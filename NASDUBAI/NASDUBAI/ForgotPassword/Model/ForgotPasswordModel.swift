//
//  ForgotPasswordModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 02/01/24.
//

import Foundation
struct ForgotPasswordModel {

    func callForgotPwApi(email: String, completion: @escaping (_ status: Bool, _ message: String) -> ()) {

        if email == "" {
//            alertMessage.value = "Please enter Email."
            completion(false, "Please enter Email.")
            return
        }

        if Validation.isValidEmail(email) {
            ApiServices().callForgotPwAPI(email: email) { completed in
                if completed.responsecode == "132" {
//                    alertMessage.value = "Invalid username or password"
                    completion(false, "Invalid username or password")
                } else {
                    completion(true, "Password successfully sent to your email. Please check.")
                }
            }
        } else {
            completion(false, "Please enter the valid Email")
        }
    }
}




struct ForgotPassword: Codable {
    let responsecode: String
    let pass: String?
}
