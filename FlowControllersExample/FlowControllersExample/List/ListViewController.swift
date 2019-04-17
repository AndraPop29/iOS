//
//  ListViewController.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 27/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class ListViewController: BaseViewController {
    
    private let viewModel: ListViewModelImpl
    private var tableView: UITableView!
    private var cellViewModels: [CellViewModel] = []
    private let disposeBag = DisposeBag()
    
    init(viewModel: ListViewModelImpl) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initBindings()
    }
    
    func displayViews() {
        
        self.view.addSubview(tableView)
    }
    
    func setupViews() {
        navigationItem.title = viewModel.title
        
        tableView = UITableView(frame: view.frame)
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func initBindings() {
        viewModel.cellViewModels.bind { [unowned self] cellViewModels in
            self.cellViewModels = cellViewModels
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension ListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! Cell
        cell.viewModel = cellViewModels[indexPath.row]
        return cell
    }
    
    
}

extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem()
    }
    
}
