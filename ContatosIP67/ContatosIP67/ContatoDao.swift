//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit
import Foundation

class ContatoDao: CoreDataUtil {

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
    
    func buscaPosicaoDoContato(_ contato: Contato) -> Int {
        return contatos.index(of: contato)!
    }
    
    func carregaContatos() {
        let busca = NSFetchRequest<Contato>(entityName: "Contato")
        
        let orderPorNome = NSSortDescriptor(key: "nome", ascending: true)
        
        busca.sortDescriptors = [orderPorNome]
        
        do{
            self.contatos = try self.persistentContainer.viewContext.fetch(busca)
        }catch let error as NSError {
            print("Fetch falhou miseravelmente: \(error.localizedDescription)")
        }
    }
    
    func inserirDadosIniciais() {
        let configuracoes = UserDefaults.standard
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        
        if !dadosInseridos {
            let caelumSP = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
            
            caelumSP.nome = "Caelum SP"
            caelumSP.endereco = "Rua Vergueiro 3185"
            caelumSP.telefone = "01155712751"
            caelumSP.site = "http://www.caelum.com.br"
            caelumSP.latitude = -23.5883034
            caelumSP.longitude = -46.632369
            
            self.saveContext()
            
            configuracoes.set(true, forKey: "dados_inseridos")
            
            configuracoes.synchronize()
        }
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
        
        self.inserirDadosIniciais()
        
        self.carregaContatos()
        
        print("Caminho do BD: \(NSHomeDirectory())")
    }
    
}
