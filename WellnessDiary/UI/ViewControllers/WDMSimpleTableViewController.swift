//
//  WDMSimpleTableViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/29/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMSimpleTableViewController: WDMSimpleViewController {

  // MARK: - Properties
  
  var tableView: WDMSimpleTableView = {
    let tableView = WDMSimpleTableView()
    return tableView
  }()
  
  var infoProvider = WDMTableViewInfoProvider() {
    didSet {
      tableViewDataSourceHandler = WDMTableViewDataSourceHandler(tableViewInfoProvider: infoProvider)
      tableviewDelegateHandler = WDMTableViewDelegateHandler(tableViewInfoHandler: infoProvider)
    }
  }
  
  var tableViewDataSourceHandler: WDMTableViewDataSourceHandler? {
    didSet {
      tableView.dataSource = tableViewDataSourceHandler
      tableView.reloadData()
    }
  }
  
  var tableviewDelegateHandler: WDMTableViewDelegateHandler? {
    didSet {
      tableView.delegate = tableviewDelegateHandler
      tableView.reloadData()
    }
  }
  
  // MARK: - Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
    
    tableView.dataSource = tableViewDataSourceHandler
    tableView.delegate = tableviewDelegateHandler
  }
  
  public func createInfoProvider() -> WDMTableViewInfoProvider {
    fatalError("Base class does nothing. Child needs to override.")
  }
  
  public func dismiss() {
    fatalError("Base class does nothing. Child needs to override.")
  }
}
