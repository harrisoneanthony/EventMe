//
//  Events.swift
//  EventMe
//
//  Created by Harrison Anthony on 9/18/23.
//

import Foundation


class Events: Codable {
    var events: [Event]!
}

class Event: Codable {
    var id: String
    var attending_count: Int
    var category: String
    var cost: Float?
    var cost_max: Float?
    var descr: String?
    var event_site_url: String
    var image_url: String
    var interested_count: Int
    var is_canceled: Bool
    var is_free: Bool
    var is_official: Bool
    var latitude: Double
    var longitude: Double
    var name: String
    var tickets_url: String?
    var time_end: String?
    var time_start: String?
    var location: Location
    var business_id: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case attending_count = "attending_count"
        case category = "category"
        case cost = "cost"
        case cost_max = "cost_max"
        case descr = "description"
        case event_site_url = "event_site_url"
        case image_url = "image_url"
        case interested_count = "interested_count"
        case is_canceled = "is_canceled"
        case is_free = "is_free"
        case is_official = "is_official"
        case latitude = "latitude"
        case longitude = "longitude"
        case name = "name"
        case tickets_url = "tickets_url"
        case time_end = "time_end"
        case time_start = "time_start"
        case location = "location"
        case business_id = "business_id"
    }
    
}

struct Location: Codable {
    var address1: String
    var address2: String?
    var address3: String?
    var city: String
    var zip_code: String
    var country: String
    var state: String
    var display_address: [String]
    var cross_streets: String
}
