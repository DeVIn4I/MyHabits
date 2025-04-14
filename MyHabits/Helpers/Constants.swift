//
//  Constants.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import Foundation

enum Constants {
    
    enum Image {
        enum TabBar {
            static let habits = "habits_tab_icon"
            static let info = "info.circle.fill"
        }
    }
    
    enum Text {
        
        enum TabBarTitle {
            static let habits = "Привычки"
            static let info = "Информация"
        }
        
        enum Habits {
            static let emptyHabitsList = "Нет отслеживаемых привычек.\nНажмите \"+\" для создания"
            static let title = "Сегодня"
            static let progressTitle = "Всё получится!"
        }
        
        enum CreateOrEditHabit {
            static let createTitle = "Создать"
            static let editTitle = "Править"
            static let leftBarButton = "Отменить"
            static let rightBarButton = "Сохранить"
            static let habitTitle = "НАЗВАНИЕ"
            static let habitPlaceholder = "Бегать по утрам, спать 8 часов и т.п."
            static let habitColorTitle = "ЦВЕТ"
            static let habitTimeTitle = "ВРЕМЯ"
        }
        
        enum DetailsHabit {
            static let rightBarButton = "Править"
            static let titleForHeader = "АКТИВНОСТЬ"
        }
        
        enum Info {
            static let title = "Информация"
            static let infoTextHeader = "Привычка за 21 день"
            static let infoText = """
            \n
            Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

            1. Провести 1 день без обращения
            к старым привычкам, стараться вести себя так, как будто цель, загаданная
            в перспективу, находится на расстоянии шага.

            2. Выдержать 2 дня в прежнем состоянии самоконтроля.

            3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
            с чем еще предстоит серьезно бороться.

            4. Поздравить себя с прохождением первого серьезного порога в 21 день. 
            За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

            5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

            6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
            """
        }
        
        
    }
}
