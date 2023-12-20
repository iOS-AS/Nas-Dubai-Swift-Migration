//
//  SeeSawViewController.h
//  BIS_AD
//
//  Created by Ajith on 16/10/18.
//  Copyright © 2018 KrrishnaRajSalim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RevealTableViewController.h"

@interface SeeSawViewController : UIViewController<RevealTableDelegate,UIWebViewDelegate, UIDocumentInteractionControllerDelegate>
{
    
    RevealTableViewController *rvc;
    UIView *baseView;
}

@property (retain)UIDocumentInteractionController *documentController;

@property (strong, nonatomic) IBOutlet UIView *webDetailView;
@property (strong, nonatomic) IBOutlet UIView *pdfDetailView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIWebView *normalWebView;
@property (strong, nonatomic) IBOutlet UIWebView *pdfWebView;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *titleSTR;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *webActivityIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *pdfActivityIndicator;

- (IBAction)savePDF:(id)sender;

@end
