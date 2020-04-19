//
//  MatchViewController.swift
//  Tinder
//
//  Created by Vinicius Rocha on 19/04/20.
//  Copyright © 2020 ViniciusRocha. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITextFieldDelegate {
    
    var usuario: Usuario? {
        didSet {
            if let usuario = usuario {
                fotoImagemView.image = UIImage(named: usuario.foto)
                mensagemLabel.text = "\(usuario.nome) curtiu você também!"
            }
        }
    }
    
    let fotoImagemView : UIImageView = .fotoImageView(named: "pessoa-1")
    let likeImagemView : UIImageView = .fotoImageView(named: "icone-like")
    let mensagemLabel : UILabel = .textBoldLabel(18, textColor: .white, numberOfLines: 1)
    
    let mensagemTxt: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.placeholder = "Diga algo legal..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let mensagemEnviarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let voltarButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Voltar para o tinder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        view.addSubview(fotoImagemView)
        fotoImagemView.preencherSuperview()
        
        let gradient  = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        
        fotoImagemView.layer.addSublayer(gradient)
        
        mensagemTxt.delegate = self
        mensagemLabel.textAlignment = .center
        
        voltarButton.addTarget(self, action: #selector(voltarClique), for: .touchUpInside)
        
        likeImagemView.translatesAutoresizingMaskIntoConstraints = false
        likeImagemView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImagemView.contentMode = .scaleAspectFit
        
        mensagemTxt.addSubview(mensagemEnviarButton)
        mensagemEnviarButton.preencher(
            top: mensagemTxt.topAnchor,
            leading: nil,
            trailing: mensagemTxt.trailingAnchor,
            bottom: mensagemTxt.bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16)
        )
        mensagemEnviarButton.addTarget(self, action: #selector(enviarMensagem), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [likeImagemView, mensagemLabel, mensagemTxt, voltarButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 32, bottom: 46, right: 32)
        )
    }
    
    @objc func voltarClique() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.enviarMensagem()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func enviarMensagem() {
        if let mensagem = self.mensagemTxt.text {
            print(mensagem)
        }
    }
    
    @objc func keyboardShow (notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                
                UIView.animate(withDuration: duracao) {
                    
                    self.view.frame = CGRect(
                        x: UIScreen.main.bounds.origin.x,
                        y: UIScreen.main.bounds.origin.y,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height - keyboardSize.height
                    )
                    
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardHide (notification: NSNotification) {
        if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duracao) {
                
                self.view.frame = UIScreen.main.bounds
                self.view.layoutIfNeeded()
            }
        }
    }
}
