//
//  Constant.swift
//  BISAD
//
//  Created by Joel Leo on 16/02/23.
//

import Foundation
struct Heights {
    
    static let settingsCellHt = SCREEN_HEIGHT * 0.06
    
    static let contactUsListHt = SCREEN_HEIGHT * 0.035
    static let contactUsHt = SCREEN_HEIGHT * 0.035

    static let bannerHt = SCREEN_HEIGHT * 0.27
    static let socialMediaHt = SCREEN_HEIGHT * 0.1
    
    static let collectionTypeHt = SCREEN_HEIGHT * 0.1

    static let HeaderViewHt = SCREEN_HEIGHT * 0.055
    static let bottomViewHt = SCREEN_HEIGHT * 0.07
    
    static let guidanceImageViewHt = SCREEN_HEIGHT * 0.3

    static let eventHt = SCREEN_HEIGHT * 0.05

    static let timeslotHt = SCREEN_WIDTH / 5

    static let productListHt = SCREEN_HEIGHT * 0.15
    static let lunchBoxBottomViewHt = SCREEN_HEIGHT * 0.1

    static let buttonFontSize: CGFloat = 3.8
    static let listDescriptionFontSize: CGFloat = 3.5

    static let zoomIn: CGFloat = 1.0
    static let zoomOut: CGFloat = 0.01

    static let popupDuration: TimeInterval = 0.2
    static let popupDismiss: Double = 0.3 // this value is based on popupDuration + 0.1

    static let participantHeaderHt: CGFloat = SCREEN_HEIGHT * 0.05

    static let loaderWidth: CGFloat = 0.085
    static let loaderBGColorRatio: CGFloat = 0.6

    static let ptmReviewHt = SCREEN_HEIGHT * 0.225
    static let menuWidth: CGFloat = SCREEN_WIDTH * 0.7
}
struct DefaultValue {
    
    //StudentView
    static let selectStudent = "Select Student"
    static let noStudent = "No Student Available"

    //Force Update
    static let forceUpdateDescription = "There is a newer version available for download! Please update the app by visiting the Apple Store"
    
    //Toast
    static let toastError = "Error!"
    static let toastSuccess = "Success!"
    
    //Login
    static let helpMail = "infoalkhor@nais.qa"
    static let signup = "Sign Up"
    static let maybeLater = "Maybe later"
    static let forgetPassword = "Forget Password"
    static let cancel = "Cancel"
    static let ok = "Ok"
    static let submit = "Submit"
    

    static let alert = "Alert"
    static let confirm = "Confirm"
    static let info = "Info"
    static let noStudents = "No students available.."
    static let success = "Success"
    static let failure = "Failure"

    static let locationAddress = "NAS"

    //For Creating Model class for submenus
    static let comingupWholeSchool = "ComingUp-WholeSchool"
    static let information = "Information"
    static let Newsletters = "Newsletters"
    static let SocialMedia = "Social Media"

    static let newsletterPresentation = "Newsletters & Presentations"
    static let sportsNewsletter = "Sports Newsletters"
    static let performingArts = "Performing Arts"
    static let personalisedLearning = "Personalised Learning"

    //Notification
    static let new = "New"
    static let updated = "Updated"


    //Parents Association
    static let parentsAssociation = "Parents Association"
    static let chatterBoxCafe = "chatterBoxCafe"
    static let classRepresentatives = "class Representatives"
    static let volunteerSignup = "Volunteer Sign Up"


    //Parents Essentials
    static let termsDates = "Term Dates"
    static let uniForm = "Uniform"
    static let boxMenu = "NAS Lunch Box Menu"
    static let busService = "Bus Service"

    //Early Years
    static let comingUp = "Coming Up"
    
    //Absences
    static let select_student = "Select Student"
    static let absenceDesc = "If you need to cancel a registered absence please contact Reception +971 (0)42199999."
    static let ddMMMyyyy = "dd MMM yyyy"
    static let emailAbsence = "For planned absences please email your Head of School "
    
    //Gallery
    static let photos = "Photos"
    static let videos = "Videos"
    
    //Payment
    static let payHere = "Pay Here"
    static let categories = "Categories"
    static let preview = "Preview"
    static let download = "Download"
    static let share = "Share"
    static let print = "Print"
    static let aed = "AED"


    //Lunchbox
    static let preOrder = "Pre Order"
    static let payment = "Payment"
    static let pre_Order = "Pre-Order"
    static let addOrder = "Add Order"
    static let myOrder = "My Order"
    static let orderHistory = "Order History"
    static let delivered = "Delivered"
    static let active = "Active"
    static let cancelled = "Cancelled"
    static let items = "Items"
    static let total = "Total"
    static let viewBasket = "View Basket"
    static let order = "Order"
    static let thankYou = "Thank You!"
    static let submitOrderSuccess = "Cost will be deducted only when item delivered"
    static let cancelOrder = "Do you want to cancel the order?"

    //Early Years
    static let earlyYears = "Early Years"

    //Guidance
    static let guidanceEssential = "Guidance Essential"
    static let guidanceTopics = "University Guidance Topics"
    static let calendar = "Calendar"
    static let guidance_calendar = "Guidance Calendar"
    static let resources = "Resources"
    
    //Wellbeing Inclusion
    static let wellbeingAndInclutionTopics = "Wellbeing & Inclusion"
    static let topics = "Topics"
    
    //Sports
    static let squard = "Squard"
    static let fixtures = "Fixtures"
    static let sports_calendar = "Sports Calendar"
    static let meetPoint = "Meet Point"
    static let meetTime = "Meet Time"
    static let fixtureStart = "Fixture Start"
    static let fixtureEnd = "Fixture End"
    static let arrivalNASDubai = "Arrival NAS Dubai"
    static let notes = "Notes"
    static let attending = "ATTENDING"
    static let notAttending = "NOT ATTENDING"
    static let pickupAtVenue = "Pick Up at Venue"
    static let pickupAtNASDubai = "Pick Up at NAS Dubai"
    static let venue = "VENUE"
    static let addToCalendar = "Add To Calendar"
    static let participants = "Participants"
    static let participationStatusSuccess = "Successfully changed your participation status"
    static let trainingDates = "Training Dates"
    static let eventAddedSuccessfully = "Event Added To Calendar"
    static let eventRemovedSuccessfully = "Event Removed From Calendar"


    //AboutUs
    static let staff_directory = "Staff Directory"
    
    //CCA
    static let cca_summary = "EAP Summary"
    static let cca_options = "EAP Options"
    static let external_providers = "External Providers"
    static let onSubmissionDateOver = "1"
    static let offSubmissionDateNotOver = "0"
    static let isAttendeeNewNotEdited = "0"
//    static let isAttendeeOn = ""
    static let isAttendeeEdit = "1"
    static let none = "None"
    static let choiceSelectionDesc = "Please select a EAP or None for each choice and each day"
    static let next = "Next"
    static let studentYearGroup = "Student Year Group:"
    static let studentName = "Student Name:"
    static let selectEAPChoice = "Select EAP Choice for:"
    static let submitCCADesc = "You are able to make changes until the closing date. After the closing date selections are final"
    static let cca_name = "EAP Name: "
    static let noCCAupcomings = "No upcoming available"

    //Calendar
    static let term_calendar = "Term Calendar"
    static let day = "Day"
    static let month = "Month"
    static let year = "Year"
    static let dismiss = "Dismiss"
    static let joinMeetingHere = "Join Meeting Here"

    //Parents Meeting
    static let select_staff = "Select Staff:-"
    static let student = "Student"
    static let classKey = "Class"
    static let staff = "Staff"
    static let room_details = "Room Details"
    static let room = "Room"
    static let noStaffAvailable = "No staff available"


    static let cancelEarlierSlot = "Another slot is already reserved by you. If you want to take appointment on this time, please cancel earlier appointment and try."
    static let confirmAppointment = "Do you want to confirm your appointment on 15 June 2021, 08:00 AM - 08:30 AM?"
    static let dateOver = "Booking and cancellation date is over"
    static let slotNotAvailable = "This slot is not available."
    static let slotReserved = "This slot is reserved by you for the Parents Evening. Click 'Cancel' option to cancel this appointment."
    static let slotAlreadyConfirmed = "Your time slot is already confirmed."
    static let insertSlotAlert = "Reserved Only - Please review and confirm and booking"
    static let cancelSlotAlert = "Request cancelled successfully"
    static let cancelAppointment = "Do you want to cancel this appointment"
    static let cancelDateIsOver = "Booking and cancellation date is over. Please contact the school"
    static let confirmReviewAppointment = "Do you want to confirm this appointment?"
    static let cancelReviewAppointment = "Do you want to cancel this appointment?"

    static let reviewConfirm = "Review & Confirm"
    static let mayBeLater = "Maybe Later"

    static let reserved_date_time = "Reserved Date & Time"
    static let confirmCancellationClose = "Confirm/Cancellation closes at "
    static let reviewAppointmentSuccess = "Successfully confirmed appointment"

    //Parent Association
    static let cancelRequest = "Do you want to cancel the request?"
    static let cancelRequestSuccess = "Request cancelled successfully"
    static let bookedTimeSlotSuccess = "Your time slot has been booked successfully"

    //Settings
    static let termOfService = "Terms Of Service"
    static let doYouWantLogout = "Do you want to logout?"
    static let guest = "Guest"
    
    //Absence
    static let continu = "Continue"

    //Payment
    static let paymentWalletPaymentModule = "wallet_topup"
    static let paymentFeePaymentModule = "fee_payment"
}

struct ImageName {
    static let pta_tutorial = "tut_pe_"

    //App Icom
    static let app_icon_transparent = "app_icon_transparent"
    static let splash = "splash_image"
    
    //Header
    static let app_title = "app_title-1"
    
    //Toast
    static let toast_success = "toast_success"
    static let toast_failed = "toast_failed"

    //Banner
    static let nas_dubai_banner = "nas_dubai_banner"

    //Tutorial
    static let app_tutorial = "cal_tutorial_"
    static let calendar_tutorial = "cal_tutorial_"
    static let home_tutorial = "cal_tutorial_"

    //Side Menus
    static let aboutus = "aboutus"
    static let absence = "absence"
    static let calendar = "calendars"
    static let ccas = "ccas"
    static let communications = "communication"
    static let contacts = "contacts"
    static let early_years = "early_years"
    static let gallery = "gallery"
    static let home = "home"
    static let ib = "ib"
    static let lunch_box = "lunch_box"
    static let nae_programme = "nae_programme"
    static let notification = "notification"
    static let parent_association = "parent_association"
    static let parent_essentials = "parent_essential"
    static let parent_meeting = "parent_meeting"
    static let payments = "payments"
    static let permission_forms = "permission_forms"
    static let primary = "primary"
    static let reports = "reports"
    static let secondary = "secondary"
    static let university_guidance = "university_guidance"
    static let sports = "sports"
    static let performing_arts = "performing_arts"

    //
    static let menu = "menu"
    static let arrow_left = "arrow_left"

    static let error = "Error"
    static let instagram = "instagram"
    static let facebook = "facebook"
    static let twitter = "twitter"

    static let twitter_logo = "twitter_logo"
    static let instagram_logo = "instagram_logo"
    
    static let questionMark = "question_mark"
    static let nas_logo = "nas_logo"
    static let placeholder_logo = "nas_logo"

    
    //Payment
    static let pay_here = "pay_here"
    static let information = "information"
    static let share_cirlce = "share_circle"
    static let download_circle = "download_circle"
    static let print_circle = "print_circle"

    //Lunchbox
    static let pre_order = "pre_order"
    static let payment = "payment"
    static let add_order = "add_order"
    static let my_order = "my_order"
    static let order_history = "order_history"
    static let no_food = "no_food"
    static let empty_cart = "empty_cart"
    static let no_order_history = "no_order_history"
    static let tick_circle = "greenTickNew"
    static let multiple  = "multiple"

    //Guidance
    static let guidance_essential = "guidance_essential"

    //Sports
    static let squard = "squard"
    static let fixtures = "fixtures"
    static let add_to_calednar = "add_to_calendar"
    static let loation = "placeholder"
    static let fixture_mail = "fixture_mail"

    //Notification
    static let play_button = "play_button"
    static let text_file = "text_file"
    static let radio_waves = "radio_waves"
    static let image_icon = "image_icon"
    static let squad = "squad"

    static let play_button_white = "play_button_white"
    
    //CCA
//    static let cca_options = "cca_options"
    static let external_providers = "external_providers"
    static let approve = "approve"
    static let closed = "closed"
    static let edit_circle = "edit"
    static let approve_circle = "approve_cca"
    static let pending = "pending"
    static let delete = "delete"
    static let cca_attendance = "cca_attendance"

    //Banner
    static let default_banner = "default_banner"

    //
    static let tick = "tick"

    //Parents Association
    
    //
    static let exclamation = "exclamation"

    //Sports
    static let checked = "checked"
    static let unchecked = "unchecked"

    //Parents Meeting
    static let teacher = "teacher_icon"
    static let student = "student_icon"
    static let participate = "participate"
    static let doubt_participate = "doubt_participate"
    static let confirm = "confirm"
    static let time_icon = "time_icon"
    static let seperate_black = "seperate_black"
    static let seperate_white = "seperate_white"

    //Common
    static let next = "next"
    static let info_circle = "info_circle"
    static let edit_pencil = "edit_pencil"
    static let no_data = "no_data"
    
    //Bottom
    static let cca_bottom = "cca_bottom"
    static let cca_options = "cca_options"

    static let new_update_bottom = "new_update_bottom"
    static let pa_bottom = "pa_bottom"
    static let pta_bottom = "pta_bottom"
    static let pta_review = "pta_review"
    //
    static let new_circle = "new_circle"
    static let updated_circle = "updated_circle"

    //Calendar
    static let cal_addType = "add_type_"
    static let cal_minusType = "minus_type_"
}

struct IntValues {
    static let lunchBoxHour = 7
    static let lunchBoxMinute = 30
    static let noneId = 999474037
}

enum FloatValues {
    static let questionTitleHt: CGFloat = 16.0
    static let zoomIn: CGFloat = 1.0
    static let zoomOut: CGFloat = 0.01
}
enum BadgeStatus: Int {
    case new = 0
    case read = 1
    case updated = 2
}
enum TypeOfCell {
    case list, radio, emoji, star, numeric
}

enum TypeOfAction {
    case noneValue, answerNotSelected, someAnswersNotSelected, allAnswerAreSelected
    case continueWithoutAnswer, answerTheQuestion
    case ok, cancel, submit, success, failure, close
    case zoomIn, zoomOut
}

enum TypeOfPage {
    case noneValue, surveyList, homeSurveyPopup, absence, lunchBox
}
