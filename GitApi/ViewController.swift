//
//  ViewController.swift
//  GitApi
//
//  Created by Alex Natic on 1/29/21.
//

import UIKit

class ViewController: UIViewController {
    //Required Info
    //Author
    //Commit hash
    //commit message
    override func viewDidLoad() {
        super.viewDidLoad()
        getGitCommits()
    }
    
    func getGitCommits() {
        let url = URL(string: "https://api.github.com/repos/alexnatic/GitApi/pulls/1/commits")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            var results : [Response?] = []
            do {
                results = try JSONDecoder().decode([Response].self, from: data)
            }
            catch {
                print("Failed to decode \(error)")
            }
            print(results[0]?.commit.message ?? "No Results")
        }.resume()
    }
    
    //Structs
    struct Response : Codable {
        let commit : CommitResults
    }

    struct CommitResults : Codable {
        let author : AuthorResults
        let message : String
        let tree : HashResults
    }
    
    struct AuthorResults : Codable {
        let name : String
        let email : String
    }
    
    struct HashResults : Codable {
        let sha : String
    }
    
}
