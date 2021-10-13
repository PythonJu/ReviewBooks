//
//  UserSignUpViewModel.swift
//  ReviewBooks
//
//  Created by MBP潤 on 2021/10/02.
//

import UIKit

class presentAnother {
    func moveToSignUpVC() {
        let UserLogInView = UserLogInViewController()
        let moveToSignUpVC: UserSignUpViewController = UIStoryboard(name: "UserSignUp", bundle: nil).instantiateViewController(identifier: "UserSignUpStoryboard") as! UserSignUpViewController
        print("---------------------------------------")
        moveToSignUpVC.modalPresentationStyle = .fullScreen
        UserLogInView.present(moveToSignUpVC, animated: true, completion: nil)
        
    }
}
