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
        guard lastRowEmpty != -1 else { return nil }
        
        grille[lastRowEmpty][column] = .filled(player)
        return lastRowEmpty
    }
    
    // On regarde sur des coordonées précice pour ne pas checker toute la grille a chaque tour
    func checkWin(row: Int, column: Int, player: Player) -> Bool {
        let directions: [(Int, Int)] = [
            (0, 1),
            (1, 0), 
            (1, 1), 
            (1, -1) 
        ]
        
        for (dx, dy) in directions {
            var count = 1 // jeton placé par le joueur
            
            // Premier sens
            var x = row + dx
            var y = column + dy
            
            // On avance tant que :
            //  - On sort pas de la grille
            //  - On croise pas un le jeton d'un autre joueur
            while x >= 0 && y >= 0 && y < columns && x < rows {
                if case .filled(let p) = grille[x][y], p == player {
                    count += 1
                    x += dx
                    y += dy
                } else {
                    break
                }
            }
            
            // Sens inverse
            x = row - dx
            y = column - dy
            
            while x >= 0 && y >= 0 && y < columns && x < rows {
                if case .filled(let p) = grille[x][y], p == player {
                    count += 1
                    x -= dx
                    y -= dy
                } else {
                    break
                }
            }
            
            if count >= 4 {
                return true
            }
        }
        return false
    }
    
    func isFull() -> Bool {
        for row in grille {
            for cell in row {
                if case .empty = cell {
                    return false
                }
            }
        }
        return true
    }
}
