//
//  SettingTableViewController.swift
//  OneDayCalendarApp
//
//  Created by kawahara keisuke on 2017/02/03.
//  Copyright © 2017年 kawahara keisuke. All rights reserved.
//

/*
import UIKit

class SettingTableViewController: UITableViewController{

    //var sections = ["カレンダー初期化", "プッシュ送信"]
    var sections = ["カレンダー初期化"]
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成( status barの高さ分ずらして表示 ).
        let myTableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
        */
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myButton", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myPush", for: indexPath)
            return cell
        }

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
*/
