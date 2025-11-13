//
//  DetailTaskTableViewCell.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 05/11/25.
//

import UIKit
import SnapKit

class ImportanceTaskTableViewCell: UITableViewCell {
    
     // MARK: - UI Elements
    
   static let identifier = "ImportanceTaskTableViewCell"
    
    let divider = UIView()
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "No"
        label.textColor = .systemRed
        return label
    }()
    let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Importance"
        label.backgroundColor = .systemBackground
        return label
    }()
    
    let mySwitcher: UISwitch = {
        let switcher = UISwitch()
        return switcher
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        setupView()
        setupConstraints()
        mySwitcher.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(containerView)
        divider.backgroundColor = .systemGray
        containerView.backgroundColor = .systemBackground
        containerView.addSubview(divider)
        containerView.addSubview(myLabel)
        containerView.addSubview(mySwitcher)
        containerView.addSubview(statusLabel)
    }
    
     func setupConstraints() {
       
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(contentView.snp.bottom)
        }


        myLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        divider.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
        }

        mySwitcher.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalTo(mySwitcher.snp.leading).offset(-15)
            make.centerY.equalTo(mySwitcher)
        }
         

    }
    
    @objc func switchValueChanged(_ sender: UISwitch){
        if sender.isOn {
            statusLabel.text = "Yes"
            statusLabel.textColor = .systemGreen
        }
        else {
            statusLabel.text = "No"
            statusLabel.textColor = .systemRed
        }
    }
    
    

}
