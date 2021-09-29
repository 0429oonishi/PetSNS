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
    private let photoOutput = AVCapturePhotoOutput()
    private var captureDeviceInput: AVCaptureDeviceInput!
    private let sessionQueue = DispatchQueue(label: "session queue")
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer!
    private var photoData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionQueue.async {
            self.setupCaptureSession()
            self.setupDevice()
            self.setupInputOutput()
            self.setupPreviewLayer()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            self.captureSession.startRunning()
        }
        
    }
    
    @IBAction private func closeButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func shutterButtonDidTapped(_ sender: Any) {
        let videoPreviewLayerOrientation = cameraPreviewLayer.connection?.videoOrientation
        sessionQueue.async {
            self.alignDirection(orientation: videoPreviewLayerOrientation)
            let photoSettings = AVCapturePhotoSettings()
            self.configurePhotoSettings(photoSettings: photoSettings)
            self.photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
    
    private func alignDirection(orientation: AVCaptureVideoOrientation?) {
        if let photoOutputConnection = self.photoOutput.connection(with: .video),
           let orientation = orientation {
            photoOutputConnection.videoOrientation = orientation
        }
    }
    
    private func configurePhotoSettings(photoSettings: AVCapturePhotoSettings) {
        if self.captureDeviceInput.device.isFlashAvailable {
            photoSettings.flashMode = .auto
        }
    }
    
    @IBAction private func stillImageShootingButtonDidTapped(_ sender: Any) {
    }
    
    @IBAction private func movieShootingButtonDidTapped(_ sender: Any) {
    }
    
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        // 撮影時、PreviewLayerが点滅する処理を実装しようとしたが、点滅しなかった。ボタンとかは点滅できた。
        DispatchQueue.main.async {
            self.cameraPreviewLayer.opacity = 0
            UIView.animate(withDuration: 0.25) {
                self.cameraPreviewLayer.opacity = 1
            }
        }
        
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        } else {
            photoData = photo.fileDataRepresentation()
        }
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings,
                     error: Error?) {
        guard let photoData = photoData else { return }
        let editingPostVC = EditingPostViewController.instantiate()
        editingPostVC.receivePhoto(photoData: photoData)
        self.navigationController?.pushViewController(editingPostVC, animated: true)
    }
    
}

// MARK: - setup
private extension CameraViewController {
    
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
            captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
            captureSession.addInput(captureDeviceInput)
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
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
        DispatchQueue.main.async {
            self.cameraPreviewLayer.frame = self.view.frame
            self.view.layer.insertSublayer(self.cameraPreviewLayer, at: 0)
        }
    }
    
}
