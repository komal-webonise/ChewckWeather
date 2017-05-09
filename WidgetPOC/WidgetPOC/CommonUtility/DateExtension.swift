//
//  DateExtension.swift
//  WidgetPOC
//

import Foundation
import LatLongToTimezone
import CoreLocation

extension Date {
    
    /// Get date as given date format
    ///
    /// - Parameter dateFormat: dateFormat for requirement
    /// - Parameter timeZone: timeZone of dateformat
    /// - Returns: date as string
    func getDateAsString(dateFormat: String = DateFormatters.DATE_FORMAT_DD_MM_YYYY,
                         timeZone: TimeZone? = nil) -> String! {
        
        let dateFormatter = DateFormatter()
        
        if let _ = timeZone {
            dateFormatter.timeZone = timeZone
        }
        
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    /// This method will compose display time to be shown on against notification
    ///
    /// - Parameter receivedDate: notification received date
    /// - Returns: String date to display
    func getTime(withTimeZone: TimeZone) -> String {
        var dateString = ""
        
        if  let dateTime = self.getDateAsString(dateFormat: DateFormatters.DATE_FORMAT_DD_MM_YY_HH_MM_AM_PM,
                                                timeZone: withTimeZone) {
            
            let dateTimeSplits: [String]! = dateTime.components(separatedBy: " ")
            
            if dateTimeSplits.count > 2 {
                
                let time = (dateTimeSplits[1])
                let AM_PM = (dateTimeSplits[2])
                dateString =  time + " " + AM_PM
            }
        }
        
        return dateString
    }
    
    ///This method is dependent on library: LatLongToTimezone, It needs to be added in pod
    /// Get time zone from coordinates
    ///
    /// - Parameters:
    ///   - lattitude: lattitude of coordinates
    ///   - longitude: longitude of coordinates
    /// - Returns: TimeZone as per geo coordinates
    static func getTimeZoneByCoordinate(lattitude: Double, longitude: Double) -> TimeZone {
        let location = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        let timeZone = TimezoneMapper.latLngToTimezone(location)
        
        return timeZone!
    }
    
}
