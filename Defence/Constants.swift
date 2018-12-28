public struct Constants {
    
    public static let GroupContainerId = "8EUMXJ6BD8.app.defenceblocker.defence"
    
    public static let AppBundleId = "app.defenceblocker.defence"
    
    public static let ContentBlockerBundleId = Constants.AppBundleId + ".ContentBlocker"

    public static let DefenceProId = "defence_pro_mac"
    
    private static let productIdentifiers: Set<ProductIdentifier> = [Constants.DefenceProId]
    
    public static let store = IAPManager(productIdentifiers: Constants.productIdentifiers)
}
