//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase

/**
 This class handle regstering new users to our app with their cerdentials.
 */
class RegisterViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBActions
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        //TODO: Set up a new user on our Firbase database
        
        //This is for Firebase Authentication, it have pre-built method called create user with email and password htat we can setup to register users.
        
        //call firebase Auth class and get auth object
        //Completion: this is where the callback occures, firebase will create the user in the background so doesn't freeze up the user interface, it doning that behind the scenes and netwoking with the firebase database, but once it's completed  it will send you a callback that tells you that it complete and whether its successful or error
        if isValid(){
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                if error != nil{
                    //Errors can be happend in validation - or network - or db
                    print(error as Any)
                }else{
                    print("Registeration Successful!")
                    
                    //sender is the current view controller
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
        }
        
    }
    
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
