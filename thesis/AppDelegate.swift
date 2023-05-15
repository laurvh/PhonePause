//
//  AppDelegate.swift
//  thesis
//
//  Created by Lauren Van Horn
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    var timer: Timer?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
                    guard success else {
                        return
                    }
                    print("Success in APNs registry")
                }
        
        application.registerForRemoteNotifications()
        
        // Set up timer
        timer = Timer.scheduledTimer(withTimeInterval: 2700, repeats: true) { [weak self] timer in
            self?.sendReminderNotification()
        }
        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else{
                return
            }
            print("Token: \(token)")
        }
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Fetch data here if needed
        completionHandler(.newData)
    }
    
    func sendReminderNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time limit reached"
        content.body = "It's time to take a break! Go outside, drink some water, more resources in the app"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification request: \(error.localizedDescription)")
            } else {
                print("Notification request added successfully!")
            }
        }
    }
    
}


