//
//  SignupFormRequestModel.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 22/02/23.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
