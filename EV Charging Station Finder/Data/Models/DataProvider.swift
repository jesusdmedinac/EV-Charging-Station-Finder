/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct DataProvider : Codable {
	let websiteURL : String?
	let comments : String?
	let dataProviderStatusType : DataProviderStatusType?
	let isRestrictedEdit : Bool?
	let isOpenDataLicensed : Bool?
	let isApprovedImport : Bool?
	let license : String?
	let dateLastImported : String?
	let iD : Int?
	let title : String?

	enum CodingKeys: String, CodingKey {

		case websiteURL = "WebsiteURL"
		case comments = "Comments"
		case dataProviderStatusType = "DataProviderStatusType"
		case isRestrictedEdit = "IsRestrictedEdit"
		case isOpenDataLicensed = "IsOpenDataLicensed"
		case isApprovedImport = "IsApprovedImport"
		case license = "License"
		case dateLastImported = "DateLastImported"
		case iD = "ID"
		case title = "Title"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		websiteURL = try values.decodeIfPresent(String.self, forKey: .websiteURL)
		comments = try values.decodeIfPresent(String.self, forKey: .comments)
		dataProviderStatusType = try values.decodeIfPresent(DataProviderStatusType.self, forKey: .dataProviderStatusType)
		isRestrictedEdit = try values.decodeIfPresent(Bool.self, forKey: .isRestrictedEdit)
		isOpenDataLicensed = try values.decodeIfPresent(Bool.self, forKey: .isOpenDataLicensed)
		isApprovedImport = try values.decodeIfPresent(Bool.self, forKey: .isApprovedImport)
		license = try values.decodeIfPresent(String.self, forKey: .license)
		dateLastImported = try values.decodeIfPresent(String.self, forKey: .dateLastImported)
		iD = try values.decodeIfPresent(Int.self, forKey: .iD)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}

}