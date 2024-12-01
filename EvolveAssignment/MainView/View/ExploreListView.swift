//
//  ExploreListView.swift
//  EvolveAssignment
//
//  Created by Jatin Gupta on 01/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreListView: View {
    var data: [Journey]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(data, id: \.id) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack(alignment: .bottomLeading) {
                            WebImage(url: URL(string: item.thumbImage))
                                .resizable()
                                .frame(height: 120)
                                .cornerRadius(10)
                            
                            if item.juPremium == "Premium" {
                                Image("lock_icon")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(.black.opacity(0.4))
                                    .cornerRadius(20)
                                    .padding()
                                    .zIndex(1.0)
                            }
                        }
                        
                        Text(item.title)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 4) {
                            Text(item.promoText)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            
                            Text("•")
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            
                            Text(item.description)
                                .font(Font.system(size: 14, weight: .medium))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.4 + 10)
                    .cornerRadius(12)
                }
            }
        }
    }
}
