//
//  StatsBottomSheet.swift
//  CarouselListSwiftUI
//
//  Created by Nikita Patidar on 25/04/25.
//
import SwiftUI
struct StatsBottomSheet: View {
    let stats: [String: Int]
    let count: Int
    let title: String
    var body: some View {
        VStack(spacing: 16) {
            Text("\(Constants.statsFor) \(title)")
                .font(.headline)
            Text("\(Constants.items) \(count)")
            ForEach(stats.sorted(by: { $0.value > $1.value }), id: \.key) { char, freq in
                Text("\(char): \(freq)")
            }
            Spacer()
        }
        .padding()
    }
}
private enum Constants {
    static let statsFor = "Stats for"
    static let items = "Items:"
}
