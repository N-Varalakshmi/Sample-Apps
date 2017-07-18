//
//  ViewController.swift
//  FeedMonkey
//
//  Created by varalakshmi n on 05/10/16.
//  Copyright © 2016 varalakshmi n. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    open var foodImgView, userImgView : UIImageView?
    var foodImages : [String]?
    var foodIndex : Int = 0
    var eatenFoodCount : Int = 0
    
    @IBOutlet weak var chooseFood: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userView = UIImageView.init(frame:CGRect.init(x: 150, y: 50, width: 100, height: 100))
        userView.image = UIImage.init(named:"Monkey")
        userView.backgroundColor = UIColor.blue
        self.view.addSubview(userView)
        userImgView = userView
        
        foodImages = ["Banana","Apple","Chilli","Grape","Cake","Ice","Orange","Chocalate"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dragged(gesture : UIGestureRecognizer) -> () {
        
        var userImg = ""
        if eatenFoodCount == 6 {
            userImg = "Full"
            eatenFoodCount = 0
            foodImgView?.removeGestureRecognizer((foodImgView?.gestureRecognizers?.first)!)
            chooseFood.setTitle("Reset Game", for: UIControlState.normal)
        }
        else {
            let point : CGPoint = gesture.location(in: self.view)
            foodImgView?.center = point
            
            if (userImgView?.frame.contains(point))!{
                if let fImagView = foodImgView {
                    fImagView.removeFromSuperview()
                    foodImgView = nil
                }
            }
            
            switch foodIndex {
            case 0,1,3,6:
                userImg = "Monkey"
                break
            default:
                userImg = "sad monkey"
            }
        }
        
        userImgView?.image = UIImage.init(named:userImg)
    }
    
    @IBAction func GenerateFood(_ sender: AnyObject) {
        
        if  (sender as? UIButton)?.title(for: UIControlState.normal) == "Reset Game" {
            userImgView?.image = UIImage.init(named:"Monkey")
            chooseFood.setTitle(nil, for: UIControlState.normal)
            chooseFood.setTitle("Choose Food", for: UIControlState.normal)
            foodImgView?.removeFromSuperview()
            foodImgView = nil
        } else {
            
            if let fImagView = foodImgView {
                fImagView.removeFromSuperview()
            } else {
                eatenFoodCount += 1
            }
            
            if let images = foodImages {
                //generate random no
                let index = Int(arc4random_uniform(UInt32(images.count)))
                
                //add food to view
                self.addFoodImage(withImage:images[index]);
                
                foodIndex = index
            }
        }
    }
    
    func addFoodImage(withImage : String) -> (){
        let foodView = UIImageView.init(frame:CGRect.init(x: 150, y: 300, width: 100, height: 100))
        foodView.image = UIImage.init(named:withImage)
        foodView.backgroundColor = UIColor.red
        foodView.isUserInteractionEnabled = true;
        self.view.addSubview(foodView)
        
        let panRecognizer : UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action:#selector(dragged(gesture:)))
            
        foodView.addGestureRecognizer(panRecognizer)
        foodImgView = foodView
    }
}

