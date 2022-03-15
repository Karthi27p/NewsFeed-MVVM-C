//
//  BuisnessHeadlinesViewController.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 16/03/22.
//

import UIKit
import SwiftUI

@available(iOS 15.0, *)
class BuisnessHeadlinesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let buisnessHeadlinesView: some View = BuisnessHeadlinesContentView()
        let hostingVC = UIHostingController(rootView: buisnessHeadlinesView)
        self.addChild(hostingVC)
        hostingVC.view.frame = self.view.frame
        self.view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
    }

}
