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
