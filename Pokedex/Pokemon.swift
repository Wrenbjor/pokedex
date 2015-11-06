//
//  Pokemon.swift
//  Pokedex
//
//  Created by Wayne Renbjor on 11/6/15.
//  Copyright © 2015 WCRStudios. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokeDexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokeDexId: Int {
        return _pokeDexId
    }
    
    init(name: String, pokeDexId: Int) {
        self._name = name
        self._pokeDexId = pokeDexId
    }
}