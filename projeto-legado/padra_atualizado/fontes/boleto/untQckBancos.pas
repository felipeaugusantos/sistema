unit untQckBancos;

interface

uses
  SysUtils, Classes, frxClass, frxExportPDF, frxBarcode, frxDBSet, frxDMPExport,
  Forms, Uni, UniClientDataSet;

type
  TfrmQckBancos = class(TForm)
    frxBanco: TfrxReport;
    frxBarCodeObject: TfrxBarCodeObject;
    frxPDFExport: TfrxPDFExport;
    frxAgrupamento: TfrxDBDataset;
    frxBoletoCarne: TfrxReport;
    dsBoletoCarne: TfrxDBDataset;
    frxDuplicataMercantil: TfrxReport;
    frxDupAgrupadas: TfrxDBDataset;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxItensMercantil: TfrxDBDataset;
    frxEmpresaMercantil: TfrxDBDataset;
    frxRelatorioDups: TfrxDBDataset;
    frxQRCodePix: TfrxDBDataset;
    dsBoleto1Via_Comprovante: TfrxDBDataset;
    frxBoleto1Via_Comprovante: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    cdsConsulta : TUniClientDataSet;
  public
    { Public declarations }
  end;

implementation

Uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckBancos.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

end;

procedure TfrmQckBancos.FormCreate(Sender: TObject);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriarQuery('SELECT CAST(" " AS CHAR(1000)) AS QRCODEPIX FROM DUAL');
  Try
    LConsulta.Open;
    cdsConsulta := fCriaClientDatSet(LConsulta, True);
    frxQRCodePix.Dataset := cdsConsulta;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmQckBancos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsConsulta);
end;

end.
