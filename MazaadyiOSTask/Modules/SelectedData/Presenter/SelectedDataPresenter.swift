//
//  SelectedDataPresenter.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import Foundation

class SelectedDataPresenter {
    var selectedData: [String : String] = [:]
    
    func getKeys() -> [String] {
        Array(selectedData.keys)
    }
    
    func getValues() -> [String] {
        Array(selectedData.values)
    }
}
