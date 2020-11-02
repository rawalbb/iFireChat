//
//  ChatViewController.swift
//  iFireChat
//
//  Created by Bansri Rawal on 10/28/20.
//

import Foundation
import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageText: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "⚡️iFireChat"
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
        chatTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        chatTableView.dataSource = self

        loadMessages()
    }
    
    func loadMessages(){
       
        
        db.collection("messages")
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                if let snapDocs = querySnapshot?.documents{
                    for doc in snapDocs {
                        let data = doc.data()
                        if let datasender = data["sender"] as? String, let databody = data["body"] as? String{
                            let newMessage = Message(sender: datasender, body: databody)
                            print(newMessage, "NEW MESSAGE")
                            self.messages.append(newMessage)
                            
                            //Whenever inside closure and trying to update UI
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }

                        }
                        
                    }
                }
            
            }
        }
        
        
        print(messages.count, "LOADED MESSAGES")
        
    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
    let firebaseAuth = Auth.auth()
      do {
        try firebaseAuth.signOut()
        navigationController?.popToRootViewController(animated: true)
        
      } catch let signOutError as NSError {
        print ("Error signing out: %@", signOutError)
      }
        
    }
    
    @IBAction func messageSendPressed(_ sender: Any) {
        if let messageBody = messageText.text, let messageSender = Auth.auth().currentUser?.email{
            
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID:")
                }
            }
            
            
        }
        
        messageText.text = ""
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        else{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        }
        
        print(indexPath.row)
        return cell
    }
    
    
    
    
    
    
}
