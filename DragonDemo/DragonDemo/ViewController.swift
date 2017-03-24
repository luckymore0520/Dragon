//
//  ViewController.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/19.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var animationView:DragonAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let animationView = DragonAnimationView(withName: "Dragon_ske", frame:self.view.bounds) {
            self.view.addSubview(animationView)
            self.animationView = animationView
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

