//
//  ArmatureLayer.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/22.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit


class ArmatureLayer: CALayer {
    var bones:[String:Bone] = [:]
    var slots:[String:SlotLayer] = [:]
    init(_ data:ArmatureData){
        super.init()
        for boneData in data.bones {
            bones[boneData.name] = Bone(boneData)
        }
        for (_,bone) in bones {
            bone.parent = bones[bone.parentName ?? ""]
        }
        for slotData in data.slots {
            let slotLayer = SlotLayer(slotData)
            slots[slotData.name] = slotLayer
            slotLayer.parent = self.bones[slotData.parent]
            self.addSublayer(slotLayer)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
