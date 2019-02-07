//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {

    var dao:ContatoDao
    
    required init?(coder aDecoder: NSCoder){
        self.dao = ContatoDao.sharedInstance()
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if contato != nil {
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var contato: Contato!
    
    func pegaDadosDoFormulario(){
        if contato == nil {
            self.contato = Contato()
        }
        
        contato.nome = self.nome.text!
        contato.telefone = self.telefone.text!
        contato.endereco = self.endereco.text!
        contato.site = self.site.text!
    }
    
    func atualizaContato() {
        pegaDadosDoFormulario()
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func CriaContato(){
        self.pegaDadosDoFormulario()
        
        dao.adiciona(contato)
        
        var number: Int = 0
        
        for cont in dao.contatos{
            print("Contato \(number): \(cont) | ")
            number = number + 1
        }
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    

}

