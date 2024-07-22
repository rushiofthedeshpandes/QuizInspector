//
//  Constants.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 21/07/24.
//

import Foundation

struct K{
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
  
    static let HTTP_POST = "POST"
    static let HTTP_GET = "GET"
    static let application_json = "application/json"
    static let content_type = "Content-Type"
    
    static let Main = "Main"
    static let QuestionaireViewController = "QuestionaireViewController"
    static let CategoriesViewController = "CategoriesViewController"
    static let HomeViewController = "HomeViewController"
    static let RegisterViewController = "RegisterViewController"
    static let HomeTableCell = "HomeTableCell"

    
    static let baseURL = "http://127.0.0.1:5001/api/"
    static let startInspection = "inspections/start"
    static let login = "login"
    static let register = "register"
    static let submit = "inspections/submit"
    
    
    static let unknownError = "Unknown error"
    static let Failure = "Failure"
    static let Error = "Error"
    static let Success = "Success"
    static let okay = "Okay"
    static let invalidInput = "Invalid Input"
    static let registerHere = "Register here"
    static let dontHaveAnAccount = "Don’t have an acount?"
    
    
    static let failedToRegisterUser = "Failed to register user."
    static let registrationSuccess = "Registration successful !"
    static let submissionSuccess = "Inspection submission successful !"
    static let missingField = "One of fields are missing. Please enter valid details."
    static let incorrectCredentials = "Incorrect credentials/ The user does not exist "
    static let userAlreadyExists  = "The user already exists."
    static let surveyCompleted  = "Survey completed"
    static let selectNextCategory  = "Please select the next category."
    static let emailShouldBeValid = "Email id should be valid"
    static let passwordShouldBeNonEmpty = "Password cannot be empty"
    static let emailShouldBeNonEmpty = "Email id cannot be empty"
    static let expectedPassword = "At least minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"
    static let submissionError = "There was an error submitting inspection. Please try again. "
    static let noInspectionCompleted = "No Inspection Completed. Please complete at least one inspection to submit.  "

    static let REQUEST_EMAIL = "email"
    static let REQUEST_PASSWORD = "password"
    static let REQUEST_ROOT = "root"
    static let REQUEST_INSPECTION = "inspection"
    static let REQUEST_AREA = "area"
    static let REQUEST_ID = "id"
    static let REQUEST_NAME = "name"
    static let REQUEST_INSPECTIONTYPE = "inspectionType"
    static let REQUEST_ACCESS = "access"
    static let REQUEST_SURVEY = "survey"
    static let REQUEST_CATEGORIES = "categories"
    static let REQUEST_QUESTIONS = "questions"
    static let REQUEST_ANSWERCHOICES = "answerChoices"
    static let REQUEST_SCORE = "score"
    static let REQUEST_SELECTEDANSERCHOICEID = "selectedAnswerChoiceId"
    
    
}
