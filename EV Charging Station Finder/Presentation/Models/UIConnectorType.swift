//
//  UIConnectorType.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 19/07/25.
//

import Foundation

struct UIConnectorType : Identifiable, Equatable {
  var id: String { name }
  
  let name: String
  
  init(name: String) {
    self.name = name
  }
}
