//
//  Reporting.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 27/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class Reporting: NSObject {

    var total: Int?
    var loss: Double?
    var gain: Double?
    var pair: String?
    
    override init() {
        
    }
    
    init(total: Int, loss: Double, gain: Double, pair:String) {
        
        self.total = total
        self.loss = loss
        self.gain = gain
        self.pair = pair
    }
    
    
    override var description: String {
        return "gain : \(gain), loss : \(loss)"
    }
}
