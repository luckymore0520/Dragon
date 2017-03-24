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
        self.advanceTime(passedTime: 0)
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        for (_,slot) in slots {
            slot.frame = CGRect(x: self.position.x, y: self.position.y, width: self.bounds.width, height: self.bounds.height)
        }
    }
    
    func advanceTime(passedTime:TimeInterval){
        //考虑animation
        for (_,bone) in bones {
            bone.updateBones()
        }
        for (_,slot) in slots {
            slot.updateLayer()
        }
    }
    
//    
//    - (void)advanceTime:(float)passedTime
//    {
//    if (self.animation){
//    [self.animation advanceTime:passedTime];
//    }
//    
//    for( Bone* bone in self.bones){
//    [bone update:NO];
//    }
//    for (Slot* slot in self.slots){
//    [slot update:NO];
//    }
//    }
//    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
