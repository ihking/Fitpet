//
//  Ex+Array.swift
//  Fitpet
//
//  Created by kyo on 2022/08/02.
//

import Foundation
import UIKit

extension Array {
  func unique<T: Equatable>(value: (Element)->T) -> [Element] {
    var result: [Element] = []
    for element in self
    {
      if !result.contains(where: { value($0) == value(element) }) {
        result.append(element)
      }
    }
    return result
  }
}
