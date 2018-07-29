import UIKit

class MyCampaignsViewController: UIViewController {
  
  @IBOutlet weak var noCampaignsView: UIView!
  
  @IBOutlet weak var discoverCampaignsButton: UIButton!
  @IBOutlet weak var saveTheBayCampaignTileButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if MyVariables.deeplink == true {
      saveTheBayCampaignTileButtonTapped(self)
    }
    
    if (MyVariables.saveTheBayVoluntered == true) {
      // there are campaigns
      saveTheBayCampaignTileButton.isHidden = false
      saveTheBayCampaignTileButton.isEnabled = true
      noCampaignsView.isHidden = true
    } else {
      // there are no campaigns
      saveTheBayCampaignTileButton.isHidden = true
      saveTheBayCampaignTileButton.isEnabled = false
      noCampaignsView.isHidden = false
    }

  }
  
  @IBAction func discoverCampaignsButtonTapped(_ sender: Any) {
    self.tabBarController?.selectedIndex = 0
    
  }

  
  @IBAction func saveTheBayCampaignTileButtonTapped(_ sender: Any) {
    if (MyVariables.deeplink == true) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let controller = storyboard.instantiateViewController(withIdentifier: "CampaignVolunteerHomeViewController")
      self.navigationController?.pushViewController(controller, animated: true)
      
    }
    MyVariables.deeplink = false

    
  }
}
