//
//  ProfileModel.swift
//  MoneyTap
//
//  Created by Abhinay Varma on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation

struct SearchResultModel:Codable {
    let batchcomplete:Bool?
    let continueObject:ContinueObject?
    let queryObject:QueryObject?
    enum CodingKeys: String, CodingKey {
        case continueObject = "continue"
        case batchcomplete
        case queryObject = "query"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        continueObject = try values.decodeIfPresent(ContinueObject.self, forKey: .continueObject)
        batchcomplete = try values.decode(Bool.self, forKey: .batchcomplete)
        queryObject = try values.decode(QueryObject.self, forKey: .queryObject)
        
    }
}

struct ContinueObject:Codable {
    let gpsoffset:Int?
    let continueValue:String?
    
    enum CodingKeys: String, CodingKey {
        case gpsoffset
        case continueValue = "continue"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gpsoffset = try values.decodeIfPresent(Int.self, forKey: .gpsoffset)
        continueValue = try values.decode(String.self, forKey: .continueValue)
    }
}


struct QueryObject:Codable {
    let redirects:[RedirectObject]?
    let pages:[PageObject]?
    
    enum CodingKeys: String, CodingKey {
        case redirects
        case pages
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        redirects = try values.decodeIfPresent([RedirectObject].self, forKey: .redirects)
        pages = try values.decode([PageObject].self, forKey: .pages)
    }
}

struct RedirectObject:Codable {
    let index:Int?
    let from:String?
    let to:String?
}

struct PageObject:Codable {
    let pageid:Int?
    let ns:Int?
    let title:String?
    let index:Int?
    let thumbnail:ImageObject?
    let terms:TermObject?
}

struct ImageObject:Codable {
    let source:String?
    let width:Int?
    let height:Int?
}

struct TermObject:Codable {
    let description:[String]?
}
