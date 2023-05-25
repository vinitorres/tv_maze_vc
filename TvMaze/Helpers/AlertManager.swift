//
//
// Created by André Vinícius Torres Conrado
//


import UIKit

class AlertManager {
    static public func showErrorAlert(sender: UIViewController ,message: String) {
        let alertError = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
            sender.dismiss(animated: true)
        }
        alertError.addAction(okAction)
        sender.present(alertError, animated: true, completion: nil)
    }
}
