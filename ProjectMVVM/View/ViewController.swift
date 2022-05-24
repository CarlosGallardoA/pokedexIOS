//
//  ViewController.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 22/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    let pokeViewModel: PokeViewModel = PokeViewModel()
    //creamos un array de filtro
    
    var filterData: [Result] = []
    var urlToDetail: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            await setUpData()
        }
        setUpView()
        
    }
    func setUpView() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.backButtonTitle = ""
        
    }
    func setUpData() async {
        await  pokeViewModel.getDataFromAPI()
        filterData = pokeViewModel.pokemons
        // No olvidar que luego de llamar datos de la api a la table refrescarla
        tableView.reloadData()
    }

}

//Creamos un extension de ViewController
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //Retorna el numero de filas, siempre retrorna un int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    //Retorna las celdas, textos o imagenes de nuestra celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Este identificador es el que definimos en la vista
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        // para saber la posicion de la celda es con indexPath.row que retorna la posicion actual de la celda
        cell.textLabel?.text = filterData[indexPath.row].name
        cell.imageView?.image = HelperImage.setImage(id: HelperString.getIdFromUrl(url: filterData[indexPath.row].url))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        urlToDetail = filterData[indexPath.row].url
        performSegue(withIdentifier: "detail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let pokeDetailView = segue.destination as! PokeDetailViewController
            pokeDetailView.url = urlToDetail!
        }
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty
        ? pokeViewModel.pokemons
        : pokeViewModel.pokemons.filter({(item: Result) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        tableView.reloadData()
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        //Para desaparecer el teclado
        self.searchBar.endEditing(true)
    }
}
