//
//  DetailViewController.swift
//  Gacha
//
//  Created by nttr on 2017/07/19.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var fish_array : [String] = []
    var fish_array_ans : [String] = []
    var fish_hold : [Bool] = []
    var str : String = ""
    
    var fishimg : UIImage!

    @IBOutlet var label : UILabel!
    @IBOutlet var img : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = str
        img.image = fishimg
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
