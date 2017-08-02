//
//  GachaController.swift
//  Gacha
//
//  Created by nttr on 2017/07/13.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox

class GachaController: UIViewController, UITextFieldDelegate{

    @IBOutlet var label : UILabel!
    @IBOutlet var label2 : UILabel!
    @IBOutlet var textbox : UITextField!
    var fish_array : [String] = ["鮪","鰯","鯨","鮎","鯵","鰻","鰈","鱚","鰍"]
    var fish_array_ans : [String] = ["まぐろ","いわし","くじら","あゆ","あじ","うなぎ","かれい","きす","かじか"]
    var fish_hold : [Bool] = [false,false,false,false,false,false,false,false,false]
    var ans : Int = 0
    
    var fishIndex = [["name1" : "鮪",
                      "name2" : "まぐろ",
                      "hold" : false,
                      "imageName" : "maguro.jpg"],
                     ["name1" : "鯨",
                      "name2" : "くじら",
                      "hold" : false,
                      "imageName" : "kuzira.jpg"]]
    
    //---タイマーに関して
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var rapButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    
    var startTime: TimeInterval? = nil // Double
    var timer: Timer?
    var elapsedTime: Double = 0.0
    //--------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // textFiel の情報を受け取るための delegate を設定
        textbox.delegate = self
        
        //ファイル読み込み
        let ud = UserDefaults.standard
        if let array = ud.array(forKey: "hold") as? [Bool] {
            fish_hold = array
        }
        
        sButton.isHidden = false
        // start: true, stop: false, reset: false　タイマー関連
        setButtonEnabled(start: true, rap: true)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        start()
    }
    
    //タイマー関連
    func setButtonEnabled(start: Bool, rap: Bool) {
        self.startButton.isEnabled = start
        self.rapButton.isEnabled = rap
    }
    func update() {
    // 2001/1/1 00:00:00
    //        print(Date.timeIntervalSinceReferenceDate)
    if let startTime = self.startTime {
    let t: Double = Date.timeIntervalSinceReferenceDate - startTime + self.elapsedTime
    //            print(t)
    let min = Int(t / 60)
    let sec = Int(t) % 60
    let msec = Int((t - Double(min * 60) - Double(sec)) * 100.0)
    self.timerLabel.text = String(format: "%02d:%02d:%02d", min, sec, msec)
    }
    }
    @IBAction func startTimer() {
        
        setButtonEnabled(start: false, rap: true)
        
        self.startTime = nil
        self.timerLabel.text = "00:00:00"
        self.elapsedTime = 0.0
        
        rapButton.isHidden = false
        startButton.isHidden = true
        
        self.startTime = Date.timeIntervalSinceReferenceDate
        self.timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(self.update),
            userInfo: nil,
            repeats: true)
    }
    @IBAction func rapTimer(_ sender: Any) {
        
        rapButton.isHidden = true
        startButton.isHidden = false
        
        // start: true, stop: false, reset: true
        setButtonEnabled(start: true, rap: false)
        
        if let startTime = self.startTime {
            self.elapsedTime += Date.timeIntervalSinceReferenceDate - startTime
        }
        
        startTime = nil
        self.timer?.invalidate()
        self.timer = nil
        
    }
    //---------------
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        label.text = textField.text
        
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start(){
        let number : Int = Int(arc4random_uniform(UInt32(fish_array.count)))
        ans = number
        label.text = fish_array[ans]
        textbox.text=""
        label2.text=""
        
        rapButton.isHidden = true
        startButton.isHidden = false
        
    }
    
    @IBAction func buttonStart(){
        sButton.isHidden = true
    }
    
    @IBAction func gogo(){
        if textbox.text == fish_array_ans[ans]{
            label2.text = "正解"
            fish_hold[ans]=true
            
            //UserDefaults保存
            let ud = UserDefaults.standard
            ud.set(fish_hold, forKey: "hold")
            ud.synchronize()
        
            var soundIdRing:SystemSoundID = 0
            if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "correct2", ofType:"mp3")!) as NSURL?{
                AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
                AudioServicesPlaySystemSound(soundIdRing)
            }
        }
        else{
            label2.text = "やり直し!!"
            var soundIdRing:SystemSoundID = 0
            if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "incorrect1", ofType:"mp3")!) as NSURL?{
                AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
                AudioServicesPlaySystemSound(soundIdRing)
            }
        }
    }
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func gacha(){
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "question1", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
        start()
        startTimer()
    }
    
    @IBAction func showAlert(){
        let alert = UIAlertController(title:"正解", message: "おめでとう", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default){ (action)
            in
            //okボタンを押した時のあくしょん
            alert.dismiss(animated: true, completion: nil)
        }
        let cancelaction = UIAlertAction(title: "NO", style: .default){ (action)
            in
            //キャンセルボタンを押した時アクション
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(cancelaction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "power" {
            let collectionController = segue.destination as! CollectionController
            collectionController.fish_array = fish_array
            collectionController.fish_array_ans = fish_array_ans
            collectionController.fish_hold = fish_hold
        }
        if segue.identifier == "table" {
            let tableViewController = (segue.destination as? UINavigationController)?.viewControllers.first as! TableViewController //navigation使った時に力技で回避
            
            tableViewController.fish_array = fish_array
            tableViewController.fish_array_ans = fish_array_ans
            tableViewController.fish_hold = fish_hold
            //tableViewController.fishIndex = fishIndex
        }
    }
    
    @IBAction func onbutton(){
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "cursor7", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
    }
    
}
