//
//  ToDoAddView.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 24/04/25.
//

import SwiftUI

public struct ToDoAddView: View {
    
    //Bring the view model from the environment
    @EnvironmentObject var viewModel: ToDoViewModel
    
    //Bring the showed state from the parent view
    // and use it to show the modal
    @Binding var showed: Bool
    
    /*
        Noify the view when any variable changes
        And use it to show the modal with the proper data
     */
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var date: Date = Date()
    
    public var toDo: ToDoEntity? = nil
    
    /*
        The date range is set to the current date
        and 10 years in the future. This is done to
        limit the date picker to a specific range.
     */
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startDate = Date.now
        let endDate = calendar.date(
            byAdding: .year,
            value: 10,
            to: startDate
        ) ?? startDate
        return startDate...endDate
    }()
    
    var isSavedDisabled: Bool {
        !viewModel.validateInput(ofText: title)
    }
            
    /*
        The body of the view is a VStack with a
        spacing of 16. It contains a ToDoTextInput
        for the title and note, a DatePicker for
        the date, and a button to save the task.
     */
    public var body: some View {
        
        VStack(spacing: 16) {
            VStack(spacing: 30) {
                ToDoTextInput(
                    "Write a title for this task",
                    text: $title,
                    label: "Title"
                )
                ToDoTextInput(
                    "Note description",
                    text: $note,
                    label: "Note"
                )
                DatePicker(
                    selection: $date,
                    in: dateRange
                ){
                    Text("Date")
                        .font(.title3)
                }
                .tint(Color.primary)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)

            
            Button {
                /*
                    Evaluate if the toDo is nil
                    if it is nil, create a new ToDoEntity
                    else update the existing ToDoEntity
                 */
                if toDo != nil {
                    // Update the ToDoEntity
                    viewModel.updateToDo(toDo!, withNewTitle: title, withNewNote: note, withNewDate: date)
                } else {
                    // Create a new ToDoEntity
                    viewModel.addToDo(
                        title: title,
                        note: note,
                        date: date
                    )
                }
                showed.toggle()
                
            }
            label: {
                Text("Guardar".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isSavedDisabled ? Color.gray : Color.black)
                    .cornerRadius(10)
                    .padding(20)
            }
            .disabled(isSavedDisabled)
                
            
        }
        .onAppear {
            if let toDo = toDo {
                title = toDo.title ?? ""
                note = toDo.note ?? ""
                date = toDo.date ?? Date()
            }
        }
        .background(.thinMaterial)
    }
}

#Preview {
    NavigationView {
        ToDoAddView(showed: .constant(true))
        .environmentObject(ToDoViewModel())
    }
}
