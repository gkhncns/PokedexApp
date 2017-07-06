//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Gokhan on 6/30/17.
//  Copyright © 2017 Gokhan Cansu. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _id: Int!
    private var _name: String!
    private var _description: String!
    private var _type: String!
    private var _defense: Int!
    private var _height: String!
    private var _weight: String!
    private var _attack: Int!
    private var _nextEvolution: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
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
    
    public var description: String {
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
    public var type: String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    public var defense: Int {
        if _defense == nil {
            _defense = 0
        }
        
        return _defense
    }
    
    public var height: String {
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    public var weight: String {
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    public var attack: Int {
        if _attack == nil {
            _attack = 0
        }
        
        return _attack
    }
    
    public var nextEvolution: String {
        if _nextEvolution == nil {
            _nextEvolution = ""
        }
        
        return _nextEvolution
    }
    
    public var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        
        return _nextEvolutionID
    }
    
    public var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        
        return _nextEvolutionLevel
    }
    
    init(id: Int, name: String) {
        _id = id
        _name = name
        
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.id)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = defense
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = attack
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for i in 1 ..< types.count {
                            
                            if let name = types[i]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    
                    self._type = ""
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String,String>], descriptions.count > 0 {
                    
                    if let url = descriptions[0]["resource_uri"] {
                        
                        let descURL = "\(BASE_URL)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDesc = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDesc
                                }
                            }
                            
                            completed()
                        })
                    }
                    
                } else {
                    
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolution = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    
                                    if let lvl = lvlExist as? Int {
                                        
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                    
                                } else {
                                    
                                    self._nextEvolutionLevel = ""
                                }
                                
                            }
                        }
                    }
                }
            }
            completed()
        }
 
    }

}
