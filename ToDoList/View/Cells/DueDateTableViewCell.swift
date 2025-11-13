//
//  DueDateTableViewCell.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 05/11/25.
//

import UIKit
import SnapKit

class DueDateTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "DueDateTableViewCell"
    
    var didToggleChange: (() -> Void)?
    
    private var datePickerHeightConstraint: Constraint?
    
    // MARK: - UI Elements
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 22
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Complete by"
        label.backgroundColor = .systemBackground
        return label
    }()
    
    let mySwitcher: UISwitch = {
        let switcher = UISwitch()
        return switcher
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.isHidden = true
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale(identifier: "ru-RU")
        picker.minimumDate = Date()
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 22
        return picker
    }()
    
    let datePickerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        return view
    }()

    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        mySwitcher.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(myLabel)
        containerView.addSubview(mySwitcher)
        contentView.addSubview(datePickerContainer)
        datePickerContainer.addSubview(datePicker)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        myLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        mySwitcher.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        datePickerContainer.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            datePickerHeightConstraint = make.height.equalTo(0).constraint
        }
        datePicker.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - Actions
    @objc private func handleSwitch(_ sender: UISwitch) {
        if sender.isOn {
            datePicker.isHidden = false
            datePickerHeightConstraint?.update(offset: 340)
            containerView.layer.cornerRadius = 0
            
        } else {
            datePickerHeightConstraint?.update(offset: 0)
            containerView.layer.cornerRadius = 22
        }
        
        didToggleChange?()
    }
}
