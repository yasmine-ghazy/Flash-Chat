//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase

/**
 This class handle messgaing sending and recieving process.
 */
class ChatViewController: UIViewController {
    
    // Declare instance variables here
    var keyboardHeight: CGFloat = 258
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tabGesture)
        
        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: CustomMessageCell.identifier)
        
        configureTableView()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    ///////////////////////////////////////////
}

//MARK: - TableView DataSource Methods
extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomMessageCell.identifier, for: indexPath) as! CustomMessageCell
        
        let messageArray = ["First message", "second message", "third message"]
        cell.messageBody.text = messageArray[indexPath.row]
        
        return cell
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    //TODO: Declare tableViewTapped here:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    //TODO: Declare configureTableView here:
    /**
     This method change the tableview cell height according to its content.
     */
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0 // Average message height
    }
    
}

///////////////////////////////////////////

//MARK:- TextField Delegate Methods
extension ChatViewController: UITextFieldDelegate{
    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.heightConstraint.constant = 50 + self.keyboardHeight // 50 -> textfield height, 258 -> keyboard height
            print(self.keyboardHeight)
            //we have to call auto layout to update all the views to redraw every thing on the screen
            self.view.layoutIfNeeded()
            
        }
    }
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            
            self.heightConstraint.constant = 50// 50 -> textfield height, 258 -> keyboard height
            print(self.keyboardHeight)
            //we have to call auto layout to update all the views to redraw every thing on the screen
            self.view.layoutIfNeeded()
            
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc func tableViewTapped(){
        messageTextfield.endEditing(true)
    }
}

///////////////////////////////////////////


//MARK: - Send & Recieve from Firebase
extension ChatViewController{
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        //TODO: Send the message to Firebase and save it in our database.
        
        //create a child messages DB inside our reference firebase database
        let messagesDB = Database.database().reference().child("Messages")
        
        //save user message into a dictionary
        let messaggeDict = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text!]
        
        //Create a custom random key for a message, so the messages can be saved under their random unique identifier
        messagesDB.childByAutoId().setValue(messaggeDict){
            (error, reference) in
            if error != nil {
                print(error)
            }else{
                print("Message saved succesfully")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                
                self.messageTextfield.text = ""
            }
        }
    }
    
    //TODO: Create the retrieveMessages method here:
    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }catch{
            print("There's a problem in signing out")
        }
        
    }
    
}
