unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, math;

type

  { TForm5 }

    TForm5 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Image1: TImage;
    Panel1: TPanel;
    Label1: TStaticText;

    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private

  public

  end;
const
  r = 20;
  _Eps: Real=1e-4;
var
  Form5: TForm5;
  lines: Array [1..30,1..30] of Boolean;
  linesColor: Array [1..30,1..30] of TColor;
  circles: Array [1..2,1..30] of Integer;
  circlescolor: array [1..30] of TColor;
  lines1: Array [1..30,1..30] of Boolean;
  linesColor1: Array [1..30,1..30] of TColor;
  circles1: Array [1..2,1..30] of Integer;
  circlescolor1: array [1..30] of TColor;
  linesAmount: Integer;
  maxLines: Integer;
  allLines: array of array of integer;
  selectedCircle  : Integer;
  isCircleSelected: Boolean;
  moves:Integer;
  again:Boolean;
implementation
 uses unit1, unit3, unit4;
{$R *.lfm}

{ TForm5 }



procedure TForm5.Image2Click(Sender: TObject);
begin
  Form5.Close;
  Form2.Show;
end;

procedure TForm5.Label1Click(Sender: TObject);
begin

end;

procedure paintGraph();
var i,j: Integer;
  MyBitmap: TBitmap;
Begin
  if moves >= 0 then
  Begin
  MyBitmap := TBitmap.Create;
  MyBitmap.SetSize(form5.Panel1.Width, form5.Panel1.Height);
  MyBitmap.Canvas.Draw(0,0,Form5.Image1.Picture.Bitmap);

  MyBitmap.Canvas.Brush.Color:= clRed;
  MyBitmap.Canvas.Pen.Color:= clGreen;
    for i:=1 to lvl-1 do
        for j:=i+1 to lvl do
            Begin
                if lines[i,j] then
                Begin
                   MyBitmap.Canvas.Pen.Color:= linesColor[i,j];
                   MyBitmap.Canvas.line(circles[1,i]+r div 2,circles[2,i]+r div 2,circles[1,j]+r div 2,circles[2,j]+r div 2);
                end;
            end;
  for i:=1 to lvl do
    Begin
        MyBitmap.Canvas.Pen.Color:= circlescolor[i];
        MyBitmap.Canvas.Brush.Color:= circlescolor[i];
        MyBitmap.Canvas.Ellipse(circles[1,i],circles[2,i],circles[1,i]+r,circles[2,i]+r);
    end;
  Form5.Panel1.Canvas.Draw(0,0, MyBitmap);
  MyBitmap.Free;
  end
  else
    Form5.Label1.Caption:='Вы проиграли!';


end;

procedure clearLines();
var i,j:Integer;
Begin
  for i :=1 to lvl-1 do
      lines[i,i+1]:=True;
  for i:=1 to lvl-2 do
      for j:=i+2 to lvl do
          lines[i,j]:=False;
  maxLines:=0;
  For i:=1 to lvl-2 do
      maxLines += i;
end;

procedure randomCircles();
var i:Integer;
Begin
     for i:=1 to lvl do
         Begin
              circles[1,i]:=random(Form5.Panel1.Width-50)+25;
              circles[2,i]:=random(Form5.Panel1.Height-150)+100;
         End;
end;

procedure createLinesArray();
var i,j,k:Integer;
Begin
  SetLength(allLines,maxLines,2);
  k:=0;
  for i:=1 to lvl-1 do
      for j:=i+2 to lvl do
          Begin
               allLines[k,0]  := i;
               allLines[k,1]  := j;
               k+=1
          end;
end;

procedure randomLines();
var i,j,k:Integer;
Begin
  linesAmount :=  random(3*lvl-6-(lvl-1));
  For i:=1 to linesAmount do
      Begin
           k:=random(maxLines);
           lines[allLines[k,0],allLines[k,1]]:=True;
           for j := k to maxLines-2 do
               Begin
               allLines[j,0]:=allLines[j+1,0];
               allLines[j,1]:=allLines[j+1,1];
               end;
           maxLines -= 1
      end;
end;

function movesAmount(n:integer):integer;
 var  i,res:Integer;
begin
  if n=5 then
  movesAmount:=3;
  if n=10 then
  movesAmount:=5;
  if n=15 then
  movesAmount:=25;
  if n=20 then
  movesAmount:=50;
  if n=25 then
  movesAmount:=100;
  if n=30 then
  movesAmount:=200;
end;

Function LinesCross(x1,y1,x2,y2,x3,y3,x4,y4:Integer): boolean;
var maxx1,maxx2,maxy1,maxy2,minx1,minx2,miny1,miny2,dx1,dx2,dy1,dy2,dxx,dyy,mul,d: integer;
begin
   LinesCross:=true;
  maxx1:=max(x1,x2);
 maxy1:=max(y1,y2);
 minx1:=min(x1,x2);
 miny1:=min(y1,y2);
 maxx2:=max(x3,x4);
 maxy2:=max(y3,y4);
 minx2:=min(x3,x4);
 miny2:=min(y3,y4);

 if (minx1>maxx2) or (maxx1 < minx2) or (miny1 > maxy2) or (maxy1 < miny2) then LinesCross:=false;

 dx1 := x2-x1;
 dy1 := y2-y1;
 dx2 := x4-x3;
 dy2 := y4-y3;
 dxx := x1-x3;
 dyy := y1-y3;
 d := dy2*dx1-dx2*dy1;

 if d = 0 then LinesCross:=false;
 if (d > 0) then begin
    mul := dx1*dyy-dy1*dxx ;
   if (mul < 0) or (mul > d) then LinesCross:=false;
    mul := dx2*dyy-dy2*dxx;
   if (mul  < 0) or (mul > d) then LinesCross:=false;
 end;

      mul := -(dx1*dyy-dy1*dxx);
if (mul  < 0) or (mul > -d)
  then LinesCross:=false;
   mul := -(dx2*dyy-dy2*dxx);
 if (mul  < 0) or  (mul > -d)
  then LinesCross:=false;


end;

procedure Colors();
var i,j,k,l:Integer;
Begin
  for i :=1 to  lvl-1 do
      for j:=i+1 to  lvl do
           linesColor[i,j]:=lk;
  for i :=1 to  lvl do
       circlescolor[i]:=tk;
  for i :=1 to  lvl-1 do
      for j:=i+1 to  lvl do
      Begin
          if lines[i,j] then
             for k:=i+1 to lvl-1 do
                 For l:=k+1 to lvl do
                    if lines[k,l] then
                    if (i <> k) and (i <> l) and (j <> k) and (j <> l) then
                    if LinesCross(circles[i,1],circles[i,2],circles[j,1],circles[j,2],circles[k,1],circles[k,2],circles[l,1],circles[l,2]) then
                        Begin
                             linesColor[i,j]:=ln;
                             linesColor[k,l]:=ln;
                             circlescolor[i]:=tn;
                             circlescolor[j]:=tn;
                             circlescolor[k]:=tn;
                             circlescolor[l]:=tn;
                        end;
      end;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form5.Panel1.Canvas.Draw(0,0, Form5.Image1.Picture.Bitmap);
  Form5.Panel1.Repaint;
  moves:=movesAmount(lvl);
  Randomize;
  clearLines();
  randomCircles();
  createLinesArray();
  randomLines();
  Colors();
  lines1:=lines;
  circles1:=circles;
  linesColor1:=linesColor;
  circlescolor1:=circlescolor;
  paintGraph();
  Label1.Caption:='Осталось ' + inttostr(moves) + ' ходов';
end;

procedure TForm5.BitBtn1Click(Sender: TObject);
begin
  Form5.Close;
  Form2.Show;
end;

procedure TForm5.BitBtn3Click(Sender: TObject);
begin
     moves:=movesAmount(lvl);
     Label1.Caption:='Осталось ' + inttostr(moves) + ' ходов';
     circles:= circles1;
     lines:=lines1;
     linesColor:=linesColor1;
     circlescolor:=circlescolor1;
     paintGraph();
end;

procedure TForm5.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i:Integer;
begin
  for i:=1 to lvl do
      if (circles[1,i]<=X) and (circles[1,i]+r>=X) and (circles[2,i]<=Y) and (circles[2,i]+r>=Y) then
      Begin
          isCircleSelected:=True;
          selectedCircle:=i;
          moves -= 1;
          Exit;
      end;
end;

procedure TForm5.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if isCircleSelected and (x > 0) and (x< panel1.Width - r) and (y > 80) and (y < panel1.Height -r) then
  Begin
      circles[1,selectedCircle]:=X;
      circles[2,selectedCircle]:=Y;
      paintgraph();
  end;

end;

procedure TForm5.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  isCircleSelected:=False;

  if moves>0 then Label1.Caption:='Осталось ' + inttostr(moves) + ' ходов'
  else Label1.Caption:='Вы проиграли!';
end;

end.
