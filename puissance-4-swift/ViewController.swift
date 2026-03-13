//
//  ViewController.swift
//  puissance-4-swift
//
//  Created by Elie Calviere on 06/03/2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
        
    @IBOutlet var cells: [UIView]!
    
    let gm = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        gm.reset()
        updateUI()
    }
    
    @IBAction func columnClick(_ sender: Any) {
        let tag = (sender as! UIView).tag
        gm.play(in: tag)
        updateUI()
    }
    
    func updateUI() {
        for row in 0..<6 {
            for column in 0..<7 {
                let cell = cells[row * 7 + column]
                switch gm.board.grille[row][column] {
                case .empty:
                    cell.backgroundColor = .gray
                case .filled(let player):
                    if player == .player1 {
                        cell.backgroundColor = .red
                    } else {
                        cell.backgroundColor = .yellow
                    }
                }
            }
        }
        
        switch gm.state {
        case .playing(let player):
            if player == .player1 {
                playerLabel.text! = "Joueur 1 à toi de jouer"
            } else {
                playerLabel.text! = "Joueur 2 à toi de jouer"
            }
        case .won(let player):
            if player == .player1 {
                playerLabel.text! = "Joueur 1 a gagné !"
            } else {
                playerLabel.text! = "Joueur 2 a gagné !"
            }
        case .draw:
            playerLabel.text = "Match nul !"
        }
    }
    
}
