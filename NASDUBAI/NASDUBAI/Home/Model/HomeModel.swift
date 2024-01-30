//
//  HomeModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 30/01/24.
//
class HomeModel {
    
    var updateApp: (()->())?

    func getBanners(completion: @escaping (Banner) -> ()) {
        ApiServices().getHomeBanners() { completed in
            self.checkUpdate(version: completed.responseArray?.iosAppVersion)
            if completed.responseArray?.enrollment_status == 1 {
                print("present")
            }
            else {
                print("No")
            }
            completion(completed)
        }
    }
    
    
    
    
    
    

    private func checkUpdate(version: String?) {
//        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//        if let version: Double = Double(version ?? "0"), let appVersion: Double = Double(appVersion ?? "0") {
//            print(appVersion, version)
//            if appVersion < version {
//                updateApp?()
//            }
//        }
    }
    
    
    func processData(data: SettingsUserDetails?) -> (SettingsUserDetails?, APIError?) {
        if data?.status == 101 || data?.status == 102 {
            alertMessage.value = K.someErrorOccured
            return (nil, .requestFailed)
        } else if data?.status == 116 {
            return (nil, .tokenExpired)
        } else {
            return (data, nil)
        }
    }
    
}

struct SettingsUserDetails: Codable {
    var status: Int?
    var responseArray: SettingsUserDetailsArray?
}

// MARK: - ResponseArray
struct SettingsUserDetailsArray: Codable {
    var deleted: Int?
    var isUserExpire: Int?
    var androidAppVersion, iosAppVersion, androidAppLink, iosAppLink: String?
    var dataCollection, triggerType, alreadyTriggered: Int?

    enum CodingKeys: String, CodingKey {
        case deleted = "deleted"
        case isUserExpire = "is_user_expire"
        case androidAppVersion = "android_app_version"
        case iosAppVersion = "ios_app_version"
        case androidAppLink = "android_app_link"
        case iosAppLink = "ios_app_link"
        case dataCollection = "data_collection"
        case triggerType = "trigger_type"
        case alreadyTriggered = "already_triggered"
    }
}




struct Banner: Codable {
    var status: Int?
    var responseArray: BannerResponseArray?
}

// MARK: - ResponseArray
struct BannerResponseArray: Codable {
    var iosAppURL, androidAppVersion, androidAppURL: String?
    var bannerImages: [String]?
    var iosAppVersion, isUserExpire: String?
    var enrollment_status: Int?
    var notice: String?
    var survey: Int?
    var iosAppLink: String?

    enum CodingKeys: String, CodingKey {
        case iosAppURL = "ios_app_url"
        case androidAppVersion = "android_app_version"
        case androidAppURL = "android_app_url"
        case bannerImages = "banner_images"
        case iosAppVersion = "ios_app_version"
        case enrollment_status = "enrollment_status"
        case isUserExpire
        case notice
        case iosAppLink = "ios_app_link"
        case survey
    }
}



