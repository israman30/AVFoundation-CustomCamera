//
//  ViewController.swift
//  CustomCamera
//
//  Created by Israel Manzo on 8/14/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

   
    @IBOutlet weak var cameraBtn: UIButton!
    
    let session = AVCaptureSession()
    
    var camera: AVCaptureDevice?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var cameraCaptureOutPut: AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession()
        
        navigationController?.navigationBar.isHidden = true
        cameraBtn.layer.cornerRadius = 30
        
    }
    
    // MARK: - Display photo
    func displayCapturePhoto(capturePhoto: UIImage){
        
        let imagePreviewVC = storyboard?.instantiateViewController(withIdentifier: "PrevViewController") as! PrevViewController
        imagePreviewVC.image = capturePhoto
        navigationController?.pushViewController(imagePreviewVC, animated: true)
        
    }
    
    // MARK: - Capture photo function
    func captureSession(){
    
        session.sessionPreset = AVCaptureSessionPresetHigh
        camera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
        
            let cameraCaptureInput = try AVCaptureDeviceInput(device: camera!)
            cameraCaptureOutPut = AVCapturePhotoOutput()
            session.addInput(cameraCaptureInput)
            session.addOutput(cameraCaptureOutPut)
            
        } catch {
            
            print(error.localizedDescription)
        }
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.frame = view.bounds
        cameraPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
        
        view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
        session.startRunning()
    }
    
    // MARK: - Take photo function capture
    func takePhoto(){
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        cameraCaptureOutPut?.capturePhoto(with: settings, delegate: self)
    }
  
    @IBAction func takePhoto(_ sender: Any) {
        
        takePhoto()
        
    }

}


// Extenssion AVCapture Photo Delegate
extension ViewController: AVCapturePhotoCaptureDelegate {
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            
            print(error.localizedDescription)
            
        } else {
            
            if let sampleBuffer = photoSampleBuffer,let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) {
                
                if let image = UIImage(data: dataImage) {
                    displayCapturePhoto(capturePhoto: image)
                    
                }
            }
        }
    }
}











