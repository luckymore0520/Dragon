//
//  DisplayLayer.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/22.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit

class DisplayLayer: CALayer {
    let data:DisplayData
    
    init(_ data:DisplayData) {
        self.data = data
        super.init()
        let imagePath = data.name.components(separatedBy: "/").last ?? "" + ".png"
        let image = UIImage(named: imagePath)
        self.bounds = CGRect(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
        self.contents = image?.cgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
