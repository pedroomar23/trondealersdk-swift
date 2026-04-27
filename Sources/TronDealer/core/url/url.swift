import Foundation 

public enum EndpointUrl {
    public static let urlApi = "https://api.trondealer.com/v2"

    case register 
    case clients 
    case walletAssign
    case walletBalance 
    case walletTransactions 
    case webhooksIncoming 
    case webhookConfirmed 

    var path: String {
        switch self {
            case .register: return "/clients/register-open"
            case .clients: return "/clients/me"
            case .walletAssign: return "/wallets/assign"
            case .walletBalance: return "/wallets/balance"
            case .walletTransactions: return "/wallets/transactions"
            case .webhooksIncoming: return "/webhooks/transaction.incoming"
            case .webhookConfirmed: return "/webhooks/transaction.confirmed"
        }
    }

    var url: URL {
        return URL(string: EndpointUrl.urlApi + path)!
    }
}