//  Push.swift
//  SixNations
//
//  Copyright (c) 2019 Antoine Barrault. All rights reserved.

import Foundation

public struct Push {

    public init(firebaseToken: String, projectId: String) {
        self.projectId = projectId
        self.firebaseToken = firebaseToken
    }

    var firebaseToken: String
    var projectId: String

    private func pushNotficationRequest() -> URLRequest {
        let str = "https://fcm.googleapis.com/v1/projects/\(projectId)/messages:send"
        let url = URL(string: str)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(firebaseToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; UTF8", forHTTPHeaderField: "Content-Type")
        request.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        return request
    }

    public func sendPushData(_ data: Data?, completion: @escaping (Bool, Error?) -> Void)  {

        let request = pushNotficationRequest()
        let task = URLSession.shared.uploadTask(with: request, from: data!) { _, response, error in
            if let rep = response as? HTTPURLResponse {
                if rep.statusCode != 200 {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        }
        task.resume()

    }

}
