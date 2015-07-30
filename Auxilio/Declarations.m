//
//  Declarations.m
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Declarations.h"

#define nURLServer                  @"https://cp.pushwoosh.com/json/1.3"
#define nURLCreateMessage           @"/createMessage"

//Localization variables
float       mlatitude;
float       mlongitude;

int         miLocalizeState     = nLocalizing;

@implementation Declarations

/**********************************************************************************************/
#pragma mark - json particular methods
/**********************************************************************************************/
+ (NSDictionary *)sendNotification {
    print(NSLog(@"getAllTeams"))
    NSMutableDictionary *diData = [[NSMutableDictionary alloc]init];
    NSString    *stApplication  = @"F4C8C-8FF40";
    NSString    *stAuth         = @"aDVeMECq0x8npwH7EzYdML8xzGNiJiN4wZf7c3drrhFUWAPrGYQCGROPkBihftilPHEcJOAzbt41O4vFJIuE";
    
    NSMutableDictionary *diNotifications = [[NSMutableDictionary alloc]init];
    NSString    *stSendDate         = @"now";
    NSString    *stIgnoreUserTime   = @"1";
    NSString    *stContent          = @"Hello world";
    [diNotifications setValue:stSendDate forKey:@"send_date"];
    [diNotifications setValue:stIgnoreUserTime forKey:@"ignore_user_timezone"];
    [diNotifications setValue:stContent forKey:@"content"];
   
    NSMutableArray *aNotification   = [[NSMutableArray alloc] init];
    [aNotification addObject:diNotifications];
    
    [diData setValue:stApplication forKey:@"application"];
    [diData setValue:stAuth forKey:@"auth"];
    [diData setValue:aNotification forKey:@"notifications"];
    
    NSMutableDictionary *diRequest = [[NSMutableDictionary alloc]init];
    [diRequest setValue:diData forKey:@"request"];
    
    NSString  *stData           = [diRequest JSONRepresentation];
    return [self sendPost:([nURLServer stringByAppendingString:nURLCreateMessage]) forData:stData andMode:nPOST];
}
//-------------------------------------------------------------------------------
+ (NSDictionary *)sendCustomNotification {
    print(NSLog(@"getAllTeams"))
    NSMutableDictionary *diData = [[NSMutableDictionary alloc]init];
    NSString    *stApplication  = @"F4C8C-8FF40";
    NSString    *stAuth         = @"aDVeMECq0x8npwH7EzYdML8xzGNiJiN4wZf7c3drrhFUWAPrGYQCGROPkBihftilPHEcJOAzbt41O4vFJIuE";
    
    NSMutableDictionary *diNotifications = [[NSMutableDictionary alloc]init];
    NSString    *stSendDate         = @"now";
    NSString    *stIgnoreUserTime   = @"1";
    NSString    *stContent          = @"Hello world";
    [diNotifications setValue:stSendDate forKey:@"send_date"];
    [diNotifications setValue:stIgnoreUserTime forKey:@"ignore_user_timezone"];
    [diNotifications setValue:stContent forKey:@"content"];
    
    NSMutableDictionary    *diCustomData = [[NSMutableDictionary alloc]init];
    [diCustomData setValue:stContent forKey:@"custom"];
    
    NSMutableArray *aNotification   = [[NSMutableArray alloc] init];
    [aNotification addObject:diNotifications];
    
    [diData setValue:stApplication forKey:@"application"];
    [diData setValue:stAuth forKey:@"auth"];
    [diData setValue:aNotification forKey:@"notifications"];
    
    NSMutableDictionary *diRequest = [[NSMutableDictionary alloc]init];
    [diRequest setValue:diData forKey:@"request"];
    
    NSString  *stData           = [diRequest JSONRepresentation];
    return [self sendPost:([nURLServer stringByAppendingString:nURLCreateMessage]) forData:stData andMode:nPOST];
}
/**********************************************************************************************/
#pragma mark - json common method
/**********************************************************************************************/
+ (NSDictionary *) sendPost:(NSString *) postUrl forData:(NSString *) data andMode:(BOOL)mode {
    @try {
        NSString *post;
        if (mode) {
            post = [[NSString alloc] initWithFormat:@"%@", data];
        }
        else {
            post = [[NSString alloc] initWithFormat:@""];
        }
        print(NSLog(@"post parameters: %@",post))
        post = [post stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        NSURL *url = [NSURL URLWithString:postUrl];
        print(NSLog(@"URL post = %@", url))
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        if (mode) {
            [request setHTTPMethod:@"POST"];
        }
        else {
            [request setHTTPMethod:@"GET"];
        }
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //[request setValue:@"iOS QCD 1.0" forHTTPHeaderField:@"User-Agent"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //Check response
        print(NSLog(@"[response statusCode] %d",(int)[response statusCode]))
        
        if ([response statusCode] >=200 && [response statusCode] <303) {
            //get json response
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            print(NSLog(@"response received %@",jsonResponse))
            
            //return response
            return jsonResponse;
        }
        else { if (error) {print(NSLog(@"Error response")) return nil; } else {print(NSLog(@"Conect Fail"))return nil;}
            return nil;
        }
    }
    @catch (NSException * e) {print(NSLog(@"Exception")) return nil;}
}

@end
