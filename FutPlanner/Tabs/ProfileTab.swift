//
//  Profile.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 9/5/24.
//

import SwiftUI
import PhotosUI
import Alamofire

struct ProfileTab: View {
    var onLogout: () -> Void
    @State private var imageKey: UUID = UUID()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Color.futGreen.edgesIgnoringSafeArea(.all).frame(height: 240)
                    .shadow(radius: 6)
                VStack(alignment: .leading) {
                    Text("\(user?.firstName ?? "Nombre del Usuario") \(user?.lastName ?? "")")
                        .font(.title).bold()
                    
                    Text("Entrenador de \(fTeam?.teamName ?? "Equipo sin cargar")")
                        .font(.body)
                    
                    Text("Usuario: \(user?.username ?? "Usuario") #\(String(user?.id ?? 0))")
                        .font(.body)
                    
                }.padding().padding(.top, 90)
                List (){
                    Button("Cambiar contraseña") {
                        
                    }
                    Button(action: onLogout, label: {
                        Text("Cerrar Sesión")
                    }).foregroundColor(.red)
                }
            }
            VStack {
                Text("Perfil").font(.system(size: 30)).bold().foregroundStyle(Color.white)
                AsyncImage(url: URL(string: user?.photoUrl ?? "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg")){ image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    LoadingComponent().frame(width: 200, height: 200)
                }.frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 6).padding(.top, 74).onTapGesture {
                        showingImagePicker = true
                    }.id(imageKey) //recarga la imagen generando un nuevo UUID
                Spacer()
            }
        }.sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage, onImageSelected: handleSelectedImage)
        }
    }
    func handleSelectedImage(_ image: UIImage) {
        guard let fixedImage = image.fixedOrientation(), let _ = fixedImage.jpegData(compressionQuality: 0.5) else {
            
            print("No se pudo arreglar la orientación de la imagen o convertirla a JPEG")
            return
        }
        Task {
            Task {
                do {
                    try await fetchChangeProfilePhoto(fixedImage)
                    
                } catch {
                    print("Error en la solicitud: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchChangeProfilePhoto(_ image: UIImage) async throws {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Error al convertir la imagen a JPEG")
            return
        }
        
        let url = "\(apiDir)/upload"
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(user?.id ?? 0)",
            "token": user?.lastTokenKey ?? "",
            "type": "profile"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            
                multipartFormData.append(imageData, withName: "photo", fileName: "profile\(user?.id ?? 0).jpg", mimeType: "image/jpeg")
                
                //Agregar los parámetros
                for (key, value) in parameters {
                    multipartFormData.append(Data(value.utf8), withName: key)
                }
            }, to: url, method: .post, headers: headers)
            .responseDecodable(of: UploadResponse.self) { response in
                switch response.result {
                case .success(let uploadResponse):
                    user!.photoUrl = uploadResponse.imageUrl
                    print(user!)
                    imageKey = UUID()
                case .failure(let error):
                    print("Error al subir la imagen: \(error)")
                    
                }
            }
    }

}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?
    var onImageSelected: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            //Callback
                            self.parent.onImageSelected(image)
                        }
                    }
                }
            }
        }
    }
}

//Extension para corregir la imagen (Imagenes de fotos sacadas con camara se rotan 90º)
extension UIImage {
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != .up else {
            //Orientación correcta, no es necesario hacer ajustes
            return self
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return normalizedImage
    }
}

#Preview {
    ProfileTab(onLogout: {})
}
