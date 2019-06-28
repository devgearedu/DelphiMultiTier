
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "AddTweet.h"
#import "Users.h"




@implementation AddTweet
@synthesize buttonOk,textTweet,delegateTweet;

-(IBAction)insertTweet
{
	@try {
   [ self dismissModalViewControllerAnimated:YES];
	NSLog(@"%@",textTweet.text);
	[delegateTweet myTweet:textTweet.text];
    }
     @catch (NSException* e) {
		 [Users showErrorAlert:e];

    }

}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	if ([textView.text length] >= 70) {
		[textTweet resignFirstResponder]; 
		return NO;
	} else {
		return YES;
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
											  action:@selector(closeTweet:)] autorelease];
}

- (void)closeTweet:(id)sender {

    [delegateTweet didDismissModalViewAddMyTweet];
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
	[buttonOk release];
	[delegateTweet release];
	[textTweet release];
    [super dealloc];
}


@end
