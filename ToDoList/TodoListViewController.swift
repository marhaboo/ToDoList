//
//  ViewController.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 27/10/25.
//

import UIKit
import SnapKit


class TodoListViewController: UIViewController {

    let tableView = UITableView()
    var items: [ToDoItem] = [
        ToDoItem(isDone: false, title:  "Купить сыр"),
        ToDoItem(isDone: true,
                 title:  "Банальные, но неопровержимые выводы, а также акционеры крупнейших компаний и по...")
    ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My tasks"
        view.backgroundColor = UIColor(named: "bgColor")
        

        setupTableView()
        makeConstaints()
        
        
    }
    
    
   
   
    
    func setupTableView() {
        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "my cell")
        tableView.register(ToDoListHeaderView.self, forHeaderFooterViewReuseIdentifier: "my header")
        tableView.register(ToDoListFooterView.self, forHeaderFooterViewReuseIdentifier: "my footer")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "bgColor")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
    }
    
    
    func makeConstaints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
     }
        
    }
    


}


extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "my cell", for: indexPath) as! ToDoItemTableViewCell
        let item = items[indexPath.row]

        cell.configure(with: item.title, isCompleted: item.isDone) { [weak self] in
            guard let self = self else { return }
            
           
            self.items[indexPath.row].isDone.toggle()
            
        
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        return cell

    }
}

extension TodoListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int ) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "my header") as! ToDoListHeaderView
        view.configure(with: items.count)
        return view

    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "my footer") as! ToDoListFooterView
        
        return view
    }
}
