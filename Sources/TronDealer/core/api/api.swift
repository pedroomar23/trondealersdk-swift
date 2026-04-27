import Foundation 
import os.log 

public class EndpointApi: @unchecked Sendable {
    public static let shared = EndpointApi()
    let logger = Logger()
    let sesion: URLSession = {
        let delegate = SesionDelegate.shared
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.timeoutIntervalForRequest = 10 
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }()

    // MARK: - Register 

    public func register(name: String, webhook_url: String, webhook_secret: String, payout_method: String, sweep_wallet: String, completion: @escaping (Result<RegisterResp, NetworkError>) -> Void) async {
        let register = RegisterReq(
            name: name, 
            webhook_url: webhook_url, 
            webhook_secret: webhook_secret, 
            payout_method: payout_method, 
            sweep_wallet: sweep_wallet
        )
        print("✅ DEBUG: REGISTER REQUEST SUCCESS \(register)")
        let jsonBody = try? JSONEncoder().encode(register)
        let decoder = JSONDecoder() 
        var request = URLRequest(url: EndpointUrl.register.url)
        request.httpBody = jsonBody
        request.httpMethod = "POST"
        request.timeoutInterval = 10 
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        logger.info("✅ DEBUG: Iniciando Solicitud a POST \(EndpointUrl.register.url.absoluteString)")

        do {
            let (data, response) = try await sesion.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                logger.debug("✅ DEBUG: SERVER RESPONSE \(httpResponse.statusCode)")

                if let jsonData = String(data: data, encoding: .utf8) {
                    logger.debug("✅ DEBUG: SERVER RESPONSE \(jsonData)")
                } else {
                    logger.error("❌ DEBUG: SERVER RESPONSE FAILURE")
                }

                switch httpResponse.statusCode {
                    case 201: 
                        let registerResp = try decoder.decode(RegisterResp.self, from: data)
                        print("✅ DEBUG: JSON RESPONSE \(registerResp)")
                    case 400:
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 429:
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 500: 
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    default: 
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                }
            }
        } catch {
            logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(NetworkError.jsonFailure(msg: error.localizedDescription))")
            completion(.failure(.jsonFailure(msg: error.localizedDescription)))
        }
    }
}