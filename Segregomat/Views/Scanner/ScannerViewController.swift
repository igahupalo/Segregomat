//
//  ScannerViewXontroller.swift
//  Segregomat
//
//  Created by Iga Hupalo on 04/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation



class BarcodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a session object.
        
        session = AVCaptureSession()

        // Set the captureDevice.

        let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)

        // Create input object.

        let videoInput: AVCaptureDeviceInput?

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
        } catch {
            return
        }

        // Add input to the session.

        if (session.canAddInput(videoInput!)) {
            session.addInput(videoInput!)
        } else {
            scanningNotPossible()
        }

        // Create output object.

        let metadataOutput = AVCaptureMetadataOutput()

        // Add output to the session.

        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)

            // Send captured data to the delegate object via a serial queue.

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

            // Set barcode type for which to scan: EAN-13.

            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]

        } else {
            scanningNotPossible()
        }

        // Add previewLayer and have it show the video data.

        previewLayer = AVCaptureVideoPreviewLayer(session: session);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
        view.layer.addSublayer(previewLayer);

        // Begin the capture session.

        session.startRunning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (session?.isRunning == false) {
            session.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (session?.isRunning == true) {
            session.stopRunning()
        }
    }

    func scanningNotPossible() {

        // Let the user know that scanning isn't possible with the current device.

        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        session = nil
    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {

        // Get the first object from the metadataObjects array.

        if let barcodeData = metadataObjects.first {

            // Turn it into machine readable code

            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;

            if let readableCode = barcodeReadable {

                // Send the barcode as a string to barcodeDetected()

                barcodeDetected(code: readableCode.stringValue!);
            }

            // Vibrate the device to give the user some feedback.

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            // Avoid a very buzzy device.

            session.stopRunning()
        }
    }

    func barcodeDetected(code: String) {

        // Let the user know we've found something.

        let alert = UIAlertController(title: "Found a Barcode!", message: code, preferredStyle: UIAlertController.Style.Alert)
        alert.addAction(UIAlertAction(title: "Search", style: UIAlertActionStyle.Destructive, handler: { action in

            // Remove the spaces.

            let trimmedCode = code.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

            // EAN or UPC?
            // Check for added "0" at beginning of code.

            let trimmedCodeString = "\(trimmedCode)"
            var trimmedCodeNoZero: String

            if trimmedCodeString.hasPrefix("0") && trimmedCodeString.characters.count > 1 {
                trimmedCodeNoZero = String(trimmedCodeString.characters.dropFirst())

                // Send the doctored UPC to DataService.searchAPI()

                DataService.searchAPI(trimmedCodeNoZero)
            } else {

                // Send the doctored EAN to DataService.searchAPI()

                DataService.searchAPI(trimmedCodeString)
            }

            self.navigationController?.popViewControllerAnimated(true)
        }))

        self.presentViewController(alert, animated: true, completion: nil)
    }
}
