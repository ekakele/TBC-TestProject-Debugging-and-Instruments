//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//  Modified by Eka Kelenjeridze on 24.11.23.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
#warning(" cell-ის არასწორი იდენტიფიკატორი NewsCell.")
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
#warning("tableView-ის ქლოჟერში, სადაც ხდება მისი ინიციალიზება, self-ის გამოყენება ამოაგდება ერორს. self გამოყენებული უნდა იყოს მხოლოდ მას შემდეგ, რაც სრულად მხოდება tableView-ს ინიციალიზება. ამისათვის არსებობს რამდენიმე გზა: ცვლადი გადავაკეთოთ private lazy var-ად ან private func setupTableView-ში გადავიტანოთ tableView-ს dataSource-ისა და delegate-ს property-ებს გატოლება self-თან, რომელიც, ამ შემთხვევაში, წარმოადგენს NewsViewController კლასის ინსტანსს.")
        //        tableView.dataSource = self
        //        tableView.delegate = self
        return tableView
    }()
    
    private var news = [News]()
#warning("აქ იყო კიდევ ერთი ძაღლის თვი დამარხული, ეწერა DefaultNewViewModel(), რომელიც იმალებოდა sceneDelegate-ში და დაკორექტირდა ViewModel-ის კლასის შესაბამისად.")
    private var viewModel: NewsViewModel = DefaultNewsViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
#warning("ვიძახებთ setupViewModelDelegate()-ს.")
        setupViewModelDelegate()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
#warning("private func setupTableView-ში გადმოვიტანეთ tableView-ს dataSource-ისა და delegate-ს property-ებს გატოლება self-თან, რომელიც, ამ შემთხვევაში, წარმოადგენს NewsViewController კლასის ინსტანსს.")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //add
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
}



// MARK: - TableViewDataSource
#warning("tableView-ში გამოვიტანეთ news-ების რაოდენობის cell-ი, ნაცვლად 0-სა.")
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
        //        .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Could not dequeue NewsCell")
        }
#warning("მასივში ელემენტების ათვლა იწყება ათვლა იწყება 0-დან, news[indexPath.row + 1] შესაძლოა მოგვცეს ერორი, როცა მითითებულ ინდექსზე ვერ ამოიღებს ელემენტს")
        cell.configure(with: news[indexPath.row])
        //        cell.configure(with: news[indexPath.row + 1])
        return cell
    }
}

// MARK: - TableViewDelegate
#warning("tableView-ში cell-ის სიმაღლეს მივანიჭეტ კონკრეტული ზომა, ნაცვლად 0-სა. ასევე, შესაძლებელია ამ მეთოდის და-skip-ვა, და cell-ის დინამიური სიმაღლის განსაზღვრა setupTableView()-ში, მაგ.: tableView.rowHeight = UITableView.automaticDimension")
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
        //        .zero
    }
}

// MARK: - MoviesListViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {
    func newsFetched(_ news: [News]) {
        self.news = news
#warning("აქ ჩავამატეთ DispatchQueue.main.async რათა API-და წამოღებული data აისახოს main thread-ზე ანუ დააფდეითდეს UI ელემენტები და აისახოს მომხმარებლის ინტერფეისზე.")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}

