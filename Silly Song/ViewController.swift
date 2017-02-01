//
//  ViewController.swift
//  Silly Song
//
//  Created by Andreas Rueesch on 01.02.17.
//  Copyright © 2017 Andreas Rueesch. All rights reserved.
//

import UIKit


// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        let curName = nameField.text!
        let bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
            "Banana Fana Fo F<SHORT_NAME>",
            "Me My Mo M<SHORT_NAME>",
            "<FULL_NAME>"].joined(separator: "\n")
        
        if curName.characters.count > 0 {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: curName)
        }
    }
}



func shortNameForName(name: String) -> String {
    let list_vowels = CharacterSet(["a", "e", "i", "o", "u"])
    var name_lower = name.lowercased()
    var short_name = ""
    
    var flagVowel = false
    for character in name_lower.unicodeScalars {
        if (list_vowels.contains(character) || flagVowel) {
            short_name.append(String(character))
            flagVowel = true
        }
    }
    return short_name
}


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameForName(name: fullName)
    var lyrics = lyricsTemplate
    lyrics = lyrics.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    lyrics = lyrics.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}
