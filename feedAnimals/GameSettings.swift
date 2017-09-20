//
//  GameSettings.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 10.09.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit

class GameSettings: NSObject {

    
    var allLevel = [Level]()
    var actualLevel : Level!
    
    
    func parsLevel(){
        
        let fileUrl = URL(fileURLWithPath: "/Users/Gamze/Documents/MasterFeedAnimals/feedAnimals/GameLevel.json")
        let task = URLSession.shared.dataTask(with: fileUrl) { (data, response, error) in
            if error != nil{
                print("ERROR")
            }
            else{
                if let mydata = data{
                    do{
                        let myjson = try JSONSerialization.jsonObject(with: mydata, options: JSONSerialization.ReadingOptions.mutableContainers)
                        //print(myjson)
                        
                        guard let array = myjson as? [Any] else {return}
                        
                        for level in array{
                            guard let levelDict = level as? [String: Any] else {return}
                            guard let foodMoonImg = levelDict["foodMoonImg"] as? String else {return}
                            guard let foodStarImg = levelDict["foodStarImg"] as? String else {return}
                            guard let happyAnimalImg = levelDict["happyAnimalImg"] as? String else {return}
                            guard let numberAnimalMoon = levelDict["numberAnimalMoon"] as? Int else {return}
                            guard let numberAnimalStar = levelDict["numberAnimalStar"] as? Int else {return}
                            guard let numberLuckyMoon = levelDict["numberLuckyMoon"] as? Int else {return}
                            guard let numberLuckyStar = levelDict["numberLuckyStar"] as? Int else {return}
                            guard let numberUnluckyMoon = levelDict["numberUnluckyMoon"] as? Int else {return}
                            guard let numberUnluckyStar = levelDict["numberUnluckyStar"] as? Int else {return}
                            guard let sadAnimalImg = levelDict["sadAnimalImg"] as? String else {return}
                            guard let withMouthAnimalImg = levelDict["withMouthAnimalImg"] as? String else {return}
                            
                            self.allLevel.append(Level(foodMoonImg: foodMoonImg, foodStarImg: foodStarImg, happyAnimalImg: happyAnimalImg, numberAnimalMoon: numberAnimalMoon, numberAnimalStar: numberAnimalStar, numberLuckyMoon: numberLuckyMoon, numberLuckyStar: numberLuckyStar, numberUnluckyMoon: numberUnluckyMoon, numberUnluckyStar: numberUnluckyStar, sadAnimalImg: sadAnimalImg, withMouthAnimalImg: withMouthAnimalImg))
                            
                        }
                        
                        for level in self.allLevel {
                            print(level.foodMoonImg)
                            print(level.foodStarImg)
                            print(level.happyAnimalImg)
                            print(level.numberAnimalMoon)
                            print(level.numberAnimalStar)
                            print(level.numberLuckyMoon)
                            print(level.numberLuckyStar)
                            print(level.numberUnluckyMoon)
                            print(level.numberUnluckyStar)
                            print(level.sadAnimalImg)
                            print(level.withMouthAnimalImg)
                        }
                        
                    }
                    catch{
                        //catch error
                    }
                }
            }
        }
        task.resume()
        
        //return allLevel
    }
    
    
    
    
    func getActualLevel() -> Level {
        var thisLevel = allLevel[0]
        
        thisLevel = actualLevel
        return actualLevel
    }
    
    
}
