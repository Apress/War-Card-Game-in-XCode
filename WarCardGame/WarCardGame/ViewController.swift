//
//  ViewController.swift
//  WarCardGame
//
//  Created by Tihomir RAdeff on 12.07.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var robotDeck: UIButton!
    @IBOutlet weak var playerDeck: UIButton!
    
    @IBOutlet weak var robotCard: UIImageView!
    @IBOutlet weak var playerCard: UIImageView!
    
    @IBOutlet weak var robotCount: UILabel!
    @IBOutlet weak var playerCount: UILabel!
    
    @IBOutlet weak var robotStatus: UILabel!
    @IBOutlet weak var playerStatus: UILabel!
    
    var deck = Deck()
    
    var playerCards: [Card] = []
    var robotCards: [Card] = []
    
    var isWar = false
    var warCards: [Card] = []
    var warCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dealCards()
    }

    @IBAction func playerDeckClick(_ sender: Any) {
        if !isWar {
            //not a war
            
            let playedCardPlayer = playerCards.removeFirst()
            let playedCardRobot = robotCards.removeFirst()
            
            playerCard.image = playedCardPlayer.image
            robotCard.image = playedCardRobot.image
            
            if playedCardPlayer.rank > playedCardRobot.rank {
                //player take the cards
                playerStatus.text = "Player wins the round!"
                robotStatus.text = ""
                
                playerCards.append(playedCardPlayer)
                playerCards.append(playedCardRobot)
                
                playerCount.text = "\(playerCards.count)"
                robotCount.text = "\(robotCards.count)"
            } else if playedCardPlayer.rank < playedCardRobot.rank {
                //robot take the cards
                robotStatus.text = "Robot wins the round!"
                playerStatus.text = ""
                
                robotCards.append(playedCardPlayer)
                robotCards.append(playedCardRobot)
                
                playerCount.text = "\(playerCards.count)"
                robotCount.text = "\(robotCards.count)"
            } else {
                //it is war
                playerStatus.text = "War!"
                robotStatus.text = "War!"
                
                isWar = true
                warCount = 0
                
                warCards.append(playedCardPlayer)
                warCards.append(playedCardRobot)
            }
        } else {
            //it is war
            if warCount < 2 {
                warCount = warCount + 1
                
                playerStatus.text = "War! \(warCount)"
                robotStatus.text = "War! \(warCount)"
                
                let playerWarCard = playerCards.removeFirst()
                let robotWarCard = robotCards.removeFirst()
                
                warCards.append(playerWarCard)
                warCards.append(robotWarCard)
                
                playerCard.image = playerWarCard.image
                robotCard.image = robotWarCard.image
            } else {
                //the war is over
                let playerWarCard = playerCards.removeFirst()
                let robotWarCard = robotCards.removeFirst()
                
                warCards.append(playerWarCard)
                warCards.append(robotWarCard)
                
                playerCard.image = playerWarCard.image
                robotCard.image = robotWarCard.image
                
                if playerWarCard.rank > robotWarCard.rank {
                    //player take the cards
                    playerStatus.text = "Player wins the war!"
                    robotStatus.text = ""
                    
                    playerCards.append(contentsOf: warCards)
                    warCards.removeAll()
                    isWar = false
                    
                    playerCount.text = "\(playerCards.count)"
                    robotCount.text = "\(robotCards.count)"
                } else if playerWarCard.rank < robotWarCard.rank {
                    //robot take the cards
                    robotStatus.text = "Robot wins the war!"
                    playerStatus.text = ""
                    
                    robotCards.append(contentsOf: warCards)
                    warCards.removeAll()
                    isWar = false
                    
                    playerCount.text = "\(playerCards.count)"
                    robotCount.text = "\(robotCards.count)"
                } else {
                    //it is war
                    playerStatus.text = "The war continues!"
                    robotStatus.text = "The war continues!"
                    
                    isWar = true
                    warCount = 0
                }
            }
        }
        
        checkWin()
    }
    
    //check if some of the player won the game
    func checkWin() {
        if playerCards.count == 0 {
            playerStatus.text = "Robot wins the game!"
            robotStatus.text = "Robot wins the game!"
            
            playerCount.text = "0"
            robotCount.text = "52"
            
            playerDeck.alpha = 0
            playerDeck.isUserInteractionEnabled = false
        }
        
        if robotCards.count == 0 {
            playerStatus.text = "Player wins the game!"
            robotStatus.text = "Player wins the game!"
            
            playerCount.text = "52"
            robotCount.text = "0"
            
            robotDeck.alpha = 0
            playerDeck.isUserInteractionEnabled = false
        }
    }
    
    //deal the cards
    func dealCards() {
        while let card = deck.deal() {
            playerCards.append(card)
            playerCount.text = "\(playerCards.count)"
            
            guard let card2 = deck.deal() else {
                break
            }
            
            robotCards.append(card2)
            robotCount.text = "\(robotCards.count)"
        }
    }
    
    //define the card
    struct Card {
        let rank: Int
        let suit: String
        
        var image: UIImage {
            switch suit {
                
            case "Hearts":
                switch rank {
                case 2:
                    return UIImage(named: "heartstwo")!
                case 3:
                    return UIImage(named: "heartsthree")!
                case 4:
                    return UIImage(named: "heartsfour")!
                case 5:
                    return UIImage(named: "heartsfive")!
                case 6:
                    return UIImage(named: "heartssix")!
                case 7:
                    return UIImage(named: "heartsseven")!
                case 8:
                    return UIImage(named: "heartseight")!
                case 9:
                    return UIImage(named: "heartsnine")!
                case 10:
                    return UIImage(named: "heartsten")!
                case 11:
                    return UIImage(named: "heartsjack")!
                case 12:
                    return UIImage(named: "heartsqueen")!
                case 13:
                    return UIImage(named: "heartsking")!
                case 14:
                    return UIImage(named: "heartsace")!
                default:
                    return UIImage(named: "ic_empty")!
                }
                
            case "Diamonds":
                switch rank {
                case 2:
                    return UIImage(named: "diamondstwo")!
                case 3:
                    return UIImage(named: "diamondsthree")!
                case 4:
                    return UIImage(named: "diamondsfour")!
                case 5:
                    return UIImage(named: "diamondsfive")!
                case 6:
                    return UIImage(named: "diamondssix")!
                case 7:
                    return UIImage(named: "diamondsseven")!
                case 8:
                    return UIImage(named: "diamondseight")!
                case 9:
                    return UIImage(named: "diamondsnine")!
                case 10:
                    return UIImage(named: "diamondsten")!
                case 11:
                    return UIImage(named: "diamondsjack")!
                case 12:
                    return UIImage(named: "diamondsqueen")!
                case 13:
                    return UIImage(named: "diamondsking")!
                case 14:
                    return UIImage(named: "diamondsace")!
                default:
                    return UIImage(named: "ic_empty")!
                }
                
            case "Clubs":
                switch rank {
                case 2:
                    return UIImage(named: "clubstwo")!
                case 3:
                    return UIImage(named: "clubsthree")!
                case 4:
                    return UIImage(named: "clubsfour")!
                case 5:
                    return UIImage(named: "clubsfive")!
                case 6:
                    return UIImage(named: "clubssix")!
                case 7:
                    return UIImage(named: "clubsseven")!
                case 8:
                    return UIImage(named: "clubseight")!
                case 9:
                    return UIImage(named: "clubsnine")!
                case 10:
                    return UIImage(named: "clubsten")!
                case 11:
                    return UIImage(named: "clubsjack")!
                case 12:
                    return UIImage(named: "clubsqueen")!
                case 13:
                    return UIImage(named: "clubsking")!
                case 14:
                    return UIImage(named: "clubsace")!
                default:
                    return UIImage(named: "ic_empty")!
                }
                
            case "Spades":
                switch rank {
                case 2:
                    return UIImage(named: "spadestwo")!
                case 3:
                    return UIImage(named: "spadesthree")!
                case 4:
                    return UIImage(named: "spadesfour")!
                case 5:
                    return UIImage(named: "spadesfive")!
                case 6:
                    return UIImage(named: "spadessix")!
                case 7:
                    return UIImage(named: "spadesseven")!
                case 8:
                    return UIImage(named: "spadeseight")!
                case 9:
                    return UIImage(named: "spadesnine")!
                case 10:
                    return UIImage(named: "spadesten")!
                case 11:
                    return UIImage(named: "spadesjack")!
                case 12:
                    return UIImage(named: "spadesqueen")!
                case 13:
                    return UIImage(named: "spadesking")!
                case 14:
                    return UIImage(named: "spadesace")!
                default:
                    return UIImage(named: "ic_empty")!
                }
                
            default:
                return UIImage(named: "ic_empty")!
            }
        }
    }
    
    //define the deck
    struct Deck {
        var cards: [Card] = []
        
        init() {
            let suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
            for suit in suits {
                for rank in 2...14 {
                    cards.append(Card(rank: rank, suit: suit))
                }
            }
            cards.shuffle()
        }
        
        mutating func deal() -> Card? {
            if cards.count > 0 {
                return cards.removeLast()
            } else {
                return nil
            }
        }
    }
}

