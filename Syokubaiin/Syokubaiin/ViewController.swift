//
//  ViewController.swift
//  Syokubaiin
//
//  Created by nttr on 2017/08/01.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label : UILabel!
    var number : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answer3(){
        number = Int(arc4random_uniform(100))
        label.text = String(number)
    }
    


}

