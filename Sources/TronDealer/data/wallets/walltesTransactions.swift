import Foundation 

// MARK: - Wallets Transactions Request 

public struct TransactionsReq: Decodable, Hashable, Encodable, Sendable {
    public let address: String 
    public let limit: Int 
    public let offset: Int 
    public let status: String 

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case limit = "limit"
        case offset = "offset"
        case status = "status"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) 
        self.address = try container.decode(String.self, forKey: .address)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.status = try container.decode(String.self, forKey: .status)
    }

    public init(address: String, limit: Int, offset: Int, status: String) {
        self.address = address
        self.limit = limit
        self.offset = offset
        self.status = status
    }
}

// MARK: - Wallets Transactions Response 

public struct WalletTransactionsResp: Decodable, Hashable, Encodable, Sendable {
    public let success: Bool 
    public let wallet: NewWallet
    public let total: Int 
    public let limit: Int 
    public let offset: Int 
    public let transactions: [Transactions]

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case wallet = "wallet"
        case total = "total"
        case limit = "limit"
        case offset = "offset"
        case transactions = "transactions"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.wallet = try container.decode(NewWallet.self, forKey: .wallet)
        self.total = try container.decode(Int.self, forKey: .total)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.transactions = try container.decode([Transactions].self, forKey: .transactions)
    }

    public init(success: Bool, wallet: NewWallet, total: Int, limit: Int, offset: Int, transactions: [Transactions]) {
        self.success = success
        self.wallet = wallet
        self.total = total 
        self.limit = limit
        self.offset = offset
        self.transactions = transactions
    }
}

public struct NewWallet: Decodable, Hashable, Encodable, Sendable {
    public let address: String 
    public let label: String 

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case label = "label"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try container.decode(String.self, forKey: .address)
        self.label = try container.decode(String.self, forKey: .label)
    }

    public init(address: String, label: String) {
        self.address = address
        self.label = label
    }
}

public struct Transactions: Decodable, Hashable, Encodable, Sendable {
    public let tx_hash: String 
    public let log_index: Int 
    public let block_number: Int 
    public let from_address: String 
    public let to_address: String 
    public let asset: String 
    public let amount: String 
    public let confirmations: Int 
    public let status: String
    public let detected_at: String 
    public let created_at: String 

    enum CodingKeys: String, CodingKey {
        case tx_hash = "tx_hash"
        case log_index = "log_index"
        case block_number = "block_number"
        case from_address = "from_address"
        case to_address = "to_address"
        case asset = "asset"
        case amount = "amount"
        case confirmations = "confirmations"
        case status = "status"
        case detected_at = "detected_at"
        case created_at = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tx_hash = try container.decode(String.self, forKey: .tx_hash)
        self.log_index = try container.decode(Int.self, forKey: .log_index)
        self.block_number = try container.decode(Int.self, forKey: .block_number)
        self.from_address = try container.decode(String.self, forKey: .from_address)
        self.to_address = try container.decode(String.self, forKey: .to_address)
        self.asset = try container.decode(String.self, forKey: .asset)
        self.amount = try container.decode(String.self, forKey: .amount)
        self.confirmations = try container.decode(Int.self, forKey: .confirmations)
        self.status = try container.decode(String.self, forKey: .status)
        self.detected_at = try container.decode(String.self, forKey: .detected_at)
        self.created_at = try container.decode(String.self, forKey: .created_at)
    }

    public init(tx_hash: String, log_index: Int, block_number: Int, from_address: String, to_address: String, asset: String, amount: String, confirmations: Int, status: String, detected_at: String, created_at: String) {
        self.tx_hash = tx_hash
        self.log_index = log_index
        self.block_number = block_number
        self.from_address = from_address
        self.to_address = to_address
        self.asset = asset
        self.amount = amount
        self.confirmations = confirmations
        self.status = status
        self.detected_at = detected_at
        self.created_at = created_at
    }
}