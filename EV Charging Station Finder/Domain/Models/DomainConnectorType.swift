//
//  DomainConnectorType.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

struct DomainConnectorType : Equatable {
  let id: String
  let name: String

  init(
    id: String = "",
    name: String = ""
  ) {
    self.id = id
    self.name = name
  }
}
