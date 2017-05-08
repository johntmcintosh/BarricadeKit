//
//  BarricadeDispatch.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


class BarricadeDispatch {
    
    let responseStore: ResponseStore
    
    init(responseStore: ResponseStore) {
        self.responseStore = responseStore
    }
    
    func register(set: ResponseSet) {
        // TODO: Implement
    }
    
    func unregister(set: ResponseSet) {
        // TODO: Implement
    }
    
    func response(for request: URLRequest) -> Response? {
        // TODO: Implement
        return nil
    }
 
    func selectCurrentResponse(in set: ResponseSet, named: String) {
        // TODO: Implement
    }
    
    func resetSelections() {
        // TODO: Implement
    }
}
