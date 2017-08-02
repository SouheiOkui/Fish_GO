//
//  ViewController.swift
//  AnimationSample
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var sampleImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapDisplay() {
        UIView.animate(withDuration: 0.6, animations: {
            self.sampleImageView.frame = CGRect(x: self.sampleImageView.frame.origin.x, y: self.sampleImageView.center.y - 300, width: self.sampleImageView.bounds.width, height: self.sampleImageView.bounds.width)
        }) { (finished) in
            UIView.animate(withDuration: 2.0, animations: { 
                self.sampleImageView.backgroundColor = UIColor.white
            }, completion: { (finished) in
                self.performSegue(withIdentifier: "toNext", sender: nil)
            })
        }
        
    }


}

