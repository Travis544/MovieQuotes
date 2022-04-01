//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by Yuanhang on 3/28/22.
//

import Foundation

class MovieQuote{
    var quote : String
    var movie : String
    var id : String?
    
    init (quote: String, movie: String){
        self.quote=quote
        self.movie=movie
    }
    
    init (id: String, quote: String, movie: String){
        self.id=id
        self.quote=quote
        self.movie=movie
    }
}
