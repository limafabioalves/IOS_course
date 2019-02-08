//
//  GerenciadorDeAcoes.swift
//  ContatosIP67
//
//  Created by ios8207 on 07/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class GerenciadorDeAcoes: NSObject {
    let contato: Contato
    var controller: UIViewController!
    
    init(do contato:Contato){
        self.contato = contato
    }
    
    func exibirAcoes(em controller:UIViewController) {
        self.controller = controller
        
        let alertView = UIAlertController(title: self.contato.nome, message: nil, preferredStyle: .actionSheet)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        let ligarParaContato = UIAlertAction(title: "Ligar", style: .default) {
            action in self.ligar()
        }
        
        let exibirContatoNoMapa = UIAlertAction(title: "Visualizar no Mapa", style: .default) {
            action in self.abrirMapa()
        }
        
        let exibirSiteDoContato = UIAlertAction(title: "Visualizar Site", style: .default, handler: {
            action in self.abrirNavegador()
        })
        
        alertView.addAction(cancelar)
        alertView.addAction(ligarParaContato)
        alertView.addAction(exibirContatoNoMapa)
        alertView.addAction(exibirSiteDoContato)
        
        self.controller.present(alertView, animated: true, completion: nil)
    }
    
    private func ligar() {
        print("Ligou")
        
        let device = UIDevice.current
        
        if device.model == "iPhone"  {
            print("UUID \(device.identifierForVendor!)")
            abrirAplicativo(com: "tel:" + self.contato.telefone)
        } else {
            let alert = UIAlertController(title: "Impossível fazer ligações", message: "Seu dispositivo não é um iPhone", preferredStyle: .alert)
            let acao= UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(acao)
            self.controller.present(alert, animated: true, completion: nil)
        }
    }
    
    private func abrirMapa() {
        print("Mapa")
        
        let url = ("http://maps.google.com/maps?q=" + self.contato.endereco!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        abrirAplicativo(com: url!)
    }
    
    private func abrirNavegador() {
        print("Navegador")
        
        var url = contato.site!
        
        if !url.hasPrefix("http://"){
            url = "http://" + url
        }
        
        abrirAplicativo(com: url)
    }
    
    private func abrirAplicativo(com url: String) {
        print("Abrir aplicativo \(url)")
        UIApplication
        .shared
            .open(URL(string: url)!, options: [:], completionHandler: nil)
    }
}
