//
//  CarouselItem.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 25/04/25.
//
import Foundation

struct CarouselItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    let items: [ListItem]
    
    private enum CodingKeys: String, CodingKey {
        case title, items
    }
}

struct ListItem: Identifiable, Codable {
    var id = UUID()
    let title: String?
    let description: String?
    let imageName: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, description, imageName 
    }
}
