//
//  ViewControllerIA.swift
//  puissance-4-swift
//
//  Created by Lorenzo Quentin on 13/03/2026.
//

import UIKit

class ViewControllerIA: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView! // ← à connecter dans le storyboard
    @IBOutlet weak var playerLabel: UILabel!       // ← idem
    
    var cellViews: [[UIView]] = []
    let gameManager = GameManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Peupler cellViews depuis la hiérarchie de vues
        for rowStackView in mainStackView.arrangedSubviews {
            guard let rowStack = rowStackView as? UIStackView else { continue }
            var rowViews: [UIView] = []
            for cellView in rowStack.arrangedSubviews {
                rowViews.append(cellView)
            }
            cellViews.append(rowViews)
        }
        
        // Ajouter le tap sur la grille
        let tap = UITapGestureRecognizer(target: self, action: #selector(boardTapped(_:)))
        mainStackView.isUserInteractionEnabled = true
        mainStackView.addGestureRecognizer(tap)
    }
    
    @objc func boardTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mainStackView)
        let columnWidth = mainStackView.bounds.width / 7
        let column = Int(location.x / columnWidth)
        
        gameManager.play(in: column)
        updateBoard()
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
}
