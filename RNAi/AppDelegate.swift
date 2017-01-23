//
//  AppDelegate.swift
//  RNAi
//
//  Created by Vivian Liu on 1/10/17.
//  Copyright © 2017 Vivian Liu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    // MARK: - Property
    fileprivate(set) var genes: [Gene] = []
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        readPlistData()
        UINavigationBar.appearance().tintColor = UIColor.white
        return true
    }
    
    // MARK: - Private Methods
    fileprivate func readPlistData() {
        if let path = Bundle.main.path(forResource: "data", ofType: "plist"), let siRNALibrary = NSArray(contentsOfFile: path) {
            var startIndex = 0
            var endIndex = 1
            while startIndex < siRNALibrary.count - 1, endIndex < siRNALibrary.count {
                let startItem = siRNALibrary[startIndex] as! Dictionary<String, String>
                let endItem = siRNALibrary[endIndex] as! Dictionary<String, String>
                if startItem["siRNA Pool Name"] == endItem["siRNA Pool Name"] {
                    endIndex += 1
                } else {
                    let range = NSMakeRange(startIndex, endIndex - startIndex)
                    let gene = Gene(dataArray: siRNALibrary.subarray(with: range) as NSArray)
                    genes.append(gene)
                    startIndex = endIndex
                    endIndex = startIndex + 1
                }
            }
        }
    }
}

