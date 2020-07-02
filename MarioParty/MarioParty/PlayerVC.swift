//
//  PlayerVC.swift
//  MarioParty
//
//  Created by Bader Alawadh on 7/2/20.
//  Copyright © 2020 Dalal Alhazeem. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController {
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var starsImage: UIImageView!
    @IBOutlet weak var diceBtn: UIButton!
    
    var isPlayingBackMusic = true
    
    var playerSound: AVAudioPlayer?
    
    var player: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playerImage.image = UIImage.gifImageWithName(player!)
        playerName.text = player
        
    }
    @IBAction func tappedStarButton(_ sender: UIButton) {
        
        diceBtn.setBackgroundImage(UIImage.gifImageWithName("dice rolling"), for: .normal)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
            let randomNumber = Int.random(in: 1 ..< 6)
            self.starsImage.image = UIImage(named: "Star\(randomNumber)")
            self.diceBtn.setBackgroundImage(UIImage(named: "dice\(randomNumber)"), for: .normal)
        }
        
    }
    
    @IBAction func tappedSoundButton(_ sender: Any) {
        playPlayerSound(name: "\(player!).WAV")
    }
    
    func playPlayerSound(name: String) {
        let path = Bundle.main.path(forResource: name, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            playerSound = try AVAudioPlayer(contentsOf: url)
            playerSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    
}
