//
//  ViewController.swift
//  Gacha
//
//  Created by nttr on 2017/07/13.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onclick(){
        
        print("test1")
        
        /*var soundIdRing:SystemSoundID = 1022
        if let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), nil, nil, nil){
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
            print("test2")
        }*/
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "mens-ou1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
    }


}

