//
//  Errors.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


enum BarricadeError: Error {
    case noResponseRegistered
    case invalidJson
    case nilFilePath
    case errorReadingFile
    case offline
}
