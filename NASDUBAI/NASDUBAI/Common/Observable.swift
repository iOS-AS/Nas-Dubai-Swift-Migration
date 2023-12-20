//
//  Observable.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 19/12/23.
//

import Foundation
class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
