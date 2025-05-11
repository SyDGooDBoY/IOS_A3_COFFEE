//
//  CalenderView.swift
//  Coffee！
//
//  Created by Xinyi Hu on 11/5/2025.
//

import SwiftUI

struct CalenderView: View {
    @StateObject private var vm = CalendarViewModel()
    
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
                //Title One
                Text("CUP BY CUP")
                    .font(.title .bold())
                    .foregroundColor(Color.black.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                //Scrolling Month
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(vm.months.indices, id: \.self) { idx in
                            Text(vm.months[idx])
                                .font(.title2 .bold())
                                .foregroundColor(
                                    idx == vm.currentMonth
                                        ? Color.brown
                                        : Color.brown.opacity(0.6)
                                )
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(
                                    idx == vm.currentMonth
                                        ? Color.brown.opacity(0.2)
                                        : Color.clear
                                )
                                .cornerRadius(6)
                                .onTapGesture {
                                    withAnimation { vm.currentMonth = idx }
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                }
                .frame(height: 50)
                .background(Color("background"))
                .cornerRadius(8)
                
                Spacer()
                    .frame(height: 20)
                    .opacity(0)
                
                //Days
                HStack {
                    ForEach(vm.weekdaySymbols, id: \.self) { wd in
                        Text(wd)
                            .font(.title3)
                            .foregroundColor(.black.opacity(0.7))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                //Dates
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7), spacing: 12) {
                    ForEach(vm.daysArray, id: \.self) { day in
                        if day == 0 {
                            Text(" ")
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("\(day)")
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(
                                    //Highlight Today
                                    day == Calendar.current.component(.day, from: Date()) &&
                                    vm.currentMonth == Calendar.current.component(.month, from: Date()) - 1
                                        ? Color.brown.opacity(0.3)
                                        : Color.clear
                                )
                                .cornerRadius(4)
                        }
                    }
                }

                Spacer()
                
                //Title Two
                Text("LAST CUP")
                    .font(.title .bold())
                    .foregroundColor(Color.black.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            //Avoid Logo Area
            .padding(.top, 80)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CalenderView()
}
