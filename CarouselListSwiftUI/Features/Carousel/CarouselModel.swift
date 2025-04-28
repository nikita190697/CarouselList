//
//  CarouselModel.swift
//  CarouselListSwiftUI
//
//  Created by Nikita Patidar on 25/04/25.
//

import SwiftUI
import Foundation

struct CarouselItem: Codable {
    let title: String
    let items: [ListItem]
}
struct ListItem: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String?
    let description: String?
    let imageName: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, description, imageName
    }
}
