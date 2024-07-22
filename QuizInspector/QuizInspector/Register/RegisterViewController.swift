//
//  RegisterViewController.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    //MARK: - IBOultets
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var viewModel : UserViewModel!
    private var subscriber: AnyCancellable?
    
    //MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        observeViewModel()
    }
    
    //MARK: - IBActions
    @IBAction func registerButtonClick(_ sender: Any) {
        let registerModel = UserModel(
            email: txtEmailId.text,
            password: txtPassword.text)
        let validationResult = viewModel.validationCheck(registerModel)
        
        guard validationResult.isSuccess else {
            showAlert(K.Error, validationResult.error)
            return
        }
        registerUser(registerModel)
    }
    
    
}

//MARK: - VIEWMODEL METHODS & OPERATIONS
extension RegisterViewController {
    private func setupViewModel() {
        viewModel = UserViewModel(endpoint: .register)
    }
    
    private func registerUser(_ userModel: UserModel) {
        viewModel.performAction(userModel)
    }
    
    private func observeViewModel() {
        subscriber = viewModel.userSubject.sink(receiveCompletion: { (resultCompletion) in
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
            self.showAlert(K.Success, K.registrationSuccess){
                self.navigationController?.popViewController(animated: true)
            }
            break
        case 400:
            self.showAlert(K.Failure, K.missingField)
            break
        case 401:
            self.showAlert(K.Failure, K.userAlreadyExists)
            break
        default:
            break
        }
    }
}
