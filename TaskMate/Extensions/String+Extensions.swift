//
//  String+Extensions.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 02/05/25.
//

extension Character {
    var isSpecialCharacter: Bool {
        !(isLetter || isNumber || isWhitespace)
    }
}
