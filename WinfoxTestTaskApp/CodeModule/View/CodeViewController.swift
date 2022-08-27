//
//  CodeViewController.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import SnapKit

class CodeViewController: UIViewController {
    
    var secondsInTimer = 120
    var timer = Timer()
    var viewModel = CodeViewModel()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.keyboardType = .numberPad
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 22, weight: .bold)
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    private lazy var sendCode: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Подтвердить", for: .normal)
        button.tintColor = .systemIndigo
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(acceptCode), for: .touchUpInside)
        return button
    }()
    
    private lazy var reSendCode: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            button.backgroundColor = .systemCyan
        } else {
            button.backgroundColor = .white
        }
        button.setTitle("Отправить код повторно через: \(secondsInTimer)", for: .normal)
        button.tintColor = .systemIndigo
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.addArrangedSubview(textView)
        stack.addArrangedSubview(sendCode)
        stack.addArrangedSubview(reSendCode)
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        
        reSendCode.alpha = 0.5
        reSendCode.isEnabled = false
        
        textView.delegate = self
        
        addSubView()
        addConstraints()
        disabledNextButton()
        createTimerForResendCode()
        bindViewModel()
    }
    
    private func addSubView() {
        view.addSubview(stackView)
    }
    
    private func addConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
    }
    
    private func bindViewModel() {
        viewModel.login.bind { login in
            if login {
                self.goToHomeScreen()
            } else {
                self.showErrorAlert("Попытка входна не удалась, попробуйте снова")
            }
        }
        
        viewModel.error.bind { error in
            if error {
                self.showErrorAlert("Код введен не верно, либо уже устарел. Попробуйте снова!")
            }
        }
    }
    
    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func disabledNextButton() {
        sendCode.alpha = 0.5
        sendCode.isEnabled = false
    }
    
    private func enableddNextButton() {
        sendCode.alpha = 1
        sendCode.isEnabled = true
    }
    
    private func goToHomeScreen() {
        let vc = HomeScreenViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @objc private func acceptCode() {
        viewModel.sigIn(textView.text ?? "")
    }
    
    @objc private func resendButtonTapped() {
        let viewModel = PhoneNumberViewModel()
        let number = UserDefaults.standard.string(forKey: "number")
        
        viewModel.fetchCode(number ?? "")
        
        reSendCode.alpha = 0.5
        reSendCode.isEnabled = false
        secondsInTimer = 120
        reSendCode.setTitle("Отправить код повторно через: \(secondsInTimer)", for: .normal)
        createTimerForResendCode()
    }
    
    @objc private func timerUpdate() {
        DispatchQueue.main.async {
            if self.secondsInTimer == 0 {
                self.reSendCode.setTitle("Отправить код повторно", for: .normal)
                self.reSendCode.alpha = 1
                self.reSendCode.isEnabled = true
            } else {
                self.reSendCode.setTitle("Отправить код повторно через: \(self.secondsInTimer)", for: .normal)
                self.reSendCode.alpha = 0.5
                self.reSendCode.isEnabled = false
                self.secondsInTimer -= 1
            }
        }
    }
    
    private func createTimerForResendCode() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
}

extension CodeViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLenght = currentCharacterCount + text.count - range.length
        return newLenght <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 6 {
            enableddNextButton()
        } else {
            disabledNextButton()
        }
    }
}
