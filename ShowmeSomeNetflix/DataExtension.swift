//
//  DataExtension.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/2/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

extension Data {
    func elements <T> () -> [T] {
        return withUnsafeBytes {
            Array(UnsafeBufferPointer<T>(start: $0, count: count/MemoryLayout<T>.size))
        }
    }
}
