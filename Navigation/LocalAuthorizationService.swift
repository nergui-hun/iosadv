//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by M M on 7/11/23.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {

    enum BiometricType {
        case none
        case touchID
        case faceID
        case unknown
    }

    enum BiometricError: LocalizedError {
        case authentificationFailed
        case userCancel
        case userFallback
        case biometryNotAvailable
        case biometryNotEnrolled
        case biometryLockout
        case unknown


        var errorDescription: String? {
            switch self {
            case .authentificationFailed:
                return "There was a problem verifying your identity"
            case .userCancel:
                return "You pressed cancel"
            case .userFallback:
                return "You pressed password"
            case .biometryNotAvailable:
                return "FaceID/TouchID not available"
            case .biometryNotEnrolled:
                return "FaceID/TouchID not set up"
            case .biometryLockout:
                return "FaceID/TouchID is locked"
            case .unknown:
                return "FaceID/TouchID can not be configured"
            }
        }
    }

    static let shared = LocalAuthorizationService()

    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String

    private var error: NSError?

    init(
        policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        localizedReason: String = "Verify your identity",
        localizedFallbackTitle: String = "Enter your password",
        localizedCancelTitle: String = "Cancel" //
    ) {
        self.policy = policy
        self.localizedReason = localizedReason

        context.localizedFallbackTitle = localizedFallbackTitle
        context.localizedCancelTitle = localizedCancelTitle
    }

    private func canEvaluate(completion: (Bool, BiometricType, BiometricError?) -> Void) {
        guard context.canEvaluatePolicy(policy, error: &error) else {
            let type = getBiometricType(for: context.biometryType)

            guard let error = error else { return completion(false, type, nil) }
            return completion(false, getBiometricType(for: context.biometryType), getBiometricError(from: error))
        }
        return completion(true, getBiometricType(for: context.biometryType), nil)
    }

        func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, BiometricError?) -> Void) {
            context.evaluatePolicy(policy, localizedReason: localizedReason) { [weak self] success, error in
                DispatchQueue.main.async {
                    if success {
                        authorizationFinished(true, nil)
                    } else {
                        guard let error = error else { return authorizationFinished(false, nil) }

                        authorizationFinished(false, self?.getBiometricError(from: error as NSError))
                    }
                }
        }
    }

    private func getBiometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return BiometricType.none
        case .touchID:
            return BiometricType.touchID
        case .faceID:
            return BiometricType.faceID
        @unknown default:
            return BiometricType.unknown
        }
    }

    private func getBiometricError(from nsError: NSError) -> BiometricError {
        guard let error = nsError as? BiometricError else { return BiometricError.unknown}

        switch error {
        case .authentificationFailed:
            return .authentificationFailed
        case .userCancel:
            return .userCancel
        case .userFallback:
            return .userFallback
        case .biometryNotAvailable:
            return .biometryNotAvailable
        case .biometryNotEnrolled:
            return .biometryNotEnrolled
        case .biometryLockout:
            return .biometryLockout
        default:
            return .unknown
        }
    }

}
