unit untRelatoriosQRCodeDM;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxBarcode, frxDBSet, Data.DB;

type
  TfrmRelatoriosQRCodeDM = class(TDataModule)
    frxQRCodePix40C: TfrxReport;
    frxObjetoQRCode: TfrxBarCodeObject;
    frxRelatorio: TfrxDBDataset;
    dtsRelatorio: TDataSource;
  private
    FValorPix: Double;

    FTextoQRCode: String;
    { Private declarations }
  public
    property ValorPix: Double read FValorPix write FValorPix;
    property TextoQRCode: String read FTextoQRCode write FTextoQRCode;
    { Public declarations }
  end;

var
  frmRelatoriosQRCodeDM: TfrmRelatoriosQRCodeDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
