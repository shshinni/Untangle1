unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ActnList, math, LCLType;

type

  { TForm5 }

    TForm5 = class(TForm)
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Image1: TImage;
    Panel1: TPanel;
    Label1: TStaticText;

    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
type
  Line = record
    circle1: Integer;
    circle2: Integer;
    color: TColor;
  end;
  Circle = record
    x: integer;
    y: integer;
    color: TColor;
  end;

var
  Form5: TForm5;
  lines, lines1: Array of Line;
  circles, circles1 : Array [1..30] of circle;
  linesAmount: Integer; //количество линий в игре
  maxLines: Integer;  //максимальное количество линий для данного уровня
  allLines: array of array of integer; //массив всех возможных линий
  selectedCircle  : Integer;
  isCircleSelected: Boolean;
  moves:Integer;
  again:Boolean;
  isStarted:Boolean;
  isChecked:Boolean;
  MyBitmap: TBitmap;
implementation
 uses unit1, unit3;
{$R *.lfm}

{ TForm5 }


procedure paintGraph();
var i: Integer;
Begin
  if moves >= 0 then
  Begin
    if MyBitmap<>nil then
    MyBitmap.free;
  MyBitmap := TBitmap.Create;//битовое изображение, которое хранится в памяти пк, никуда не выводится
  MyBitmap.SetSize(form5.Panel1.Width, form5.Panel1.Height); //присаивается размер  панели
  MyBitmap.Canvas.Draw(0,0,Form5.Image1.Picture.Bitmap);  //рисует фон
  for i:=1 to linesamount+lvl do //лвл начальные линии
            Begin
                   MyBitmap.Canvas.Pen.Color:= lines[i].Color;  //берем цвет нашей линии
                   MyBitmap.Canvas.line(circles[lines[i].circle1].x+r div 2,circles[lines[i].circle1].y+r div 2,circles[lines[i].circle2].x+r div 2,circles[lines[i].circle2].y+r div 2);//проводим линию
            end;
  for i:=1 to lvl do
    Begin
        MyBitmap.Canvas.Pen.Color:= circles[i].color;
        MyBitmap.Canvas.Brush.Color:= circles[i].color;
        MyBitmap.Canvas.Ellipse(circles[i].x,circles[i].y,circles[i].x+r,circles[i].y+r);//рисует круг
    end;
  Form5.Panel1.Canvas.Draw(0,0, MyBitmap);//отображаем битовое изображение
  end;
end;

procedure randomCircles();
var i:Integer;
Begin
     for i:=1 to lvl do
         Begin
              circles[i].x := random(Form5.Panel1.Width-50)+25;
              circles[i].y := random(Form5.Panel1.Height-150)+100; //случайным образом присваиваем координаты точкам в пределах панели
         End;
end;

procedure createLinesArray();
var i,j,k:Integer;
Begin
  SetLength(allLines,0,0); //удаляем массив всех возможных линий в выбранном уровне
  SetLength(allLines,maxLines,2); //создаем массив всех возможных линий в выбранном уровне
  k:=0;
  for i:=1 to lvl-1 do
      for j:=i+2 to lvl do
          Begin
               allLines[k,0]  := i;
               allLines[k,1]  := j; //создание всех возможных линий в виде номеров точек
               k+=1
          end;
end;

procedure randomLines();
var i,j,k:Integer;
Begin
  linesAmount :=  random(3*lvl-6-(lvl-1));  //признак планарности графа
  SetLength(Lines,0);//удаляем массив линий
  SetLength(Lines,linesAmount+lvl+1); //устанавливаем необходимую длину массива линий
  For i:=1 to lvl-1 do
      Begin
        Lines[i].circle1 := i;
        Lines[i].circle2:= i+1; //создаем линии, чтобы был связный граф
      end;
  For i:=lvl to lvl + linesAmount do
      Begin
           k:=random(maxLines);//выбор одной из всех возможных линий выбранного уровня
           Lines[i].circle1 := alllines[k,0];
           Lines[i].circle2:= alllines[k,1];  //записываем выбранную линию в массив линий
           for j := k to maxLines-2 do
               Begin
               allLines[j,0]:=allLines[j+1,0];
               allLines[j,1]:=allLines[j+1,1];
               end; //удаление выбранной линии из массива всех возможных линий выбранного уровня
           maxLines -= 1//уменьшение длины массива
      end;
end;

function movesAmount(n:integer):integer;
begin
  if n=5 then
  movesAmount:=3;
  if n=10 then
  movesAmount:=8;
  if n=15 then
  movesAmount:=25;
  if n=20 then
  movesAmount:=50;
  if n=25 then
  movesAmount:=75;
  if n=30 then
  movesAmount:=100;
end;

Function LinesCross(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2:Integer): boolean;
var v1,v2,v3,v4: integer;
begin
  v1 := (bx2 - bx1) * (ay1 - by1) - (by2 - by1) * (ax1 - bx1);
  v2 := (bx2 - bx1) * (ay2 - by1) - (by2 - by1) * (ax2 - bx1);
  v3 := (ax2 - ax1) * (by1 - ay1) - (ay2 - ay1) * (bx1 - ax1);
  v4 := (ax2 - ax1) * (by2 - ay1) - (ay2 - ay1) * (bx2 - ax1);
  LinesCross  := (v1 * v2 < 0) and (v3 * v4 < 0)  //проверка пересечния линий при помощи скалярного произведения векторов
end;

procedure Colors();
var i,j:Integer;
Begin
  for i :=1 to  lvl + linesamount do
      lines[i].color := lk;//присваиваем всем линиям цвет конца игры
  for i :=1 to  lvl do
       circles[i].color := tk; //присваиваем всем точкам цвет конца игры
  for i :=1 to  lvl + linesamount-1 do
      Begin
             for j:=i+1 to lvl + linesamount do
                if (lines[i].circle1 <> lines[j].circle1) and (lines[i].circle1 <> lines[j].circle2) and (lines[i].circle2 <> lines[j].circle1) and (lines[i].circle2 <> lines[j].circle2) then //проверка совпадения точек начала и конца линий
                    if LinesCross(circles[lines[i].circle1].x,circles[lines[i].circle1].y,circles[lines[i].circle2].x,circles[lines[i].circle2].y,circles[lines[j].circle1].x,circles[lines[j].circle1].y,circles[lines[j].circle2].x,circles[lines[j].circle2].y) then
                        Begin
                             lines[i].color:=ln;
                             lines[j].color:=ln;
                             circles[lines[i].circle1].color:=tn;
                             circles[lines[i].circle2].color:=tn;
                             circles[lines[j].circle1].color:=tn;
                             circles[lines[j].circle2].color:=tn;
                        end;
      end;
end;

function check(): boolean;
  var i,k:integer;
begin
  check:=false;//проверка завершения игры
  k:=0;
  for i:= 1 to lvl do
      if circles[i].color=tk then k+=1;
  if k=lvl then check:=true;
 end;

procedure TForm5.Button1Click(Sender: TObject);
var i: Integer;
begin
  isStarted:=true;
  isChecked:=false;
  Form5.Panel1.Canvas.Draw(0,0, Form5.Image1.Picture.Bitmap); //отображение фонового рисунка
  Form5.Panel1.Repaint;//отображение всех компонентов  панели
  moves:=movesAmount(lvl);
  repeat
        Randomize;
        maxLines := 0;
        For i:=1 to lvl-2 do
            maxLines += i;
        randomCircles();
        createLinesArray();
        randomLines();
        Colors();
  until check()=False;
  lines1:=lines;
  circles1:=circles;
  paintGraph();
  Label1.Caption:='Осталось ' + inttostr(moves) + ' ходов';
end;

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Label1.Caption:='';
end;

procedure TForm5.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  key := VK_0;
end;

procedure TForm5.FormKeyPress(Sender: TObject; var Key: char);
begin
  key:=#0;
end;

procedure TForm5.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     key := VK_0;
end;

procedure TForm5.FormPaint(Sender: TObject);
begin
  if MyBitmap<>nil then
  Form5.Panel1.Canvas.Draw(0,0, MyBitmap);
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  isStarted:=false;
  MyBitmap:= nil;
end;

procedure TForm5.BitBtn1Click(Sender: TObject);
begin
  Label1.Caption:='';
  Form5.Close;
  Form2.Show;
end;

procedure TForm5.Action1Execute(Sender: TObject);
begin

end;

procedure TForm5.Action2Execute(Sender: TObject);
begin

end;

procedure TForm5.Action3Execute(Sender: TObject);
begin

end;

procedure TForm5.Action4Execute(Sender: TObject);
begin

end;

procedure TForm5.Action5Execute(Sender: TObject);
begin

end;

procedure TForm5.Action6Execute(Sender: TObject);
begin

end;

procedure TForm5.Action7Execute(Sender: TObject);
begin

end;

procedure TForm5.Action8Execute(Sender: TObject);
begin

end;

procedure TForm5.BitBtn3Click(Sender: TObject);
begin
  isChecked:=false;
  if isStarted then begin
     moves:=movesAmount(lvl);
     Label1.Caption:='Осталось ' + inttostr(moves) + ' ходов';
     circles:= circles1;
     lines:=lines1;
     Colors();
     paintGraph();
  end;
end;

procedure TForm5.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i:Integer;
begin
  if isStarted then
  for i:=1 to lvl do
      if (circles[i].x<=X) and (circles[i].x+r>=X) and (circles[i].y<=Y) and (circles[i].y+r>=Y) then
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
      circles[selectedCircle].x:=X;
      circles[selectedCircle].y:=Y;
      colors();
      paintgraph();
  end;
end;

procedure TForm5.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if isStarted then begin
  isCircleSelected:=False; //освобождаем точку
  if (moves>=0) and (isChecked = False) then
  begin
     if check() then
     begin
         Label1.Caption:='Вы выиграли!' ;
         ShowMessage ('Вы выиграли!');
         moves:=0;
         isChecked:=True;
     end
     else if moves>0 then Label1.Caption:='Осталось ' + inttostr(moves) + ' ходов'
        else begin
                  Label1.Caption:='Вы проиграли...';
                  ShowMessage ('Вы проиграли...');
                  isChecked:=True;
             end;
  end;
  end;
end;
end.
