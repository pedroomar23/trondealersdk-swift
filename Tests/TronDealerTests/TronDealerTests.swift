import XCTest
@testable import TronDealer

final class TronDealerTests: XCTestCase {

    // MARK: - Register 
    func testRegisterReq() async throws {
        let jsonString = """
            {
                "name": "My Business",
                "webhook_url": "https://example.com/webhooks/trondealer",
                "webhook_secret": "my-signing-secret",
                "payout_method": "wallet",
                "sweep_wallet": "0x1234567890abcdef1234567890abcdef12345678"
            }
        """
        let decoder = JSONDecoder()
        let requestReq = try decoder.decode(RegisterReq.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: REGISTER REQUEST SUCCESS \(requestReq)")

        XCTAssertEqual(requestReq.name, "My Business")
        XCTAssertEqual(requestReq.webhook_url, "https://example.com/webhooks/trondealer")
        XCTAssertEqual(requestReq.webhook_secret, "my-signing-secret")
        XCTAssertEqual(requestReq.payout_method, "wallet")
        XCTAssertEqual(requestReq.sweep_wallet, "0x1234567890abcdef1234567890abcdef12345678")
    }
    func testRegisterResp() async throws {
        let jsonString = """
            {
                "success": true,
                "client": {
                "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
                "name": "My Business",
                "api_key": "td_abc123def456...",
                "webhook_url": "https://example.com/webhooks/trondealer",
                "min_confirmations": null,
                "sweep_wallet": "0x1234567890abcdef1234567890abcdef12345678",
                "payout_method": "wallet",
                "qvapay_account": null,
                "zelle_contact": null,
                "is_active": true,
                "created_at": "2026-04-07T12:00:00.000Z"
            }
        }
        """
        let decoder = JSONDecoder()
        let registerResp = try decoder.decode(RegisterResp.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: REGISTER RESPONSE SUCCESS \(registerResp)")

        XCTAssertEqual(registerResp.success, true)
        XCTAssertEqual(registerResp.client.id, "a1b2c3d4-e5f6-7890-abcd-ef1234567890")
        XCTAssertEqual(registerResp.client.name, "My Business")
        XCTAssertEqual(registerResp.client.api_key, "td_abc123def456...")
        XCTAssertEqual(registerResp.client.webhook_url, "https://example.com/webhooks/trondealer")
        XCTAssertEqual(registerResp.client.min_confirmations, nil)
        XCTAssertEqual(registerResp.client.sweep_wallet, "0x1234567890abcdef1234567890abcdef12345678")
        XCTAssertEqual(registerResp.client.payout_method, "wallet")
        XCTAssertEqual(registerResp.client.qvapay_account, nil)
        XCTAssertEqual(registerResp.client.zelle_account, nil)
        XCTAssertEqual(registerResp.client.created_at, "2026-04-07T12:00:00.000Z")
    }

    // MARK: - Clients 
    func testCllients() async throws {
        let jsonString = """
            {
                "success": true,
                "client": {
                    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
                    "name": "My Business",
                    "webhook_url": "https://example.com/webhooks/trondealer",
                    "webhook_secret_masked": "****cret",
                    "has_webhook_secret": true,
                    "min_confirmations": 15,
                    "sweep_wallet": "0x1234567890abcdef1234567890abcdef12345678",
                    "payout_method": "wallet",
                    "qvapay_account": null,
                    "zelle_contact": null,
                    "created_at": "2026-04-07T12:00:00.000Z"
                }
        }
        """
        let decoder = JSONDecoder() 
        let clientResp = try decoder.decode(ClientsResp.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: CLIENT RESPONSE SUCCESS \(clientResp)")

        XCTAssertEqual(clientResp.success, true)
        XCTAssertEqual(clientResp.client.id, "a1b2c3d4-e5f6-7890-abcd-ef1234567890")
        XCTAssertEqual(clientResp.client.name, "My Business")
        XCTAssertEqual(clientResp.client.webhook_url, "https://example.com/webhooks/trondealer")
        XCTAssertEqual(clientResp.client.webhook_secret_masked, "****cret")
        XCTAssertEqual(clientResp.client.has_webhook_secret, true)
        XCTAssertEqual(clientResp.client.min_confirmations, 15)
        XCTAssertEqual(clientResp.client.sweep_wallet, "0x1234567890abcdef1234567890abcdef12345678")
        XCTAssertEqual(clientResp.client.payout_method, "wallet")
        XCTAssertEqual(clientResp.client.qvapay_account, nil)
        XCTAssertEqual(clientResp.client.zelle_account, nil)
        XCTAssertEqual(clientResp.client.created_at, "2026-04-07T12:00:00.000Z")
    }

    // MARK: - Wallets 

    func testWalletAsgin() async throws {
        let jsonString = """
            {
                 "label": "user-deposit-42"
            }
        """
        let decoder = JSONDecoder()
        let walletReq = try decoder.decode(WalletAsignReq.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: WALLET REQUEST SUCCESS \(walletReq)")

        XCTAssertEqual(walletReq.label, "user-deposit-42")
    }

    func testWalletAsignResp() async throws {
        let jsonString = """
            {
                "success": true,
                "wallet": {
                    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                    "address": "0xAbC1234567890DEF1234567890abcdef12345678",
                    "label": "string",
                    "status": "active",
                    "created_at": "2026-04-28T18:50:03.359Z"
                }
            }   
        """
        let walletResp = try JSONDecoder().decode(WalletAsignResp.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: JSON RESPONSE SUCCESS \(walletResp)")

        XCTAssertEqual(walletResp.success, true)
        XCTAssertEqual(walletResp.wallet.id, "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertEqual(walletResp.wallet.address, "0xAbC1234567890DEF1234567890abcdef12345678")
        XCTAssertEqual(walletResp.wallet.label, "string")
        XCTAssertEqual(walletResp.wallet.status, "active")
        XCTAssertEqual(walletResp.wallet.created_at, "2026-04-28T18:50:03.359Z")
    }

    func testWalletBalanceRep() async throws {
        let jsonString = """
            {
                "address": "0x1234567890abcdef1234567890abcdef12345678"
            }
        """
        let walletReq = try JSONDecoder().decode(WalletBalanceReq.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: JSON WALLET BALANCE REQUEST \(walletReq)")

        XCTAssertEqual(walletReq.address, "0x1234567890abcdef1234567890abcdef12345678")
    }

    func testWalletBalanceResp() async throws {
        let jsonString = """
                {
                    "success": true,
                    "wallet": {
                        "address": "string",
                        "label": "string",
                        "status": "active"
                    },
                    "balances": {
                        "NativeToken": "0.0042",
                        "USDT": "150.50",
                        "USDC": "75.00"
                    }
                }
        """
        let walletResp = try JSONDecoder().decode(WalletBalanceResp.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: JSON RESPONSE SUCCESS \(walletResp)")

        XCTAssertEqual(walletResp.success, true)
        XCTAssertEqual(walletResp.wallet.address, "string")
        XCTAssertEqual(walletResp.wallet.label, "string")
        XCTAssertEqual(walletResp.wallet.status, "active")
        XCTAssertEqual(walletResp.balances.NativeToken, "0.0042")
        XCTAssertEqual(walletResp.balances.USDT, "150.50")
        XCTAssertEqual(walletResp.balances.USDC, "75.00")
    }

    func testWalletTransactionsReq() async throws {
        let jsonString = """
            {
                "address": "0x1234567890abcdef1234567890abcdef12345678",
                "limit": 20,
                "offset": 0,
                "status": "confirmed"
            }
        """
        let walletReq = try JSONDecoder().decode(TransactionsReq.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: WALLET REQUEST SUCCESS \(walletReq)")

        XCTAssertEqual(walletReq.address, "0x1234567890abcdef1234567890abcdef12345678")
        XCTAssertEqual(walletReq.limit, 20)
        XCTAssertEqual(walletReq.offset, 0)
        XCTAssertEqual(walletReq.status, "confirmed")
    }

    func testWalletTransactionsResp() async throws {
        let jsonString = """
            {
                "success": true,
                "wallet": {
                    "address": "string",
                    "label": "string"
                },
                "total": 42,
                "limit": 20,
                "offset": 0,
                "transactions": [
                    {
                        "tx_hash": "0xabc123...",
                        "log_index": 0,
                        "block_number": 0,
                        "from_address": "string",
                        "to_address": "string",
                        "asset": "USDT",
                        "amount": "100.00",
                        "confirmations": 0,
                        "status": "detected",
                        "detected_at": "2026-04-30T17:30:51.463Z",
                        "created_at": "2026-04-30T17:30:51.463Z"
                    }
                ]
            }
        """
        let walletResp = try JSONDecoder().decode(WalletTransactionsResp.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: WALLET TRANSACTIONS RESPONSE SUCCESS \(walletResp)")

        XCTAssertEqual(walletResp.success, true)
        XCTAssertEqual(walletResp.wallet.address, "string")
        XCTAssertEqual(walletResp.wallet.label, "string")
        XCTAssertEqual(walletResp.total, 42)
        XCTAssertEqual(walletResp.limit, 20)
        XCTAssertEqual(walletResp.offset, 0)
        XCTAssertEqual(walletResp.transactions[0].tx_hash, "0xabc123...")
        XCTAssertEqual(walletResp.transactions[0].log_index, 0)
        XCTAssertEqual(walletResp.transactions[0].block_number, 0)
        XCTAssertEqual(walletResp.transactions[0].from_address, "string")
        XCTAssertEqual(walletResp.transactions[0].to_address, "string")
        XCTAssertEqual(walletResp.transactions[0].asset, "USDT")
        XCTAssertEqual(walletResp.transactions[0].amount, "100.00")
        XCTAssertEqual(walletResp.transactions[0].confirmations, 0)
        XCTAssertEqual(walletResp.transactions[0].status, "detected")
        XCTAssertEqual(walletResp.transactions[0].detected_at, "2026-04-30T17:30:51.463Z")
        XCTAssertEqual(walletResp.transactions[0].created_at, "2026-04-30T17:30:51.463Z")
    }

    // MARK: - WEBHOOKS

    func testWebHookIncomingReq() async throws {
        let jsonString = """
            {
                "event": "transaction.incoming",
                "timestamp": "2026-03-30T14:22:01.000Z",
                "data": {
                    "tx_hash": "0xabc123def456789abc123def456789abc123def456789abc123def456789abcd",
                    "block_number": 48123456,
                    "from_address": "0x742d35Cc6634C0532925a3b844Bc9e7595f2bD18",
                    "to_address": "0xAbC1234567890DEF1234567890abcdef12345678",
                    "asset": "USDT",
                    "amount": "150.50",
                    "confirmations": 3,
                    "wallet_label": "user-deposit-42",
                    "network": "bsc"
                }
            }
        """
        let webhookReq = try JSONDecoder().decode(WebHookIncomingReq.self, from: jsonString.data(using: .utf8)!)
        print("✅ DEBUG: WEBHOOK INCOMING REQUEST SUCCESS \(webhookReq)")

        XCTAssertEqual(webhookReq.event, "transaction.incoming")
        XCTAssertEqual(webhookReq.timestamp, "2026-03-30T14:22:01.000Z")
        XCTAssertEqual(webhookReq.data.tx_hash, "0xabc123def456789abc123def456789abc123def456789abc123def456789abcd")
        XCTAssertEqual(webhookReq.data.block_number, 48123456)
        XCTAssertEqual(webhookReq.data.from_address, "0x742d35Cc6634C0532925a3b844Bc9e7595f2bD18")
        XCTAssertEqual(webhookReq.data.to_address, "0xAbC1234567890DEF1234567890abcdef12345678")
        XCTAssertEqual(webhookReq.data.asset, "USDT")
        XCTAssertEqual(webhookReq.data.amount, "150.50")
        XCTAssertEqual(webhookReq.data.confirmations, 3)
        XCTAssertEqual(webhookReq.data.wallet_label, "user-deposit-42")
        XCTAssertEqual(webhookReq.data.network, "bsc")
    }
}
