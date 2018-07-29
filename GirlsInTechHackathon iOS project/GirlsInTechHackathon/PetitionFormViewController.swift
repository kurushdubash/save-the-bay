import UIKit
import DocuSignSDK

class PetitionFormViewController: UIViewController {
  
  @IBOutlet weak var signFormButton: UIButton!
  
  @IBOutlet weak var donationAmountTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var fullNameTextField: UITextField!
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var bottomFormConstraint: NSLayoutConstraint!
  @IBOutlet weak var scrollView: UIScrollView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    fullNameTextField.addTarget(self, action: #selector(enterPressedONameFormTextField), for: .editingDidEndOnExit)
    emailTextField.addTarget(self, action: #selector(enterPressedOnEmailFormTextField), for: .editingDidEndOnExit)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)

  }
  
  @IBAction func closeButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    
    
  }
  
  @IBAction func signFormButtonTapped(_ sender: Any) {
    
    let templateManager = DSMTemplatesManager.init()
    
    let envelopeDefaults = DSMEnvelopeDefaults()
    let petitionSignerDefaults = DSMRecipientDefault()
    petitionSignerDefaults.inPersonSignerName = fullNameTextField.text! // TODO take value from textfield
    petitionSignerDefaults.recipientName = "Donald Smith"
    petitionSignerDefaults.recipientRoleName = "Signer"
    petitionSignerDefaults.recipientSelectorType = DSMEnvelopeDefaultsUniqueRecipientSelectorType.recipientRoleName
    petitionSignerDefaults.recipientEmail = "donaldsmiththegreat@gmail.com"
    petitionSignerDefaults.recipientType = DSMRecipientType.inPersonSigner
    
    MyVariables.donationAmount = MyVariables.donationAmount + Int(donationAmountTextField.text!)!
    
    envelopeDefaults.recipientDefaults = [petitionSignerDefaults]
    
    templateManager.presentSendTemplateControllerWithTemplate(withId: "a020bbec-dcf9-4463-9ca6-950038e21765", envelopeDefaults: envelopeDefaults, pdfToInsert: nil, insertAtPosition: DSMDocumentInsertAtPosition.beginning, signingMode: DSMSigningMode.online, presenting: self, animated: true) { (viewController: UIViewController?, error: Error?) in
      
      self.scrollView.setContentOffset(CGPoint.zero, animated: true)
      self.fullNameTextField.text = ""
      self.emailTextField.text = ""
      self.donationAmountTextField.text = ""
      
      print("Completed Signing")
    }
    
    APISampleTest()
    
    
    
  }
  
  
  @IBAction func editingDidBeginOnTextField(_ sender: Any) {
    bottomFormConstraint.constant = 550
    view.updateConstraints()
    
    
  }
  
  @objc func enterPressedONameFormTextField() {
    //do something with typed text if needed
    fullNameTextField.resignFirstResponder()
    emailTextField.becomeFirstResponder()
  }
  
  @objc func enterPressedOnEmailFormTextField() {
    //do something with typed text if needed
    emailTextField.resignFirstResponder()
    donationAmountTextField.becomeFirstResponder()
  }
  
  @objc func keyboardDidShow() {
    var offset = scrollView.contentOffset
    offset.y = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height
    scrollView.setContentOffset(offset, animated: true)
  }
  
  /*
   "name": "Kurush Dubash",
   "email": "dubash.kurush@gmail.com",
   "docusign_link": "https://support.docusign.com/en/answers/00009432",
   "donation_amount": 50.45,// This should be a double/float
   "organization_id": "503d21c8-92a2-11e8-9eb6-529269fb1459"
   */
  func APISampleTest() {
    let url = URL(string: "http://206.189.213.5:5000/submit-pledge/hassaan22")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "PUT"
    
    let jsonDict: [String: Any] = ["name": fullNameTextField.text!,
                                   "email": emailTextField.text!,
                                   "docusign_link": "https://support.docusign.com/en/answers/00009432",
                                   "donation_amount": donationAmountTextField.text!,
                                   "organization_id": "db29bcee-92c1-11e8-b405-ced46763e96b"]
    let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)!
    
    
    
    
    
    request.httpBody = jsonString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print("error=\(String(describing: error))")
        return
      }
      
      if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
        print("response = \(String(describing: response))")
      }
      
      let responseString = String(data: data, encoding: .utf8)
      print("responseString = \(String(describing: responseString))")
    }
    task.resume()
  }
  
}
