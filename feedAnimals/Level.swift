//
//  Level.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 03.09.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit

class Level: NSObject {
    var foodMoonImg = String()
    var foodStarImg = String()
    var happyAnimalImg = String()
    var numberAnimalMoon = Int()
    var numberAnimalStar = Int()
    var numberLuckyMoon = Int()
    var numberLuckyStar = Int()
    var numberUnluckyMoon = Int()
    var numberUnluckyStar = Int()
    var sadAnimalImg = String()
    var withMouthAnimalImg = String()
    
    
    init(foodMoonImg: String, foodStarImg: String, happyAnimalImg: String, numberAnimalMoon: Int, numberAnimalStar: Int, numberLuckyMoon: Int, numberLuckyStar: Int, numberUnluckyMoon: Int, numberUnluckyStar: Int, sadAnimalImg: String, withMouthAnimalImg: String) {
        
        self.foodMoonImg = foodMoonImg
        self.foodStarImg = foodStarImg
        self.happyAnimalImg = happyAnimalImg
        self.numberAnimalMoon = numberAnimalMoon
        self.numberAnimalStar = numberAnimalStar
        self.numberLuckyMoon = numberLuckyMoon
        self.numberLuckyStar = numberLuckyStar
        self.numberUnluckyMoon = numberUnluckyMoon
        self.numberUnluckyStar = numberUnluckyStar
        self.sadAnimalImg = sadAnimalImg
        self.withMouthAnimalImg = withMouthAnimalImg
        
    }
    
    
    
}
