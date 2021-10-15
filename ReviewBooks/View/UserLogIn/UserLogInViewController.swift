//
//  UserLogInViewController.swift
//  ReviewBooks
//
//  Created by MBP潤 on 2021/10/01.
//

import UIKit

class UserLogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var userPWTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBAction func presentSignUpVC(_ sender: UIButton) {
        moveToSignUpVC.modalPresentationStyle = .fullScreen
        self.present(moveToSignUpVC, animated: true, completion: nil)
    }
    
    private let moveToSignUpVC: UserSignUpViewController = UIStoryboard(name: "UserSignUp", bundle: nil).instantiateViewController(identifier: "UserSignUpStoryboard") as! UserSignUpViewController

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIDTextField?.attributedPlaceholder = NSAttributedString(string: "ユーザーID、メールアドレス、電話番号", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray2])
        userPWTextField?.attributedPlaceholder = NSAttributedString(string: "パスワード", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGray2])
        userPWTextField?.isSecureTextEntry = true
        logInButton?.layer.cornerRadius = 5.0
        signUpButton?.layer.cornerRadius = 5.0
        
        userIDTextField?.delegate = self
        userPWTextField?.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Singleton.sharedInstance.changePresentVC == "moveToSignUpVC" {
            Singleton.sharedInstance.changePresentVC = "moveToLogInVC"
            moveToSignUpVC.modalPresentationStyle = .fullScreen
            self.present(moveToSignUpVC, animated: true, completion: nil)
        } else {
            return
        }
    }
}
