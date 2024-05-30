//
//  Banner.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation

struct Banner: Decodable {
    var id: String
    var name: String
    var date: String
    var picture: String
    var showCta: Bool
}

extension Banner {
    
    static let sampleData = [
        Banner(
            id: "a233d4f2",
            name: "Bella",
            date: "2020-12-12",
            picture: "https://utfs.io/f/490b2ef4-647c-4e92-9cd9-e2778b0eba12-1tag0.png",
            showCta: true
        ),
        Banner(
            id: "d0601dac",
            name: "Shadow",
            date: "2021-03-20",
            picture: "https://utfs.io/f/c1bf8d7e-e8a6-4e3a-94c5-2fa0e4e79392-1tafx.png",
            showCta: false
        ),
        Banner(
            id: "e4f4a9c3",
            name: "Mittens",
            date: "2021-04-15",
            picture: "https://utfs.io/f/49da5ed1-daf2-4ce1-ac79-88eb7debb5e9-1tafw.png",
            showCta: false
        ),
        Banner(
            id: "5457edf4",
            name: "Lily",
            date: "2020-07-10",
            picture: "https://utfs.io/f/7dcc098f-db23-4572-885f-054b90e52868-1k7zp2.jpg",
            showCta: true
        )
    ]
}
