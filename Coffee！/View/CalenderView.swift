//
//  CalenderView.swift
//  Coffee！
//
//  Created by Xinyi Hu on 11/5/2025.
//

import SwiftUI

struct CalenderView: View {
    @StateObject private var vm = CalendarViewModel()
    
    @State private var selectedDay: Int? = nil
    @State private var isShowingEntry = false
    
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
                    .frame(height: 20)
                    .opacity(0)
                
                ///Title One
                Text("CUP BY CUP")
                    .font(.title .bold())
                    .foregroundColor(Color.black.opacity(0.7))
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
                    .frame(height: 20)
                    .opacity(0)
                
                //Days
                HStack {
                    ForEach(vm.weekdaySymbols, id: \.self) { wd in
                        Text(wd)
                            .font(.title3)
                            .foregroundColor(Color.black.opacity(0.7))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                ///Dates
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
                                    day == Calendar.current.component(.day, from: Date()) &&
                                    vm.currentMonth == Calendar.current.component(.month, from: Date()) - 1
                                    ? Color.brown.opacity(0.3)
                                    : Color.clear
                                )
                                .cornerRadius(4)
                                ///Click on date
                                .onTapGesture {
                                    selectedDay = day
                                    isShowingEntry = true
                                }
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 40)
                    .opacity(0)
                
                ///Title Two
                Text("LAST CUP")
                    .font(.title .bold())
                    .foregroundColor(Color.black.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            ///Avoid Logo Area
            .padding(.top, 80)
            .padding(.horizontal, 20)
        }
        .sheet(isPresented: $isShowingEntry) {
            if let day = selectedDay {
                EntryDetailView(
                    day: day,
                    month: vm.currentMonth + 1,
                    viewModel: vm
                )
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

struct EntryDetailView: View {
    let day: Int
    let month: Int
    @ObservedObject var viewModel: CalendarViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()

                Form {
                    Section(header: Text("Log for \(month)/\(day)")) {
                        // ImagePicker、类型 Picker、TextField、评分控件…
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Your Entry")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.brown)
                    }
                }
            }
        }
    }
}

#Preview {
    CalenderView()
}
