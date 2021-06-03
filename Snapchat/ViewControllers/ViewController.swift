//
//  ViewController.swift
//  Snapchat
//
//  Created by p on 26/05/21.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func IniciarSesionGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
        print("Intentando Iniciar Sesion 🧐")
        print("Inicio de sesion con Google 😎")
        //GIDSignIn.sharedInstance()?.signOut()
    }
    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){
            (user, error) in
            print("Intentando Iniciar Sesion 🧐")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user,error)  in
                    print("Intentando crear un usuario")
                                       if error != nil{
                                            print("Se presento el siguiente error al crear el usuario: \(error)")
                                       }else{
                                       print("El usuario fue creado exitosamente")
                                        
                                        Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                                        
                                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.emailTextField.text!) se creo correctamente.", preferredStyle: .alert)
                                        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                                            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                                        })
                                        alerta.addAction(btnOK)
                                        self.present(alerta, animated: true, completion: nil)
                                        
                                       }
            })
            }else{
                print("Inicio de sesion exitoso con correo😎")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    private func showHome(result: AuthDataResult?, error: Error?){
        if let result = result, error == nil {
            print("Inicio de sesion exitoso")
        } else {
            let alertController = UIAlertController(title: "Error", message: "Se ha producido un error de autenticacion mediante Google", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }

}

extension ViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil {
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
        }
    }
    
    
}
