//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Petar Iliev on 8.11.22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "registerToChat"
    static let loginSegue = "loginToChat"
    static let title = "⚡️FlashChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
