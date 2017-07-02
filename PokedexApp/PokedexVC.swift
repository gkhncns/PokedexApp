//
//  PokedexVC.swift
//  PokedexApp
//
//  Created by Gokhan on 6/30/17.
//  Copyright © 2017 Gokhan Cansu. All rights reserved.
//

import UIKit
import AVFoundation

class PokedexVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var pokemonsCollection: UICollectionView!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    var pokemons: [Pokemon]!
    var fileteredPokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    var inSearchMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonsCollection.delegate = self
        pokemonsCollection.dataSource = self
        pokemonSearchBar.delegate = self
        
        pokemons = [Pokemon]()
        
        pokemonSearchBar.returnKeyType = .go
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    // MARK: - Functions
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(id: pokeId, name: name)
                pokemons.append(pokemon)
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            if inSearchMode == true {
                
                let pokemon = fileteredPokemons[indexPath.row]
                cell.configureCell(pokemon: pokemon)
            } else {
                
                let pokemon = pokemons[indexPath.row]
                cell.configureCell(pokemon: pokemon)
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Forward to related page
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode == true {
            return fileteredPokemons.count
        }
        
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 85, height: 85)
    }
    
    // MARK: - SearchBar Functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if pokemonSearchBar.text == nil || pokemonSearchBar.text == "" {
            
            inSearchMode = false
            pokemonsCollection.reloadData()
            
            view.endEditing(true)
        } else {
            
            inSearchMode = true
            
            let lower = pokemonSearchBar.text!.lowercased()
            
            fileteredPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            pokemonsCollection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    // MARK: - IBAction Functions
    
    @IBAction func musicButtonTapped(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }

}









