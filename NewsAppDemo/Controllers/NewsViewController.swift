//
//  NewsViewController.swift
//  NewsAppDemo
//
//  Created by hasher on 12/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit
import PullToRefreshKit
import Localize_Swift

class NewsViewController: UIViewController {
    
    private var newsViewModel = NewsViewModel()
    
    private var newsArray = [Article](){
        didSet
        {
            if newsArray.count > 0 {
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.tableViewx.reloadData()
                }
            }
        }
    }
    
    private var page = 0
    @IBOutlet weak var tableViewx: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todays News"
        addRightButtonsWith(fisrtButtonDefaultTitle: "French", fisrtButtonSelectedTitle: "English", target: self)
        setupTableView()
        getAllNews(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverForInternetConnectivity()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForInternetConnectivity()
    }
    
    
    fileprivate func setupTableView() {
        tableViewx.register(UINib(nibName: ArticleTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier())
        tableViewx.dataSource = self
        tableViewx.delegate = self
        tableViewx.rowHeight = UITableView.automaticDimension
        tableViewx.estimatedRowHeight = 200
        newsViewModel.news.bind { [weak self] (news) in
            DispatchQueue.main.async {
                if self?.page == 0
                {
                    self?.newsArray.removeAll()
                    self?.tableViewx.switchRefreshHeader(to: .normal(.success, 0.5))
                }
                
                if news.count != 0
                {
                    self?.tableViewx.hideNoDataLabel()
                    self?.newsArray.append(contentsOf: news)
                }else if self?.newsArray.count == 0 && news.count == 0 {
                     self?.tableViewx.showNoDataLabel(withText: "No data to show")
                }
                self?.tableViewx.switchRefreshFooter(to: .normal)
            }
        }
        
        tableViewx?.configRefreshHeader(container: self, action: { [weak self] in
            self?.page = 0
            self?.getAllNews(page: self?.page ?? 0)
        })
        
        tableViewx.configRefreshFooter(container: self) { [weak self] in
            self?.page += 1
            self?.getAllNews(page: self?.page ?? 0)
        }
    }
    
    // MARK: - InternetConnection_Observer
    override func gotInternetConnectivity() {
        super.gotInternetConnectivity()
        page = 0
        getAllNews(page: page)
    }
    
    private func getAllNews(page: Int)
    {
        newsViewModel.getAllArticles(noAggregationCountCallback: { [weak self] in
            DispatchQueue.main.async {
            self?.tableViewx.switchRefreshHeader(to: .normal(.success, 0.5))
            self?.tableViewx.showNoDataLabel(withText: "No data to show")
            }
        }, startIndex: page, currentListCount: newsArray.count) { [weak self] in
            //noMoreDataCallback
            DispatchQueue.main.async {
                self?.tableViewx.switchRefreshFooter(to: .noMoreData)
            }
        }
    }
    
}



//MARK: UITableViewDataSource, UITableViewDelegate

extension NewsViewController: UITableViewDataSource, UITableViewDelegate{
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier(), for: indexPath) as! ArticleTableViewCell
        cell.setUpCell(article: newsArray[indexPath.row])
        return cell
    }
}

//MARK: Right Bar button Action
extension NewsViewController
{
    @objc override public func firstButtonAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Localize.setCurrentLanguage("fr")
        }else
        {
            Localize.resetCurrentLanguageToDefault()
        }
        addRightButtonsWith(fisrtButtonDefaultTitle: "French", fisrtButtonSelectedTitle: "English",fisrtButtonSelected: sender.isSelected, target: self)
        tableViewx.reloadData()
        self.title = "Todays News".localized()
    }
}
