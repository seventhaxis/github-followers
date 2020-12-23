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
    case unableToAddFavorite = "There was an error adding user to favorites. Please try again."
    case unableToSaveFavorites = "There was an error saving your favorite users. Please try again."
    case favoriteAlreadyExists = "You've already added this user to your favorites. You must really like 'em! 😜"
}
