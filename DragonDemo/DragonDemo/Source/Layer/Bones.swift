//
//  Bones.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/22.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import Foundation
import UIKit
// A Bone should be a class
// Because a bone is usally a parent of a slot or another bone
// The animation of the bone may affect the aniamtion of its children
class Bone {
    let name:String
    let parentName:String?
    let origin:Transform
    
    var tween:Transform
    var updateSemaphore:Int = 2
    var parent:Bone?
    var matrix:CGAffineTransform?
    
    init(_ data:BoneData) {
        self.name = data.name
        self.parentName = data.parent
        self.origin = data.transform
        self.tween = Transform()
    }
    
    func updateBones() {
        if (self.updateSemaphore > 0) {
            self.updateSemaphore -= 1
        }
        if (self.updateSemaphore <= 0) {
            return
        }
        
        let transform = Transform(x: self.origin.x + self.tween.x,
                                  y: self.origin.y + self.tween.y,
                                  skewX: self.origin.skewX + self.tween.skewX,
                                  skewY: self.origin.skewY + self.tween.skewY,
                                  scaleX: self.origin.scaleX * self.tween.scaleX,
                                  scaleY: self.origin.scaleY * self.tween.scaleY)
        let matrix = CGAffineTransform(withTransform: transform)
        if let parent = self.parent, let parentMatrix = parent.matrix {
            self.matrix = CGAffineTransform(withMatrix: matrix, contactWith: parentMatrix)
        } else {
            self.matrix = matrix
        }
    }
    

}
