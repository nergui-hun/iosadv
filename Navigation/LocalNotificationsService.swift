//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by M M on 7/11/23.
//

import UIKit
import UserNotifications

final class LocalNotificationsService: NSObject, UNUserNotificationCenterDelegate {
    static let shared = LocalNotificationsService()

    //MARK: - Methods
    func registerForLatestUpdatesIfPossible() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .provisional]) { granted, error in
            if granted {
                self.scheduleNotification()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func scheduleNotification() {
        registerCategories()

        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() //Отменяем все еще не появившиеся уведомления

        let content = UNMutableNotificationContent()

        content.title = "Уведомление"
        content.body = "Посмотрите последние обновления"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["CustomData": "qwerty"]
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 4
        dateComponents.minute = 3

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        print("Доступ к уведомлениям получен")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("You swiped")
            case "Show":
                print("Show more")
            default:
                break
            }
        }
        completionHandler()
    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "Show", title: "Show more", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [], options: [])

        center.setNotificationCategories([category])
    }

}
