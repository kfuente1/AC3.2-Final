//
//  UploadViewController.swift
//  AC3.2-Final
//
//  Created by Karen Fuentes on 2/15/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import MobileCoreServices

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var databaseReference: FIRDatabaseReference!
    var user: FIRUser?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.doneButton.isEnabled = false
        self.databaseReference = FIRDatabase.database().reference().child("posts")
        
        FIRAuth.auth()?.signInAnonymously(completion: { (user: FIRUser?, error: Error?) in
            if let error = error {
                print(error)
            }
            else {
                self.user = user
            }
        })
    }
    
    // MARK: - Delegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePicked.image = image
        } else {
            print("Bad Media")
        }
        dismiss(animated: true) {
            self.imagePickerButton.isHidden = true
        }
    }
    
    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        let postRef = self.databaseReference.childByAutoId()
        if let image = self.imagePicked.image {
            let storage = FIRStorage.storage()
            let storageRef = storage.reference(forURL: "gs://ac-32-final.appspot.com/")
            let spaceRef = storageRef.child("images/\(postRef.key)")
            
            let data = UIImageJPEGRepresentation(image, 0.5)
            
            let metadata = FIRStorageMetadata()
            metadata.cacheControl = "public,max-age=300";
            metadata.contentType = "image/jpeg";
            
            let _ = spaceRef.put(data!, metadata: metadata, completion: { (metadata, error) in
                guard metadata != nil else {
                    print("Error in putting data")
                    return
                }
            })
        }
        
        let post = Post(key: postRef.key, userId: (user?.uid)! , comment: self.textView.text)
        let dict = post.asDictionary
        
        postRef.setValue(dict) { (error, reference) in
            if let error = error {
                print(error)
            }else {
                print(reference)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func imagePickerButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [String(kUTTypeImage)]
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        //self.doneButton.isEnabled = true
    }
}

