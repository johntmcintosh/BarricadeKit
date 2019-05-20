//
//  ResponseStore.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public protocol ResponseStore {
    
    var responseSets: [ResponseSet] { get }
    
    func currentResponse(for set: ResponseSet) -> Response?
    
    func register(set: ResponseSet)
    
    func resetSelections()
    
    func responseSet(for request: URLRequest) -> ResponseSet?
    
    func responseSet(for requestNamed: String) -> ResponseSet?
    
    func selectCurrentResponse(in set: ResponseSet, named: String)
    
    func unregister(set: ResponseSet)
    
    func canRespond(to request: URLRequest) -> Bool
}


public class InMemoryResponseStore: ResponseStore {
    
    public private(set) var responseSets: [ResponseSet] = []
    private var currentResponseForSet: [String: Response] = [:]
    
    
    // MARK: Registration
    
    public func register(set: ResponseSet) {
        responseSets.append(set)
    }
    
    public func responseSet(for request: URLRequest) -> ResponseSet? {
        for set in responseSets {
            guard let components = request.url?.components else { continue }
            if set.responds(to: request, components: components) {
                return set
            }
        }
        return nil
    }
    
    public func responseSet(for requestNamed: String) -> ResponseSet? {
        for set in responseSets {
            if set.requestName == requestNamed {
                return set
            }
        }
        return nil
    }
    
    public func unregister(set: ResponseSet) {
        guard let index = responseSets.firstIndex(where: { $0.requestName == set.requestName }) else { return }
        responseSets.remove(at: index)
    }

    public func canRespond(to request: URLRequest) -> Bool {
        guard let set = responseSet(for: request) else { return false }
        return currentResponse(for: set) != nil
    }

    
    // MARK: Selection Management
    
    public func currentResponse(for set: ResponseSet) -> Response? {
        guard let current = currentResponseForSet[set.requestName] else {
            return set.defaultResponse
        }
        return current
    }
    
    public func selectCurrentResponse(in set: ResponseSet, named: String) {
        guard let response = set.response(named: named) else { return }
        currentResponseForSet[set.requestName] = response
    }
    
    public func resetSelections() {
        currentResponseForSet.removeAll()
    }
}


private extension URL {
    
    var components: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}
