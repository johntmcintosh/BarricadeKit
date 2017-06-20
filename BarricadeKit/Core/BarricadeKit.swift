//
//  BarricadeKit.swift
//  Barricade
//
//  Created by John McIntosh on 5/10/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public enum BarricadeKit { }


extension BarricadeKit {
    
    public static func url(for file: String, in directory: String?, bundle: Bundle = .main) -> URL? {
        return bundle.url(forResource: file, withExtension: nil, subdirectory: directory)
    }
}
