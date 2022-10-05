//
//  AppDelegate.swift
//  GoogleMapsDemo
// https://www.raywenderlich.com/11395893-push-notifications-tutorial-getting-started
//  Created by Phuong Duong on 6/27/21....

import SwiftUI
import UserNotifications
import AVKit


class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    var backgroundSessionCompletionHandler: (() -> Void)?
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        URLCache.shared.memoryCapacity = 20_000_000 // ~10 MB memory space
//        URLCache.shared.diskCapacity = 10_000_000_000 // ~1GB disk cache space
        URLCache.shared = URLCache(memoryCapacity: 20*1024*1024,
                                     diskCapacity: 4*1024*1024*1024,
                                         diskPath: nil)
        //  Audio session
        self.audioSessiton()
        
        // Override point for customization after application launch.you’re
        //        print("AppDelegate >> didFinishLaunchingWithOptions")
        
        UNUserNotificationCenter.current().delegate = self
        UITabBar.appearance().barTintColor = UIColor.green
        UITabBar.appearance().tintColor = UIColor.white
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        { [weak self] granted, _ in
            guard granted else { return }
            self?.getNotificationSettings()
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        let notificationOption = launchOptions?[.remoteNotification]
        
        if let notification = notificationOption as? [String: AnyObject],
           let aps = notification["aps"] as? [String: AnyObject] {
            print("aps: \(aps)")
        }
        return true
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        print("AppDelegate >> didReceiveRemoteNotification")
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        if aps["content-available"] as? Int == 1 {
            completionHandler(.noData)
        } else {
            completionHandler(.newData)
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            //            print("AppDelegate >> Notification settings: \(settings)")
            //            guard settings.authorizationStatus == .authorized else { return }
            //            DispatchQueue.main.async {
            //                UIApplication.shared.registerForRemoteNotifications()
            //            }
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken
                     deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        UserDefaults.standard.set(token, forKey: "deviceToken")
        //print("AppDelegate >> UserId \(MTConfig.GetUserId())")
        //print("AppDelegate >> Token \(token)")
        //Update token here
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError
                     error: Error) {
        // Try again later.
        print("AppDelegate >> Failed to register: \(error)")
    }
    
    func audioSessiton() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
        } catch {
            print("Failed to set audio session category.")
        }
    }
    
}

// MARK: - UNUserNotificationCenterDelegate


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
