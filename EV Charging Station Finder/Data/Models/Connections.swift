/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Connections : Codable {
	let iD : Int?
	let connectionTypeID : Int?
	let connectionType : ConnectionType?
	let reference : String?
	let statusTypeID : String?
	let statusType : String?
	let levelID : Int?
	let level : Level?
	let amps : Int?
	let voltage : Int?
	let powerKW : Double?
	let currentTypeID : Int?
	let currentType : CurrentType?
	let quantity : Int?
	let comments : String?

	enum CodingKeys: String, CodingKey {

		case iD = "ID"
		case connectionTypeID = "ConnectionTypeID"
		case connectionType = "ConnectionType"
		case reference = "Reference"
		case statusTypeID = "StatusTypeID"
		case statusType = "StatusType"
		case levelID = "LevelID"
		case level = "Level"
		case amps = "Amps"
		case voltage = "Voltage"
		case powerKW = "PowerKW"
		case currentTypeID = "CurrentTypeID"
		case currentType = "CurrentType"
		case quantity = "Quantity"
		case comments = "Comments"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		iD = try values.decodeIfPresent(Int.self, forKey: .iD)
		connectionTypeID = try values.decodeIfPresent(Int.self, forKey: .connectionTypeID)
		connectionType = try values.decodeIfPresent(ConnectionType.self, forKey: .connectionType)
		reference = try values.decodeIfPresent(String.self, forKey: .reference)
		statusTypeID = try values.decodeIfPresent(String.self, forKey: .statusTypeID)
		statusType = try values.decodeIfPresent(String.self, forKey: .statusType)
		levelID = try values.decodeIfPresent(Int.self, forKey: .levelID)
		level = try values.decodeIfPresent(Level.self, forKey: .level)
		amps = try values.decodeIfPresent(Int.self, forKey: .amps)
		voltage = try values.decodeIfPresent(Int.self, forKey: .voltage)
		powerKW = try values.decodeIfPresent(Double.self, forKey: .powerKW)
		currentTypeID = try values.decodeIfPresent(Int.self, forKey: .currentTypeID)
		currentType = try values.decodeIfPresent(CurrentType.self, forKey: .currentType)
		quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
		comments = try values.decodeIfPresent(String.self, forKey: .comments)
	}

}