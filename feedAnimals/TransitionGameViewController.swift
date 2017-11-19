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
    
    //save the Levels here
    var allLevel = [Level]()
    var actualLevel : Level!

    //after click the farmer
    @IBAction func touchFarmer(_ sender: UIButton) {
        positionAnimal(nameOfImage: actualLevel.animalWithBody as NSString, countOfAnimal: actualLevel.numberAnimalMoon + actualLevel.numberAnimalStar, widthOfImage: 80.0, heightOfImage: 160.0)

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
                    guard let neutralAnimalImg = levelDict["neutralAnimalImg"] as? String else {return}
                    guard let withMouthAnimalImg = levelDict["withMouthAnimalImg"] as? String else {return}
                    
                    self.allLevel.append(Level(animalName: animalName, animalWithBody: animalWithBody, foodMoonImg: foodMoonImg, foodStarImg: foodStarImg, happyAnimalImg: happyAnimalImg, numberAnimalMoon: numberAnimalMoon, numberAnimalStar: numberAnimalStar, numberLuckyMoon: numberLuckyMoon, numberLuckyStar: numberLuckyStar, numberUnluckyMoon: numberUnluckyMoon, numberUnluckyStar: numberUnluckyStar, sadAnimalImg: sadAnimalImg, neutralAnimalImg: neutralAnimalImg, withMouthAnimalImg: withMouthAnimalImg))
                    
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
    //get the actuel Level
    func getActualLevel(id: Int) -> Level {
        let thisLevel = self.allLevel[id]
        return thisLevel
    }
    //position the animal randomly
    func positionAnimal(nameOfImage:NSString, countOfAnimal:Int, widthOfImage: CGFloat, heightOfImage: CGFloat) {
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

    
    func buttonAction(sender: UIButton!) {
        if self.myInt < self.allLevel.count {
            performSegue(withIdentifier: "getSegue", sender: self)
        }
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
