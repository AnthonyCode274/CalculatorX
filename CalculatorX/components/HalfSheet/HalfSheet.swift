//
//  HalfSheet.swift
//  CalculatorX
//
//  Created by HauNguyen on 06/10/2565 BE.
//

import UIKit
import SwiftUI

extension View {
    func halfSheet<Content:View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(HalfSheetViewModifier(isPresented: isPresented, onDismiss: onDismiss, swiftUIContent: content))
    }
}

// 1 - Create a UISheetPresentationController that can be used in a SwiftUI interface
struct HalfSheet<Content: View>: UIViewRepresentable {
    
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let content: Content
    @State private var getState: UISheetPresentationController.Detent.Identifier = .large
    
    init(isPresented: Binding<Bool>,
         onDismiss: (() -> Void)? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
        // Create the UIViewController that will be presented by the UIButton
        let vc = UIViewController()
        
        // Create the UIHostingController that will embed the SwiftUI View
        let host = UIHostingController(rootView: content)
        
        // Add the UIHostingController to the UIViewController
        vc.addChild(host)
        vc.view.addSubview(host.view)
        // Set constraints
        host.view.translatesAutoresizingMaskIntoConstraints = false
        host.view.leftAnchor.constraint(equalTo: vc.view.leftAnchor).isActive = true
        host.view.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        host.view.rightAnchor.constraint(equalTo: vc.view.rightAnchor).isActive = true
        host.view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        host.didMove(toParent: vc)
        
        // Set the presentationController as a UISheetPresentationController
        if let sheet = vc.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = false
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            //sheet.largestUndimmedDetentIdentifier = .medium
            sheet.selectedDetentIdentifier = .medium
        }
        
        // Set the coordinator (delegate)
        // We need the delegate to use the presentationControllerDidDismiss function
        vc.presentationController?.delegate = context.coordinator
        
        
        if isPresented {
            // Present the viewController
            uiView.window?.rootViewController?.present(vc, animated: true)
        } else {
            // Dismiss the viewController
            uiView.window?.rootViewController?.dismiss(animated: true)
        }
        
    }
    
    /* Creates the custom instance that you use to communicate changes
     from your view controller to other parts of your SwiftUI interface.
     */
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, onDismiss: onDismiss)
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        @Binding var isPresented: Bool
        let onDismiss: (() -> Void)?
        
        init(isPresented: Binding<Bool>,
             onDismiss: (() -> Void)? = nil)
        {
            self._isPresented = isPresented
            self.onDismiss = onDismiss
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            self.isPresented = false
            self.onDismiss?()
        }
        
    }
}

// 2 - Create the SwiftUI modifier conforming to the ViewModifier protocol
struct HalfSheetViewModifier<SwiftUIContent : View>: ViewModifier {
    
    @Binding var isPresented: Bool
    
    let onDismiss: (() -> Void)?
    
    let swiftUIContent: SwiftUIContent
    
    init(isPresented: Binding<Bool>,
         onDismiss: (() -> Void)? = nil,
         @ViewBuilder swiftUIContent: @escaping () -> SwiftUIContent)
    {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.swiftUIContent = swiftUIContent()
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                HalfSheet(isPresented: $isPresented, onDismiss: onDismiss) {
                    swiftUIContent
                }
                .fixedSize()
            )
    }
}


// 4 - An example of how to use the sheetWithDetents modifier
struct DemoHalfSheetModal: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.pink
                .ignoresSafeArea()
            Button {
                isPresented.toggle()
            } label: {
                VStack {
                    Text("Tap me!")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                }
            }
            .halfSheet(isPresented: $isPresented, onDismiss: onDismiss) {
                VStack {
                    Text("SwiftUI Content ")
                        .bold()
                        .font(.title)
                }
            }
        }
    }
    
    func onDismiss() {
        print("The sheet has been dismissed")
    }
}

struct HalfSheetModal_Previews: PreviewProvider {
    static var previews: some View {
        DemoHalfSheetModal()
    }
}
