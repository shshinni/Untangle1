unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox,
  ComCtrls, Spin, ExtCtrls, MMSystem;

type

  { TForm4 }

  TForm4 = class(TForm)
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    TrackBar1: TTrackBar;
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox3Change(Sender: TObject);
    procedure ColorBox4Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;


implementation
uses unit1;
{$R *.lfm}

{ TForm4 }
procedure TForm4.ColorBox1Change(Sender: TObject);
begin
  tn:= ColorBox1.Selected;
end;

procedure TForm4.ColorBox2Change(Sender: TObject);
begin
  tk:= ColorBox2.Selected;
end;

procedure TForm4.ColorBox3Change(Sender: TObject);
begin
  ln:= ColorBox3.Selected;
end;

procedure TForm4.ColorBox4Change(Sender: TObject);
begin
  tk:= ColorBox4.Selected;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  ColorBox1.Selected := tn;
  ColorBox2.Selected := tk;
  ColorBox3.Selected:= ln;
  ColorBox4.Selected := lk;
end;

procedure TForm4.Image3Click(Sender: TObject);
begin
  Form4.Close;
  Form1.Show;
end;

procedure TForm4.TrackBar1Change(Sender: TObject);
begin
 WaveOutSetVolume(WAVE_MAPPER,trackbar1.Position * 600);
end;
end.
