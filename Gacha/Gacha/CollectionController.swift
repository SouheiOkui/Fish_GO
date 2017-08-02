//
//  CollectionController.swift
//  Gacha
//
//  Created by nttr on 2017/07/13.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class CollectionController: UIViewController {
    
    var fish_array : [String] = []
    var fish_array_ans : [String] = []
    var fish_hold : [Bool] = []
    
    var labels: [UILabel] = []
    var labelsh: [UILabel] = []
    
    var count: Int = 0
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    
    @IBOutlet var label1h: UILabel!
    @IBOutlet var label2h: UILabel!
    @IBOutlet var label3h: UILabel!
    @IBOutlet var label4h: UILabel!
    @IBOutlet var label5h: UILabel!
    @IBOutlet var label6h: UILabel!
    @IBOutlet var label7h: UILabel!
    @IBOutlet var label8h: UILabel!
    @IBOutlet var label9h: UILabel!
    
    @IBOutlet var labelComent: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        labels = [label1, label2, label3, label4, label5, label6, label7, label8, label9]
        labelsh = [label1h, label2h, label3h, label4h, label5h, label6h, label7h, label8h, label9h]
        for (index, bool) in fish_hold.enumerated() {
            if(bool){
                labels[index].text = fish_array[index]
                labelsh[index].text = fish_array_ans[index]
                count=count+1
            }
            else{
                labels[index].text = "?"
                labelsh[index].text = "?"
            }
        }
        if count > 3{
            labelComent.text = "頑張れ"
        }
        if count > 6{
            labelComent.text = "もうちょっと"
        }
        if count > 8{
            labelComent.text = "完璧"
        }
        
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
