//
//  AppController.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation
import ProgressHUD

class AppController: UIViewController {
    
    override func viewDidLoad() {
        ProgressHUD.colorHUD = UIColor.yellow
        ProgressHUD.colorAnimation = .red
    }
    
    func startLoading() {
        
            ProgressHUD.show()
            self.view.isUserInteractionEnabled = false
        }

        func stopLoading() {
            self.view.isUserInteractionEnabled = true
            ProgressHUD.dismiss()
        }
    
}
