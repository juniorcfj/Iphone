class iPhone {
    var modelo: String
    var cor: String
    var capacidade: Int
    
    init(modelo: String, cor: String, capacidade: Int) {
        self.modelo = modelo
        self.cor = cor
        self.capacidade = capacidade
    }
    
    func ligar() {
        print("O iPhone está ligado.")
    }
    
    func desligar() {
        print("O iPhone está desligado.")
    }
    
    func fazerChamada(numero: String) {
        print("Fazendo uma chamada para \(numero)...")
    }
    
    func enviarMensagem(texto: String, para numero: String) {
        print("Enviando mensagem para \(numero): \(texto)")
    }
}

import AVFoundation

class CameraManager: NSObject, AVCapturePhotoCaptureDelegate {
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()

    override init() {
        super.init()
        

        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                    if captureSession.canAddOutput(photoOutput) {
                        captureSession.addOutput(photoOutput)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func takePhoto(completion: @escaping (UIImage?) -> Void) {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
            
        } else {
        
        }
    }
}


import Contacts

class ContactsManager {
    private let contactStore = CNContactStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        contactStore.requestAccess(for: .contacts) { granted, error in
            completion(granted)
        }
    }
    
    func fetchContacts() -> [CNContact] {
        let keys = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor
        ]
        
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            let contacts = try contactStore.enumerateContacts(with: request)
            return contacts
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
