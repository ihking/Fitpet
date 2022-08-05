//
//  ReUsable.swift
//  Fitpet
//
//  Created by kyo on 2022/08/02.
//

import UIKit

protocol ReUsable {
    static var id: String { get }
}
extension ReUsable where Self: UIView {
    static var id: String {
        return String(describing: self)
    }
}
