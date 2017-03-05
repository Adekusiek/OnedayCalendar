//
//  MySentenceData.swift
//  MyCalenderApp
//
//  Created by kawahara keisuke on 2017/01/28.
//  Copyright © 2017年 kawahara keisuke. All rights reserved.
//

import Foundation


class SentenceData{
    
    var sentence: String
    var author: String

    var sentenceNo: Int = 0
    
    init(sentenceDataSourceArray: [String]){
        sentence = sentenceDataSourceArray[0]
        author   = sentenceDataSourceArray[1]
    }
}

class SentenceDataManager{
    
    static let sharedInstance = SentenceDataManager()
    
    var sentenceDataArray = [SentenceData]()
    
    private init(){
        
    }
    
    var nowSentenceIndex: Int = 0
    
    func loadSentence(){
        sentenceDataArray.removeAll()
        nowSentenceIndex = 0
        
        guard let csvFilePath = Bundle.main.path(forResource: "GreatSentences", ofType: "csv") else{
            // if no csv file found
            print("csv file could not find")
            return
        }
        
        // Read csv File
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            // Read one line by one
            csvStringData.enumerateLines(invoking: {(line, stop) in
                // separate data by "," 
                let sentenceDataSourceArray = line.components(separatedBy: ",")
                // Create an object to conserve sentence data
                let sentenceData = SentenceData(sentenceDataSourceArray: sentenceDataSourceArray)
                self.sentenceDataArray.append(sentenceData)
                sentenceData.sentenceNo = self.sentenceDataArray.count
            })
        } catch let error {
            print("csv file could not read:\(error)")
            return
        }
        
    }
}
