//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var cGuess: UILabel!
    @IBOutlet var icGuess: UILabel!
    @IBOutlet var entGuess: UITextField!
    @IBOutlet var runGuess: UIButton!
    
    var numGuess: Int = 1
    var state: String = ""
    var corrGuess: String = ""
//    var cGuesses: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        runGuess.isHidden = false
        // Do any additional setup after loading the view.
//        cGuesses = ""
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        numGuess = 1
        state = phrase!.uppercased()
        corrGuess = ""
        let phraseArr = Array(state.uppercased().characters)
        cGuess.text = ""
        for char in phraseArr {
            if char == " " {
                cGuess.text = cGuess.text! + "  "
            } else {
                cGuess.text = cGuess.text! + "_ "
            }
        }
        image.image = UIImage(named: "hangman1.gif")
        icGuess.text = ""
        entGuess.text = ""
    }
    
    @IBAction func runGuess(_ sender: AnyObject) {
        if entGuess.text?.characters.count == 1 {
            if state.contains(entGuess.text!.uppercased()) { // && !cGuesses.contains(entGuess.text!){
                corrGuess.append(entGuess.text!.uppercased())
                cGuess.text = ""
                for char in state.characters {
                    if corrGuess.contains(String(char)) {
                        cGuess.text = cGuess.text! + String(char)
                    } else if char == " " {
                        cGuess.text = cGuess.text! + "  "
                    } else {
                        cGuess.text = cGuess.text! + "_ "
                    }
                }
                if !((cGuess.text?.contains("_"))!) {
                    let alertController = UIAlertController(title: "You win! :)", message: "Want to play again?", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    present(alertController, animated: true, completion: nil)
                    runGuess.isHidden = true
                }
            } else {
                icGuess.text = icGuess.text! + entGuess.text!.uppercased()
                numGuess = numGuess + 1
                image.image = UIImage(named: "hangman" + String(numGuess) + ".gif")
                if numGuess == 7 {
                    let alertController = UIAlertController(title: "You lose. :(", message: "Want to play again?", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    present(alertController, animated: true, completion: nil)
                    runGuess.isHidden = true
                }
            }
        }
    }
    
    @IBAction func refresh(_ sender: AnyObject) {
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
