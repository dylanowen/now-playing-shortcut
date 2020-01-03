//
//  ComplicationController.swift
//  now-playing-shortcut WatchKit Extension
//
//  Created by Dylan Owen on 1/1/20.
//  Copyright © 2020 Dylan Owen. All rights reserved.
//

import ClockKit
import os

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  // MARK: - Timeline Configuration
  
  func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
    
    handler([])
  }
  
  func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  // MARK: - Timeline Population
  
  func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
    if let template = getTemplate(family: complication.family) {
      handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
    }
    else {
      handler(nil)
    }
  }
  
  // MARK: - Placeholder Templates
  
  func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    // This method will be called once per supported complication, and the results will be cached
    handler(getTemplate(family: complication.family))
  }
  
}

func getTemplate(family: CLKComplicationFamily) -> CLKComplicationTemplate? {
  switch family {
  case .modularSmall:
    os_log("Loading Complication: modularSmall", type: .info)
    
    let template = CLKComplicationTemplateModularSmallSimpleImage()
    template.imageProvider = getAlphaImageProvider(complication: "Modular")
    return template
  case .utilitarianSmall:
    os_log("Loading Complication: utilitarianSmall", type: .info)
    
    let template = CLKComplicationTemplateUtilitarianSmallRingImage()
    template.imageProvider = getAlphaImageProvider(complication: "Utilitarian")
    return template
  case .circularSmall:
    os_log("Loading Complication: circularSmall", type: .info)

    let template = CLKComplicationTemplateCircularSmallSimpleImage()
    template.imageProvider = getAlphaImageProvider(complication: "Graphic Circular")
    return template
  case .extraLarge:
    os_log("Loading Complication: extraLarge", type: .info)

    let template = CLKComplicationTemplateExtraLargeSimpleImage()
    template.imageProvider = getAlphaImageProvider(complication: "Extra Large")
    return template
  case .graphicCorner:
    os_log("Loading Complication: graphicCorner", type: .info)
    
    let template = CLKComplicationTemplateGraphicCornerCircularImage()
    template.imageProvider = getFullColorImageProvider(complication: "Graphic Corner")
    return template
  case .graphicBezel:
    os_log("Loading Complication: graphicBezel", type: .info)
    
    let imageTemplate = CLKComplicationTemplateGraphicCircularImage()
    imageTemplate.imageProvider = getFullColorImageProvider(complication: "Graphic Bezel")
    
    let template = CLKComplicationTemplateGraphicBezelCircularText()
    template.circularTemplate = imageTemplate
    return template
  case .graphicCircular:
    os_log("Loading Complication: graphicCircular", type: .info)
    
    let template = CLKComplicationTemplateGraphicCircularImage()
    template.imageProvider = getFullColorImageProvider(complication: "Graphic Circular")
    return template
  default:
    return nil
  }
}

func getFullColorImageProvider(complication: String) -> CLKFullColorImageProvider {
  os_log("Full Color Complication Image: %@", type: .info, complication)
  
  return CLKFullColorImageProvider(
    fullColorImage: UIImage(named: "Complication/" + complication)!,
    tintedImageProvider: getAlphaImageProvider(complication: complication)
  )
}

func getAlphaImageProvider(complication: String) -> CLKImageProvider {
  os_log("Alpha Complication Image: %@", type: .info, complication)
  
  return CLKImageProvider(
    onePieceImage: UIImage(named: "Complication/" + complication)!,
    twoPieceImageBackground: UIImage(named: complication + " Background")!,
    twoPieceImageForeground: UIImage(named: complication + " Foreground")!
  )
}
