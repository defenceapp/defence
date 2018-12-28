import Foundation
import SafariServices

public class BlockListUpdater {
    
    static func updateBlockerList() {
        
    }
    
    static func syncBlockerList() {
        
        guard let sharedDirectory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.GroupContainerId) else {
            
            return
        }
        
        let jsonUrl = Bundle.main.resourceURL!.appendingPathComponent("blockerList.json")
        let sharedJsonUrl = sharedDirectory.appendingPathComponent("blockerList.json")
        
        if !FileManager.default.contentsEqual(atPath: sharedJsonUrl.path, andPath: jsonUrl.path) {
            
            try? FileManager.default.removeItem(at: sharedJsonUrl)
            try! FileManager.default.copyItem(at: jsonUrl, to: sharedJsonUrl)
        }
        
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: Constants.ContentBlockerBundleId)
    }
}
