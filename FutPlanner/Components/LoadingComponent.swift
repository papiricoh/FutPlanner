//
//  LoadingComponent.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct LoadingComponent: View {
    @State var degreesRotating = 0.0
    
    var body: some View {
        ZStack {
            Image(systemName: "soccerball").font(.system(size: 80))
                .foregroundColor(.black)
                .rotationEffect(.degrees(degreesRotating))
            
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)
                        .speed(0.8).repeatForever(autoreverses: false)) {
                            degreesRotating = 360.0
                        }
                }
        }.padding(60).background(Color.white).cornerRadius(20).padding()
    }
}

#Preview {
    LoadingComponent()
}
