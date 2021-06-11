//
//  DetailArtisanViewController.swift
//  BeautyBell
//
//  Created by Jacob Andrean on 10/06/21.
//

import UIKit

enum SectionType {
    case artisanInformation(viewModels: ArtisanInformationCellViewModel)
    case artisanServices(viewModels: [ArtisanServicesCellViewModel])
}

class DetailArtisanViewController: UIViewController {
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
        return DetailArtisanViewController.createSectionLayout(section: sectionIndex)
    }))
    
    private var sections = [SectionType]()
    private var artisan: Artisan
    
    init(artisan: Artisan) {
        self.artisan = artisan
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureModels(artisan: artisan)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            ArtisanInformationCell.self,
            forCellWithReuseIdentifier: ArtisanInformationCell.identifier
        )
        collectionView.register(
            ArtisanServicesCell.self,
            forCellWithReuseIdentifier: ArtisanServicesCell.identifier
        )
        collectionView.dataSource = self
    }
    
    private func configureModels(artisan: Artisan) {
        self.artisan = artisan
        sections.append(.artisanInformation(viewModels: ArtisanInformationCellViewModel(
            name: artisan.name,
            avatar: URL(string: artisan.avatar),
            description: artisan.description,
            rating: artisan.rating)))
        
        sections.append(.artisanServices(viewModels: artisan.services.compactMap({
            return ArtisanServicesCellViewModel(
                name: $0.name,
                price: $0.price,
                caption: $0.caption
            )
        })))
        print(sections.count)
    }

}

extension DetailArtisanViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .artisanInformation(viewModels: _):
            return 1
        case .artisanServices(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .artisanInformation(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtisanInformationCell.identifier, for: indexPath) as? ArtisanInformationCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: viewModels)
            return cell
        case .artisanServices(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtisanServicesCell.identifier, for: indexPath) as? ArtisanServicesCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(150)
                ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(160)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(160)
                ),
                subitem: item,
                count: 1
            )
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
//            section.boundarySupplementaryItems = supplementaryViews
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(390)
                ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
}
