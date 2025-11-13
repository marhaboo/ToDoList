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

    let divider = UIView()
    let checkMarkButton = UIButton()
    let titleLabel =  UILabel()
    let chevronRightIcon = UIButton(type: .system)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.backgroundColor = .white
        
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        setNeedsUpdateConstraints()
        
      
        
        setTableElements()
        makeConstraints()
        
        
   

    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    func setTableElements() {
        contentView.addSubview(checkMarkButton)
        checkMarkButton.tintColor = UIColor(named: "borderColor")
        checkMarkButton.addTarget(self, action: #selector(toggleList), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        
        divider.backgroundColor = .systemGray
        contentView.addSubview(divider)
        
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

            checkMarkButton.snp.makeConstraints { make in
                        make.centerY.equalToSuperview()
                        make.leading.equalToSuperview().offset(16)
                        make.width.height.equalTo(24)
                    }

            titleLabel.snp.makeConstraints { make in
                        make.top.bottom.equalToSuperview().inset(18)
                        make.leading.equalTo(checkMarkButton.snp.trailing).offset(16)
                        make.trailing.equalToSuperview().offset(-28)
                    }
            divider.snp.makeConstraints { make in
                make.height.equalTo(0.5)
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalTo(titleLabel)
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


        let imageName = isCompleted ? "checkmark.circle.fill" : "circle"
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)

        let image = UIImage(systemName: imageName, withConfiguration: largeConfig)

        checkMarkButton.setImage(image, for: .normal)

        checkMarkButton.tintColor = isCompleted ? .systemGreen : .gray

        

        if isCompleted {
            titleLabel.textColor = .systemGray
            let attributedString = NSAttributedString(
                string: title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = attributedString
          
        } else {
            titleLabel.textColor = .black
            titleLabel.attributedText = NSAttributedString(string: title)
           
        }
        
    }


    
    override func updateConstraints() {

        super.updateConstraints()
    }
    
    

    

}
