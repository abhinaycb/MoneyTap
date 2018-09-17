//
//  AppConstants.swift
//  MoneyTap
//
//  Created by Abhinay Varma on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import UIKit
import Foundation

let DEBUG_MODE: Bool = true
let CURRENT_BUILD_VERSION = "5.0"  // used for client config API only


struct API_KEYS {
    static let GOOGLE_API_KEY: String = "AIzaSyARMIRBYefMU-jjUPeacM9tzxP-Mb6O5zw"//"AIzaSyCWQ7vzsDEu_ijgbbHNIk4tCBnfbftqj8I"//
    static let FACEBOOK_APP_ID: String = "460257644150836"
}

let ROW_HEIGHT:CGFloat = 150.0
let DEVICE_TYPE = "IOS"
let Button_Height: CGFloat = 60.0

var APPLICATION_NAME: String? {
    return Bundle.main.infoDictionary?["CFBundleName"] as? String
}

struct Colors {
    static let NAV_TITLE = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue:255.0/255.0, alpha: 1.0)
    static let NAV_TINT_BLUE_BG = UIColor(red : 60.0/255.0 , green : 59.0/255.0 , blue : 92.0/255.0, alpha : 1.0)
    static let APP_BG = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
    static let CELL_BG = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
}

struct ReasonType {
    static let Cancel = "CANCELLED"
    static let Reschedule = "RESCHEDULE"
    static let RejectQuote = "QUOTE_REJECTED"
}

struct MyOrdersType
{
    static let Bookings = "BOOKINGS"
    static let Subscriptions = "SUBSCRIPTIONS"
}

struct FONT_NAME {
    static let HJ_PROXIMANOVA_REGULAR_FONT = "ProximaNova-Regular"
    static let HJ_PROXIMANOVA_SEMIBOLD_FONT = "ProximaNova-Semibold"
    static let HJ_PROXIMANOVA_THIN_FONT = "ProximaNovaT-Thin"
}

struct Fonts {
    static let NAV_TITLE = UIFont(name: FONT_NAME.HJ_PROXIMANOVA_REGULAR_FONT, size: 17.0)!
    static let HEADING_FONT = UIFont(name: FONT_NAME.HJ_PROXIMANOVA_REGULAR_FONT, size: 15.0)!
    static let SMALL_TEXT = UIFont(name: FONT_NAME.HJ_PROXIMANOVA_REGULAR_FONT, size: 13.0)!
    static let SERVICES_REASONS_TO_CHOOSE_HJ_TITLE = Fonts.HEADING_FONT
    static let ADDRESS_LIST_TITLE = UIFont(name: FONT_NAME.HJ_PROXIMANOVA_THIN_FONT, size: 13.0)!
}

//Empty View
struct EmptyViewText {
    static let topText = "Nothing to see here"
    static let bottomText = "Yikes!Please try again, sorry for the inconvenience caused"
    static let imageNameText = "noDataImage"
}


