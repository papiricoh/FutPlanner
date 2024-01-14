//
//  HomeTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 12/1/24.
//

import SwiftUI

struct HomeTab: View {
    var body: some View {
        
        VStack(alignment: .center) {
            Text("FutPlanner").font(.system(size: 30)).multilineTextAlignment(.leading).bold()
            ClubCard()
            Spacer()
        }
    }
}

#Preview {
    HomeTab()
}
