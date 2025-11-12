//
//  ViewController.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 27/10/25.
//

import UIKit
import SnapKit


class TodoListViewController: UIViewController, AddViewControllerDelegate {
    func addViewController(_ controller: AddViewController, didSave item: ToDoItem) {
        items.append(item)
        dataBaseManager.saveContext()
        tableView.reloadData()
        
        controller.dismiss(animated: true)
    }
    
    func addViewController(_ controller: AddViewController, didDelete item: ToDoItem) {
        deleteItem(item)
        controller.dismiss(animated: true)
    }

    

   
    var items: [ToDoItem] = [ ]
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let toolbar = UIToolbar()
    let addButton = UIBarButtonItem()
    
    let dataBaseManager: DataBaseManager
    let todoItem: [ToDoItem] = []
    
    init(dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My tasks"
        view.backgroundColor = UIColor(named: "bgColor")
        

        setupTableView()
        setUpToolbar()
        makeConstaints()
        reloadData()

        
    }
    

    func setUpToolbar() {
        view.addSubview(toolbar)
        
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.backgroundColor = .clear
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 28
        
        
 
        button.translatesAutoresizingMaskIntoConstraints = false
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        
        button.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        
        let addButtonItem = UIBarButtonItem(customView: button)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, addButtonItem, flexibleSpace]
    }



    
    @objc func addNewTask() {
         showAddEditScreen(for: nil)
       }
    
    func deleteItem(_ item: ToDoItem) {
        dataBaseManager.context.delete(item)
        dataBaseManager.saveContext()

        
        if let index = items.firstIndex(where: { $0.objectID == item.objectID }) {
             items.remove(at: index)
             tableView.reloadData()
         }
    }
 
    

    
    func showAddEditScreen(for item: ToDoItem?, at indexPath: IndexPath? = nil) {
        let addVC = AddViewController()
        addVC.item = item
        addVC.delegate = self
        addVC.dataBaseManager = self.dataBaseManager

        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }

    
    func setupTableView() {
        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "my cell")
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
    
    func reloadData() {
        do {
            let requset = ToDoItem.fetchRequest()
            items = try dataBaseManager.context.fetch(requset)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "my cell", for: indexPath) as! ToDoItemTableViewCell
        let item = items[indexPath.row]


        cell.configure(with: item.title ?? "No task", isCompleted: item.isDone) { [weak self] in
            guard let self = self else { return }
            let task = self.items[indexPath.row]
            task.isDone.toggle()
            self.dataBaseManager.saveContext()
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }

  
        let isFirst = indexPath.row == 0
        let isLast = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        cell.contentView.layer.cornerRadius = 22
        cell.contentView.layer.masksToBounds = true

        if isFirst && !isLast {
            cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if isLast && !isFirst {
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else if isFirst && isLast {
            cell.contentView.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner
            ]
        } else {
            cell.contentView.layer.cornerRadius = 0
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !items[indexPath.row].isDone {
            showAddEditScreen(for: items[indexPath.row], at: indexPath)
        }
        
            
                  tableView.deselectRow(at: indexPath, animated: true)
                  return
              
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAsCompleted = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completionHandler  in
            guard let self = self else {return}
            self.items[indexPath.row].isDone.toggle()
            self.dataBaseManager.saveContext()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        markAsCompleted.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.white)
        markAsCompleted.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [markAsCompleted])
 
        
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, deleteHandler in
            guard let self = self else { return }
            let itemToDelete = self.items[indexPath.row]
            self.deleteItem(itemToDelete)
            deleteHandler(true)
        }
        trash.image = UIImage(systemName: "trash")?.withTintColor(.white)
        trash.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [trash])
    }



}

protocol AddViewControllerDelegate: AnyObject {
    func addViewController(_ controller: AddViewController, didSave item: ToDoItem)
    func addViewController(_ controller: AddViewController, didDelete item: ToDoItem)
}




    
