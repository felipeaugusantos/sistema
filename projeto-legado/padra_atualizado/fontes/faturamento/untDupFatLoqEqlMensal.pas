unit untDupFatLoqEqlMensal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Datasnap.DBClient,
  Uni, UniClientDataSet, faturamento.Classes.FaturamentoLocEqu,
  untFuncoesRel;

type
  TfrmDupFatLocEqlMensal = class(TfrmPai)
    pnlPrincipal: TPanel;
    grdFatur: TcxGridCitel;
    grdFaturTableView: TcxGridDBTableViewCitel;
    grdFaturTableViewEQF_SEQCON: TcxGridDBColumn;
    grdFaturTableViewEQL_NROCON: TcxGridDBColumn;
    grdFaturTableViewEQL_CODCLI: TcxGridDBColumn;
    grdFaturTableViewEQL_NOMCLI: TcxGridDBColumn;
    grdFaturTableViewEQF_AUT_PD: TcxGridDBColumn;
    grdFaturTableViewEQF_VLRTOT: TcxGridDBColumn;
    grdFaturTableViewEQF_NUMDUP: TcxGridDBColumn;
    grdFaturTableViewEQF_GERBOL: TcxGridDBColumn;
    grdFaturLevel: TcxGridLevel;
    cdsEqlFat: TUniClientDataSet;
    cdsEqlFatEQF_SEQCON: TStringField;
    cdsEqlFatEQL_CODCLI: TStringField;
    cdsEqlFatCLI_NOMCLI: TStringField;
    cdsEqlFatEQF_AUT_PD: TStringField;
    cdsEqlFatEQF_VLRTOT: TFloatField;
    cdsEqlFatEQF_NUMDUP: TStringField;
    cdsEqlFatEQF_GERBOL: TStringField;
    cdsEqlFatEQL_NROCON: TStringField;
    dtsEqlFat: TDataSource;
    blnImprimirRelacao: TBitBtnLocked;
    btnGerarCSL: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure blnImprimirRelacaoClick(Sender: TObject);
    procedure btnGerarCSLClick(Sender: TObject);
  private
    { Private declarations }
    FintLocDec: Integer;
    FstrLocDec: String;

    procedure pCarregarFaturamento;
    procedure pCarregarFaturamentoIndividual(blnGrid: Boolean = True; qryLogEql: TUniQuery = nil);
    procedure pGravaTabelaTemporaria;
  public
    { Public declarations }
    ObjFaturaMensal: TFaturamentoMensalContrato;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmDupFatLocEqlMensal }

procedure TfrmDupFatLocEqlMensal.pGravaTabelaTemporaria;
var
  qryLogEql: TUniQuery;
begin

  qryLogEql := fCriaQuery;

  try
    qryLogEql.SQL.Clear;
    qryLogEql.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_LOQEQL;');
    qryLogEql.SQL.Add('CREATE TEMPORARY TABLE TMP_LOQEQL(        ');
    qryLogEql.SQL.Add('  TMP_SEQCON VARCHAR(20),                 ');
    qryLogEql.SQL.Add('  TMP_NROCON VARCHAR(12),                 ');
    qryLogEql.SQL.Add('  TMP_CODCLI VARCHAR(8),                  ');
    qryLogEql.SQL.Add('  TMP_NOMCLI VARCHAR(60),                 ');
    qryLogEql.SQL.Add('  TMP_AUT_PD VARCHAR(20),                 ');
    qryLogEql.SQL.Add('  TMP_VLRTOT DECIMAL(12,2),               ');
    qryLogEql.SQL.Add('  TMP_NUMDUP VARCHAR(12),                 ');
    qryLogEql.SQL.Add('  TMP_ESPDOC CHAR(2),                     ');
    qryLogEql.SQL.Add('  TMP_EMPDOC CHAR(3),                     ');
    qryLogEql.SQL.Add('  TMP_PARCEL CHAR(3),                     ');
    qryLogEql.SQL.Add('  TMP_GERBOL CHAR(1)                      ');
    qryLogEql.SQL.Add(');                                        ');
    qryLogEql.ExecSQL;

    pCarregarFaturamentoIndividual(False, qryLogEql);
  finally
    FreeAndNil(qryLogEql);
  end;

end;

procedure TfrmDupFatLocEqlMensal.blnImprimirRelacaoClick(Sender: TObject);
begin
  inherited;

  pGravaTabelaTemporaria;

  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(314, 10455, [], [], [], Sender, nil, True);
end;

procedure TfrmDupFatLocEqlMensal.btnGerarCSLClick(Sender: TObject);
begin
  inherited;

  pGravaTabelaTemporaria;

  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(315, 10456, [], [], [], Sender, nil, True);
end;

procedure TfrmDupFatLocEqlMensal.FormCreate(Sender: TObject);
begin
  inherited;

  FintLocDec := fCfgSis('LOCDEC', VarInteger);
  FstrLocDec := '#,##0.' + fStrZero('0', FintLocDec);

  cdsEqlFat.CreateDataSet;
  TFloatField(cdsEqlFat.FieldByName('EQF_VLRTOT')).DisplayFormat := FstrLocDec;

end;

procedure TfrmDupFatLocEqlMensal.FormShow(Sender: TObject);
begin
  inherited;

  If Assigned(ObjFaturaMensal) Then
    pCarregarFaturamento;
end;

procedure TfrmDupFatLocEqlMensal.pCarregarFaturamento;
begin
  If cdsEqlFat.Active Then
    cdsEqlFat.EmptyDataSet;

  pCarregarFaturamentoIndividual;
end;

procedure TfrmDupFatLocEqlMensal.pCarregarFaturamentoIndividual(blnGrid: Boolean = True; qryLogEql: TUniQuery = nil);
var
  intCnt,
  intCont: Integer;
Begin
  For intCnt := 0 to ObjFaturaMensal.ListaFatura.Count-1 Do
  Begin
    if blnGrid then
      ObjFaturaMensal.ListaFatura[intCnt].pCarregarDuplicatas;

    For intCont := 0 to ObjFaturaMensal.ListaFatura[intCnt].Duplicatas.Count-1 Do
    Begin
      If ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].ValorDuplicata <= 0 Then
        Continue;
      if blnGrid then
      begin
        cdsEqlFat.Insert;
        cdsEqlFat.FieldByName('EQF_SEQCON').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.AutInc;
        cdsEqlFat.FieldByName('EQL_NROCON').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.NroContrato;
        cdsEqlFat.FieldByName('EQL_CODCLI').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.CodCliente;
        cdsEqlFat.FieldByName('CLI_NOMCLI').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.CodCliente + ' - ' + ObjFaturaMensal.ListaFatura[intCnt].Contrato.NomCliente;
        cdsEqlFat.FieldByName('EQF_AUT_PD').AsString := ObjFaturaMensal.ListaFatura[intCnt].strDocumentoGerado;
        cdsEqlFat.FieldByName('EQF_VLRTOT').AsFloat  := ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].ValorDuplicata;
        cdsEqlFat.FieldByName('EQF_NUMDUP').AsString :=
            ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].NumDup + '-' +
            ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].EspDoc + '-' +
            ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].EmpDoc + '-' +
            ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].Parcela + '-' +
            FormatFloat(FstrLocDec, ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].ValorReceber);

        If ObjFaturaMensal.blnAgruparDuplicatas Then
          cdsEqlFat.FieldByName('EQF_GERBOL').AsString := IIF(ObjFaturaMensal.blnBoletoImpresso, 'Sim', 'Não')
        Else
          cdsEqlFat.FieldByName('EQF_GERBOL').AsString := IIF(ObjFaturaMensal.ListaFatura[intCnt].blnBoletoImpresso, 'Sim', 'Não');
        cdsEqlFat.Post;
      end
      else
      begin
        qryLogEql.SQL.Clear;
        qryLogEql.SQL.Add('INSERT INTO TMP_LOQEQL(');
        qryLogEql.SQL.Add('  TMP_SEQCON, TMP_NROCON, TMP_CODCLI, TMP_NOMCLI, TMP_AUT_PD, TMP_VLRTOT, TMP_NUMDUP, TMP_ESPDOC, TMP_EMPDOC, TMP_PARCEL, TMP_GERBOL');
        qryLogEql.SQL.Add(')VALUES(');
        qryLogEql.SQL.Add('  :SEQCON, :NROCON, :CODCLI, :NOMCLI, :AUT_PD, :VLRTOT, :NUMDUP, :ESPDOC, :EMPDOC, :PARCEL, :GERBOL');
        qryLogEql.SQL.Add(');');
        qryLogEql.ParamByName('SEQCON').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.AutInc;
        qryLogEql.ParamByName('NROCON').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.NroContrato;
        qryLogEql.ParamByName('CODCLI').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.CodCliente;
        qryLogEql.ParamByName('NOMCLI').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.NomCliente;
        qryLogEql.ParamByName('AUT_PD').AsString := ObjFaturaMensal.ListaFatura[intCnt].strDocumentoGerado;
        qryLogEql.ParamByName('VLRTOT').AsFloat  := ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].ValorDuplicata;
        qryLogEql.ParamByName('NUMDUP').AsString := ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].NumDup;
        qryLogEql.ParamByName('ESPDOC').AsString := ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].EspDoc;
        qryLogEql.ParamByName('EMPDOC').AsString := ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].EmpDoc;
        qryLogEql.ParamByName('PARCEL').AsString := ObjFaturaMensal.ListaFatura[intCnt].Duplicatas[intCont].Parcela;

        If ObjFaturaMensal.blnAgruparDuplicatas Then
          qryLogEql.ParamByName('GERBOL').AsString := IIF(ObjFaturaMensal.blnBoletoImpresso, 'Sim', 'Não')
        Else
          qryLogEql.ParamByName('GERBOL').AsString := IIF(ObjFaturaMensal.ListaFatura[intCnt].blnBoletoImpresso, 'Sim', 'Não');

        qryLogEql.ExecSQL;
      end;
    End;
  End;
End;

end.
