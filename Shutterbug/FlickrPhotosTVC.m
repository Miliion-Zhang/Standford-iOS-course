//
//  FlickrPhotosTVC.m
//  Shutterbug
//
//  Created by Minlin Zhang on 12/21/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "FlickrPhotosTVC.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

@interface FlickrPhotosTVC () <UISplitViewControllerDelegate>

@end

@implementation FlickrPhotosTVC

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *photo = self.photos[indexPath.row];
    cell.textLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - UITableViewControllerDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers[1];
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    
    if ([detail isKindOfClass:[ImageViewController class]]) {
        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
    }
}

#pragma mark - Navigation

- (void)prepareImageViewController:(ImageViewController *)ivc   toDisplayPhoto:(NSDictionary *)photo
{
    ivc.imageURL = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
    ivc.title = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display Photo"]) {
                if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
                    [self prepareImageViewController:segue.destinationViewController
                                      toDisplayPhoto:self.photos[indexPath.row]];
                }
            }
        }
    }
}

#pragma mark - UISplitViewControllerDelegate

- (void)awakeFromNib
{
    self.splitViewController.delegate = self;
}

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
    //return NO;
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    NSLog(@"willHideViewController has been called!");
    barButtonItem.title = aViewController.title;
    //UINavigationController *detail = (UINavigationController *)self.splitViewController.viewControllers[1];
    //detail.navigationItem.leftBarButtonItem = barButtonItem;
    //detail.navigationItem.title = @"For testing navigationItem";
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    //self.navigationItem.title = @"For testing navigationItem";
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //UINavigationController *detail = (UINavigationController *)self.splitViewController.viewControllers[1];
    //detail.navigationItem.leftBarButtonItem = nil;
    
    self.navigationItem.leftBarButtonItem = nil;
    NSLog(@"willShowViewController has been called!");
}

@end
