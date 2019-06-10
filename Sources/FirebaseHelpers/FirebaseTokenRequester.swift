//  FirebaseTokenRequester.swift
//  SixNations
//
//  Copyright (c) 2019 Antoine Barrault. All rights reserved.

import Foundation
import OAuth2

enum MyError: Error {
    case serviceAccountTokenProviderNotCreated
}

let scopes = ["https://www.googleapis.com/auth/firebase.remoteconfig",
              "https://www.googleapis.com/auth/firebase.messaging"]

public struct FirebaseTokenRequester {

    var ressourceName: String
    public init(for ressourceName: String) {
        self.ressourceName = ressourceName
    }

    public func requesToken(completion: @escaping (String) -> Void) throws {

        let filePath = Bundle.main.path(forResource: ressourceName, ofType: "json")
        let fileUrl = URL(fileURLWithPath: filePath!)
        guard let tokenProvider = ServiceAccountTokenProvider(credentialsURL: fileUrl,
                                                              scopes: scopes)
            else {
                throw MyError.serviceAccountTokenProviderNotCreated
        }

        try tokenProvider.withToken { (token, _) in
            if let token = token?.AccessToken {
                completion(token)
            }
        }

    }
}
