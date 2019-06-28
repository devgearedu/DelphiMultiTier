unit SpriteUnit;
//--------------------------------------------------------------------------
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
//--------------------------------------------------------------------------
interface
uses Windows, Types, Graphics;

const
  MAX_SPEED = 20;
  DisplaySize : TSize = (cx : 600; cy:400);

type

TSpriteList = class;  // forward declaration for use in Sprite class

// class Sprite -- a base class for any object which will be displayed
// on the screen.
//

TSprite = class
							 // data members
protected
  owner : TSpriteList;         // pointer to the list which contains us
  next  : TSprite;          // pointer to next sprite in the list
  origin : TPoint;         // sprites position in the window
  boundingRect : TRect;   // a rectangle which completely encloses sprite
  mx,my : double;          // current direction of sprite
  screenSize : TSize;     // size of screen which contains the sprite
							 // used to wrap objects from one side of screen to other
  condemned : boolean;      // used to mark dead objects

public
  constructor Create( aScreenSize : TSize);
  procedure  SetMomentum( const newMomentum : TSize);
  procedure Condemn;
  // Update -- by default, moves sprite based on it's momentum.  Should
  // return a value which will be added to the score
  //
  function Update : integer; virtual;
  procedure ResetBoundingRect;
  // ExpandBoundingRect -- given a point, expand our bounding rectangle
  // to include this point.
  //
  procedure  ExpandBoundingRect( const p : TPoint);
  // Default draw function draws a pixel at the sprites origin
  //
  procedure Draw( Canvas  : TCanvas); virtual;
  // Wrap -- adjust the sprites origin, if it strays off the edge of
  // the window
  //
  procedure Wrap;
end;


// SpriteList -- contains a list of sprites.  Contains specific
// functions for collision detection
//
TSpriteList  = class
  root : TSprite;
public
  count : integer;
  constructor Create;
  destructor Destroy; override;
  procedure Add( sprite : TSprite);
  procedure DrawAll( Canvas : TCanvas);
  function UpdateAll() : integer;
  function CheckForHitMeteor(const p : TPoint) : TSprite;
end;

// Meteor -- a rock, floating in space.  The meteor is specified as
// a series of polor-coordinate points (an angle and a radius).  This
// allows for faster calculation when making the meteors rotate as
// they float about.
//


TMeteor = class (TSprite)
      angularMomentum,    // how fast the meteor is spinning
		  currentAngle : integer;       // current angle of rotation
      angle,          // angle and radius of the points
      radius : array [0..9] of integer;         //   which define the meteor
      count,              // # of points which define the meteor
      size,               // 1=tiny, 2=medium, 3=large rock
      spawnCount : integer;         // how many smaller meteors to create when hit

public
  constructor Create( aOrigin : TPoint; aMomentum : TSize; aSize, aSpawnCount : integer);
  function  GetSize: integer;
  function Update : integer; override;
  procedure Hit;
  procedure Draw( Canvas : TCanvas); override;
end;

// Shot -- a bullet little block as it is easier to draw...
TShot = class(TSprite)
    timeToDie : integer;            // shots disappear after a set amount of time
  public
    constructor Create( aOrigin: TPoint; aMomentum : TSize; aTimeToDie : integer);
    procedure Draw( Canvas : TCanvas );override;
    function Update: integer; override;
end;

// Debris -- a spinning line.  it floats about for a few seconds and
// disappears.  the player ship is turned into these when it is destroyed.
//
TDebris = class(TSprite)
  p1,p2 : TPoint;
  size,              // length of line
  angle,             // current angle of spinning line
  angularMomentum,   // rate of spin
  timeToDie : integer;
public
  constructor Create( const aP1: TPoint;const aP2 : TPoint; screenSize : TSize );
  function  Update : integer; override;
  procedure Draw( Canvas : TCanvas ); override;
end;

// Ship -- the player ship
//
TShip = class(TSprite)
  angle,radius,thrust : integer;
public
  constructor Create( pos : TPoint);
  procedure Draw( Canvas : TCanvas); override;
  procedure Explode;
  procedure Rotate( adjust : integer);
  procedure AddThrust( adjust : integer);
  function Update: integer; override;
  function  CreateNewShot: TShot;
end;

// Message -- a sprite that can display numbers 0-9, used for score display
//
TSprMessage = class(TSprite)
  text : AnsiString;
public
  constructor Create( aOrigin : TPoint);
  procedure SetText( aText : AnsiString);
  procedure  Draw( Canvas  : TCanvas); override;
end;

implementation
uses Math, Sysutils;
// values used to initialize meteors.  these values are randomly
// tweaked, so each meteor looks different
//
const count1 : integer = 8;

var
    angle1    : array [0..9] of integer =  (  0,45,90,135,180,225,270,315,0,0 );
    radius1   : array [0..9] of integer =  ( 30,30,30, 30, 30, 30, 30, 30,0,0 );
    sinTable  : array [0..360] of double;
    cosTable  : array [0..360] of double;
    adjust   : double;




// adjust - value to convert degrees to radians
//  pi can be computed as atan(1)*4,
//  and there are 2*pi radians in 360 degrees so:
//  adjust = 2*pi/360 = pi/180 = atan(1)*4/180 = atan(1)/45

function sind( angle : integer ) : double;
begin
  Result := sinTable[(angle+360) mod 360];
end;

function cosd( angle : integer) : double;
begin
  Result := cosTable[(angle+360) mod 360];
end;



constructor TSprite.Create( aScreenSize : TSize);
begin
  screenSize := aScreenSize;
  ResetBoundingRect();
  mx := 0;
  my := 0;
  condemned := false;
end;

procedure  TSprite.SetMomentum( const newMomentum : TSize);
begin
  mx := newMomentum.cx;
  my := newMomentum.cy;
end;

procedure TSprite.Condemn;
begin
   condemned := true;
end;
// Update -- by default, moves sprite based on it's momentum.  Should
// return a value which will be added to the score
//
function TSprite.Update : integer;
begin
  Inc(origin.x,Round(mx));
  Inc(origin.y,Round(my));
  Wrap();
  Result := 0;
end;

procedure TSprite.ResetBoundingRect;
begin
 boundingRect := Rect( origin.X,origin.Y, origin.X,origin.Y);
end;

// ExpandBoundingRect -- given a point, expand our bounding rectangle
// to include this point.
//
procedure  TSprite.ExpandBoundingRect( const p : TPoint);
begin
if (p.x < boundingRect.left) then boundingRect.left := p.x;
if (p.y < boundingRect.top) then boundingRect.top := p.y;
if (p.x > boundingRect.right) then boundingRect.right := p.x;
if (p.y > boundingRect.bottom) then boundingRect.bottom := p.y;
end;

// Default draw function draws a pixel at the sprites origin
//
procedure TSprite.Draw( Canvas : TCanvas);
begin
  Canvas.Pixels[origin.x,origin.y] := clWhite;
end;


// Wrap -- adjust the sprites origin, if it strays off the edge of
// the window
//
procedure TSprite.Wrap;
begin
  origin.x := (origin.x + screenSize.cx) mod screenSize.cx;
  origin.y := (origin.y + screenSize.cy) mod screenSize.cy;
end;

constructor TSpriteList.Create;
begin
    root  := nil;
    count := 0;
end;

procedure  TSpriteList.Add( sprite : TSprite);
begin
  Inc(count);
  if (root = nil) then
  begin
	  root := sprite;
	   sprite.next := nil;
	   sprite.owner := self;
	 exit;
  end;
  sprite.next := root;
  sprite.owner := self;
  root := sprite;
end;

destructor TSpriteList.Destroy;
var
   previous, current : TSprite;
begin
  current  := root;
  while (current <> nil) do
  begin
     previous := current.next;
     FreeAndNil(current);
     current := previous;
  end;
  inherited;
end;

procedure TSpriteList.DrawAll( Canvas : TCanvas);
var
 temp : TSprite;
begin
  temp := root;
  while (temp <> nil) do
  begin
	  temp.Draw( Canvas );
	  temp := temp.next;
  end;
end;

function TSpriteList.UpdateAll : integer;
var
   previous, current : TSprite;
   points: integer;

begin
  current  := root;
  previous := nil;
  points := 0;
  while (current <> nil) do
  begin
    // if the object is not condemned, call it's update
    // function
    if (not current.condemned)  then
    begin
      Inc(points,current.Update());
      previous := current;
      current  := current.next;
    end
    // if the object is condemned, delete it from the
    // list
    else
    begin
      // special case if we're deleting the root node
      if (previous = nil) then
      begin
        root := current.next;
        FreeAndNil(current);
        Dec(count);
        current := root;
      end
      else
      begin
        previous.next := current.next;
        FreeAndNil(current);
        Dec(count);
        current := previous.next;
      end;
    end;
  end;
  Result := points;
end;



function TSpriteList.CheckForHitMeteor( const P : TPoint ) : TSprite;
var
  temp : TSprite;
begin
  temp := root;
  Result := nil;
  while (temp <> nil) do
  begin
	  if ((temp is TMeteor) and
       PtInRect(temp.boundingRect, P)) then
         Exit(temp);
	temp := temp.next;
  end;
end;


constructor TMeteor.Create( aOrigin : TPoint; aMomentum : TSize; aSize, aSpawnCount : integer);
var
  I  : integer;
begin
  inherited Create( DisplaySize );
  origin := aOrigin;
  mx := aMomentum.cx;
  my := aMomentum.cy;
  size := aSize;
  randomize;
  spawnCount := aSpawnCount;
  for i := 0 to 9 do
  begin
	  angle[i]  := (angle1[i]+random(20)-10) mod 360;
	  radius[i] := (radius1[i]+random(10)-5) div (4-size);
  end;
  angularMomentum := random(7) - 4;
  currentAngle := 0;
  count := count1;
end;

function  TMeteor.GetSize: integer;
begin
  Result := size;
end;


function TMeteor.Update : integer;
begin
  Inc(origin.x,Round(mx));
  Inc(origin.y,Round(my));
  Wrap;
  currentAngle := (currentAngle + angularMomentum + 360) mod 360;
  Result := 0;
end;

procedure TMeteor.Hit;
var
 I : integer;
 temp : TSize;
begin
  Dec(size);
  if (size > 0) then
    for i := 0 to spawnCount do
    begin
      temp.cx  := random(10)-5;
      temp.cy  := random(10)-5;
      owner.Add( TMeteor.Create( origin, temp, size, size ) );
    end;
  condemned := true;
end;

procedure TMeteor.Draw( Canvas : TCanvas);
var
  temp   : TPoint;
  points : array [0..9] of TPoint;
  i      : integer;
begin
  temp := Point( round(radius[0] * sind(angle[0]+currentAngle)),
  round(radius[0]*cosd(angle[0]+currentAngle)) );
  ResetBoundingRect();
  temp := Point(temp.x+origin.x,temp.y+origin.y );
  ExpandBoundingRect( temp);
  points[0] := temp;
  for i := 1  to count+1 do
  begin
	    temp := Point( round(radius[i mod count] * sind(angle[i mod count]+currentAngle)),
			            	   round(radius[i mod count]*cosd(angle[i mod count]+currentAngle)) );
	    Inc(temp.x,origin.x);
      Inc(temp.y,origin.y);
      ExpandBoundingRect( temp );
	    points[i] := temp;
  end;
  points[count] := points[0];
  Canvas.Polyline(points);
end;

constructor TShot.Create( aOrigin :TPoint; aMomentum: TSize; aTimeToDie : integer);
begin
   inherited Create(DisplaySize);
     //*BBK*
	origin := aOrigin;
	mx := aMomentum.cx;
	my := aMomentum.cy;
	timeToDie := aTimeToDie;
end;

procedure TShot.Draw( Canvas : TCanvas );
begin
	if (timeToDie > 0) then
	begin
	  Canvas.Pen.Color :=  clWhite;
	  Canvas.Rectangle(origin.x-1, origin.y-1, origin.x+1, origin.y+1);
	  Canvas.Pen.Color :=  clGreen;
	end;
end;

function TShot.Update: integer;
var
  meteor : TSprite;
  size : integer;
begin
  // shots die after a fixed amount of time
  if (timeToDie > 0) then
  begin
	  origin := Point(origin.x+Round(mx),origin.y+Round(my));
	  Dec(timeToDie);
	  if (timeToDie = 0)  then condemned := true;
  end;

  Wrap;  // if the shot is off the screen, wrap to other side

  // check against all meteors in the list, to see if any are
  // colliding with ourself

  meteor := owner.CheckForHitMeteor( origin );

  // if so, tell the meteor it was hit, and mark ourself for
  // deletion

  if (Assigned(meteor)) then
  begin
    TMeteor(meteor).Hit();
    condemned := true;
	  size := TMeteor(meteor).GetSize();
    case (size) of
       0: Exit(500);
       1: Exit(50);
       2: Exit(5);
    end;
  end;
  Result := 0;
end;


constructor TDebris.Create( const aP1: TPoint;const aP2 : TPoint; screenSize : TSize );
begin
  inherited Create(screenSize);
	p1 := aP1;
	p2 := aP2;
	mx := random(10)-5;
	my := random(10)-5;
	angularMomentum := random(10)-5;
	timeToDie := 20 + random(5);
end;

function TDebris.Update: integer;
begin
	if (timeToDie > 0) then
  begin
	  Inc(p1.x,Round(mx));
	  Inc(p1.y,Round(my));
	  Inc(p2.x,Round(mx));
	  Inc(p2.y,Round(my));
	  Dec(timeToDie);
	end else Condemn;
	Result := 0;
end;

procedure TDebris.Draw( Canvas : TCanvas);
begin
	Canvas.MoveTo(p1.x,p1.y);
	Canvas.LineTo(p2.x,p2.y);
end;

constructor TShip.Create( pos : TPoint);
begin
  inherited Create(DisplaySize);

	origin := pos;
	angle  := 0;
	radius := 10;
	thrust := 0;
	mx     := 0;
  my     := 0;
end;

procedure TShip.Draw( Canvas : TCanvas);
var
	p1,p2,p3,p4 : TPoint;
begin

	p1 := Point( Round(radius*sind(angle)), Round(radius*cosd(angle)) );
	p2 := Point( Round(radius*sind(angle+130)), Round(radius*cosd(angle+130) ));
	p3 := Point( Round((radius/4)*sind(angle+180)), Round((radius/4)*cosd(angle+180)) );
	p4 := Point( Round(radius*sind(angle+230)), Round(radius*cosd(angle+230)) );
	Canvas.MoveTo( p1.x+origin.x , p1.y+origin.y );
	Canvas.LineTo( p2.x+origin.x , p2.y+origin.y );
	Canvas.LineTo( p3.x+origin.x , p3.y+origin.y );
	Canvas.LineTo( p4.x+origin.x , p4.y+origin.y );
	Canvas.LineTo( p1.x+origin.x , p1.y+origin.y );
end;

procedure TShip.Explode;
var
	 p1,p2,p3,p4 : TPoint;
begin
	Condemn();

	p1.x := origin.x + Round(radius*sind(angle));
	p1.y := origin.y + Round(radius*cosd(angle));

	p2.x := origin.x + Round(radius*sind(angle+130));
	p2.y := origin.y + Round(radius*cosd(angle+130));

	p3.x := origin.x + Round((radius/4)*sind(angle+180));
	p3.y := origin.y + Round((radius/4)*cosd(angle+180));

	p4.x := origin.x + Round(radius*sind(angle+230));
	p4.y := origin.y + Round(radius*cosd(angle+230));

	owner.Add( TDebris.Create( p1, p2, screenSize ) );
	owner.Add( TDebris.Create( p2, p3, screenSize ) );
	owner.Add( TDebris.Create( p3, p4, screenSize ) );
	owner.Add( TDebris.Create( p4, p1, screenSize ) );
  end;

procedure TShip.Rotate( adjust : integer);
begin
  angle := (angle + adjust + 360) mod 360;
end;

procedure TShip.AddThrust( adjust : integer);
begin
  Inc(thrust,adjust);
  if (thrust < 0) then thrust := 0;
end;

function TShip.Update: integer;
var
	len : integer;
  meteor : TSprite;
begin
	mx := mx + thrust*sind( angle );
	my := my + thrust*cosd( angle );
	len := round((sqrt(mx*mx+my*my)));
	if (len > MAX_SPEED) then
  begin
	  mx := mx/len*MAX_SPEED;
	  my := my/len*MAX_SPEED;
	  thrust := 0;
	end;
	Inc(origin.x, Round(mx));
	Inc(origin.y, Round(my));
	Wrap();
	// check to see if we hit a meteor
  meteor := owner.CheckForHitMeteor( origin );
	if (Assigned(meteor)) then Exit(-9999);
	Result := 0;
end;

function  TShip.CreateNewShot: TShot;
var
   shotDir : TSize;
   shotOrigin : TPoint;
begin
	shotDir.cx := Round(10*sind(angle) + mx);
  shotDir.cy := Round(10*cosd(angle) + my);
	shotOrigin := Point(origin.x + Round(radius*sind( angle )), origin.y + Round(radius*cosd( angle )) );
	Result := TShot.Create( shotOrigin,shotDir, 20 );
end;




constructor TSprMessage.Create( aOrigin : TPoint);
begin
   inherited Create(DisplaySize);
   origin := aOrigin;
end;

procedure TSprMessage.SetText( aText : AnsiString);
begin
	text := aText;
end;

procedure  TSprMessage.Draw( Canvas  : TCanvas);
  const tw = 6;          // text width
        th = 10;         // text height
var
  i    : integer;
  temp : TPoint;
begin
   temp := origin;
   for i := 1 to Length(text) do
   begin
      case (text[i]) of
         '0':
              begin
                Canvas.MoveTo(temp.x,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y+th);
                Canvas.LineTo(temp.x,temp.y+th);
                Canvas.LineTo(temp.x,temp.y);
              end;

         '1':
              begin
                Canvas.MoveTo(temp.x+(tw div 2),temp.y);
                Canvas.LineTo(temp.x+(tw div 2),temp.y+th+1);
              end;

         '2':
              begin
                Canvas.MoveTo(temp.x,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y+(th div 2));
                Canvas.LineTo(temp.x,temp.y+(th div 2));
                Canvas.LineTo(temp.x,temp.y+th);
                Canvas.LineTo(temp.x+tw+1,temp.y+th);
              end;

         '3': begin
                Canvas.MoveTo(temp.x,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y+th);
                Canvas.LineTo(temp.x-1,temp.y+th);
                Canvas.MoveTo(temp.x+tw,temp.y+(th div 2));
                Canvas.LineTo(temp.x-1,temp.y+(th div 2));
              end;

         '4': begin
                Canvas.MoveTo(temp.x,temp.y);
                Canvas.LineTo(temp.x,temp.y+(th div 2));
                Canvas.LineTo(temp.x+tw,temp.y+(th div 2));
                Canvas.MoveTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y+(th+1));
              end;

         '5':
              begin
                Canvas.MoveTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x,temp.y);
                Canvas.LineTo(temp.x,temp.y+(th div 2));
                Canvas.LineTo(temp.x+tw,temp.y+(th div 2));
                Canvas.LineTo(temp.x+tw,temp.y+(th));
                Canvas.LineTo(temp.x-1,temp.y+(th));
              end;

         '6': begin
                Canvas.MoveTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x,temp.y);
                Canvas.LineTo(temp.x,temp.y+th);
                Canvas.LineTo(temp.x+tw,temp.y+th);
                Canvas.LineTo(temp.x+tw,temp.y+(th div 2));
                Canvas.LineTo(temp.x-1,temp.y+(th div 2));
              end;

         '7': begin
                Canvas.MoveTo(temp.x,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y+(th+1));
              end;

         '8': begin
                Canvas.MoveTo(temp.x,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x+tw,temp.y+th);
                Canvas.LineTo(temp.x,temp.y+th);
                Canvas.LineTo(temp.x,temp.y);
                Canvas.MoveTo(temp.x,temp.y+(th div 2));
                Canvas.LineTo(temp.x+tw,temp.y+(th div 2));
              end;

         '9': begin
                Canvas.MoveTo(temp.x,temp.y+th);
                Canvas.LineTo(temp.x+tw,temp.y+th);
                Canvas.LineTo(temp.x+tw,temp.y);
                Canvas.LineTo(temp.x,temp.y);
                Canvas.LineTo(temp.x,temp.y+(th div 2));
                Canvas.LineTo(temp.x+tw,temp.y+(th div 2));
              end;

         '*':  begin// ship
                Canvas.MoveTo(temp.x+(tw div 2),temp.y);
                Canvas.LineTo(temp.x+tw,temp.y+th);
                Canvas.LineTo(temp.x+(tw div 2),temp.y+(th-(th div 4)));
                Canvas.LineTo(temp.x,temp.y+th);
                Canvas.LineTo(temp.x+(tw div 2),temp.y);
              end;
      end;
      Inc(temp.x, tw+tw div 2);
   end;
 end;

procedure  InitSinCosTables;
var
  i : integer;
begin
  adjust := ArcTan(1)/45;
  for i:=0 to 360 do
  begin
	  sinTable[i] := sin(adjust*i);
	  cosTable[i] := cos(adjust*i);
  end;
end;


initialization
InitSinCosTables;
finalization
end.
