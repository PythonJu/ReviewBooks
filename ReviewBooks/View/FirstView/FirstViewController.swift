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
        moveToLogInVC.modalPresentationStyle = .fullScreen
        self.present(moveToLogInVC, animated: true, completion: nil)
    }
    @IBAction func presentSignInVC(_ sender: UIButton) {
        Singleton.sharedInstance.changePresentVC = "moveToSignUpVC"
        moveToLogInVC.modalPresentationStyle = .fullScreen
        self.present(moveToLogInVC, animated: false, completion: nil)
    }
    
    private let moveToLogInVC: UserLogInViewController = UIStoryboard(name: "UserLogIn", bundle: nil).instantiateViewController(identifier: "UserLogInStoryboard") as! UserLogInViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.cornerRadius = 5.0
        signUpButton.layer.cornerRadius = 5.0
    }
}
