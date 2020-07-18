//
//  SearchView.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 18/04/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

class HeroListView: UIView {
    
    init (){
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchBoxBackgroundView: UIView = {
        let view = UIView(frame: CGRect())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.heroCellBackgroundColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    let searchBox: UITextField = {
        let sb = UITextField()
        //sb.backgroundColor = UIColor.red
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Search for an hero"
        sb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 25.0)
        
        let button = UIButton(frame: CGRect(x: 30, y: 30, width: 100, height: 100))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(clearSearchField), for: .allEvents)
        
        sb.rightView = button
        sb.rightViewMode = .always
        
        return sb
    }()
    
    @objc func clearSearchField() {
        searchBox.text = .none
        
    }
    
    func setupViews() {
//        addSubview(searchBoxBackgroundView)
//        searchBoxBackgroundView.addSubview(searchBox)
//        //searchBoxBackgroundView.addSubview(clearSearchFieldButton)
//        
//        addConstraint(NSLayoutConstraint(item: searchBoxBackgroundView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 10))
//        addConstraint(NSLayoutConstraint(item: searchBoxBackgroundView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: searchBoxBackgroundView, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: searchBoxBackgroundView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1/9, constant: 1))
//        
//        addConstraint(NSLayoutConstraint(item: searchBox, attribute: .leadingMargin, relatedBy: .equal, toItem: searchBoxBackgroundView, attribute: .leadingMargin, multiplier: 1, constant: 10))
//        addConstraint(NSLayoutConstraint(item: searchBox, attribute: .trailingMargin, relatedBy: .equal, toItem: searchBoxBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -10))
//        addConstraint(NSLayoutConstraint(item: searchBox, attribute: .centerY, relatedBy: .equal, toItem: searchBoxBackgroundView, attribute: .centerY, multiplier: 1, constant: 0))
        
//        addConstraint(NSLayoutConstraint(item: clearSearchFieldButton, attribute: .leadingMargin, relatedBy: .equal, toItem: searchBox, attribute: .trailingMargin, multiplier: 1, constant: 15))
//        addConstraint(NSLayoutConstraint(item: clearSearchFieldButton, attribute: .centerY, relatedBy: .equal, toItem: searchBoxBackgroundView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func addHeroTableView(heroTableView: UIView){
        heroTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(heroTableView)

        addConstraint(NSLayoutConstraint(item: heroTableView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: heroTableView, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: heroTableView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: heroTableView, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0))
    }
}
