//
//  SearchBar.swift
//  CarouselListSwiftUI
//
//  Created by Nikita Patidar on 25/04/25.
//
import SwiftUI
struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        TextField(Constants.search, text: $text)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.horizontal, .bottom])
    }
}
private enum Constants {
    static let search = "Search"
}
