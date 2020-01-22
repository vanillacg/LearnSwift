//
//  JobModel.swift
//  CGMK
//
//  Created by chenguang on 2020/1/22.
//  Copyright © 2020 chenguang. All rights reserved.
//

import Foundation
import ObjectMapper

class Channel: Mappable {
    var name: String?
    var nameEn: String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    
    init() {
        
    }
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
            name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seqId_id"]
        abbrEn <- map["abbr_en"]
    }
}

class Douban: Mappable {
    var channels: [Channel]?
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        channels <- map["channels"]
    }
}
