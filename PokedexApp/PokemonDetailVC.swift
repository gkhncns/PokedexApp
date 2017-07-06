//
//  PokemonDetailVC.swift
//  PokedexApp
//
//  Created by Gokhan on 7/3/17.
//  Copyright © 2017 Gokhan Cansu. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonNameLabel.text = pokemon.name.capitalized
        
        pokemon.downloadPokemonDetails {
            
            // Whatever we write here will only be called after the network call is complete!
            self.updateUI()
        }
    }
    
    // MARK: - Functions
    
    func updateUI() {
        baseAttackLabel.text = "\(pokemon.attack)"
        defenseLabel.text = "\(pokemon.defense)"
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexIdLabel.text = "\(pokemon.id)"
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        mainImage.image = UIImage(named: "\(pokemon.id)")
        currentEvoImage.image = UIImage(named: "\(pokemon.id)")
        
        if pokemon.id == 0 {
            
            evoLabel.text = "No Evolutions"
            nextEvoImage.isHidden = true
            
        } else {
            
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionID)
            
            let str = "Next Evolution: \(pokemon.nextEvolution) - LVL \(pokemon.nextEvolutionLevel)"
            evoLabel.text = str
        }

    }
    
    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
