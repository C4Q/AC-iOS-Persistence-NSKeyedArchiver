//
//  EditListViewController.swift
//  DSA
//
//  Created by Alex Paul on 12/8/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//
import UIKit

class EditListViewController: UIViewController {
    
    @IBOutlet weak var dsaTitleTextField: UITextField!
    @IBOutlet weak var dsaDescriptionTextView: UITextView!
    
    // will get set if coming from edit state
    var dsaItemToBeEdited: DSA!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dsaItem = dsaItemToBeEdited {
            dsaTitleTextField.text = dsaItem.title
            dsaDescriptionTextView.text = dsaItem.dsaDescription
            navigationItem.title = "Edit DSA Item"
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // TODO: new
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        guard let dsaTitle = dsaTitleTextField.text,
            let dsaDescription = dsaDescriptionTextView.text
            else { return }
        if dsaTitle.isEmpty || dsaDescription.isEmpty {
            showAlert()
            return
        } else {
            let newDSAItem = DSA.init(title: dsaTitle, description: dsaDescription)
            if let _ = dsaItemToBeEdited {
                dsaItemToBeEdited.title = dsaTitle
                dsaItemToBeEdited.dsaDescription = dsaDescription
                DataModel.shared.updateDSAItem(withUpdatedItem: dsaItemToBeEdited
                )
            } else {
                DataModel.shared.addDSAItemToList(dsaItem: newDSAItem)
            }
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // TODO: new??
    private func showAlert() {
        let alertController = UIAlertController(title: "Missing Fields", message: "A title and description for the DSA item is required", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
