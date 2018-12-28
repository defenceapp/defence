import Foundation

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        
        guard let sharedDirectory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:"8EUMXJ6BD8.app.defenceblocker.defence") else {
            
            return
        }

        let sharedJsonUrl = sharedDirectory.appendingPathComponent("blockerList").appendingPathExtension("json")
        
        let attachmentOptional = NSItemProvider(contentsOf: sharedJsonUrl)
        
        guard let attachment = attachmentOptional else {
            NSLog("Could not load")
            return
        }
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
}
