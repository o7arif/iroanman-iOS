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
    }
    
    
    class Placeholder {
        static let writeUsYourValuableComments = NSLocalizedString("label.writeUsYourValuableComments", comment: "Write us your valuable comments....")
    }
    
    
    class Button {
        static let letsGetStarted = NSLocalizedString("button.letsGetStarted", comment: "Let`s Get Started")
        static let tapHereToLogin = NSLocalizedString("button.tapHereToLogin", comment: "Tap here to Login")
        static let getService = NSLocalizedString("button.getService", comment: "Get Service")
        static let seeMyOrder = NSLocalizedString("button.seeMyOrder", comment: "See My Order")
        static let submit = NSLocalizedString("button.submit", comment: "Submit")
    }
    
    
    class Message {
        static let readyToMakeYourLifeEasier = NSLocalizedString("message.readyToMakeYourLifeEasier", comment: "Ready to Make Your Life Easier with Laundry Service?")
        static let yourNotificationIsEmpty = NSLocalizedString("message.yourNotificationIsEmpty", comment: "Your notification is Empty")
        static let yourOrderListIsEmpty = NSLocalizedString("message.yourOrderListIsEmpty", comment: "Your order list is Empty")
        static let yourOrderHasBeenConfirmed = NSLocalizedString("message.yourOrderHasBeenConfirmed", comment: "Your order has been Confirmed")
        static let yourFeedbackWillHelpUsToImproveTheLaundryServiceExperience = NSLocalizedString("button.yourFeedbackWillHelpUsToImproveTheLaundryServiceExperience", comment: "Your feedback will help us to improve the Laundry Service Experience.")
        static let thanksForYourFeedback = NSLocalizedString("button.thanksForYourFeedback", comment: "Thanks for your feedback")
        static let somethingWentWrongPleaseTryAgainLater = NSLocalizedString("button.somethingWentWrongPleaseTryAgainLater", comment: "Something went wrong. Please try again later.")
    }
    
    
    class Formatted {
        static func yourOrderIdNo(orderId: String) -> String {
            return String(format: NSLocalizedString("fmt.yourOrderIdNo%@", comment: "Your Order ID No #"), orderId)
        }
    }
    
}
