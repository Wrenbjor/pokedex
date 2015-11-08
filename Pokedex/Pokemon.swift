//
//  Pokemon.swift
//  Pokedex
//
//  Created by Wayne Renbjor on 11/6/15.
//  Copyright © 2015 WCRStudios. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokeDexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoId: String!
    private var _nextEvoName: String!
    private var _nextEvoLvl: String!
    private var _pokemonURL: String!
    
    var name: String {
        get {
            if _name == nil {
                return ""
            }
            return _name
        }
        
    }
    
    var pokeDexId: Int {
        get {
            if _pokeDexId == nil {
                _pokeDexId = 0
            }
            return _pokeDexId
        }
    }
    
    var weight: String {
        get {
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }
    
    var height: String {
        get {
            if _height == nil {
                _height = ""
            }
            return _height
        }
    }
    
    var attack: String {
        get {
            if _attack == nil {
                _attack = ""
            }
            return _attack
        }
    }
    
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            return _description
        }
    }
    
    var defense: String {
        get {
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }
    
    var type: String {
        get {
            if _type == nil {
                _type = ""
            }
            return _type
        }
    }
    
    var nextEvolutionName: String {
        get {
            if _nextEvoName == nil {
                _nextEvoName = ""
            }
            return _nextEvoName
        }
        
    }
    
    var nextEvolutionId: String {
        get {
            if _nextEvoId == nil {
                _nextEvoId = ""
            }
            return _nextEvoId
        }
    }
    
    var nextEvolutionLevel: String {
        get {
            if _nextEvoLvl == nil {
                _nextEvoLvl = ""
            }
            return _nextEvoLvl
        }
    }
    
    init(name: String, pokeDexId: Int) {
        self._name = name
        self._pokeDexId = pokeDexId
        
        self._pokemonURL = "\(BASE_URL)\(API_URL)\(POKEMON_URL)\(self._pokeDexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: self._pokemonURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>]  where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    } else {
                        self._type = ""
                    }
                }
                
                if let desc = dict["descriptions"] as? [Dictionary<String, String>] where desc.count > 0 {
                    if let url = desc[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(BASE_URL)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            
                            let descResult = response.result
                            if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    self._description = description
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                if let level = evolutions[0]["level"] as? Int {
                                    self._nextEvoLvl = "\(level)"
                                }
                                
                                self._nextEvoId = num
                                self._nextEvoName = to
                            }
                        }
                    }
                }
            }
        }
    }
}