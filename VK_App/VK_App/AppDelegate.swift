// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
        print(getUrlFileManager())
        return true
    }

    func getUrlFileManager() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
