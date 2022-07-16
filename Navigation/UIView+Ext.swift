//
//  UIView+Ext.swift
//  Navigation
//
//  Created by M M on 5/4/22.
//

import Foundation
import UIKit

extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }

    func unpin(from superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = false
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = false
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = false
    }
    
}
