//
//  MyAppApp.swift
//  MyApp
//
//  Created by SUshil on 19/02/22.
//

import SwiftUI
import Firebase
@main
struct MyAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
    
}
class AppDelegate: NSObject,UIApplicationDelegate{
    func application(_ application:UIApplication,didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey:Any]? = nil)-> Bool {
        FirebaseApp.configure()
        return true
    }
}
