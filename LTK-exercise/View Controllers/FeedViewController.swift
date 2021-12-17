//
//  FeedViewController.swift
//  LTK-exercise
//

import UIKit

class FeedViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    var ltkFeed: LTKFeed?
    let zeroCount = 0
    var details: Details?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        fetchFeed()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    func fetchFeed()
    {
        LTKApiManager.shared.getFeed(completion: { data in
            self.ltkFeed = data
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        })
    }
    
    func configureNavBar()
    {
        navigationItem.title = Titles.ltk
        navigationController?.addCustomBottomLine(color: UIColor.lightGray, height: 0.5)
    }
    
    func configureTableView()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: LTKFeedCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LTKFeedCell.self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? DetailViewController,
           let details = self.details {
            vc.details = details
        }
    }
    
    func getDetailsAndPrepareSegue(index: Int)
    {
        guard let ltkFeed = ltkFeed
        else
        {
            return
        }
        LTKDataManager.getDetails(index: index, feed: ltkFeed, completion: { details in
            self.details = details
            self.performSegue(withIdentifier: Segues.detailSegue, sender: self)
        })
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ltkFeed?.ltks?.count ?? zeroCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let feedCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LTKFeedCell.self)) as? LTKFeedCell,
              let ltk = ltkFeed?.ltks?[indexPath.row] else
              {
                  return UITableViewCell()
              }
        
        feedCell.configure(with: ltk)
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        getDetailsAndPrepareSegue(index: indexPath.row)
    }
}


