//
//  ViewController.swift
//  TimeAtack
//
//  Created by nttr on 2017/07/13.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var number : Int = 0 {
        didSet {
            if number>19 {
                label.textColor=UIColor.blue
            }
            else if number>9 {
                label.textColor=UIColor.red
            }
            else{
                label.textColor=UIColor.black
            }
        }
    }
    
    
    @IBOutlet var label : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func plus(){
        number=number+1
        label.text=String(number)
    }
    
    @IBAction func minus(){
        number=number-1
        label.text=String(number)
    }
    @IBAction func crear(){
        number=0
        label.text=String(number)
    }
    
}

