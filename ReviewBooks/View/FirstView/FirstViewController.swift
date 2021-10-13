//
//  HomeViewController.swift
//  ReviewBooks
//
//  Created by MBP潤 on 2021/10/03.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func presentLogInVC(_ sender: UIButton) {
        let moveToLogInVC: UserLogInViewController = UIStoryboard(name: "UserLogIn", bundle: nil).instantiateViewController(identifier: "UserLogInStoryboard") as! UserLogInViewController
        moveToLogInVC.modalPresentationStyle = .fullScreen
        self.present(moveToLogInVC, animated: true, completion: nil)
    }
    @IBAction func presentSignInVC(_ sender: UIButton) {
        let moveToSignUpVC: UserSignUpViewController = UIStoryboard(name: "UserSignUp", bundle: nil).instantiateViewController(identifier: "UserSignUpStoryboard") as! UserSignUpViewController
        moveToSignUpVC.modalPresentationStyle = .fullScreen
        self.present(moveToSignUpVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.cornerRadius = 5.0
        signUpButton.layer.cornerRadius = 5.0
    }
}
