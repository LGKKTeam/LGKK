//
//  SPBaseError.swift
//  spDirect
//
//  Created by Admin on 3/8/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import Foundation

// MARK: - Error
public enum SPAPICode: String {
    case none = ""
    
    // Authencation
    case errorRequiredFieldNotProvided
    case errorInvalidCredentials
    case errorPasswordLength
    case errorDuplication
    case errorAccountIsInactive
    case errorAccountIsActive
    case errorAccountIsBanned
    case errorAccountIsBannedOrActive
    case errorActivationCodeExpired
    case errorForgotPasswordCodeExpired
    case errorActivationFailed
    case errorResourceNotExist
    case invalidCurrentPassword
    case errorUnauthenticated
    case errorNotActiveUser
    case errorNoPaymentMethod
    
    //  Order
    case errorNoActiveCart
    
    public init(rawValue: String) {
        switch rawValue {
        case "ERROR_REQUIRED_FIELD_NOT_PROVIDED": self = .errorRequiredFieldNotProvided; break
        case "ERROR_INVALID_CREDENTIALS": self = .errorInvalidCredentials; break
        case "ERROR_PASSWORD_LENGTH": self = .errorPasswordLength; break
        case "ERROR_DUPLICATION": self = .errorDuplication; break
        case "ERROR_ACCOUNT_IS_INACTIVE": self = .errorAccountIsInactive; break
        case "ERROR_ACCOUNT_IS_ACTIVE": self = .errorAccountIsActive; break
        case "ERROR_ACCOUNT_IS_BANNED": self = .errorAccountIsBanned; break
        case "ERROR_ACCOUNT_IS_BANNED_OR_ACTIVE": self = .errorAccountIsBannedOrActive; break
        case "ERROR_ACTIVATION_CODE_EXPIRED": self = .errorActivationCodeExpired; break
        case "ERROR_FORGOT_PASSWORD_CODE_EXPIRED": self = .errorForgotPasswordCodeExpired; break
        case "ERROR_ACTIVATION_FAILED": self = .errorActivationFailed; break
        case "ERROR_RESOURCE_NOT_EXIST": self = .errorResourceNotExist; break
        case "INVALID_CURRENT_PASSWORD": self = .invalidCurrentPassword; break
        case "ERROR_UNAUTHENTICATED": self = .errorUnauthenticated; break
        case "ERROR_NOT_ACTIVE_USER": self = .errorNotActiveUser; break
        case "ERROR_NO_PAYMENT_METHOD": self = .errorNoPaymentMethod; break
        case "ERROR_NO_ACTIVE_CART": self = .errorNoActiveCart; break
        default: self = .none; break
        }
    }
}

public enum SPAPIStatus: Int {
    case statusSuccess = 0
    
    case status400 = 400
    case status401 = 401
    case status402 = 402
    case status403 = 403
    case status404 = 404
    case status500 = 500
    case status200 = 200
}

public enum SPBaseError {
    case none
    case encryptFailed
    case wrapError(Swift.Error)
    
    // error case from API
    case requiredFieldNotProvided
    case unexpectedError
    case loginFailed
    case invalidPasswordLength
    case activationTokenExpired
    case forgotPasswordTokenExpired
    case activationFailed
    case resourceNotExist
    case invalidPassword
    case unauthenticated
    case notActiveUser
    case duplication(String)
    
    // Signup error code
    case firstNameIsBlank
    case lastNameIsBlank
    case phoneNumberIsBlank
    case invalidPhoneNumber
    case emailIsBlank
    case invalidEmail
    case passwordBlank
    case confirmPasswordBlank
    case passwordLessThan6Characters
    case confirmPasswordLessThan6Characters
    case passwordAndConfirmPasswordAreNotMatched
    case verificationCodeIsIncorrect
    
    // Sign in error code
    case phoneOrPasswordIsIncorrect
    case accountDoesNotExit
    case accountIsNotActivatedYet
    case accountIsDisabled
    case accountIsActive
    
    // Order
    case noActiveCart
    case noResultFound
    case noPaymentMethod
    
    // Account
    case currentPasswordIncorrect
    case currentPasswordBlank
    case newPasswordBlank
    case newPasswordLessThan6Characters
    case confirmNewPasswordBlank
    case confirmNewPasswordLessThan6Characters
    case newPwdAndConfirmAreNotMatched
    
    private func toStringCaseAPI() -> String? {
        switch self {
        // error case from API
        case .requiredFieldNotProvided:
            return localString("Required field is not provided")
        case .unexpectedError:
            return localString("Unexpected error")
        case .loginFailed:
            return localString("Login failed")
        case .invalidPasswordLength:
            return localString("Invalid password length")
        case .activationTokenExpired:
            return localString("Your activation token does not exist or has been expired.")
        case .forgotPasswordTokenExpired:
            return localString("Your forgot password token does not exist or has been expired.")
        case .activationFailed:
            return localString("Activation failed")
        case .resourceNotExist:
            return localString("Resource does not exist")
        case .invalidPassword:
            return localString("Invalid password")
        case .unauthenticated:
            return localString("Unauthenticated")
        case .notActiveUser:
            return localString("Not active user")
        case .duplication(let message):
            return localString(message)
        default:
            return nil
        }
    }
    
    private func toStringSignup() -> String? {
        switch self {
        // Signup error code
        case .firstNameIsBlank:
            return localString("Please enter your first name.")
        case .lastNameIsBlank:
            return localString("Please enter your last name.")
        case .phoneNumberIsBlank:
            return localString("Please enter your mobile phone number.")
        case .invalidPhoneNumber:
            return localString("Your phone number is invalid.")
        case .emailIsBlank:
            return localString("Please enter your email.")
        case .invalidEmail:
            return localString("Your email is invalid.")
        case .passwordBlank:
            return localString("Passwords should be at least 6 characters.")
        case .confirmPasswordBlank:
            return localString("Passwords should be at least 6 characters.")
        case .passwordLessThan6Characters:
            return localString("Passwords should be at least 6 characters.")
        case .confirmPasswordLessThan6Characters:
            return localString("Passwords should be at least 6 characters.")
        case .passwordAndConfirmPasswordAreNotMatched:
            return localString("Passwords do not match.")
        case .verificationCodeIsIncorrect:
            return localString("The verification code is invalid.")
        default:
            return nil
        }
    }
    
    private func toStringAccount() -> String? {
        switch self {
        // Account
        case .currentPasswordIncorrect:
            return localString("Your current password is incorrect.")
        case .currentPasswordBlank:
            return localString("Please enter your current password.")
        case .newPasswordBlank:
            return localString("Passwords should be at least 6 characters.")
        case .newPasswordLessThan6Characters:
            return localString("Passwords should be at least 6 characters.")
        case .confirmNewPasswordBlank:
            return localString("Passwords should be at least 6 characters.")
        case .confirmNewPasswordLessThan6Characters:
            return localString("Passwords should be at least 6 characters.")
        case .newPwdAndConfirmAreNotMatched:
            return localString("New passwords do not match.")
        default:
            return nil
        }
    }
    
    private func toStringAuthenAccount() -> String? {
        switch self {
        // Signin error code
        case .phoneOrPasswordIsIncorrect:
            return localString("Your phone number or password is incorrect.")
        case .accountDoesNotExit:
            return localString("Your phone number or password is incorrect.")
        case .accountIsNotActivatedYet:
            let msg = "You have not completed registration. We will send a code to you for account verification."
            return localString(msg)
        case .accountIsDisabled:
            var msg = "Your account is disable. For any questions or concerns, "
            msg.append("please contact our Customer Support at (424) 333-0709 or via email demo.siliconprime@gmail.com")
            return localString(msg)
        case .accountIsActive:
            return localString("Your account is activated already")
        default:
            return nil
        }
    }
    
    public func toString() -> String? {
        if let result = toStringCaseAPI() {
            return result
        } else if let result = toStringAuthenAccount() {
            return result
        } else if let result = toStringSignup() {
            return result
        } else if let result = toStringAccount() {
            return result
        }
        
        switch self {
        case .encryptFailed:
            return NSLocalizedString("Encrypt failed somewhere", comment: "")
        case .wrapError(let error):
            let error = error as NSError
            let userInfo = error.userInfo
            var errorMessage = "Undefine"
            if let message = userInfo[NSLocalizedFailureReasonErrorKey] as? String {
                errorMessage = message
            } else {
                errorMessage = error.description
            }
            return errorMessage
            
        // Order
        case .noResultFound:
            return localString("No result found")
        case .noActiveCart:
            return localString("No active cart.")
        case .noPaymentMethod:
            return localString("No payment method.")
            
        default:
            return ""
        }
    }
    
    private func localString(_ str: String) -> String {
        return NSLocalizedString(str, comment: "")
    }
    
    // For get a error message, need 2 params status and code from response.
    public init(status: SPAPIStatus, code: SPAPICode, response: [String: Any]?) {
        switch (status, code) {
        case (.status400, SPAPICode.errorDuplication):
            if let response = response, let message = response["message"] as? String {
                self = .duplication(message)
            } else {
                self = .duplication("Duplication")
            }
            break
            
        case (.status403, SPAPICode.errorAccountIsInactive): self = .accountIsNotActivatedYet; break
        case (.status403, SPAPICode.errorAccountIsActive): self = .accountIsActive; break
        case (.status403, SPAPICode.errorAccountIsBanned): self = .accountIsDisabled; break
        case (.status400, SPAPICode.errorRequiredFieldNotProvided): self = .requiredFieldNotProvided; break
        case (.status500, SPAPICode.errorInvalidCredentials): self = .unexpectedError; break
        case (.status403, SPAPICode.errorInvalidCredentials): self = .loginFailed; break
        case (.status400, SPAPICode.errorPasswordLength): self = .invalidPasswordLength; break
        case (.status400, SPAPICode.errorActivationCodeExpired): self = .activationTokenExpired; break
        case (.status400, SPAPICode.errorForgotPasswordCodeExpired): self = .forgotPasswordTokenExpired; break
        case (.status400, SPAPICode.errorActivationFailed): self = .activationFailed; break
        case (.status404, SPAPICode.errorResourceNotExist): self = .resourceNotExist; break
        case (.status400, SPAPICode.invalidCurrentPassword): self = .invalidPassword; break
        case (.status401, SPAPICode.errorUnauthenticated): self = .unauthenticated; break
        case (.status400, SPAPICode.errorNotActiveUser): self = .notActiveUser; break
        // Order
        case (.status404, SPAPICode.errorNoActiveCart): self = .noActiveCart; break
        case (.status404, SPAPICode.errorNoPaymentMethod): self = .noPaymentMethod; break
        default: self = .none; break
        }
    }
}
