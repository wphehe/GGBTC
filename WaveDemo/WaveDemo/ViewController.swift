//
//  ViewController.swift
//  WaveDemo
//
//  Created by wangpeng on 2020/4/1.
//  Copyright © 2020 wangpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var waveView: WaveView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       self.waveView = WaveView(frame: CGRect.init(x:100, y:200,width: 130,height: 130))
        self.view.addSubview(self.waveView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        waveView?.startDisplayLink()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        waveView?.stopDisplayLink()
    }

}

