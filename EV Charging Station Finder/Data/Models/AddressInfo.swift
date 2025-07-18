/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct AddressInfo : Codable {
	let iD : Int?
	let title : String?
	let addressLine1 : String?
	let addressLine2 : String?
	let town : String?
	let stateOrProvince : String?
	let postcode : String?
	let countryID : Int?
	let country : Country?
	let latitude : Double?
	let longitude : Double?
	let contactTelephone1 : String?
	let contactTelephone2 : String?
	let contactEmail : String?
	let accessComments : String?
	let relatedURL : String?
	let distance : Double?
	let distanceUnit : Int?

	enum CodingKeys: String, CodingKey {

		case iD = "ID"
		case title = "Title"
		case addressLine1 = "AddressLine1"
		case addressLine2 = "AddressLine2"
		case town = "Town"
		case stateOrProvince = "StateOrProvince"
		case postcode = "Postcode"
		case countryID = "CountryID"
		case country = "Country"
		case latitude = "Latitude"
		case longitude = "Longitude"
		case contactTelephone1 = "ContactTelephone1"
		case contactTelephone2 = "ContactTelephone2"
		case contactEmail = "ContactEmail"
		case accessComments = "AccessComments"
		case relatedURL = "RelatedURL"
		case distance = "Distance"
		case distanceUnit = "DistanceUnit"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		iD = try container.decodeIfPresent(Int.self, forKey: .iD)
		title = try container.decodeIfPresent(String.self, forKey: .title)
		addressLine1 = try container.decodeIfPresent(String.self, forKey: .addressLine1)
		addressLine2 = try container.decodeIfPresent(String.self, forKey: .addressLine2)
		town = try container.decodeIfPresent(String.self, forKey: .town)
		stateOrProvince = try container.decodeIfPresent(String.self, forKey: .stateOrProvince)
		postcode = try container.decodeIfPresent(String.self, forKey: .postcode)
		countryID = try container.decodeIfPresent(Int.self, forKey: .countryID)
		country = try container.decodeIfPresent(Country.self, forKey: .country)
		latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
		contactTelephone1 = try container.decodeIfPresent(String.self, forKey: .contactTelephone1)
		contactTelephone2 = try container.decodeIfPresent(String.self, forKey: .contactTelephone2)
		contactEmail = try container.decodeIfPresent(String.self, forKey: .contactEmail)
		accessComments = try container.decodeIfPresent(String.self, forKey: .accessComments)
		relatedURL = try container.decodeIfPresent(String.self, forKey: .relatedURL)
		distance = try container.decodeIfPresent(Double.self, forKey: .distance)
		distanceUnit = try container.decodeIfPresent(Int.self, forKey: .distanceUnit)
	}

}