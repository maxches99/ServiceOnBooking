//
//  RegistrationNewClient.swift
//  ServiceOnBooking
//
//  Created by Максим Чесников on 19.12.2021.
//

import SwiftUI
import CoreData

struct RegistrationNewClient: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var services: FetchedResults<Service>
    
    @State var name = ""
    @State var family = ""
    @State var surname = ""
    
    @State var arrayOfServices: [Service] = []
    
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var action: (String, String, String, [Service], UIImage) -> Void
    
    var body: some View {
        VStack {
            Form {
                Section("ФИО") {
                    TextField("Имя", text: $name)
                    TextField("Фамилия", text: $family)
                    TextField("Отчество (Если есть)", text: $surname)
                    HStack {
                        Image(uiImage: self.image)
                                .resizable()
                                .cornerRadius(50)
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .padding(8)
                                .onTapGesture {
                                    showSheet = true
                            }
                        Text("Выберите изображение профиля")
                    }
                }
                Section("Услуги") {
                    List {
                        ForEach(services) { service in
                            Button(action: {arrayOfServices.append(service)}) {
                                HStack {
                                    Text(service.name ?? "")
                                    Spacer()
                                    if arrayOfServices.contains(service) {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle(Text("Данные клиента"))
        .toolbar {
            ToolbarItem {
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                    action(name, family, surname, arrayOfServices, image)
                }) {
                    Label("Add Item", systemImage: "square.and.arrow.down")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}

struct RegistrationNewClient_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationNewClient() {_,_,_, _, _ in}
        .environment(\.managedObjectContext, PersistenceController.previewServices.container.viewContext)
    }
}

//                        self.mode.wrappedValue.dismiss()


import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
