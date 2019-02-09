//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var dao:ContatoDao
    var delegate:FormularioContatoViewControllerDelegate?
    
    var contato: Contato!
    
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
            
            if let foto = contato.foto {
                self.imageView.image = foto
                
                self.imageView.layer.cornerRadius = 75
                self.imageView.layer.masksToBounds = true
                self.imageView.clipsToBounds = true
            }
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionaFoto(sender:)))
        
        self.imageView.addGestureRecognizer(tap)
    }
    
    func selecionaFoto(sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("camera disponivel")
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]){
        
        
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage{
         
            
            self.imageView.image = imagemSelecionada
        }
        picker.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pegaDadosDoFormulario(){
        if contato == nil {
            self.contato = Contato()
        }
        
        contato.nome = self.nome.text!
        contato.telefone = self.telefone.text!
        contato.endereco = self.endereco.text!
        contato.site = self.site.text!
        contato.foto = self.imageView.image
    }
    
    func atualizaContato() {
        pegaDadosDoFormulario()
        
        self.delegate?.contatoAtualizado(contato)
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func CriaContato(){
        self.pegaDadosDoFormulario()
        
        dao.adiciona(contato)
        
        self.delegate?.contatoAdicionado(contato)
        
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
    @IBOutlet var imageView: UIImageView!
    

}

