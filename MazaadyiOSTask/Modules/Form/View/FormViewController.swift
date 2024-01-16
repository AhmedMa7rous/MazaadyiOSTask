//
//  FormViewController.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 12/01/2024.
//

import UIKit
import iOSDropDown

//MARK: Protocol
protocol FormViewProtocol: NSObject {
    func updateCategoryAndSubcategory()
    func updateProperties()
    func updateModels()
    func updateTransmissionType()
}

class FormViewController: UIViewController {

    //MARK: Outlet Connections
    @IBOutlet weak var categoriesDropDown: LabeledDropDown!
    @IBOutlet weak var subCategoryDropDown: LabeledDropDown!
    @IBOutlet weak var processTypeDropDown: LabeledDropDown!
    @IBOutlet weak var brandDropDown: LabeledDropDown!
    @IBOutlet weak var modelDropDown: LabeledDropDown!
    @IBOutlet weak var typeDropDown: LabeledDropDown!
    @IBOutlet weak var transmissionDropDown: LabeledDropDown!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet var DropDowns: [LabeledDropDown]!
    
    //MARK: Properties
    
    private(set) var presenter: FormPresenterProtocol!
    let specifyTextField = UITextField()
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        presenter = FormPresenter(formView: self)
        presenter.fetchMainCategories()
        getAfterSelect()
        updateCategoryAndSubcategory()
    }

    //MARK: Action Connections
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        presenter.allSelectedData["Process type"] = (presenter.allSelectedData["Process type"] ?? "") + " - " + (specifyTextField.text ?? "")
        let vc = SelectedDataViewController()
        vc.presenter.selectedData = self.presenter.allSelectedData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Support Functions
    
    //This function responsible for every thing related with UI
    private func updateUi() {
        setUpNavigationBar()
        setUpDropDown()
    }
    
    ///This is a support function (support updateUi function) to set up navigation bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    ///This is a support function (support updateUi function) to set up  DropDowns UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpDropDown() {
        for dropDown in DropDowns {
            dropDown.isEnabled = false
        }
    }
    
    ///This is a support function responsible for add a new TextField  to the stackView dynamically to let user type his specifications
    private func addSpecifyTextField(at index: Int) {
        specifyTextField.accessibilityIdentifier = "Specify here"
        specifyTextField.borderStyle = .roundedRect
        specifyTextField.placeholder = " Specify here"
        specifyTextField.backgroundColor = .systemBackground
        
       formStackView.insertArrangedSubview(specifyTextField, at: index)
    }
    
    ///This function responsible for what happend after select an option from each dropdown
    private func getAfterSelect() {
        categoriesDropDown.didSelect { [weak self] selectedText, index, _ in
            guard let self = self else { return }
            self.presenter.allSelectedData["Category"] = selectedText
            self.presenter.mainCategoryIndex = index
            if self.presenter.subCategories != nil && self.presenter.subCategories?.count != 0{
                self.subCategoryDropDown.isEnabled = true
                self.subCategoryDropDown.text = ""
                self.updateCategoryAndSubcategory()
            }
        }
        
        subCategoryDropDown.didSelect { [weak self] selectedText, index, _ in
            self?.presenter.allSelectedData["SubCategory"] = selectedText
            self?.presenter.subCategoryIndex = index
            self?.presenter.fetchProperties()
        }
        
        subCategoryDropDown.listDidDisappear { [weak self] in
            self?.updateTransmissionType()
            if self?.presenter.processTypeOptions != nil {
                self?.processTypeDropDown.isEnabled = true
                self?.brandDropDown.isEnabled = true
                self?.transmissionDropDown.isEnabled = true
            } else {
                self?.brandDropDown.isEnabled = true
                self?.transmissionDropDown.isEnabled = true
            }
        }
        
        processTypeDropDown.didSelect { [weak self] selectedText, index, _ in
            self?.presenter.allSelectedData["Process type"] = selectedText
            self?.presenter.brandOptionIndex = index
            if selectedText == "Other" {
                self?.addSpecifyTextField(at: 3)
            }
        }
        
        brandDropDown.didSelect { [weak self] selectedText, index, id in
            self?.presenter.allSelectedData["Brand"] = selectedText
            self?.presenter.brandOptionIndex = index
            self?.presenter.fetchOptionsChild()
            self?.modelDropDown.isEnabled = true
        }
        
        modelDropDown.didSelect { [weak self] selectedText, index, id in
            self?.presenter.allSelectedData["Model"] = selectedText
            if self?.presenter.typeOptions != nil {
                self?.typeDropDown.isEnabled = true
            } else {
                self?.typeDropDown.isEnabled = false
            }
        }
        typeDropDown.didSelect { [weak self] selectedText, index, id in
            self?.presenter.allSelectedData["Type"] = selectedText
        }
        transmissionDropDown.didSelect { [weak self] selectedText, index, id in
            self?.presenter.allSelectedData["Transmission type"] = selectedText
        }
    }
    
    private func getProcessTypes() -> [String] {
        guard let processTypeOptions = self.presenter.processTypeOptions else { return [] }
        return processTypeOptions.compactMap({ $0.name })
    }
    
    private func getBrands() -> [String] {
        guard let brands = self.presenter.brandOptions else { return [] }
        return brands.compactMap({ $0.name })
    }
}
//MARK: Protocol Functions
extension FormViewController: FormViewProtocol {
    
    func updateCategoryAndSubcategory() {
        categoriesDropDown.optionArray = presenter.mainCategories.compactMap({ $0.name })
        
        guard let subCategories = presenter.subCategories else { return }
        subCategoryDropDown.optionArray = subCategories.compactMap({ $0.name })
    }
    
    func updateProperties() {
        var processTypes = getProcessTypes()
        processTypes.append("Other")
        processTypeDropDown.optionArray = processTypes
        
        let brands = getBrands()
        brandDropDown.optionArray = brands
    }
    
    func updateModels() {
        guard let modelOptions = presenter.modelOptions else { return }
        modelDropDown.optionArray = modelOptions.compactMap({ $0.name })
    }
    
    func updateTransmissionType() {
        guard let transmissionOptions = presenter.transmissionOptions else { return }
        transmissionDropDown.optionArray = transmissionOptions.compactMap({ $0.name })
    }
}

