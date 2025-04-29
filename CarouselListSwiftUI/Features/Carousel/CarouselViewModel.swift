//
//  CarouselViewModel.swift
//  CarouselListSwiftUI
//
//  Created by Nikita Patidar on 25/04/25.
//
import SwiftUI
import Foundation

@Observable
class CarouselViewModel {
    // MARK: - Variables
    var carouselItems: [CarouselItem] = []
    var selectedIndex: Int = 0
    var currentItem: CarouselItem? = nil
    var searchText: String = "" {
        didSet {
            updateFilteredItems()
        }
    }
    var filteredItems: [ListItem] = []
    var showStats = false
    // MARK: - Initializer
    init() {
        setup()
    }
    // MARK: - Setup
    func setup() {
        carouselItems = loadItems(from: "carouselItems", as: [CarouselItem].self) ?? []
        currentItem = carouselItems.first
        updateFilteredItems()
    }
    // MARK: - Get stats
    var stats: [String: Int] {
        let chars = filteredItems.compactMap { $0.title }
            .joined()
            .lowercased()
        var freq: [String: Int] = [:]
        for char in chars where char.isLetter {
            freq[String(char), default: 0] += 1
        }
        return freq.sorted { $0.value > $1.value }
            .prefix(3)
            .reduce(into: [:]) { $0[$1.key] = $1.value }
    }
    // MARK: - Change carousel items
    func moveTo(index: Int) {
        guard index >= 0 && index < carouselItems.count else { return }
        selectedIndex = index
        currentItem = carouselItems[index]
        searchText = ""
    }
    // MARK: - Update Filtered Items
    func updateFilteredItems() {
        if let currentItem = currentItem {
            filteredItems = searchText.isEmpty ? currentItem.items : currentItem.items.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        } else {
            filteredItems = []
        }
    }
}
extension CarouselViewModel {
    func loadItems<T: Decodable>(from fileName: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to find JSON file: \(fileName).json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedItems = try JSONDecoder().decode(T.self, from: data)
            return decodedItems
        } catch {
            print("Error loading JSON from \(fileName).json: \(error)")
            return nil
        }
    }
}
