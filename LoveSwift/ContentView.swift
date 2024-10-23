//
//  ContentView.swift
//  LoveSwift
//
//  Created by Yugo Sugiyama on 2024/10/22.
//

import SwiftUI

enum PageType: String, CaseIterable, Identifiable {
    var id: String {
        return rawValue
    }

    case circle
    case hStack
    case piano
    case calendar
    case circleAnimation

    @ViewBuilder
    var view: some View {
        switch self {
        case .circle:
            CircleMusicNoteView(
                radius: 170,
                musicNoteInfos: []
            )
        case .hStack:
            VStack {
                HStack(spacing: 30) {
                    Text("Hello")
                        .padding()
                        .background(Color.red)
                    Text("World")
                        .padding()
                        .background(Color.blue)
                    Text("!")
                        .padding()
                        .background(Color.green)
                }
                .padding()
                Color.white
                    .frame(height: 4)
                CustomHStack(spacing: 30) {
                    Text("Hello")
                        .padding()
                        .background(Color.red)
                    Text("World")
                        .padding()
                        .background(Color.blue)
                    Text("!")
                        .padding()
                        .background(Color.green)
                }
                .padding()
            }
            .background(.black)
        case .piano:
            PianoView()
                .frame(height: 200)
        case .calendar:
            CalendarView(calendarItems: calendarItems)
        case .circleAnimation:
            CircleMusicAnimatedNoteView(
                radius: 170,
                keyStrokes: KeyTemplate.allKeyTypes
            )
                .frame(width: 500, height: 500)
                .background(.black)
        }
    }

    var title: String {
        switch self {
        case .circle: return "Circle"
        case .hStack: return "HStack"
        case .piano: return "PianoView"
        case .calendar: return "CalendarView"
        case .circleAnimation: return "CircleAnimationView"
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Layout Protocol Views")) {
                    ForEach(PageType.allCases) { type in
                        NavigationLink(
                            destination: type.view,
                        label: {
                            Text(type.title)
                        })
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("LoveSwift")
        }

    }
}

#Preview {
    ContentView()
}
