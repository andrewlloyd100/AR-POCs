import SwiftUI
import RealityKit
import ARKit

struct FruitView : View {
    @ObservedObject var model: FruitModel
    
    var body: some View {
        VStack {
            FruitARViewContainer(model: model)
            VStack {
                Toggle(isOn: $model.banana) {
                    Text("Banana")
                }
                Toggle(isOn: $model.grapes) {
                    Text("Grapes")
                }
                Toggle(isOn: $model.peach) {
                    Text("Peach")
                }
                Toggle(isOn: $model.lemon) {
                    Text("Lemon")
                }
                Toggle(isOn: $model.watermelon) {
                    Text("Watermelon")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
        
    }
}


struct FruitARViewContainer: UIViewRepresentable {
    @ObservedObject var model: FruitModel
    
    var arView: ARView?

    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(ARCoordinator.handleTap)))
        
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Fruit.loadScene()
        
        
        if let scene = try? Fruit.loadScene() {
            if let bananaEntity = scene.findEntity(named: "banana") {
                bananaEntity.isEnabled = model.banana
            }
            if let grapesEntity = scene.findEntity(named: "grapes") {
                grapesEntity.isEnabled = model.grapes
            }
            if let peachEntity = scene.findEntity(named: "peach") {
                peachEntity.isEnabled = model.peach
            }
            if let lemonEntity = scene.findEntity(named: "lemon") {
                lemonEntity.isEnabled = model.lemon
            }
            if let watermelonEntity = scene.findEntity(named: "watermelon") {
                watermelonEntity.isEnabled = model.watermelon
            }
        
            // Add the box anchor to the scene
            arView.scene.anchors.append(scene)
        }
        
        return arView
        
    }
    
    func makeCoordinator() -> ARCoordinator {
        ARCoordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let scene = uiView.scene.anchors.first as? Fruit.Scene else {
            fatalError("couldnt fetch scene")
        }
        if let bananaEntity = scene.findEntity(named: "banana") {
            bananaEntity.isEnabled = model.banana
        }
        if let grapesEntity = scene.findEntity(named: "grapes") {
            grapesEntity.isEnabled = model.grapes
        }
        if let peachEntity = scene.findEntity(named: "peach") {
            peachEntity.isEnabled = model.peach
        }
        if let lemonEntity = scene.findEntity(named: "lemon") {
            lemonEntity.isEnabled = model.lemon
        }
        if let watermelonEntity = scene.findEntity(named: "watermelon") {
            watermelonEntity.isEnabled = model.watermelon
        }
    }
    
}
