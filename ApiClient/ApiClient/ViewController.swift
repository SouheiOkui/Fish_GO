//
//  ViewController.swift
//  ApiClient
//
//  Created by nttr on 2017/07/21.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // API取得の開始処理
    func getData() {
        let URL = NSURL(string: "http://express.heartrails.com/api/json?method=getPrefectures")
        let req = NSURLRequest(URL: URL)
        let connection: NSURLConnection = NSURLConnection(request: req, delegate: self, startImmediately: false)
        
        // NSURLConnectionを使ってAPIを取得する
        NSURLConnection.sendAsynchronousRequest(req,
                                                queue: NSOperationQueue.mainQueue(),
                                                completionHandler: response)
    }
    
    // 取得したAPIデータの処理
    func response(res: NSURLResponse!, data: NSData!, error: NSError!){
        
        println(data)
        
    }

}

