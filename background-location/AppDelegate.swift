//
//  AppDelegate.swift
//  background-location
//
//  Created by ahmedmahmoud on 29/08/2022.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let locationManager = CLLocationManager()
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startUpdatingLocation()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    var timer = Timer()
    
    func applicationWillTerminate(_ application: UIApplication) {
       print("WILL BE TERMINATED")
    }
    
    @objc static func handler(_ t: Timer) {
        var request = URLRequest(url: URL(string: "http://localhost:7080")!)
        request.httpMethod = "POST"
        request.httpBody = Data("HELLO".utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print("RESPONSE")
        })

        task.resume()
    }
    
    
}


extension AppDelegate: CLLocationManagerDelegate {
    func sendUpdate(_ d: String) -> Void {
        var request = URLRequest(url: URL(string: "http://localhost:7080")!)
        request.httpMethod = "POST"
        request.httpBody = Data(d.utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print("RESPONSE")
        })

        task.resume()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedAlways) {
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations.first?.coordinate
        let l  = "\(loc?.longitude ?? 0) - \(loc?.latitude ?? 0)"
        sendUpdate(l)
        print(l)
    }

    
}
