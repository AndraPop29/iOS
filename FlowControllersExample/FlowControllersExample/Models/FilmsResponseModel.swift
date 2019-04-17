//
//  FilmsResponseModel.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 28/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

struct Film : Decodable {
    
    let title: String
    let director: String
    let release_date: String
    
    enum FilmKeys: String, CodingKey {
        case title
        case director
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FilmKeys.self)
        title = try container.decode(String.self, forKey: .title)
        director = try container.decode(String.self, forKey: .director)
        release_date = try container.decode(String.self, forKey: .releaseDate)
    }
}

struct FilmsResponseModel : Decodable {
    let results: [Film]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([Film].self, forKey: .results)
    }
}
