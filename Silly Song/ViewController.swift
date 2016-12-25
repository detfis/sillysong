//
//  ViewController.swift
//  Silly Song
//
//  Created by Kamil Pluta on 25.12.2016.
//  Copyright © 2016 Kamil Pluta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    @IBAction func displayLyrics(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty else {
            return
        }
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func shortNameFromName(name: String) -> String {
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    let lowercaseName = name.lowercased()
    let normalizedName = lowercaseName.folding(options: .diacriticInsensitive, locale: .current)
    let firstVowelIndex = normalizedName.rangeOfCharacter(from: vowelSet)?.lowerBound
    if firstVowelIndex == nil {
        return normalizedName
    } else {
        return normalizedName.substring(from: firstVowelIndex!)
    }
    
}


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

