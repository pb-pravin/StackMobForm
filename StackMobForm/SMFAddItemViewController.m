//
//  SMFAddItemViewController.m
//  StackMobForm
//
//  Created by Wess Cope on 1/25/13.
//  Copyright (c) 2013 WessCope. All rights reserved.
//

#import "SMFAddItemViewController.h"
#import "SMFItemForm.h"
#import "SMFAppDelegate.h"
#import "StackMob.h"

@interface SMFAddItemViewController ()
@property (strong, nonatomic) SMFItemForm *form;

- (void)saveNewItem:(id)sender;
@end

@implementation SMFAddItemViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.form = [[SMFItemForm alloc] init];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.form.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    UITextField *field              = [self.form.fields objectAtIndex:indexPath.row];
    field.frame                     = CGRectInset(cell.bounds, 30.0f, 5.0f);
    field.contentVerticalAlignment  = UIControlContentVerticalAlignmentCenter;
    
    [cell addSubview:field];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *submit            = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame                = CGRectMake(10.0f, 10.0f, self.tableView.bounds.size.width - 20.0f, 40.0f);
    submit.clipsToBounds        = YES;
    submit.titleLabel.font      = [UIFont systemFontOfSize:22.0f];
    submit.backgroundColor      = [UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0.5];
    submit.layer.cornerRadius   = 5.0f;
    submit.layer.borderColor    = [UIColor darkGrayColor].CGColor;
    submit.layer.borderWidth    = 1.0f;
    
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(saveNewItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:submit];
    
    return footerView;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Save Actions -
- (void)saveNewItem:(id)sender
{
    if(self.form.isValid)
    {
        NSString *title     = [self.form.form valueForField:@"title"];
        NSString *details   = [self.form.form valueForField:@"details"];
        NSString *note      = [self.form.form valueForField:@"note"];
        
        SMFAppDelegate *appDelegate     = (SMFAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSManagedObject *itemObject     = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
        
        [itemObject setValue:title      forKey:@"title"];
        [itemObject setValue:details    forKey:@"details"];
        [itemObject setValue:note       forKey:@"note"];
        [itemObject setValue:[itemObject assignObjectId] forKey:[itemObject primaryKeyField]];
        
        //[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]].
        [context saveOnSuccess:^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Save was successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];

            [self.navigationController popToRootViewControllerAnimated:YES];
        } onFailure:^(NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error :(" message:[NSString stringWithFormat:@"Save Error: %@", error.debugDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }];
    }
}

@end
