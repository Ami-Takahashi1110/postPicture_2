//
//  ViewController.swift
//  postPicture
//
//  Created by USER on 2023/04/07.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //label.text = FirebaseApp.app()?.name
        FirebaseApp.configure()
    }
    // パラメータ定義
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
     
    // 入力チェック
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
            
        }
        // ログイン
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                print("ログインに失敗しました：\(error.localizedDescription)")
                return
                    } else {
                        // ログイン成功時
                        print("ログインに成功しました")
                        // 投稿写真閲覧画面へ遷移
                        self.performSegue(withIdentifier: "toPostPicture", sender: nil)
                    }
        }
    }
    
    
    @IBAction func signinButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        // アカウント新規作成時
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print("アカウント作成に失敗しました：\(error.localizedDescription)")
            } else {
                // ログイン成功時
                print("アカウント作成に成功しました")
                // 投稿写真閲覧画面へ遷移
                self.performSegue(withIdentifier: "toPostPicture", sender: nil)
            }
        }        
    }
}

