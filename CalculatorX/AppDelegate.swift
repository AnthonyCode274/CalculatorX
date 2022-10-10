//
//  AppDelegate.swift
//  GoogleMapsDemo
// https://www.raywenderlich.com/11395893-push-notifications-tutorial-getting-started
//  Created by Phuong Duong on 6/27/21....

import SwiftUI
import AVKit


class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
}

// MARK: - UNUserNotificationCenterDelegate


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
