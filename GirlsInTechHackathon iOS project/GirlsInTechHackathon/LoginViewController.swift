import UIKit
import DocuSignSDK
import SVProgressHUD


struct MyVariables {
  static var deeplink = false
  static var saveTheBayVoluntered = false
  static var donationAmount = 255
}

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signupButton: UIButton!
  
  var gradientLayer: CAGradientLayer!
  // MARK: - View Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureEmailTextField()
    configurePasswordTextField()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  // MARK: - UI Configuration Methods
  
  func configureEmailTextField() {
    emailTextField.addTarget(self, action: #selector(enterPressedOnEmailTextField), for: .editingDidEndOnExit)
    emailTextField.returnKeyType = .next

  }
  
  
  func configurePasswordTextField() {
    passwordTextField.addTarget(self, action: #selector(enterPressedOnPasswordTextField), for: .editingDidEndOnExit)
    passwordTextField.returnKeyType = .go
    
  }
  
  
  
  // MARK: - Action methods
  
  @objc func enterPressedOnEmailTextField() {
    //do something with typed text if needed
    emailTextField.resignFirstResponder()
    passwordTextField.becomeFirstResponder()
  }
  
  @objc func enterPressedOnPasswordTextField() {
    //do something with typed text if needed
    passwordTextField.resignFirstResponder()
  }
  
  @IBAction func loginButtonTapped(_ sender: Any) {
    SVProgressHUD.show(withStatus: "Logging in")
    login()
  }
  
  @IBAction func signupButtonTapped(_ sender: Any) {
    // TODO
    
  }
  
  func login() {
    let loginValidation = validateEmailAndPassword()
    
    var errorString = ""
    
    switch loginValidation {
    case .InvalidEmail:
      errorString = "Invalid Email.\nPlease try again"
      SVProgressHUD.showError(withStatus: errorString)

    case .InvalidPassword:
      errorString = "Invalid Password.\nPlease try again"
      SVProgressHUD.showError(withStatus: errorString)

    case .InvalidEmailAndPassword:
      errorString = "Invalid Email and Password.\nPlease try again"
      SVProgressHUD.showError(withStatus: errorString)

    case .Success:
      
      DSMManager.login(withUserId: "donaldsmiththegreat@gmail.com", password: "hassaan22", integratorKey: "06bfde9d-3d9c-4cf5-8e1c-bd3d10aa04d6", host: URL.init(string: "https://demo.docusign.net/restapi")) { (error: Error?) in
        SVProgressHUD.dismiss()
        
        if (error == nil) {
          self.presentHomepage()
        } else {
          self.showInvalidLoginCredentialsHUD()
        }
      }
    }
    
    
  }
  
  func presentHomepage() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "TabBarController")
    self.present(controller, animated: true, completion: nil)
  }
  
  
  // MARK: - TextField Validation Methods
  
  func validateEmailAndPassword() -> LoginValidation {
    let emailValidation = validateEmail(emailTextField.text?.trimmingCharacters(in: .whitespaces))
    let passwordValidation = validatePassword(passwordTextField.text)
    if (emailValidation == .InvalidEmail && passwordValidation == .InvalidPassword) {
      return .InvalidEmailAndPassword
    }
    if (emailValidation == .InvalidEmail) {
      return .InvalidEmail
    }
    if (passwordValidation == .InvalidPassword) {
      return .InvalidPassword
    }
    return .Success
  }
  
  
  func validateEmail(_ emailString: String?) -> LoginValidation {
    guard let emailString = emailString else {
      return .InvalidEmail
    }
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    if emailTest.evaluate(with: emailString) {
      print("success")
      return .Success
    } else {
      print("fail")
      return .InvalidEmail
    }
  }
  
  func validatePassword(_ passwordString: String?) -> LoginValidation {
    guard let passwordString = passwordString else {
      return .InvalidEmail
    }
    
    if (passwordString.count < 6) {
      return .InvalidPassword
    }
    return .Success
  }
  
  func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
  }
  
  
  // MARK: - UI Helper Methods
  
  func showInvalidLoginCredentialsHUD() {
    SVProgressHUD.showError(withStatus: "Invalid Email or Password.\nPlease try again.")
    print("Invalid Email or Password. Please try again.")
    
  }

  
  
  enum LoginValidation: String {
    case InvalidEmail
    case InvalidPassword
    case InvalidEmailAndPassword
    case Success
  }
}

