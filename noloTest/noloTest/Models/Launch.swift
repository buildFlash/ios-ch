//
//  Launch.swift
//  noloTest
//
//  Created by Aryan Sharma on 26/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import Foundation

struct Launch: Codable {
    var mission_name: String
    var launch_date_utc: String
    var flight_number: Int
    var mission_id: [String]
    var rocket: Rocket
    var links: Link
    var details: String?
    var launch_year: String
}

struct Rocket: Codable {
    var rocket_name: String
}

struct Link: Codable {
    var mission_patch: String?
}
