//
//  Cat.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation


struct Cat {
    var id: String
    var name: String
    var date: String
    var picture: String
    var sex: String
    var likes: Int
    var categories: [String]
}

extension Cat {
    static let sampleData =
    [
        Cat(
            id: "40e672b3",
            name: "Whiskers",
            date: "2021-05-01",
            picture: "https://utfs.io/f/56149d82-5267-49e2-8c72-60628b8a7d47-1tafv.png",
            sex: "female",
            likes: 24,
            categories: [
                "playful",
                "friendly"
            ]
        ),
        Cat(
            id: "e4f4a9c3",
            name: "Mittens",
            date: "2021-04-15",
            picture: "https://utfs.io/f/49da5ed1-daf2-4ce1-ac79-88eb7debb5e9-1tafw.png",
            sex: "male",
            likes: 76,
            categories: [
                "cuddly",
                "adventurous"
            ]
        ),
        Cat(
            id: "d0601dac",
            name: "Shadow",
            date: "2021-03-20",
            picture: "https://utfs.io/f/c1bf8d7e-e8a6-4e3a-94c5-2fa0e4e79392-1tafx.png",
            sex: "male",
            likes: 457,
            categories: [
                "independent",
                "curious",
                "hunter"
            ]
        ),
        Cat(
            id: "e6d9bd8c",
            name: "Luna",
            date: "2021-02-10",
            picture: "https://utfs.io/f/4dbce952-2019-4241-8e12-5c764b933a09-1tafy.png",
            sex: "male",
            likes: 1234,
            categories: [
                "playful",
                "cuddly",
                "adventurous",
                "friendly"
            ]
        ),
        Cat(
            id: "12498700",
            name: "Oliver",
            date: "2021-01-05",
            picture: "https://utfs.io/f/bdbe3f61-57c2-479a-a94f-fe1c4b387205-1tafz.png",
            sex: "male",
            likes: 564,
            categories: [
                "friendly",
                "adventurous",
                "hunter"
            ]
        )
    ]
}
