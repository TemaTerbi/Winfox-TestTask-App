//
//  ExitViewController.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 27.08.2022.
//

import UIKit
import SnapKit

class ExitViewController: UIViewController {
    
    var viewModel = ExitViewModel()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        addSubview()
        addConstraints()
    }
    
    private func addSubview() {
        view.addSubview(exitButton)
    }
    
    private func addConstraints() {
        exitButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    @objc private func signOut() {
        viewModel.signOut()
    }
}
