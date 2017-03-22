//
//  AnimationModel.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/20.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Animation {
    let name:String
    let duration:Int
    var boneTimelines:[Timeline] = []
    var slotTimelines:[Timeline] = []
    
    init(_ json:JSON) {
        self.name = json["name"].stringValue
        self.duration = json["duration"].int ?? 0
        let boneTimelinesJson = json["bone"].arrayValue
        for boneTimelineJson in boneTimelinesJson {
            if let boneTimeline = Timeline(boneTimelineJson) {
                self.boneTimelines.append(boneTimeline)
            }
        }
        let slotTimelinesJson = json["slot"].arrayValue
        for slotTimelineJson in slotTimelinesJson {
            if let slotTimeline = Timeline(slotTimelineJson) {
                self.slotTimelines.append(slotTimeline)
            }
        }
        
    }

}

//A timeline correspond to the animation of a bone or a slot
//just like the timeline when designing the animation
//A Timeline has many key frames which decide the whole animation
struct Timeline {
    let name:String
    var duration:Int = 0
    var frames:[Frame] = []
    init?(_ json:JSON) {
        let framesJson = json["frame"].arrayValue
        if (framesJson.isEmpty) {
            return nil
        }
        for frameJson in framesJson {
            let frame = Frame(frameJson, startAt:self.duration)
            frames.append(frame)
            self.duration += frame.duration
        }
        self.name = json["name"].stringValue
    }
}


struct Frame {
    let duration:Int
    let position:Int  //startTime
    let displayIndex:Int
    let tweenEasing:Bool
    let transform:Transform
    let alpha:Float
    init(_ json:JSON, startAt start:Int){
        self.duration = json["duration"].int ?? 0
        self.position = start
        self.transform = Transform(json["transform"])
        self.tweenEasing = json["tweenEasing"].int == 0 ? true : false
        self.displayIndex = json["displayIndex"].int ?? 0
        self.alpha = (json["color"]["aM"].float ?? 100.0) * 0.01
    }
}

struct Transform {
    let x: CGFloat
    let y: CGFloat
    let skewX: CGFloat
    let skewY: CGFloat
    let scaleX: CGFloat
    let scaleY: CGFloat
    
    init() {
        self.x = 0
        self.y = 0
        self.skewX = 0
        self.skewY = 0
        self.scaleX = 0
        self.scaleY = 0
    }
    
    
    init(_ json:JSON) {
        self.x = CGFloat(json["x"].float ?? 0)
        self.y = CGFloat(json["y"].float ?? 0)
        self.scaleX = CGFloat(json["scX"].float ?? 1)
        self.scaleY = CGFloat(json["scY"].float ?? 1)
        self.skewX = CGFloat((json["skX"].float ?? 0) / 180.0 * Float(M_PI))
        self.skewY = CGFloat((json["skY"].float ?? 0) / 180.0 * Float(M_PI))
    }
}

extension CGAffineTransform {
 

    init(withTransform transform:Transform) {
        self.a = transform.scaleX * cos(transform.skewY)
        self.b = transform.scaleX * sin(transform.skewY)
        self.c = -transform.scaleY * sin(transform.skewX)
        self.d = transform.scaleY * cos(transform.skewX)
        self.tx = transform.x
        self.ty = transform.y
    }

   
    init(withMatrix first:CGAffineTransform, contactWith another:CGAffineTransform) {
        if (another.a != 1 || another.b != 0 || another.c != 0 || another.d != 1) {
            self.a = first.a * another.a + first.b * another.c
            self.b = first.a * another.b + first.b * another.d
            self.c = first.c * another.a + first.d * another.c
            self.d = first.c * another.b + first.d * another.d
        } else {
            self.a = first.a
            self.b = first.b
            self.c = first.c
            self.d = first.d
        }
        self.tx = first.tx * another.a + first.ty * another.c + another.tx
        self.ty = first.tx * another.b + first.ty * another.d + another.ty
    }


}
