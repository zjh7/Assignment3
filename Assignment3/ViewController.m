//
//  ViewController.m
//  Assignment3
//
//  Created by David Evans on 2/5/13.
//  Copyright (c) 2013 DavidEvans. All rights reserved.
//

#import "ViewController.h"
#import "Assignment3DetailViewController.h"
#import "Fruit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Zack's Banana Stand";
    
    _allSelected = NO;
    
    _cart = [NSMutableArray arrayWithCapacity:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark IBActions

-(IBAction)selectAllOrNone:(id)sender
{
    _allSelected = !_allSelected;
    if(_allSelected){
        [_selectAll setTitle:@"Select None" forState:UIControlStateNormal];
    } else {
        [_selectAll setTitle:@"Select All" forState:UIControlStateNormal];
    }
    [_cartView reloadData];
}

//Should remove all of the fruit in the cart.
-(IBAction)removeAllFruitInCart:(id)sender
{
    if([_cart count] > 0)
    {
        [_cart removeAllObjects]; //Removes all objects from array
        [_cartView reloadData]; //Reloads data view

    }
}

//should add 50 bananas to the cart and display them!
-(IBAction)fillCartWithBananas:(id)sender
{
    int incart = [_cart count];
    int toadd = 0;
    toadd = incart+50;
    for(int i = incart; i < toadd; i++)
    {
        NSString * fruitName = [NSString stringWithFormat:@"Banana # %d", (i+1)];
        Fruit * anonFruit = [[Fruit alloc] initWithWithName:fruitName andColor:@"Yellow" andShape:@"Curved"];
        anonFruit.url = @"http://en.m.wikipedia.org/wiki/Banana";
        [_cart addObject:anonFruit];
    }
    [_cartView reloadData];
}

-(IBAction)addFruit:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Fruit"message:@"Which fruit would you like to add?" delegate:self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Banana", @"Apple", nil];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        int incart = [_cart count];
        NSString * fruitName = [NSString stringWithFormat:@"Banana # %d", (incart+1)];
        Fruit * anonFruit = [[Fruit alloc] initWithWithName:fruitName andColor:@"Yellow" andShape:@"Curved"];
        anonFruit.url = @"http://en.m.wikipedia.org/wiki/Banana";
        [_cart addObject:anonFruit];
        [_cartView reloadData];
    }
    if (buttonIndex == 2)
    {
        int incart = [_cart count];
        NSString * fruitName = [NSString stringWithFormat:@"Apple # %d", (incart+1)];
        Fruit * anonFruit = [[Fruit alloc] initWithWithName:fruitName andColor:@"Red" andShape:@"Round"];
        anonFruit.url = @"http://en.m.wikipedia.org/wiki/Apple";
        [_cart addObject:anonFruit];
        [_cartView reloadData];
    }
}

#pragma mark UITableView dataSource and delegate methods

-(int) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Fruit";
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_cart count]==0)
    {
        return 1;
    }
    return [_cart count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCell"];
    }
    
    if([_cart count] == 0){
        cell.textLabel.text = @"No Fruit in Cart";
        cell.detailTextLabel.text = @"Womp womp";
        if(_allSelected){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }

        
    } else {
        Fruit * tempFruit = [_cart objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [tempFruit name];
        cell.detailTextLabel.text = [tempFruit color];
        
        if(_allSelected){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fruit * selectedFruit = [_cart objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Assignment3DetailViewController * detailView = [[Assignment3DetailViewController alloc] initWithNibName:@"Assignment3DetailViewController" bundle:nil];
    
    detailView.title = selectedFruit.name;
    detailView.url = selectedFruit.url;
    
    [self.navigationController pushViewController:detailView animated:YES];
}

@end