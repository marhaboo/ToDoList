//
//  TextViewTableViewCell.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 03/11/25.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    let placeholderText = "Something needs to done"
    var item: ToDoItem?
    
    var onFinish: ((String) -> Void)?
    
    lazy var todoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.text = placeholderText
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = .zero
        textView.textColor = .lightGray
        textView.isScrollEnabled = false    
        textView.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        textView.delegate = self
        contentView.addSubview(textView)
        return textView
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 22
        contentView.clipsToBounds = true
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func configure(with item: ToDoItem?) {
        self.item = item
        
        if let item = item {    
            todoTextView.text = item.title
            todoTextView.textColor = .black
        }
        else {
            todoTextView.text = placeholderText
            todoTextView.textColor = .lightGray
        }
      
    }
    
    
     func makeConstraints() {
        todoTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
         contentView.snp.makeConstraints { make in
             make.height.equalTo(100)
             make.horizontalEdges.equalToSuperview().inset(16)
         }

    }


}



extension TextViewTableViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
                textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
        onFinish?(textView.text)
    }
    
    func textViewDidChange(_ textView: UITextView) {
           if let tableView = self.superview as? UITableView {
               UIView.setAnimationsEnabled(false)
               tableView.beginUpdates()
               tableView.endUpdates()
               UIView.setAnimationsEnabled(true)
           }
       }
    
}



