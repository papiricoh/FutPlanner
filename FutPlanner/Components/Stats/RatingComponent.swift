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
            Text(text).font(.title3).bold()
            
            HStack {
                ForEach(1...maxRating, id: \.self) { i in
                    Button {
                        rating = i
                    } label: {
                        renderRating(for: i).font(.title3)
                            .foregroundStyle(i > rating ? Color.gray : Color.futGreenLight)
                    }
                }.buttonStyle(.plain)
            }
        }.padding()
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
