unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  ExtCtrls;


type

  { TForm3 }

  TForm3 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    procedure Image2Click(Sender: TObject);
  private

  public

  end;
var
  Form3: TForm3;

implementation
 uses unit1;
{$R *.lfm}



{ TForm3 }



procedure TForm3.Image2Click(Sender: TObject);
begin
    Form3.Close;
  Form1.Show;
end;
end.

