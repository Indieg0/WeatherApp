//
//  ViewController.h
//  onemoretime
//
//  Created by Kirill on 12.11.15.
//  Copyright © 2015 Kirill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;



- (IBAction)generateButton:(id)sender;
- (IBAction)myLocationButton:(id)sender;

@end

