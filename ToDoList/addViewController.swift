//
//  addViewController.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 01/11/25.
//

import UIKit

class addViewController: UIViewController {
    
    let closeButton = CustomButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCloseButton()
        makeConstraint()
    }
    
    func setupCloseButton(){
        view.addSubview(closeButton)
        view.backgroundColor = .cyan
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(funcCloseButton), for: .touchUpInside)
        
    }
    
    @objc func funcCloseButton() {
        self.dismiss(animated: true)
        
    }
    
   func  makeConstraint() {
       closeButton.snp.makeConstraints { make in
           make.center.equalToSuperview()
       }
    }

}


class CustomButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -200, dy: -200).contains(point)
    }
}
