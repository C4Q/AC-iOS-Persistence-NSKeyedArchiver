//
//  DetailViewController.swift
//  DSA
//
//  Created by Alex Paul on 12/8/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dsaTitleLabel: UILabel!
    @IBOutlet weak var dsaDescriptionTextView: UITextView!
    
    var dsa: DSA!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(forDSA: dsa)
    }
    
    private func configureView(forDSA dsa: DSA) {
        navigationItem.title = dsa.title
        dsaTitleLabel.text = dsa.title
        dsaDescriptionTextView.text = dsa.dsaDescription
    }

}
