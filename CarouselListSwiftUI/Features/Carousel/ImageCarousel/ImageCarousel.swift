//
//  ImageCarousel.swift
//  CarouselListSwiftUI
//
//  Created by Nikita Patidar on 25/04/25.
//
import SwiftUI
struct ImageCarousel: View {
    var viewModel: CarouselViewModel
    @State private var selectedImageIndex: Int = 0
    var body: some View {
        VStack {
            TabView(selection: $selectedImageIndex) {
                ForEach(0..<viewModel.carouselItems.count, id: \.self) { index in
                    Image(viewModel.carouselItems[index].image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .cornerRadius(12)
                        .padding()
                        .tag(index)
                        .onTapGesture {
                            viewModel.moveTo(index: index)
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 180)
            HStack(spacing: 6) {
                ForEach(0..<viewModel.carouselItems.count, id: \.self) { index in
                    Circle()
                        .fill(selectedImageIndex == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            selectedImageIndex = index
                            viewModel.moveTo(index: index)
                        }
                }
            }
            .onChange(of: selectedImageIndex) { oldValue, newValue in
                viewModel.moveTo(index: selectedImageIndex)
            }
        }
    }
}
