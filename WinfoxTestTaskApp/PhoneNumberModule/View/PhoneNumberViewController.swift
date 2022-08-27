//
//  ViewController.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import SnapKit
import FlagPhoneNumber

class PhoneNumberViewController: UIViewController {
    
    var listController: FPNCountryListViewController!
    var number: String?
    var viewModel = PhoneNumberViewModel()
    
    private lazy var phoneNumberTextField: FPNTextField = {
        let textField = FPNTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Далее", for: .normal)
        button.tintColor = .systemIndigo
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(phoneNumberTextField)
        stack.addArrangedSubview(nextButton)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemIndigo
        
        addSubView()
        addConstraints()
        disabledNextButton()
        configurePhoneTextField()
        changeBackButton()
        bindViewModel()
    }
    
    private func addSubView() {
        view.addSubview(stackView)
    }
    
    private func addConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
    }
    
    private func bindViewModel() {
        viewModel.codeSend.bind { code in
            if code {
                self.goToCodeViewController()
            }
        }
    }
    
    private func changeBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        backItem.tintColor = .white
        navigationItem.backBarButtonItem = backItem
    }
    
    private func configurePhoneTextField() {
        phoneNumberTextField.displayMode = .list
        phoneNumberTextField.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: phoneNumberTextField.countryRepository)
        listController.didSelect = { country in
            self.phoneNumberTextField.setFlag(countryCode: country.code)
        }
    }
    
    private func disabledNextButton() {
        nextButton.alpha = 0.5
        nextButton.isEnabled = false
    }
    
    private func enableddNextButton() {
        nextButton.alpha = 1
        nextButton.isEnabled = true
    }
    
    @objc private func nextButtonTapped() {
        viewModel.fetchCode(number ?? "")
    }
    
    private func goToCodeViewController() {
        let CodeVc = CodeViewController()
        navigationController?.pushViewController(CodeVc, animated: true)
    }
}

extension PhoneNumberViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        ///
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            enableddNextButton()
            number = textField.getFormattedPhoneNumber(format: .International)
        } else {
            disabledNextButton()
        }
    }
    
    func fpnDisplayCountryList() {
        let vc = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        phoneNumberTextField.text = ""
        self.present(vc, animated: true)
    }
}

