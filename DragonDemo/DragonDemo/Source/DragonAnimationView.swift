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
    var armatureLayer:ArmatureLayer?
    init?(withName armatureName:String, inBundle bundle:Bundle, frame:CGRect) {
        guard let path = bundle.path(forResource: armatureName, ofType: "json") else {
            return nil
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let json = JSON(data: jsonData)
        self.model = DragonModel(json)
        super.init(frame: frame)
        if let armatureData = self.model.armatures.first {
            let armatureLayer = ArmatureLayer(armatureData)
            self.armatureLayer = armatureLayer
            armatureLayer.frame = self.bounds;
            self.layer.addSublayer(armatureLayer)
        }
    }
    
    
    convenience init?(withName armatureName:String, frame:CGRect = CGRect.zero) {
        self.init(withName:armatureName, inBundle:Bundle.main, frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
