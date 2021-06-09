//
//  CrearUsuarioViewController.swift
//  Snapchat
//
//  Created by p on 8/06/21.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class CrearUsuarioViewController: UIViewController {
    @IBOutlet weak var CorreoTextField: UITextField!
    @IBOutlet weak var ContraseñaTextField: UITextField!
    @IBOutlet weak var btnRegistrarUsuario: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegistrarUsuario(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.CorreoTextField.text!, password: self.ContraseñaTextField.text!, completion: { (user,error)  in
            print("Intentando crear un usuario")
           if error != nil{
                print("Se presento el siguiente error al crear el usuario: \(error)")
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.CorreoTextField.text!) .Tiene problemas al crearse.", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler:nil)
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
           }else{
               print("El usuario fue creado exitosamente")
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.CorreoTextField.text!) se creo correctamente.", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler:{ (UIAlertAction) in
                    self.performSegue(withIdentifier: "RegistroUsuarioSegue", sender: nil)
                })
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
            
            
            
            
           }
    })
}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
