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
                 title:  "Банальные, но неопровержимые выводы, а также акционеры крупнейших компаний и по..."),
        ToDoItem(isDone: true, title: "Задание")
    ]
 
    let toolbar = UIToolbar()
    let addButton = UIBarButtonItem()


    override func viewDidLoad() {
        super.viewDidLoad()
  
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My tasks"
        view.backgroundColor = UIColor(named: "bgColor")
        

        setupTableView()
        setUpToolbar()
        makeConstaints()

        
        
        
    }
    

    func setUpToolbar() {
        view.addSubview(toolbar)
        
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)


       
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        let addButtonItem = UIBarButtonItem(customView: button)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, addButtonItem, flexibleSpace]
    
    }


    
    @objc func addNewTask() {
          let openVC = addViewController()
        present(openVC, animated: true)
       }
    
    func setupTableView() {
        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "my cell")
        tableView.register(NewItemTableViewCell.self, forCellReuseIdentifier: "new cell")
        tableView.register(ToDoListHeaderView.self, forHeaderFooterViewReuseIdentifier: "my header")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "bgColor")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
    }
    
    
    func makeConstaints() {

        toolbar.snp.makeConstraints { make in
                   make.leading.trailing.equalToSuperview()
                   make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                   make.height.width.equalTo(56)
               }

        tableView.snp.makeConstraints { make in
                   make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                   make.leading.trailing.equalToSuperview()
                   make.bottom.equalTo(toolbar.snp.top)
               }
        
        
        
    }
    


}


extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if items.count == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "new cell", for: indexPath) as! NewItemTableViewCell
            cell.selectionStyle = .none
            return cell
        }

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



}
