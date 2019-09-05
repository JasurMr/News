//
//  FeedViewController.swift
//  News
//
//  Created by Macbook on 9/5/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
        networkService.getFeed()
        
        // Do any additional setup after loading the view.
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
