unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls;


type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;
var
  Form3: TForm3;


implementation
 uses unit1;
{$R *.lfm}



{ TForm3 }

procedure TForm3.FormShow(Sender: TObject);
begin
  Label1.Caption:= 'При выборе уровня на экране появляется определенное количество точек, часть из которых соединены линиями. При запуске уровня линии  пересекаются между собой. Цель игры – распутать паутину из линий, двигая точки так, чтобы они не пересекались. Если линии пересекаются, они окрашены одним цветом, если нет, то другим. Как только все линии распутаны - уровень пройден.';
end;

procedure TForm3.Label1Click(Sender: TObject);
begin

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Form3.Close;
  Form1.Show;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

end.

