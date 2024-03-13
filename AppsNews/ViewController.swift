//
//  ViewController.swift
//  AppsNews
//
//  Created by KevinLA on 11/03/24.
//

import UIKit
import SafariServices

struct NoticiasModelo: Codable {
    let articles: [Noticia]
}


struct Noticia: Codable {
    let title: String?
    let description: String?
    //let author: String?
    let url: String?
    let urlToImage: String?
}

class ViewController: UIViewController {
    
    var articulosNoticias : [Noticia] = []

    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaNoticias.register(UINib(nibName: "CeldaNoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaNoticia")
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        buscarNoticias()
    }

    func buscarNoticias() {
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let decodificador = JSONDecoder()
                
                if let datosDecodificados = try?
                    decodificador.decode(NoticiasModelo.self, from: data) {
                    //print("datosDecodificados: \(datosDecodificados.articles.count)")
                    
                    articulosNoticias = datosDecodificados.articles
                    
                    tablaNoticias.reloadData()
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celdaNoticia", for: indexPath) as! CeldaNoticiaTableViewCell
        celda.titulonoticia.text = articulosNoticias[indexPath.row].title
        celda.descricionNoticiasLabel.text = articulosNoticias[indexPath.row].description
        
        
        if let url = URL(string: articulosNoticias[indexPath.row].urlToImage ?? "") {
            if let imagenData = try? Data(contentsOf: url) {
                celda.ImagenNoticiaIV.image = UIImage(data: imagenData)
            }
        }
        
        return celda
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablaNoticias.deselectRow(at: indexPath, animated: true)
        
        guard let urlMostrar = URL(string: articulosNoticias[indexPath.row].url ?? "") else {return}
        
        let VCSS = SFSafariViewController(url: urlMostrar)
        
        present(VCSS, animated: true)
    }
}
