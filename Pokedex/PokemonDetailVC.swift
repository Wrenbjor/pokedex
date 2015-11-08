//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Wayne Renbjor on 11/7/15.
//  Copyright © 2015 WCRStudios. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var pokedexId: UILabel!
    @IBOutlet weak var baseAttack: UILabel!

    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var evoImg1: UIImageView!
    @IBOutlet weak var evoImg2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokeDexId)")
        mainImage.image = img
        evoImg1.hidden = false
        evoImg1.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }

    func updateUI() {
        descriptionLbl.text = pokemon.description
        defenceLbl.text = pokemon.defense
        height.text = pokemon.height
        weight.text = pokemon.weight
        pokedexId.text = "\(pokemon.pokeDexId)"
        baseAttack.text = pokemon.attack
        
        if pokemon.type == "" {
            typeLbl.text = "None"
        } else {
            typeLbl.text = pokemon.type
        }
        
        if pokemon.nextEvolutionId == "" {
            evolutionLbl.text = "No Evolutions"
            evoImg2.hidden = true
        } else {
            evoImg2.hidden = false
            evoImg2.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionName)"
            
            if pokemon.nextEvolutionLevel != "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            evolutionLbl.text = str
        }
        
        
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
