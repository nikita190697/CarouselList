//
//  CarouselModel.swift
//  CarouselListSwiftUI
//
//  Created by Nikita Patidar on 25/04/25.
//

import SwiftUI
import Foundation

struct CarouselItem: Identifiable {
    let id = UUID()
    let title: String
    let items: [ListItem]
}
struct ListItem: Identifiable {
    let id = UUID()
    let title: String?
    let description: String?
    let imageName: String?
}
