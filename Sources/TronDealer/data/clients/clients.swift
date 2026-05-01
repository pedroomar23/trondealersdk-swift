import Foundation

public struct ClientsResp: Decodable, Hashable, Encodable, Sendable {
    public let success: Bool 
    public let client: Clients

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case client = "client"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        client = try container.decode(Clients.self, forKey: .client)
    }

    public init(success: Bool, client: Clients) {
        self.success = success
        self.client = client
    }
}

public struct Clients: Decodable, Hashable, Encodable, Sendable {
    public let id: String 
    public let name: String 
    public let webhook_url: String 
    public let webhook_secret_masked: String 
    public let has_webhook_secret: Bool 
    public let min_confirmations: Int 
    public let sweep_wallet: String 
    public let payout_method: String 
    public let qvapay_account: String? 
    public let zelle_account: String?
    public let created_at: String 

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case webhook_url = "webhook_url"
        case webhook_secret_masked = "webhook_secret_masked"
        case has_webhook_secret = "has_webhook_secret"
        case min_confirmations = "min_confirmations"
        case sweep_wallet = "sweep_wallet"
        case payout_method = "payout_method"
        case qvapay_account = "qvapay_account"
        case zelle_account = "zelle_account"
        case created_at = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        webhook_url = try container.decode(String.self, forKey: .webhook_url)
        webhook_secret_masked = try container.decode(String.self, forKey: .webhook_secret_masked)
        has_webhook_secret = try container.decode(Bool.self, forKey: .has_webhook_secret)
        min_confirmations = try container.decode(Int.self, forKey: .min_confirmations)
        sweep_wallet = try container.decode(String.self, forKey: .sweep_wallet)
        payout_method = try container.decode(String.self, forKey: .payout_method)
        qvapay_account = try container.decodeIfPresent(String.self, forKey: .qvapay_account)
        zelle_account = try container.decodeIfPresent(String.self, forKey: .zelle_account)
        created_at = try container.decode(String.self, forKey: .created_at)
    }

    public init(id: String, name: String, webhook_url: String, webhook_secret_masked: String, has_webhook_secret: Bool, min_confirmations: Int, sweep_wallet: String, payout_method: String, qvapay_account: String?, zelle_account: String?, created_at: String) {
        self.id = id
        self.name = name
        self.webhook_url = webhook_url
        self.webhook_secret_masked = webhook_secret_masked
        self.has_webhook_secret = has_webhook_secret
        self.min_confirmations = min_confirmations
        self.sweep_wallet = sweep_wallet
        self.payout_method = payout_method
        self.qvapay_account = qvapay_account
        self.zelle_account = zelle_account
        self.created_at = created_at
    }
}



