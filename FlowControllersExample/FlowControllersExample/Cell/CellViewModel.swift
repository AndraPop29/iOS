//
//  CellViewModel.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 28/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

protocol CellViewModel {
    
    var title : String? { get }
    var director : String? { get }
}

class CellViewModelImpl : CellViewModel {
    
    var title : String?
    var director : String?
    private var film : Film
    
    init(film: Film) {
        self.film = film
        self.title = film.title
        self.director = film.director
    }
}
