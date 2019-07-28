//
//  TemplateFormView.swift
//  MemeGenerator
//
//  Created by Igor on 28/07/2019.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class TemplateFormView: XibView {
    
    // MARK: Clean variables
    var presenter: FormPresenter?
    var templates: [MemeTemplate]?
    
    // MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var templateSelected: UITextField!
    
    override func customConfig() {
        // template picker config
        let pickerView = UIPickerView()
        templateSelected.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func setupWithSuperView(_ superView: UIView) {
        super.setupWithSuperView(superView)
        
        // templates initalization
        // TODO: loading view
        presenter?.findTemplates()
    }
    
}

// MARK: Presenter comunication

extension TemplateFormView {
    
    func onTemplatesFound(_ templates: [MemeTemplate]) {
        logger.info("Templates set!")
        self.templates = templates
    }
    
    func onTemplatesError() {
        logger.error("Templates error!")
    }
    
}

// MARK: Presenter comunication

extension TemplateFormView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.templates?.count ?? 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return templates?[row].name ?? "empty"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        templateSelected.text = templates?[row].name ?? "empty"
        self.endEditing(true)
        // TODO: call presenter to make next form
    }
    
}