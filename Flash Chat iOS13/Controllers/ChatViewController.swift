//
//  SceneDelegate.swift
//  Flash Chat iOS13
//
//  Created by Petar Iliev on 07/11/2022.
//  Copyright © 2022 Petar Iliev. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        Message(sender: "petariliev@utexas.edu", body: "Hey"),
        Message(sender: "petariliev2002@gmail.com", body: "Hey!"),
        Message(sender: "petariliev@utexas.edu", body: "How are you?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view population
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        // navigation bar customization
        title = K.title
        navigationItem.hidesBackButton = true
        
        loadMessages()
    }
    
    // adds real time update listener to Firestore
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            self.messages = []
            if error != nil {
                print("Error while retrieving data from Firestore")
                print(error!.localizedDescription)
            } else {
   
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let documentData = document.data()
                        if let sender = documentData[K.FStore.senderField] as? String, let body = documentData[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: body)
                            self.messages.append(newMessage)
                            
                            // update UI
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        // update database if there's a message and a user
        if let messageBody = messageTextfield.text, let email = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : email,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { error in
                if error != nil {
                    print("Error while saving data to Firestore")
                    print(error!.localizedDescription)
                } else {
                    print("Data successfuly saved to Firestore")
                }
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
    }
    
}
