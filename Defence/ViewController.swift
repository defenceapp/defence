import Cocoa
import SafariServices
import StoreKit

class ViewController: NSViewController {

    @IBOutlet weak var enabledOrDisabledImage: NSImageView!
    @IBOutlet weak var enabledOrDisabledLabel: NSTextField!
    @IBOutlet weak var purchaseProButton: NSButtonCell!
    var proProduct: SKProduct? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        purchaseProButton.isEnabled = false
        updateContentBlockerState()
        reloadProProduct()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateContentBlockerState), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "Defence"
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func updateContentBlockerState() {
        
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: Constants.ContentBlockerBundleId) {
            (state, error) in
            
            if let state = state {
                DispatchQueue.main.async {
                    let isEnabled = state.isEnabled
                    let enabledOrDisabledIcon = isEnabled ? NSImage.statusAvailableName : NSImage.statusUnavailableName
                    self.enabledOrDisabledImage.image = NSImage(named: enabledOrDisabledIcon)!
                    self.enabledOrDisabledLabel.stringValue = isEnabled ? "Enabled" : "Disabled"
                }
            }
            else {
                
                print("No state")
            }
        }
    }
    
    @IBAction func showPreferences(_ sender: NSButtonCell) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: Constants.ContentBlockerBundleId) { (error) in
            if error != nil {
                print("Error launching the extension's preferences: %@", error);
                return;
            }
        }
    }
    
    @objc func reloadProProduct() {
        proProduct = nil
        
        Constants.store.requestProducts { [weak self] success, products in
            guard let self = self else { return }
            if success {
                guard let products = products else {
                    
                    return
                }
                
                for product in products {
                    if (product.productIdentifier == Constants.DefenceProId) {
                        
                        DispatchQueue.main.async {
                            self.proProduct = product
                            self.purchaseProButton.isEnabled = true
                        }
                    }
                }
            }
        }
    }

    @IBAction func purchasePro(_ sender: NSButtonCell) {
       
        Constants.store.buyProduct(proProduct!)
    }
}
