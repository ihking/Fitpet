//
//  Ex+UITableView.swift
//  Fitpet
//
//  Created by kyo on 2022/08/02.
//

import UIKit

import RxSwift

extension UITableView {
  func registerCell<T: UITableViewCell>(_ : T.Type) where T: ReUsable {
    register(T.self, forCellReuseIdentifier: T.id)
  }
  
  func dequeueCell<T: UITableViewCell>() -> T where T: ReUsable {
    return dequeueReusableCell(withIdentifier: T.id) as! T
  }
  
  func dequeueCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T where T: ReUsable {
    return dequeueReusableCell(withIdentifier: T.id, for: indexPath) as! T
  }
}
