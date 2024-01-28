//
//  BannerImageModel.swift
//  NAS
//
//  Created by Mobatia Mac on 15/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import Foundation

// MARK: - BannerImageModel
struct BannerImageModel: Codable {
    let responsecode: String?
    let response: ResponseDictt?
}

// MARK: - Response
struct ResponseDictt: Codable {
    let statuscode: Int?
    let response, bannerImage, description, contactEmail: String?

    enum CodingKeys: String, CodingKey {
        case statuscode, response
        case bannerImage = "banner_image"
        case description
        case contactEmail = "contact_email"
    }
}
