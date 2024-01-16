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
    var brandOptionIndex: Int? { get set }
    var allSelectedData: [String : String] { get set }
    var mainCategories: [Category] { get }
    var subCategories: [Category]? { get }
    var properties: [Property] { get }
    var processTypeOptions: [Option]? { get }
    var brandOptions: [Option]? { get }
    var modelOptions: [Option]? { get }
    var typeOptions: [Option]? { get }
    var transmissionOptions: [Option]? { get }
    //MARK: - Methods
    func fetchMainCategories()
    func fetchProperties()
    func fetchOptionsChild()
    func getAllSelectedData() -> [String : String]
    
}

class FormPresenter {
    //MARK: - Properties
    weak var formView: FormViewProtocol?
    var mainCategories = [Category]()
    var subCategories: [Category]? {
        if let selected = mainCategoryIndex, selected < mainCategories.count {
            return mainCategories[selected].children ?? []
        }
        return nil
    }
    var properties = [Property]()
    var processTypeOptions: [Option]? {
        if properties[0].name == "Process  Type" {
            print("Found Proccess Type")
            return properties[0].options
        } else {
            return nil
        }
    }
    var brandOptions: [Option]? {
        if properties[0].name == "Brand" {
            print("Found Brands in 0")
            return properties[0].options
        } else if properties[1].name == "Brand" {
            print("Found Brands in 1")
            return properties[1].options
        } else {
            return nil
        }
    }
    var modelOptions: [Option]?
    var typeOptions: [Option]? {
        var options: [Option]?
        for property in properties {
            if property.name == "Type" {
                options = property.options
                break
            }
        }
        return options
    }
    var transmissionOptions: [Option]? {
        var options: [Option]?
        for property in properties {
            if property.name == "Transmission Type" {
                options = property.options
                break
            }
        }
        return options
    }
    var mainCategoryIndex: Int?
    var subCategoryIndex: Int?
    var brandOptionIndex: Int?
    var allSelectedData: [String : String] = [:]
    var networkError: String = ""
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
                self?.formView?.updateCategoryAndSubcategory()
            case .failure(let error):
                self?.networkError = "Invalid"
                print("Error fetching main categories: \(error.localizedDescription)")
            }
        })
    }
    
    func fetchProperties() {
        guard let subCategories = self.subCategories else { return }
        networkManager.fetchProperties(forCategory: subCategories[subCategoryIndex ?? 0].id) { [weak self] result in
            switch result {
            case .success(let properties):
                self?.properties = properties.data
                self?.formView?.updateProperties()
            case .failure(let error):
                self?.networkError = "Invalid"
                print("Error fetching properties: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchOptionsChild() {
        guard let brandOptions = self.brandOptions else { return }
        networkManager.fetchOptionsChild(forOptionId: brandOptions[brandOptionIndex ?? 0].id) { [weak self] result in
            switch result {
            case .success(let models):
                print("Successsssssss")
                self?.modelOptions = models.data[0].options
                self?.formView?.updateModels()
            case .failure(let error):
                self?.networkError = "Invalid"
                print("Error fetching models: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllSelectedData() -> [String : String] {
        return allSelectedData
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
