//
//  PlaySoundsViewController.swift
//  TeamPang
//
//  Created by 선민승 on 2020/08/13.
//  Copyright © 2020 선민승. All rights reserved.
//

import UIKit
import AVFoundation

//extension PlaySoundsViewController: AVAudioPlayerDelegate{
//    struct Alerts {}
//
//    enum PlayingState { case playing, notPlaying }
//
//    func setupAudio() {}
//
//    func playSound(rate:Float? =nil, pitch: Float?=nil, echo:Bool=false, reverb: Bool = false) {}
//
//    func connectAudioNodes(_ nodes: AVAudioNode...) {}
//}


class PlaySoundsViewController: UIViewController {
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb //자동으로 1~5까지 assign
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) { //한꺼번에 여섯개의 버튼을 연결가능 
        switch(ButtonType(rawValue: sender.tag)!){
         case .slow:
               playSound(rate: 0.5)
           case .fast:
               playSound(rate: 1.5)
           case .chipmunk:
               playSound(pitch: 1000)
           case .vader:
               playSound(pitch: -1000)
           case .echo:
               playSound(echo: true)
           case .reverb:
               playSound(reverb: true)
        }
        configureUI(.playing)
    }
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
