//
//  Artisan.swift
//  BeautyBell
//
//  Created by Jacob Andrean on 10/06/21.
//

import Foundation

struct Artisan: Codable {
    let id: String
    let createdAt: String
    let name: String
    let avatar: String
    let image: String
    let user_image: String
    let rating: String
    let description: String
    let services: [Service]
}

struct Service: Codable {
    let name: String
    let price: String
    let caption: String
}
