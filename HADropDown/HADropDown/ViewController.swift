//
//  ViewController.swift
//  MyDropDown
//
//  Created by Hassan Aftab on 22/02/2017.
//  Copyright © 2017 Hassan Aftab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dropDown: HADropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: HADropDownDelegate {
    func didSelectItem(dropDown: HADropDown, at index: Int) {
        print("Item selected at index \(index)")
    }
}
