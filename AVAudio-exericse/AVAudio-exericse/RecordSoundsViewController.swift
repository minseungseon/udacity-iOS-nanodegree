//
//  RecordSoundsViewController.swift
//  TeamPang
//
//  Created by 선민승 on 2020/08/12.
//  Copyright © 2020 선민승. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate { //swift는 하나의 슈퍼클래스만 상속받을 수 있지만, 프로토콜은 원하는 만큼 conform 할 수 있다.
  
    
    
    var audioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopRecordingButton.isEnabled=false

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) //vieWillAppear의 슈퍼클래스를 커스텀 전에 먼저 가져와준다
        print("view will appear")
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("started recording")
        recordingLabel.text="Recording in Progress"
        stopRecordingButton.isEnabled=true
        recordButton.isEnabled=false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath as Any)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()    }
    
    @IBAction func stopRecordingButton(_ sender: Any) {
        print("stopped")
        recordButton.isEnabled=true
        stopRecordingButton.isEnabled=false
        recordingLabel.text="Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            print("AVAudioRecorder worked SUCCESSFULLY!")

        }else{
            print("AVAudioRecorder did not work properly")
    }
 }
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "stopRecording" { //stopRecording 아이덴티파이어로 확인이 된다면
            let playSoundsVC = segue.destination as! PlaySoundsViewController //세그의 destination을 지정해주는데, var destination: UIViewController { get } 이렇게 destination은 UIvierController를 가져와한다고 정의되어있다 따라서 우리가 원하는 ViewController로 forced up cast를 시켜주기 위해 as! 를 사용해준다.
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
        }
    }
    
}
