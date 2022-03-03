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
        updateViewFromModel()
    }

    @IBOutlet weak var scoreLabel: UILabel!

    @IBAction func newGame(_ sender: UIButton) {
        // tests
        print(game.deckCards.count)
        print("\n")
        print(game.listOfCardsBeingPlayed)
        print(game.listOfCardsBeingPlayed.count)

        game.newGame()
        updateViewFromModel()
    }

    @IBAction func deal3MoreCards(_ sender: UIButton) {
    }

    @IBOutlet var cardButtons: [UIButton]!

    func updateViewFromModel() {

        for index in cardButtons.indices{
            cardButtons[index].isHidden = true
        }

        // display cards being played
        for index in game.listOfCardsBeingPlayed.indices {

            // building the string of shapes according to the number of shapes
            var string = game.listOfCardsBeingPlayed[index].shapes.description
            if(game.listOfCardsBeingPlayed[index].numberOfShapes > 2) {
                for _ in 2...game.listOfCardsBeingPlayed[index].numberOfShapes {
                     string += "\n" + game.listOfCardsBeingPlayed[index].shapes.description
                }
            }
            
            let color = game.listOfCardsBeingPlayed[index].color.colorUI()
            let strokeWidth = game.listOfCardsBeingPlayed[index].filling.strokeWidth()
            let alphaComponent = game.listOfCardsBeingPlayed[index].filling.alphaComponent()

            // alignment - center
            let paragraphSyle = NSMutableParagraphStyle()
            paragraphSyle.alignment = .center

            let attributes: [NSAttributedString.Key:Any] = [ .strokeColor: color,
                                                             .strokeWidth: strokeWidth,
                                                             .foregroundColor: color.withAlphaComponent(alphaComponent),
                                                             .font: UIFont.systemFont(ofSize: 25.0),
                                                             .paragraphStyle: paragraphSyle]
            let attribtext = NSAttributedString(string: string, attributes: attributes)
            cardButtons[index].setAttributedTitle(attribtext, for: .normal)
            cardButtons[index].layer.cornerRadius = 8.0
            cardButtons[index].isHidden = false
        }


    }
}

