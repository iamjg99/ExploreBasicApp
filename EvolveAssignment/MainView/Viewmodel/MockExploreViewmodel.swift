//
//  MockExploreViewmodel.swift
//  EvolveAssignment
//
//  Created by Jatin Gupta on 01/12/24.
//

import Combine
import Foundation

class MockExploreViewmodel: ObservableObject {
    @Published var data: ExploreData?

    func fetchExploreData() {
        guard let mockResponseUrl = Bundle.main.url(forResource: "MockExploreData", withExtension: "json") else {
            print("Mock JSON file not found.")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: mockResponseUrl)
            let responseModel = try ExploreDecoder().decode(ExploreData.self, from: jsonData)

            self.data = responseModel
            self.objectWillChange.send()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

class ExploreDecoder: TopLevelDecoder {
    func decode<T>(_ type: T.Type, from: Data) throws -> T where T : Decodable {
        do {
            return try JSONDecoder().decode(type, from: from)
        }
        catch {
            print("decodingError ===>", error)
            throw error
        }
    }
}
