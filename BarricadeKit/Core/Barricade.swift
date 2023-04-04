//
//  Barricade.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


open class Barricade: URLProtocol {
    
    static var responseStore: ResponseStore!
    
    public static func setup(with responseStore: ResponseStore) {
        self.responseStore = responseStore
    }
    
    public static func setupWithInMemoryResponseStore() {
        setup(with: InMemoryResponseStore())
    }
    
    public static func enableForDefaultSession() {
        if responseStore == nil {
            setupWithInMemoryResponseStore()
        }

        URLProtocol.registerClass(self)
    }
    
    public static func enable(for sessionConfiguration: URLSessionConfiguration) {
        if responseStore == nil {
            setupWithInMemoryResponseStore()
        }
        
        var protocolClasses = sessionConfiguration.protocolClasses ?? []
        if !protocolClasses.contains(where: { $0 == type(of: self) }) {
            protocolClasses.insert(self, at: 0)
        }
        sessionConfiguration.protocolClasses = protocolClasses
    }
    
    public static func disableForDefaultSession() {
        URLProtocol.unregisterClass(self)
    }

    public static func disable(for sessionConfiguration: URLSessionConfiguration) {
        var protocolClasses = sessionConfiguration.protocolClasses ?? []
        if let index = protocolClasses.firstIndex(where: { $0 == type(of: self) }) {
            protocolClasses.remove(at: index)
        }
        sessionConfiguration.protocolClasses = protocolClasses
    }
    
    
    // MARK: Response Configuration
    
    public static var allRequestsBarricaded: Bool = true
    
    public static var responseDelay: TimeInterval = 0.1
    
    public static func register(set: ResponseSet) {
        responseStore.register(set: set)
    }
    
    public static func unregister(set: ResponseSet) {
        responseStore.unregister(set: set)
    }

    /**
     Tells Barricade to set a response object to be returned the next time the request is sent.
     - Parameters:
       - request: The operation name for the request
       - name: The display name of the response
     - Returns: Whether or not there was a response object found in the response store for the provided request operation name
    */
    @discardableResult public static func selectResponse(for request: String, with name: String) -> Bool {
        guard let set = responseStore.responseSet(for: request) else { return false }
        return responseStore.selectCurrentResponse(in: set, named: name)
    }
    
    public static func resetSelections() {
        responseStore.resetSelections()
    }
    
    public static func unregisterAll() {
        for set in responseStore.responseSets {
            responseStore.unregister(set: set)
        }
    }
    
    
    // MARK: URLProtocol
    
    private var canceled = false
    
    open override class func canInit(with request: URLRequest) -> Bool {
        if allRequestsBarricaded {
            return true
        }

        return responseStore.canRespond(to: request)
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    open override func startLoading() {
        guard let set = Barricade.responseStore.responseSet(for: request),
            let response = Barricade.responseStore.currentResponse(for: set) else {
                respondWithResponseNotRegistered(after: Barricade.responseDelay)
                return
        }
        
        let modifiedResponse = response.modified(for: request)
        switch modifiedResponse {
        case .network(let networkResponse):
            respond(with: networkResponse, after: Barricade.responseDelay)
        case .error(let errorResponse):
            respond(with: errorResponse, after: Barricade.responseDelay)
        }
    }
    
    open override func stopLoading() {
        canceled = true
    }
    
    
    // MARK: Private
    
    private func respondWithResponseNotRegistered(after delay: TimeInterval) {
        respond(with: BarricadeError.noResponseRegistered(request), after: Barricade.responseDelay)
    }
    
    private func respond(with errorResponse: ErrorResponse, after delay: TimeInterval) {
        if let error = errorResponse.error {
            respond(with: error, after: delay)
        } else {
            respond(with: BarricadeError.errorResponseMissingError, after: delay)
        }
    }

    private func respond(with error: Error, after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard !self.canceled else { return }
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    private func respond(with networkResponse: NetworkResponse, after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard !self.canceled else { return }
            
            guard let urlResponse = networkResponse.urlResponse(for: self.request) else {
                self.respond(with: BarricadeError.unableToGenerateUrlResponse, after: 0.0)
                return
            }
            
            self.client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .allowedInMemoryOnly)
            
            // NOTE: This currently returns all data in a single shot. A possible future enhancement here
            // would be to update this to support streaming the response data over several calls. This would
            // also allow support for simulating different network speeds more accurately than the current
            // generic `responseDelay` does.
            let data = networkResponse.content ?? Data()
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
}
