//
//  BaseTVCell.swift
//  Fitpet
//
//  Created by kyo on 2022/08/01.
//

import UIKit

class BaseTVCell<T>: UITableViewCell {

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    backgroundColor = .clear
    selectionStyle = .none

    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() { }
  
  var item: T? {
    didSet {
      if let item = item {
        bind(item)
      }
    }
  }
  
  func bind(_ item: T) {}
}

