import Foundation 

// MARK: - Register Request

public struct RegisterReq: Decodable, Hashable, Encodable, Sendable {
    public var name: String
    public var webhook_url: String 
    public var webhook_secret: String 
    public var payout_method: String 
    public var sweep_wallet: String 

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case webhook_url = "webhook_url"
        case webhook_secret = "webhook_secret"
        case payout_method = "payout_method"
        case sweep_wallet = "sweep_wallet"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.webhook_url = try container.decode(String.self, forKey: .webhook_url)
        self.webhook_secret = try container.decode(String.self, forKey: .webhook_secret)
        self.payout_method = try container.decode(String.self, forKey: .payout_method)
        self.sweep_wallet = try container.decode(String.self, forKey: .sweep_wallet)
    }

    public init(name: String, webhook_url: String, webhook_secret: String, payout_method: String, sweep_wallet: String) {
        self.name = name 
        self.webhook_url = webhook_url
        self.webhook_secret = webhook_secret
        self.payout_method = payout_method
        self.sweep_wallet = sweep_wallet
    }
}

// MARK: - Register Response 

public struct RegisterResp: Decodable, Hashable, Encodable, Sendable {
    public let success: Bool 
    public let client: Client

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case client = "client"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.client = try container.decode(Client.self, forKey: .client)
    }

    public init(success: Bool, client: Client) {
        self.success = success
        self.client = client
    }
}

public struct Client: Decodable, Hashable, Encodable, Sendable {
    public let id: String 
    public let name: String 
    public let api_key: String 
    public let webhook_url: String 
    public let min_confirmations: Int? 
    public let sweep_wallet: String 
    public let payout_method: String 
    public let qvapay_account: String? 
    public let zelle_account: String? 
    public let created_at: String 

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case api_key = "api_key"
        case webhook_url = "webhook_url"
        case min_confirmations = "min_confirmations"
        case sweep_wallet = "sweep_wallet"
        case payout_method = "payout_method"
        case qvapay_account = "qvapay_account"
        case zelle_account = "zelle_account"
        case created_at = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.api_key = try container.decode(String.self, forKey: .api_key)
        self.webhook_url = try container.decode(String.self, forKey: .webhook_url)
        self.min_confirmations = try container.decodeIfPresent(Int.self, forKey: .min_confirmations) 
        self.sweep_wallet = try container.decode(String.self, forKey: .sweep_wallet)
        self.payout_method = try container.decode(String.self, forKey: .payout_method)
        self.qvapay_account = try container.decodeIfPresent(String.self, forKey: .qvapay_account) 
        self.zelle_account = try container.decodeIfPresent(String.self, forKey: .zelle_account)
        self.created_at = try container.decode(String.self, forKey: .created_at)
    }

    public init(id: String, name: String, api_key: String, webhook_url: String, min_confirmations: Int?, sweep_wallet: String, payout_method: String, qvapay_account: String?, zelle_account: String?, created_at: String) {
        self.id = id 
        self.name = name 
        self.api_key = api_key
        self.webhook_url = webhook_url
        self.min_confirmations = min_confirmations
        self.sweep_wallet = sweep_wallet
        self.payout_method = payout_method
        self.qvapay_account = qvapay_account
        self.zelle_account = zelle_account
        self.created_at = created_at
    }
}