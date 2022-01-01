////
////  ServicesView.swift
////  ServiceOnBooking
////
////  Created by Максим Чесников on 19.12.2021.
////
//
//import SwiftUI
//import CoreData
//
//struct ServicesView: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Service.name, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Service>
//    
//    var body: some View {
//        
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
//        
//        return List {
//            ForEach(items) { item in
//                NavigationLink {
//                    if let relat = item.relationship {
//                        Text("\(item.name ?? "") \(relat)")
//                    }
//                    
//                } label: {
//                    Text("\(item.name ?? "")")
//                }
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            ToolbarItem {
//                Button(action: addItem) {
//                    Label("Add Item", systemImage: "plus")
//                }
//            }
//        }
//    }
//    
//    private func addItem() {
//        withAnimation {
//            let newItem = Service(context: viewContext)
//            newItem.name = "Косметология 2"
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//struct ServicesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServicesView().environment(\.managedObjectContext, PersistenceController.previewServices.container.viewContext)
//    }
//}
