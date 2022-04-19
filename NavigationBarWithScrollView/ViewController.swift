//
//  ViewController.swift
//  NavigationBarWithScrollView
//
//  Created by Seunghun Yang on 2022/04/19.
//

import UIKit
import SnapKit

class SomeCell: UICollectionViewCell {
    static let identifier = "SomeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
}

class SomeHeader: UICollectionReusableView {
    static let identifier = "SomeHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SomeCell.self, forCellWithReuseIdentifier: SomeCell.identifier)
        collectionView.register(
            SomeHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SomeHeader.identifier
        )
        return collectionView
    }()
    
    private var header: SomeHeader?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hello"
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.section == 0 { return CGSize(width: view.frame.width, height: 300) }
        return CGSize(width: view.frame.width, height: 1200)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 0 { return .zero }
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: SomeCell.identifier, for: indexPath)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SomeHeader.identifier,
            for: indexPath
        )
        guard let header = header as? SomeHeader else { return header }
        self.header = header
        return header
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let appearance = navigationController?.navigationBar.standardAppearance,
              let header = header else { return }
        
        let scrollOffset = scrollView.contentOffset.y + view.safeAreaInsets.top
        let headerOffset = header.frame.origin.y
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label.withAlphaComponent(scrollOffset / headerOffset),
            .font: UIFont.systemFont(ofSize: 25, weight: .bold),
        ]

        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
}

