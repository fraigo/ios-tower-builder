//
//  ViewController.swift
//  ios-tower-builder
//
//  Created by Francisco on 2018-10-03.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit


extension CGFloat {
    func toPixels(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGFloat {
        let scale: CGFloat = 1.0 / UIScreen.main.scale
        return CGFloat(scale * (self / scale).rounded(rule))
    }
}


extension UIView {
    var  startX : CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    var  yPos : CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    var  finalX : CGFloat {
        get {
            return self.frame.origin.x + self.frame.width
        }
    }
}


class ViewController: UIViewController {
    
    var stopped = false
    var currentBar = UIView()
    var lastBar = UIView()
    var height : CGFloat = 0
    var width : CGFloat = 0
    var viewWidth : CGFloat = 0
    var viewHeight : CGFloat = 0
    var yPos : CGFloat = 0
    var xPos : CGFloat = 0
    var xIncr : CGFloat = 2.0
    var maxBars : CGFloat = 20.0
    
    @IBOutlet var myView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.viewClick))
        view.addGestureRecognizer(gesture)
        
        let screenSize = view.bounds
        
        
        viewWidth = screenSize.width.toPixels()
        viewHeight = screenSize.height.toPixels()
        height = viewHeight / maxBars
        width = viewWidth / 2
        yPos = height * ( maxBars - 3 )
        currentBar = UIView(frame: CGRect(x: 0, y: yPos + height, width: viewWidth, height: height*2))
        currentBar.backgroundColor = UIColor.black
        view.addSubview(currentBar)
        newBar()
    }
    
    func newBar(){
        lastBar = currentBar
        currentBar = UIView(frame: CGRect(x: xPos, y: yPos, width: width, height: height))
        currentBar.backgroundColor = UIColor.blue
        view.addSubview(currentBar)
        stopped = false
        moveBar()
    }
    
    func moveBar(){
        
        if (currentBar.frame.origin.x + currentBar.frame.width > viewWidth){
            xIncr = xIncr * -1
        }
        if (currentBar.frame.origin.x < 0){
            xIncr = xIncr * -1
        }
        currentBar.frame.origin.x += xIncr
        if (!stopped){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                self.moveBar()
            }
        }
        
    }
    
    @objc func viewClick(){
        stopBar();
    }
    
    func stopBar(){
        stopped = true
        let maxLeft  = max(currentBar.startX, lastBar.startX)
        let minRight = min(self.currentBar.finalX , self.lastBar.finalX)
        NSLog("Putting from \(self.currentBar.frame.origin.x) to \(maxLeft) ")
        self.currentBar.frame.origin.x = maxLeft
        self.currentBar.frame.size.width = minRight - maxLeft
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.yPos -= self.height
            self.newBar()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

