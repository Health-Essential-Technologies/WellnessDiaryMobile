//
//  WDMSomeViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 3/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKit

class WDMSomeViewController: WDMSimpleViewController {

  let chart = OCKCartesianChartView(type: .line)
  
    override func viewDidLoad() {
        super.viewDidLoad()

      chart.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(chart)
      setupChart()
    }

  private func setupChart() {
      /// First create an array of CGPoints that you will use to generate your data series.
      /// We use the handy map method to generate some random points.
      let dataPoints = [CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 2), CGPoint(x: 3, y: 5), CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 4), CGPoint(x: 6, y: 5), CGPoint(x: 1, y: 3)]

      /// Now you create an instance of `OCKDataSeries` from your array of points, give it a title and a color. The title is used for the label below the graph (just like in Microsoft Excel)
      var data = OCKDataSeries(dataPoints: dataPoints,
                               title: "Random stuff",
                               color: .green)

      /// Set the pen size for the data series...
      data.size = 2



      /// Finally you add the prepared data series to your graph view.
      chart.graphView.dataSeries = [data]

      /// If you do not specify the minimum and maximum of your graph, `OCKCartesianGraphView` will take care of the right scaling.
      /// This can be helpful if you do not know the range of your values but it makes it more difficult to animate the graphs.
      chart.graphView.yMinimum = 0
      chart.graphView.yMaximum = 6
      chart.graphView.xMinimum = 1
      chart.graphView.xMaximum = 7

      /// You can also set an array of strings to set custom labels on the x-axis.
      /// I am not sure if that works on the y-axis as well.
      chart.graphView.horizontalAxisMarkers = ["1","2","3","4","5","6","7"]

      /// With theses properties you can set a title and a subtitle for your graph.
      chart.headerView.titleLabel.text = "Hello"
      chart.headerView.detailLabel.text = "I am a graph"
    }

}
