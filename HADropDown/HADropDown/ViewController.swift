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
        dropDown.items = ["yo", "hello"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

