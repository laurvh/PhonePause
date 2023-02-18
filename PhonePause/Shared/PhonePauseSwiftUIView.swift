//
//  PhonePauseSwiftUIView.swift
//  PhonePause
//
//

import SwiftUI

struct TrackingView: View {
    @State var elapsedTime: TimeInterval = 0
    let threshold: TimeInterval = 2700 // 45 minutes in seconds
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Time spent: \(formatTimeInterval(elapsedTime))")
                .padding()
            
            Button("Start") {
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            .padding()
            
            Button("Stop") {
                self.timer.upstream.connect().cancel()
            }
            .padding()
        }
        .onReceive(timer) { _ in
            self.elapsedTime += 1
            
            if self.elapsedTime >= self.threshold {
                sendNotification()
                self.timer.upstream.connect().cancel()
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

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView()
    }
}

