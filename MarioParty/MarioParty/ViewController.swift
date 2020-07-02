//
//  ViewController.swift
//  MarioParty
//
//  Created by Dalal Alhazeem on 3/24/20.
//  Copyright © 2020 Dalal Alhazeem. All rights reserved.
//

import UIKit
import ImageIO
import AVFoundation

class ViewController: UIViewController {
   
    @IBOutlet weak var charImg: UIImageView!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var showLabel: UILabel!

    var isPlayingBackMusic = true
    var backgroundMusic: AVAudioPlayer?
    var playerSound: AVAudioPlayer?
    let gifImages = ["Mario", "Luigi", "Bowser", "Koopa", "Waluigi"]
    var player = String()
    var previousPlayer = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //nextButton.isUserInteractionEnabled = false
        changePlayer()
        configureView()
        playBackMusic(name: "BG.wav")
        
    }
    
    func configureView() {
        changeBtn.layer.cornerRadius = 10
        changeBtn.layer.masksToBounds = true
        showLabel.layer.cornerRadius = 10
        showLabel.layer.masksToBounds = true
    }
    

    @IBAction func tappedArrow(_ sender: UIButton) {
        performSegue(withIdentifier: "Character", sender: nil)
    }
    
    @IBAction func tappedChangeCharacter(_ sender: Any) {
        changePlayer()
        playPlayerSound(name: "\(player).WAV")
        
    }
    
    @IBAction func tappedMusicButton(_ sender: UIButton) {
        
        isPlayingBackMusic ? backgroundMusic?.pause() : playBackMusic(name: "BG.wav")
        isPlayingBackMusic.toggle()
    }
    
    func changePlayer() {
        player = gifImages.randomElement()!
        while player == previousPlayer {
            player = gifImages.randomElement()!
        }
        charImg.image = UIImage.gifImageWithName("\(player)")
        previousPlayer = player
    }
    
    func playBackMusic(name: String) {
        let path = Bundle.main.path(forResource: name, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.play()
        } catch {
            // couldn't load file :(
        }
        backgroundMusic?.numberOfLoops = 100
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PlayerVC else {
            fatalError()
        }
        destination.player = self.player
        
    }
    
    
    
}

