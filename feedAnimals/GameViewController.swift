//
//  GameViewController.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 12.07.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit


class GameViewController: UIViewController{
    // left top
    @IBOutlet weak var firstFarmArea: UIImageView!
    
    // left buttom
    @IBOutlet weak var secondFarmArea: UIImageView!
    
    // right top
    @IBOutlet weak var thirdFarmArea: UIImageView!
    
    // right buttom
    @IBOutlet weak var fourthFarmArea: UIImageView!

    @IBOutlet weak var dropImageMoon: UIImageView!
    
    @IBOutlet weak var dropImageStar: UIImageView!
    
    @IBOutlet weak var cloud: UIImageView!
    
    @IBOutlet weak var overlayLeft: UIButton!
    @IBOutlet weak var overlayRight: UIButton!
    
    @IBOutlet weak var overlayButtonRStar: UIButton!
    @IBOutlet weak var overlayButtonLMoon: UIButton!
    
    // for touch functions
    var moonImageView = UIImageView()
    var starImageView = UIImageView()
    
    // this boolean is to prevent a multiple call of the func touchEnded
    var isStarTouchEnded = false
    var isMoonTouchEnded = false
    
    var animalMoonArr = [UIImageView]()
    var animalStarArr = [UIImageView]()
    
    var foodMoonArr = [UIImageView]()
    var foodStarArr = [UIImageView]()
    
    // Elements after parsing JSON
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
    
    var levelID = Int()
    var actualLevel : Level!
    
    // Save the Levels here
    var allLevel = [Level]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Set up the URL request
        guard let fileUrl = Bundle.main.path(forResource: "JSONTestLevel", ofType: "json")else{
            print("Error: fileUrl")
            return
        }
        let url = URL(fileURLWithPath: fileUrl)
        
        // set up the session
        let session = URLSession.shared
        
        // make the request
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("error calling task")
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do{
                let myjson = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyObject]
                //print(myjson)
                
                for level in myjson{
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
                
                /*for level in self.allLevel {
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
                 }*/
                
                self.actualLevel = self.getActualLevel(id: self.levelID)
                print(self.actualLevel.happyAnimalImg)
            }
            catch{
                //catch error
            }
        }
        task.resume()
        
    }
    
    func getActualLevel(id: Int) -> Level {
        let thisLevel = self.allLevel[id]
        return thisLevel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let thisLevelViewController = segue.destination as! TransitionGameViewController
        thisLevelViewController.myInt = levelID
    }
    
    @IBAction func changeLevel(_ sender: UIButton) {
        
        if self.levelID < self.allLevel.count-1 {
            self.levelID = levelID + 1
            performSegue(withIdentifier: "setSegue", sender: self)
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let gameSummaryViewController = storyBoard.instantiateViewController(withIdentifier: "SummaryGameViewController") as! SummaryGameViewController
            self.present(gameSummaryViewController, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func pressOverlay(_ sender: UIButton) {
        if sender == overlayButtonRStar {
            animalStarArr = gameSettingsAnimal(xStart: 464, animalCount: 6, animalName: "sadCow.jpg")
            overlayRight.isHidden = true
            
            /*mit alpha wird es transparent-> isEnabled setzt es ebenfalls auf transparent
            overlayButtonRStar.alpha = 0.5*/
            
            overlayButtonRStar.isEnabled = false
            self.starImageView = UIImageView(image: UIImage(named: "barn-star.jpg"))
            starImageView.frame = CGRect(x: 420, y: 640, width: 200, height: 120)
            view.addSubview(starImageView)
               
        }
        if sender == overlayButtonLMoon {
            animalMoonArr = gameSettingsAnimal(xStart: 45, animalCount: 6, animalName: "sadCow.jpg")
            overlayLeft.isHidden = true
            overlayButtonLMoon.isEnabled = false
            self.moonImageView = UIImageView(image: UIImage(named: "barn-moon.jpg"))
            moonImageView.frame = CGRect(x: 420, y: 640, width: 200, height: 120)
            view.addSubview(moonImageView)
        }
    }
    
    // position the animals to feed position behind the wood
    func gameSettingsAnimal(xStart:Int, animalCount:Int, animalName:String)-> [UIImageView] {
        // calculate x depend on animalCount
        var xCalStart = xStart
        var imageView = UIImageView()
        var imageViewArr = [UIImageView]()
        let distance = (462 - 104)/animalCount
        for _ in 0 ..< animalCount {
            let xDepOnCount = xCalStart + distance
            imageView = UIImageView(image: UIImage(named: animalName))
            imageView.frame = CGRect(x: xDepOnCount, y: 460, width: 100, height: 80)
            imageView.center.y -= view.bounds.width
            
            UIView.animate(withDuration: 1.5, animations: {
                imageView.center.y += self.view.bounds.width
            })
            self.view.addSubview(imageView)
            xCalStart = xDepOnCount
            imageViewArr.append(imageView)
        }
        return imageViewArr
    }
    
    //1
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self.view)
            
            if starImageView.frame.contains(location){
                if isStarTouchEnded == false {
                    self.starImageView.center = location
                }
            }else{
                if isMoonTouchEnded == false {
                    self.moonImageView.center = location
                }
            }
        }
    }
    
    //2
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            
            if starImageView.frame.contains(location){
                if isStarTouchEnded == false {
                    self.starImageView.center = location
                }
            }else if moonImageView.frame.contains(location){
                if isMoonTouchEnded == false {
                    self.moonImageView.center = location
                }
            }
        }
    }
    
    //3
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self.view)
            var counter : CGFloat = -160
            if (starImageView.frame.contains(location)) && (isStarTouchEnded == false){
                starImageView.isHidden = true
                for _ in 0...4 {
                    self.starImageView = UIImageView(image: UIImage(named: "barn-star.jpg"))
                    starImageView.frame.size.width = 80
                    starImageView.frame.size.height = 40
                    starImageView.center.x = (dropImageStar.center.x + counter)
                    starImageView.center.y = dropImageStar.center.y
                    view.addSubview(starImageView)
                    foodStarArr.append(starImageView)
                    starImageView.superview?.bringSubview(toFront: cloud)
                    isStarTouchEnded = true
                    counter += 80
                    
                }
                feedAnimals(animals: animalStarArr, food: foodStarArr)
                
            }
            if (moonImageView.frame.contains(location)) && (isMoonTouchEnded == false){
                moonImageView.isHidden = true
                for _ in 0...4 {
                    self.moonImageView = UIImageView(image: UIImage(named: "barn-moon.jpg"))
                    moonImageView.frame.size.width = 80
                    moonImageView.frame.size.height = 40
                    moonImageView.center.x = (dropImageMoon.center.x + counter)
                    moonImageView.center.y = dropImageMoon.center.y
                    view.addSubview(moonImageView)
                    foodMoonArr.append(moonImageView)
                    moonImageView.superview?.bringSubview(toFront: cloud)
                    isMoonTouchEnded = true
                    counter += 80
                    
                }
                feedAnimals(animals: animalMoonArr, food: foodMoonArr)
            }
        }
    }
 
    func feedAnimals(animals: [UIImageView], food: [UIImageView]) {
        let animalImg = ["happyCow.jpg","happyCowMouth.jpg","happyCow.jpg"]
        var images = [UIImage]()
        
        for i in 0..<animalImg.count{
            images.append(UIImage(named: animalImg[i])!)
        }
        
        for i in animals{
            i.animationImages = images
            i.animationDuration = 1.0
            i.animationRepeatCount = 5
            i.startAnimating()
            
        }
        
        for n in food{
            //n.isHidden = false
            UIView.animate(withDuration: 5, delay: 0.5, options: UIViewAnimationOptions.transitionFlipFromTop, animations: {
                n.alpha = 0
            }, completion: { finished in
                n.isHidden = true
            })
        }
    }
    
    func seperateLuckyUnluckyAnimals(animals: [UIImageView], numberLucky: Int, numberUnlucky: Int) {
        if animals.count <= numberLucky {
            // move animals along the y position
        }else{
            // move rest animals along the y position
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
