import Foundation 

// MARK: - Wallet Asign Request 

public struct WalletAsignReq: Decodable, Hashable, Encodable, Sendable {
    public let label: String 

    enum CodingKeys: String, CodingKey {
        case label = "label"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
    }

    public init(label: String) {
        self.label = label 
    }
}

// MARK: - Wallet Asign Response 

public struct WalletAsignResp: Decodable, Hashable, Encodable, Sendable {
    public let success: Bool 
    public let wallet: Wallet

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case wallet = "wallet"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.wallet = try container.decode(Wallet.self, forKey: .wallet)
    }

    public init(success: Bool, wallet: Wallet) {
        self.success = success
        self.wallet = wallet
    }
}

public struct Wallet: Decodable, Hashable, Encodable, Sendable {
    public let id: String 
    public let address: String 
    public let label: String 
    public let status: String 
    public let created_at: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case address = "address"
        case label = "label"
        case status = "status"
        case created_at = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.address = try container.decode(String.self, forKey: .address)
        self.label = try container.decode(String.self, forKey: .label)
        self.status = try container.decode(String.self, forKey: .status)
        self.created_at = try container.decode(String.self, forKey: .created_at)
    }

    public init(id: String, address: String, label: String, status: String, created_at: String) {
        self.id = id 
        self.address = address
        self.label = label 
        self.status = status
        self.created_at = created_at
    }
}