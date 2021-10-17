//
//  UserLogInViewController.swift
//  ReviewBooks
//
//  Created by MBP潤 on 2021/10/01.
//

import UIKit
import FirebaseAuth

class UserLogInViewController: UIViewController {
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var userPWTextField: UITextField!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    @IBAction func presentSignUpVC(_ sender: UIButton) {
        moveToSignUpVC.modalPresentationStyle = .fullScreen
        self.present(moveToSignUpVC, animated: true, completion: nil)
    }
    
    private let moveToSignUpVC: UserSignUpViewController = UIStoryboard(name: "UserSignUp", bundle: nil).instantiateViewController(identifier: "UserSignUpStoryboard") as! UserSignUpViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIDTextField.attributedPlaceholder = NSAttributedString(string: "ユーザーID、メールアドレス、電話番号", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray2])
        userPWTextField.attributedPlaceholder = NSAttributedString(string: "パスワード", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray2])
        userPWTextField.isSecureTextEntry = true
        logInButton.layer.cornerRadius = 5.0
        signUpButton.layer.cornerRadius = 5.0
        
        userIDTextField.delegate = self
        userPWTextField.delegate = self
        
        textFieldDidChangeSelection(userIDTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hiderKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Singleton.sharedInstance.changePresentVC == "moveToSignUpVC" {
            Singleton.sharedInstance.changePresentVC = "moveToLogInVC"
            moveToSignUpVC.modalPresentationStyle = .fullScreen
            self.present(moveToSignUpVC, animated: true, completion: nil)
        }
    }
}

extension UserLogInViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func showKeyboard(notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else { return }
        let signInbuttonMaxY = buttonStackView.frame.maxY
        let distance = signInbuttonMaxY - keyboardMinY - 85
        
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: -distance)
        })
    }
    @objc func hiderKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = .identity
        })
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailIsEmpty = userIDTextField.text?.isEmpty ?? true
        let userPWIsEmpty = userPWTextField.text?.isEmpty ?? true
        
        if emailIsEmpty || userPWIsEmpty {
            logInButton.isEnabled = false
            logInButton.tintColor = .systemGray5
            logInButton.backgroundColor = .systemGray2
        } else {
            logInButton.isEnabled = true
            logInButton.tintColor = .systemGray2
            logInButton.backgroundColor = .systemGray6
        }
    }
}

