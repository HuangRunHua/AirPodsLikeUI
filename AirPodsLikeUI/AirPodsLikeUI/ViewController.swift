//
//  ViewController.swift
//  基础知识
//
//  Created by Joker Hook on 2019/1/23.
//  Copyright © 2019 com.icloud@h76joker. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices // 加入震动反馈

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // --- 返回给定组件的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mode.count
    }
    
    // --- 返回给定组件的列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    var imageView: UIImageView! // 设定一个UIImageView对象，用于储存背景图片
    var blurEffect: UIBlurEffect! // 设定一个UIBlurEffect对象，用于添加模糊效果
    var blurView: UIVisualEffectView!
    var addButton: UIButton!
    var myView: UIView!
    var modePicker: UIPickerView!
    var changeButton: UIButton! // 放在picker下面，获取picker的值
    var introLabel: UILabel!
    var myImageView: UIImageView!
    var closeMyViewButton: UIButton! // 用于关闭掉我们的屏幕
    var choseIndex = 0
    var feedbackGenerator : UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .heavy)
    deinit {
        feedbackGenerator = nil
    }
    
    
    let mode = ["dark","light","regular","extraLight","prominent","normal"]
    let distance = 450
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackGenerator?.prepare()
        initAllView()
    }
    
    
    /**
     * 初始化imageView，添加照片
     */
    func addPicture() {
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.imageView!.image = UIImage(named: "back")
        self.view.addSubview(self.imageView!)
    }
    
    // --- 初始化我们的模糊效果 ---
    func addVisualBlur() {
        self.blurEffect = UIBlurEffect(style: .dark)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        self.blurView!.frame.size = self.view.frame.size
        self.blurView!.center = self.view.center
        self.view.addSubview(self.blurView!)
    }
    
    
    func initMyView(distance:Int) {
        self.myView = UIView(frame: CGRect(x: 16, y: self.view.frame.height - 425 + CGFloat(distance), width: view.frame.width - 32, height: 375))
        myView?.layer.cornerRadius = 25.0
        myView?.layer.masksToBounds = true
        myView?.backgroundColor = .white
        self.view.addSubview(myView!)
    }
    
    func initModePicker(distance:Int) {
        modePicker = UIPickerView(frame: CGRect(x: self.view.frame.width/2 - 125 , y: self.view.frame.height - 270 + 16 + CGFloat(distance), width: 250, height: 150))
        modePicker.showsSelectionIndicator = true
        modePicker.delegate = self
        modePicker.dataSource = self
        self.modePicker.selectRow(choseIndex, inComponent: 0, animated: false)
        self.view.addSubview(modePicker)
    }
    
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return mode[row]
    }
    
    // 设置列宽
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 130
        
    }
    //设置行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int)
        -> CGFloat {
            return 40
    }
    
    // --- 初始化按钮 ---
    func addNewButton() {
        self.addButton = UIButton(frame: CGRect(x: view.frame.width - 56, y: 32, width: 40, height: 40))
        //addButton?.backgroundColor = .blue
        addButton?.setBackgroundImage(UIImage(named: "1"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtontapped(sender:)), for: .touchDown)
        self.view.addSubview(self.addButton!)
    }
    
    
    func initChangeButton(distance:Int) {
        changeButton = UIButton(frame: CGRect(x: 32, y: self.view.frame.height - 120 + CGFloat(distance), width: self.view.frame.width - 64, height: 50))
        changeButton.setTitle("确定", for: .normal)
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.backgroundColor = UIColor.purple
        changeButton.layer.cornerRadius = 5.0
        changeButton.layer.masksToBounds = true
        changeButton.addTarget(self, action: #selector(changeButtontapped(sender:)), for: .touchDown)
        //self.myView.addSubview(choseButton)
        self.view.addSubview(changeButton)
    }
    
    func initLabel(distance:Int) {
        introLabel = UILabel(frame: CGRect(x: 32, y: self.view.frame.height - 409 + CGFloat(distance), width: view.frame.width - 64, height: 50))
        introLabel.text = "选择你想要的效果"
        introLabel.textColor = UIColor.darkGray
        
        introLabel.font = UIFont.init(name: "Thonburi", size: 30)
        introLabel.textAlignment = NSTextAlignment.center
        view.addSubview(introLabel)
    }
    
    func initMyImageView(distance:Int) {
        myImageView = UIImageView(frame: CGRect(x: self.view.frame.width/2 - 55, y: self.view.frame.height - 350 + CGFloat(distance), width: 110, height: 110))
        myImageView.image = UIImage(named: "xuanze")
        self.view.addSubview(myImageView)
    }
    
    
    @objc func addButtontapped(sender: UIButton) {
        feedbackGenerator?.impactOccurred()
        UIView.animate(withDuration: 0.25) {
            self.modePicker.frame = CGRect(x: self.view.frame.width/2 - 65 , y: self.view.frame.height - 270 + 16, width: 130, height: 150)
            self.changeButton.frame = CGRect(x: 32, y: self.view.frame.height - 120, width: self.view.frame.width - 64, height: 50)
            self.introLabel.frame = CGRect(x: 32, y: self.view.frame.height - 409, width: self.view.frame.width - 64, height: 50)
            self.myImageView.frame = CGRect(x: self.view.frame.width/2 - 55, y: self.view.frame.height - 350, width: 110, height: 110)
            self.myView.frame = CGRect(x: 16, y: self.view.frame.height - 425, width: self.view.frame.width - 32, height: 375)
            self.closeMyViewButton.frame = CGRect(x: self.view.frame.width - 55, y: self.view.frame.height - 409 - 5, width: 30, height: 30)
        }
    }
    
    func initCloseMyViewButton(distance:Int) {
        closeMyViewButton = UIButton(frame: CGRect(x: self.view.frame.width - 55, y: self.view.frame.height - 409 - 5 + CGFloat(distance), width: 30, height: 30))
        closeMyViewButton.setImage(UIImage(named: "close"), for: .normal)
        closeMyViewButton.addTarget(self, action: #selector(closeMyViewButtonTapped(sender:)), for: .touchDown)
        self.view.addSubview(closeMyViewButton)
    }
    
    // --- 给关闭视图按钮添加动作
    @objc func closeMyViewButtonTapped(sender: UIButton) {
        feedbackGenerator?.impactOccurred()
        UIView.animate(withDuration: 0.25) {
            self.modePicker.frame = CGRect(x: self.view.frame.width/2 - 65 , y: self.view.frame.height - 270 + 16 + CGFloat(self.distance), width: 130, height: 150)
            self.changeButton.frame = CGRect(x: 32, y: self.view.frame.height - 120 + CGFloat(self.distance), width: self.view.frame.width - 64, height: 50)
            self.introLabel.frame = CGRect(x: 32, y: self.view.frame.height - 409 + CGFloat(self.distance), width: self.view.frame.width - 64, height: 50)
            self.myImageView.frame = CGRect(x: self.view.frame.width/2 - 55, y: self.view.frame.height - 350 + CGFloat(self.distance), width: 110, height: 110)
            self.myView.frame = CGRect(x: 16, y: self.view.frame.height - 425 + CGFloat(self.distance), width: self.view.frame.width - 32, height: 375)
            self.closeMyViewButton.frame = CGRect(x: self.view.frame.width - 55, y: self.view.frame.height - 409 - 5 + CGFloat(self.distance), width: 30, height: 30)
        }
    }
    
    // --- 给选择按钮添加动作
    @objc func changeButtontapped(sender: UIButton) {
        feedbackGenerator?.impactOccurred()
        choseIndex = modePicker.selectedRow(inComponent: 0)
        switch choseIndex {
        case 0:
            blurEffect = UIBlurEffect(style: .dark)
        case 1:
            blurEffect = UIBlurEffect(style: .light)
        case 2:
            blurEffect = UIBlurEffect(style: .regular)
        case 3:
            blurEffect = UIBlurEffect(style: .extraLight)
        case 4:
            blurEffect = UIBlurEffect(style: .prominent)
        case 5:
            blurEffect = nil
        default:
            blurEffect = UIBlurEffect(style: .dark)
        }
        print(choseIndex)
        whenTapButtonInitAllView()
    }
    
    func initAllView() {
        addPicture()
        addVisualBlur()
        addNewButton()
        initMyView(distance: distance)
        initModePicker(distance: distance)
        initChangeButton(distance: distance)
        initLabel(distance: distance)
        initMyImageView(distance: distance)
        initCloseMyViewButton(distance: distance)
    }
    
    func whenTapButtonInitAllView() {
        addPicture()
        self.blurView = UIVisualEffectView(effect: blurEffect)
        self.blurView!.frame.size = self.view.frame.size
        self.blurView!.center = self.view.center
        self.view.addSubview(self.blurView!)
        addNewButton()
        initMyView(distance: 0)
        initModePicker(distance: 0)
        self.modePicker.selectRow(choseIndex, inComponent: 0, animated: false)
        initChangeButton(distance: 0)
        initLabel(distance: 0)
        initMyImageView(distance: 0)
        initCloseMyViewButton(distance: 0)
    }
    
    
}

