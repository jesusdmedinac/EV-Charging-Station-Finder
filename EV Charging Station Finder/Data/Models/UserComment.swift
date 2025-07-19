/*
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
*/

import Foundation

struct UserComment: Codable {
  let id: Int?
  let chargePointId: Int?
  let commentTypeId: Int?
  let commentType: String?
  let userName: String?
  let comment: String?
  let rating: Int?
  let relatedUrl: String?
  let dateCreated: String?
  let user: User?
  
  enum CodingKeys: String, CodingKey {
    case id = "ID"
    case chargePointId = "ChargePointID"
    case commentTypeId = "CommentTypeID"
    case commentType = "CommentType"
    case userName = "UserName"
    case comment = "Comment"
    case rating = "Rating"
    case relatedUrl = "RelatedURL"
    case dateCreated = "DateCreated"
    case user = "User"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    chargePointId = try container.decodeIfPresent(Int.self, forKey: .chargePointId)
    commentTypeId = try container.decodeIfPresent(Int.self, forKey: .commentTypeId)
    commentType = try container.decodeIfPresent(String.self, forKey: .commentType)
    userName = try container.decodeIfPresent(String.self, forKey: .userName)
    comment = try container.decodeIfPresent(String.self, forKey: .comment)
    rating = try container.decodeIfPresent(Int.self, forKey: .rating)
    relatedUrl = try container.decodeIfPresent(String.self, forKey: .relatedUrl)
    dateCreated = try container.decodeIfPresent(String.self, forKey: .dateCreated)
    user = try container.decodeIfPresent(User.self, forKey: .user)
  }
}
