//
//  CalenderView.swift
//  Coffee！
//
//  Created by Xinyi Hu on 11/5/2025.
//

import SwiftUI

struct CalenderView: View {
    @EnvironmentObject var postStore: PostStore
    @StateObject private var vm = CalendarViewModel()
    
    @State private var selectedDay: DaySelection? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("Background")
                .ignoresSafeArea()
            
            Image("Logo")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(16)
            
            VStack {
                Spacer()
                    .frame(height: 30)
                    .opacity(0)
                
                ///Title One
                Text("CUP BY CUP")
                    .font(.title .bold())
                    .foregroundColor(Color("Font"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ///Scrolling Month
                ScrollView(.horizontal, showsIndicators: false) {
                       LazyHStack(spacing: 16) {
                           ForEach(vm.months.indices, id: \.self) { idx in
                               Text(vm.months[idx])
                                   .font(.title2.bold())
                                   .foregroundColor(
                                       idx == vm.currentMonth ? .brown : Color.brown.opacity(0.6)
                                   )
                                   .padding(.vertical, 8)
                                   .padding(.horizontal, 12)
                                   .background(
                                       idx == vm.currentMonth ? Color.brown.opacity(0.2) : .clear
                                   )
                                   .cornerRadius(6)
                                   .onTapGesture {
                                       withAnimation { vm.currentMonth = idx }
                                   }
                           }
                       }
                       .padding(.horizontal)
                   }
                   .frame(height: 50)
                   .background(Color("Background"))
                   .cornerRadius(8)
                
                Spacer()
                    .frame(height: 30)
                    .opacity(0)
                
                //Days
                HStack {
                    ForEach(vm.weekdaySymbols, id: \.self) { wd in
                        Text(wd)
                            .font(.title3 .bold())
                            .foregroundColor(Color("Font"))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                    .opacity(0)
                
                ///Dates
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7), spacing: 30) {
                    ForEach(vm.daysArray, id: \.self) { day in
                        if day == 0 {
                            Text(" ")
                                .frame(maxWidth: .infinity)
                        } else {
                            let isToday = vm.isToday(day: day)
                            let hasPost = vm.hasPost(on: postStore.posts, day: day)

                            Text("\(day)")
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .fontWeight(isToday ? .bold : .regular)
                                .foregroundColor(isToday ? .brown : Color("Font"))
                                .font(isToday ? .title3 : .callout)
                                .background(
                                    Circle()
                                        .fill(hasPost
                                            ? Color("Green").opacity(0.3)
                                            : Color.clear
                                        )
                                )
                                .cornerRadius(4)
                                .onTapGesture {
                                    selectedDay = DaySelection(day: day)
                                }
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 40)
                    .opacity(0)
            }
            ///Avoid Logo Area
            .padding(.top, 80)
            .padding(.horizontal, 20)
        }
        .sheet(item: $selectedDay) { selection in
                CalenderPopUpView(
                    day: selection.day,
                    month: vm.currentMonth + 1,
                    viewModel: vm
                )
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.visible)
                .environmentObject(postStore)
            }
    }
}


#Preview {
    CalenderView()
        .environmentObject(PostStore())
}
