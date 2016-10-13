//
//  ViewController.swift
//  练习
//
//  Created by 彭盛凇 on 16/10/13.
//  Copyright © 2016年 huangbaoche. All rights reserved.
//

import UIKit

let screen_height = UIScreen.main.bounds.height
let screen_width  = UIScreen.main.bounds.width

class ViewController: UIViewController {
    
    let picker: UIImagePickerController = UIImagePickerController()
    
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height / 2)
        imageView.image = UIImage(named: "25201AC7F8318DDACDD56C19E36C1FB1.jpg")
        return imageView
    }()
    
    lazy var photoLibrary: UIButton = {
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: screen_height / 2, width: screen_width, height: screen_height / 4)
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(ViewController.doAction(button:)), for: UIControlEvents.touchUpInside)
        button.setTitle("打开相册", for: UIControlState.normal)
        button.tag = 123
        
        return button
    }()
    
    lazy var cameraButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: screen_height * 3 / 4, width: screen_width, height: screen_height / 4)
        button.backgroundColor = UIColor.cyan
        button.addTarget(self, action: #selector(ViewController.doAction(button:)), for: UIControlEvents.touchUpInside)
        button.setTitle("打开相机", for: UIControlState.normal)
        button.tag = 456
        
        return button
    }()
    
    func doAction(button:UIButton) {
        
        switch button.tag {
        case 123:
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary      //相册  默认
        case 456:
//            判断有没有相机
            if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                
                let alert = UIAlertController(title: "错误", message: "没有相机", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "知道啦", style: .cancel, handler: { [weak self] (UIAlertAction) in
                    guard let strongSelf = self else { return }
                    strongSelf.dismiss(animated: true, completion: nil)
                    }))
                
                self.present(alert, animated: true, completion: nil)
            }else{//有相机
                
            picker.sourceType = UIImagePickerControllerSourceType.camera            //相机
            }
        default:
            picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum  //存储
        }
        
        picker.delegate = self
        
        picker.allowsEditing = true
        
//        无法push导航控制器
//        navigationController?.pushViewController(picker, animated: true)
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)
        view.addSubview(photoLibrary)
        view.addSubview(cameraButton)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage ?? UIImage()
        
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
