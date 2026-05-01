import Foundation 

// MARK: - WebHook Incoming Request 
public struct WebHookIncomingReq: Decodable, Hashable, Encodable, Sendable {
    public let event: String
    public let timestamp: String 
    public let data: SData

    enum CodingKeys: String, CodingKey {
        case event = "event"
        case timestamp = "timestamp"
        case data = "data"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.event = try container.decode(String.self, forKey: .event)
        self.timestamp = try container.decode(String.self, forKey: .timestamp)
        self.data = try container.decode(SData.self, forKey: .data)
    }

    public init(event: String, timestamp: String, data: SData) {
        self.event = event
        self.timestamp = timestamp
        self.data = data 
    }
}

public struct SData: Decodable, Hashable, Encodable, Sendable {
    public let tx_hash: String 
    public let block_number: Int 
    public let from_address: String 
    public let to_address: String 
    public let asset: String 
    public let amount: String 
    public let confirmations: Int 
    public let wallet_label: String 
    public let network: String 

    enum CodingKeys: String, CodingKey {
        case tx_hash = "tx_hash"
        case block_number = "block_number"
        case from_address = "from_address"
        case to_address = "to_address"
        case asset = "asset"
        case amount = "amount"
        case confirmations = "confirmations"
        case wallet_label = "wallet_label"
        case network = "network"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tx_hash = try container.decode(String.self, forKey: .tx_hash)
        self.block_number = try container.decode(Int.self, forKey: .block_number)
        self.from_address = try container.decode(String.self, forKey: .from_address)
        self.to_address = try container.decode(String.self, forKey: .to_address)
        self.asset = try container.decode(String.self, forKey: .asset)
        self.amount = try container.decode(String.self, forKey: .amount)
        self.confirmations = try container.decode(Int.self, forKey: .confirmations)
        self.wallet_label = try container.decode(String.self, forKey: .wallet_label)
        self.network = try container.decode(String.self, forKey: .network)
    }

    public init(tx_hash: String, block_number: Int, from_address: String, to_address: String, asset: String, amount: String, confirmations: Int, wallet_label: String, network: String) {
        self.tx_hash = tx_hash
        self.block_number = block_number
        self.from_address = from_address
        self.to_address = to_address
        self.asset = asset
        self.amount = amount
        self.confirmations = confirmations
        self.wallet_label = wallet_label
        self.network = network
    }
}
