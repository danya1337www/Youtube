//
//  VideoContentService.swift
//  Youtube
//
//  Created by Danil Chekantsev on 13/08/2025.
//

import Foundation
import UIKit

final class VideoContentService {
    
    static let shared = VideoContentService() 
    
    required init() {}
    
    func loadData(from resource: String = "Data") async throws -> [VideoContent] {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        let data = try Data(contentsOf: url)
        let youtubeContent = try JSONDecoder().decode(YoutubeContent.self, from: data)
        return youtubeContent.videos
    }
        
}
