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
                let alertController = UIAlertController(title: "Error de Autenticidad", message: "El usuario ingresado no se encuentra registrado. Registrelo porfavor!.", preferredStyle: .alert)
                let btnCancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                let btnCreate = UIAlertAction(title: "Crear usuario", style: .default, handler: { (UIAlertAction) in
                    self.performSegue(withIdentifier: "RegistrarUsuarioSegue", sender: nil)
                })
                alertController.addAction(btnCreate)
                alertController.addAction(btnCancel)
                self.present(alertController, animated: true, completion: nil)
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
