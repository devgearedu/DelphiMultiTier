
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "FollowerUsers.h"
#import "FollowingTweets.h"
#import "login.h"
#import "TJSONArray.h"
#import "Users.h"

@implementation FollowerUsers
@synthesize users,followingtweets,loginView;



#pragma mark -
#pragma mark View lifecycle

//custom function


-(void) returnToLogin{
	
	
	if( self.navigationController.topViewController != loginView ){		
		
		[self.navigationController pushViewController:loginView animated:YES];	
		
		
	
	
	}
	
}


-(void)updateTweet{
	@try {
	  NSLog(@"refresh");
	  [[Users getinstance] refreshListUsers]; 
	  self.users =  [[Users getinstance] getListUsers];
	  [self.tableView reloadData];
     }
    @catch (NSException* e) {
		[Users showErrorAlert:e];
	    [self.navigationController pushViewController:loginView animated:YES];
    }
}
-(void)next{
	@try {
	
	  [[Users getinstance] setUsersToFollow];	
	  [followingtweets reloadTableListOfTweet:  [[Users getinstance] getListTweets]];	
	  [self.navigationController pushViewController:followingtweets animated:YES];
    } 
	@catch (NSException* e) {
		[Users showErrorAlert:e];
		
		[self.navigationController pushViewController:loginView animated:YES];
    }

}
-(void)follow:(id)sender{
	UISwitch *theSwitch = (UISwitch *)sender;
	UITableViewCell *cell = (UITableViewCell *)theSwitch.superview;
	if(theSwitch.on) 
		[[Users getinstance] followUser:cell.textLabel.text withValue:1];
	else
		[[Users getinstance] followUser:cell.textLabel.text withValue:0];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    	
	self.title = @"Follower users";
	
	UIButton *buttonLeft =  [[UIButton buttonWithType:UIButtonTypeCustom]retain];
	[buttonLeft setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
	[buttonLeft addTarget:self action:@selector(updateTweet) forControlEvents:UIControlEventTouchUpInside];
	[buttonLeft setFrame:CGRectMake(0, 0, 32, 32)];
	self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
	[buttonLeft release];
	

	UIButton *buttonRight =  [[UIButton buttonWithType:UIButtonTypeCustom]retain];
	[buttonRight setImage:[UIImage imageNamed:@"arrowright.png"] forState:UIControlStateNormal];
	[buttonRight addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
	[buttonRight setFrame:CGRectMake(0, 0, 32, 32)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
	[buttonRight release];
	/* end navigationbar*/
    @try {
		[[Users getinstance] refreshListUsers];
		self.users =  [[Users getinstance] getListUsers];

	}
	@catch (NSException * e) {
		[Users showErrorAlert:e];
		[self.navigationController pushViewController:loginView animated:YES];
	}
     

	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}
*/


/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.users count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = [[self.users objectAtIndex:indexPath.row] objectForKey:@"username"];

    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
	
	//image on the left row
	cell.imageView.image = [UIImage imageNamed:@"user.png"];
	

	//switch for follow a user
	UISwitch *mySwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
	cell.accessoryView = mySwitch;
	//set the state
	BOOL ifFollow = [[[self.users objectAtIndex:indexPath.row] objectForKey:@"followed"]boolValue];
	
	if(ifFollow)		
		[(UISwitch *)cell.accessoryView setOn:1];//yes   
	else 
		[(UISwitch *)cell.accessoryView setOn:0];//NO   	
	//to change the state
	[(UISwitch *)cell.accessoryView addTarget:self action:@selector(follow:) forControlEvents:UIControlEventValueChanged];

	



	
	
	
	
	return cell;
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[followingtweets release];
	[users release];
	[loginView release];
    [super dealloc];
}


@end

