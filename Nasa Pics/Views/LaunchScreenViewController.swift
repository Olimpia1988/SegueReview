//
//  LaunchScreenViewController.swift
//  Nasa Pics
//
//  Created by Olimpia on 1/3/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit



class LaunchScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delay(4) {
            print("Error here")
            
            
            
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
