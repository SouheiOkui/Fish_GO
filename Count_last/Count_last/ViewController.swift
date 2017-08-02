//
//  ViewController.swift
//  Count_last
//
//  Created by nttr on 2017/08/02.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var labe : UILabel!
    
    var count : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tasu(){
        count=count+1
        labe.text = String(count)
    }
    @IBAction func hiku(){
        count=count-1
        labe.text = String(count)
    }
    @IBAction func ccc(){
        count=0
        labe.text = String(count)
    }
    @IBAction func nijou(){
        count=count*count
        labe.text = String(count)
    }

}

