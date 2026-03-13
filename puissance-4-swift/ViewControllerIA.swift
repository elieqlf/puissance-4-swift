//
//  ViewControllerIA.swift
//  puissance-4-swift
//
//  Created by Lorenzo Quentin on 13/03/2026.
//

import UIKit

class ViewControllerIA: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton! // ← à connecter dans le storyboard
    
    var cellViews: [[UIView]] = []
    let gameManager = GameManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for rowStackView in mainStackView.arrangedSubviews {
            guard let rowStack = rowStackView as? UIStackView else { continue }
            var rowViews: [UIView] = []
            for cellView in rowStack.arrangedSubviews {
                rowViews.append(cellView)
            }
            cellViews.append(rowViews)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(boardTapped(_:)))
        mainStackView.isUserInteractionEnabled = true
        mainStackView.addGestureRecognizer(tap)
        
        updateLabel()
    }
    
    @objc func boardTapped(_ sender: UITapGestureRecognizer) {
        // Bloquer les taps si la partie est finie
        guard case .playing = gameManager.state else { return }
        
        let location = sender.location(in: mainStackView)
        let columnWidth = mainStackView.bounds.width / 7
        let column = Int(location.x / columnWidth)
        
        gameManager.play(in: column)
        updateBoard()
        updateLabel()
    }

    func updateBoard() {
        for row in 0..<6 {
            for col in 0..<7 {
                let cell = gameManager.board.grille[row][col]
                let view = cellViews[row][col]
                
                switch cell {
                case .empty:
                    view.backgroundColor = .systemGray
                case .filled(.player1):
                    view.backgroundColor = .red
                case .filled(.player2):
                    view.backgroundColor = .yellow
                }
            }
        }
    }
    
    func updateLabel() {
        switch gameManager.state {
        case .playing(let player):
            playerLabel.text = player == .player1 ? "🔴 Joueur 1 à toi de jouer" : "🟡 Joueur 2 à toi de jouer"
        case .won(let player):
            playerLabel.text = player == .player1 ? "🔴 Joueur 1 a gagné !" : "🟡 Joueur 2 a gagné !"
        case .draw:
            playerLabel.text = "Match nul !"
        }
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        gameManager.reset()
        updateBoard()
        updateLabel()
    }
}
