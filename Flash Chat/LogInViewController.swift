//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase

/**
 This class handle siging in for existing users to our app with their cerdentials.
 */
class LogInViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - IBActions
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        if isValid(){
            Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!){ (user, error) in
                if error != nil{
                    //Errors can be happend in validation - or network - or db
                    print(error as Any)
                }else{
                    print("Login Successful!")
                    
                    //sender is the current view controller
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
        }
        
    }
    
    //MARK: - Meethods
    
    /**
     This method check validation of user cerdentials.
     */
    func isValid() -> Bool{
        if (self.passwordTextfield.text?.isEmpty)! || (self.passwordTextfield.text?.isEmpty)!{
            return false
        }else{
            return true //Valid
        }
    }
}
