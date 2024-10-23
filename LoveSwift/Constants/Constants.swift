//
//  Constants.swift
//  LoveSwift
//
//  Created by Yugo Sugiyama on 2024/10/24.
//

import SwiftUI
import PianoUICore

public enum KeyTemplate {
    public static let openingKeyStrokes: [[PianoKeyStroke]] = [
        [.init(key: .init(keyType: .c, octave: .fifth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .aSharp, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .g, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .c, octave: .fifth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .f, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .c, octave: .fifth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .aSharp, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .c, octave: .fifth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .f, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .g, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .g, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
         [.init(key: .init(keyType: .aSharp, octave: .fourth), velocity: 100, timestampNanoSecond: .now)],
        [.init(key: .init(keyType: .c, octave: .fifth), velocity: 100, timestampNanoSecond: .now)],
    ]

    public static let allKeyTypes: [[PianoKeyStroke]] = KeyType.allCases
        .map { [PianoKeyStroke(key: .init(keyType: $0, octave: .fourth), velocity: 100, timestampNanoSecond: .now)] }
}
