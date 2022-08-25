//
//  ViewController.swift
//  Events
//
//  Created by Muhammad Aaraiz Wasim on 08/08/2022.
//

import UIKit
import Foundation

extension UserDefaults {
    func setUser<T: Codable>(_ data: T?, forKey defaultName: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: defaultName)
    }
    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}

let key = "user"

class ViewController: UIViewController {
    
    @IBOutlet weak var toggleSwitch: UISwitch! //implicitly unwrapping
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var rememberMeSwitch: UILabel!
    
    
    
    var check = true
    var stateCheck = false
    var user : User?
    var userLogin : User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //checking user data in UserDefaults
        
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: User.self, key: key1) {
            emailField.text = retrievedCodableObject.userEmail
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let emailFormat = isValidEmail(testStr: emailField.text!)
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        var temp: String
        if(emailFormat == false)
        {
            showEmailFormatError()
        }
        else {
            if (email == "a@confiz.com" && password == "p"){
                //this would work for remember me button
                if(check == false)
                {
                    emailField.text = ""
                    passwordField.text = ""
                    temp = ""
                }
                else {
                    //do not use force unwrap!!!!
                    passwordField.text = ""
                    
                    guard let x = emailField.text else {
                        return
                    }
                    temp = x
                    //persisting the state here
                }
                let codableObject = User(userEmail: temp , state: "True")
                UserDefaults.standard.setUser(codableObject, forKey: key)
                jumpToOtherViewController()
                
            }
            else if (email != "a@confiz.com" && password == "p"){
                showEmailErrorAlert()
                
            }
            else if (email == "a@confiz.com" && password != "p"){
                showPasswordErrorAlert()
            }
            else {
                showErrorAlert()
            }
        }
        
    }
    func jumpToOtherViewController()
    {
        let vc = storyboard?.instantiateViewController(identifier: "other") as! UINavigationController
        
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        showIncompleteAlert()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
    }
    
    @IBAction func rememberMeToggled(_ sender: UISwitch) {
        if sender.isOn {
            check = true
        }
        else {
            check = false
        }
    }
    
    
    func showEmailErrorAlert() {
        
        let alert = UIAlertController(title: "Login Failed", message: "Invalid Email", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: {action in print("Retry")}))
        
        present(alert, animated: true)
    }
    func showEmailFormatError() {
        
        let alert = UIAlertController(title: "Login Failed", message: "Invalid Email Format", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: {action in print("Retry")}))
        
        present(alert, animated: true)
    }
    func showPasswordErrorAlert() {
        
        let alert = UIAlertController(title: "Login Failed", message: "Invalid Password", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: {action in print("Retry")}))
        
        present(alert, animated: true)
    }
    
    func showErrorAlert() {
        
        let alert = UIAlertController(title: "Login Failed", message: "Invalid Email & Password", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: {action in print("Retry")}))
        
        present(alert, animated: true)
    }
    
    func showIncompleteAlert() {
        
        let alert = UIAlertController(title: "Error", message: "Functionality yet to be implemented", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Return", style: .cancel, handler: {action in print("Tapped Return")}))
        
        present(alert, animated: true)
    }
}

