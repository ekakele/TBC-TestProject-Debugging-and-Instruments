//
//  NewsViewModel.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//  Modified by Eka Kelenjeridze on 24.11.23.
//

import Foundation
#warning("პოტოკოლი უნდა გავხადოთ AnyObject-ის ტიპის (ანუ class-ის ტიპის ობიექტები), რაც ნიშნავს, რომ ამ პროტოკოლის დაკომფირმების შესაძლებლბობა ექნებათ მხოლოდ კლასის ინსტანსებს, ამის შემდგომ უკვე გვექნება საშუალება weak keyword დავუწეროთ დელეგატის ცვლადს და თვიდან ავირიდოთ retain cycle.")
protocol NewsViewModelDelegate: AnyObject {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}

protocol NewsViewModel {
    var delegate: NewsViewModelDelegate? { get set }
    func viewDidLoad()
}

final class DefaultNewsViewModel: NewsViewModel {
    
    // MARK: - Properties
#warning("შეიცვალა თარიღის კომპონენტი (from=) URL-ში, რადგან მითითებულ API-ზე გვაქვს შეზღუდული წვდომა, კერძოდ მხოლოდ 2021-11-23-დან შეგვიძლია ინფორმაციის ნახვა/წამოღება, არსებულ URL-ში კი მოთხოვნილი იყო 2021 წლის ინფორმაცია, შესაბამისად data-ს ვერ წამოვიღებდით.")
    private let newsAPI = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-11&sortBy=publishedAt&apiKey=17e61763d44f478e98881fe534a41c66"
    
    private var newsList = [News]()
    
#warning("აქ უნდა weak keyword, რათა არ მოხდეს memory leak/retain cycle ")
    weak var delegate: NewsViewModelDelegate?
    
    // MARK: - Public Methods
    func viewDidLoad() {
#warning("რა თქმა უნდა, აუცილებელია fetchNews მეთოდის viewDidLoad-ში გამოძახება და ამისათვის უნდა მოვხსნათ ჩაკომენტარება")
        fetchNews()
    }
    
    // MARK: - Private Methods
    private func fetchNews() {
        NetworkManager.shared.get(url: newsAPI) { [weak self] (result: Result<ArticlesResponse, Error>) in
            print(result)
            switch result {
#warning("უფრო სწორი იქნება, რომ მრავლობითში იყოს: articles.")
            case .success(let articles):
                self?.delegate?.newsFetched(articles.articles)
#warning("ვინაიდან append() მეთოდი არგუმენტად იღებს მხოლოდ ერთ ელემენტს, მას ვერ გადავაწოდებთ ელემენტების მასივს. ამისათვის უნდა გამოვიყენოთ += ოპერატორი, რაც მოგვცემს მასივისთვის მეორე მასივის დამატების საშუალებას")
                self?.newsList += articles.articles
#warning("It looks like you're trying to append an array of News to another array of News. However, append expects a single element, not an array. If you want to add all the elements from one array to another, you should use the += operator.")
                //            self?.newsList.append(articles.articles)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
