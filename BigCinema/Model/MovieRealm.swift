//
//  MovieRealm.swift
//  BigCinema
//
//  Created by 1 on 05.04.2022.
//
import RealmSwift
import Foundation

class MovieRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var voteAverage:Double = 0.0
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var releaseDate = ""
    @objc dynamic var id = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var backdropPath = ""
    @objc dynamic var overview = ""

    //MARK: НЕ сохранит фильм повторно
    override static func primaryKey() -> String? {
        return "id"
    }
}
