//
//  CampaignDiscoverHomePageViewController.swift
//  GirlsInTechHackathon
//
//  Created by Hassaan Shakeel on 7/28/18.
//  Copyright © 2018 Hassaan Shakeel. All rights reserved.
//

import UIKit

class CampaignDiscoverHomePageViewController: UIViewController {

  @IBOutlet weak var volunteerButton: UIButton!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }


    

  @IBAction func volunteerButtonTapped(_ sender: Any) {
    MyVariables.deeplink = true
    MyVariables.saveTheBayVoluntered = true
    self.tabBarController?.selectedIndex = 1
    
  }
  
  
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
