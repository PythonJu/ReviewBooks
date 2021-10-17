//
//  UserSignInViewController.swift
//  ReviewBooks
//
//  Created by MBP潤 on 2021/10/01.
//

import UIKit
import Firebase
import FirebaseAuth

class UserSignUpViewController: UIViewController {
    
    @IBOutlet weak var addUserEmailTextField: UITextField!
    @IBOutlet weak var createUserPWTextField: UITextField!
    @IBOutlet weak var againUserPWTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func tappedSignUp(_ sender: UIButton) {
        handlerAuthToFirebase()
        guard let email: String = addUserEmailTextField.text else {
            print("email is empty")
            return
        }
        guard let password: String = createUserPWTextField.text else {
            print("password is empty")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                guard let err = error else { return }
                print("認証情報の保存に失敗しました：\(err)")
                return
            }
            print("認証情報の保存に成功しました：\(user.email!)")
        }
    }
    @IBAction func presentLogInVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUserEmailTextField.attributedPlaceholder = NSAttributedString(string: "example@book.com", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray3])
        createUserPWTextField.attributedPlaceholder = NSAttributedString(string: "英数字8文字以上", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray3])
        againUserPWTextField.attributedPlaceholder = NSAttributedString(string: "パスワードを再入力してください", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray3])
        
        createUserPWTextField.isSecureTextEntry = true
        againUserPWTextField.isSecureTextEntry = true
        signUpButton.layer.cornerRadius = 5.0
        signUpButton.backgroundColor = UIColor.rgb(red: 180, green: 150, blue: 255)
        
        addUserEmailTextField.delegate = self
        createUserPWTextField.delegate = self
        againUserPWTextField.delegate = self
        
        textFieldDidChangeSelection(addUserEmailTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    private func handlerAuthToFirebase() {
        
    
    }
}

extension UserSignUpViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func showKeyboard(notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else { return }
        let signInbuttonMaxY = signUpButton.frame.maxY
        let distance = signInbuttonMaxY - keyboardMinY + 10
        
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: -distance)
        })
    }
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = .identity
        })
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailIsEmpty = addUserEmailTextField.text?.isEmpty ?? true
        let userPWIsEmpty = createUserPWTextField.text?.isEmpty ?? true
        let againUserPWIsEmpty = againUserPWTextField.text?.isEmpty ?? true
        
        if emailIsEmpty || userPWIsEmpty || againUserPWIsEmpty {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 180, green: 150, blue: 255)
        } else {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .systemGray2
        }
    }
}
