//
//  AppDelegate.swift
//  Food For All
//
//  Created by Daniel Jones on 1/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import Instabug

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        registerParseSubclasses()
        setParseConfiguration()
        PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
        instabugSetup()
        
        if User.current() == nil {
            //not logged in
            toWelcomeVC()
        } else {
            //already logged in
//            toFrontPageVC()
            let navController = UINavigationController(rootViewController: PhotosFormViewController())
            setInitialVC(vc: navController)
        }
        
        return true
    }
    
    fileprivate func setParseConfiguration() {
        var appConfiguration = Configuration()
        let configuration = ParseClientConfiguration {
            $0.applicationId = appConfiguration.environment.applicationId
            $0.server = appConfiguration.environment.server
        }
        Parse.initialize(with: configuration)
    }
    
    fileprivate func registerParseSubclasses() {
        User.registerSubclass()
        GigParse.registerSubclass()
        MessageMetrics.registerSubclass()
        SearchGig.registerSubclass()
        GigImage.registerSubclass()
        VenmoMetric.registerSubclass()
        ReviewParse.registerSubclass()
    }
    
    fileprivate func toWelcomeVC() {
        let rootVC = WelcomeViewController()
        let navController = WelcomeNavigationController(rootViewController: rootVC)
        setInitialVC(vc: navController)
    }
    
    fileprivate func toFrontPageVC() {
        let tabBarController = CustomTabBarController()
        setInitialVC(vc: tabBarController)
    }
    
    fileprivate func setInitialVC(vc: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
    
    fileprivate func instabugSetup() {
        Instabug.start(withToken: "c1d90288be3cf98624000127f6139a87", invocationEvent: .shake)
        Instabug.setIntroMessageEnabled(false)
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

