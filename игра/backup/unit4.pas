unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox,
  ComCtrls, Spin, MMSystem;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  public

  end;

var
  Form4: TForm4;

implementation
uses unit1;
{$R *.lfm}

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  Form4.Close;
  Form1.Show;
end;

procedure TForm4.ColorBox1Change(Sender: TObject);
begin

end;

procedure TForm4.FormCreate(Sender: TObject);
begin

end;

procedure TForm4.FormShow(Sender: TObject);
begin

end;

procedure TForm4.Label1Click(Sender: TObject);
begin

end;

procedure TForm4.Label3Click(Sender: TObject);
begin

end;

procedure TForm4.Label5Click(Sender: TObject);
begin

end;

procedure TForm4.SpinEdit1Change(Sender: TObject);
begin

end;

procedure TForm4.TrackBar1Change(Sender: TObject);
begin
 WaveOutSetVolume(WAVE_MAPPER,trackbar1.Position * 1000);
end;

procedure TForm4.TrackBar1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

end.

