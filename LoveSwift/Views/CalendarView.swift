//
//  CalendarView.swift
//  LoveSwift
//
//  Created by Yugo Sugiyama on 2024/10/22.
//


import SwiftUI

enum CalendarEventType {
    case working, privateEvent, family, publicEvent

    var backgroundColor: Color {
        switch self {
        case .working: return .orange
        case .privateEvent: return .purple
        case .family: return .pink
        case .publicEvent: return .green
        }
    }
}

struct CalendarColumnType {
    let columnCount: Int
    let columnIndex: Int

    static var single: CalendarColumnType {
        CalendarColumnType(columnCount: 1, columnIndex: 0)
    }

    static func multi(columnCount: Int, columnIndex: Int) -> CalendarColumnType {
        CalendarColumnType(columnCount: columnCount, columnIndex: columnIndex)
    }
}

struct CalendarItem: Identifiable {
    let id = UUID()
    let title: String
    let from: Date
    let to: Date
    let zIndex: Double
    let eventType: CalendarEventType
    let columnType: CalendarColumnType

    var widthCoefficient: Double {
        max(0, 1 - (Double(zIndex) / 10.0))
    }

    init(
        title: String,
        from: Date,
        to: Date,
        zIndex: Double,
        eventType: CalendarEventType,
        columnType: CalendarColumnType = .init(columnCount: 1, columnIndex: 0)
    ) {
        self.title = title
        self.from = from
        self.to = to
        self.zIndex = zIndex
        self.eventType = eventType
        self.columnType = columnType
    }
}

struct CalendarLayout: Layout {
    let calendarItems: [CalendarItem]
    static let hourHeight: CGFloat = 60
    static let dayWidth: CGFloat = 30
    static let timeWidth: CGFloat = 60

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return CGSize(width: proposal.width ?? 0, height: CalendarLayout.hourHeight * 24)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, item) in calendarItems.enumerated() {
            let subview = subviews[index]
            let baseWidth = bounds.width * item.widthCoefficient
            let width = baseWidth / CGFloat(item.columnType.columnCount)
            let fromHour = Calendar.current.component(.hour, from: item.from)
            let toHour = Calendar.current.component(.hour, from: item.to)
            let fromMinutes = Calendar.current.component(.minute, from: item.from)
            let toMinutes = Calendar.current.component(.minute, from: item.to)

            let fromY = CGFloat(fromHour) * CalendarLayout.hourHeight + CGFloat(fromMinutes) / 60.0 * CalendarLayout.hourHeight
            let toY = CGFloat(toHour) * CalendarLayout.hourHeight + CGFloat(toMinutes) / 60.0 * CalendarLayout.hourHeight
            let height = toY - fromY

            let xOffset = bounds.width - baseWidth + width * CGFloat(item.columnType.columnIndex)
            subview.place(
                at: CGPoint(x: xOffset, y: fromY),
                proposal: ProposedViewSize(width: width, height: height)
            )
        }
    }
}

struct CalendarView: View {
    let calendarItems: [CalendarItem]
    let leadingDateWidth: CGFloat = 60

    var body: some View {
        ScrollView {
            ZStack() {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<24) { hour in
                        HStack(alignment: .top, spacing: 0) {
                            Text("\(hour):00")
                                .frame(width: CalendarLayout.timeWidth, alignment: .leading)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 1)
                        .frame(height: CalendarLayout.hourHeight, alignment: .top)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                        .padding(.leading, leadingDateWidth)
                }
                CalendarLayout(calendarItems: calendarItems) {
                    ForEach(calendarItems) { item in
                        VStack {
                            Text(item.title)
                                .padding(4)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(item.eventType.backgroundColor)
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .padding(2)  // 外側のパディング
                        }
                        .zIndex(item.zIndex)
                    }
                    .padding(.leading, CalendarLayout.timeWidth)
                }
            }
        }
    }
}

let calendarItems: [CalendarItem] = [
    CalendarItem(
        title: "オフィス出社",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 9))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 18))!,
        zIndex: 0,
        eventType: .family
    ),
    CalendarItem(
        title: "オフィス出社",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 10))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 16))!,
        zIndex: 1,
        eventType: .privateEvent
    ),
    CalendarItem(
        title: "Daily Meeting",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 13, minute: 30))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 14))!,
        zIndex: 2,
        eventType: .working
    ),
    CalendarItem(
        title: "エンジニア勉強会",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 14, minute: 30))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 15, minute: 30))!,
        zIndex: 2,
        eventType: .working
    ),
    CalendarItem(
        title: "会社のイベント",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 15))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 16))!,
        zIndex: 3,
        eventType: .working
    ),
    CalendarItem(
        title: "Daily Meeting",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 16))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 16, minute: 30))!,
        zIndex: 1,
        eventType: .working
    ),
    CalendarItem(
        title: "Daily Meeting",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 16, minute: 30))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 17))!,
        zIndex: 1,
        eventType: .working
    ),
    CalendarItem(
        title: "デザイン定例",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 17))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 17, minute: 30))!,
        zIndex: 1,
        eventType: .working
    ),
    CalendarItem(
        title: "Swift愛好会移動",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 18, minute: 30))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 19))!,
        zIndex: 0,
        eventType: .privateEvent
    ),
    CalendarItem(
        title: "Swift愛好会",
        from: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 19))!,
        to: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20, hour: 22))!,
        zIndex: 0,
        eventType: .privateEvent
    ),
]

#Preview {
    CalendarView(calendarItems: calendarItems)
        .padding()
}
