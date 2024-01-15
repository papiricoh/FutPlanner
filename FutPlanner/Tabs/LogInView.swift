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
            Form {
                Section(header: Text("Credenciales")) {
                    TextField("Nombre de Usuario", text: $username)
                    SecureField("Contraseña", text: $password)
                }
                
                Button(action: login) {
                    Text("Iniciar Sesión")
                }
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

#Preview {
    LogInView(onLoginSuccess: {
        //
    })
}
