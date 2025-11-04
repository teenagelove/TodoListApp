//
//  Constants.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

enum Constants {
    enum SFSymbol {
        static let circle = "circle"
        static let checkmarkedCircle = "checkmark.circle"
        static let pencil = "square.and.pencil"
        static let chevronLeft  = "chevron.left"
        static let clockwise = "arrow.clockwise"
        static let triangle = "exclamationmark.triangle.fill"
    }

    enum String {
        static let repeatString = "Повторить"
        static let backString = "Назад"
        static let nameString = "Название"
        static let descriptionString = "Описание"
        static let emptyString = "Список задач пуст"
        static let emptySearchString = "Ничего не найдено"
        static let deleteString = "Удалить"
        static let editString = "Редактировать"
        static let shareString = "Поделиться"
        static let tasksString = "Задачи"
        static let countTasksString = "задач"
        static let searchPlaceholder = "Поиск"
        static let errorTitleString = "Ошибка"
        static let errorDescriptionString = "Не удалось загрузить данные. Пожалуйста, попробуйте еще раз."
        static let okString = "ОК"
        static let cancelString = "Отмена"
    }

    enum API {
        static let baseURL = "https://dummyjson.com/todos"
    }
}
