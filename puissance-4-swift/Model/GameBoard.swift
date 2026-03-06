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
    
    func getLastRowEmpty(in column: Int) -> Int {
        var lastRowEmpty = -1
        for row in 0..<rows {
            switch grille[row][column] {
            case .empty:
                lastRowEmpty = row
            case .filled:
                break
            }
        }
        return lastRowEmpty
    }
    
    mutating func drop(in column: Int, as player: Player) -> Int? {
        let lastRowEmpty = getLastRowEmpty(in: column)
        
        // Colonne pleine
        guard lastRowEmpty != -1 else { return -1}
        
        grille[lastRowEmpty][column] = .filled(player)
        return lastRowEmpty
    }
    
    // On regarde sur des coordonées précice pour ne pas checker toute la grille a chaque tour
    func checkWin(row: Int, column: Int, player: Player) -> Bool {
        return false
    }
}
