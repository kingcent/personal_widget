tag_names = "AudioService AudioPolicyManagerBase  AudioService WiredAccessoryObserver UsbDeviceManager AudioPolicyService HALAudioPolicyManagerBase usbmond"

crt.Screen.Send "logcat -s " & tag_names & vbCr 
