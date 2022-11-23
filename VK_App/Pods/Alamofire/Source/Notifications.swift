// Notifications.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

public extension Request {
    /// Posted when a `Request` is resumed. The `Notification` contains the resumed `Request`.
    static let didResumeNotification = Notification.Name(rawValue: "org.alamofire.notification.name.request.didResume")
    /// Posted when a `Request` is suspended. The `Notification` contains the suspended `Request`.
    static let didSuspendNotification = Notification
        .Name(rawValue: "org.alamofire.notification.name.request.didSuspend")
    /// Posted when a `Request` is cancelled. The `Notification` contains the cancelled `Request`.
    static let didCancelNotification = Notification.Name(rawValue: "org.alamofire.notification.name.request.didCancel")
    /// Posted when a `Request` is finished. The `Notification` contains the completed `Request`.
    static let didFinishNotification = Notification.Name(rawValue: "org.alamofire.notification.name.request.didFinish")

    /// Posted when a `URLSessionTask` is resumed. The `Notification` contains the `Request` associated with the
    /// `URLSessionTask`.
    static let didResumeTaskNotification = Notification
        .Name(rawValue: "org.alamofire.notification.name.request.didResumeTask")
    /// Posted when a `URLSessionTask` is suspended. The `Notification` contains the `Request` associated with the
    /// `URLSessionTask`.
    static let didSuspendTaskNotification = Notification
        .Name(rawValue: "org.alamofire.notification.name.request.didSuspendTask")
    /// Posted when a `URLSessionTask` is cancelled. The `Notification` contains the `Request` associated with the
    /// `URLSessionTask`.
    static let didCancelTaskNotification = Notification
        .Name(rawValue: "org.alamofire.notification.name.request.didCancelTask")
    /// Posted when a `URLSessionTask` is completed. The `Notification` contains the `Request` associated with the
    /// `URLSessionTask`.
    static let didCompleteTaskNotification = Notification
        .Name(rawValue: "org.alamofire.notification.name.request.didCompleteTask")
}

// MARK: -

extension Notification {
    /// The `Request` contained by the instance's `userInfo`, `nil` otherwise.
    public var request: Request? {
        userInfo?[String.requestKey] as? Request
    }

    /// Convenience initializer for a `Notification` containing a `Request` payload.
    ///
    /// - Parameters:
    ///   - name:    The name of the notification.
    ///   - request: The `Request` payload.
    init(name: Notification.Name, request: Request) {
        self.init(name: name, object: nil, userInfo: [String.requestKey: request])
    }
}

extension NotificationCenter {
    /// Convenience function for posting notifications with `Request` payloads.
    ///
    /// - Parameters:
    ///   - name:    The name of the notification.
    ///   - request: The `Request` payload.
    func postNotification(named name: Notification.Name, with request: Request) {
        let notification = Notification(name: name, request: request)
        post(notification)
    }
}

private extension String {
    /// User info dictionary key representing the `Request` associated with the notification.
    static let requestKey = "org.alamofire.notification.key.request"
}

/// `EventMonitor` that provides Alamofire's notifications.
public final class AlamofireNotifications: EventMonitor {
    public func requestDidResume(_ request: Request) {
        NotificationCenter.default.postNotification(named: Request.didResumeNotification, with: request)
    }

    public func requestDidSuspend(_ request: Request) {
        NotificationCenter.default.postNotification(named: Request.didSuspendNotification, with: request)
    }

    public func requestDidCancel(_ request: Request) {
        NotificationCenter.default.postNotification(named: Request.didCancelNotification, with: request)
    }

    public func requestDidFinish(_ request: Request) {
        NotificationCenter.default.postNotification(named: Request.didFinishNotification, with: request)
    }

    public func request(_ request: Request, didResumeTask task: URLSessionTask) {
        NotificationCenter.default.postNotification(named: Request.didResumeTaskNotification, with: request)
    }

    public func request(_ request: Request, didSuspendTask task: URLSessionTask) {
        NotificationCenter.default.postNotification(named: Request.didSuspendTaskNotification, with: request)
    }

    public func request(_ request: Request, didCancelTask task: URLSessionTask) {
        NotificationCenter.default.postNotification(named: Request.didCancelTaskNotification, with: request)
    }

    public func request(_ request: Request, didCompleteTask task: URLSessionTask, with error: AFError?) {
        NotificationCenter.default.postNotification(named: Request.didCompleteTaskNotification, with: request)
    }
}
