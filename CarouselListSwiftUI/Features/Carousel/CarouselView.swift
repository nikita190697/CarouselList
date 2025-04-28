//
//  ContentView.swift
//  CarouselListSwiftUI
//
//  Created by Nikita Patidar on 25/04/25.
//

import SwiftUI

struct CarouselView: View {
    @State private var viewModel = CarouselViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                List {
                    ImageCarousel(viewModel: viewModel)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                    
                    Section(header:
                                SearchBar(text: $viewModel.searchText)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color.white)
                    ) {
                        ForEach(viewModel.filteredItems) { item in
                            listItemView(item)
                        }
                        if viewModel.filteredItems.isEmpty {
                            Text("No data available!")
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .padding(.top, 12)
                .listStyle(.plain)
                .overlay(
                    floatingButton
                )
                .sheet(isPresented: $viewModel.showStats) {
                    StatsBottomSheet(
                        stats: viewModel.stats,
                        count: viewModel.currentItem?.items.count ?? 0,
                        title: viewModel.currentItem?.title ?? ""
                    )
                    .presentationDetents([.medium])
                }
            }
        }
    }
    
    @ViewBuilder
    func listItemView(_ item: ListItem) -> some View {
        HStack(spacing: 15) {
            if let imageName = item.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cardCornerRadius))
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(item.title ?? "")
                    .font(.headline)
                Text(item.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.all, 8)
        .background(Color.appListBg.opacity(0.6))
        .cornerRadius(Constants.cardCornerRadius)
        .listRowInsets(EdgeInsets(top: 3, leading: 16, bottom: 3, trailing: 16))
    }
    @ViewBuilder
    var floatingButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.showStats.toggle()
                }) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .font(.system(size: 24))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
        }
    }
}
private enum Constants {
    static let cardCornerRadius: CGFloat = 12
    static let imageSize: CGFloat = 60
    static let cardPadding: CGFloat = 8
}
#Preview {
    CarouselView()
}
