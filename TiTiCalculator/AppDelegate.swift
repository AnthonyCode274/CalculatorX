//
//  AppDelegate.swift
//  GoogleMapsDemo
// https://www.raywenderlich.com/11395893-push-notifications-tutorial-getting-started
//  Created by Phuong Duong on 6/27/21....

import SwiftUI
import AVKit
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    static var displayName = Bundle.displayName()
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

// MARK: - UNUserNotificationCenterDelegate

//extension AppDelegate {
//    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        do {
//            try Network.reachability = Reachability(hostname: "www.google.com")
//        }
//        catch {
//            switch error as? Network.Error {
//            case let .failedToCreateWith(hostname)?:
//                print("Network error:\nFailed to create reachability object With host named:", hostname)
//            case let .failedToInitializeWith(address)?:
//                print("Network error:\nFailed to initialize reachability object With address:", address)
//            case .failedToSetCallout?:
//                print("Network error:\nFailed to set callout")
//            case .failedToSetDispatchQueue?:
//                print("Network error:\nFailed to set DispatchQueue")
//            case .none:
//                print(error)
//            }
//        }
//        return true
//    }
//}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
