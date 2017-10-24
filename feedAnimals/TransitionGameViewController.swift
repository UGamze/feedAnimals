//
//  TransitionGameViewController.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 16.08.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit
import SpriteKit

class TransitionGameViewController: UIViewController {
    
    @IBOutlet weak var randomViewofAnimal: UIImageView!
    @IBOutlet weak var farmer: UIButton!
    var myInt = Int()
    
    // Save the Levels here
    var allLevel = [Level]()
    var actualLevel : Level!

    @IBAction func touchFarmer(_ sender: UIButton) {
        positionAnimal(nameOfImage: actualLevel.animalWithBody as NSString, countOfAnimal: actualLevel.numberAnimalMoon + actualLevel.numberAnimalStar, widthOfImage: 80.0, heightOfImage: 160.0)
        //addFeedAnimalButton(nameOfImage: "cow")

        let button = UIButton(frame: CGRect(x:230, y: 350, width: 600, height: 80))
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        button.setTitle("Hilf mir die " + (actualLevel.animalName) + " zu füttern" , for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                
                for level in myjson{
                    guard let levelDict = level as? [String: Any] else {return}
                    guard let animalName = levelDict["animalName"] as? String else {return}
                    guard let animalWithBody = levelDict["animalWithBody"] as? String else {return}
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
                    
                    self.allLevel.append(Level(animalName: animalName, animalWithBody: animalWithBody, foodMoonImg: foodMoonImg, foodStarImg: foodStarImg, happyAnimalImg: happyAnimalImg, numberAnimalMoon: numberAnimalMoon, numberAnimalStar: numberAnimalStar, numberLuckyMoon: numberLuckyMoon, numberLuckyStar: numberLuckyStar, numberUnluckyMoon: numberUnluckyMoon, numberUnluckyStar: numberUnluckyStar, sadAnimalImg: sadAnimalImg, withMouthAnimalImg: withMouthAnimalImg))
                    
                }
                if(self.myInt < self.allLevel.count) {
                    self.actualLevel = self.getActualLevel(id: self.myInt)
                }
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
    
    func positionAnimal(nameOfImage:NSString, countOfAnimal:Int, widthOfImage: CGFloat, heightOfImage: CGFloat) {
        //TODO: min. distance neccessary
        let x = self.randomViewofAnimal.frame.origin.x
        let y = self.randomViewofAnimal.frame.origin.y
        for _ in 0 ..< countOfAnimal {
            //create and position cow
            let imageView = UIImageView(image: UIImage(named: nameOfImage as String)!)
            imageView.frame = CGRect(
                //just in the rect randomViewofAnimal
                x: CGFloat(arc4random_uniform(UInt32(self.randomViewofAnimal.frame.width))) + x,
                y: CGFloat(arc4random_uniform(UInt32(self.randomViewofAnimal.frame.height))) + y,
                width: widthOfImage,
                height: heightOfImage)
            
            view.addSubview(imageView)
        }
        self.farmer.isUserInteractionEnabled = false
    }
    
    /**func addFeedAnimalButton(nameOfImage:NSString) {
        //210 350
        let button = UIButton(frame: CGRect(x:450, y: 310, width: 600, height: 80))
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.7569, green: 0.3843, blue: 0.0667, alpha: 1.0).cgColor
        button.backgroundColor = UIColor(red: 0.9451, green: 0.5137, blue: 0.1882, alpha: 1.0)
        button.setTitle("Help me to feed the " + (nameOfImage as String) + "s" , for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //button.center = self.view.center
        self.view.addSubview(button)
    }*/
    
    func buttonAction(sender: UIButton!) {
        if self.myInt < self.allLevel.count {
            performSegue(withIdentifier: "getSegue", sender: self)
        }
    }
    
    //function for ramdom Position
    func spawnRandomPosition() -> Int{
        let position = Int()
        let height = self.view!.frame.height
        let width = self.view!.frame.width
        
        let randomPosition = CGPoint(x:CGFloat(arc4random()).truncatingRemainder(dividingBy: height),
                                     y: CGFloat(arc4random()).truncatingRemainder(dividingBy: width))
        
        let sprite = SKSpriteNode()
        sprite.position = randomPosition
        
        return position
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewcontroller = segue.destination as! GameViewController
        viewcontroller.allLevelCount = allLevel.count
        viewcontroller.thisLevel = actualLevel
        viewcontroller.levelID = myInt
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
