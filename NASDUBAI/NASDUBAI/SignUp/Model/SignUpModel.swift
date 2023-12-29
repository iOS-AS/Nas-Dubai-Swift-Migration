//
//  SignUpModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 29/12/23.
//

import Foundation

struct SignUpModel {
    func callSignupApi(email: String, completion: @escaping (_ status: Bool, _ message: String) -> ()) {

        if email == "" {
//            alertMessage.value = "Please enter Email."
            completion(false, "Please enter Email.")
            return
        }

        if Validation.isValidEmail(email) {
            ApiServices().callSignupAPI(email: email) { completed in
                if completed.status == 100 {
                    DefaultsWrapper().setUserCode(completed.userCode ?? "")
                    DefaultsWrapper().setAccessToken(completed.token ?? "")
                    completion(true, "Successfully registered. Please check your email for further details.")
                } else if completed.status == 132 {
//                    alertMessage.value = "Invalid username or password"
                    completion(false, "Invalid username or password")
                } else if completed.status == 121 {
//                    alertMessage.value = "The e-mail has already registered."
                    completion(false, "The e-mail has already registered.")
                }
            }
        } else {
            completion(false, "Please enter the valid Email.")
        }


    }
}
