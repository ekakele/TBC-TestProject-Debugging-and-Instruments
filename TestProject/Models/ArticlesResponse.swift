//
//  Article.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//  Modified by Eka Kelenjeridze on 24.11.23.
//

import Foundation

#warning("იმისათვის, რომ Article სრულად აკომფირმებდეს Decodable-ის პროტოკოლს, მისი property-ც უნდა იყოს Decodable ტიპის ობიექტი.")

#warning("ასევე, მოცემული API-დან ობიექტის მოდელი არ არის სწორად შემქნილი, ნაცვლად let articles: News-სა უნდა იყოს: let articles: [News], ასევე, stract-ის სახელწოდება უფრო სწორი იქნებოდა მრავლობითში და ამგვარდა: ArticlesResponse.")

struct ArticlesResponse: Decodable {
    let articles: [News]
}

