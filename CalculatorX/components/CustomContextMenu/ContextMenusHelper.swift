//
//  ContextMenusHelper.swift
//  CalculatorX
//
//  Created by HauNguyen on 04/10/2565 BE.
//

import SwiftUI

struct ContextMenusHelper<Content: View, PreView: View>: UIViewRepresentable {
    init(content: Content, preview: PreView, actions: UIMenu? = nil, onEnd: (() -> Void)? = nil) {
        self.content = content
        self.preview = preview
        self.actions = actions
        self.onEnd = onEnd
    }
    
    var content: Content
    var preview: PreView
    var actions: UIMenu?
    var onEnd: (() -> Void)?
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let hostedView = UIHostingController(rootView: self.content)
        hostedView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let contrains = [
            hostedView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostedView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostedView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostedView.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            hostedView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostedView.view.heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
        
        view.addSubview(hostedView.view)
        view.addConstraints(contrains)
        
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addInteraction(interaction)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        var parent: ContextMenusHelper
        init(parent: ContextMenusHelper) {
            self.parent = parent
        }
        
        // Delegate Methods..
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            
            return UIContextMenuConfiguration(identifier: nil) {
                
                let previewController = UIHostingController(rootView: self.parent.preview)
                previewController.view.backgroundColor = .clear
                
                return previewController
                // Your view..
            } actionProvider: { items in
                // Your actions..
                return self.parent.actions
            }
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
            animator.addCompletion {
                print("Ended")
                self.parent.onEnd?()
            }
        }
    }
}

struct ContextMenusHelper_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomContextMenu(content: {
                Label {
                    Text("Click me!")
                        .font(.title2)
                } icon: {
                    Image(systemName: "lock.fill")
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(.purple)
                .cornerRadius(8)

            }, preview: {
                Text("Hello")
            }, actions: {
                return UIMenu(title: "", children: [])
            })
        }
    }
}

