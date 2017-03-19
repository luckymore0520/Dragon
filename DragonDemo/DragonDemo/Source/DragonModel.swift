//
//  DragonModel.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/19.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DragonModel {
    let name: String
    let frameRate: Int
    let version: String
    let armatures: [Armature]
    
    init(_ json:JSON) {
        self.name = json["name"].stringValue
        self.frameRate = json["frameRate"].int ?? 24
        self.version = json["version"].stringValue
        let armaturesJson = json["armature"].arrayValue
        self.armatures = armaturesJson.map { (json:JSON) -> Armature in
                Armature(json)
        }
    }
}

struct Armature {
    let name: String
    let bones: [Bone]
    let slots: [Slot]
    
    init(_ json: JSON) {
        self.name = json["name"].stringValue
        let slotsJson = json["slot"].arrayValue
        self.slots = slotsJson.map { (json:JSON) -> Slot in
            Slot(json)
        }
        let skinJson = json["skin"].dictionaryValue
        let slotInSkinJson = skinJson["slot"]?.arrayValue ?? []
        for slotJson in slotInSkinJson {
            let name = slotJson["name"].stringValue
            var targetSlot:Slot?
            for slot in self.slots {
                if (slot.name == name) {
                    targetSlot = slot
                    break
                }
            }
            if targetSlot != nil {
                let displayArrayJson = slotJson["display"].arrayValue
                targetSlot?.displays = displayArrayJson.map({ (json:JSON) -> Display in
                    Display(json)
                })
            }
        }
        let bonesJson = json["bone"].arrayValue
        self.bones = bonesJson.map({ (json:JSON) -> Bone in
            Bone(json)
        })
    }
}

struct Bone {
    let level:Int = 0
    let name:String
    let parent:String
    let transform:Transform
    let global:Transform
    init(_ json:JSON) {
        self.name = json["name"].stringValue
        self.parent = json["parent"].stringValue
        self.transform = Transform(json["transform"])
        self.global = self.transform
    }
}

struct Slot {
    let name: String
    let parent: String
    let displayIndex: Int
    let zOrder: Int
    var displays:[Display] = []
    init(name:String) {
        self.name = name
        self.parent = ""
        self.displayIndex = 0
        self.zOrder = 0
    }
    
    
    init(_ json:JSON) {
        self.name = json["name"].stringValue
        self.parent = json["parent"].stringValue
        self.displayIndex = json["displayIndex"].int ?? 0
        self.zOrder = json["z"].int ?? 0
    }
}

struct Display {
    var transform: Transform
    var pivot: Point?
    let name: String
    
    init(_ json:JSON) {
        self.transform = Transform(json["transform"])
        self.name = json["name"].stringValue
    }
}

struct Transform {
    let x: Float
    let y: Float
    let skewX: Float
    let skewY: Float
    let scaleX: Float
    let scaleY: Float
    
    init(_ json:JSON) {
        self.x = json["x"].float ?? 0
        self.y = json["y"].float ?? 0
        self.scaleX = json["scX"].float ?? 1
        self.scaleY = json["scY"].float ?? 1
        self.skewX = (json["skX"].float ?? 0) / 180.0 * Float(M_PI)
        self.skewY = (json["skY"].float ?? 0) / 180.0 * Float(M_PI)
    }
}

struct Point {
    
}
