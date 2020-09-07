//
//  LandingViewModel.swift
//  Example
//
//  Created by Randhir Kumar on 07/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//


class LandingViewModel {
    
    typealias CompletionHandler = (() -> Void)
    private let completionHandler: CompletionHandler?

    private var dataSource: [LandingModel]? {
        didSet {
            completionHandler?()
        }
    }
    
    init(completionHandler: @escaping CompletionHandler) {
        self.completionHandler = completionHandler
    }
    
    func initializeDataSource(datasource: [LandingModel]) {
        self.dataSource = datasource
    }
    
    // MARK: - View Model helper func
    func noOfRows() -> Int {
        guard let data = dataSource else { return 0 }
        return data.count
    }
    
    func getCellItem(atIndex index: Int) -> LandingModel? {
        guard let dataSource = dataSource, index < dataSource.count else { return nil }
        return dataSource[index]
    }
}
