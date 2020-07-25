//
//  CharactersViewController.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 23/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    
    private let presenter: CharactersPresenter
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(presenter: CharactersPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localizable.welcomePage.searchBar.rawValue
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableView?.register(CharactersViewCell.nib, forCellReuseIdentifier: CharactersViewCell.identifier)
        tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputTextByUser = searchController.searchBar.text else { return }
        presenter.inputTextDidChange(inputTextByUser)
    }
}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersViewCell.identifier, for: indexPath) as? CharactersViewCell else { return UITableViewCell()}
        let characters = presenter.dataSource[indexPath.row]
        let presenter = CharactersViewCellPresenter(model: characters)
        cell.configure(presenter: presenter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.rowDidTap(indexPath.row)
    }
}

extension CharactersViewController: CharactersPresenterDelegate {
    func showAlert(message: String, buttonTitle: String, title: String) {
        
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func setNavigationTitle(_ text: String) {
        navigationItem.title = text
    }
}
