//
//  SlotLayer.swift
//  DragonDemo
//
//  Created by WangKun on 2017/3/22.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit

class SlotLayer: CALayer {
    let slotName:String
    let displayLayers:[DisplayLayer]
    let defaultDesplayLayer:Int
    
    var parent:Bone?
    var displayNode:DisplayLayer? //The layer should display
    var displayIndex:Int = -1
    var matrix:CGAffineTransform?
    
    var origin:Transform?
    
    init(_ data:SlotData) {
        self.slotName = data.name
        self.displayLayers = data.displays.map{DisplayLayer($0)}
        self.defaultDesplayLayer = data.displayIndex
        super.init()
        changeDisplay(toIndex: data.displayIndex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeDisplay(toIndex index:Int)  {
        if (index == self.displayIndex) {
            return
        }
        self.displayIndex = index
        
        self.displayNode?.removeFromSuperlayer()
        if (index >= 0 && index < self.displayLayers.count) {
            let displayNode = self.displayLayers[index]
            let displayData = displayNode.data
            self.origin = displayData.transform
            
            self.addSublayer(displayNode)
            
            
            
            self.displayNode = displayNode
            self.updateLayer()
        }
    }
    
    func updateLayer(){
        if (self.parent?.updateSemaphore ?? -1 <= 0) {
            return
        }
        guard let origin = self.origin,
            let parentMatrix = self.parent?.matrix,
            let displayNode = self.displayNode else {
            return
        }
        let originMatrix = CGAffineTransform(withTransform: origin)
        let matrix = CGAffineTransform(withMatrix: originMatrix, contactWith: parentMatrix)
        self.matrix = matrix
        var transform = matrix
        transform.tx = 0
        transform.ty = 0
        
        
        displayNode.setAffineTransform(transform)
        displayNode.position = CGPoint(x: matrix.tx, y: matrix.ty)
        
    }
    
    
    
}
