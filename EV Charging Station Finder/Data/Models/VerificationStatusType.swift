//
//  VerificationStatusType.swift
//  EV Charging Station Finder
//
//  Created by Jesús Daniel Medina on 18/07/2025.
//  Copyright © 2025. All rights reserved.
//

import Foundation

struct VerificationStatusType: Codable {
  let id: Int?
  let title: String?
  let isVerified: Bool?
  
  enum CodingKeys: String, CodingKey {
    case id = "ID"
    case title = "Title"
    case isVerified = "IsVerified"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    isVerified = try container.decodeIfPresent(Bool.self, forKey: .isVerified)
  }
  
  init() {
    self.id = nil
    self.title = nil
    self.isVerified = nil
  }
}
