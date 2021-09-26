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
            /// ① ビデオプレビューレイヤーのビデオ方向に合わせる
            if let photoOutputConnection = self.photoOutput.connection(with: .video),
               let orientation = videoPreviewLayerOrientation {
                photoOutputConnection.videoOrientation = orientation
            }
            /// ② 向きが揃ったら、設定開始
            let photoSettings = AVCapturePhotoSettings()
            if self.captureDeviceInput.device.isFlashAvailable {
                photoSettings.flashMode = .auto
            }
            /// ③ 写真をキャプチャ
            self.photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
        
        let editingPostVC = EditingPostViewController.instantiate()
        self.navigationController?.pushViewController(editingPostVC, animated: true)
    }
    
    @IBAction private func stillImageShootingButtonDidTapped(_ sender: Any) {
    }
    
    @IBAction private func movieShootingButtonDidTapped(_ sender: Any) {
    }
    
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        /// capturePhoto(with: photoSettings, delegate: self)後、１番最初に呼ばれる
        print(#function)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        /// シャッター音が鳴った直後
        print(#function)
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
        /// システムが深度データとポートレートエフェクトマットの処理を終えたときに届く
        print(#function)
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
        /// 最終的なコールバックで、1枚の写真のキャプチャが終了したことを示す
        print(#function)
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
