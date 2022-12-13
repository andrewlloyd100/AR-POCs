//
//  ARPOCsApp.swift
//  ARPOCs
//
//  Created by Andrew Lloyd on 08/12/2022.
//

import SwiftUI

@main
struct ARPOCsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(model: HomeModel())
        }
    }
}
