//
//  APIResponseModels.swift
//  NetworkPaymentTest
//
//  Created by sigosoft on 14/09/20.
//  Copyright © 2020 Stebin. All rights reserved.
//
import UIKit
import NISdk
import PassKit

struct AccessTokenModel: Codable {
    let responsecode: String?
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let response, statuscode, accessToken: String?

    enum CodingKeys: String, CodingKey {
        case response, statuscode
        case accessToken = "access_token"
    }
}



//// MARK: - Welcome
//struct CreateOrderModel: Codable {
//    let responsecode: String?
//    let response: CreateOrderResponse?
//}
//
//// MARK: - Response
//struct CreateOrderResponse: Codable {
//    let response, statuscode, orderReference: String?
//    let orderPaypageURL, authorization: String?
//
//    enum CodingKeys: String, CodingKey {
//        case response, statuscode
//        case orderReference = "order_reference"
//        case orderPaypageURL = "order_paypage_url"
//        case authorization
//    }
//}

struct CreateOrderModel: Codable {
    let responsecode: String?
    let response: CreateOrderResponse?
}

// MARK: - Response
struct CreateOrderResponse: Codable {
    let response, statuscode, order_id, merchantOrderReference, order_reference, order_paypage_url, authorization: String?
    let data: OrderResponse?

//    let response, statuscode, orderReference: String?
//
//    let orderPaypageURL, authorization, order_id: String?

    enum CodingKeys: String, CodingKey {
        
        case response
        case statuscode
        case order_id
        case merchantOrderReference
        case order_reference
        case order_paypage_url
        case authorization
        case data
        
//        case response, statuscode
//        case order_id = "order_id"
//        case orderReference = "order_reference"
//        case orderPaypageURL = "order_paypage_url"
//        case authorization, data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    
    let id: String?
    let links: DataLinks?
    let type: String?
    let merchantDefinedData: FormattedOrderSummary?
    let action: String?
    let amount: Amount?
    let language: String?
    let merchantAttributes: MerchantAttributes?
    let reference, outletID, createDateTime: String?
    let paymentMethods: PaymentMethods?
    let referrer, formattedAmount: String?
    let formattedOrderSummary: FormattedOrderSummary?
    let embedded: Embedded?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case links = "_links"
        case type, merchantDefinedData, action, amount, language, merchantAttributes, reference
        case outletID = "outletId"
        case createDateTime, paymentMethods, referrer, formattedAmount, formattedOrderSummary
        case embedded = "_embedded"
    }
}

// MARK: - Amount
struct Amount: Codable {
    let currencyCode: String?
    let value: Int?
}

// MARK: - Embedded
struct Embedded: Codable {
    let payment: [Payment]?
}

// MARK: - Payment
struct Payment: Codable {
    let id: String?
    let links: PaymentLinks?
    let state: String?
    let amount: Amount?
    let updateDateTime, outletID, orderReference: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case links = "_links"
        case state, amount, updateDateTime
        case outletID = "outletId"
        case orderReference
    }
}

// MARK: - PaymentLinks
struct PaymentLinks: Codable {
    let paymentChinaUnionPay, linksSelf, cnpChinaUnionPayResults, paymentCard: CnpPaymentLink?
    let curies: [Cury]?

    enum CodingKeys: String, CodingKey {
        case paymentChinaUnionPay = "payment:china_union_pay"
        case linksSelf = "self"
        case cnpChinaUnionPayResults = "cnp:china_union_pay_results"
        case paymentCard = "payment:card"
        case curies
    }
}

// MARK: - CnpPaymentLink
struct CnpPaymentLink: Codable {
    let href: String?
}

// MARK: - Cury
struct Cury: Codable {
    let name, href: String?
    let templated: Bool?
}

// MARK: - FormattedOrderSummary
struct FormattedOrderSummary: Codable {
}

// MARK: - DataLinks
struct DataLinks: Codable {
    let cnpPaymentLink, paymentAuthorization, linksSelf, tenantBrand: CnpPaymentLink?
    let payment, merchantBrand: CnpPaymentLink?

    enum CodingKeys: String, CodingKey {
        case cnpPaymentLink = "cnp:payment-link"
        case paymentAuthorization = "payment-authorization"
        case linksSelf = "self"
        case tenantBrand = "tenant-brand"
        case payment
        case merchantBrand = "merchant-brand"
    }
}

// MARK: - MerchantAttributes
struct MerchantAttributes: Codable {
    let redirectURL: String?

    enum CodingKeys: String, CodingKey {
        case redirectURL = "redirectUrl"
    }
}

// MARK: - PaymentMethods
struct PaymentMethods: Codable {
    let apm, card: [String]?
}
