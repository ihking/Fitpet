//
//  Ex+String.swift
//  Fitpet
//
//  Created by kyo on 2022/08/02.
//

import Foundation

extension String {
  var encUrl: URL? {
    URL(string: self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
  }

  var dateType: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: self)
  }
}
