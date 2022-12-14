// UIViewController + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вызов алерта из любого UIViewController
extension UIViewController {
    typealias Closure = (() -> ())?
    func showAlert(title: String?, message: String?, handler: Closure) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: ConstantsSting.okText, style: .default) { _ in
            handler?()
        }
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}
