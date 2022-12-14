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
            .edgesIgnoringSafeArea(.all)
            
            
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

struct CarARViewContainer: UIViewRepresentable {
    @Binding var type: CarType
    @Binding var carPaint: [CarPart : Color]
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        updateCarModel(arView: arView)
        
        return arView
        
    }
    
    private func updateCarModel(arView: ARView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
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
