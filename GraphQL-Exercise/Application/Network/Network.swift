//
//  Network.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.spacex.land/graphql")!)
}
