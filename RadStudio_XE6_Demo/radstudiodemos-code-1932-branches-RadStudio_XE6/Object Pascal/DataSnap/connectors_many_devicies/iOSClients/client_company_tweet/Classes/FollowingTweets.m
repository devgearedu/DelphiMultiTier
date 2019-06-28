
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "FollowingTweets.h"
#import "login.h"
#import "TJSONArray.h"
#import "Users.h"
#import "CallBackTweet.h"
#import "DSProxyExt.h"



@implementation FollowingTweets
@synthesize list;
@synthesize loginView;
@synthesize newTweet;


#pragma mark -
#pragma mark View lifecycle

-(void) returnToLogin{
	
	
	if( self.navigationController.topViewController != loginView ){			
		
		[self.navigationController pushViewController:loginView animated:YES];	}
	
}


//method called from the callback whene a message come
-(void)reloadTableListOfTweet:(NSArray *)params{
  	self.list = params;
	[self.tableView reloadData];
}


//to close  menu modal  view
- (void)didDismissModalViewMenu{
	
    [self dismissModalViewControllerAnimated:YES];
	
}
// to close Addtweet modal view
-(void) didDismissModalViewAddMyTweet
{
	[self dismissModalViewControllerAnimated:YES];
}

// to insert my tweet and reload the list of tweets
-(void)myTweet:(NSString *)textMyTweet{
	@try {
		[ self dismissModalViewControllerAnimated:YES];
		[[TCompanyTweet  getProxyinstance] SendTweet:textMyTweet];
		self.list = [[Users getinstance] getListTweets]; 
		[self.tableView reloadData];
		
	}
	@catch (NSException * e) {

		[self.navigationController pushViewController:loginView animated:YES];
		@throw e;
		
	}
	
}


//to open  menu modal  view
-(void)openViewModalMenu{
	// Create the modal view controller
	menu *viewMenu = [[menu alloc] initWithNibName:@"menu" bundle:nil] ;
	
	// We are the delegate responsible for dismissing the modal view 
	viewMenu.delegateMenu = self;
	
	// Create a Navigation controller
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewMenu];
	[viewMenu release];
	navController.modalPresentationStyle = UIModalPresentationFormSheet;

	// show the navigation controller modally
	[self presentModalViewController:navController animated:YES];

}




//to open  AddTweet modal  view
-(void)openViewModalAddTweet{
	// Create the modal view controller
	AddTweet *viewAddTweet = [[AddTweet alloc] initWithNibName:@"AddTweet" bundle:nil] ;
	
	// We are the delegate responsible for dismissing the modal view 
	viewAddTweet.delegateTweet = self;
	
	// Create a Navigation controller
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewAddTweet];
	[viewAddTweet release];
	
	navController.modalPresentationStyle = UIModalPresentationFormSheet;
	
	// show the navigation controller modally
	[self presentModalViewController:navController animated:YES];
	

}

- (void)viewDidLoad {
	[super viewDidLoad];
		//set a pointer at this view to reload the list when a message come
	[[Users getinstance] setFollowingTweets:self];
	
	//populate a list of messages

    self.list =  [[Users getinstance] getListTweets];
  
	

	self.title = [NSString stringWithFormat:@"User: %@", [[Users getinstance] getUserName]];
	
	UIButton *buttonLeft =  [[UIButton buttonWithType:UIButtonTypeCustom]retain];
	[buttonLeft setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
	[buttonLeft addTarget:self action:@selector(openViewModalMenu) forControlEvents:UIControlEventTouchUpInside];
	[buttonLeft setFrame:CGRectMake(0, 0, 32, 32)];
	self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
	[buttonLeft release];
	
	
	UIButton *buttonRight =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	[buttonRight setImage:[UIImage imageNamed:@"add_tweet.png"] forState:UIControlStateNormal];
	[buttonRight addTarget:self action:@selector(openViewModalAddTweet) forControlEvents:UIControlEventTouchUpInside];
	[buttonRight setFrame:CGRectMake(0, 0, 32, 32)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
	[buttonRight release];


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	NSLog(@"quando ci passo?");
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
    return [self.list count];

}
 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSString * userName = [[self.list objectAtIndex:indexPath.row] objectForKey:@"username"];
	NSString * userMessage = [[self.list objectAtIndex:indexPath.row] objectForKey:@"message"];
	cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", userName,userMessage];
	
	
	//image on the left row
	cell.imageView.image = [UIImage imageNamed:@"bird_off.png"];
	
	cell.textLabel.minimumFontSize = 9;
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.numberOfLines = 0;
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString * userName = [[self.list objectAtIndex:indexPath.row] objectForKey:@"username"];
	NSString * userMessage = [[self.list objectAtIndex:indexPath.row] objectForKey:@"message"];
	
	int count = [userName length] + [userMessage length];
	
	if (count > 50) {
		return 70;
	}
	else
      return 50;
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
	[super dealloc];
	[loginView release];
	[list release];
	[newTweet release];

	//[[Users getinstance] setView:nil];
	
}


@end

