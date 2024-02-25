//
//  ViewController.swift
//  IP-AddOne
//
//  Created by SaiManasa on 12/5/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var inputField: UITextField!
    
    var counter = 0
    var gameStart = true
    var time = 10
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(counter)"
        timeLabel.text = "\(time)"
        randomNum()
    }
    
    @IBAction func inputFieldChanged(_ sender: UITextField) {
        start()
        guard let userText = sender.text
        else {
            return
        }
        guard userText.count == 4
        else {
            return
        }
        guard Int(userText) != nil
        else {
            return
        }
        let matched = checkUserInput(userText)
        update(matched)
    }
    
    func randomNum() {
        let numb = String(Int.random(in:0..<10)) + String(Int.random(in:0..<10)) + String(Int.random(in:0..<10)) + String(Int.random(in:0..<10))
        numberLabel.text = numb
    }
    
    func checkUserInput(_ userVal: String) -> Bool {
        guard let gameVal = numberLabel.text
        else {
            return false
        }
        var correctAnswer = ""
        for x in gameVal {
            guard var num = Int(String(x))
            else {
                return false
            }
            num = num + 1
            correctAnswer = correctAnswer + String(String(num).last!)
        }
        
        if correctAnswer == userVal {
            return true
        }
        return false
    }
    
    func update(_ correctOrNot: Bool) {
        if correctOrNot {
            counter = counter + 1
            scoreLabel.text = "\(counter)"
        } else {
            counter = counter - 1
            scoreLabel.text = "\(counter)"
        }
        randomNum()
        inputField.text = ""
    }
    
    func start() {
        if (gameStart) {
            gameStart = false
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerFunction() {
        time = time - 1
        timeLabel.text = "\(time)"
        if (time == 0) {
            timer.invalidate()
            time = 10
            let finalScore = counter
            counter = 0
            let alert = UIAlertController(title: "Game Over!", message: "Score: \(finalScore)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click To Restart", style: UIAlertAction.Style.default, handler: { action in
                self.scoreLabel.text = "\(self.counter)"
                self.timeLabel.text = "\(self.time)"
                self.inputField.text = ""
                self.randomNum()
                self.gameStart = true
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

