//
//  PickerView.swift v.0.1.2
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 08.09.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

// from https://www.credera.com/blog/custom-application-development/creating-a-dropdown-field-in-swift-for-ios/

import UIKit

/** Extension UITextField and class PickerView provide a simple data selector.

 Example:

 @IBOutlet var calendarSelector: UITextField!

 override func viewDidLoad() {
 super.viewDidLoad()

 calendarSelector.loadDropdownData(data: ["A", "B", "C", "D", "E", "F", "G", "H", "I"], selectionHandler: { selectedText in
 print("selected: \(selectedText)")
 })
 }
 */

extension UITextField {
    /// Attaches a PickerView to the UITextField input field.
    ///
    /// - Parameters:
    ///   - data: array of strings to be presented for selection by the picker
    ///   - selectionHandler: on selection callback will be called, with the selected string
    func loadDropdownData(data: [String], selectionHandler: @escaping (_ selectedText: String) -> Void) {
        inputView = PickerView(pickerData: data, dropdownField: self, onSelect: selectionHandler)
    }
}

/// Callback conveying the string selected by the PickerView
typealias onSelectCallback = (String) -> Void

class PickerView: UIPickerView {
    var pickerData: [String]!
    var pickerTextField: UITextField!
    var onSelect: onSelectCallback?

    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: .zero)

        self.pickerData = pickerData
        pickerTextField = dropdownField

        delegate = self
        dataSource = self

        if pickerData.count > 0 {
            pickerTextField.text = self.pickerData[0]
            pickerTextField.isEnabled = true
        } else {
            pickerTextField.text = nil
            pickerTextField.isEnabled = false
        }
    }

    init(pickerData: [String], dropdownField: UITextField, onSelect: @escaping onSelectCallback) {
        super.init(frame: .zero)

        self.pickerData = pickerData
        pickerTextField = dropdownField
        self.onSelect = onSelect

        delegate = self
        dataSource = self

        DispatchQueue.main.async {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
        printClassAndFunc(info: "selectionHandler=\(String(describing: onSelect))")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PickerView: UIPickerViewDataSource {
    /// Provides the number of components (or “columns”) in picker view
    ///
    /// - Parameter pickerView: the view requesting the data
    /// - Returns: the number of components (or “columns”) that the picker view should display
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    /// Provides the number of rows for a specified component
    ///
    /// - Parameters:
    ///   - pickerView: the view requesting the data
    ///   - numberOfRowsInComponent:
    /// - Returns: The number of rows for the component
    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return pickerData.count
    }
}

extension PickerView: UIPickerViewDelegate {
    // This function sets the text of the picker view to the content of the "pickerData array
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return pickerData[row]
    }

    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        printClassAndFunc(info: "\(row) \(component) selectionHandler=\(String(describing: onSelect))")
        pickerTextField.text = pickerData[row]
        pickerTextField.resignFirstResponder()
        if pickerTextField.text != nil {
            onSelect?(pickerTextField.text!)
        }
    }
}
