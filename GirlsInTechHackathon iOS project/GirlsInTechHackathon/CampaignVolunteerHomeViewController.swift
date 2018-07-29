//
//  CampaignVolunteerDetailsViewController.swift
//  GirlsInTechHackathon
//
//  Created by Hassaan Shakeel on 7/28/18.
//  Copyright © 2018 Hassaan Shakeel. All rights reserved.
//

import UIKit

class CampaignVolunteerHomeViewController: UIViewController {

  
  @IBOutlet weak var labelOneView: UIView!
  @IBOutlet weak var label1Underline: UIView!
  
  @IBOutlet weak var labelTwoView: UIView!
  
  @IBOutlet weak var pledgeDonationLabel: UILabel!
  @IBOutlet weak var label2Underline: UIView!
  
  @IBOutlet weak var separatorBorderView: UIView!
  
  @IBOutlet weak var campaignAnalyticsSuperview: UIView!
  
  @IBOutlet weak var pledgeFormButton: UIButton!
  @IBOutlet weak var volunteerResourcesImageButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let tapOne = UITapGestureRecognizer(target: self, action: #selector(self.handleLabelOneTap(_:)))
      labelOneView.addGestureRecognizer(tapOne)
      
      let tapTwo = UITapGestureRecognizer(target: self, action: #selector(self.handleLabelTwoTap(_:)))
      labelTwoView.addGestureRecognizer(tapTwo)
      
      self.labelOneView.alpha = 1.0
      self.labelTwoView.alpha = 0.45
      label1Underline.isHidden = false
      label2Underline.isHidden = true
      volunteerResourcesImageButton.isHidden = false
      campaignAnalyticsSuperview.isHidden = true
      
      
      
      createDropShadow()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.labelOneView.alpha = 1.0
    self.labelTwoView.alpha = 0.45
    label1Underline.isHidden = false
    label2Underline.isHidden = true
    volunteerResourcesImageButton.isHidden = false
    campaignAnalyticsSuperview.isHidden = true
    
    pledgeDonationLabel.text = "$ \(MyVariables.donationAmount)"
  }


  @objc func handleLabelOneTap(_ sender: Any) {
    self.labelOneView.alpha = 1.0
    self.labelTwoView.alpha = 0.45
    label1Underline.isHidden = false
    label2Underline.isHidden = true
    volunteerResourcesImageButton.isHidden = false
    campaignAnalyticsSuperview.isHidden = true
    
    pledgeFormButton.isEnabled = true

  }
  
  @objc func handleLabelTwoTap(_ sender: Any) {
    self.labelOneView.alpha = 0.45
    self.labelTwoView.alpha = 1.0
    label1Underline.isHidden = true
    label2Underline.isHidden = false
    volunteerResourcesImageButton.isHidden = true
    campaignAnalyticsSuperview.isHidden = false
    pledgeFormButton.isEnabled = false

  }
  
  func createDropShadow() {
    separatorBorderView.layer.shadowColor = UIColor.lightGray.cgColor
    separatorBorderView.layer.shadowOpacity = 1
    separatorBorderView.layer.shadowOffset = CGSize.zero
    separatorBorderView.layer.shadowRadius = 5
  }

}
