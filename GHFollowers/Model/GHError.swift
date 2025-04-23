//
//  GHError.swift
//  GHFollowers
//
//  Created by Mohd Tabrez Khan on 10/09/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import Foundation

enum GHError: String {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Maybe check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server is invalid. Please try again."
    case unableToFavorite   = "There was an error adding to favorites"
    case unableToGetFavorites = "There seems to be some problem retrieving your favorites"
    case alreadyInFavorites = "This user is already in your favorite list"
}
