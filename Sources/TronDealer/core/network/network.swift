import Foundation

public enum NetworkError: Error {
    case jsonFailure(msg: String)
    case statusFialure(code: Int)
}