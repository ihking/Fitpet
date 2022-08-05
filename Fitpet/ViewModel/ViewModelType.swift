//
//  ViewModelType.swift
//  Fitpet
//
//  Created by kyo on 2022/07/29.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
