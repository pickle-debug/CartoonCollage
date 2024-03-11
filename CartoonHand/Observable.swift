//
//  CoinsObversable.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/11.
//

import Foundation
class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T?) -> Void)?

    init(_ value: T? = nil) {
        self.value = value
    }

    func bind(_ listener: @escaping (T?) -> Void) {
        self.listener = listener
        listener(value)
    }
}
