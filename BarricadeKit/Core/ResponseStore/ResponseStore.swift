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
    
    func currentResponse(for set: ResponseSet) -> Response
    
    func register(set: ResponseSet)
    
    func resetSelections()
    
    func responseSet(for request: URLRequest) -> ResponseSet?
    
    func responseSet(for requestNamed: String) -> ResponseSet?
    
    func selectCurrentResponse(in set: ResponseSet, named: String)
    
    func unregister(set: ResponseSet)
}
