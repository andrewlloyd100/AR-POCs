import SwiftUI
import RealityKit
import ARKit
import CasePaths
import SceneKit

struct CarView : View {
    @ObservedObject var model: CarModel
    
    var body: some View {
        VStack {
            CarARViewContainer(carPaint: $model.mercPaint).edgesIgnoringSafeArea(.all)
            
            
            HStack {
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
    @Binding var carPaint: [MercPart : Color]
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        
        let scene = try! Merc.loadScene()
        arView.scene.anchors.append(scene)
        
        updateMercPaint(scene: scene)

        return arView
        
    }
    
    private func updateMercPaint(scene: Merc.Scene) {
        for partPaint in carPaint {
            setMercPartColor(scene: scene,
                             part: partPaint.key,
                             color: partPaint.value)
        }
    }
    
   
    private func setMercPartColor(scene: Merc.Scene,
                          part: MercPart,
                          color: Color) {
        if let modelEntity = scene.car?.findEntity(named: part.rawValue)?.children[0] as?  ModelEntity {
            var material = SimpleMaterial()
            material.baseColor = .color(UIColor(color))
            modelEntity.model?.materials = [material]
        }
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let scene = uiView.scene.anchors.first as? Merc.Scene else {
            fatalError("couldnt fetch scene")
        }
        updateMercPaint(scene: scene)
    }
    
}
