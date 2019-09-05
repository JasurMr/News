//
//  AuthViewController.swift
//  News
//
//  Created by Macbook on 9/5/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authService = AppDelegate.shared().authService
        // Do any additional setup after loading the view.
    }
    

    @IBAction func signinTouch() {
        authService.wakeUpSession()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
