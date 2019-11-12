//
//  HeroesViewModel.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 04/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

protocol HeroListViewModelDelegate: class {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
}

final class HeroListViewModel {
    private weak var delegate: HeroListViewModelDelegate?
    
    private var heroes: [Hero] = []
    private var limit = 20
    private var offset = 0
    private var totalHeroes = 0
    private var isFetchInProgress = false
    
    let client = MarvelClient()
    let request: HeroRequest
    
    init(request: HeroRequest, delegate: HeroListViewModelDelegate){
        self.request = request
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return totalHeroes
    }
    
    var currentCount: Int {
        return heroes.count
    }
    
    func hero(at index: Int) -> Hero {
      return heroes[index]
    }
    
    func fetchCharacters(){
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        client.fetchCharacters(with: request, offset: self.offset){ [weak self] in
            self?.offset += $0.data.results.count
            self?.isFetchInProgress = false
            
            self?.totalHeroes = $0.data.total
            self?.heroes.append(contentsOf: $0.data.results)
            
            if $0.data.offset > 0 {
                let indexPathsToReload = self?.calculateIndexPathsToReload(from: $0.data.results)
                self?.delegate?.onFetchCompleted(with: indexPathsToReload)
            } else {
                self?.delegate?.onFetchCompleted(with: .none)
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newHeroes: [Hero]) -> [IndexPath] {
        let startIndex = heroes.count - newHeroes.count
        let endIndex = startIndex + newHeroes.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
