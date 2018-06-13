//
//  ViewController.swift
//  Search Engine Switcher
//
//  Created by Ray on 2018/6/12.
//  Copyright © 2018 Ray. All rights reserved.
//

import Cocoa
import SafariServices

class ViewController: NSViewController, NSWindowDelegate {

    @IBOutlet weak var enableIndicator: NSTextField!
    @IBOutlet weak var infomationLabel: NSTextField!
    @IBOutlet weak var enableButton: NSButton!

    let extId = "com.rayps.Search-Engine-Switcher.Search-Engine-Switcher-Extension"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear() {
        checkExtensionState()
    }

    override func viewDidAppear() {
        view.window!.delegate = self
        view.window!.styleMask.remove(.resizable)

        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.checkExtensionState), userInfo: nil, repeats: true)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }

    @objc func checkExtensionState() {
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extId) { (state, error) in
            DispatchQueue.main.async {
                if let status = state?.isEnabled {
                    self.enableIndicator.textColor = status ? .systemGreen : .systemRed
                    self.infomationLabel.stringValue = status ? "Enabled" : "Extension is currently disabled"
                    self.enableButton.isHidden = status
                }
            }
        }
    }

    @IBAction func enableButtonClicked(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extId)
    }

}

