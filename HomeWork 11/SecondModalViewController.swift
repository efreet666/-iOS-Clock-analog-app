//
//  SecondModalViewController.swift
//  HomeWork 11
//
//  Created by Влад Бокин on 05.10.2021.
//

import UIKit

class SecondModalViewController: UIViewController {

    let picker = UIPickerView()
    var hour: String = ""
    var minutes: String = ""
    
    var delegate: clockDelegate?
    
    @IBAction func dismissButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        
        //MARK: - Delegate
        if hour == "0"{
            hour = "00"
        } else{
            if (Int(hour) ?? 1) < 10 && hour != "0"{
                hour = "0" + hour
        }
        }
        if minutes == "0"{
            minutes = "00"
        } else {
        if (Int(minutes) ?? 1) < 10 && minutes != "0" {
            minutes = "0" + minutes
        }
        }
        let element: String = "\(hour):\(minutes)"
        
        delegate?.setTime(time: element)
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerSetup()
    }
    var selectedHour: String = "10"
    var selectedMinute: String = "30"
    func pickerSetup(){
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: 50, y: 70, width: self.view.frame.width - 100, height: 200)
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.selectRow(Int(selectedHour) ?? 0, inComponent: 0, animated: true)
        picker.selectRow(Int(selectedMinute) ?? 0, inComponent: 1, animated: true)
        view.addSubview(picker)
    }


}

extension SecondModalViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        default:
            return 0
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)"
            }
            
        case 1:
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)"
            }
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
                case 0:
                    hour = "\(row)"
                
                case 1:
                    minutes = "\(row)"
                default:
                    break;
                }
    }
}
