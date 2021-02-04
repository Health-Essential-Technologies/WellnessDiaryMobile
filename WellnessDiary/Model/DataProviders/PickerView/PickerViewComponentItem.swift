//
//  PickerViewComponentItem.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

struct PickerViewComponentItem {
    
    // MARK: - Properties
    
    var title: String?
    var rowHeight: CGFloat
    var rowWidth: CGFloat
    var rowItems = [PickerViewRowItem]()
    
    // MARK: - Initializers
    
    init(title: String?, rowItems: [PickerViewRowItem], rowHeight: CGFloat = -1, rowWidth: CGFloat = -1) {
        self.title = title
        self.rowItems = rowItems
        self.rowHeight = rowHeight
        self.rowWidth = rowWidth
    }
}
