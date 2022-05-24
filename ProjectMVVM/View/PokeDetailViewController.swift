//
//  PokeDetailViewController.swift
//  ProjectMVVM
//
//  Created by Carlos Enrique Gallardo Ambrosio on 23/05/22.
//

import UIKit

class PokeDetailViewController: UIViewController {

    var url: String = ""
    var pokemon: PokeDetail? = nil
    @IBOutlet weak var lblNamePokemon: UILabel!
    let pokeViewModel: PokeViewModel = PokeViewModel()
    
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await setUpView()
        }
    }
    func setUpView() async {
        await pokeViewModel.getPokeDetail(url: url)
        pokemon = pokeViewModel.pokemon
        setUpPokeData()
    }
    func setUpPokeData() {
        view.backgroundColor = PokeTypes.types[(pokemon?.types[0].type.name)!]
        lblNamePokemon.text = pokemon?.name.capitalized
        lblType.text = pokemon?.types[0].type.name.capitalized ?? ""
        imagePokemon.image = HelperImage.setImageFromUrl(url: (pokemon?.sprites.other.officialArtwork.front_default)!)
    }
}
