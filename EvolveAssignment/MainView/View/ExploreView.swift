//
//  MainView.swift
//  EvolveAssignment
//
//  Created by Jatin Gupta on 01/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreView: View {
    @ObservedObject var viewmodel: MockExploreViewmodel
    @State var searchText: String = ""
    @State private var selectedCategory: ProblemFilter? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Text("Explore")
                    .font(Font.system(size: 26, weight: .bold))
                    .lineSpacing(5.2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)

                Spacer()

                Button(action: {
                    // Heart button action
                }) {
                    Image("favorite_icon")
                }

                Button(action: {
                    // Music button action
                }) {
                    Image("music_icon")
                }
            }
            .padding(.top, 16)

            Text("Discover")
                .font(Font.system(size: 26, weight: .bold))
                .foregroundColor(.white)
                .fontWeight(.regular)
                .padding(.top, 16)

            HStack {
                Image("search_icon")

                TextField("Search", text: $searchText)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal)
            .background(.white.opacity(0.1))
            .cornerRadius(20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    let allCategory = ProblemFilter(title: "All", id: -1)
                    let categories = [allCategory] + (viewmodel.data?.problemFilter ?? [])

                    ForEach(categories, id: \.id) { category in
                        HStack(spacing: 8) {
                            Text(category.title)
                                .font(Font.system(size: 12, weight: .regular))
                                .foregroundColor(.white)

                            if selectedCategory == nil && category.id == -1 || selectedCategory?.id == category.id {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 10, height: 10)
                                    .rotationEffect(.degrees(10))
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background((selectedCategory == nil && category.id == -1) || selectedCategory?.id == category.id
                            ? Color.white.opacity(0.4)
                            : Color.white.opacity(0.2))
                        .cornerRadius(20)
                        .onTapGesture {
                            selectedCategory = category.id == -1 ? nil : category
                        }
                    }
                }
            }

            if let listData = filteredJourneys, !listData.isEmpty {
                ExploreListView(data: listData)
            } else {
                VStack {
                    Text("No items found for the selected category.")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .padding(.horizontal, 20)
        .background(.black)
        .onAppear {
            viewmodel.fetchExploreData()
        }
    }

    var filteredJourneys: [Journey]? {
        guard let data = viewmodel.data?.data else { return nil }
        
        let categoryFilteredData: [Journey]
        if selectedCategory == nil {
            categoryFilteredData = data
        } else {
            categoryFilteredData = data.filter { journey in
                if let problems = journey.problems {
                    return problems.contains { problem in
                        problem.localizedCaseInsensitiveContains(selectedCategory?.title ?? "")
                    }
                }
                return false
            }
        }
        
        if searchText.isEmpty {
            return categoryFilteredData
        } else {
            return categoryFilteredData.filter { journey in
                journey.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    ExploreView(viewmodel: MockExploreViewmodel())
}
