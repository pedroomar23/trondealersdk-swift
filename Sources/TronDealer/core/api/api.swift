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
                        print("✅ DEBUG: JSON RESPONSE SUCCESS \(registerResp)")

                        let successDetails = String(data: data, encoding: .utf8)
                        logger.debug("✅ DEBUG: SERVER RESPONSE SUCCESS \(String(describing: successDetails))")
                    case 400:
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")

                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                    case 429:
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")

                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                    case 500: 
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")

                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                    default: 
                        logger.error("❌ DEBUG: JSON RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")

                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                }
            }
        } catch {
            logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(NetworkError.jsonFailure(msg: error.localizedDescription))")
            completion(.failure(.jsonFailure(msg: error.localizedDescription)))
        }
    }

    // MARK: - Clients 

    public func clients(completion: @escaping (Result<ClientsResp, NetworkError>) -> Void) async {
        let decoder = JSONDecoder() 
        var request = URLRequest(url: EndpointUrl.clients.url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10 
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        logger.info("✅ DEBUG: Iniciando Solicitud a GET \(EndpointUrl.clients.url.absoluteString)")

        do {
            let (data, response) = try await sesion.data(for: request) 

            if let httpResponse = response as? HTTPURLResponse {
                logger.debug("✅ DEBUG: Status Response \(httpResponse.statusCode)")

                if let jsonData = String(data: data, encoding: .utf8) {
                    logger.debug("✅ DEBUG: Server Response \(jsonData)")
                } else {
                    logger.error("❌ DEBUG: Server Response Failure")
                }

                switch httpResponse.statusCode {
                    case 200: 
                        let clientsResp = try decoder.decode(ClientsResp.self, from: data)
                        print("✅ DEBUG: JSON RESPONSE SUCCESS \(clientsResp)")

                        let successDetails = String(data: data, encoding: .utf8)
                        logger.debug("✅ DEBUG: SERVER RESPONSE SUCCESS \(String(describing: successDetails))")
                    case 401:
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                        
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                    case 403:
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")

                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                    case 500:
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")

                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                    default: 
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")

                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(String(describing: errorDetails))")
                }
            }
        } catch {
            logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(NetworkError.jsonFailure(msg: error.localizedDescription))")
            completion(.failure(.jsonFailure(msg: error.localizedDescription)))
        }
    }

    // MARK: - Wallets 

    public func walletsAsign(label: String, completion: @escaping (Result<WalletAsignResp, NetworkError>) -> Void) async {
        let walletReq = WalletAsignReq(
            label: label
        )
        print("✅ DEBUG: WALLET ASIGN REQUEST \(walletReq)")
        
        let jsonBody = try? JSONEncoder().encode(walletReq)
        let urlRequest = EndpointUrl.walletAssign.url
        var request = URLRequest(url: urlRequest)
        request.httpBody = jsonBody
        request.httpMethod = "POST"
        request.timeoutInterval = 10 
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        logger.info("✅ DEBUG: Inciciando Solicitud a POST \(urlRequest.absoluteString)")

        do {
            let (data, response) = try await sesion.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                logger.debug("✅ DEBUG: STATUS CODE RESPONSE \(httpResponse.statusCode)")

                if let jsonData = String(data: data, encoding: .utf8) {
                    logger.debug("✅ DEBUG: SERVER RESPONSE \(jsonData)")
                } else {
                    logger.error("❌ DEBUG: JSON FAILURE RESPONSE")
                }

                switch httpResponse.statusCode {
                    case 201: 
                        let walletResp = try JSONDecoder().decode(WalletAsignResp.self, from: data)
                        print("✅ DEBUG: JSON RESPONSE SUCCESS \(walletResp)")

                        let successDetails = String(data: data, encoding: .utf8)
                        logger.debug("✅ DEBUG: JSON RESPONSE SUCCESS \(String(describing: successDetails))")
                    case 401: 
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 403: 
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 500:
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    default:
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")  
                }
            }
        } catch {
            logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(NetworkError.jsonFailure(msg: error.localizedDescription))")
            completion(.failure(.jsonFailure(msg: error.localizedDescription)))
        }
    }

    public func walletBalance(address: String, completion: @escaping (Result<WalletBalanceResp, NetworkError>) -> Void) async {
        let walletReq = WalletBalanceReq(address: address)
        print("✅ DEBUG: WALLET BALANCE REQUEST SUCCESS \(walletReq)")
        
        let jsonBody = try? JSONEncoder().encode(walletReq)
        let urlBalance = EndpointUrl.walletBalance.url
        var request = URLRequest(url: urlBalance)
        request.httpBody = jsonBody
        request.httpMethod = "POST"
        request.timeoutInterval = 10 
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        logger.info("✅ DEBUG: Iniciando Solicitud a POST \(urlBalance.absoluteString)")

        do {
            let (data, response) = try await sesion.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                logger.debug("✅ DEBUG: SERVER RESPONSE SUCCESS \(httpResponse.statusCode)")

                if let jsonData = String(data: data, encoding: .utf8) {
                    logger.debug("✅ DEBUG: SERVER RESPONSE SUCCESS \(jsonData)")
                } else {
                    logger.error("❌ DEBUG: SERVER FAILURE RESPONSE")
                }

                switch httpResponse.statusCode {
                    case 200:
                        let walletResp = try JSONDecoder().decode(WalletBalanceResp.self, from: data) 
                        print("✅ DEBUG: JSON RESPONSE SUCCESS \(walletResp)")

                        let successDetails = String(data: data, encoding: .utf8)
                        logger.debug("✅ DEBUG: JSON RESPONSE SUCCESS \(String(describing: successDetails))")
                    case 401: 
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 403: 
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 500:
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    default:
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: SERVER RESPONSE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))") 
                }
            }
        } catch {
            logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(NetworkError.jsonFailure(msg: error.localizedDescription))")
            completion(.failure(.jsonFailure(msg: error.localizedDescription)))
        }
    }

    public func walletTransactions(address: String, limit: Int, offset: Int, status: String, completion: @escaping (Result<WalletTransactionsResp, NetworkError>) -> Void) async {
        let walletReq = TransactionsReq(address: address, limit: limit, offset: offset, status: status)
        print("✅ DEBUG: WALLET REQUEST SUCCESS \(walletReq)")

        let jsonBody = try? JSONEncoder().encode(walletReq)
        let urlTransaction = EndpointUrl.walletTransactions.url
        var request = URLRequest(url: urlTransaction)
        request.httpBody = jsonBody
        request.httpMethod = "POST"
        request.timeoutInterval = 10 
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        logger.info("✅ DEBUG: Iniciando Solicitud a POST \(urlTransaction.absoluteString)")

        do {
            let (data, response) = try await sesion.data(for: request) 

            if let httpResponse = response as? HTTPURLResponse {
                logger.debug("✅ DEBUG: SERVER RESPONSE SUCCESS \(httpResponse.statusCode)")

                if let jsonData = String(data: data, encoding: .utf8) {
                    logger.debug("✅ DEBUG: SERVER RESPONSE SUCCESS \(jsonData)")
                } else {
                    logger.error("❌ DEBUG: SERVER RESPONSE FAILURE")
                }

                switch httpResponse.statusCode {
                    case 200: 
                        let walletResp = try JSONDecoder().decode(WalletTransactionsResp.self, from: data) 
                        print("✅ DEBUG: JSON RESPONSE SUCCESS \(walletResp)")

                        let successDetails = String(data: data, encoding: .utf8)
                        logger.debug("✅ DEBUG: JSON DEBUG SUCCESS \(String(describing: successDetails))")
                    case 400:
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON DEBUG FAILURE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: STATUS CODE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 401: 
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON DEBUG FAILURE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: STATUS CODE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 403:
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON DEBUG FAILURE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: STATUS CODE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    case 500:
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON DEBUG FAILURE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: STATUS CODE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                    default: 
                        let errorDetails = String(data: data, encoding: .utf8)
                        logger.error("❌ DEBUG: JSON DEBUG FAILURE \(String(describing: errorDetails))")
                        logger.error("❌ DEBUG: STATUS CODE FAILURE \(NetworkError.statusFialure(code: httpResponse.statusCode))")
                }
            }
        } catch {
            logger.error("❌ DEBUG: JSON FAILURE RESPONSE \(NetworkError.jsonFailure(msg: error.localizedDescription))")
            completion(.failure(.jsonFailure(msg: error.localizedDescription)))
        }
    }

    // MARK: - WEBHOOKS 

    
}