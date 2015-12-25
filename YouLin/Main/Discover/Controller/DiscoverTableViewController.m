//
//  DiscoverTableViewController.m
//  YouLin
//
//  Created by Jimmy on 15/12/12.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "DiscoverTableViewController.h"

@interface DiscoverTableViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *discoverScrollerView;

@property (weak, nonatomic) IBOutlet UIImageView *cityActivityImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cityUnsusedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cityGroupImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cityWorkRoomImageView;

@property (weak, nonatomic) IBOutlet UIImageView *activityMarkImage;
@property (weak, nonatomic) IBOutlet UIImageView *unUseMarkImage;


@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setImageView {
    _cityActivityImageView.image = [UIImage imageNamed:@"Resource.bundle/ico_feed_post_event@2x"];
    _cityUnsusedImageView.image = [UIImage imageNamed:@"Resource.bundle/ico_feed_post_sell@2x"];
    _cityGroupImageView.image = [UIImage imageNamed:@"Resource.bundle/ico_feed_post_group@2x"];
    _cityWorkRoomImageView.image = [UIImage imageNamed:@"Resource.bundle/ico_feed_post_workroom@2x"];
    
    _activityMarkImage.image = [UIImage imageNamed:@"Resource.bundle/bg_poflie_sent_"];
    _unUseMarkImage.image = [UIImage imageNamed:@"Resource.bundle/bg_poflie_sent_"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
