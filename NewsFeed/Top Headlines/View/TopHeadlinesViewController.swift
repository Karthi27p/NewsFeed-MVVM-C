//
//  TopHeadlinesViewController.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 12/02/22.
//

import UIKit
import SwiftUI

class TopHeadlinesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topHeadlinesView: some View = TopHeadlinesContentView()
        let hostingVC = UIHostingController(rootView: topHeadlinesView)
        self.addChild(hostingVC)
        hostingVC.view.frame = self.view.frame
        self.view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
