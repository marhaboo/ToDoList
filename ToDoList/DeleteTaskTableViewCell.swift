//
//  DeleteTaskTableViewCell.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 05/11/25.
//

import UIKit
import SnapKit

class DeleteTaskTableViewCell: UITableViewCell {
    
    var onDeleteTapped: (() -> Void)?

         // MARK: - UI Elements
        
       static let identifier = "DeleteTaskTableViewCell"
        
        let myDeleteButton: UIButton = {
            let button = UIButton()
            button.setTitle("Delete", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 25)
            button.setTitleColor(.systemRed, for: .normal)
            button.backgroundColor = .systemBackground
            return button
        }()
        
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.backgroundColor = .systemBackground
            contentView.layer.cornerRadius = 22
            contentView.clipsToBounds = true
            myDeleteButton.addTarget(self, action: #selector(deleteButton), for: .touchUpInside)
            setupView()
            updateConstraints()
          
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        
        func setupView() {
            contentView.addSubview(myDeleteButton)
        }
        
        override func updateConstraints() {
            super.updateConstraints()
            
            contentView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(20)
                make.bottom.equalToSuperview()
                make.horizontalEdges.equalToSuperview().inset(16)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(100)
            }
            
            myDeleteButton.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.edges.equalToSuperview()
            }
        }
    
    
    @objc  func deleteButton() {
        onDeleteTapped?()
    }
        
        

    }



