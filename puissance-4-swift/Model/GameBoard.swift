//
//  GameBoard.swift
//  puissance-4-swift
//
//  Created by Elie Calviere on 06/03/2026.
//

struct GameBoard {
    let rows = 6
    let columns = 7
    
    var grille: [[Cell]]
    
    init() {
        grille = []
        for _ in 0..<rows {
            var ligne = [Cell]()
            for _ in 0..<columns {
                ligne.append(.empty)
            }
            grille.append(ligne)
        }
    }
}
