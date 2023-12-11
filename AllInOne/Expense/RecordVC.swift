//
//  RecordVC.swift
//  AllInOne
//
//  Created by Suri Manikanth on 04/12/23.
//

import UIKit

class RecordVC: UIViewController {

    @IBOutlet weak var mikeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    var speechRecognizer = SpeechRecognizer()
    var isRecording = false
    var recordMessage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myViewController = MyViewController()
        present(myViewController, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func mikeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            speechRecognizer.resetTranscript()
            speechRecognizer.startTranscribing()
            isRecording = true
            self.pauseButton.isHidden = false
        } else {
            isRecording = false
            speechRecognizer.stopTranscribing()
            let text = speechRecognizer.transcript
            recordMessage = recordMessage + text
            self.pauseButton.isHidden = true
        }
       
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        print(recordMessage)
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
    }
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            isRecording = false
            speechRecognizer.stopTranscribing()
            let text = speechRecognizer.transcript
            recordMessage = recordMessage + text
            mikeButton.isSelected = !mikeButton.isSelected
        } else {
            isRecording = true
            speechRecognizer.startTranscribing()
            mikeButton.isSelected = !mikeButton.isSelected
        }
    }
    
}
