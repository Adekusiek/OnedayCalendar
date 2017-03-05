//
//  DataViewController.swift
//  MyCalenderApp
//
//  Created by kawahara keisuke on 2017/01/25.
//  Copyright © 2017年 kawahara keisuke. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    

    @IBOutlet weak var yearField: UILabel!
    @IBOutlet weak var monthField: UILabel!
    @IBOutlet weak var dayField: UILabel!
    @IBOutlet weak var dowField: UILabel!
    @IBOutlet weak var sentenceField: UILabel!
    @IBOutlet weak var authorField: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var remainRatio: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var yearLabel: String?
    var monthLabel: String?
    var dayLabel: String?
    var dowLabel: String?
    var sentenceLabel: String?
    var authorLabel: String?
    var sentenceIndex: Int?
    var flagLiked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearField.text = yearLabel! + "年"
        monthField.text = monthLabel! + "月"
        dayField.text = dayLabel!
        dowField.text = dowLabel
        if dowLabel == "土曜日" {
            dowField.textColor = UIColor.blue
        } else if dowLabel == "日曜日" {
            dowField.textColor = UIColor.red
        }
        sentenceField.text = sentenceLabel
        authorField.text = authorLabel
        
        
        let currentdate = Calendar(identifier: .gregorian)
        let date = currentdate.date(from: DateComponents(year: Int(yearLabel!), month: Int(monthLabel!), day:Int(dayLabel!)))
        let firstDate = currentdate.date(from: DateComponents(year: Int(yearLabel!), month: 1, day:1))
        let endDate = currentdate.date(from: DateComponents(year: Int(yearLabel!), month: 12, day:31))
        let diffDays = date?.timeIntervalSince(firstDate!)
        let yearDiffDays = endDate?.timeIntervalSince(firstDate!)
        
        // プログレスバーの設定
        let ratio = 1 - Float(diffDays!)/Float(yearDiffDays!)
        let i = Float(diffDays!)/Float(yearDiffDays!) * 2.0
        let ratioPercent = Int(ratio * 100)
        progressBar.progress = ratio
        remainRatio.text = "残り" + String(ratioPercent) + "%"
        progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)  //この行を追加
        progressBar.progressTintColor = UIColor.init(red: CGFloat(min(i , 1)), green: CGFloat(1 - abs(1 - i)), blue: CGFloat(max(1 - i, 0)), alpha: 1)


        // お気に入り追加ボタンの設定
        let userDefaults = UserDefaults.standard
        var index =  [Int]()
        if let likedIndex = userDefaults.array(forKey: "likedIndex") {
            index = likedIndex as! [Int]
            
            for (index, element) in index.enumerated(){
                if sentenceIndex == element{
                    flagLiked = true
                    likeButton.setImage(UIImage(named: "star_yellow.pdf"), for: UIControlState.normal)
                    break
                }
            }

        }
        
        if flagLiked == false {
            likeButton.setImage(UIImage(named: "star_white.pdf"), for: UIControlState.normal)
            likeButton.setImage(UIImage(named: "star_opaque.pdf"), for: UIControlState.highlighted)
        
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    print(likeButton.currentTitle)
// button.setImage(UIImage(named: "star_yellow)
    @IBAction func tapLikeButton(_ sender: Any) {
        
        // If this sentence is already liked, disable this function even though the button is tapped
        if flagLiked == false {
            let userDefaults = UserDefaults.standard
            var index =  [Int]()
            // Check if any sentence is liked previously
            if let likedIndex = userDefaults.array(forKey: "likedIndex") {
                // Unchast array to Integer Array
                index = likedIndex as! [Int]
                index.append(sentenceIndex!)
            } else {
                index.append(sentenceIndex!)
            }
            // Set starbutton to yellowed start button
            likeButton.setImage(UIImage(named: "star_yellow.pdf"), for: UIControlState.normal)
            userDefaults.set(index, forKey: "likedIndex")
            userDefaults.synchronize()
            // without following line, we can add the liked sentence the number of times tapped before reloading
            flagLiked = true
        }
        
    }

}
