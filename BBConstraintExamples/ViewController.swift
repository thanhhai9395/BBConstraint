//
//  ViewController.swift
//  BBConstraintExamples
//
//  Created by innmac on 08/05/2023.
//

import UIKit
import BBConstraint

class ViewController: UIViewController {

    lazy var centerView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .red
        return vw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(centerView)

        centerView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10)
        centerView.centerInSuperview()
    }
}

