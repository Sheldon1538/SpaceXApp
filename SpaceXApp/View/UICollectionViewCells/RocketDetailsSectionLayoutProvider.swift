//
//  RocketDetailsSectionLayoutProvider.swift
//  SpaceXApp
//
//  Created by Konstantin on 22.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

enum RocketDetailsSectionLayout {
    case imagesSlider
    case rocketDescription
    case rocketSize
    case rocketCountry
    case firstStage
    case secondStage
    case costPerLaunch
    case defaultSection
}

class RocketDetailsSectionLayoutProvider {
    let environment: NSCollectionLayoutEnvironment!
    
    init(environment: NSCollectionLayoutEnvironment) {
        self.environment = environment
    }
    
    func layoutSection(section: RocketDetailsSectionLayout) -> NSCollectionLayoutSection {
        switch section {
        case .imagesSlider:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
            let groupWidth = environment.container.contentSize.width * 0.87
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(groupWidth), heightDimension: .absolute(250)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            let sectionSideInset = (environment.container.contentSize.width - groupWidth)/2
            section.contentInsets = .init(top: 0, leading: sectionSideInset, bottom: 0, trailing: sectionSideInset)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case .rocketDescription:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 16
            section.orthogonalScrollingBehavior = .none
            return section
        case .rocketSize:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 16
            return section
        case .rocketCountry:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 20
            return section
        case .firstStage:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)), elementKind: "Header", alignment: .topLeading)]
            section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
            return section
        case .secondStage:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)), elementKind: "Header", alignment: .topLeading)]
            section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
            return section
        case .costPerLaunch:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)), elementKind: "Header", alignment: .topLeading)]
            section.contentInsets = .init(top: .zero, leading: 16, bottom: 16, trailing: 16)
            return section
        case .defaultSection:
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0)), subitems: [])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            return section
        }
    }
    
    
}
