//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit
import Foundation

class ContatoDao: NSObject {

    static private var defaultDAO: ContatoDao!
    var contatos: Array<Contato>
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)
    }
    
    func remove(_ posicao: Int) {
        contatos.remove(at: posicao)
    }
        
    func listaTodos() -> [Contato] {
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao: Int) -> Contato {
        return contatos[posicao]
    }
    
    static func sharedInstance() -> ContatoDao{
        if defaultDAO == nil {
            defaultDAO = ContatoDao()
        }
        return defaultDAO
    }
    
    override private init() {
        self.contatos = Array()
        super.init()
    }
    
}
