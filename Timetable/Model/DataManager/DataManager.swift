//
//  DataManager.swift
//  Timetable
//
//  Created by art-off on 01.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    
    // загруженные данные
    private let downloadedRealm: Realm
    // данные пользователя
    private let userRealm: Realm
    
    init() {
        
        let fileManager = FileManager.default
        
        // создаем дирректорию для приложения в Documents
        let sibsuURL = try! fileManager
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("sibsu")
        
        if !fileManager.fileExists(atPath: sibsuURL.path) {
            do {
                try fileManager.createDirectory(at: sibsuURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                NSLog("Не выходит создать папку в Document директории")
            }
        }
        
        let downloadedURL = sibsuURL.appendingPathComponent("sibsu-downloaded.realm")
        let userURL = sibsuURL.appendingPathComponent("sibsu-user.realm")
        
        let downloadedConfig = Realm.Configuration(fileURL: downloadedURL)
        let userConfig = Realm.Configuration(fileURL: userURL)
        
        downloadedRealm = try! Realm(configuration: downloadedConfig)
        userRealm = try! Realm(configuration: userConfig)
        
        print(downloadedURL)
        print(userURL)
    }
    
    // MARK: Словарь для перевода type, которых хранится в БД (Int) в обычный вид, для работы в приложении
    // Испльзуется в расширении для перевода табличных классво в структуры, с которыми работаю в самом приложенииы
    private let typeConvert = [
        0: "(Лекция)",
        1: "(Практика)",
        2: "(Лабораторная работа)",
    ]
    
}

// MARK: - Getting Entities
extension DataManager: GettingEntities {
    
    func getProfessors() -> Results<RProfessor> {
        let professors = downloadedRealm.objects(RProfessor.self)
        return professors
    }
    
    func getGroups() -> Results<RGroup> {
        let groups = downloadedRealm.objects(RGroup.self)
        return groups
    }
    
    func getPlaces() -> Results<RPlace> {
        let places = downloadedRealm.objects(RPlace.self)
        return places
    }
    
    func getFavoriteProfessors() -> Results<RProfessor> {
        let professors = userRealm.objects(RProfessor.self)
        return professors
    }
    
    func getFavoriteGruops() -> Results<RGroup> {
        let groups = userRealm.objects(RGroup.self)
        return groups
    }
    
    func getFavoritePlaces() -> Results<RPlace> {
        let places = userRealm.objects(RPlace.self)
        return places
    }
    
    func getGroup(withId id: Int) -> RGroup? {
        let group = downloadedRealm.object(ofType: RGroup.self, forPrimaryKey: 1)
        //let groups = realmCaches.objects(RGroup.self).filter("id = \(id)")
        //guard let group = groups.first else { return nil }
        return group
    }
    
    func getProfessor(withId id: Int) -> RProfessor? {
        let professor = downloadedRealm.object(ofType: RProfessor.self, forPrimaryKey: id)
        //let professors = realmCaches.objects(RProfessor.self).filter("id = \(id)")
        //guard let professor = professors.first else { return nil }
        return professor
    }
    
    func getPlace(withId id: Int) -> RPlace? {
        let place = downloadedRealm.object(ofType: RPlace.self, forPrimaryKey: id)
        //let places = realmCaches.objects(RPlace.self).filter("id = \(id)")
        //guard let place = places.first else { return nil }
        return place
    }
    
}

// MARK: - Writing Entities
extension DataManager: WritingEntities {
    
    func writeFavorite(groups: [RGroup]) {
        // Если эти объекты уже будут в одном из хранилищь - так мы обезопасим себя от ошибки
        let copyGroups = groups.map { $0.newObject() }
        try? userRealm.write {
            userRealm.add(copyGroups, update: .modified)
        }
    }
    
    func writeFavorite(group: RGroup) {
        let copyGroup = group.newObject()
        try? userRealm.write {
            userRealm.add(copyGroup, update: .modified)
        }
    }
    
    func writeFavorite(professors: [RProfessor]) {
        let copyProfessors = professors.map { $0.newObject() }
        try? userRealm.write {
            userRealm.add(copyProfessors, update: .modified)
        }
    }
    
    func writeFavorite(professor: RProfessor) {
        let copyProfessor = professor.newObject()
        try? userRealm.write {
            userRealm.add(copyProfessor, update: .modified)
        }
    }
    
    func writeFavorite(places: [RPlace]) {
        let copyPlaces = places.map { $0.newObject() }
        try? userRealm.write {
            userRealm.add(copyPlaces, update: .modified)
        }
    }
    
    func writeFavorite(place: RPlace) {
        let copyPlace = place.newObject()
        try? userRealm.write {
            userRealm.add(copyPlace, update: .modified)
        }
    }
    
    func write(groups: [RGroup]) {
        let copyGroups = groups.map { $0.newObject() }
        try? downloadedRealm.write {
            downloadedRealm.add(copyGroups, update: .modified)
        }
    }
    
    func write(group: RGroup) {
        let copyGroup = group.newObject()
        try? downloadedRealm.write {
            downloadedRealm.add(copyGroup, update: .modified)
        }
    }
    
    func write(professors: [RProfessor]) {
        let copyProfessors = professors.map { $0.newObject() }
        try? downloadedRealm.write {
            downloadedRealm.add(copyProfessors, update: .modified)
        }
    }
    
    func write(professor: RProfessor) {
        let copyProfessor = professor.newObject()
        try? downloadedRealm.write {
            downloadedRealm.add(copyProfessor, update: .modified)
        }
    }
    
    func write(places: [RPlace]) {
        let copyPlaces = places.map { $0.newObject() }
        try? downloadedRealm.write {
            downloadedRealm.add(copyPlaces, update: .modified)
        }
    }
    
    func write(place: RPlace) {
        let copyPlace = place.newObject()
        try? downloadedRealm.write {
            downloadedRealm.add(copyPlace, update: .modified)
        }
    }

}

// MARK: - Deleting Entities
extension DataManager: DeletingEntities {
    
    func deleteFavorite(groups: [RGroup]) {
        try? userRealm.write {
            userRealm.delete(groups)
        }
    }
    
    func deleteFavorite(group: RGroup) {
        try? userRealm.write {
            userRealm.delete(group)
        }
    }
    
    func deleteFavorite(professors: [RProfessor]) {
        try? userRealm.write {
            userRealm.delete(professors)
        }
    }
    
    func deleteFavorite(professor: RProfessor) {
        try? userRealm.write {
            userRealm.delete(professor)
        }
    }
    
    func deleteFavorite(places: [RPlace]) {
        try? userRealm.write {
            userRealm.delete(places)
        }
    }
    
    func deleteFavorite(place: RPlace) {
        try? userRealm.write {
            userRealm.delete(place)
        }
    }
    
    func delete(groups: [RGroup]) {
        try? userRealm.write {
            userRealm.delete(groups)
        }
    }
    
    func delete(group: RGroup) {
        try? userRealm.write {
            userRealm.delete(group)
        }
    }
    
    func delete(professors: [RProfessor]) {
        try? userRealm.write {
            userRealm.delete(professors)
        }
    }
    
    func delete(professor: RProfessor) {
        try? userRealm.write {
            userRealm.delete(professor)
        }
    }
    
    func delete(places: [RPlace]) {
        try? userRealm.write {
            userRealm.delete(places)
        }
    }
    
    func delete(place: RPlace) {
        try? userRealm.write {
            userRealm.delete(place)
        }
    }
    
}

// MARK: - Getting Timetable
extension DataManager: GettingTimetable {
    
    func getTimetable(forGroupId groupId: Int) -> GroupTimetable? {
        let optionalTimetable = userRealm.object(ofType: RGroupTimetable.self, forPrimaryKey: groupId)
        let optionalGroup = downloadedRealm.object(ofType: RGroup.self, forPrimaryKey: groupId)
        guard let timetable = optionalTimetable else { return nil }
        guard let group = optionalGroup else { return nil }
        
        let groupTimetable = convertGroupTimetable(from: timetable, groupName: group.name)
        
        return groupTimetable
    }
    
    func getTimetable(forProfessorId professorId: Int) -> ProfessorTimetable? {
        let optionalTimetable = userRealm.object(ofType: RProfessorTimetable.self, forPrimaryKey: professorId)
        let optionalProfessor = downloadedRealm.object(ofType: RProfessor.self, forPrimaryKey: professorId)
        guard let timetable = optionalTimetable else { return nil }
        guard let professor = optionalProfessor else { return nil }
        
        let profesorTimetable = convertProfessorTimetable(from: timetable, professorName: professor.name)
        
        return profesorTimetable
    }
    
    func getTimetable(forPlaceId placeId: Int) -> PlaceTimetable? {
        let optionalTimetable = userRealm.object(ofType: RPlaceTimetable.self, forPrimaryKey: placeId)
        let optionalPlace = downloadedRealm.object(ofType: RPlace.self, forPrimaryKey: placeId)
        guard let timetable = optionalTimetable else { return nil }
        guard let place = optionalPlace else { return nil }
        
        let placeTimetable = convertPlaceTimetable(from: timetable, placeName: place.name)
        
        return placeTimetable
    }
    
}

// MARK: - Writing Timetable
extension DataManager: WritingTimetable {
    
    func write(groupTimetable: RGroupTimetable) {
        try? userRealm.write {
            userRealm.add(groupTimetable, update: .modified)
        }
    }
    
    func write(professorTimetable: RProfessorTimetable) {
        try? userRealm.write {
            userRealm.add(professorTimetable, update: .modified)
        }
    }
    
    func write(placeTimetable: RPlaceTimetable) {
        try? userRealm.write {
            userRealm.add(placeTimetable, update: .modified)
        }
    }
    
}

// MARK: - Для перевода данных из классов Realm к структурам, используемых в приложении
extension DataManager {
    
    

    // MARK: Перевод объекта РАСПИСАНИЯ ГРУППЫ Realm к структуре, используемой в приложении
    private func convertGroupTimetable(from timetable: RGroupTimetable, groupName: String) -> GroupTimetable {
        var groupWeeks = [GroupWeek]()

        // пробегаемся по всем неделям (по дву)
        for week in timetable.weeks {

            // заполняем массив дней nil, потом если будут учебные дни в этой недели - заменю значение
            var groupDays: [GroupDay?] = [nil, nil, nil, nil, nil, nil]

            // пробегаемся во всем дням недели
            for day in week.days {

                var groupLessons = [GroupLesson]()
                
                // пробегаемся по всем занятиям дня
                for lesson in day.lessons {

                    var groupSubgroups = [GroupSubgroup]()
                    
                    // пробегаемся по всех подргуппам занятия
                    for subgroup in lesson.subgroups {

                        var professorsName = [String]()
                        // берем имя преподавателя из БД с помощью id
                        for id in subgroup.professors {
                            let optionalProfessor = getProfessor(withId: id)
                            if let professor = optionalProfessor {
                                professorsName.append(professor.name)
                            } else {
                                professorsName.append("Необознанный")
                            }
                        }
                        
                        let optionalPlace = getPlace(withId: subgroup.place)
                        let placeName: String
                        if let place = optionalPlace {
                            placeName = place.name
                        } else {
                            placeName = "Неопознанное"
                        }
                        
                        // копируем подргуппу
                        let groupSubgroup = GroupSubgroup(
                            number: subgroup.number,
                            subject: subgroup.subject,
                            type: typeConvert[subgroup.type] ?? "(Неопознанный)",
                            professors: professorsName,
                            professorsId: Array(subgroup.professors),
                            place: placeName,
                            placeId: subgroup.place)

                        groupSubgroups.append(groupSubgroup)
                    }
                    
                    // добавляем занятие в массив занятий
                    let groupLesson = GroupLesson(time: lesson.time, subgroups: groupSubgroups)
                    groupLessons.append(groupLesson)
                }
                
                let groupDay = GroupDay(lessons: groupLessons)
                // проверяем, подходит ли number для вставки в массив groupDays (0-понедельник, 5-суббота)
                if day.number >= 0 && day.number <= 5 {
                    // заменяем nil
                    groupDays[day.number] = groupDay
                }
            }

            let groupWeek = GroupWeek(days: groupDays)
            groupWeeks.append(groupWeek)
        }

        let groupTimetable = GroupTimetable(groupId: timetable.groupId, groupName: groupName, weeks: groupWeeks)
        return groupTimetable
    }
    
    // MARK: Перевод объекта РАСПИСАНИЯ ПРОФЕССОРА Realm к структуре, используемой в приложении
    private func convertProfessorTimetable(from timetable: RProfessorTimetable, professorName: String) -> ProfessorTimetable {
        var professorWeeks = [ProfessorWeek]()

        // пробегаемся по всем неделям (по дву)
        for week in timetable.weeks {

            // заполняем массив дней nil, потом если будут учебные дни в этой недели - заменю значение
            var professorDays: [ProfessorDay?] = [nil, nil, nil, nil, nil, nil]

            // пробегаемся во всем дням недели
            for day in week.days {

                var professorLessons = [ProfessorLesson]()
                
                // пробегаемся по всем занятиям дня
                for lesson in day.lessons {

                    var professorSubgroups = [ProfessorSubgroup]()
                    
                    // пробегаемся по всех подргуппам занятия
                    for subgroup in lesson.subgroups {

                        var groupsName = [String]()
                        // берем имя преподавателя из БД с помощью id
                        for id in subgroup.groups {
                            let group = getProfessor(withId: id)
                            if let group = group {
                                groupsName.append(group.name)
                            } else {
                                groupsName.append("Ошибка")
                            }
                        }
                        
                        let optionalPlace = getPlace(withId: subgroup.place)
                        let placeName: String
                        if let place = optionalPlace {
                            placeName = place.name
                        } else {
                            placeName = "Неопознанное"
                        }
                        
                        // копируем подргуппу
                        let professorSubgroup = ProfessorSubgroup(
                            number: subgroup.number,
                            subject: subgroup.subject,
                            type: typeConvert[subgroup.type] ?? "(Неопознанный)",
                            groups: groupsName,
                            groupsId: Array(subgroup.groups),
                            place: placeName,
                            placeId: subgroup.place)

                        professorSubgroups.append(professorSubgroup)
                    }
                    
                    // добавляем занятие в массив занятий
                    let professorLesson = ProfessorLesson(time: lesson.time, subgroups: professorSubgroups)
                    professorLessons.append(professorLesson)
                }
                
                let professorDay = ProfessorDay(lessons: professorLessons)
                // проверяем, подходит ли number для вставки в массив groupDays (0-понедельник, 5-суббота)
                if day.number >= 0 && day.number <= 5 {
                    // заменяем nil
                    professorDays[day.number] = professorDay
                }
            }

            let professorWeek = ProfessorWeek(days: professorDays)
            professorWeeks.append(professorWeek)
        }

        let professorTimetable = ProfessorTimetable(professorId: timetable.professorId, professorName: professorName, weeks: professorWeeks)
        return professorTimetable
    }
    
    
    // MARK: Перевод объекта РАСПИСАНИЯ КАБИНЕТА Realm к структуре, используемой в приложении
    private func convertPlaceTimetable(from timetable: RPlaceTimetable, placeName: String) -> PlaceTimetable {
        var placeWeeks = [PlaceWeek]()

        // пробегаемся по всем неделям (по дву)
        for week in timetable.weeks {

            // заполняем массив дней nil, потом если будут учебные дни в этой недели - заменю значение
            var placeDays: [PlaceDay?] = [nil, nil, nil, nil, nil, nil]

            // пробегаемся во всем дням недели
            for day in week.days {

                var placeLessons = [PlaceLesson]()
                
                // пробегаемся по всем занятиям дня
                for lesson in day.lessons {

                    var placeSubgroups = [PlaceSubgroup]()
                    
                    // пробегаемся по всех подргуппам занятия
                    for subgroup in lesson.subgroups {

                        var groupsName = [String]()
                        // берем имя преподавателя из БД с помощью id
                        for id in subgroup.groups {
                            let group = getPlace(withId: id)
                            if let group = group {
                                groupsName.append(group.name)
                            } else {
                                groupsName.append("Ошибка")
                            }
                        }
                        
                        var professorsName = [String]()
                        // берем имя преподаватели из БД с помощью id
                        for id in subgroup.professors {
                            let professor = getProfessor(withId: id)
                            if let professor = professor {
                                professorsName.append(professor.name)
                            } else {
                                professorsName.append("Ошибка")
                            }
                        }
                        
                        let placeSubgroup = PlaceSubgroup(
                            number: subgroup.number,
                            subject: subgroup.subject,
                            type: typeConvert[subgroup.type] ?? "(Неопознанный)",
                            groups: groupsName,
                            groupsId: Array(subgroup.groups),
                            professors: professorsName,
                            professorsId: Array(subgroup.professors))

                        placeSubgroups.append(placeSubgroup)
                    }
                    
                    // добавляем занятие в массив занятий
                    let placeLesson = PlaceLesson(time: lesson.time, subgroups: placeSubgroups)
                    placeLessons.append(placeLesson)
                }
                
                let placeDay = PlaceDay(lessons: placeLessons)
                // проверяем, подходит ли number для вставки в массив groupDays (0-понедельник, 5-суббота)
                if day.number >= 0 && day.number <= 5 {
                    // заменяем nil
                    placeDays[day.number] = placeDay
                }
            }

            let placeWeek = PlaceWeek(days: placeDays)
            placeWeeks.append(placeWeek)
        }

        let placeTimetable = PlaceTimetable(placeId: timetable.placeId, placeName: placeName, weeks: placeWeeks)
        return placeTimetable
    }
    
    
}
