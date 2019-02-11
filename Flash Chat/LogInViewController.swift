//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase
import iOSDropDown

/**
 This class handle siging in for existing users to our app with their cerdentials.
 */
class LogInViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var emailTextfield: DropDown!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // The list of array to display. Can be changed dynamically
        emailTextfield.optionArray = ["Option 1", "Option 2", "Option 3"]
        //Its Id Values and its optional
        emailTextfield.optionIds = [1,23,54,22]
        
        // The the Closure returns Selected Index and String
        emailTextfield.didSelect{(selectedText , index ,id) in
            print(selectedText)
        }
        
        emailTextfield.isSearchEnable = true
        
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
