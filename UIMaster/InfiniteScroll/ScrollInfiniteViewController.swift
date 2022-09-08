//
//  ViewController.swift
//  UIMaster
//
//  Created by geonhui Yu on 2022/08/31.
//

import UIKit

class ScrollInfiniteViewController: UIViewController {
    
    private let rollingStringData: [String] = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    private var selectedIndex = 0
    
    @IBOutlet weak var rollingScrollView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rollingScrollView.delegate = self
        rollingScrollView.dataSource = self
        rollingScrollView.isUserInteractionEnabled = false
        
        self.trigger()
    }
    
    private func trigger() {
        
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(scrollIndex), userInfo: nil, repeats: true)
    }
    
    @objc func scrollIndex() {
        
        let row: Int = selectedIndex
        
        rollingScrollView.selectRow(row, inComponent: 0, animated: true)
        selectedIndex = selectedIndex + 1
    }
}

extension ScrollInfiniteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10000
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let oneWeeky = self.rollingStringData
        return oneWeeky[row % oneWeeky.count]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rollingScrollView.reloadComponent(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let oneWeek = rollingStringData
        let textFiled = UITextField()
        
        pickerView.subviews.forEach { $0.backgroundColor = .clear }
        
        if oneWeek.count == 0 {

            return textFiled

        } else {
            
            textFiled.text = oneWeek[row % rollingStringData.count]
            textFiled.textAlignment = .center
            return textFiled
        }
    }
    
}
