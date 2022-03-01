//
//  ViewController.swift
//  Set_Cardgame
//
//  Created by Rona Bompa on 24.02.2022.
//

import UIKit

enum colors {

}

enum shapes {
    
}

class ViewController: UIViewController {

    private lazy var game = Set()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var scoreLabel: UILabel!

    @IBAction func newGame(_ sender: UIButton) {
        // tests
        print(game.deckCards)
        print(game.deckCards.count)
        print("\n")
        print(game.listOfCardsBeingPlayed)
        print(game.listOfCardsBeingPlayed.count)
    }

    @IBAction func deal3MoreCards(_ sender: UIButton) {
    }

    @IBOutlet var cardButtons: [UIButton]!
}

