//
//  ToggleView.swift
//  rumor
//
//  Created by Albert Zhou on 11/27/23.
//

import SwiftUI


struct ToggleView: View {
    var userName:String
    @State private var selection: Tab = .home
    enum Tab{
        case home
        case profile
    }
    var body: some View {
        TabView(selection:$selection){
            HomeView(userName: userName)
                .tabItem { Label("Home",systemImage: "house")
                }.tag(Tab.home)
            ProfileView(userName: userName)
                .tabItem { Label("Profile",systemImage: "person")
                }.tag(Tab.profile)
                
        }
    }
}

#Preview {
    ToggleView(userName: "rumor")
}
