//
//  ExploreData.swift
//  EvolveAssignment
//
//  Created by Jatin Gupta on 01/12/24.
//

import Foundation

struct ExploreData: Codable {
    let status: Bool
    let data: [Journey]
    let totalPages: Int
    let premiumStatus: Int
    let problemFilter: [ProblemFilter]
    
    enum CodingKeys: String, CodingKey {
        case status, data
        case totalPages = "total_pages"
        case premiumStatus = "premium_status"
        case problemFilter = "problem_filter"
    }
}

struct Journey: Codable {
    let id: Int
    let title: String
    let juLabel: String
    let promoText: String
    let description: String
    let juType: String
    let juPremium: String
    let numDays: Int
    let thumbImage: String
    let coverImage: String
    let juLink: String?
    let problems: [String]?
    let techniques: [String]
    let days: [Day]
    let details: String
    let sessions: String
    let mins: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case juLabel = "ju_label"
        case promoText = "promo_text"
        case description
        case juType = "ju_type"
        case juPremium = "ju_premium"
        case numDays = "num_days"
        case thumbImage = "thumb_image"
        case coverImage = "cover_image"
        case juLink = "ju_link"
        case problems, techniques, days, details, sessions, mins
    }
}

struct Day: Codable {
    let id: Int
    let title: String
    let description: String
    let numSteps: Int
    let dayCompleted: String
    let completedSteps: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, description
        case numSteps = "num_steps"
        case dayCompleted = "day_completed"
        case completedSteps = "completed_steps"
    }
}

struct ProblemFilter: Codable {
    let title: String
    let id: Int
}

enum ExploreDataType {
    case all
    case lgbtq
    case neurodiversity
    case sexualHealth
    case selfLove
    case relationships
    case work
    case finance
}

extension ExploreDataType {
    var displayName: String {
        switch self {
        case .all: return "All"
        case .work: return "💼 Work"
        case .finance: return "💵 Finance"
        case .sexualHealth: return "🌸 Sexual Health"
        case .lgbtq: return "🌈 LGBTQIA+"
        case .neurodiversity: return "🧠 Neurodiversity"
        case .selfLove: return "🌻 Self-love"
        case .relationships: return "❤️ Relationships"
        }
    }
}
