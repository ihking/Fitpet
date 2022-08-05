//
//  Ex+Date.swift
//  Fitpet
//
//  Created by kyo on 2022/08/02.
//


import Foundation
import UIKit

extension Date {
  public var day: Int {
    return Calendar.current.component(.day, from: self)
  }

  func formatterToDate(_ format: String) -> String {
    let nameFormatter = DateFormatter()
    nameFormatter.dateFormat = format
    let string = nameFormatter.string(from: self)
    return string
  }

  var weatherDate: String {
    let val = (day-Date().day)
    return (val < 2 && val >= 0) ? (val == 0 ? "Today": "Tomorrow"): "\(formatterToDate("E")) \(self.day) \(formatterToDate("MMMM"))"
  }

}
