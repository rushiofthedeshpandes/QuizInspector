//
//  HomeViewController.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 21/07/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inspectionIdLabel: UILabel!
    @IBOutlet weak var inspectionLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var buttonStart: UIButton!
    
    var viewModel : InspectionViewModel!
    private let apiManager = APIManager()
    private var subscriber: AnyCancellable?
    private var root : Root?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        fetchQuestions()
        observeViewModel()
        // Do any additional setup after loading the view.
    }
    
    private func setupViewModel() {
        viewModel = InspectionViewModel(apiManager: apiManager,
                                      endpoint: .questionsFetch)
    }
       
    private func fetchQuestions() {
        viewModel.fetchQuestions()
    }
       
    private func observeViewModel() {
        subscriber = viewModel.inspectionSubject.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (root) in
            DispatchQueue.main.async {
                print("Root object : \(root)")
                self.root = root
                self.configureUI()
            }
        }
    }
    @IBAction func startButtonClicked(_ sender: Any) {
        let categoryVC = UIStoryboard(name: K.Main, bundle: nil).instantiateViewController(withIdentifier: K.CategoriesViewController) as! CategoriesViewController
        if let newRoot = self.root {
            categoryVC.root = newRoot
            categoryVC.categories = newRoot.inspection.survey.categories
        }
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    private func configureUI(){
        guard let newRoot = self.root else { return}
        self.inspectionIdLabel.text = "Inspection ID : \(newRoot.inspection.id)"
        self.inspectionLabel.text = "Inspection Type : \(newRoot.inspection.inspectionType.name)"
        self.areaLabel.text = "Area : \(newRoot.inspection.area.name)"
    }
}

