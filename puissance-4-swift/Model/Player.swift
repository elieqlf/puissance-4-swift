//
//  Player.swift
//  puissance-4-swift
//
//  Created by Elie Calviere on 06/03/2026.
//

enum Player {
    case player1
    case player2
    
    func next() -> Player {
        switch self {
        case .player1:
            return .player2
        case .player2:
            return .player1
        }
    }
}
