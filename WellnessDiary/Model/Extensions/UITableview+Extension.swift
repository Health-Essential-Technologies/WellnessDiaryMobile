//
//  UITableview+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

extension UITableView {
    
    // MARK: - Methods
    
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    public func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T
    }
    
    public func dequeue<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error: cell with id: \(cellClass.reuseIdentifier) is not \(T.self)")
        }
        return cell
    }
}
