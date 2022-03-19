unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Unit2, Unit3, Unit4;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button2: TBitBtn;
    Button3: TBitBtn;
    Button4: TBitBtn;
    Button5: TBitBtn;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses MMSystem;
{$R *.lfm}

{ TForm1 }

procedure TForm1.Button5Click(Sender: TObject);
begin
  if MessageDlg('Подтверждение','Действительно выйти?',mtCustom,[mbCancel,mbOk],0) = 1 then close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
sndPlaySound('CS2_AutoplayMusic.wav', SND_ASYNC);
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  Hide;
  Form3.ShowModal;
  Show;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Hide;
  Form4.ShowModal;
  Show;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Hide;
  Form2.ShowModal;
  Show;
end;

end.

