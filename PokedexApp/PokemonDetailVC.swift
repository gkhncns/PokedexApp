//
//  PokemonDetailVC.swift
//  PokedexApp
//
//  Created by Gokhan on 7/3/17.
//  Copyright © 2017 Gokhan Cansu. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = pokemon.name
    }

}
