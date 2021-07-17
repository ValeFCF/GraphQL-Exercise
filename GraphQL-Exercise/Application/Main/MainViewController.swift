//
//  MainViewController.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        xxx()
    }

    private func xxx() {
        Network.shared.apollo.fetch(query: LaunchPastListQuery()) { result in
          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }
}

