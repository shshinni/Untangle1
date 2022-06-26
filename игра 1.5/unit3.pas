unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  ExtCtrls, Buttons, Unit5;

type

  { TForm2 }

  TForm2 = class(TForm)
    Image0: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;

    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);



  private

  public

  end;

var
  Form2: TForm2;
  lvl:Integer;

implementation
uses unit1;
{$R *.lfm}

{ TForm2 }


procedure TForm2.Image2Click(Sender: TObject);
begin
  Hide;
  lvl := 5;
  Form5.ShowModal;
  Show;
end;

procedure TForm2.Image3Click(Sender: TObject);
begin
   Hide;
  lvl := 10;
  Form5.ShowModal;
  Show;
end;

procedure TForm2.Image4Click(Sender: TObject);
begin
  Hide;
  lvl := 15;
  Form5.ShowModal;
  Show;
end;

procedure TForm2.Image5Click(Sender: TObject);
begin
  Hide;
  lvl := 20;
  Form5.ShowModal;
  Show;
end;

procedure TForm2.Image6Click(Sender: TObject);
begin
  Hide;
  lvl := 25;
  Form5.ShowModal;
  Show;
end;

procedure TForm2.Image7Click(Sender: TObject);
begin
  Hide;
  lvl := 30;
  Form5.ShowModal;
  Show;
end;

procedure TForm2.Image8Click(Sender: TObject);
begin
    Form2.Close;
  Form1.Show;
end;
end.

