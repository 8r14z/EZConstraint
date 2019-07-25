//
//  ViewController.swift
//  EzConstraint-Example
//
//  Created by An Le  on 7/25/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view
            .constraint(.centerX, to: self.view)
            .constraint(.centerY, to: self.view)
            .constraintWidth(constant: 100)
            .constraintAspectRatio(1)
    }


}

