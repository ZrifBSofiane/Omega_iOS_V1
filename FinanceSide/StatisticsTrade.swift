//
//  StatisticsTrade.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 27/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class StatisticsTrade: NSObject {
    
    
    var loss: Double?
    var gain: Double?
    
    override init() {
        
    }
    
    init(loss: Double, gain: Double) {
        self.loss = loss
        self.gain = gain
    }
    
    
    override var description: String {
         return "gain : \(gain), loss : \(loss)"
    }
}
