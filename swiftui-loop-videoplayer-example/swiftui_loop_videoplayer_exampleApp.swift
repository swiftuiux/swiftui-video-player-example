//
//  swiftui_loop_videoplayer_exampleApp.swift
//
//  Created by Igor Shelopaev on 03.07.2023.
//

import SwiftUI
import AVFAudio

@main
struct swiftui_loop_videoplayer_exampleApp: App {
    
    /// Delegate for processing notifications and  events of app level
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accessibilityIdentifier("ContentView")
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {

    /// Application enter point
    /// - Parameters:
    ///   - application: app
    ///   - launchOptions: launch params
    /// - Returns: State
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        setupAudio()

        return true
    }

    /// Setup audio params
    func setupAudio() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers])
            try audioSession.setActive(true)
        } catch {
            print("something went wrong")
        }
    }
}
