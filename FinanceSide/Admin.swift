//
//  Admin.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 26/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class Admin: NSObject {
    
    var id: Int?
    var username: String?
    var password: String?
    
    override init() {
        
    }
    
    init(id: Int, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    
    override var description: String {
        return "Id : \(id), Username : \(username), Password : \(password)"
    }
    
    
    

}
