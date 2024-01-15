//
//  LogInView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct LogInView: View {
    var onLoginSuccess: () -> Void
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Image("ClubPlaceholder").resizable().frame(width: 100, height: 100).clipShape(Rectangle()).cornerRadius(20)
            Text("Bienvenido a FutPlanner")
            VStack {
                ZStack (alignment: .leading) {
                    TextField("", text: $username).padding().clipShape(Rectangle()).background(Color("FutGreen")).foregroundColor(.white).cornerRadius(8).padding(.horizontal)
                    
                    if username.isEmpty {
                        Text("Usuario").foregroundStyle(Color.gray).padding(.leading, 34).allowsHitTesting(false)
                    }
                    
                }
                ZStack (alignment: .leading) {
                    SecureField("", text: $password).padding().clipShape(Rectangle()).background(Color("FutGreen")).foregroundColor(.white).cornerRadius(8).padding(.horizontal)
                    
                    if password.isEmpty {
                        Text("Contraseña").foregroundStyle(Color.gray).padding(.leading, 34).allowsHitTesting(false)
                    }
                }
                
                Button(action: login) {
                    Text("Iniciar Sesión")
                }.padding().background(Color("FutGreenLight")).foregroundColor(.white).bold().clipShape(Rectangle()).cornerRadius(8)
            }
        }
    }
    func login() {
        // Aquí debería implementar la lógica de validación y autenticación
        // Por ahora, este es solo un ejemplo
        print("Intento de inicio de sesión con Usuario: \(username), Contraseña: \(password)")
        
        // Supongamos que la validación fue exitosa
        onLoginSuccess()
    }
    
}

extension UITextField {
    func setPlaceholderColor(to color: UIColor) {
        let placeholderText = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: color])
    }
}

#Preview {
    LogInView(onLoginSuccess: {
        //
    })
}
