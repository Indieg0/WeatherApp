//
//  ViewController.m
//  onemoretime
//
//  Created by Kirill on 12.11.15.
//  Copyright © 2015 Kirill. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"


@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateButton:(id)sender {
    
    NSString *urlString = [[NSString alloc]init];

    urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&cnt=7&mode=json&appid=2de143494c0b295cca9337e1e96b00e0", self.latitudeField.text, self.longitudeField.text];
    
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:urlString]];

    NSError *error;
    NSMutableDictionary *time = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
    
  
    
    NSArray *list = time[@"list"];
    NSMutableDictionary *temperature = [[NSMutableDictionary alloc] init];
    NSMutableArray *allTemp = [NSMutableArray array];
    for (NSDictionary *course in list) {
        
        [temperature setObject:course forKey:@"temp"];
       // NSLog(@"Temperatures: %@,", course[@"temp"]);
        [allTemp addObject:course[@"temp"]];
    }
   // NSLog(@"%@", weekTemp);
    
    
    NSMutableArray *dayTemp = [NSMutableArray array];
    for (NSDictionary *course in allTemp) {
        
        [temperature setObject:course forKey:@"day"];
        // NSLog(@"Temperatures: %@,", course[@"temp"]);
        [dayTemp addObject:course[@"day"]];
    }
    
    NSMutableArray *convertedDayArray = [NSMutableArray array];
    for (NSString* obj in dayTemp) {
        CGFloat celvinTemp = [obj floatValue];
        CGFloat celsiumTemp = celvinTemp - 273;
        [convertedDayArray addObject:[NSString stringWithFormat:@"%1.1f", celsiumTemp]];
    }
    NSLog(@"%@", convertedDayArray);
    
    TableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    vc.convertedDayTemp = convertedDayArray;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (IBAction)myLocationButton:(id)sender {
    
    [self.locationManager startUpdatingLocation];

}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.longitudeField.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitudeField.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    [self.locationManager stopUpdatingLocation];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
