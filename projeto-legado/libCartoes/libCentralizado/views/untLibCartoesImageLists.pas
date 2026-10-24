unit untLibCartoesImageLists;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  cxImageList, cxGraphics;

type
  TfrmLibCartoesImageLists = class(TForm)
    imlImagensBancos: TcxImageList;
  private
    { Private declarations }
  public
    class function RetornaIndiceBanco(ACodigoBanco: Integer): Integer;
    { Public declarations }
  end;

var
  frmLibCartoesImageLists: TfrmLibCartoesImageLists;

implementation

{$R *.dfm}

{ TfrmLibCartoesImageLists }

class function TfrmLibCartoesImageLists.RetornaIndiceBanco(ACodigoBanco: Integer): Integer;
begin
  Result := 0;

  Case ACodigoBanco Of
      1: Result := 1;
     33: Result := 2;
    341: Result := 3;
    237: Result := 4;
    104: Result := 5;
    756: Result := 6;
    422: Result := 7;
    748: Result := 8;
  End;
end;

end.
