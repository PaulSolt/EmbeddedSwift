//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//
// import Foundation
// func format(double: Double) -> String {
//     let int = Int(double)
//     let frac = Int((double - Double(int)) * 10000)
//     return "\(int).\(frac)"
// }

@_cdecl("app_main")
func app_main() {
  print("Hello from Swift on ESP32-C6!")
  // print(3.14)
  // print("\(3.14)")
  // printf("%f", 3.14)
  printFloat(3.14)
  // printFloat(Float(3.14))
  // printFloat(3.14)
  // char array[10];
  // sprintf(array, "%f", 3.123);

  let n = 256
  let ledStrip = LedStrip(gpioPin: 0, maxLeds: n)
  ledStrip.clear()
  print("clear!")
  var color: LedStrip.Color = .lightRandom
  var flip = false
  var colors: [LedStrip.Color] = .init(repeating: .off, count: n)
  var counter = 0
  var t: Double = 6.4

  var hue: UInt16 = 40

  while true {
    colors.removeAll()
    for x in 0..<16 {
      for y in 0..<16 {
      
        let x = Double(x)
        let y: Double = Double(y)
        var c = abs(sin(x * y * t)) // * 32
        print("\(Int(x)), \(Int(y)) \(format(double: c))")
        // String(format: "%f", 3.0)
        // print(c)
        // putc(Int32, UnsafeMutablePointer<FILE>!)
        // putc('\n', stdout);

        // printf("abc")
        
        // let c = abs(sin(x * y * t) * 32 - cos(x * y * t) * 32)

        // var c = abs(sin(x * y * t + x * x - y * y)) // - cos(x * y * t)) // 255.0
        // var c = abs(sin(x * t))
        // if c > 1 {
        //     c = 1
        // }
        c *= 32



        //let c = abs( Int(sin(Double(x * y)) * Double(t) + sin(Double(y) + t) ) * 64) % 64
        // print("x: \(x) y \(y) c: \(c)")
        // let y = String()
        // print("\(Float(c))")
        let color: LedStrip.Color = LedStrip.Color(r: UInt8(c), g: UInt8(c), b: UInt8(c))
        colors.append(color)
        // let color = LedStrip.Color(r: UInt8, g: UInt8, b: UInt8)
      } 
    }

    // t += 0.001
   if flip {
      color = .lightRandom
    } else {
      color = .lightWhite
    }

    // print("colors")
    for y: Int in 0 ..< 16 {

      for x in 0 ..< 16 {
        let index = y * 16 + x
        // ledStrip.setPixel(index: index, color: color)
        // ledStrip.setPixel(index: index, color: colors[index])
        ledStrip.setPixel(index: index, color: colors[index], hue: hue)
      }
    }
    print("hue: \(hue)")
    hue += 1
    hue %= 360

    // for index in 0 ..< n / 2 {
    //   print("setPixel: \(n)")
    //   ledStrip.setPixel(index: index, color: colors[index])

    //   // ledStrip.setPixel(index: index * 2, color: colors[index * 2])
    //   // ledStrip.setPixel(index: index + 2, color: colors[index + 2])
    // }
    // print("refresh:")
    ledStrip.refresh()

    counter += 1
    if counter >= 6 {
      flip.toggle()
      counter = 0
    }

    // flip.toggle()

    let blinkDelayMs: UInt32 = 16
    vTaskDelay(blinkDelayMs / (1000 / UInt32(configTICK_RATE_HZ)))

  }
}
