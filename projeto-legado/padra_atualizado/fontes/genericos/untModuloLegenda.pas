unit untModuloLegenda;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  cxImageList, cxGraphics;

type
  TfrmModuloLegenda = class(TDataModule)
    imglLegenda: TImageList;
    imglSitFin: TImageList;
    imglSitAdt: TImageList;
    imglSobEnc: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
