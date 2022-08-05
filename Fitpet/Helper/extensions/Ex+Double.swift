//
//  Ex+Double.swift
//  Fitpet
//
//  Created by kyo on 2022/08/04.
//

import Foundation

extension Double {
  var celsius: Int {
    return Int(self-Const.Kelvin)
  }
}
