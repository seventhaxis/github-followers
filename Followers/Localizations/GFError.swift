//
//  GFError.swift
//  Followers
//
//  Created by Matt Brown on 12/9/20.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "Please enter a valid GitHub username and try again."
    case incompleteRequest = "Unable to complete request. Please check network connection."
    case invalidServerResponse = "Invalid response from the server. Please try again."
    case invalidDataReceived = "The data received from the server was invalid. Please try again."
    case unableToDecodeData = "Unable to decode data received from server. Please try again."
}
