//
//  ViewController.swift
//  HomeWork 11
//
//  Created by Влад Бокин on 01.10.2021.
//

import UIKit

class ViewController: UIViewController {
    var timer: Timer?
    var timeLeft = 0
    
    @IBOutlet weak var soundSettingViewOutlet: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func startButtonAction(_ sender: UIButton) {
        
        UIPickerView.animate(withDuration: 0.6) {
            self.picker.alpha = 0
            }
        
        UIView.animate(withDuration: 1.0, delay: 0.5) {
            self.shapeView.alpha = 1
            }
        
        
        if seconds != 0 {
            timeLeft = seconds
        } else {
            timeLeft = 1
        }
        if minutes != 0 {
            timeLeft = (timeLeft * 60) * minutes
        }
        if hour != 0{
            timeLeft *= (timeLeft * 60) * hour
        }
        UILabel.animate(withDuration: 1.0, delay: 0.5) {
            self.timerLabel.alpha = 1
            self.timerLabel.text = "\(self.timeLeft)"
            }
        
        basicAnimation()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeLeft != 0 {
                print("\(self.timeLeft)")
                self.timeLeft -= 1
                self.timerLabel.text = "\(self.timeLeft)"
            } else {
                timer.invalidate()
                UIPickerView.animate(withDuration: 1.0) {
                    self.picker.alpha = 1
                    }
                UIView.animate(withDuration: 1.0) {
                    self.shapeView.alpha = 0
                    }
                
                UILabel.animate(withDuration: 1.0, delay: 0.5) {
                    self.timerLabel.alpha = 0
                    self.timerLabel.text = ""
                    }
               
            }
        }
    }
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        UIPickerView.animate(withDuration: 1.0) {
            self.picker.alpha = 1
            }
        UIView.animate(withDuration: 1.0) {
            self.shapeView.alpha = 0
            }
        UILabel.animate(withDuration: 1.0, delay: 0.5) {
            self.timerLabel.alpha = 0
            }
        
        timeLeft = 0
        timer?.invalidate()
        self.timerLabel.text = ""
    }
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    
    
    let picker = UIPickerView()
   
    let shapeView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Shape")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shapeView.alpha = 0
        timerLabel.alpha = 0
        timerLabel.textColor = .white
        timerLabel.text = ""
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: 50, y: 70, width: self.view.frame.width - 100, height: 200)
        picker.setValue(UIColor.white, forKey: "textColor")
        view.addSubview(picker)
        roundedButton()
        setContraint()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationCircular()
    }
 
    func roundedButton(){
        cancelButton.layer.cornerRadius = 45
        startButton.layer.cornerRadius = 45
        soundSettingViewOutlet.layer.cornerRadius = 10
    }

    //MARK: - Animation
    let shapeLayer = CAShapeLayer()
   
    func animationCircular(){
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        //MARK: - BezierPath
        let circularPath = UIBezierPath(arcCenter:  center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
    
        //MARK: - shapeLayer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 15
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = CGColor(red: 100, green: 0, blue: 0, alpha: 1.0)
        shapeView.frame = CGRect(x: 40, y: 40, width: 300, height: 300)
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimation(){
        let basicAnmation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnmation.toValue = 0
        basicAnmation.duration = CFTimeInterval(timeLeft)
        basicAnmation.fillMode = CAMediaTimingFillMode.forwards
        basicAnmation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnmation, forKey: "basicAnimation")
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 12
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 0
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) ч"
        case 1:
            return "\(row) мин"
        case 2:
            return "\(row) с"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
                case 0:
                    hour = row
                case 1:
                    minutes = row
                case 2:
                    seconds = row
                default:
                    break;
                }
    }
    
    func setContraint(){
    view.addSubview(shapeView)
    NSLayoutConstraint.activate([
        shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        shapeView.heightAnchor.constraint(equalToConstant: 300),
        shapeView.widthAnchor.constraint(equalToConstant: 300)
    ]
    )
    }
}
