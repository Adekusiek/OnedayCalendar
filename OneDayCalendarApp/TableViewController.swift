//
//  SecondViewController.swift
//  MyCalenderApp
//
//  Created by kawahara keisuke on 2017/01/24.
//  Copyright © 2017年 kawahara keisuke. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // Array of likedSentence
    var sentenceIndexList:  [Int]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard
        if let index = userDefaults.array(forKey: "likedIndex") as? [Int] {
            self.sentenceIndexList = index
        }
        self.tableView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sentenceIndex = sentenceIndexList {
            return sentenceIndex.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath) as? LikedTableViewCell else{
            return UITableViewCell()
        }
        
        if let sentenceIndexList = sentenceIndexList  {
            let likedIndex = sentenceIndexList[indexPath.row]
            cell.sentenceLabel.text = SentenceDataManager.sharedInstance.sentenceDataArray[likedIndex].sentence
            cell.authorLabel.text = SentenceDataManager.sharedInstance.sentenceDataArray[likedIndex].author
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            sentenceIndexList?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            let userDefauts = UserDefaults.standard
            userDefauts.set(sentenceIndexList, forKey:"likedIndex")
        }
    }
    
    
}
