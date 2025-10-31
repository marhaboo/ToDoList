//
//  ToFoListHeaderView.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 29/10/25.
//

import UIKit
import SnapKit

class ToDoListHeaderView: UITableViewHeaderFooterView {
    
    
    let taskName = UILabel()
    let numberTasks = UILabel()
    let showButton = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(taskName)
        contentView.addSubview(numberTasks)
        contentView.addSubview(showButton)
        
        setupUi()
        updateConstraints()
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUi() {
        taskName.text = "Tasks - "
        taskName.textColor = .lightGray
        
        numberTasks.text = "0"
        numberTasks.textColor = .lightGray
        
        showButton.setTitle("Show", for: .normal)
        showButton.setTitleColor(.systemBlue , for: .normal)
    }
    
    func configure(with count: Int) {
        numberTasks.text = "\(count)"
    }
    
    override func updateConstraints() {
        taskName.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
        
        numberTasks.snp.updateConstraints { make in
            make.leading.equalTo(taskName.snp.trailing).offset(4)
            make.verticalEdges.equalToSuperview()
        }
        
        showButton.snp.updateConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
        
        super.updateConstraints()
    }
  

}
