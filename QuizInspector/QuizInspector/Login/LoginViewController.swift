//
//  LoginViewController.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    
    //MARK: - IBOulets
    @IBOutlet weak private var txtEmailId: UITextField!
    @IBOutlet weak private var txtPassword: UITextField!
    @IBOutlet weak private var lblFooter: UILabel!
    
    var loginViewModel : UserViewModel!
    private var subscriber: AnyCancellable?
    
    //MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configFooterLbl()
        setupViewModel()
        observeViewModel()
    }
    
    //MARK: - IBActions
    @IBAction private func registerButtonTapped(){
        let loginModel = UserModel(email: txtEmailId.text, password: txtPassword.text)
        let validation = loginViewModel.validationCheck(loginModel)
        guard validation.isSuccess else{
            showAlert(K.Error, validation.error)
            return
        }
        loginViewModel.performAction(loginModel)
    }
    
    //MARK: - Configurations Methods
    func configFooterLbl(){
        let textstr = K.dontHaveAnAccount + K.registerHere
        lblFooter.text = textstr
        let colorAttriString = NSMutableAttributedString(string: textstr)
        let range = (textstr as NSString).range(of: K.registerHere)
        colorAttriString.addAttribute(.foregroundColor, value: UIColor.lightGreen, range: range)
        lblFooter.attributedText = colorAttriString
        
        //add gesture Recognizer sentence
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.registerButtonTapped(gesture:)))
        lblFooter.isUserInteractionEnabled = true
        lblFooter.addGestureRecognizer(tapAction)
    }
    
    @objc private func registerButtonTapped(gesture: UITapGestureRecognizer){
        let sentenceRange = ((lblFooter.text ?? "") as NSString).range(of: K.registerHere)
        if gesture.didTapAttributedTextInLabel(label: lblFooter, inRange: sentenceRange) {
            let registerVC = UIStoryboard(name: K.Main, bundle: nil).instantiateViewController(withIdentifier: K.RegisterViewController) as! RegisterViewController
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
        
    }
    
    
    
}



//MARK: - VIEWMODEL METHODS & OPERATIONS 
extension LoginViewController {
    private func setupViewModel() {
        loginViewModel = UserViewModel(endpoint: .login)
    }
    
    private func loginUser(_ userModel: UserModel) {
        loginViewModel.performAction(userModel)
    }
    
    private func observeViewModel() {
        subscriber = loginViewModel.userSubject.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                self.showAlert(K.Failure, error.localizedDescription)
            default: break
            }
        }) { (value) in
            DispatchQueue.main.async {
                self.handleRespone(value)
            }
        }
    }
    func handleRespone(_ value: Int) {
        switch(value){
        case 200:
            self.navigateToHomeVC()
            break
        case 400:
            self.showAlert(K.Failure, K.missingField)
            break
        case 401:
            self.showAlert(K.Failure, K.incorrectCredentials)
            break
        default:
            break
        }
    }
    
    func navigateToHomeVC(){
        let homeVC = UIStoryboard(name: K.Main, bundle: nil).instantiateViewController(withIdentifier: K.HomeViewController) as! HomeViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
