//
//  CategoriesViewController.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 21/07/24.
//

import UIKit
import Combine

class CategoriesViewController: UIViewController {

    var categories : [Category] = []
    var updatedCategories : [Category] = []
    var root : Root?
    
    var submitInspectionViewModel : SubmitInspectionViewModel!
    private let apiManager = APIManager()
    private var subscriber: AnyCancellable?
    
    @IBOutlet weak var categoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addSubmitButton()
        setupViewModel()
        observeViewModel()
    }
    
    func addSubmitButton(){
        let barButtonAddNewUser = UIBarButtonItem(title: "Submit",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(submitInspection))
        self.navigationItem.rightBarButtonItem = barButtonAddNewUser
    }
    
}

//MARK: -VIEW MODEL METHODS & OPERATIONS 
extension CategoriesViewController {
    private func setupViewModel() {
        submitInspectionViewModel = SubmitInspectionViewModel(endpoint: .submit)
    }
    
    private func submit(_ root: Root) {
        submitInspectionViewModel.performAction(root)
    }
    
    private func observeViewModel() {
        subscriber = submitInspectionViewModel.inspectionSubject.sink(receiveCompletion: { (resultCompletion) in
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
    
    @objc func submitInspection(){
        guard updatedCategories.count > 0 else{
            self.showAlert(K.Failure, K.noInspectionCompleted)
            return
        }
        guard let newRoot = root else {
            self.showAlert(K.Failure, K.missingField)
            return
        }
        submit(newRoot)
    }
    
    func handleRespone(_ value: Int) {
        switch(value){
        case 200:
            self.showAlert(K.Success, K.submissionSuccess){
                self.navigationController?.popViewController(animated: true)
            }
            break
        case 500:
            self.showAlert(K.Failure, K.submissionError)
            break
        default:
            break
        }
    }
}


//MARK: -UITABLEVIEW DATASOURCE & DELEGATE METHODS
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource{

    func setupTableView(){
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        self.categoryTableView.backgroundColor = .clear

        registerCells()
    }

    func registerCells(){
        categoryTableView.register(HomeTableCell.register(),
                                   forCellReuseIdentifier: HomeTableCell.identifier)
    }

    func reloadTableView(){
        DispatchQueue.main.async {
            self.categoryTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.identifier, 
                                                       for: indexPath) as? HomeTableCell else{
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let cateogory = categories[indexPath.row]
        cell.setupCell(viewModel: cateogory)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cateogory = categories[indexPath.row]
        let questionVC = UIStoryboard(name: K.Main, bundle: nil).instantiateViewController(withIdentifier: K.QuestionaireViewController) as! QuestionaireViewController
        questionVC.delegate = self
        questionVC.questions = cateogory.questions
        questionVC.category = cateogory
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
}


//MARK: - DATAUPDATER DELEGATE METHODS

extension CategoriesViewController : DataUpdater{
    func didUpdateQuestions(_ questions: [Question]?, for category: Category){
        guard questions != nil else{
            return
        }
        updatedCategories.append(category)
    }
}
    
