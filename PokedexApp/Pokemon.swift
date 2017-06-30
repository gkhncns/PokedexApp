//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Gokhan on 6/30/17.
//  Copyright © 2017 Gokhan Cansu. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _id: Int!
    private var _name: String!
    
    public var id: Int {
        if _id == nil {
            _id = 0
        }
        
        return _id
    }
    
    public var name: String {
        if _name == nil {
            _name = ""
        }
        
        return _name
    }
    
    init(id: Int, name: String) {
        _id = id
        _name = name
    }
}
