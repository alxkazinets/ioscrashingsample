//
//  KSCrashSampleApp.swift
//  KSCrashSample
//
//  Created by alex on 11.06.2023.
//

import SwiftUI
import UIKit
import KSCrash_Installations

@main
struct KSCrashSampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        KSCrash.sharedInstance().deleteBehaviorAfterSendAll = .init(rawValue: 0)
        
        let crashesReportingInstallation = KSCrashInstallationStandard.sharedInstance()
        crashesReportingInstallation?.url = URL(string: "http://192.168.1.45:8001/")!
        crashesReportingInstallation?.install()
        
        crashesReportingInstallation?.sendAllReports(completion: { reports, completed, error in
            print(reports)
            print(completed)
            print(error)
        })
        
        return true
    }
}
