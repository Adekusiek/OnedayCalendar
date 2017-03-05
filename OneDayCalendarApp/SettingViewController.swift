//
//  SettingViewController.swift
//  OneDayCalendarApp
//
//  Created by kawahara keisuke on 2017/02/07.
//  Copyright © 2017年 kawahara keisuke. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func tapInitialButton(_ sender: Any) {

        // Add alert dialogue
        let alertController = UIAlertController(title: "日付の初期化", message: "本年度01月01日にカレンダーを巻き戻します", preferredStyle: UIAlertControllerStyle.alert)
        // Add OK button
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(action: UIAlertAction) in
            // When OK button is tapped
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(false, forKey:"initFlag")
            userDefaults.synchronize()
        }

        alertController.addAction(okAction)
        // Add cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Display alert dialogue
        present(alertController, animated: true, completion: nil)

    }
}
