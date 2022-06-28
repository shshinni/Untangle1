unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, RTTICtrls, Unit2, Unit3, Unit4;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  ln,lk,tn,tk: TColor;
  sound: Boolean;
implementation
uses MMSystem;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
sndPlaySound('CS2_AutoplayMusic.wav', SND_ASYNC);
ln := clRed;
lk :=  clLime;
tn := clRed;
tk := clLime;
sound := True;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  Hide;
  Form2.ShowModal;
  Show;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  Hide;
  Form3.ShowModal;
  Show;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  Hide;
  Form4.ShowModal;
  Show;
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  if MessageDlg('Подтверждение','Действительно выйти?',mtCustom,[mbCancel,mbOk],0) = 1 then close;
end;
end.

