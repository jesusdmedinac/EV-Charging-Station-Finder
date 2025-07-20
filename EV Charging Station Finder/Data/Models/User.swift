//
//  User.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 19/07/25.
//

import Foundation

struct User: Codable {
  let id: Int?
  let username: String?
  let profileImageUrl: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "ID"
    case username = "Username"
    case profileImageUrl = "ProfileImageURL"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    profileImageUrl = try container.decodeIfPresent(String.self, forKey: .profileImageUrl)
  }
  
  init(
    id: Int? = nil,
    username: String? = nil,
    profileImageUrl: String? = nil
  ) {
    self.id = id
    self.username = username
    self.profileImageUrl = profileImageUrl
  }
}
