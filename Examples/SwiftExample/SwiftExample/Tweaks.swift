//
//  Tweaks.swift
//  SwiftExample
//
//  Created by John McIntosh on 6/14/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation
import Tweaks


public typealias TweakActionBlock = @convention(block) () -> Void


@discardableResult
public func tweakAction(categoryName: String, collectionName: String, tweakName: String, action: @escaping TweakActionBlock) -> FBTweak {
    let store = FBTweakStore.sharedInstance()!
    let category = store.makeCategory(name: categoryName)
    let collection = category.makeCollection(name: collectionName)
    let tweak = collection.makeTweak(categoryName: categoryName, tweakName: tweakName)
    
    tweak.defaultValue = unsafeBitCast(action, to: AnyObject.self)
    
    return tweak
}


extension FBTweakStore {
    
    public func makeCategory(name: String) -> FBTweakCategory {
        guard let category = tweakCategory(withName: name) else {
            let category = FBTweakCategory(name: name)!
            addTweakCategory(category)
            return category
        }
        return category
    }
}


extension FBTweakCategory {
    
    public func makeCollection(name: String) -> FBTweakCollection {
        guard let collection = tweakCollection(withName: name) else {
            let collection = FBTweakCollection(name: name)!
            addTweakCollection(collection)
            return collection
        }
        return collection
    }
}


extension FBTweakCollection {
    
    public func makeTweak(categoryName: String, tweakName: String) -> FBTweak {
        let identifier = FBTweak.makeIdentifier(categoryName: categoryName, collectionName: self.name, tweakName: tweakName)
        guard let tweak = tweak(withIdentifier: identifier) else {
            let tweak = FBTweak(identifier: identifier)!
            tweak.name = tweakName
            addTweak(tweak)
            return tweak
        }
        return tweak
    }
}


extension FBTweak {
    
    public static func makeIdentifier(categoryName: String, collectionName: String, tweakName: String) -> String {
        return "FBTweak:\(categoryName)-\(collectionName)-\(tweakName)"
    }
}
