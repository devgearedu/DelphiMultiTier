
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
//*******************************************************
//
//               Delphi DataSnap Framework
//
// Copyright(c) 1995-2011 Embarcadero Technologies, Inc.
//
//*******************************************************


#import "login.h"
#import "FollowerUsers.h"
#import "Users.h"
#import "DsProxyExt.h"

@implementation login
@synthesize textFields,followerUsers,loginView;



//function from protocol SEttings
-(void) didDismissModalViewSettings
{
	[self dismissModalViewControllerAnimated:YES];
}

//function from protocol SEttings
-(void) set:(NSString *)host andSet:(NSString *)port{
	
    [self setConnection:host andSet:[port intValue]];
	[self dismissModalViewControllerAnimated:YES];
}


//set connection host and port 
-(void)setConnection :(NSString *)host andSet:(int)port
{
	Users *usr  = [Users getinstance];
	usr.hostValue = host;
	usr.portValue = port;
	
   	[TCompanyTweet getConnectioninstance].Host = host;
	[TCompanyTweet getConnectioninstance].Port = port;
	[TCompanyTweet getConnectioninstance].protocol = @"http";

     //change title of navigation bar
	[self setTitlteOfNavigationBar:[NSString stringWithFormat:@"host: %@  port:%i", usr.hostValue,usr.portValue ]];

}


//set title of navigation bar
-(void)setTitlteOfNavigationBar:(NSString * )value{
	
	CGRect frame = CGRectMake(0, 0, 400, 44);
	UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:11.0];
	label.textAlignment = UITextAlignmentRight ;
	//label.text = [NSString stringWithFormat:@"host: %@  port:%i", usr.hostValue,usr.portValue ];
	label.text = [NSString stringWithFormat:@"%@",value];
	self.navigationItem.titleView = label;
}



-(IBAction)dissmissKeyboard: (id)sender{
	[sender resignFirstResponder];
}

-(IBAction)backgroundTouched: (id)sender{
	[textFields resignFirstResponder];
}


-(void)login: (id)sender{

	
  	Users *usr  = [Users getinstance];
	
	if (  [usr.hostValue isEqualToString:@""] || !(usr.hostValue) ||  !(usr.portValue)) {
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"you have to set host and port number!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
		[alert show];
		
	}
	else {
			
		
		NSString * retmsg;
		@try{
		[self setConnection: usr.hostValue andSet: usr.portValue ];

	
	       BOOL result =[[Users getinstance] loginUser:textFields.text withMessage:&retmsg];
	

	       if (result) {
		        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:retmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
		        [alert show];
		
		
		   [self.navigationController pushViewController:followerUsers animated:YES];
		   [self.navigationController setNavigationBarHidden:NO animated:YES];
	     }
	      else {
			
		      UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:retmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
		        [alert show];
	
	     }
		}
		
         @catch (NSException* e) {
			 [Users showErrorAlert:e];
		
		 }
		
	
		

	}
	
	/*
	followerUsers = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
	[self presentModalViewController:followerUsers animated:YES];	 
	*/
	
}



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

    [super viewDidLoad];

	//set a pointer at this view to reload the list when a message come
	[[Users getinstance] setLoginView:self];
	
	Users *usr  = [Users getinstance];
	[self setTitlteOfNavigationBar:[NSString stringWithFormat:@"host: %@  port:%i", usr.hostValue,usr.portValue ]];

	
	[self.navigationController setNavigationBarHidden:NO animated:YES]; 
	
	UIButton *buttonLeft =  [[UIButton buttonWithType:UIButtonTypeCustom]retain];
	[buttonLeft setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
	[buttonLeft addTarget:self action:@selector(OpensettingsModalView) forControlEvents:UIControlEventTouchUpInside];
	[buttonLeft setFrame:CGRectMake(0, 0, 32, 32)];
	self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
	[buttonLeft release];


}

-(void)OpensettingsModalView{

	// Create the modal view controller
	Settings *viewSettings = [[Settings alloc] initWithNibName:@"Settings" bundle:nil] ;
	
	// We are the delegate responsible for dismissing the modal view 
	viewSettings.delegateSettings = self;
	
	// Create a Navigation controller
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewSettings];
	[viewSettings release];
	navController.modalPresentationStyle = UIModalPresentationFormSheet;
	
	// show the navigation controller modally
	[self presentModalViewController:navController animated:YES];

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
	[textFields release];
	[followerUsers release];
	[loginView release];


    [super dealloc];
}


@end
