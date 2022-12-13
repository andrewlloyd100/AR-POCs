import SwiftUI
import CasePaths
import IdentifiedCollections
import SwiftUINavigation

struct HomeView: View {
    @ObservedObject var model: HomeModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    self.model.carButtonTapped()
                }) {
                    Text("Car")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.bordered)
                Button(action: {
                    self.model.fruitButtonTapped()
                }) {
                    Text("Fruit")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            .padding()
            .navigationTitle(Text("AR Proof of concepts"))
        }
        .sheet(
            unwrapping: self.$model.destination,
            case: CasePath(HomeModel.Destination.car)
        ) { _ in
            CarView(model: CarModel())
        }
        .sheet(
            unwrapping: self.$model.destination,
            case: CasePath(HomeModel.Destination.fruit)
        ) { _ in
            FruitView(model: FruitModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(model: HomeModel())
    }
}
