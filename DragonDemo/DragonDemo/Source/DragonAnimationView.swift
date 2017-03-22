//
//  DragonAnimationView.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/19.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit
import SwiftyJSON


class DragonAnimationView: UIView {
    let model:DragonModel
    init?(withName armatureName:String, inBundle bundle:Bundle) {
        guard let path = bundle.path(forResource: armatureName, ofType: "json") else {
            return nil
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let json = JSON(data: jsonData)
        self.model = DragonModel(json)
        super.init(frame: CGRect.zero)
    }
    
    
    convenience init?(withName armatureName:String) {
        self.init(withName:armatureName, inBundle:Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
