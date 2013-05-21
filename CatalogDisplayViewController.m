//
//  CatalogDisplayViewController.m
//  PracticeLibrarySearch
//
//  Created by Bobby Koczon on 1/16/13.
//  Copyright (c) 2013 Bobby Koczon. All rights reserved.
//

#import "CatalogDisplayViewController.h"

@interface CatalogDisplayViewController ()

@end

@implementation CatalogDisplayViewController

@synthesize titleLabel = _titleLabel, titleString = _titleString;
@synthesize yearLabel = _yearLabel, yearString = _yearString;
@synthesize numberOfEntriesLabel = _numberOfEntriesLabel, numberOfEntriesString = _numberOfEntriesString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_yearLabel sizeToFit];
    
    _titleLabel.text = [_titleString valueForKey:@"title"];
    _yearLabel.text = [_yearString valueForKey:@"year"];
    _numberOfEntriesLabel.text = [_numberOfEntriesString valueForKey:@"entry"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
