//
//  UserSignInViewController.swift
//  ReviewBooks
//
//  Created by MBP潤 on 2021/10/01.
//

import UIKit

class UserSignUpViewController: UIViewController {
    
    @IBOutlet weak var addUserEmailTextField: UITextField!
    @IBOutlet weak var createUserPWTextField: UITextField!
    @IBOutlet weak var againUserPWTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    @IBAction func presentLogInVC(_ sender: UIButton) {
        let moveToLogInVC: UserLogInViewController = UIStoryboard(name: "UserLogIn", bundle: nil).instantiateViewController(identifier: "UserLogInStoryboard") as! UserLogInViewController
        guard ((self.presentingViewController as? FirstViewController) != nil) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        moveToLogInVC.modalPresentationStyle = .fullScreen
        self.presentingViewController?.dismiss(animated: true, completion: {
            self.presentingViewController?.present(moveToLogInVC, animated: true, completion: nil)
            print("---------------------------------")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUserEmailTextField.attributedPlaceholder = NSAttributedString(string: "example@book.com", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray3])
        createUserPWTextField.attributedPlaceholder = NSAttributedString(string: "英数字8文字以上", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray3])
        againUserPWTextField.attributedPlaceholder = NSAttributedString(string: "パスワードを再入力してください", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray3])
        
        signInButton.layer.cornerRadius = 5.0
        signInButton.backgroundColor = UIColor.rgb(red: 180, green: 150, blue: 255)
        
        addUserEmailTextField.delegate = self
        createUserPWTextField.delegate = self
        againUserPWTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func showKeyboard(notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else { return }
        let signInbuttonMaxY = signInButton.frame.maxY
        let distance = signInbuttonMaxY - keyboardMinY
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: -distance)
        })
    }
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = .identity
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UserSignUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailIsEmpty = addUserEmailTextField.text?.isEmpty ?? true
        let userPWIsEmpty = createUserPWTextField.text?.isEmpty ?? true
        let againUserPWIsEmpty = againUserPWTextField.text?.isEmpty ?? true
        
        if emailIsEmpty || userPWIsEmpty || againUserPWIsEmpty {
            signInButton.isEnabled = false
            signInButton.backgroundColor = UIColor.rgb(red: 180, green: 150, blue: 255)
        } else {
            signInButton.isEnabled = true
            signInButton.backgroundColor = .systemGray2
        }
    }
}
