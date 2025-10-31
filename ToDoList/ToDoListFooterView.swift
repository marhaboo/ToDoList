//
//  ToDoListFooterView.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 30/10/25.
//

import UIKit
import SnapKit

class ToDoListFooterView: UITableViewHeaderFooterView {
    
    let addButton = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupAddButton()
        updateConstraints()
        
        setNeedsUpdateConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAddButton(){
        contentView.addSubview(addButton)
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        addButton.setImage(image, for: .normal)
        addButton.tintColor = .white

        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 36/2
        
    }
    
   override func updateConstraints() {
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(384)
            make.height.width.equalTo(36)
          
             
            super.updateConstraints()
        }
    }


}
