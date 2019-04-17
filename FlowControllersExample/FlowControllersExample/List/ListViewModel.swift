//
//  ListViewModel.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 27/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import Alamofire
import RxSwift

protocol ListViewModel {
    var title : String { get }
    var cellViewModels: BehaviorSubject<[CellViewModel]> { get }
    weak var flowDelegate : ListFlowDelegate? { get }
    func didSelectItem()
    func loadData()
}

protocol ListFlowDelegate : class {
    func didSelectItem(on viewModel: ListViewModel)
}

class ListViewModelImpl: ListViewModel {
    var title : String = "Films"
    var cellViewModels = BehaviorSubject<[CellViewModel]>(value: [])
    weak var flowDelegate: ListFlowDelegate?
    
    init() {
        loadData()
    }
    
    func loadData() {
        APIClient().getFilms(success: { films in
            let cellViewModels = films.map { CellViewModelImpl(film: $0) }
            self.cellViewModels.onNext(cellViewModels)
        }, failure: { error in
            
        })
    }
    
    func didSelectItem() {
        flowDelegate?.didSelectItem(on: self)
    }
}
