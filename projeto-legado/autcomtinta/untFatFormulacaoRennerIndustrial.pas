unit untFatFormulacaoRennerIndustrial;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB, untFuncEspecificas, AppEvnts, Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoRennerIndustrial = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    dbgFormulacao: TDBGridCitel;
    pnlBotoesFor: TPanel;
    memBase: TMemo;
    lblTipoFormulacao: TLabel;
    btnCancelarForm: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgFormulacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarFormClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryRennerIndustrial: TUniQuery;
    dtsRennerIndustrial: TDataSource;

    ftiDadosEtiq: TFormulEtiq;
    blnPulsos: Boolean;    
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pMostraFormulacoes;
  public
    { Public declarations }
    strAutInc: String;
  end;

var
  frmFatFormulacaoRennerIndustrial: TfrmFatFormulacaoRennerIndustrial;

implementation

uses untFuncoes, untFatFormulacaoEtiqueta, 
  StrUtils, untIConfTinta, untTintaMaquina;

{$R *.dfm}

{ TfrmFatFormulacaoRennerIndustrial }

procedure TfrmFatFormulacaoRennerIndustrial.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FORREN')) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FORREN ';

  With qryRennerIndustrial Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    (FieldByName('TMP_QTDBAS') As TFloatField).DisplayFormat := '#,###0.000';
  End;
end;

procedure TfrmFatFormulacaoRennerIndustrial.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORREN (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12,3)) ';

  With qryRennerIndustrial Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;
end;

procedure TfrmFatFormulacaoRennerIndustrial.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORREN') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORREN ';

    With qryRennerIndustrial Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoRennerIndustrial.pMostraFormulacoes;
  Var
    strSQL: String;
    strFormul: String;
    strCfgExi: String;
    fltQtdBas: Double;
    intContador: Integer;
    qryGen001: TUniQuery;

    strCodIte,
    strCodColRet,
    strDesCol: string;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    pRetItemEDescricaoColorante('REN', strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

    If (Not fEmptyStr(strDesCol)) Then
    Begin
      Result := Result + '-' + strDesCol;
    End;
  end;
begin

  strCfgExi := fCfgSis('EXIDOC');

  //Converte para pulsos na hora de mostrar.
  blnPulsos := fCfgSis('PULMLS') = '1';
  lblTipoFormulacao.Caption := IIF(blnPulsos,'Formulação em Pulsos','Formulação em MLs');

  qryGen001 := fCriaQuery(Nil);
  pAtualizaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_CODCLI, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_CODACA, ';
  strSQL := strSQL + '  DET_EMPACA, ';
  strSQL := strSQL + '  DET_IDEPRO, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_TIPPRE, ';
  strSQL := strSQL + '  DET_DTAENT, ';
  strSQL := strSQL + '  DET_HORENT, ';
  strSQL := strSQL + '  DET_MONTAD, ';
  strSQL := strSQL + '  DET_A_N_O_, ';
  strSQL := strSQL + '  DET_QTDEMB, ';

  strSQL := strSQL + '  DET_FORM01, ';
  strSQL := strSQL + '  DET_FORM02, ';
  strSQL := strSQL + '  DET_FORM03, ';
  strSQL := strSQL + '  DET_FORM04, ';
  strSQL := strSQL + '  DET_FORM05, ';
  strSQL := strSQL + '  DET_FORM06, ';
  strSQL := strSQL + '  DET_FORM07, ';
  strSQL := strSQL + '  DET_FORM08, ';
  strSQL := strSQL + '  DET_FORM09, ';
  strSQL := strSQL + '  DET_FORM10, ';
  strSQL := strSQL + '  DET_FORM11, ';
  strSQL := strSQL + '  DET_FORM12, ';
  strSQL := strSQL + '  DET_FORM13, ';
  strSQL := strSQL + '  DET_FORM14, ';
  strSQL := strSQL + '  DET_FORM15,';

  strSQL := strSQL + '  DET_QTDB01 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB01, ';
  strSQL := strSQL + '  DET_QTDB02 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB02, ';
  strSQL := strSQL + '  DET_QTDB03 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB03, ';
  strSQL := strSQL + '  DET_QTDB04 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB04, ';
  strSQL := strSQL + '  DET_QTDB05 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB05, ';
  strSQL := strSQL + '  DET_QTDB06 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB06, ';
  strSQL := strSQL + '  DET_QTDB07 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB07, ';
  strSQL := strSQL + '  DET_QTDB08 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB08, ';
  strSQL := strSQL + '  DET_QTDB09 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB09, ';
  strSQL := strSQL + '  DET_QTDB10 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB10, ';
  strSQL := strSQL + '  DET_QTDB11 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB11, ';
  strSQL := strSQL + '  DET_QTDB12 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB12, ';
  strSQL := strSQL + '  DET_QTDB13 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB13, ';
  strSQL := strSQL + '  DET_QTDB14 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB14, ';
  strSQL := strSQL + '  DET_QTDB15 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB15 ';
  strSQL := strSQL + '   , IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS QTD ';
  strSQL := strSQL + 'FROM ';

  {******************}
  {*SE FOR ORÇAMENTO*}
  {***************PZ*}
  If (Pos(strCfgExi, 'O_OR_PD_') > 0) Then
  Begin
    strSQL := AnsiReplaceStr(strSQL,'DET_','FDO_');
    strSQL := strSQL + '  TINDOR  ';
  End
  Else
    strSQL := strSQL + '  TINDET ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

  qryGen001.Close;
  qryGen001.SQL.Clear;
  qryGen001.SQL.Add(strSQL);
  qryGen001.ParamByName('AUTINC').AsString := strAutInc;
  qryGen001.Open;

  pCarregaDadosFormulEtiq(qryGen001, ftiDadosEtiq);

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO TMP_FORREN ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :FORMUL, ';
  strSQL := strSQL + '  :QTDBAS ) ';

  For intContador := 1 To 15 Do
  Begin

    If (strCfgExi = 'V') Then
    Begin
      strFormul := qryGen001.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      If blnPulsos Then
        fltQtdBas := qryGen001.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat
      Else
        fltQtdBas := qryGen001.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End
    Else
    Begin
      strFormul := qryGen001.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      If blnPulsos Then
        fltQtdBas := qryGen001.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat
      Else
        fltQtdBas := qryGen001.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End;

    If (fEmptyStr(strFormul)) Then
      Break;

    With qryRennerIndustrial Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := fDescricaoColorante(strFormul);
      if fCfgSis('TOTPRD', varBoolean) then
        fltQtdBas := fltQtdBas * qryGen001.FieldByName('QTD').AsFloat;

      ParamByName('QTDBAS').AsFloat  := fltQtdBas;
      ExecSQL;
      Close;
    End;

  End;

  qryGen001.Close;
  FreeAndNil(qryGen001);
  pAtualizaTemporaria;

end;

procedure TfrmFatFormulacaoRennerIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgFormulacao);
  pMostraFormulacoes;
end;

procedure TfrmFatFormulacaoRennerIndustrial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoRennerIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  qryRennerIndustrial := fCriaQuery(Self);
  dtsRennerIndustrial := fCriaDataSource(qryRennerIndustrial);
  dbgFormulacao.DataSource := dtsRennerIndustrial;
end;

procedure TfrmFatFormulacaoRennerIndustrial.dbgFormulacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnCancelarForm.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnImprimir.Click;
  End;
end;

procedure TfrmFatFormulacaoRennerIndustrial.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoRennerIndustrial.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryRennerIndustrial, ftiDadosEtiq);
end;

end.
