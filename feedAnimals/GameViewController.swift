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

    var isStarTouchEnded = false
    var isMoonTouchEnded = false
    
    var animalMoonArr = [UIImageView]()
    var animalStarArr = [UIImageView]()
    
    var barnMoonArr = [UIImageView]()
    var barnStarArr = [UIImageView]()
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
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
                    barnStarArr.append(starImageView)
                    starImageView.superview?.bringSubview(toFront: cloud)
                    isStarTouchEnded = true
                    counter += 80
                    
                }
                feedAnimals(animals: animalStarArr, barns: barnStarArr)
                
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
                    barnMoonArr.append(moonImageView)
                    moonImageView.superview?.bringSubview(toFront: cloud)
                    isMoonTouchEnded = true
                    counter += 80
                    
                }
                feedAnimals(animals: animalMoonArr, barns: barnMoonArr)
            }
        }
    }
 
    func feedAnimals(animals: [UIImageView], barns: [UIImageView]) {
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
        
        for n in barns{
            //n.isHidden = false
            UIView.animate(withDuration: 5, delay: 0.5, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {
                n.alpha = 0
            }, completion: { finished in
                n.isHidden = true
            })
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
