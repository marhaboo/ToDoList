//
//  ToDoItemTableViewCell.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 27/10/25.
//

import UIKit
import SnapKit

class ToDoItemTableViewCell: UITableViewCell {
    
    var toggleHandler: (() -> Void)?

    let checkMark = UIButton()
    let titleLabel =  UILabel()
    let chevronRightIcon = UIButton(type: .system)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
      
        
        setTableElements()
        makeConstraints()
        
        
   

    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableElements() {
        contentView.addSubview(checkMark)
        checkMark.tintColor = UIColor(named: "borderColor")
        checkMark.addTarget(self, action: #selector(toggleList), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        
        contentView.addSubview(chevronRightIcon)
        chevronRightIcon.tintColor = UIColor(named: "borderColor")
        let chevronConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        chevronRightIcon.setImage(UIImage(systemName: "chevron.right", withConfiguration: chevronConfig), for: .normal)
     
        
    }
    
    @objc func toggleList() {
        toggleHandler?()
        
    }
    
        func makeConstraints() {
            
            contentView.snp.makeConstraints { make in
                        make.leading.equalToSuperview().offset(16)   
                        make.trailing.equalToSuperview().offset(-16)
                        make.top.equalToSuperview().offset(4)
                   
                    }

            checkMark.snp.makeConstraints { make in
                        make.centerY.equalToSuperview()
                        make.leading.equalToSuperview().offset(16)
                        make.width.height.equalTo(24)
                    }

            titleLabel.snp.makeConstraints { make in
                        make.top.bottom.equalToSuperview().inset(18)
                        make.leading.equalTo(checkMark.snp.trailing).offset(12)
                        make.trailing.equalToSuperview().offset(-12)
                    }
            
            chevronRightIcon.snp.makeConstraints { make in          
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(16)
                make.width.height.equalTo(18)
                make.height.equalTo(18)
                
            }

        }
    
    // MARK: - Configure


    func configure(with title: String, isCompleted: Bool, toggleHandler: @escaping () -> Void) {
        self.toggleHandler = toggleHandler
        
        titleLabel.text = title
        let imageName = isCompleted ? "checkmark.circle.fill" : "circle"
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        checkMark.setImage(UIImage(systemName: imageName, withConfiguration: largeConfig), for: .normal)
        
        if isCompleted {
            let attributedString = NSAttributedString(
                string: title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = attributedString
        } else {
            titleLabel.attributedText = NSAttributedString(string: title)
        }
    }

    
    override func updateConstraints() {

        super.updateConstraints()
    }

}
