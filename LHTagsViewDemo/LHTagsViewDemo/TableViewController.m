//
//  TableViewController.m
//  LHTagsViewDemo
//
//  Created by Lin on 2016/11/4.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "TableViewController.h"
#import "TagTableViewCell.h"

@interface TableViewController ()

@property (nonatomic,strong) NSArray *random_array;
@property (nonatomic,strong) NSArray *tags_array;
@property (nonatomic, strong) NSMutableArray *cellInfos;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _tags_array =  [@[@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more",@"tag" ,@"less is more"] mutableCopy];
    
    _cellInfos = [NSMutableArray new];
    for (NSInteger i = 0; i < 20; i++) {
        [_cellInfos addObject:[self random_array]];
    }
    
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagTableViewCellId" forIndexPath:indexPath];
    cell.tags_array = _cellInfos[indexPath.row];
    return cell;
}

-(NSArray*)random_array
{
    return [_tags_array subarrayWithRange:NSMakeRange(0, arc4random_uniform((uint32_t)_tags_array.count))];
}


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
