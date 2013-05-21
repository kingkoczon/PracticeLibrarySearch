//
//  SearchTableViewController.m
//  PracticeLibrarySearch
//
//  Created by Bobby Koczon on 1/16/13.
//  Copyright (c) 2013 Bobby Koczon. All rights reserved.
//

#import "SearchTableViewController.h"
#import "TFHpple.h"
#import "Results.h"
#import "CatalogDisplayViewController.h"

@interface SearchTableViewController () {
    NSMutableArray *_catalogObjects;
}

@end

@implementation SearchTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(IBAction)search:(id)sender {
    NSString *searchQuery = [catalogSearchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *addOnUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://ecatalog.coronado.lib.ca.us/search~S0/?searchtype=t&searcharg=%@", searchQuery]];
    NSData *resultsHtmlData = [NSData dataWithContentsOfURL:addOnUrl];
    
    TFHpple *resultsParser = [TFHpple hppleWithHTMLData:resultsHtmlData];
    
    NSString *titleXpathQueryString = @"//td[@class='browseEntryData']/a[2]";
    
    NSArray *itemDetails = [resultsParser searchWithXPathQuery:titleXpathQueryString];
        
    NSMutableArray *newResults = [[NSMutableArray alloc] initWithCapacity:0];
    
        for (TFHppleElement *elementTitle in itemDetails) {
            
            Results *result = [[Results alloc] init];
            [newResults addObject:result];
            
            result.title = [[elementTitle firstChild] content];
            
            NSString *yearXpathQueryString = @"//td[@class='browseEntryYear']";
            NSArray *yearDetails = [resultsParser searchWithXPathQuery:yearXpathQueryString];
            
            for (TFHppleElement *elementYear in yearDetails) {
                result.year = [[elementYear firstChild] content];
            }
            
            NSString *entriesXpathQueryString = @"//td[@class='browseEntryEntries']";
            NSArray *entriesDetails = [resultsParser searchWithXPathQuery:entriesXpathQueryString];
            
            for (TFHppleElement *elementEntry in entriesDetails) {
                result.entry = [[elementEntry firstChild] content];
            }
        }
    
    _catalogObjects = newResults;
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_catalogObjects count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Results *thisResult = [_catalogObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = thisResult.title;
    cell.detailTextLabel.text = thisResult.year;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"showCatalogDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CatalogDisplayViewController *CatalogDisplayVC = segue.destinationViewController;
        CatalogDisplayVC.titleString = [_catalogObjects objectAtIndex:indexPath.row];
        CatalogDisplayVC.yearString = [_catalogObjects objectAtIndex:indexPath.row];
        CatalogDisplayVC.numberOfEntriesString = [_catalogObjects objectAtIndex:indexPath.row];
    }
    else if ([segue.identifier isEqualToString:@"loopbackSegue"]) {
        // im guessing i need to parse html again here.
    }
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[_catalogObjects valueForKey:@"entry"] isEqualToString:@"1"]) {
        [self performSegueWithIdentifier:@"showCatalogDetail" sender:self];
    } else {
        [self performSegueWithIdentifier:@"loopbackSegue" sender:self];
    }
}

@end
