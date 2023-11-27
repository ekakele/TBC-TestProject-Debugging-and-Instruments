//
//  News.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//  Modified by Eka Kelenjeridze on 24.11.23.
//

import Foundation

#warning("იმისათვის, რომ ArticlesResponse სრულად აკომფირმებდეს Decodable-ის პროტოკოლს, მისი property-ც უნდა იყოს Decodable ტიპის ობიექტი, შესაბამისად, News-ს დავაკომფირმებინეთ Decodable პროტოკოლი.")

struct News: Decodable {
#warning("აქაც იყო ძაღლის თავი დამარხული, არასწორად ეწერა JSON response-ის key: უნდა იყოს author და არა authors. წინააღმდეგ შემთხვევაში ვერ მოხერხდება author-ის შესაბამისი ინფორმაციის წამოღება.")
    let author: String?
    let title: String?
    let urlToImage: String?
}
