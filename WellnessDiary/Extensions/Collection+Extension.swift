//
//  Collection+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import Foundation

/**
 Iterates thru a Collection and returns nil if index is out of bounds.
 */

extension Collection where Indices.Iterator.Element == Index {
    
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

/**
 Iterates thru a Array and returns nil if index is out of bounds.
 */

extension Array {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
