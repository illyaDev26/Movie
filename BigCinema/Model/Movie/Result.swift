//
//  Movies.swift
//  BigCinema
//
//  Created by 1 on 05.04.2022.
//

import Foundation

struct Movie : Decodable {
    let id : Int?
    let overview : String?
    let release_date : String?
    let adult : Bool?
    let backdrop_path : String?
    let vote_count : Int?
    let genre_ids : [Int]?
    let vote_average : Double?
    let original_language : String?
    let original_title : String?
    let poster_path : String?
    let video : Bool?
    let title : String?
    let popularity : Double?
    let media_type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case overview = "overview"
        case release_date = "release_date"
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case vote_count = "vote_count"
        case genre_ids = "genre_ids"
        case vote_average = "vote_average"
        case original_language = "original_language"
        case original_title = "original_title"
        case poster_path = "poster_path"
        case video = "video"
        case title = "title"
        case popularity = "popularity"
        case media_type = "media_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
    }

}
