import SwiftUI
import UIKit

struct BookAddView: View {
    @EnvironmentObject var baseData: ViewModel
    
    @State var title = ""
    @State var name = ""
    
    @State private var image: UIImage?
    @State var showingImagePicker = false
    
    var body: some View {
        
        Form{
            ZStack(alignment:.center){
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.size.height*0.2)
                } else {
                    Image("noimage")
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.size.height*0.2)
                }
            }.frame(maxWidth:.infinity)
                .onTapGesture{
                    print("画像を選択")
                    showingImagePicker = true
                }
            TextField("タイトル", text: $title)
            TextField("ページ数", text: $name).keyboardType(.numberPad)
            
            Button(action: {
                print("確定")
                if title != "" && name != ""{
                    if let uiImage = image {
                        baseData.add(name: title, pages: Int(name)!, imageData: uiImage.pngData()!)
                    } else {
                        baseData.add(name: title, pages: Int(name)!, imageData: (UIImage(named: "noimage")?.pngData())!)
                    }
                    
                    baseData.showingBookAddView = false
                }
                
            }) {
                Text("確定")
            }
        }.sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
        
    }
    
}

struct BookAddView_Previews: PreviewProvider {
    @StateObject static var baseData = ViewModel()
    
    static var previews: some View {
        BookAddView().environmentObject(baseData)
        
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
           
            
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
              
                let clipRect = CGRect(x: 100, y: 0,
                                      width: editedImage.size.width-200, height: editedImage.size.height)
                let cripImageRef = editedImage.cgImage!.cropping(to: clipRect)
                let crippedImage = UIImage(cgImage: cripImageRef!)
                
                
                parent.selectedImage = crippedImage
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let clipRect = CGRect(x: 100, y: 0,
                                      width: originalImage.size.width-200, height: originalImage.size.height)
                let cripImageRef = originalImage.cgImage!.cropping(to: clipRect)
                let crippedImage = UIImage(cgImage: cripImageRef!)
                
                parent.selectedImage = crippedImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


