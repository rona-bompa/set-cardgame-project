//
//  ViewController.swift
//  Set_Cardgame
//
//  Created by Rona Bompa on 24.02.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Set()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCardsContentViewFromModel()
    }

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        // tests
        print("deck: \(game.deckCards.count)")
        print("played:  \(game.listOfCardsBeingPlayed.count)")
        print("selected: \(game.selectedCards.count)")
        print("matched: \(game.matchedCards.count) \n")

        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.selectCard(at: cardNumber)
            updateCardsContentViewFromModel()
            updateCardsBorderViewFromModel()
        }
    }

    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        updateCardsContentViewFromModel()
        updateCardsBorderViewFromModel()
    }

    @IBAction func deal3MoreCards(_ sender: UIButton) {
//        if game.listOfCardsBeingPlayed.count < 24 {
//            sender.isEnabled = true
            game.dealThreeMoreCards()
            updateCardsContentViewFromModel()
            updateCardsBorderViewFromModel()
    }

    func updateCardsContentViewFromModel() {
        // hide all cards
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

    func updateCardsBorderViewFromModel() {
        // no border for all cards
        for index in cardButtons.indices{
            cardButtons[index].layer.borderWidth = 0.0
        }

        var borderColor = UIColor.blue.cgColor
        switch game.matchColor {
        case .yes:
            borderColor = UIColor.green.cgColor
        case .no:
            borderColor = UIColor.red.cgColor
        case .notYetThreeCards:
            borderColor = UIColor.blue.cgColor
        }

        // borderColor for selected cards
        for cardSelected in game.selectedCards {
            cardButtons[game.listOfCardsBeingPlayed.firstIndex(of: cardSelected) ?? 0].layer.borderWidth = 3.0
            cardButtons[game.listOfCardsBeingPlayed.firstIndex(of: cardSelected) ?? 0].layer.borderColor = borderColor
        }
    }
}

