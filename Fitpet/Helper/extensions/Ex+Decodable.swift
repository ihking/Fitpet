//
//  Ex+Decodable.swift
//  Fitpet
//
//  Created by kyo on 2022/08/02.
//

import Foundation

extension Decodable {
  static func decode(data: Data) throws -> Self {
    let decoder = JSONDecoder()
    return try decoder.decode(Self.self, from: data)
  }
}
