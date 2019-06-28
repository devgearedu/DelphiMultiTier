
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "menu.h"
#import "login.h"
#import "Users.h"
#import "FollowerUsers.h"

@implementation menu
@synthesize listUsers,delegateMenu,loginView,followerUsersView;


-(IBAction)logOut{
	@try{
		if ([[Users getinstance] isLogged]){
	[[Users getinstance] logOut];
		}		
	[self.navigationController pushViewController:loginView animated:YES];
    }
    @catch (NSException* e) {
        [Users showErrorAlert:e];
    	[self.navigationController pushViewController:loginView animated:YES];
    }
}

-(IBAction)goToFollowUsers{
	@try {

	[self.navigationController pushViewController:followerUsersView animated:YES];
}
@catch (NSException* e) {
	[Users showErrorAlert:e];
	[self.navigationController pushViewController:loginView animated:YES];
}
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
											  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
											  target:self
											  action:@selector(closeMenu:)] autorelease];
	
	
	
}

- (void)closeMenu:(id)sender {
	
    // Call the delegate to dismiss the modal view
    [delegateMenu didDismissModalViewMenu];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[listUsers release];
	[delegateMenu release];
	[loginView release];
	[followerUsersView release];
    [super dealloc];
}


@end
