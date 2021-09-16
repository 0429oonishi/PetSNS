//
//  CameraViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit
import AVFoundation

final class CameraViewController: UIViewController {
    
    @IBOutlet private weak var cameraView: UIView!
    @IBOutlet private weak var shutterButton: UIButton!
    
    private var captureSession = AVCaptureSession()
    private var currentDevice: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
        
    }
    
    @IBAction private func closeButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func shutterButtonDidTapped(_ sender: Any) {
        let editingPostVC = EditingPostViewController.instantiate()
        self.navigationController?.pushViewController(editingPostVC, animated: true)
    }
    
    @IBAction private func stillImageShootingButtonDidTapped(_ sender: Any) {
    }
    
    @IBAction private func movieShootingButtonDidTapped(_ sender: Any) {
    }
    
}

// MARK: - setup
extension CameraViewController {
    
    func setupCaptureSession() {
        captureSession.sessionPreset = .photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .unspecified
        )
        deviceDiscoverySession.devices.forEach { device in
            switch device.position {
                case .back:
                    currentDevice = device
                default:
                    break
            }
        }
    }
    
    func setupInputOutput() {
        do {
            guard let currentDevice = currentDevice else { return }
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
            captureSession.addInput(captureDeviceInput)
            let photoOutput = AVCapturePhotoOutput()
            photoOutput.setPreparedPhotoSettingsArray(
                [AVCapturePhotoSettings(
                    format: [AVVideoCodecKey: AVVideoCodecType.jpeg]
                )]
            )
            captureSession.addOutput(photoOutput)
        } catch {
            fatalError("\(error)")
        }
    }
    
    func setupPreviewLayer() {
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
        cameraPreviewLayer.frame = view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer, at: 0)
    }
    
}
