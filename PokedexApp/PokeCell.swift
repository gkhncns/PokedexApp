//
//  PokeCell.swift
//  PokedexApp
//
//  Created by Gokhan on 6/30/17.
//  Copyright © 2017 Gokhan Cansu. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        thumbImg.image = UIImage(named: "\(self.pokemon.id)")
        nameLbl.text = self.pokemon.name.capitalized
    }
    
}
