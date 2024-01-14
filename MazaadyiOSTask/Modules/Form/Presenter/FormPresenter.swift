//
//  FormViewModel.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 12/01/2024.
//

import Foundation

protocol FormPresenterProtocol {
    //MARK: - Properties
    var mainCategoryIndex: Int? { get set }
    var subCategoryIndex: Int? { get set }
    var mainCategories: [Category] { get }
    var subCategories: [Category] { get }
    var properties: [Property] { get }
    var propertiesOptions: [Option] { get }
    var brandOptions: [Option] { get }
    
    //MARK: - Methods
    func fetchMainCategories()
    func fetchProperties()
    //func fetchOptionsChild()
    func getAllSelectedData() -> [String]
    
}

class FormPresenter {
    //MARK: - Properties
    weak var formView: FormViewProtocol?
    var mainCategories = [Category]()
    var subCategories: [Category] {
        if let selected = mainCategoryIndex, selected < mainCategories.count {
            return mainCategories[selected].children ?? []
        }
        return []
    }
    var properties = [Property]()
    var propertiesOptions: [Option] {
        
        properties[0].options
    }
    var brandOptions: [Option] {
        properties[1].options
    }
    var mainCategoryIndex: Int?
    var subCategoryIndex: Int?
    private var networkManager: NetworkManagerProtocol
    
    //MARK: - LifCycle
    
    init(formView: FormViewProtocol?, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
        self.formView = formView
    }
    
}


extension FormPresenter: FormPresenterProtocol {
    
    //MARK: Intents
    func fetchMainCategories() {
        networkManager.fetchAllCategories(completion: { [weak self] result in
            switch result {
            case .success(let categories):
                self?.mainCategories = categories.data.categories
                self?.formView?.updateDataSource()
            case .failure(let error):
                print("Error fetching main categories: \(error.localizedDescription)")
            }
        })
    }
    
    func fetchProperties() {
        networkManager.fetchProperties(forCategory: mainCategories[mainCategoryIndex ?? 0].id) { [weak self] result in
            switch result {
            case .success(let properties):
                self?.properties = properties.data
                self?.formView?.updateDataSource()
            case .failure(let error):
                print("Error fetching properties: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllSelectedData() -> [String] {
        [mainCategories[mainCategoryIndex ?? 0].name]
//        let selectedSubCategory = subCategories[subCategoryIndex ?? 0].name
    }
}


//class MockNetworkManager: NetworkManagerProtocol {
//    static let results = Categories(code: 1, msg: "message", data: DataClass(categories: []))
//    
//    func fetchAllCategories(completion: @escaping (Result<Categories, APIError>) -> Void) {
//        completion( .success(MockNetworkManager.results))
//    }
//    
//    
//}
//let viewModel = FormViewModel(networkManager: MockNetworkManager())
//viewModel.fetchMainCategories()
//viewModel.mainCategories.value == MockNetworkManager.results
