//
//  ViewController.swift
//  NavigationBarWithScrollView
//
//  Created by Seunghun Yang on 2022/04/19.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(view)
            make.height.equalTo(2400)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print(yOffset)
    }
}

