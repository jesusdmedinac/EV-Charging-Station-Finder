/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct POIResponse : Codable {
	let dataProvider : DataProvider?
	let operatorInfo : OperatorInfo?
	let usageType : UsageType?
	let statusType : StatusType?
	let submissionStatus : SubmissionStatus?
	let userComments : String?
	let percentageSimilarity : String?
	let mediaItems : String?
	let isRecentlyVerified : Bool?
	let dateLastVerified : String?
	let iD : Int?
	let uUID : String?
	let parentChargePointID : String?
	let dataProviderID : Int?
	let dataProvidersReference : String?
	let operatorID : Int?
	let operatorsReference : String?
	let usageTypeID : Int?
	let usageCost : String?
	let addressInfo : AddressInfo?
	let connections : [Connections]?
	let numberOfPoints : String?
	let generalComments : String?
	let datePlanned : String?
	let dateLastConfirmed : String?
	let statusTypeID : Int?
	let dateLastStatusUpdate : String?
	let metadataValues : String?
	let dataQualityLevel : Int?
	let dateCreated : String?
	let submissionStatusTypeID : Int?

	enum CodingKeys: String, CodingKey {

		case dataProvider = "DataProvider"
		case operatorInfo = "OperatorInfo"
		case usageType = "UsageType"
		case statusType = "StatusType"
		case submissionStatus = "SubmissionStatus"
		case userComments = "UserComments"
		case percentageSimilarity = "PercentageSimilarity"
		case mediaItems = "MediaItems"
		case isRecentlyVerified = "IsRecentlyVerified"
		case dateLastVerified = "DateLastVerified"
		case iD = "ID"
		case uUID = "UUID"
		case parentChargePointID = "ParentChargePointID"
		case dataProviderID = "DataProviderID"
		case dataProvidersReference = "DataProvidersReference"
		case operatorID = "OperatorID"
		case operatorsReference = "OperatorsReference"
		case usageTypeID = "UsageTypeID"
		case usageCost = "UsageCost"
		case addressInfo = "AddressInfo"
		case connections = "Connections"
		case numberOfPoints = "NumberOfPoints"
		case generalComments = "GeneralComments"
		case datePlanned = "DatePlanned"
		case dateLastConfirmed = "DateLastConfirmed"
		case statusTypeID = "StatusTypeID"
		case dateLastStatusUpdate = "DateLastStatusUpdate"
		case metadataValues = "MetadataValues"
		case dataQualityLevel = "DataQualityLevel"
		case dateCreated = "DateCreated"
		case submissionStatusTypeID = "SubmissionStatusTypeID"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dataProvider = try values.decodeIfPresent(DataProvider.self, forKey: .dataProvider)
		operatorInfo = try values.decodeIfPresent(OperatorInfo.self, forKey: .operatorInfo)
		usageType = try values.decodeIfPresent(UsageType.self, forKey: .usageType)
		statusType = try values.decodeIfPresent(StatusType.self, forKey: .statusType)
		submissionStatus = try values.decodeIfPresent(SubmissionStatus.self, forKey: .submissionStatus)
		userComments = try values.decodeIfPresent(String.self, forKey: .userComments)
		percentageSimilarity = try values.decodeIfPresent(String.self, forKey: .percentageSimilarity)
		mediaItems = try values.decodeIfPresent(String.self, forKey: .mediaItems)
		isRecentlyVerified = try values.decodeIfPresent(Bool.self, forKey: .isRecentlyVerified)
		dateLastVerified = try values.decodeIfPresent(String.self, forKey: .dateLastVerified)
		iD = try values.decodeIfPresent(Int.self, forKey: .iD)
		uUID = try values.decodeIfPresent(String.self, forKey: .uUID)
		parentChargePointID = try values.decodeIfPresent(String.self, forKey: .parentChargePointID)
		dataProviderID = try values.decodeIfPresent(Int.self, forKey: .dataProviderID)
		dataProvidersReference = try values.decodeIfPresent(String.self, forKey: .dataProvidersReference)
		operatorID = try values.decodeIfPresent(Int.self, forKey: .operatorID)
		operatorsReference = try values.decodeIfPresent(String.self, forKey: .operatorsReference)
		usageTypeID = try values.decodeIfPresent(Int.self, forKey: .usageTypeID)
		usageCost = try values.decodeIfPresent(String.self, forKey: .usageCost)
		addressInfo = try values.decodeIfPresent(AddressInfo.self, forKey: .addressInfo)
		connections = try values.decodeIfPresent([Connections].self, forKey: .connections)
		numberOfPoints = try values.decodeIfPresent(String.self, forKey: .numberOfPoints)
		generalComments = try values.decodeIfPresent(String.self, forKey: .generalComments)
		datePlanned = try values.decodeIfPresent(String.self, forKey: .datePlanned)
		dateLastConfirmed = try values.decodeIfPresent(String.self, forKey: .dateLastConfirmed)
		statusTypeID = try values.decodeIfPresent(Int.self, forKey: .statusTypeID)
		dateLastStatusUpdate = try values.decodeIfPresent(String.self, forKey: .dateLastStatusUpdate)
		metadataValues = try values.decodeIfPresent(String.self, forKey: .metadataValues)
		dataQualityLevel = try values.decodeIfPresent(Int.self, forKey: .dataQualityLevel)
		dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
		submissionStatusTypeID = try values.decodeIfPresent(Int.self, forKey: .submissionStatusTypeID)
	}

	init() {
		self.dataProvider = nil
		self.operatorInfo = nil
		self.usageType = nil
		self.statusType = nil
		self.submissionStatus = nil
		self.userComments = nil
		self.percentageSimilarity = nil
		self.mediaItems = nil
		self.isRecentlyVerified = nil
		self.dateLastVerified = nil
		self.iD = nil
		self.uUID = nil
		self.parentChargePointID = nil
		self.dataProviderID = nil
		self.dataProvidersReference = nil
		self.operatorID = nil
		self.operatorsReference = nil
		self.usageTypeID = nil
		self.usageCost = nil
		self.addressInfo = nil
		self.connections = nil
		self.numberOfPoints = nil
		self.generalComments = nil
		self.datePlanned = nil
		self.dateLastConfirmed = nil
		self.statusTypeID = nil
		self.dateLastStatusUpdate = nil
		self.metadataValues = nil
		self.dataQualityLevel = nil
		self.dateCreated = nil
		self.submissionStatusTypeID = nil
	}
}
