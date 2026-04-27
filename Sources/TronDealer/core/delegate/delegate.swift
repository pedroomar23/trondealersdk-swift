import Foundation

class SesionDelegate: NSObject, URLSessionDelegate, @unchecked Sendable {
    static let shared = SesionDelegate() 

    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completion: @escaping (URLRequest?) -> Void) {
        var newRequest = request
        newRequest.httpShouldHandleCookies = true 
        completion(request)
    }

    func session(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completion: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completion(.useCredential, credential)
    }
}