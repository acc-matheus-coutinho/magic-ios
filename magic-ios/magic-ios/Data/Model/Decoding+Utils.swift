//
//  Decoding+Utils.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 08/08/22.
//


// WIP on Decoding Array<Any>


//import Foundation
//
//extension KeyedDecodingContainer {
//
//    func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
//        var container = try nestedUnkeyedContainer(forKey: key)
//        return try container.decode(type)
//    }
//
//}
//
//extension UnkeyedDecodingContainer {
//    mutating func decode(_ type: [Any].Type) throws -> [Any] {
//        var array: [Any] = []
//
//        while isAtEnd == false {
//            if let value = try? decode(Bool.self) {
//                array.append(value)
//            } else if let value = try? decode(Int.self) {
//                array.append(value)
//            } else if let value = try? decode(String.self) {
//                array.append(value)
//            } else if let value = try? decode(Double.self) {
//                array.append(value)
//            } else if let nestedArray = try? decodeNestedArray([Any].self) {
//                array.append(nestedArray)
//            } else if let isValueNil = try? decodeNil(), isValueNil == true {
//                array.append(Optional<Any>.none as Any)
//            } else {
//                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath, debugDescription: "Unable to decode value"))
//            }
//        }
//        return array
//    }
//
//    mutating func decodeNestedArray(_ type: [Any].Type) throws -> [Any] {
//        var container = try nestedUnkeyedContainer()
//        return try container.decode(type)
//    }
//}
