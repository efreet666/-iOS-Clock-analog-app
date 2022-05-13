//
//  SecondViewController.swift
//  HomeWork 11
//
//  Created by Влад Бокин on 05.10.2021.
//

import UIKit

protocol clockDelegate{
    func setTime(time: String)
}

class SecondViewController: UIViewController {
    var timeArray: [AlarmClock] = [AlarmClock]()
    @IBOutlet weak var alarmTableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBAction func editBarButtonAction(_ sender: Any) {
        alarmTableView.isEditing = !alarmTableView.isEditing
    }
    
    //MARK: - add new alarm clock
    @IBAction func addBarButtonAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVC" {
            if let vc = segue.destination as? SecondModalViewController {
                vc.delegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.alarmTableView.dataSource = self
        self.alarmTableView.delegate = self
        
        self.registerTableViewCells()
        
        settingsButton.layer.cornerRadius = 30
      
    }
    
    private func registerTableViewCells(){
         let alarmCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.alarmTableView.register(alarmCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
}

extension SecondViewController: clockDelegate{
    func setTime(time: String) {
        let time = AlarmClock(time: time, isEnable: true)
        timeArray.append(time)
        self.alarmTableView.reloadData()
    }
   
}
extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell{
            cell.timeLabelOutlet.text = timeArray[indexPath.row].time
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.black
                cell.selectedBackgroundView = backgroundView
            return cell
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            timeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showVC", sender: nil)
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVC" {
            if let vc = segue.destination as? SecondModalViewController {
                vc.selectedMinute = timeArray[indexPath.row].time
            }
        }
        }
}
}
