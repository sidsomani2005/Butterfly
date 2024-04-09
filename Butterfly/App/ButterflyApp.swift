//
//  ButterflyApp.swift
//  Butterfly
//
//  Created by Sid Somani on 11/23/23.
//

import SwiftUI
import FirebaseCore

@available(iOS 17.0, *)
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@available(iOS 17.0, *)
@main
struct ButterflyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
