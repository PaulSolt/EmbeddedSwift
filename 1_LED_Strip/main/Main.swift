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

@_cdecl("app_main")
func app_main() {
  print("Hello from Swift on ESP32-C6!")

  // As a debug workaround with Embedded Swift (9/12/24)
  // You can print floating point numbers in C with printf or using the format(double:) method
  print("PI= \(format(double: 3.14))")
  printFloat(3.14)
  
  // TODO: Adjust by the number of pixels on your LED light strip or matrix
  let n = 256
  let ledStrip = LedStrip(gpioPin: 0, maxLeds: n)
  ledStrip.clear()

  var color: LedStrip.Color = .lightWhite
  var flip = false
  var colors: [LedStrip.Color] = .init(repeating: .off, count: n)
  var counter = 0
  
  let ledPerRow = 16
  let rows = 5

  // Animation loop
  while true {

    // Animate LED rows by removing colors from one side and appending to the other
    colors.removeLast(ledPerRow)
    let newColors: [LedStrip.Color] = .init(repeating: color, count: ledPerRow)
    colors.insert(contentsOf: newColors, at: 0)

    // Update all the colors
    for y: Int in 0 ..< 16 {
      for x in 0 ..< 16 {
        let index = y * 16 + x
        ledStrip.setPixel(index: index, color: colors[index])
      }
    }
    ledStrip.refresh()

    // Alternate color every X rows
    if counter >= rows {
      flip.toggle()
      counter = 0
    }
    if flip {
      color = .lightBlue
    } else {
      color = .lightWhite
    }
    counter += 1

    let blinkDelayMs: UInt32 = 33
    vTaskDelay(blinkDelayMs / (1000 / UInt32(configTICK_RATE_HZ)))
  }
}
