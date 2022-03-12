//
//  L10n.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 3/9/22.
//

import Foundation

class L10n {
    
    class Label {
        static let getStuffWashed = NSLocalizedString("label.getStuffWashed", comment: "Get Stuff Washed")
        static let premiumWashing = NSLocalizedString("label.premiumWashing", comment: "Premium Washing")
        static let dryCleaning = NSLocalizedString("label.dryCleaning", comment: "Dry Cleaning")
        static let guestUser = NSLocalizedString("label.guestUser", comment: "Guest User")
        static let login = NSLocalizedString("label.login", comment: "Login")
        static let unknownAddress = NSLocalizedString("label.unknownAddress", comment: "Unknown address")
        static let promotions = NSLocalizedString("label.promotions", comment: "Promotions")
        static let ourServices = NSLocalizedString("label.ourServices", comment: "Our Services")
        static let emergencyService = NSLocalizedString("label.emergencyService", comment: "Emergency Service")
        static let home = NSLocalizedString("label.home", comment: "Home")
        static let myOrder = NSLocalizedString("label.myOrder", comment: "My Order")
        static let notification = NSLocalizedString("label.notification", comment: "Notification")
        static let profile = NSLocalizedString("label.profile", comment: "Profile")
        static let notifications = NSLocalizedString("label.notifications", comment: "Notifications")
        static let onGoing = NSLocalizedString("label.onGoing", comment: "On Going")
        static let completed = NSLocalizedString("label.completed", comment: "Completed")
        static let manageAddress = NSLocalizedString("label.manageAddress", comment: "Manage Address")
        static let privacyPolicy = NSLocalizedString("label.privacyPolicy", comment: "Privacy Policy")
        static let termsOfService = NSLocalizedString("label.termsOfService", comment: "Terms of Service")
        static let contactUs = NSLocalizedString("label.contactUs", comment: "Contact us")
        static let about = NSLocalizedString("label.about", comment: "About")
        static let logOut = NSLocalizedString("label.logOut", comment: "Log out")
        static let howWasLaundryService = NSLocalizedString("label.howWasLaundryService", comment: "How was Laundry Service?")
        static let orderDetails = NSLocalizedString("label.orderDetails", comment: "Order Details")
        static let cashOnDelivery = NSLocalizedString("label.cashOnDelivery", comment: "Cash on Delivery")
        static let SignUp = NSLocalizedString("label.SignUp", comment: "Sign up")
        static let unknownError = NSLocalizedString("label.unknownError", comment: "Unknown error!")
        static let recoverPassword = NSLocalizedString("label.recoverPassword", comment: "Recover Password")
        static let createYourNewPassword = NSLocalizedString("label.createYourNewPassword", comment: "Create your new password")
        static let alert = NSLocalizedString("label.alert", comment: "Alert")
        static let ok = NSLocalizedString("label.ok", comment: "Ok")
        static let skip = NSLocalizedString("label.skip", comment: "Skip")
        static let doYouWantAddYourProfilePhoto = NSLocalizedString("label.doYouWantAddYourProfilePhoto", comment: "Do you want add your profile photo?")
        static let pleaseAddYourPhotoCapture = NSLocalizedString("label.pleaseAddYourPhotoCapture", comment: "Please add your photo/Capture.")
        static let selectPhotoFirst = NSLocalizedString("label.selectPhotoFirst", comment: "Select photo first")
        static let congratulations = NSLocalizedString("label.congratulations", comment: "Congratulations!")
        static let otpVerification = NSLocalizedString("label.otpVerification", comment: "OTP Verification")
    }
    
    
    class Placeholder {
        static let writeUsYourValuableComments = NSLocalizedString("placeholder.writeUsYourValuableComments", comment: "Write us your valuable comments....")
        static let enterPhoneNumber = NSLocalizedString("placeholder.enterPhoneNumber", comment: "Enter Phone Number")
        static let enterYourPassword = NSLocalizedString("placeholder.enterYourPassword", comment: "Enter your password")
        static let yourName = NSLocalizedString("placeholder.yourName", comment: "Your Name")
        static let createPassword = NSLocalizedString("placeholder.createPassword", comment: "Create password")
        static let confirmPassword = NSLocalizedString("placeholder.confirmPassword", comment: "Confirm password")
        static let createNewPassword = NSLocalizedString("placeholder.createNewPassword", comment: "Create new password")
        static let confirmNewPassword = NSLocalizedString("placeholder.confirmNewPassword", comment: "Confirm new password")
    }
    
    
    class Button {
        static let letsGetStarted = NSLocalizedString("button.letsGetStarted", comment: "Let`s Get Started")
        static let tapHereToLogin = NSLocalizedString("button.tapHereToLogin", comment: "Tap here to Login")
        static let getService = NSLocalizedString("button.getService", comment: "Get Service")
        static let seeMyOrder = NSLocalizedString("button.seeMyOrder", comment: "See My Order")
        static let submit = NSLocalizedString("button.submit", comment: "Submit")
        static let forgotPassword = NSLocalizedString("button.forgotPassword", comment: "Forgot password?")
        static let sendOTP = NSLocalizedString("button.sendOTP", comment: "Send OTP")
        static let confirm = NSLocalizedString("button.confirm", comment: "Confirm")
        static let finish = NSLocalizedString("button.finish", comment: "Finish")
        static let resend = NSLocalizedString("button.resend", comment: "Resend")
        static let signIn = NSLocalizedString("button.signIn", comment: "Sign in")
        static let addNewAddress = NSLocalizedString("button.addNewAddress", comment: "Add New Address")
    }
    
    
    class Message {
        static let readyToMakeYourLifeEasier = NSLocalizedString("message.readyToMakeYourLifeEasier", comment: "Ready to Make Your Life Easier with Laundry Service?")
        static let yourNotificationIsEmpty = NSLocalizedString("message.yourNotificationIsEmpty", comment: "Your notification is Empty")
        static let yourOrderListIsEmpty = NSLocalizedString("message.yourOrderListIsEmpty", comment: "Your order list is Empty")
        static let yourOrderHasBeenConfirmed = NSLocalizedString("message.yourOrderHasBeenConfirmed", comment: "Your order has been Confirmed")
        static let yourFeedbackWillHelpUsToImproveTheLaundryServiceExperience = NSLocalizedString("message.yourFeedbackWillHelpUsToImproveTheLaundryServiceExperience", comment: "Your feedback will help us to improve the Laundry Service Experience.")
        static let thanksForYourFeedback = NSLocalizedString("message.thanksForYourFeedback", comment: "Thanks for your feedback")
        static let somethingWentWrongPleaseTryAgainLater = NSLocalizedString("message.somethingWentWrongPleaseTryAgainLater", comment: "Something went wrong. Please try again later.")
        static let pleaseLoginToGetOurService = NSLocalizedString("message.pleaseLoginToGetOurService", comment: "Please login to get our Service")
        static let dontHaveAnAccountSignUp = NSLocalizedString("message.dontHaveAnAccountSignUp", comment: "Don't have an Account? Sign up")
        static let pleaseRegisterToGetOurService = NSLocalizedString("message.pleaseRegisterToGetOurService", comment: "Please Register to get our Service")
        static let alreadyHaveAnAccountLoginNow = NSLocalizedString("message.alreadyHaveAnAccountLoginNow", comment: "Already have an Account? Login Now")
        static let enterPhoneNumberToRecoverPassword = NSLocalizedString("message.enterPhoneNumberToRecoverPassword", comment: "Enter phone number to recover Password")
        static let somethingWentWrongDuringPhotoFetchingFromGallery = NSLocalizedString("message.somethingWentWrongDuringPhotoFetchingFromGallery", comment: "Something went wrong during Photo fetching from gallery")
        static let youHaveSuccessfullySignedUpOnLaundryService = NSLocalizedString("message.youHaveSuccessfullySignedUpOnLaundryService", comment: "You have successfully Signed up on Laundry Service")
        static let enterTheVerificationCodeWeJustSentYouOtpOnYourPhone = NSLocalizedString("message.enterTheVerificationCodeWeJustSentYouOtpOnYourPhone", comment: "Enter the verification code we just sent you OTP on your Phone")
        static let youAreNotSignedInPleaseSignInFirst = NSLocalizedString("message.youAreNotSignedInPleaseSignInFirst", comment: "You are not signed in!\nPlease sign in first.")
        static let yourAddressListIsEmpty = NSLocalizedString("message.yourAddressListIsEmpty", comment: "Your address list is empty!")
    }
    
    
    class Error {
        static let invalidEmailAddress = NSLocalizedString("error.invalidEmailAddress", comment: "Invalid email address")
        static let atLeast6CharacterLong = NSLocalizedString("error.atLeast6CharacterLong", comment: "At least 6 character long")
        static let invalidMobileNumber = NSLocalizedString("error.invalidMobileNumber", comment: "Invalid mobile number")
        static let invalidNumber = NSLocalizedString("error.invalidNumber", comment: "Invalid number")
        static let notDefined = NSLocalizedString("error.notDefined", comment: "TT: not defined")
        static let pleaseEnterCorrectInformation = NSLocalizedString("error.pleaseEnterCorrectInformation", comment: "Please enter correct information")
        static let toolTipCustomStringShouldntBeEmptyHere = NSLocalizedString("error.toolTipCustomStringShouldntBeEmptyHere", comment: "toolTipCustomString shouldn't be empty here")
        static let passwordDidNotMatch = NSLocalizedString("error.passwordDidNotMatch", comment: "Password did not match")
    }
    
    
    class Formatted {
        static func yourOrderIdNo(orderId: String) -> String {
            return String(format: NSLocalizedString("fmt.yourOrderId%@", comment: "Your Order ID No #"), orderId)
        }
        static func orderIdNo(orderId: String) -> String {
            return String(format: NSLocalizedString("fmt.orderId%@", comment: "Order ID #"), orderId)
        }
        static func isEmpty(field: String) -> String {
            return String(format: NSLocalizedString("fmt.isEmpty", comment: "%@ is empty"), field)
        }
        static func mustBeBetweenTo(arg1: Int, arg2: Int) -> String {
            return String(format: NSLocalizedString("fmt.mustBeBetweenTo", comment: "Must be between: %@ to %@"), arg1, arg2)
        }
        static func mustBeDigits(arg: Int) -> String {
            return String(format: NSLocalizedString("fmt.mustBeDigits", comment: "Must be %@ digits"), arg)
        }
        static func mustBeBetweenDigits(arg1: Int, arg2: Int) -> String {
            return String(format: NSLocalizedString("fmt.mustBeBetweenDigits", comment: "Must be between %@ - %@ digits"), arg1, arg2)
        }
        static func resendCodeIn(arg: String) -> String {
            return String(format: NSLocalizedString("fmt.resendCodeIn", comment: "Resend code in %@ seconds"), arg)
        }
    }
    
}
