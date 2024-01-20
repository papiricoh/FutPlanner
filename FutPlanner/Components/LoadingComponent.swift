//
//  LoadingComponent.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI
import Lottie

struct LoadingComponent: View {
    @State var degreesRotating = 0.0
    
    var body: some View {
        ZStack {
            Image(systemName: "soccerball").font(.system(size: 80))
                .foregroundColor(.black)
                .rotationEffect(.degrees(degreesRotating))
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)
                        .speed(0.3).repeatForever(autoreverses: false)) {
                            degreesRotating = 360.0
                        }
                }
            LottieView(animation: .named("loading")).looping()
        }.frame(width: 250, height: 250).padding(-40).background(Color.white).containerShape(Circle()).padding()
    }
}

#Preview {
    LoadingComponent()
}
