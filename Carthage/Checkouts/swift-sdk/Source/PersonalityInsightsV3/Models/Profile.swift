/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/** A personality profile generated by the Personality Insights service. */
public struct Profile: JSONDecodable {

    /// The number of words found in the input.
    public let wordCount: Int

    /// The language model used to process the input.
    public let processedLanguage: String

    /// Recursive array of characteristics describing the Big Five dimensions 
    /// inferred from the input text.
    public let personality: [TraitTreeNode]
    
    /// Array of characteristics describing thneeds of the input text.
    public let needs: [TraitTreeNode]
    
    /// Array of characteristics describing values of the input text.
    public let values: [TraitTreeNode]
    
    /// Array of behaviors describing values of the input text that is returned
    /// only for timestamped JSON input.
    public let behavior: [BehaviorNode]?
    
    /// Detailed results for each category of consumption preferences. 
    public let consumptionPreferences: [ConsumptionPreferencesCategoryNode]?
    
    /// Array of warning messages generated from the input text.
    public let warnings: [Warning]
    
    /// A message indicating the number of words found and where the value falls
    /// in the range of required or suggested number of words when guidance is
    /// available.
    public let wordCountMessage: String?
    
    /// Used internally to initialize a `Profile` model from JSON.
    public init(json: JSONWrapper) throws {
        wordCount = try json.getInt(at: "word_count")
        processedLanguage = try json.getString(at: "processed_language")
        personality = try json.decodedArray(at: "personality", type: TraitTreeNode.self)
        needs = try json.decodedArray(at: "needs", type: TraitTreeNode.self)
        values = try json.decodedArray(at: "values", type: TraitTreeNode.self)
        behavior = try? json.decodedArray(at: "behavior", type: BehaviorNode.self)
        consumptionPreferences = try? json.decodedArray(at: "consumption_preferences", type: ConsumptionPreferencesCategoryNode.self)
        warnings = try json.decodedArray(at: "warnings", type: Warning.self)
        wordCountMessage = try? json.getString(at: "word_count_message")
    }
}
