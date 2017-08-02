//
//  TableViewController.swift
//  Gacha
//
//  Created by nttr on 2017/07/14.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import AudioToolbox

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var fish_array : [String] = []
    var fish_array_ans : [String] = []
    var fish_hold : [Bool] = []
    var fishIndex = [["name1" : "鮪",
                      "name2" : "まぐろ",
                      "hold" : false,
                      "imageName" : "maguro.jpg"]]
    
    var count : Int = 0
    
    @IBOutlet var fishTableView : UITableView!
    @IBOutlet var label: UILabel!
    
    
    var fishimg = [UIImage(named: "maguro.jpg"),
                   UIImage(named: "iwashi.jpg"),
                   UIImage(named: "kuzira.jpg"),
                   UIImage(named: "ayu.jpg"),
                   UIImage(named: "azi.jpg"),
                   UIImage(named: "unagi.JPG"),
                   UIImage(named: "karei.jpg"),
                   UIImage(named: "kisu.jpg"),
                   UIImage(named: "kazika.JPG")
                     ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データソースメソッドをセルフに任せる
        fishTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(TableViewController.back))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Timer", style: .plain, target: self, action: #selector(TableViewController.gogo))
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .w, target: self, action: #selector(TableViewController.gogo))
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        //いろんなボタン
        
        for (index, bool) in fish_hold.enumerated(){
            if(bool){
                fish_array[index] = fish_array[index] + "    " + fish_array_ans[index]
                count = count+1
            }
            else{
                fish_array[index] = "???"
                fishimg[index] = nil
            }
            label.text = "正解数 : " + String(count)
        }
        
        title = "正解数 : " + String(count)
        
        //不要な線を消す
        fishTableView.tableFooterView = UIView()
        
        //デリゲードメソッドをselfに任せる
        fishTableView.delegate = self
        
        
        //カスタムセルの設定
        let nib = UINib(nibName: "FishTableViewCell", bundle: Bundle.main) //Table関連
        fishTableView.register(nib, forCellReuseIdentifier: "Cell") //Table関連
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func gogo() {
        self.performSegue(withIdentifier: "toTimer", sender: nil)
    }
    
    //1.個数決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fish_array.count //上位５個とかコントロールできまっせ
    }
    //2.セルに表示するデータ決め
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //idつけたcellの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FishTableViewCell //Table関連
        //cell.textLabel?.text = fish_array[indexPath.row]
        
        //表示内容を決める
        cell.fishImageView.image = fishimg[indexPath.row] //Table関連
        cell.fishLabel.text = fish_array[indexPath.row] //Table関連
        
        //let imageName = fishIndex[indexPath.row]["imageName"]
        //cell.fishImageView.image = UIImage(named : imageName! as! String) //Table関連
        //cell.fishLabel.text = fishIndex[indexPath.row]["name1"] as! String //Table関連
        
        return cell
    }
    
    @IBAction func onbutton(){
        var soundIdRing:SystemSoundID = 0
        if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "cursor7", ofType:"mp3")!) as NSURL?{
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)//ここに選択状態を解除　審査に落ちることも
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let dtaileViewController = segue.destination as! DetailViewController
            dtaileViewController.fish_array = fish_array
            dtaileViewController.fish_array_ans = fish_array_ans
            dtaileViewController.fish_hold = fish_hold
            
            let selectedIndex = fishTableView.indexPathForSelectedRow! //選ばれたセルは何行めか
            dtaileViewController.str = fish_array[selectedIndex.row]
            dtaileViewController.fishimg  = fishimg[selectedIndex.row]
        }
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
