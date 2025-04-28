//
//  CarouselViewModel.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 23/04/25.
//

import Foundation

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
        carouselItems = loadCarouselItems()
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
        updateFilteredItems()
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
    func loadCarouselItems() -> [CarouselItem] {
        guard let url = Bundle.main.url(forResource: "carouselItems", withExtension: "json") else {
            print("Failed to find JSON file.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let carouselItems = try JSONDecoder().decode([CarouselItem].self, from: data)
            return carouselItems
        } catch {
            print("Error loading JSON: \(error)")
            return []
        }
    }
}
