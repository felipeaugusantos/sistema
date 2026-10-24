unit untQckCtpTitContasSint;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiQck, RLReport, StrUtils, RLParser, RLPreviewForm,
  Data.DB, untIFuncoes;

type
  TfrmQckCtpTitContasSint = class(TfrmPaiQck)
    RLLabel1: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    rllJuros: TRLLabel;
    rllDesconto: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText7: TRLDBText;
    rllLinha: TRLLabel;
    rllGrupo: TRLLabel;
    rllConta: TRLLabel;
    rllEmpresa: TRLLabel;
    rlbTotalLinha: TRLBand;
    RLBand2: TRLBand;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    rllTotalGeral: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel11: TRLLabel;
    rllEventos: TRLLabel;
    rlbGrupo2: TRLGroup;
    rlbTituloGrupo2: TRLBand;
    RLDBText10: TRLDBText;
    rllTitRes: TRLLabel;
    rlbSumarioGrupo2: TRLBand;
    rllTotRes: TRLLabel;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    RLBand1: TRLBand;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText1: TRLDBText;
    rllOrdenacao: TRLLabel;
    rllFimCta: TRLLabel;
    rllIncPrevis: TRLLabel;
    rllFornecedor: TRLLabel;
    rllPorBai: TRLLabel;
    rllValorExibido: TRLLabel;
    rlbTituloGrupo3: TRLBand;
    RLLabel9: TRLLabel;
    RLDBText8: TRLDBText;
    dtsRelatorio: TDataSource;
    rllPortador: TRLLabel;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbTituloGrupoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rllLinhaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllGrupoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText9BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText5BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText7BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel19BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel25BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel20BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel26BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel21BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel27BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel22BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel28BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel4BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel5BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel6BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel11BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel17BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel23BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel2BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbResumoGrupoAfterPrint(Sender: TObject);
    procedure rllJurosBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllDescontoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBResult8BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBResult7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    strCodCta, strLinha, strGrupo: String;
    curValorGrupo1, curValorGrupo2, curValorGrupo3, curValorGrupo4,
    curValorLinha1, curValorLinha2, curValorLinha3, curValorLinha4,
    curValorGeral1, curValorGeral2, curValorGeral3, curValorGeral4: Currency;
    { Private declarations }
  public
    strValExi : String;
  end;

var
  frmQckCtpTitContasSint: TfrmQckCtpTitContasSint;

implementation

uses untfuncoesFactory;

{$R *.dfm}

procedure TfrmQckCtpTitContasSint.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strOrdem;
end;

procedure TfrmQckCtpTitContasSint.RLDBText4BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
  Var
    strCodigo: String;
begin
  inherited;
  strCodigo := dtsRelatorio.dataSet.FieldByName('CTP_CODCTA').AsString;
  Insert('.', strCodigo, 3);
  Insert('.', strCodigo, 6);
  //Text := strCodigo + ' - ' + dtsRelatorio.dataSet.FieldByName('CTA_DESCTA').AsString;
  Text := strCodigo + ' - ' + fRetNomeConta(dtsRelatorio.dataSet.FieldByName('CTP_CODCTA').AsString);
end;

procedure TfrmQckCtpTitContasSint.rlbTituloGrupoBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;
  strCodCta := dtsRelatorio.dataSet.FieldByName('CTP_CODCTA').AsString;
  rlbTotalLinha.Visible := False;
  Insert('.', strCodCta, 3);
  Insert('.', strCodCta, 6);
  strLinha := LeftStr(strCodCta,2) + '.00.000';
  strGrupo := LeftStr(strCodCta,5) + '.000';
end;

procedure TfrmQckCtpTitContasSint.rllLinhaBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := 'LINHA: ' + strLinha + ' - ' + fRetNomeConta(AnsiReplaceStr(strLinha,'.',''));
end;

procedure TfrmQckCtpTitContasSint.rllDescontoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.rllGrupoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := 'GRUPO: ' + strGrupo + ' - ' + fRetNomeConta(AnsiReplaceStr(strGrupo,'.',''));
end;

procedure TfrmQckCtpTitContasSint.rllJurosBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLDBText9BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  curValorGrupo1   := curValorGrupo1 + dtsRelatorio.dataSet.FieldByName('VALOR').AsCurrency;
  curValorLinha1   := curValorLinha1 + dtsRelatorio.dataSet.FieldByName('VALOR').AsCurrency;
  curValorGeral1   := curValorGeral1 + dtsRelatorio.dataSet.FieldByName('VALOR').AsCurrency;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('VALOR').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckCtpTitContasSint.RLDBResult7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLDBResult8BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLDBText3BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  curValorGrupo2   := curValorGrupo2 + dtsRelatorio.dataSet.FieldByName('VALPAG').AsCurrency;
  curValorLinha2   := curValorLinha2 + dtsRelatorio.dataSet.FieldByName('VALPAG').AsCurrency;
  curValorGeral2   := curValorGeral2 + dtsRelatorio.dataSet.FieldByName('VALPAG').AsCurrency;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('VALPAG').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckCtpTitContasSint.RLDBText5BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If strValExi = '1' Then
  Begin
    curValorGrupo3   := curValorGrupo3 + dtsRelatorio.dataSet.FieldByName('VALJUR').AsCurrency;
    curValorLinha3   := curValorLinha3 + dtsRelatorio.dataSet.FieldByName('VALJUR').AsCurrency;
    curValorGeral3   := curValorGeral3 + dtsRelatorio.dataSet.FieldByName('VALJUR').AsCurrency;
    Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('VALJUR').AsCurrency,ffNumber,15,2);
  End
  Else
  Begin
    Text := '';
    curValorGrupo3 := 0;
    curValorLinha3 := 0;
    curValorGeral3 := 0;
    PrintIt := False;
  End;
end;

procedure TfrmQckCtpTitContasSint.RLDBText7BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If strValExi = '1' Then
  Begin  
    curValorGrupo4   := curValorGrupo4 + dtsRelatorio.dataSet.FieldByName('VALDES').AsCurrency;
    curValorLinha4   := curValorLinha4 + dtsRelatorio.dataSet.FieldByName('VALDES').AsCurrency;
    curValorGeral4   := curValorGeral4 + dtsRelatorio.dataSet.FieldByName('VALDES').AsCurrency;
    Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('VALDES').AsCurrency,ffNumber,15,2);
  End
  Else
  Begin
    curValorGrupo4 := 0;
    curValorLinha4 := 0;
    curValorGeral4 := 0;
    Text := '';
    PrintIt := False;
  End;
end;

procedure TfrmQckCtpTitContasSint.RLLabel19BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo1,ffNumber,15,2);
  curValorGrupo1 := 0;
end;

procedure TfrmQckCtpTitContasSint.RLLabel25BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha1,ffNumber,15,2);
  curValorLinha1 := 0;
end;

procedure TfrmQckCtpTitContasSint.RLLabel20BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo2,ffNumber,15,2);
  curValorGrupo2 := 0;
end;

procedure TfrmQckCtpTitContasSint.RLLabel26BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha2,ffNumber,15,2);
  curValorLinha2 := 0;
end;

procedure TfrmQckCtpTitContasSint.RLLabel21BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo3,ffNumber,15,2);
  curValorGrupo3 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLLabel27BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha3,ffNumber,15,2);
  curValorLinha3 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLLabel22BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo4,ffNumber,15,2);
  curValorGrupo4 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLLabel28BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha4,ffNumber,15,2);
  curValorLinha4 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLLabel4BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral1,ffNumber,15,2);
  curValorGeral1 := 0;
end;

procedure TfrmQckCtpTitContasSint.RLLabel5BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral2,ffNumber,15,2);
  curValorGeral2 := 0;
end;

procedure TfrmQckCtpTitContasSint.RLLabel6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral3,ffNumber,15,2);
  curValorGeral3 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLLabel11BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral4,ffNumber,15,2);
  curValorGeral4 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContasSint.RLLabel17BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpTitContasSint.RLLabel23BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpTitContasSint.RLLabel2BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpTitContasSint.rlbResumoGrupoAfterPrint(
  Sender: TObject);
begin
  inherited;
  strCodCta := dtsRelatorio.dataSet.FieldByName('CTP_CODCTA').AsString;
  If LeftStr(strCodCta,2) <> LeftStr(strLinha,2) Then
  Begin
    rlbTotalLinha.Visible  := True;
    rllLinha.Visible       := True;
    rllGrupo.Visible       := True;
    rlbResumoGrupo.Visible := True;
  End
  Else
  If LeftStr(strCodCta,4) <> LeftStr(AnsiReplaceStr(strGrupo,'.',''),4) Then
  Begin
    rlbTotalLinha.Visible   := False;
    rllLinha.Visible        := False;
    rlbResumoGrupo.Visible  := True;
  End;
  If dtsRelatorio.dataSet.Eof Then
  Begin
    rlbTotalLinha.Visible := True;
  End;
end;

end.

