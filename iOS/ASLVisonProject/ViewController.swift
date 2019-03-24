    //
    //  ViewController.swift
    //  ASLVisonProject
    //
    //  Created by Sahith Thummalapally on 3/23/19.
    //  Copyright © 2019 Sahith Thummalapally Inc. All rights reserved.
    //
    

    import UIKit
    import AVKit
    import CoreML
    import Vision
    import AVFoundation
    import Firebase
    
    
    class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
        
        
        
            var predictString = ""
        
       
            enum HandLetter: String {
                
            
                case A = "A"
                case B = "B"
                case C = "C"
                case D = "D"
                case E = "E"
                case F = "F"
                case G = "G"
                case H = "H"
                case I = "I"
                case K = "K"
                case L = "L"
                case M = "M"
                case N = "N"
                case O = "O"
                case P = "P"
                case Q = "Q"
                case R = "R"
                case S = "S"
                case T = "T"
                case V = "V"
                
                
            }
        
        
            
            @IBOutlet weak var predictionLabel: UILabel!
        
        
            func configureCamera(){
            
                let captureSession = AVCaptureSession()
                captureSession.sessionPreset = .photo
                captureSession.startRunning()
                
                
                guard let captureDevice = AVCaptureDevice.default(for: .video) else {
                    return
                }
                
                
                guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice)
                    else {
                    return
                }
                
                
                captureSession.addInput(captureInput)
                
                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                view.layer.addSublayer(previewLayer)
                previewLayer.frame = view.frame
                
                
                
                let dataOutput = AVCaptureVideoDataOutput()
                dataOutput.setSampleBufferDelegate(self as AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue(label: "videoQueue"))
                captureSession.addOutput(dataOutput)
            
            }
        
        
            func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection){
                
                
                guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
                    else {
                        return
                    }
                
                
                guard let handModel = try? VNCoreMLModel(for: ASLPredictor().model) else{
                        return
                    }
                
                
                
                let request =  VNCoreMLRequest(model: handModel)
                { (finishedRequest, err) in
                    
                guard let results = finishedRequest.results as? [VNClassificationObservation] else {
                    return
                }
                    
                    
                guard let firstResult = results.first else {
                    return
                }
                    
                    
                 DispatchQueue.main.async {
                    
                    switch firstResult.identifier {
                        
                        case HandLetter.A.rawValue:
                            self.predictString = "A"
                        case HandLetter.B.rawValue:
                            self.predictString = "B"
                        case HandLetter.C.rawValue:
                            self.predictString = "C"
                        case HandLetter.D.rawValue:
                            self.predictString = "D"
                        case HandLetter.E.rawValue:
                            self.predictString = "E"
                        case  HandLetter.F.rawValue:
                            self.predictString = "F"
                        case HandLetter.G.rawValue:
                            self.predictString = "G"
                        case HandLetter.H.rawValue:
                            self.predictString = "H"
                        case HandLetter.I.rawValue:
                            self.predictString = "I"
                        case HandLetter.K.rawValue:
                            self.predictString = "K"
                        case HandLetter.L.rawValue:
                            self.predictString = "L"
                        case HandLetter.M.rawValue:
                            self.predictString = "M"
                        case HandLetter.N.rawValue:
                            self.predictString = "N"
                        case HandLetter.O.rawValue:
                            self.predictString = "O"
                        case HandLetter.P.rawValue:
                            self.predictString = "P"
                        case HandLetter.Q.rawValue:
                            self.predictString = "Q"
                        case HandLetter.R.rawValue:
                            self.predictString = "R"
                        case HandLetter.S.rawValue:
                            self.predictString = "S"
                        case HandLetter.T.rawValue:
                            self.predictString = "T"
                        case HandLetter.V.rawValue:
                            self.predictString = "V"
                        
                        
                        
                        default:
                            break
                    }
                    
                    self.predictionLabel.text = self.predictString
                    
                    
                    var ref: DocumentReference? = nil
                    
                    let db = Firestore.firestore()
                    
                    ref = db.collection("ASLTranslator").addDocument(data: [
                        
                        "letter": self.predictString
                        
                    ]) { err in
                        if let err = err{
                            print("Error adding document: \(err)")
                        } else{
                            print("Document added with ID: \(ref!.documentID)")
                        }

                    }
                    
                    }
                    
                    
                    }
                    
                    try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
                
               
        
        }
        
        
        @IBAction func startRecording(_ sender: Any) {
            
            
            configureCamera()
            
            
        }
        
        
        @IBAction func endRecording(_ sender: Any) {
            exit(0)
        }
        
        
        
            
    
                override func viewDidLoad() {
                    
                    
                    super.viewDidLoad()
                    configureCamera()
                    
                }
        
        }

