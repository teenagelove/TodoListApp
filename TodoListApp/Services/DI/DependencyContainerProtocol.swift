//
//  DependencyContainerProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

protocol DependencyContainerProtocol {
    var navigationService: NavigationServiceProtocol { get }
    var networkService: NetworkServiceProtocol { get }
    var storageService: StorageServiceProtocol { get }
}
