//
//  Events.swift
//  EventMe
//
//  Created by Harrison Anthony on 9/18/23.
//

import Foundation


class Events: Codable {
    var events: [Events]!
}

class Event: Codable {
    var id: String
    var attending_count: Int
    var category: String
    var cost: Int?
    var cost_max: Int?
    var description: String
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
    var time_end: String
    var time_start: String
    var location: Location
    var business_id: String
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

