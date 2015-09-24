//
//  ViewController.m
//  Camera
//
//  Created by Jackson Graham on 7/28/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TakePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];



}



- (IBAction)PickPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info{
    if (info[UIImagePickerControllerEditedImage]) {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
        UIImageWriteToSavedPhotosAlbum(chosenImage,nil, nil, nil);
} else {
    self.videoURL = info[UIImagePickerControllerMediaURL];
    self.videoController = [[MPMoviePlayerController alloc]init];
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame: CGRectMake (29, 162, 263, 243)];
    [self.view addSubview:self.videoController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.videoController];
    
    
    
    
    [self.videoController play];

    
    
}

    [picker dismissViewControllerAnimated:YES completion:NULL];



}

- (IBAction)TakeVideo:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:picker animated:YES completion:NULL];
    //kUTTtype movie will show an eerror unless you import the required frameworks
    
    
}

- (void)videoPlayBackDidFinish:(NSNotificationCenter *)notification {
    [[NSNotificationCenter defaultCenter]removeObserver:self name: MPMoviePlayerPlaybackDidFinishNotification object: nil];
    // stop the video player remove it from
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
}
- (IBAction)SendEmail:(id)sender {



    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
        mail.mailComposeDelegate = self;
      //  if (self.videoURL !=nil) {
        [mail addAttachmentData:[NSData dataWithContentsOfURL:self.videoURL] mimeType:@"video/MOV" fileName:@"Video.MOV"];
       // } else if (self.img =!nil) {
        
        
        
            
        [mail setSubject:@"video"];
        [mail setMessageBody:@"body" isHTML:YES];
        [mail setToRecipients:[NSArray arrayWithObject:@"desired@email.com"]];
        [self presentViewController:mail animated:YES completion:nil];
    } else { NSLog(@"Your Device Needs To Be Updated."); }
}

    
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSLog (@"result");


[self dismissViewControllerAnimated:YES completion:NULL];
}
       @end
