//
//  TemperaturaViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 13/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import Foundation

class TemperaturaViewController: UIViewController{
    
    @IBOutlet weak var labelCondicaoAtual: UILabel!
    @IBOutlet weak var labelTemperaturaMaxima: UILabel!
    @IBOutlet weak var labelTemperaturaMinima: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var contato: Contato?
    
    let URL_BASE = "https://api.openweathermap.org/data/2.5/weather?APPID=0ddf194c899f9f1ce6542f4d0f6aadee&units=metric"
    
    let URL_BASE_IMAGE = "https://openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        if let contato = self.contato {
            if let endpoint = URL(string: URL_BASE + "&lat=\(contato.latitude ?? 0)&lon=\(contato.longitude ?? 0)") {
                
                let session = URLSession(configuration: .default)
                
                print(endpoint)
                
                let task = session.dataTask(with: endpoint) {
                    (data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200{
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as?[String:AnyObject] {
                                    let main = json["main"] as! [String:AnyObject]
                                    let weather = json["weather"]![0] as! [String:AnyObject]
                                    let temp_min = main["temp_min"] as! Double
                                    let temp_max = main["temp_max"] as! Double
                                    let icon = weather["icon"] as! String
                                    let condicao = weather["main"] as! String
                                    
                                    DispatchQueue.main.async {
                                        print(condicao)
                                        print(temp_min)
                                        print(temp_max)
                                        print(icon)
                                        
                                        self.labelCondicaoAtual.text = condicao
                                        self.labelTemperaturaMinima.text = temp_min.description + "*"
                                        self.labelTemperaturaMaxima.text = temp_max.description + "*"
                                        self.pegaImagem(icon)
                                        
                                        self.labelCondicaoAtual.isHidden = false
                                        self.labelTemperaturaMinima.isHidden = false
                                        self.labelTemperaturaMaxima.isHidden = false
                                        
                                    }
                                }
                            } catch let erro as NSError{
                                print(erro.localizedDescription)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    private func pegaImagem(_ icon:String){
        if let endpoint = URL(string:URL_BASE_IMAGE + icon + ".png") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: endpoint) {
                (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            print("Exibindo Imagem")
                            self.imageView.image = UIImage(data: data!)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
}
