//
//  PokeCell.swift
//  Pokedex
//
//  Created by Wayne Renbjor on 11/6/15.
//  Copyright © 2015 WCRStudios. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 15.0
        
    }
    
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokeName.text = self.pokemon.name.capitalizedString
        pokeImage.image = UIImage(named: "\(self.pokemon.pokeDexId)")
        
    }
}
