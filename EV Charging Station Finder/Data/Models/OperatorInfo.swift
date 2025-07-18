/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct OperatorInfo : Codable {
	let websiteURL : String?
	let comments : String?
	let phonePrimaryContact : String?
	let phoneSecondaryContact : String?
	let isPrivateIndividual : Bool?
	let addressInfo : String?
	let bookingURL : String?
	let contactEmail : String?
	let faultReportEmail : String?
	let isRestrictedEdit : Bool?
	let iD : Int?
	let title : String?

	enum CodingKeys: String, CodingKey {
		case websiteURL = "WebsiteURL"
		case comments = "Comments"
		case phonePrimaryContact = "PhonePrimaryContact"
		case phoneSecondaryContact = "PhoneSecondaryContact"
		case isPrivateIndividual = "IsPrivateIndividual"
		case addressInfo = "AddressInfo"
		case bookingURL = "BookingURL"
		case contactEmail = "ContactEmail"
		case faultReportEmail = "FaultReportEmail"
		case isRestrictedEdit = "IsRestrictedEdit"
		case iD = "ID"
		case title = "Title"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		websiteURL = try container.decodeIfPresent(String.self, forKey: .websiteURL)
		comments = try container.decodeIfPresent(String.self, forKey: .comments)
		phonePrimaryContact = try container.decodeIfPresent(String.self, forKey: .phonePrimaryContact)
		phoneSecondaryContact = try container.decodeIfPresent(String.self, forKey: .phoneSecondaryContact)
		isPrivateIndividual = try container.decodeIfPresent(Bool.self, forKey: .isPrivateIndividual)
		addressInfo = try container.decodeIfPresent(String.self, forKey: .addressInfo)
		bookingURL = try container.decodeIfPresent(String.self, forKey: .bookingURL)
		contactEmail = try container.decodeIfPresent(String.self, forKey: .contactEmail)
		faultReportEmail = try container.decodeIfPresent(String.self, forKey: .faultReportEmail)
		isRestrictedEdit = try container.decodeIfPresent(Bool.self, forKey: .isRestrictedEdit)
		iD = try container.decodeIfPresent(Int.self, forKey: .iD)
		title = try container.decodeIfPresent(String.self, forKey: .title)
	}
}