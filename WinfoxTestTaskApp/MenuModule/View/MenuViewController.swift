//
//  MenuViewController.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 27.08.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let refreshController = UIRefreshControl()
    var viewModel = MenuViewModel()
    var idOfPlace = ""
    var menu = [Menu]()
    
    let tableView = UITableView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMenu(idOfPlace)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        bindViewModel()
        addSubView()
        addConstraints()
        setupTableView()
        registerTableViewCell()
        refreshController.beginRefreshing()
        
        refreshController.attributedTitle = NSAttributedString(string: "Загрузка...")
    }
    
    private func addSubView() {
        view.addSubview(tableView)
        tableView.addSubview(refreshController)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    private func registerTableViewCell() {
        tableView.register(MenuCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemIndigo
        tableView.separatorStyle = .none
    }
    
    private func bindViewModel() {
        viewModel.menu.bind { menu in
            self.menu = menu
            self.tableView.reloadData()
            self.refreshController.endRefreshing()
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        cell.selectionStyle = .none
        let menuForSetupData = menu[indexPath.row]
        cell.setupMenuData(menuForSetupData)
        return cell
    }
}
