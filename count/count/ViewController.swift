//
//  ViewController.swift
//  count
//
//  Created by nttr on 2017/07/12.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //データの宣言
    @IBOutlet var label : UILabel!
    @IBOutlet var label2 : UILabel!
    @IBOutlet var back_photo : UIImageView!
    
    var array : [String] = ["a","b","c"]
    
    var number: Double = 0 {
        didSet {
            if number>99 {
                label.textColor=UIColor.yellow
                label2.textColor=UIColor.white
                back_photo.image = UIImage(named: "2043216i.jpeg")
            }
            else if number>9 {
                label.textColor=UIColor.red
                label2.textColor=UIColor.black
                back_photo.image = UIImage(named: "43a3408c2672eeec38cf3a68128a41d3.png")
            }
            else{
                label.textColor=UIColor.black
                label2.textColor=UIColor.black
                back_photo.image = UIImage(named: "3095248i.jpeg")
            }
        }
    }

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
        print(number)
        //
        label.text = String(number)
        
    }
    @IBAction func mainasu(){
        number=number-1
        //
        label.text = String(number)
    }
    @IBAction func clear(){
        number=0
        //
        label.text = String(number)
    }
    @IBAction func kake2(){
        number=number*2
        //
        label.text = String(number)
    }
    @IBAction func waru2(){
        number=number/2
        //
        label.text = String(number)
    }
    @IBAction func ransu(){
        number=Double(arc4random_uniform(100))
        //
        label.text = String(number)
    }
    @IBAction func menu(){
        if number == 0{
            self.performSegue(withIdentifier: "tomenue", sender: nil)
        }
    }
    
    func changeBack(number: Int) -> Int {
        //ifß
        for name in array{
            if name == "b"{
                print("bingo")
        }
        return 0
    }
}
