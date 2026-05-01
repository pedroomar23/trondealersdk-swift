import Foundation 

// MARK: - Wallet Balance Request

public struct WalletBalanceReq: Decodable, Hashable, Encodable, Sendable {
    public let address: String 

    enum CodingKeys: String, CodingKey {
        case address = "address"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try container.decode(String.self, forKey: .address)
    }

    public init(address: String) {
        self.address = address
    }
}   

// MARK: - Wallet Balance Response 

public struct WalletBalanceResp: Decodable, Hashable, Encodable, Sendable {
    public let success: Bool 
    public let wallet: Wallets
    public let balances: Balance

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case wallet = "wallet"
        case balances = "balances"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.wallet = try container.decode(Wallets.self, forKey: .wallet)
        self.balances = try container.decode(Balance.self, forKey: .balances)
    }

    public init(success: Bool, wallet: Wallets, balances: Balance) {
        self.success = success
        self.wallet = wallet
        self.balances = balances
    }
}

public struct Wallets: Decodable, Hashable, Encodable, Sendable {
    public let address: String 
    public let label: String 
    public let status: String 

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case label = "label"
        case status = "status"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try container.decode(String.self, forKey: .address)
        self.label = try container.decode(String.self, forKey: .label)
        self.status = try container.decode(String.self, forKey: .status)
    }

    public init(address: String, label: String, status: String) {
        self.address = address
        self.label = label 
        self.status = status
    }
}

public struct Balance: Decodable, Hashable, Encodable, Sendable {
    public let NativeToken: String 
    public let USDT: String 
    public let USDC: String 

    enum CodingKeys: String, CodingKey {
        case NativeToken = "NativeToken"
        case USDT = "USDT"
        case USDC = "USDC"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.NativeToken = try container.decode(String.self, forKey: .NativeToken)
        self.USDT = try container.decode(String.self, forKey: .USDT)
        self.USDC = try container.decode(String.self, forKey: .USDC)
    }

    public init(NativeToken: String, USDT: String, USDC: String) {
        self.NativeToken = NativeToken
        self.USDT = USDT
        self.USDC = USDC
    }
}