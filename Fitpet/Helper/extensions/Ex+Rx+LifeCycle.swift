//
//  Extensions.swift
//  Fitpet
//
//  Created by kyo on 2022/08/01.
//

import RxSwift
import RxCocoa
import UIKit

extension RxSwift.Reactive where Base: UIViewController {
  public var viewDidLoad: Observable<()> {
    return methodInvoked(#selector(UIViewController.viewDidLoad))
      .map { _ in return }
  }
  public var viewDidAppear: Observable<()> {
    return methodInvoked(#selector(UIViewController.viewDidAppear))
      .map { _ in return }
  }
}
