/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Country : Codable {
	let iSOCode : String?
	let continentCode : String?
	let id : Int?
	let title : String?

	enum CodingKeys: String, CodingKey {
		case iSOCode = "ISOCode"
		case continentCode = "ContinentCode"
		case id = "ID"
		case title = "Title"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		iSOCode = try container.decodeIfPresent(String.self, forKey: .iSOCode)
		continentCode = try container.decodeIfPresent(String.self, forKey: .continentCode)
		id = try container.decodeIfPresent(Int.self, forKey: .id)
		title = try container.decodeIfPresent(String.self, forKey: .title)
	}
    
  init(
    iSOCode: String? = nil,
    continentCode: String? = nil,
    id: Int? = nil,
    title: String? = nil
  ) {
    self.iSOCode = iSOCode
    self.continentCode = continentCode
    self.id = id
    self.title = title
  }
}
