//
//  GameManager.swift
//  puissance-4-swift
//
//  Created by Elie Calviere on 09/03/2026.
//

import Foundation

class GameManager {
    var board: GameBoard
    var state: GameState
    
    init() {
        self.board = GameBoard()
        self.state = .playing(.player1)
    }
    
    func play(in column: Int) {
        if case .playing(let player) = state {
            if let row = board.drop(in: column, as: player) {
                if board.checkWin(row: row, column: column, player: player) {
                    state = .won(player)
                } else if board.isFull() {
                    state = .draw
                } else {
                    state = .playing(player.next())
                }
            }
        }
    }
    
    func reset() {
        self.board = GameBoard()
        self.state = .playing(.player1)
    }
}
