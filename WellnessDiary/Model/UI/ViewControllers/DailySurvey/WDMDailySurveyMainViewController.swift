//
//  WDMDailySurveyMainViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import UIKit
import CareKit
import ResearchKit

class WDMDailySurveyMainViewController: WDMSimpleViewController, ORKTaskViewControllerDelegate {
  func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    UserPreference.sharedUserPreferences.setSystemPreferences(for: DAILY_SURVEY_DATE_KEY, with: Date())
    checkSurveyAvailability()
    taskViewController.dismiss(animated: true)
    createDailySurveyVC()
  }
  

  // MARK: Properties
  private var dailySurveyViewController = ORKTaskViewController(task: WDMDailySurveyManager.sharedInstance.getDailySurvey(), taskRun: UUID())
  private var completedSurveyViewController = WDMDailySurveyCompletedChildViewController(nibName: nil, bundle: nil)
  private var editBtnItem: WDMSimpleBarButtomItem!
  
  @objc private let startSurveyBtn: WDMSimpleButton = {
    let btn = WDMSimpleButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("Start Survey", for: .normal)
    btn.clipsToBounds = true
    btn.backgroundColor = Colors.mainColor.color
    btn.layer.cornerRadius = 12
    return btn
  }()
  
  // MARK: Initializers
  
  // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()

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
    checkSurveyAvailability()
  }

  @objc private func editBarButtonTapped() {
    navigationController?.present(WDMDailySurveyEditViewController(), animated: true)
  }
  
  @objc private func startSurveyBtnTapped() {
    navigationController?.present(dailySurveyViewController, animated: true)
  }
  
  private func createDailySurveyVC() {
    dailySurveyViewController = ORKTaskViewController(task: WDMDailySurveyManager.sharedInstance.getDailySurvey(), taskRun: UUID())
    dailySurveyViewController.delegate = self
  }
  
  private func checkSurveyAvailability() {
    if let lastSurveyDate = UserPreference.sharedUserPreferences.getDate(for: DAILY_SURVEY_DATE_KEY) {
      if Calendar.current.isDateInToday(lastSurveyDate) {
        add(completedSurveyViewController)
        startSurveyBtn.isHidden = true
      }
    } else {
      completedSurveyViewController.remove()
      startSurveyBtn.isHidden = false
    }
  }
  

}
