//
//  RatingComponent.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 19/2/24.
//

import SwiftUI

struct RatingComponent: View {
    var text: String
    @Binding var rating: Int
    var onRating = Image(systemName: "star.fill")
    var offRating: Image?
    var maxRating: Int = 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(text).font(.title3).bold().foregroundStyle(Color.white)
                Spacer(minLength: 10)
            }
            HStack {
                Spacer()
                ForEach(1...maxRating, id: \.self) { i in
                    Button {
                        rating = i
                    } label: {
                        renderRating(for: i).font(.system(size: 20))
                            .foregroundStyle(i > rating ? Color.white : Color.yellow)
                    }
                }.buttonStyle(.plain)
                Spacer()
            }
        }.padding(.horizontal).padding(.vertical, 5).background(Color.futGreenLight).cornerRadius(10).padding(.horizontal)
    }
    
    func renderRating(for i: Int) -> Image {
        if i > rating {
            offRating ?? onRating
        } else {
            onRating
        }
    }
}

#Preview {
    RatingComponent(text: "Rendimiento general", rating: .constant(1))
}
