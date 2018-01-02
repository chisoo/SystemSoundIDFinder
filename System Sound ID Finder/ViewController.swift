//
//  ViewController.swift
//  System Sound ID Finder
//
//  Created by Chisoo Kim on 12/21/17.
//  Copyright © 2017 Chisoo Kim. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var soundPicker: UIPickerView!
    @IBOutlet var soundIdLabel: UILabel!
    
    var soundPickerData = [String]()
    var soundPickerDictionary = [String: UInt32]()
	
	var systemSoundIdPlaying: SystemSoundID?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSoundIDList()
        soundIdLabel.text = "???"
        
        self.soundPicker.dataSource = self
        self.soundPicker.delegate = self
        
    }
	
    func playSound(soundID: UInt32) {
		systemSoundIdPlaying = soundID
        AudioServicesPlaySystemSound(systemSoundIdPlaying!)
    }
    
	// MARKER: - UIPickerView data source methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return soundPickerData.count
    }
	
	// MARKER: - UIPickerView delegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return soundPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont(name: "System", size: 20)
        label.text = soundPickerData[row]
        label.textAlignment = .center
        
        return label
    }
	
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if let systemSoundIdPlaying = systemSoundIdPlaying {
			AudioServicesDisposeSystemSoundID(systemSoundIdPlaying)
		}
		
        let soundIdNumber = soundPickerDictionary[soundPickerData[row]]!
        soundIdLabel.text = String(soundIdNumber)
        playSound(soundID: soundIdNumber)
        
    }
    
    func getSoundIDList() {
        soundPickerDictionary = ["MailReceived": 1000, "MailSent": 1001, "VoicemailReceived": 1002,
                                 "SMSReceived": 1003, "SMSSent": 1004, "CalendarAlert": 1005,
                                 "LowPower": 1006, "SMSReceived_Alert1": 1007, "SMSReceived_Alert2": 1008,
                                 "SMSReceived_Alert3": 1009, "SMSReceived_Alert4": 1010, "SMSReceived_Vibrate": 1011,
                                 "SMSReceived_Alert5": 1012, "SMSReceived_Alert6": 1013, "SMSReceived_Alert7": 1014,
                                 "VoicemailReceived2": 1015, "SMSSent2": 1016,
                                 "SMSReceivedAlert-Anticipate": 1020, "SMSReceivedAlert-Bloom": 1021,
                                 "SMSReceivedAlert-Calypso": 1022, "SMSReceivedAlert-Choo_Choo": 1023,
                                 "SMSReceivedAlert-Descent": 1024, "SMSReceivedAlert-Fanfare": 1025,
                                 "SMSReceivedAlert-Ladder": 1026, "SMSReceivedAlert-Minuet": 1027,
                                 "SMSReceivedAlert-News_Flash": 1028, "SMSReceivedAlert-Noir": 1029,
                                 "SMSReceivedAlert-Sherwood_Forest": 1030, "SMSReceivedAlert-Spell": 1031,
                                 "SMSReceivedAlert-Suspense": 1032, "SMSReceivedAlert-Telegraph": 1033,
                                 "SMSReceivedAlert-Tiptoes": 1034, "SMSReceivedAlert-Typewriters": 1035,
                                 "SMSReceivedAlert-Update": 1036, "SMSReceivedAlert-ussd": 1050,
                                 "SIMToolkitTone-CallDropped": 1051, "SIMToolkitTone-GeneralBeep": 1052,
                                 "SIMToolkitTone-NegativeACK": 1053, "SIMToolkitTone-PositiveACK": 1054,
                                 "SIMToolkitTone-SMS": 1055, "PINKeyPressed": 1057,
                                 "AudioToneBusy": 1070, "AudioToneCongestion": 1071,
                                 "AudioTonePathAcknowledge": 1072, "AudioToneError": 1073,
                                 "AudioToneCallWaiting": 1074, "AudioToneKey2": 1075,
                                 "ScreenLocked": 1100, "ScreenUnlocked": 1101, "FailedUnlock": 1102,
                                 "KeyPressed-Tink": 1103, "KeyPressed-Tock1": 1104, "KeyPressed-Tock2": 1105,
                                 "ConnectedToPower": 1106, "RingerSwitchIndication": 1107,
                                 "CameraShutter": 1108, "ShakeToShuffle": 1109, "JBL_Begin": 1110,
                                 "JBL_Confirm": 1111, "JBL_Cancel": 1112, "BeginRecording": 1113,
                                 "EndRecording": 1114, "JBL_Ambiguous": 1115, "JBL_NoMatch": 1116,
                                 "BeginVideoRecording": 1117, "EndVideoRecording": 1118,
                                 "VCInvitationAccepted": 1150, "VCRinging": 1151, "VCEnded": 1152,
                                 "VCCallWaiting": 1153, "VCCallUpgrade": 1154,
                                 "TouchTone0": 1200, "TouchTone1": 1201, "TouchTone2": 1202,
                                 "TouchTone3": 1203, "TouchTone4": 1204, "TouchTone5": 1205,
                                 "TouchTone6": 1206, "TouchTone7": 1207, "TouchTone8": 1208,
                                 "TouchTone9": 1209, "TouchTone-Star": 1210, "TouchTone-Pound": 1211,
                                 "Headset_StartCall": 1254, "Headset_Redial": 1255, "Headset_AnswerCall": 1256,
                                 "Headset_EndCall": 1257, "Headset_CallWaitingActions": 1258, "Headset_TransitionEnd": 1259,
                                 "SystemSoundPreview_Voicemail": 1300, "SystemSoundPreview_ReceivedMessage": 1301,
                                 "SystemSoundPreview_new-mail": 1302, "SystemSoundPreview_mail-sent": 1303,
                                 "SystemSoundPreview-alarm": 1304, "SystemSoundPreview-lock": 1305,
                                 "KeyPressClickPreview": 1306, "SMSReceived_Selection1": 1307,
                                 "SMSReceived_Selection2": 1308, "SMSReceived_Selection3": 1309,
                                 "SMSReceived_Selection4": 1310, "SMSReceived_Vibrate2": 1311,
                                 "SMSReceived_Selection5": 1312, "SMSReceived_Selection6": 1313,
                                 "SMSReceived_Selection7": 1314, "SMSReceived_Selection8": 1314,
                                 "SystemSoundPreview-Voicemail2": 1315,
                                 "SMSReceived_Selection-Anticipate": 1320, "SMSReceived_Selection-Bloom": 1321,
                                 "SMSReceived_Selection-Calypso": 1322, "SMSReceived_Selection-Choo_Choo": 1323,
                                 "SMSReceived_Selection-Descent": 1324, "SMSReceived_Selection-Fanfare": 1325,
                                 "SMSReceived_Selection-Ladder": 1326, "SMSReceived_Selection-Minuet": 1327,
                                 "SMSReceived_Selection-News_Flash": 1328, "SMSReceived_Selection-Noir": 1329,
                                 "SMSReceived_Selection-Sherwood_Forest": 1330, "SMSReceived_Selection-Spell": 1331,
                                 "SMSReceived_Selection-Suspense": 1332, "SMSReceived_Selection-Telegraph": 1333,
                                 "SMSReceived_Selection-Tiptoes": 1334, "SMSReceived_Selection-Typewriters": 1335,
                                 "SMSReceived_Selection-Update": 1336, "RingerVibeChanged": 1350,
                                 "SilentVibeChanged": 1351, "Vibrate": 4095
        ]
        soundPickerData = Array(soundPickerDictionary.keys).sorted()
    }
}

