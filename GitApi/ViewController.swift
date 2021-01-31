//
//  ViewController.swift
//  GitApi
//
//  Created by Alex Natic on 1/29/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var commitsTableView: UITableView!
    
    var results : [Response?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Git Commits"
        getGitCommits()
        //Add footer to remove empty cells
        self.commitsTableView.tableFooterView = UIView()
    }
    
    func getGitCommits() {
        guard let url = URL(string: "https://api.github.com/repos/alexnatic/GitApi/pulls/1/commits") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            do {
                self.results = try JSONDecoder().decode([Response].self, from: data)
            }
            catch {
                print("Failed to decode: \(error)")
            }

            DispatchQueue.main.async {
                self.commitsTableView.reloadData()
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Commit Cell")
        let authorName = cell?.viewWithTag(1) as? UILabel
        let commitMessage = cell?.viewWithTag(2) as? UILabel
        let commitHash = cell?.viewWithTag(3) as? UILabel
        
        
        authorName?.text = self.results[indexPath.row]?.commit.author.name
        commitMessage?.text = self.results[indexPath.row]?.commit.message
        commitHash?.text = self.results[indexPath.row]?.commit.tree.sha
        return cell ?? UITableViewCell()
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
