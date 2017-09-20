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
    var myInt: Int = 0

    @IBAction func touchFarmer(_ sender: UIButton) {
        positionAnimal(nameOfImage: "cow", countOfAnimal: 6, widthOfImage: 80.0, heightOfImage: 160.0)
        addFeedAnimalButton(nameOfImage: "cow")

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func addFeedAnimalButton(nameOfImage:NSString) {
        let button = UIButton(frame: CGRect(x:210, y: 350, width: 600, height: 80))
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.7569, green: 0.3843, blue: 0.0667, alpha: 1.0).cgColor
        button.backgroundColor = UIColor(red: 0.9451, green: 0.5137, blue: 0.1882, alpha: 1.0)
        button.setTitle("Help me to feed the " + (nameOfImage as String) + "s" , for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func buttonAction(sender: UIButton!) {
        if myInt != nil {
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
        viewcontroller.levelID = myInt
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
