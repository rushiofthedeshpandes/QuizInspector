//
//  UserModelTests.swift
//  QuizInspectorTests
//
//  Created by Rushikesh Deshpande on 21/07/24.
//

import XCTest
@testable import QuizInspector
final class UserModelTests: XCTestCase {
    
    var viewModel: UserViewModel?
    
    override func setUpWithError() throws {
        viewModel = UserViewModel(endpoint: nil)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
//MARK: - Invalid Test Cases
    func testInvalidEmail(){
        guard let viewModel else {
            XCTFail("ViewModel Cannot be nil")
            return
        }
        
        let loginModel1 = UserModel(email: nil, password: "Rushi@123")
        let loginModel2 = UserModel(email: "", password: "Rushi@123")
        let loginModel3 = UserModel(email: "Rushi", password: "Rushi@123")
        let loginModel4 = UserModel(email: "Rushi@123", password: "Rushi@123")
        let loginModel5 = UserModel(email: "Rushi.com", password: "Rushi@123")
        let loginModel6 = UserModel(email: "Rushi.com@123", password: "Rushi@123")
        
        let result1 = viewModel.validationCheck(loginModel1).isSuccess
        let result2 = viewModel.validationCheck(loginModel2).isSuccess
        let result3 = viewModel.validationCheck(loginModel3).isSuccess
        let result4 = viewModel.validationCheck(loginModel4).isSuccess
        let result5 = viewModel.validationCheck(loginModel5).isSuccess
        let result6 = viewModel.validationCheck(loginModel6).isSuccess
        
        XCTAssertFalse(result1)
        XCTAssertFalse(result2)
        XCTAssertFalse(result3)
        XCTAssertFalse(result4)
        XCTAssertFalse(result5)
        XCTAssertFalse(result6)
    }
    
    
    func testInvalidPassword(){
        guard let viewModel else {
            XCTFail("ViewModel Cannot be nil")
            return
        }
        
        let loginModel1 = UserModel(email: "Rushi@gmail.com", password: nil)
        let loginModel2 = UserModel(email: "Rushi@gmail.com", password: "")
        let loginModel3 = UserModel(email: "Rushi@gmail.com", password: "Rushi")
        let loginModel4 = UserModel(email: "Rushi@gmail.com", password: "12345678")
        let loginModel5 = UserModel(email: "Rushi@gmail.com", password: "Rushi123")
        let loginModel6 = UserModel(email: "Rushi@gmail.com", password: "123Viv")
        
        let result1 = viewModel.validationCheck(loginModel1).isSuccess
        let result2 = viewModel.validationCheck(loginModel2).isSuccess
        let result3 = viewModel.validationCheck(loginModel3).isSuccess
        let result4 = viewModel.validationCheck(loginModel4).isSuccess
        let result5 = viewModel.validationCheck(loginModel5).isSuccess
        let result6 = viewModel.validationCheck(loginModel6).isSuccess
        
        XCTAssertFalse(result1)
        XCTAssertFalse(result2)
        XCTAssertFalse(result3)
        XCTAssertFalse(result4)
        XCTAssertFalse(result5)
        XCTAssertFalse(result6)
    }
    
//MARK: - Valid Test Cases
     func testValidEmail(){
        guard let viewModel else {
            XCTFail("ViewModel Cannot be nil")
            return
        }
        
        let loginModel1 = UserModel(email: "Rushi@gmail.com", password: "Rushi@123")
        let loginModel2 = UserModel(email: "Rushi@phntechnology.com", password: "Rushi@123")
        let loginModel3 = UserModel(email: "sdfijd@asdkf.rav", password: "Rushi@123")
       
        let result1 = viewModel.validationCheck(loginModel1).isSuccess
        let result2 = viewModel.validationCheck(loginModel2).isSuccess
        let result3 = viewModel.validationCheck(loginModel3).isSuccess
     
        XCTAssertTrue(result1)
        XCTAssertTrue(result2)
        XCTAssertTrue(result3)
    }
    
    func testValidPassword(){
       guard let viewModel else {
           XCTFail("ViewModel Cannot be nil")
           return
       }
       
       let loginModel1 = UserModel(email: "Rushi@gmail.com", password: "Rushi@123")
       let loginModel2 = UserModel(email: "Rushi@gmail.com", password: "Rushi@123")
       let loginModel3 = UserModel(email: "Rushi@gmail.com", password: "@1234Rushi")
      
       let result1 = viewModel.validationCheck(loginModel1).isSuccess
       let result2 = viewModel.validationCheck(loginModel2).isSuccess
       let result3 = viewModel.validationCheck(loginModel3).isSuccess
    
        XCTAssertTrue(result1)
        XCTAssertTrue(result2)
        XCTAssertTrue(result3)
   }
}
