//
//  NumericAssignComponent.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 20/2/24.
//

import SwiftUI

struct NumericAssignComponent: View {
    var text: String
    var img: String
    var imgColor: Color
    @Binding var num: Int
    var body: some View {
        VStack(spacing: 10) {
            Text(text).bold()
            VStack(spacing: 20) {
                Button(action: {
                    num += 1
                }, label: {
                    Image(systemName: "arrowtriangle.up")
                })
                HStack {
                    Image(systemName: img).foregroundColor(imgColor).font(.title2)
                    Text(String(num))
                }
                Button(action: {
                    decrease()
                }, label: {
                    Image(systemName: "arrowtriangle.down")
                })
            }
        }
    }
    
    func decrease() -> Void {
        if(self.num - 1 >= 0) {
            self.num -= 1
        }
    }
}

#Preview {
    NumericAssignComponent(text: "Goles", img: "greetingcard.fill", imgColor: Color.black, num: .constant(0))
}
