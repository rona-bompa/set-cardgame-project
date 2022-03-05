//
//  ViewController.swift
//  Set_Cardgame
//
//  Created by Rona Bompa on 24.02.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Set()

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var deal3moreCards: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        updateViewFromModel()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.selectCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func deal3MoreCards(_ sender: UIButton) {
        //        if game.listOfCardsBeingPlayed.count < 24 {
        //            sender.isEnabled = true
        game.dealThreeMoreCards()
        updateViewFromModel()
    }

    func updateViewFromModel() {
        // ENABLE/ DISABLE - Deal 3 more cards button
        if game.deckCards.count == 0 || game.listOfCardsBeingPlayed.count == 24 {
            deal3moreCards.isEnabled = false
        } else {
            deal3moreCards.isEnabled = true
        }

        // HIDE all cards & NO border
        for index in cardButtons.indices{
            cardButtons[index].isHidden = true
            cardButtons[index].layer.borderWidth = 0.0
        }
        // DISPLAY cards when being played
        for index in game.listOfCardsBeingPlayed.indices {

            var string = ""
            let shape = game.listOfCardsBeingPlayed[index].shapes.description
            // building the string of shapes according to the number of shapes
            switch game.listOfCardsBeingPlayed[index].numberOfShapes {
            case 1: string = shape
            case 2: string = shape + "\n" + shape
            case 3: string = shape + "\n" + shape + "\n" + shape
            default: string = ""
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

        // BORDER color
        var borderColor = UIColor.blue.cgColor
        switch game.areAMatch {
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

        // SCORE
        scoreLabel.text = "Score: \(game.score)"
    }
}

