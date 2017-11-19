//
//  FHViewController.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 13.08.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit

class FHViewController: UIViewController  {
    // for animation
    var animationObj = Animation()
    
    
    //Objects for firstVC
    @IBOutlet weak var farmer: UIButton!

    // Function for firstVC
    @IBAction func startAnimation(_ sender: UIButton) {
        animationObj.animateButton(objectButton: farmer)
        createSpeechBubbleText(textForSpeech: "Hallo, ich bin der Bauer Heinz...", nameOfImage: "speechBubble")
    }
    //Objects for secondVC
    @IBOutlet weak var sVCFarmer: UIButton!
    
    //Function for secondVC
    @IBAction func sVCstartAmination(_ sender: UIButton) {
        animationObj.animateButton(objectButton: sVCFarmer)
        createSpeechBubbleText(textForSpeech:"... und ich hab ein Bauernhof mit vielen Tieren: Kühen, Enten, Hasen usw.", nameOfImage: "speechBubble")
        animationObj.animateView(objectView: insertNewObject(name: "Sheep_body_happy_color", rec: CGRect(x: 750, y: 525, width: 160, height: 170)))
        
        animationObj.animateView(objectView: insertNewObject(name: "Cow_body_happy_color", rec: CGRect(x: 850, y: 480, width: 200, height: 250)))
        
        animationObj.animateView(objectView: insertNewObject(name: "Cat_body_happy_color", rec: CGRect(x: 495, y: 515, width: 120, height: 200)))
        
        animationObj.animateView(objectView: insertNewObject(name: "Chicken_body_happy_color", rec: CGRect(x: 660, y: 570, width: 140, height: 200)))
        
        animationObj.animateView(objectView: insertNewObject(name: "Rabbit_body_happy_color", rec: CGRect(x: 570, y: 570, width: 120, height: 200)))
    }
    
    //Objects for thirdVC
    @IBOutlet weak var thirdVCStarFee: UIButton!
    @IBOutlet weak var thirdVCanimatedFood: UIImageView!
    @IBOutlet weak var thirdVCanimatedFeestar: UIImageView!
    
    //Function for thirdVC
    @IBAction func thirdVCstartAmination(_ sender: UIButton) {
        animationObj.animateView(objectView: thirdVCanimatedFood)
        animationObj.animateButton(objectButton: thirdVCStarFee)
        createSpeechBubbleText(textForSpeech:"... eines Tages kommt die Sternenfee zu Bauer Heinz. Sie hat ein Zauberfutter dabei. Sie sagt, dass ihr Zauberfutter Tiere glücklich macht.", nameOfImage: "speechBubble-eckig")
    }
    
    //Objects for fourthVC
    @IBOutlet weak var fourthVCanimatedFood: UIImageView!
    @IBOutlet weak var fourthVCanimatedMoonFee: UIButton!
    
    //Function for fourthVC
    @IBAction func fourthVCanimationStart(_ sender: UIButton) {
        animationObj.animateView(objectView: fourthVCanimatedFood)
        animationObj.animateButton(objectButton: fourthVCanimatedMoonFee)
        createSpeechBubbleText(textForSpeech:"... am gleichen Tag kommt auch die Mondfee. Auch sie hat ein Zauberfutter dabei und sagt, dass ihr Zauberfutter Tiere glücklich macht.", nameOfImage: "speechBubble-eckig")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Create a Speechbubble
    func createSpeechBubbleText(textForSpeech:NSString, nameOfImage: String) {
        //create speechBubble with text and switch position
        let imageView = UIImageView(image: UIImage(named: nameOfImage)!)
        imageView.frame = CGRect(x: 780, y: 250, width: 200, height: 190)
        view.addSubview(imageView)
        //spiegelt das Bild
        imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        let text = UITextView(frame: CGRect(x: 808, y: 260, width: 150, height: 130))
        text.text = textForSpeech as String!
        text.textColor = UIColor.black
        text.backgroundColor = UIColor.clear
        text.textAlignment = .center
        view.addSubview(text)
    }
    
    //TODO: function should check, if the UIImageView (which would be inserted) exists in the view
    func checkImageViewInView(forImage:UIImageView) -> Bool {
        var checkImageInView = Bool()
        for imageView in view.subviews {
            if (forImage.frame != imageView.frame){
                checkImageInView = false
            }else{
                checkImageInView = true
                return checkImageInView
            }
        }
        return checkImageInView
    }
    //to insert a new Object with name and coordinates
    func insertNewObject(name:NSString, rec:CGRect) -> UIImageView{
        let imageView = UIImageView(image: UIImage(named: name as String)!)
        imageView.frame = rec
        //to eliminate double creation of UIImageView
        if(!checkImageViewInView(forImage: imageView)){
            view.addSubview(imageView)
            return imageView
        }
        return imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
