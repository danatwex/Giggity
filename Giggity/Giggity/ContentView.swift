//
//  ContentView.swift
//  Giggity
//
//  Created by Daniel Marques on 10/02/23.
//

import SwiftUI

struct Pie: View {

    @State var slices: [(Double, Color)] = [
        (2, .red),
        (3, .orange),
        (4, .yellow),
        (1, .green),
        (5, .blue),
        (4, .indigo),
        (2, .purple)
    ]

    var total: Double = 100
    var essentials: Double = 50
    var discretionary: Double = 10
    var savings: Double = 20

    var body: some View {
        Canvas { context, size in
            let donut = Path { p in
                p.addEllipse(in: CGRect(origin: .zero, size: size))
                p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5))
            }
            context.clip(to: donut, style: .init(eoFill: true))

            let total = slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))

                startAngle = endAngle
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.slices = [
                (1, .green),
                (5, .blue),
                (4, .indigo),
                (2, .purple)
            ]
        }
    }
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie()
    }
}
