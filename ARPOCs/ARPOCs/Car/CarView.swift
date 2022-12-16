import SwiftUI
import RealityKit
import ARKit
import CasePaths
import SceneKit

struct CarView : View {
    @ObservedObject var model: CarModel
    
    var body: some View {
        VStack {
            CarARViewContainer(type: $model.carType,
                               carPaint: $model.mercPaint)
            
            HStack {
                Picker("Car", selection: $model.carType) {
                    ForEach(CarType.allCases, id: \.self) { value in
                        Text(value.rawValue)
                            .tag(value)
                    }
                }
                Picker("Car Part", selection: $model.selectedPart) {
                    ForEach(Array(model.mercPaint.keys), id: \.self.rawValue) { part in
                        Text(part.displayString)
                    }
                }
                ColorPicker("", selection: $model.selectedColor)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 100)
        }
    }
}

class ARCoordinator: NSObject, ARSessionDelegate {
    
    weak var arView: ARView?
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let view = self.arView else { return }
        debugPrint("Anchors added to the scene: ", anchors)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("tap")
        let tapLocation = sender.location(in: arView)
        // Get the entity at the location we've tapped, if one exists
        if let button = arView?.entity(at: tapLocation) {
            // For testing purposes, print the name of the tapped entity
            print(button.name)
        }
    }
}

struct CarARViewContainer: UIViewRepresentable {
    @Binding var type: CarType
    @Binding var carPaint: [CarPart : Color]
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        updateCarModel(arView: arView)
        
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(ARCoordinator.handleTap)))
        
        return arView
    }

    func makeCoordinator() -> ARCoordinator {
        ARCoordinator()
    }
    
    private func updateCarModel(arView: ARView) {
        arView.scene.anchors.removeAll()
        switch type {
        case .merc:
            let scene = try! Merc.loadScene()
            arView.scene.anchors.append(scene)
            updateCarPaint(scene: scene)
        case .ferrari:
            let scene = try! Ferrari.loadScene()
            arView.scene.anchors.append(scene)
            updateCarPaint(scene: scene)
        }
    }
    
    private func updateCarPaint(scene: RealityKit.Entity) {
        for partPaint in carPaint {
            setCarPartColor(scene: scene,
                             part: partPaint.key,
                             color: partPaint.value)
        }
    }
    
    private func setCarPartColor(scene: RealityKit.Entity,
                          part: CarPart,
                          color: Color) {
        if let modelEntity = scene.findEntity(named: "car")?.findEntity(named: part.rawValue)?.children[0] as?  ModelEntity {
            var material = SimpleMaterial()
            material.baseColor = .color(UIColor(color))
            modelEntity.model?.materials = [material]
        }
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let scene = uiView.scene.anchors.first as? RealityKit.Entity else {
            print("couldnt fetch scene")
            return
        }
        
        if currentDisplayedType(arView: uiView) != self.type {
            print("Type changed to: \(type.rawValue)")
            //type has been changed, remove old car model and add new one
            updateCarModel(arView: uiView)
        } else {
            //same model, just update paint
            updateCarPaint(scene: scene)
        }
    }
    
    func currentDisplayedType(arView: ARView) -> CarType? {
        if let _ = arView.scene.anchors.first as? Merc.Scene {
            return .merc
        }
        else if let _ = arView.scene.anchors.first as? Ferrari.Scene {
            return .ferrari
        }
        else {
            return nil
        }
    }
    
}
