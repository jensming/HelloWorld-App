//
//  ContentView.swift
//  HelloWorld
//
//  Created by James Ensminger on 7/18/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var helloWorld = false
    @State var endHW = false
    
    var body: some View {
        
        ZStack {
            
            Button(action: doWorldRain, label: {
                Text("Hello World!")
                    .padding()
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                    .foregroundColor(.green)
                    .background(.green.opacity(0.35))
                    .cornerRadius(15.0)
            }).disabled(helloWorld)
            
            // handles states of world emoji rain
            WorldRain()
                .scaleEffect(helloWorld ? 1 : 0, anchor: .top)
                .opacity(helloWorld && !endHW ? 1 : 0)
                .offset(y: helloWorld ? 0 : getBounds().height / 2)
                .ignoresSafeArea()
        }
    }
    
    // handles the world emoji rain animation and duration
    func doWorldRain() {
        
        withAnimation(.spring()) {
            
            helloWorld = true
        }
        
        // resets the world emoji rain animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            withAnimation(.easeInOut(duration: 1.5)) {
                
                endHW = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                
                withAnimation(.easeInOut(duration: 0.2)) {
                    
                    helloWorld = false
                    endHW = false
                }
            }
        }
    }
}

// gets size of screen's bounds
func getBounds() -> CGRect {
    return UIScreen.main.bounds
}

// world emoji rains whenever button is clicked
struct WorldRain: UIViewRepresentable {
    
    // controls the emitter layer view
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmitterCells()
        
        emitterLayer.emitterSize = CGSize(width: getBounds().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getBounds().width/2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    // updates the emitter layer
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    // creates world emojis
    func createEmitterCells() -> [CAEmitterCell] {
        
        var emitterCells: [CAEmitterCell] = []
        
        for _ in 1...3 {
        
            let cell = CAEmitterCell()
            
            cell.contents = UIImage(named: "world-emoji")?.cgImage
            cell.color = UIColor.white.cgColor
            cell.birthRate = 4.5
            cell.lifetimeRange = 20
            cell.velocity = 100
            cell.scale = 0.25
            cell.scaleRange = 0.2
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.spin = 1.5
            cell.spinRange = 1
            cell.yAcceleration = 15
            
            emitterCells.append(cell)
        }
        
        return emitterCells
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
