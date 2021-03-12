//
//  WDMDailySurveyMainViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import UIKit
import CareKit
import ResearchKit

class WDMDailySurveyMainViewController: WDMSimpleViewController {

  // MARK: Properties
  
  private var dailySurveyViewController = ORKTaskViewController(task: WDMDailySurveyManager.sharedInstance.getDailySurvey(), taskRun: UUID())
  private var completedSurveyViewController = WDMDailySurveyCompletedChildViewController(nibName: nil, bundle: nil)
  private var editBtnItem: WDMSimpleBarButtomItem!
  
  private let startSurveyBtn: WDMSimpleButton = {
    let btn = WDMSimpleButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("Start Survey", for: .normal)
    btn.clipsToBounds = true
    btn.backgroundColor = Colors.mainColor.color
    btn.layer.cornerRadius = 12
    return btn
  }()
  
  private var refreshViewTimer: Timer?
  
  // MARK: Initializers
  
  // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkSurveyAvailability()
  }
  
  // MARK: Methods
  
  override func initialSetup() {
    super.initialSetup()
    
    title = "DAILY_SURVEY".localize()
    dailySurveyViewController.delegate = self
    
    view.addSubview(startSurveyBtn)
    
    NSLayoutConstraint.activate([
      startSurveyBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      startSurveyBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startSurveyBtn.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      startSurveyBtn.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      startSurveyBtn.heightAnchor.constraint(equalToConstant: 44)
    ])
    
    startSurveyBtn.addTarget(self, action: #selector(startSurveyBtnTapped), for: .touchUpInside)
  }

  @objc private func editBarButtonTapped() {
    navigationController?.present(WDMDailySurveyEditViewController(), animated: true)
  }
  
  @objc private func startSurveyBtnTapped() {
    let dailySteps = WDMDailySurveyManager.sharedInstance.getDailySurvey()
    if dailySteps.steps.count > 0 {
      createDailySurveyVC()
      navigationController?.present(dailySurveyViewController, animated: true)
    } else {
        showAlertForEmptySteps()
      }
  }
  
  private func createDailySurveyVC() {
      dailySurveyViewController = ORKTaskViewController(task: WDMDailySurveyManager.sharedInstance.getDailySurvey(), taskRun: UUID())
      dailySurveyViewController.delegate = self
  }
  
  private func showAlertForEmptySteps() {
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: "UNABLE_TO_LOAD_SURVEY".localize(), message: "YOU_HAVE_NO_QUESTIONS_SELECTED_FOR_THE_SURVEY_.\n\nGO_TO_SETTINGS->DAILY_SURVEY_QUESTIONS_AND_TURN_ON_AT_LEAST_ONE_QUESTION_.".localize(), preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "OK".localize(), style: .cancel)
      alertController.addAction(okAction)
      self.navigationController?.present(alertController, animated: true)
    }
  }
  
  private func checkSurveyAvailability() {
    if let lastSurveyDate = UserPreference.sharedUserPreferences.getDate(for: DAILY_SURVEY_DATE_KEY) {
      if Calendar.current.isDateInToday(lastSurveyDate) {
        add(completedSurveyViewController)
        startSurveyBtn.isHidden = true
        if refreshViewTimer == nil {
          scheduleTimer()
        }
        return
      }
    }
    
    destroyTimer()
    completedSurveyViewController.remove()
    startSurveyBtn.isHidden = false
  }
  
  private func scheduleTimer() {
    let now = Date()
    let startOfTomorrow = Calendar.current.startOfDay(for: now.tomorrow())
    refreshViewTimer = Timer.scheduledTimer(withTimeInterval: startOfTomorrow.timeIntervalSince1970 - now.timeIntervalSince1970, repeats: false, block: { [unowned self] _ in
      self.checkSurveyAvailability()
      destroyTimer()
    })
  }
  
  private func destroyTimer() {
    refreshViewTimer?.invalidate()
    refreshViewTimer = nil
  }

}

// MARK: ORKTaskViewControllerDelegate
extension WDMDailySurveyMainViewController: ORKTaskViewControllerDelegate {
  
  // MARK: Methods
  
  func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    
    defer {
      taskViewController.dismiss(animated: true)
    }
    
    if reason == .completed {
      UserPreference.sharedUserPreferences.setSystemPreferences(for: DAILY_SURVEY_DATE_KEY, with: Date())
      checkSurveyAvailability()
      createDailySurveyVC()
      ResearchKitStoreManager.shared.addSurvey(from: taskViewController.result)
    }
    
    
  }
  
}
