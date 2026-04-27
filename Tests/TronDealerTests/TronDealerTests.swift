import XCTest
@testable import TronDealer

final class TronDealerTests: XCTestCase {
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
}
