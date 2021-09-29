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
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startRunCaptureSession()
        
    }
    
    private func startRunCaptureSession() {
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
        }
        photoData = photo.fileDataRepresentation()
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
        sessionQueue.async {
            self.captureSession.sessionPreset = .photo
        }
    }
    
    func setupDevice() {
        sessionQueue.async {
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera],
                mediaType: .video,
                position: .unspecified
            )
            deviceDiscoverySession.devices.forEach { device in
                switch device.position {
                case .back:
                    self.currentDevice = device
                default:
                    break
                }
            }
        }
    }
    
    func setupInputOutput() {
        sessionQueue.async {
            do {
                guard let currentDevice = self.currentDevice else { return }
                self.captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
                self.captureSession.addInput(self.captureDeviceInput)
                self.photoOutput.setPreparedPhotoSettingsArray(
                    [AVCapturePhotoSettings(
                        format: [AVVideoCodecKey: AVVideoCodecType.jpeg]
                    )]
                )
                self.captureSession.addOutput(self.photoOutput)
            } catch {
                fatalError("\(error)")
            }
        }
    }
    
    func setupPreviewLayer() {
        sessionQueue.async {
            self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.cameraPreviewLayer.videoGravity = .resizeAspectFill
            self.cameraPreviewLayer.connection?.videoOrientation = .portrait
            DispatchQueue.main.async {
                self.cameraPreviewLayer.frame = self.view.frame
                self.view.layer.insertSublayer(self.cameraPreviewLayer, at: 0)
            }
        }
    }
    
}
