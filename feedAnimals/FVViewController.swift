//
//  FVViewController.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 13.08.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit

class FVViewController: UIViewController {

    //Objects for firstVC
    @IBOutlet weak var animationButton: UIButton!
    @IBOutlet weak var animatedFarmer: UIImageView!

    // Function for firstVC
    @IBAction func startAnimation(_ sender: UIButton) {
        animateView(objectFarmer: animatedFarmer)
        createSpeechBubbleText(textForSpeech: "Hallo, ich bin der Bauer Heinz...", nameOfImage: "speechBubble")
    }
    //Objects for secondVC
    @IBOutlet weak var sVCanimatedFarmer: UIImageView!
    @IBOutlet weak var sVCanimationButton: UIButton!
    
    //Function for secondVC
    @IBAction func sVCstartAmination(_ sender: UIButton) {
        animateView(objectFarmer: sVCanimatedFarmer)
        createSpeechBubbleText(textForSpeech:"... und ich hab ein Bauernhof mit vielen Tieren: Kühen, Enten, Hasen usw.", nameOfImage: "speechBubble")
        animateView(objectFarmer: insertNewObject(name: "Sheep_body_happy_color", rec: CGRect(x: 750, y: 525, width: 160, height: 170)))
        
        animateView(objectFarmer: insertNewObject(name: "Cow_body_happy_color", rec: CGRect(x: 850, y: 480, width: 200, height: 250)))
        
        animateView(objectFarmer: insertNewObject(name: "Cat_body_happy_color", rec: CGRect(x: 495, y: 515, width: 120, height: 200)))
        
        animateView(objectFarmer: insertNewObject(name: "Chicken_body_happy_color", rec: CGRect(x: 660, y: 570, width: 140, height: 200)))
        
        animateView(objectFarmer: insertNewObject(name: "Rabbit_body_happy_color", rec: CGRect(x: 570, y: 570, width: 120, height: 200)))
    }
    
    //Objects for thirdVC
    @IBOutlet weak var thirdVCanimationButton: UIButton!
    @IBOutlet weak var thirdVCanimatedFood: UIImageView!
    @IBOutlet weak var thirdVCanimatedFeestar: UIImageView!
    
    //Function for thirdVC
    @IBAction func thirdVCstartAmination(_ sender: UIButton) {
        animateView(objectFarmer: thirdVCanimatedFood)
        animateView(objectFarmer: thirdVCanimatedFeestar)
        createSpeechBubbleText(textForSpeech:"... eines Tages kommt die Sternenfee zu Bauer Heinz. Sie hat ein Zauberfutter dabei. Sie sagt, dass ihr Zauberfutter Tiere glücklich macht.", nameOfImage: "speechBubble-eckig")
    }
    
    //Objects for fourthVC
    @IBOutlet weak var fourthVCanimatedFeemoon: UIImageView!
    @IBOutlet weak var fourthVCanimatedStart: UIButton!
    @IBOutlet weak var fourthVCanimatedFood: UIImageView!
    
    //Function for fourthVC
    @IBAction func fourthVCanimationStart(_ sender: UIButton) {
        animateView(objectFarmer: fourthVCanimatedFood)
        animateView(objectFarmer: fourthVCanimatedFeemoon)
        createSpeechBubbleText(textForSpeech:"... am gleichen Tag kommt auch die Mondfee. Auch sie hat ein Zauberfutter dabei und sagt, dass ihr Zauberfutter Tiere glücklich macht.", nameOfImage: "speechBubble-eckig")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /** Alternative Function to animateView -> without boolean
    func animateViewAlternative (objectFarmer:UIImageView){
        //let finishedAnim = checkImageViewInView(forImage: objectFarmer)
        UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            objectFarmer.frame.size.width += 30
            objectFarmer.frame.size.height += 30
        },completion: { (finished:Bool) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                objectFarmer.frame.size.width -= 30
                objectFarmer.frame.size.height -= 30
            }, completion: nil)
        })
        //during the animation-> the button is inactive
    }**/
    
        
    func animateView(objectFarmer:UIImageView){
        UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                objectFarmer.frame.size.width += 30
                objectFarmer.frame.size.height += 30
            }) { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                objectFarmer.frame.size.width -= 30
                objectFarmer.frame.size.height -= 30
            })
        }
    }
        
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
    
    func insertNewObject(name:NSString, rec:CGRect) -> UIImageView{
        let imageView = UIImageView(image: UIImage(named: name as String)!)
        imageView.frame = rec
        //doppeltes Anlegen von UIImageView vermeiden
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
