/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct POIResponse : Codable {
  let dataProvider: DataProvider?
  let operatorInfo: OperatorInfo?
  let usageType: UsageType?
  let statusType: StatusType?
  let submissionStatus: SubmissionStatus?
  let userComments: [UserComment]?
  let percentageSimilarity: Double?
  let mediaItems: [MediaItem]?
  let isRecentlyVerified: Bool?
  let dateLastVerified: String?
  let id: Int?
  let uuid: String?
  let parentChargePointID: Int?
  let dataProviderID: Int?
  let dataProvidersReference: String?
  let operatorID: Int?
  let operatorsReference: String?
  let usageTypeID: Int?
  let usageCost: String?
  let addressInfo: AddressInfo?
  let connections: [Connection]?
  let numberOfPoints: Int?
  let generalComments: String?
  let datePlanned: String?
  let dateLastConfirmed: String?
  let statusTypeID: Int?
  let dateLastStatusUpdate: String?
  let metadataValues: [String]?
  let dataQualityLevel: Int?
  let dateCreated: String?
  let submissionStatusTypeID: Int?
  let isRestrictedEdit: Bool?
  let isOpenDataLicensed: Bool?
  let isOpenDataProvider: Bool?
  let isOpenDataAggregator: Bool?
  let isApprovedImport: Bool?
  let license: String?
  let dateLastImported: String?
  let dataProviderStatusType: DataProviderStatusType?
  let verificationStatusType: VerificationStatusType?
  let dateLastUpdated: String?

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
    case id = "ID"
    case uuid = "UUID"
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
    case isRestrictedEdit = "IsRestrictedEdit"
    case isOpenDataLicensed = "IsOpenDataLicensed"
    case isOpenDataProvider = "IsOpenDataProvider"
    case isOpenDataAggregator = "IsOpenDataAggregator"
    case isApprovedImport = "IsApprovedImport"
    case license = "License"
    case dateLastImported = "DateLastImported"
    case dataProviderStatusType = "DataProviderStatusType"
    case verificationStatusType = "VerificationStatusType"
    case dateLastUpdated = "DateLastUpdated"
  }

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
    parentChargePointID = try container.decodeIfPresent(Int.self, forKey: .parentChargePointID)
    dataProviderID = try container.decodeIfPresent(Int.self, forKey: .dataProviderID)
    dataProvidersReference = try container.decodeIfPresent(String.self, forKey: .dataProvidersReference)
    operatorID = try container.decodeIfPresent(Int.self, forKey: .operatorID)
    operatorsReference = try container.decodeIfPresent(String.self, forKey: .operatorsReference)
    usageTypeID = try container.decodeIfPresent(Int.self, forKey: .usageTypeID)
    usageCost = try container.decodeIfPresent(String.self, forKey: .usageCost)
    userComments = try container.decodeIfPresent([UserComment].self, forKey: .userComments)
    percentageSimilarity = try container.decodeIfPresent(Double.self, forKey: .percentageSimilarity)
    mediaItems = try container.decodeIfPresent([MediaItem].self, forKey: .mediaItems)
    isRecentlyVerified = try container.decodeIfPresent(Bool.self, forKey: .isRecentlyVerified)
    dateLastVerified = try container.decodeIfPresent(String.self, forKey: .dateLastVerified)
    numberOfPoints = try container.decodeIfPresent(Int.self, forKey: .numberOfPoints)
    generalComments = try container.decodeIfPresent(String.self, forKey: .generalComments)
    datePlanned = try container.decodeIfPresent(String.self, forKey: .datePlanned)
    dateLastConfirmed = try container.decodeIfPresent(String.self, forKey: .dateLastConfirmed)
    statusTypeID = try container.decodeIfPresent(Int.self, forKey: .statusTypeID)
    dateLastStatusUpdate = try container.decodeIfPresent(String.self, forKey: .dateLastStatusUpdate)
    metadataValues = try container.decodeIfPresent([String].self, forKey: .metadataValues)
    dataQualityLevel = try container.decodeIfPresent(Int.self, forKey: .dataQualityLevel)
    dateCreated = try container.decodeIfPresent(String.self, forKey: .dateCreated)
    submissionStatusTypeID = try container.decodeIfPresent(Int.self, forKey: .submissionStatusTypeID)
    dataProvider = try container.decodeIfPresent(DataProvider.self, forKey: .dataProvider)
    operatorInfo = try container.decodeIfPresent(OperatorInfo.self, forKey: .operatorInfo)
    usageType = try container.decodeIfPresent(UsageType.self, forKey: .usageType)
    statusType = try container.decodeIfPresent(StatusType.self, forKey: .statusType)
    submissionStatus = try container.decodeIfPresent(SubmissionStatus.self, forKey: .submissionStatus)
    addressInfo = try container.decodeIfPresent(AddressInfo.self, forKey: .addressInfo)
    connections = try container.decodeIfPresent([Connection].self, forKey: .connections)
    isRestrictedEdit = try container.decodeIfPresent(Bool.self, forKey: .isRestrictedEdit)
    isOpenDataLicensed = try container.decodeIfPresent(Bool.self, forKey: .isOpenDataLicensed)
    isOpenDataProvider = try container.decodeIfPresent(Bool.self, forKey: .isOpenDataProvider)
    isOpenDataAggregator = try container.decodeIfPresent(Bool.self, forKey: .isOpenDataAggregator)
    isApprovedImport = try container.decodeIfPresent(Bool.self, forKey: .isApprovedImport)
    license = try container.decodeIfPresent(String.self, forKey: .license)
    dateLastImported = try container.decodeIfPresent(String.self, forKey: .dateLastImported)
    dataProviderStatusType = try container.decodeIfPresent(DataProviderStatusType.self, forKey: .dataProviderStatusType)
    verificationStatusType = try container.decodeIfPresent(VerificationStatusType.self, forKey: .verificationStatusType)
    dateLastUpdated = try container.decodeIfPresent(String.self, forKey: .dateLastUpdated)
  }
}
