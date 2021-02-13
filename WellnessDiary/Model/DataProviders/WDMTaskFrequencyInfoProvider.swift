//
//  WDMTaskFrequencyInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/30/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMTaskFrequencyInfoProvider: WDMTableViewInfoProvider {
  
  // MARK: - Properties
  
  var frequency: Set<TaskFrequency>
  var occurence: Set<TaskOccurence>
  weak var delegate: TaskRecurrenceSelectionProtocol?
  
  // MARK: - Initallizers
  
  init(withSectionItems sectionItems: [TableViewSectionItem] = [], presenterViewController: WDMSimpleViewController? = nil, frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>, delegate: TaskRecurrenceSelectionProtocol?) {
    self.frequency = frequency
    self.occurence = occurence
    self.delegate = delegate
    super.init(withSectionItems: sectionItems, presenterViewController: presenterViewController)
  }
  
  // MARK: - Methods
  
  override func getDefaultTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSimpleTableViewCell {
    let cell = super.getDefaultTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    if let infoProvider = cell.cellInfoProvider as? WDMTaskReccurenceCellInfoProvider {
      
      if let infoProviderFrequency = infoProvider.taskReccurence.frequency {
        
        if frequency.contains(infoProviderFrequency) {
          infoProvider.cellAccessoryType = .checkmark
        } else {
          infoProvider.cellAccessoryType = .none
        }
      }
      
      if let infoProviderOccurence = infoProvider.taskReccurence.occurence {
        if occurence.contains(infoProviderOccurence) {
          infoProvider.cellAccessoryType = .checkmark
        } else {
          infoProvider.cellAccessoryType = .none
        }
      }
    }
    
    cell.selectionStyle = .default
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    super.tableView(tableView, didSelectRowAt: indexPath)
    if let cell = tableView.cellForRow(at: indexPath) as? WDMDefaultTableViewCell {
      if let infoProvider = cell.cellInfoProvider as? WDMTaskReccurenceCellInfoProvider {
        
        if let cellFrequency = infoProvider.taskReccurence.frequency {
          if frequency.contains(cellFrequency) {
            frequency.remove(cellFrequency)
            delegate?.remove(cellFrequency)
          } else {
            frequency.insert(cellFrequency)
            delegate?.add(cellFrequency)
          }
        }
        
        if let cellOccurence = infoProvider.taskReccurence.occurence {
          if occurence.contains(cellOccurence) {
            occurence.remove(cellOccurence)
            delegate?.remove(cellOccurence)
            if occurence.count < 1 {
              occurence.insert(.beforeBreakfast)
              delegate?.add(cellOccurence)
            }
            
          } else {
            occurence.insert(cellOccurence)
            delegate?.add(cellOccurence)
          }
        }
      }
      
      tableView.reloadData()
    }
  }
  
  
}
