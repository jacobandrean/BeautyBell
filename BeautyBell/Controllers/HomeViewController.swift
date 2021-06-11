//
//  HomeViewController.swift
//  BeautyBell
//
//  Created by Jacob Andrean on 10/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var artisans: [Artisan] = []
    private var artisansCopy: [Artisan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureTableView()
        APICaller.shared.fetchArtisanList { [weak self] (result) in
            switch result {
            case .success(let model):
                self?.artisans = model
                self?.artisansCopy = model
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func configureTableView() {
        tableView.register(ArtisanTableViewCell.self, forCellReuseIdentifier: ArtisanTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searched = searchBar.text else {
            return
        }
        artisans = artisansCopy
        var temp: [Artisan] = []
        for artisan in artisans {
            if artisan.name.contains(searched.lowercased()) {
                temp.append(artisan)
            }
        }
        artisans = temp
        searchController.isActive = false
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Artisan"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artisans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtisanTableViewCell.identifier) as? ArtisanTableViewCell else {
            return UITableViewCell()
        }
        let artisan = artisans[indexPath.row]
        let viewModel = ArtisanTableViewCellViewModel(
            name: artisan.name,
            avatar: URL(string: "\(artisan.avatar)"),
            description: artisan.description
        )
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let artisan = artisans[indexPath.row]
        let vc = DetailArtisanViewController(artisan: artisan)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
