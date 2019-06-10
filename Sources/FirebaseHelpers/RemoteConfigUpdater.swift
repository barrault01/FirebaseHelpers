//
//  RemoteConfigUpdater.swift
//  
//
//  Created by Antoine Barrault on 6/10/19.
//
import Foundation

public struct RemoteConfigUpdater {

    public init(firebaseToken: String, projectId: String) {
        self.projectId = projectId
        self.firebaseToken = firebaseToken
    }

    var firebaseToken: String
    var projectId: String

    public func remoteConfig() -> URLRequest {
        let str = "https://firebaseremoteconfig.googleapis.com/v1/projects/\(projectId)/remoteConfig"
        let url = URL(string: str)
        var request = URLRequest(url: url!)
        request.addValue("Bearer \(firebaseToken)", forHTTPHeaderField: "Authorization")
        request.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        return request
    }

    public func putRemoteConfig(with etag: String?) -> URLRequest {
        let str = "https://firebaseremoteconfig.googleapis.com/v1/projects/\(projectId)/remoteConfig"
        let url = URL(string: str)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(firebaseToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; UTF8", forHTTPHeaderField: "Content-Type")
        request.setValue(etag ?? "", forHTTPHeaderField: "If-Match")
        request.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")

        return request
    }

}
