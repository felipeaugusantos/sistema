unit untQckConsultaSCPCEmpresarialPlatinum;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxExportPDF, frxDBSet, Data.DB,
  System.Generics.Collections, Vcl.Graphics, Dialogs;

type
  TfrmQckConsultaSCPCEmpresarialPlatinum = class(TDataModule)
    frxExpPDF: TfrxPDFExport;
    frxReport: TfrxReport;
    frxPainel: TfrxDBDataset;
    frxSociosDet: TfrxDBDataset;
    frxParticDet: TfrxDBDataset;
    frxIdent: TfrxDBDataset;
    frxAdmin: TfrxDBDataset;
    frxConsul: TfrxDBDataset;
    frxLocal: TfrxDBDataset;
    frxAdminDet: TfrxDBDataset;
    frxConsulDet: TfrxDBDataset;
    frxSocios: TfrxDBDataset;
    frxPartic: TfrxDBDataset;
    frxConsulMes: TfrxDBDataset;
    frxRelForn: TfrxDBDataset;
    frxTitVencer: TfrxDBDataset;
    frxHistPag: TfrxDBDataset;
    frxRefNeg: TfrxDBDataset;
    frxPendRestr: TfrxDBDataset;
    frxPendRestrDet: TfrxDBDataset;
    frxChqSust: TfrxDBDataset;
    frxChqSustDet: TfrxDBDataset;
    frxChqSemF: TfrxDBDataset;
    frxChqSemFDet: TfrxDBDataset;
    frxProtestos: TfrxDBDataset;
    frxProtestosDet: TfrxDBDataset;
    frxRecuper: TfrxDBDataset;
    frxInfo: TfrxDBDataset;
    frxComportamentoSuaEmpresa: TfrxDBDataset;
    frxAnaSet: TfrxDBDataset;
    frxRepLeg: TfrxDBDataset;
    procedure frxReportBeforePrint(Sender: TfrxReportComponent);
    procedure DataModuleCreate(Sender: TObject);
    function frxReportUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    function fFormataFloatTexto(strFloat: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQckConsultaSCPCEmpresarialPlatinum: TfrmQckConsultaSCPCEmpresarialPlatinum;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmQckConsultaSCPCEmpresarialPlatinum.DataModuleCreate(Sender: TObject);
begin
  frxReport.AddFunction('function fFormataFloatTexto(strFloat: String): String');
end;

function TfrmQckConsultaSCPCEmpresarialPlatinum.fFormataFloatTexto(
  strFloat: String): String;
begin
  Result := strFloat;

  Try
    If Result <> '' Then
      Result := FormatFloat('#,##0.00;-#,##0.00', strToFloat(StringReplace(Result, '.', ',', [])));
  Except
    Result := strFloat;
  End;
end;

procedure TfrmQckConsultaSCPCEmpresarialPlatinum.frxReportBeforePrint(
  Sender: TfrxReportComponent);
  Var
    intContadorMemos,
    intPosicaoNomeDataset: Integer;
    strNomeDataset,
    strNomeCampo,
    strTextoCampo        : String;
begin
  For intContadorMemos := 0 To frxReport.ComponentCount - 1 Do
  BEgin
    If (frxReport.Components[intContadorMemos] Is TfrxMemoView) Then
    Begin
      If TfrxMEmoView(frxReport.Components[intContadorMemos]).Parent Is TfrxDataBand Then
      Begin
        strTextoCampo := TfrxMEmoView(frxReport.Components[intContadorMemos]).Text;
        strNomedataset := TfrxDAtaBand(TfrxMEmoView(frxReport.Components[intContadorMemos]).Parent).DataSetName;

        If System.Pos(strNomedataset, strTextoCampo) > 0 Then
        BEgin
          intPosicaoNomeDataset := System.Pos(strNomedataset, strTextoCampo);

          strNomecampo := Copy(strTextoCampo,
                               intPosicaoNomeDataset + Length(strnomeDataSet) + 2,
                               System.Pos('"]', strTExtoCampo, intPosicaoNomeDataset) -
                                              (intPosicaoNomeDataset + Length(strnomeDataSet) + 2));
          If strNomecampo = '' Then
            strNomecampo := Copy(strTextoCampo,
                                 intPosicaoNomeDataset + Length(strnomeDataSet) + 2,
                                 System.Pos('">', strTExtoCampo, intPosicaoNomeDataset) -
                                                  (intPosicaoNomeDataset + Length(strnomeDataSet) + 2));

           TfrxMEmoView(frxReport.Components[intContadorMemos]).Visible := (Assigned(TfrxDBDataset(TfrxDAtaBand(TfrxMEmoView(frxReport.Components[intContadorMemos]).Parent).Dataset).Dataset)) And
                                                                           (TfrxDBDataset(TfrxDAtaBand(TfrxMEmoView(frxReport.Components[intContadorMemos]).Parent).Dataset).DataSet.FindField(strNomeCampo) <> Nil);
        End;
      End;
    End;
  End;

  TfrxMEmoView(frxReport.FindComponent('Rich1')).Visible := (Assigned(frxIdent.Dataset)) And
                                                            (frxIdent.Dataset.FindField('filiais-cidades') <> Nil);
end;

function TfrmQckConsultaSCPCEmpresarialPlatinum.frxReportUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATAFLOATTEXTO' Then
    Result := fFormataFloatTexto(Params[0]);
end;

end.
