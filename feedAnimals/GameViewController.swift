//
//  GameViewController.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 12.07.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit


class GameViewController: UIViewController{
    // for animation
    var animationObj = Animation()
    
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
    
    // for position the food
    @IBOutlet weak var cloud: UIImageView!
    
    // button to enable a click on this area
    @IBOutlet weak var overlayLeft: UIButton!
    @IBOutlet weak var overlayRight: UIButton!
    
    // the star and the moon Button for bringing the animals into the field
    @IBOutlet weak var overlayButtonRStar: UIButton!
    @IBOutlet weak var overlayButtonLMoon: UIButton!
    
    // for touch functions
    var moonImageView = UIImageView()
    var starImageView = UIImageView()
    
    // this boolean is to prevent a multiple call of the func touchEnded
    var isTouchAllowed = true
    var isStarTouchAllowed = true
    var isMoonTouchAllowed = true
    
    // arrays for animals
    var animalMoonArr = [UIImageView]()
    var animalStarArr = [UIImageView]()
    
    // arrays for food
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
    
    // information about Level
    var thisLevel: Level!
    var levelID = Int()
    var allLevelCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationObj.pulsateButton(objectButton:overlayButtonRStar)
        animationObj.pulsateButton(objectButton:overlayButtonLMoon)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let thisLevelViewController = segue.destination as! TransitionGameViewController
        thisLevelViewController.myInt = levelID
        thisLevelViewController.actualLevel = thisLevel
    }
    
    
    @IBAction func changeLevel(_ sender: UIButton) {
        self.levelID = levelID + 1
        if(self.levelID >= allLevelCount){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let gameSummaryViewController = storyBoard.instantiateViewController(withIdentifier: "SummaryGameViewController") as! SummaryGameViewController
            self.present(gameSummaryViewController, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: "setSegue", sender: self)
        }
    }
    
    @IBAction func pressOverlay(_ sender: UIButton) {
        var myDelay = 0.0
        if sender == overlayButtonRStar {
            //464
            animalStarArr = gamePreconditionAnimal(xStart: 470, animalCount: thisLevel.numberAnimalStar, animalName:thisLevel.neutralAnimalImg as String)
        
            for imageView in (animalStarArr){
                // the change of the delay can help us to let the animals come partially in
                UIView.animate(withDuration: 1.5, delay: myDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    imageView.center.y += self.view.bounds.width
                    myDelay = myDelay + 0.5
                }, completion: nil)
            }
            
            overlayRight.isHidden = true
            
            /*mit alpha wird es transparent-> isEnabled setzt es ebenfalls auf transparent
            overlayButtonRStar.alpha = 0.5*/
            
            overlayButtonRStar.isEnabled = false
            self.starImageView = UIImageView(image: UIImage(named: thisLevel.foodStarImg))
            starImageView.frame = CGRect(x: 430, y: 620, width: 200, height: 120)
            view.addSubview(starImageView)
               
        }
        if sender == overlayButtonLMoon {
            //45
            animalMoonArr = gamePreconditionAnimal(xStart: 55, animalCount: thisLevel.numberAnimalMoon, animalName: thisLevel.neutralAnimalImg as String)
            
            for imageView in (animalMoonArr){
                // the change of the delay can help us to let the animals come partially in
                UIView.animate(withDuration: 1.5, delay: myDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    imageView.center.y += self.view.bounds.width
                    myDelay = myDelay + 0.5
                }, completion: nil)
            }
            
            overlayLeft.isHidden = true
            overlayButtonLMoon.isEnabled = false
            self.moonImageView = UIImageView(image: UIImage(named: thisLevel.foodMoonImg))
            moonImageView.frame = CGRect(x: 430, y: 620, width: 200, height: 120)
            view.addSubview(moonImageView)
        }
    }
    
    // position the animals to feed position behind the wood
    func gamePreconditionAnimal(xStart:Int, animalCount:Int, animalName:String)-> [UIImageView] {
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
            
            self.view.addSubview(imageView)
            xCalStart = xDepOnCount
            imageViewArr.append(imageView)
            
        }
        return imageViewArr
    }
    
    //1 touch of food in the cloud (drag and drop)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self.view)
            
            if starImageView.frame.contains(location){
                    self.starImageView.center = location
            }else{
                    self.moonImageView.center = location
            }
        }
    }
    
    //2 touch of food in the cloud (drag and drop)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            
            if starImageView.frame.contains(location){
                    self.starImageView.center = location
            }else if moonImageView.frame.contains(location){
                    self.moonImageView.center = location
            }
        }
    }
    
    //3 touch of food in the cloud (drag and drop)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTouchAllowed == true{
            for touch in (touches){
                let location = touch.location(in: self.view)
                var counter : CGFloat = -160
                if (starImageView.frame.contains(location)) && (isStarTouchAllowed == true){
                    starImageView.isHidden = true
                    for _ in 0...4 {
                        self.starImageView = UIImageView(image: UIImage(named: thisLevel.foodStarImg))
                        starImageView.frame.size.width = 80
                        starImageView.frame.size.height = 40
                        starImageView.center.x = (dropImageStar.center.x + counter)
                        starImageView.center.y = dropImageStar.center.y
                        view.addSubview(starImageView)
                        foodStarArr.append(starImageView)
                        starImageView.superview?.bringSubview(toFront: cloud)
                        isStarTouchAllowed = false
                        //overlayButtonRStar.isEnabled = true
                        counter += 80
                        
                    }
                    feedAnimals(animals: animalStarArr, food: foodStarArr)
                    if(isMoonTouchAllowed == false){
                        self.isTouchAllowed = false
                    }
                    _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                        // do stuff 5 seconds later
                        // Button "Wie viele <Tier> werden glücklich?"
                        self.addCheckHappyAnimalButton(nameOfImage: (self.thisLevel.animalName as NSString), foodImg: self.starImageView)
                    }
                }
                else if (moonImageView.frame.contains(location)) && (isMoonTouchAllowed == true){
                    moonImageView.isHidden = true
                    for _ in 0...4 {
                        self.moonImageView = UIImageView(image: UIImage(named: thisLevel.foodMoonImg))
                        moonImageView.frame.size.width = 80
                        moonImageView.frame.size.height = 40
                        moonImageView.center.x = (dropImageMoon.center.x + counter)
                        moonImageView.center.y = dropImageMoon.center.y
                        view.addSubview(moonImageView)
                        foodMoonArr.append(moonImageView)
                        moonImageView.superview?.bringSubview(toFront: cloud)
                        isMoonTouchAllowed = false
                        //overlayButtonLMoon.isEnabled = true
                        counter += 80
                        
                    }
                    feedAnimals(animals: animalMoonArr, food: foodMoonArr)
                    if(isStarTouchAllowed == false){
                        self.isTouchAllowed = false
                    }
                    _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                        // do stuff 5 seconds later
                        // Button "Wie viele <Tier> werden glücklich?"
                        self.addCheckHappyAnimalButton(nameOfImage: (self.thisLevel.animalName as NSString), foodImg: self.moonImageView)
                    }
                }
            }
        }
    }
 
    func addCheckHappyAnimalButton(nameOfImage:NSString, foodImg:UIImageView) {
        //210 350
        if foodImg == starImageView {
            let button = UIButton(frame: CGRect(x:540, y: 310, width: 350, height: 80))
            button.tag = 1
            button.layer.cornerRadius = 40
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.gray.cgColor
            button.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
            button.setTitle("Lass die " + (thisLevel.animalName as String) + " sortieren", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            button.addTarget(self, action: #selector(checkIfAnimalsHappyButton), for: .touchUpInside)
            
            self.view.addSubview(button)
        }else if foodImg == moonImageView{
            let button = UIButton(frame: CGRect(x:130, y: 310, width: 350, height: 80))
            button.tag = 2
            button.layer.cornerRadius = 40
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.gray.cgColor
            button.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
            button.setTitle("Lass die " + (thisLevel.animalName as String) + " sortieren", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            button.addTarget(self, action: #selector(checkIfAnimalsHappyButton), for: .touchUpInside)

            self.view.addSubview(button)
        }
    }
    
    // if click the button to sort the animals
    func checkIfAnimalsHappyButton(sender: UIButton!) {
        var distance = 0
  
        switch sender.tag
        {
        case 1:     //when button.tag = 1 Star is clicked...
            for n in 0..<thisLevel.numberLuckyStar{
                UIView.animate(withDuration: 5, delay: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations: {
                    distance = n * ((462 - 104)/self.thisLevel.numberLuckyStar)
                    self.animalStarArr[n].frame = CGRect(x: 520 + distance, y: 130, width: 100, height: 80)
                    self.animalStarArr[n].image = UIImage(named: self.thisLevel.happyAnimalImg)
                }, completion: { finished in
                    self.animalStarArr[n].isHidden = false
                })
            }
            for i in thisLevel.numberLuckyStar..<thisLevel.numberAnimalStar{
                UIView.animate(withDuration: 5, delay: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations: {
                    distance = (i-self.thisLevel.numberLuckyStar) * ((462 - 104)/self.thisLevel.numberUnluckyStar)
                    self.animalStarArr[i].frame = CGRect(x: 520 + distance, y: 430, width: 100, height: 80)
                    self.animalStarArr[i].image = UIImage(named: self.thisLevel.sadAnimalImg)
                }, completion: { finished in
                    self.animalStarArr[i].isHidden = false
                })
            }
            sender.isHidden = true
            if(overlayButtonLMoon.isEnabled == true){
                _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                    // do stuff 5 seconds later
                    self.animationObj.pulsateButton(objectButton: self.overlayButtonLMoon)
                }
            }
            break
        case 2:    //when button.tag = 2 Moon is clicked...
            //die ersten bis numberLucky sind lucky
            for n in 0..<thisLevel.numberLuckyMoon{
                UIView.animate(withDuration: 5, delay: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations: {
                    distance = n * ((462 - 104)/self.thisLevel.numberLuckyMoon)
                    self.animalMoonArr[n].frame = CGRect(x: 110 + distance, y: 130, width: 100, height: 80)
                    self.animalMoonArr[n].image = UIImage(named: self.thisLevel.happyAnimalImg)
                }, completion: { finished in
                    self.animalMoonArr[n].isHidden = false
                })
            }
        
            //ab Lucky bis numberAnimal sind unlucky
            for i in thisLevel.numberLuckyMoon..<thisLevel.numberAnimalMoon{
                UIView.animate(withDuration: 5, delay: 0.5, options: UIViewAnimationOptions.transitionCurlUp, animations: {
                    // (i-self.thisLevel.numberLuckyMoon) -> damit es auch mit 0 anfängt
                    distance = (i-self.thisLevel.numberLuckyMoon) * ((462 - 104)/self.thisLevel.numberUnluckyMoon)
                    self.animalMoonArr[i].frame = CGRect(x: 110 + distance, y: 430, width: 100, height: 80)
                    self.animalMoonArr[i].image = UIImage(named: self.thisLevel.sadAnimalImg)
                }, completion: { finished in
                    self.animalMoonArr[i].isHidden = false
                })
            }
            
            sender.isHidden = true
            if(overlayButtonRStar.isEnabled == true){
                _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                    // do stuff 5 seconds later
                    self.animationObj.pulsateButton(objectButton: self.overlayButtonRStar)
                }
            }
            break
        default:
            break
        }
        
    }
    
    func feedAnimals(animals: [UIImageView], food: [UIImageView]) {
        let animalImg = [thisLevel.happyAnimalImg,thisLevel.withMouthAnimalImg,thisLevel.happyAnimalImg]
        var images = [UIImage]()
        
        // animalImg is array with String, images includes the UIImages
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
  /*
    func seperateLuckyUnluckyAnimals(animals: [UIImageView], numberLucky: Int, numberUnlucky: Int) {
        if animals.count <= numberLucky {
            // move animals along the y position
        }else{
            // move rest animals along the y position
        }
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
