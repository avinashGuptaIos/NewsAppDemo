//
//  Box.swift
//  NewsAppDemo
//
//  Created by hasher on 12/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
