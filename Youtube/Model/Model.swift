//
//  ContentType.swift
//  Youtube
//
//  Created by Danil Chekantsev on 13/08/2025.
//

import Foundation

struct VideoContent: Codable {
    let channelTitle: String
    let title: String
    let views: String
    let previewImage: String
    let avatar: String
    let likesCount: Int
    let commentsCount: Int
    let type: ContentType
}

struct YoutubeContent: Codable {
    let videos: [VideoContent]
    let shorts: [VideoContent]
}

enum ContentType: String, Codable {
    case video = "video"
    case shorts = "shorts"
}

enum ServiceError: Error, LocalizedError {
    case noData
    case invalidJSON
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .noData:
           return "no data"
        case .invalidJSON:
            return "invalid json"
        case .networkError:
            return "network error"
        }
    }
}

