//
//  ContentView.swift
//  PhonePause
//
//  Created by Lauren Van Horn on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    @State var elapsedTime: TimeInterval = 0
        @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        let threshold: TimeInterval = 2700 // 45 minutes in seconds
        @State var reminderMessage: String = ""

    var body: some View {
        VStack {
            Text("Time spent: \(formatTimeInterval(elapsedTime))")
                .padding()
            
            if !reminderMessage.isEmpty {
                            Text(reminderMessage)
                                .foregroundColor(.red)
                                .padding()
                        }

            Button("Start") {
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            .padding()

            Button("Stop") {
                self.timer.upstream.connect().cancel()
            }
            .padding()
        }
        
        .background(Image("PhonePauseBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        .onReceive(timer) { _ in
                    self.elapsedTime += 1

                    if self.elapsedTime >= self.threshold {
                        sendNotification()
                        self.timer.upstream.connect().cancel()
                    } else if Int(self.elapsedTime) % 600 == 0 {
                        self.reminderMessage = "Friendly reminder to take a break!"
                    } else {
                        self.reminderMessage = ""
                    }
                }
    }

    func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: interval)!
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time limit reached"
        content.body = "You have spent 45 consecutive minutes on your device. Take a break!"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
