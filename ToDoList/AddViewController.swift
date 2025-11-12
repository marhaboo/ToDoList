//
//  addViewController.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 01/11/25.
//

import UIKit

class AddViewController: UIViewController {
    
    var item: ToDoItem?
    weak var delegate: AddViewControllerDelegate?
    var dataBaseManager: DataBaseManager?
      
       
    
    
    // MARK: - UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "text view cell" )
        tableView.register(ImportanceTaskTableViewCell.self, forCellReuseIdentifier: ImportanceTaskTableViewCell.identifier)
        tableView.register(DueDateTableViewCell.self, forCellReuseIdentifier: DueDateTableViewCell.identifier)
        tableView.register(DeleteTaskTableViewCell.self , forCellReuseIdentifier: DeleteTaskTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground

        
        configureNavigationBar()
        makeConstraints()
        
    }
    
    
    
    func configureNavigationBar(){
        navigationItem.title = "Todo"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(canselButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    
    
    @objc func canselButtonTapped() {
        dismiss(animated: true)
        
    }
    
    @objc func saveButtonTapped(_ sender: Any) {
        let titleText: String
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextViewTableViewCell {
                    titleText = cell.todoTextView.text ?? ""
                } else {
                    titleText = ""
                }
        
        if let existingItem = item {
                  existingItem.title = titleText
                  delegate?.addViewController(self, didSave: existingItem)
              } else {
                  guard let context = dataBaseManager?.context else {return}
                   
                  let newItem = ToDoItem(context: context)
                  newItem.title = titleText
                  newItem.isDone = false
                  delegate?.addViewController(self, didSave: newItem)
              }
          }


    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
    }
    
}
extension AddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "text view cell", for: indexPath) as! TextViewTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            
            cell.configure(with: item)
            return cell
        }
        else  if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImportanceTaskTableViewCell.identifier, for: indexPath) as! ImportanceTaskTableViewCell
            
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
        else  if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DueDateTableViewCell.identifier, for: indexPath) as! DueDateTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .clear

            
            cell.didToggleChange = { [weak self] in
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
            return cell

        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DeleteTaskTableViewCell.identifier, for: indexPath) as! DeleteTaskTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.onDeleteTapped = { [weak self] in
                guard let self = self, let item = self.item else {return}
                self.delegate?.addViewController(self, didDelete: item)
            }

            return cell
        }
       
        
       
    }
}

extension AddViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

