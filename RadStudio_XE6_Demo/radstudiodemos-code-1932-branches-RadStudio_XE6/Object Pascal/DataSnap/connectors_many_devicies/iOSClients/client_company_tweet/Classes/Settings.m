
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "Settings.h"
#import "Users.h"


@implementation Settings
@synthesize delegateSettings,hostText,portText,save;


-(IBAction)Save{

	
	
	if (  [hostText.text isEqualToString:@""] || !(hostText.text ) ||  !(portText.text )) {
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"you have to set host and port number!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
		[alert show];
		
	}else {
		[delegateSettings set:hostText.text andSet:portText.text];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:hostText.text forKey:@"HOST"];
	    [defaults setObject:portText.text forKey:@"PORT"];
		[[NSUserDefaults standardUserDefaults] synchronize ];
		
		
	}
	
	
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
	
	Users *usr  = [Users getinstance];
	hostText.text = usr.hostValue;
	portText.text = [NSString stringWithFormat:@"%i", usr.portValue];
	
	

	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
											  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
											  target:self
											  action:@selector(closeSettings:)] autorelease];

}


- (void)closeSettings:(id)sender {
    [delegateSettings didDismissModalViewSettings];
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
    [super dealloc];
	[delegateSettings release];
	[hostText release];
	[portText release];
	[save release];

}


@end
