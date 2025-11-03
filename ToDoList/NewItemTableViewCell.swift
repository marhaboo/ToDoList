//
//  NewItemTableViewCell.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 01/11/25.
//

import UIKit
import SnapKit

class NewItemTableViewCell: UITableViewCell {

    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.text = "New"
        titleLabel.textColor = .systemGray
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)

         self.backgroundColor = .clear
         self.selectionStyle = .none
         contentView.backgroundColor = .white
         contentView.layer.cornerRadius = 12
         contentView.layer.masksToBounds = true


         
         contentView.snp.makeConstraints { make in
                     make.leading.equalToSuperview().offset(16)
                     make.trailing.equalToSuperview().offset(-16)
                     make.top.equalToSuperview().offset(4)
                
                 }

        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(18)
            make.leading.equalToSuperview().offset(52)
            make.trailing.equalToSuperview().offset(-12)
          
        }
         
        
    }
}
