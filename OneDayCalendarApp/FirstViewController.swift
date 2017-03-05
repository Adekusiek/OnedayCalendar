//
//  FirstViewController.swift
//  MyCalenderApp
//
//  Created by kawahara keisuke on 2017/01/24.
//  Copyright © 2017年 kawahara keisuke. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPageViewControllerDataSource {
    
    let weekdayJP = ["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"]
    
    // Store the instance of UIPageViewController embedded into ContainerView
    var pageViewController: UIPageViewController?
    
    // Store the ViewController to showed with paging
    var calendarArray = [DataViewController]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load data from csv file
        SentenceDataManager.sharedInstance.loadSentence()
        
        let userDefaults = UserDefaults.standard
        
        // Initialization for the first launching after download
        if userDefaults.bool(forKey: "initFlag") {}else {
            let calendar = Calendar(identifier: .gregorian)
            let now = Date()
            let year = calendar.component(.year, from: now)
            
            userDefaults.set(year, forKey:"year")
            userDefaults.set(01, forKey:"month")
            userDefaults.set(01, forKey:"day")
            userDefaults.set(true, forKey:"initFlag")
            userDefaults.synchronize()
        }
        
        // Load previous stopped date
        let year = userDefaults.integer(forKey: "year")
        let month = userDefaults.integer(forKey: "month")
        let day = userDefaults.integer(forKey: "day")
        
        // Set calendar dates
        let currentdate = Calendar(identifier: .gregorian)
        let date = currentdate.date(from: DateComponents(year: year, month: month, day:day))

        
        // make instance of ViewController on the storyboard and add them to calender array
        for index in 0...365 {
            let calendar = storyboard?.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
            
            // This variable must not be changed to let
            //var startDay =   currentdate.date(byAdding: DateComponents(day: index), to: date!)
            var interval = 60*60*24*index
            var startDay = Date(timeInterval: Double(interval), since: date!)
            calendar.yearLabel = String(currentdate.component(.year, from: startDay))
            calendar.monthLabel = String(currentdate.component(.month, from: startDay))
            calendar.dayLabel = String(currentdate.component(.day, from: startDay))
            calendar.dowLabel = weekdayJP[currentdate.component(.weekday, from: startDay) - 1]
            
            // arc4random puts random number different in each execution
            // For the fixed random number, use random()
            let num = Int(arc4random()) % SentenceDataManager.sharedInstance.sentenceDataArray.count
            
            calendar.sentenceLabel = SentenceDataManager.sharedInstance.sentenceDataArray[num].sentence
            calendar.authorLabel = SentenceDataManager.sharedInstance.sentenceDataArray[num].author
            calendar.sentenceIndex = num
            
            calendarArray.append(calendar)
            
            if currentdate.isDateInTomorrow(startDay) {
                break
            }
            
            
        }
        
        // Get UIPageViewController embedded in ContainerView
        pageViewController = childViewControllers[0] as? UIPageViewController
        
        // Set Data Source
        pageViewController!.dataSource = self
        
        //Set ViewController for the initial view
        pageViewController!.setViewControllers([calendarArray[0]], direction: .forward, animated: false, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When calendar date is initialized
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "initFlag") {} else {
            self.calendarArray.removeAll()
            self.viewDidLoad()
        }


    }
    
    // 逆方向にページ送りした時に呼ばれるメソッド
    // No Going Back for this Calendar
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = calendarArray.index(of: viewController as! DataViewController), index < calendarArray.count - 1  else {
            return nil
        }
        
        saveDate(calendarArray: calendarArray[index + 1])
        
        return calendarArray[index + 1]
    }
    
    // 順方向にページ送りした時に呼ばれるメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = calendarArray.index(of: viewController as! DataViewController), index < calendarArray.count - 1 else {
            return nil
        }
        saveDate(calendarArray: calendarArray[index + 1])
        
        return calendarArray[index + 1]
    }
    
    @IBAction func tapJumpButton(_ sender: Any) {
        pageViewController!.setViewControllers([calendarArray[calendarArray.count - 2]], direction: .forward, animated: false, completion: nil)
        saveDate(calendarArray: calendarArray[calendarArray.count - 2])
    }
    
    func saveDate(calendarArray: DataViewController){
        
        let userDefaults = UserDefaults.standard

        let year = calendarArray.yearLabel
        let month = calendarArray.monthLabel
        let day = calendarArray.dayLabel
        
        userDefaults.set(Int(year!), forKey:"year")
        userDefaults.set(Int(month!), forKey:"month")
        userDefaults.set(Int(day!), forKey:"day")
        userDefaults.synchronize()
        
    }
    
    
}

