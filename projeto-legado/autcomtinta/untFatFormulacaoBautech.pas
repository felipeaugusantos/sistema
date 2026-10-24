unit untFatFormulacaoBautech;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB,  AppEvnts, Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoBautech = class(TfrmPaiSimples)
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
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryForBau: TUniQuery;
    dtsForBau: TDataSource;
    ftiDadosEtiq: TFormulEtiq;
    strPulMl: string;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAdicionaFormulacoes;
  public
    { Public declarations }
    strAutInc: String;
    strCaiTab: String;
  end;

var
  frmFatFormulacaoBautech: TfrmFatFormulacaoBautech;

implementation

uses  untFatFormulacaoEtiqueta, StrUtils, untBautechDinamica,
  untFuncEspecificas, untTintaMaquina;

{$R *.dfm}

{ TfrmFatFormulacaoBautech }

procedure TfrmFatFormulacaoBautech.pAdicionaFormulacoes;
var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  intContador: Integer;
  qryGen: TUniQuery;
  intParteInteira: Integer;
  fltParteFracao: Double;

  strCodIte,
  strCodColRet,
  strDesCol: string;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    pRetItemEDescricaoColorante('BAU', strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

    If (Not fEmptyStr(strDesCol)) Then
    Begin
      Result := Result + '-' + strDesCol;
    End;
  end;

begin

  qryGen := fCriaQuery(Nil);

  //Converte para pulsos na hora de mostrar.
  strPulMl := fCfgSis('PULMLS');
  if strPulMl = '1' then
    lblTipoFormulacao.Caption := 'Formulação em Pulsos'
  else if strPulMl = '2' then
    lblTipoFormulacao.Caption := 'Formulação em MLs'
  else if strPulMl = '3' then
    lblTipoFormulacao.Caption := 'Formulação em Onças';

  pAtualizaTemporaria;

  strCfgExi := fCfgSis('EXIDOC');

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
  strSQL := strSQL + '  DET_FORM15, ';
  strSQL := strSQL + '  DET_FORM16, ';
  strSQL := strSQL + '  DET_FORM17, ';
  strSQL := strSQL + '  DET_FORM18, ';
  strSQL := strSQL + '  DET_FORM19, ';
  strSQL := strSQL + '  DET_FORM20, ';

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
  strSQL := strSQL + '  DET_QTDB15 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB15, ';
  strSQL := strSQL + '  DET_QTDB16 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB16, ';
  strSQL := strSQL + '  DET_QTDB17 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB17, ';
  strSQL := strSQL + '  DET_QTDB18 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB18, ';
  strSQL := strSQL + '  DET_QTDB19 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB19, ';
  strSQL := strSQL + '  DET_QTDB20 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB20 ';
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
    strSQL := strSQL + '  TINDET' + strCaiTab + ' ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);
  qryGen.ParamByName('AUTINC').AsString := strAutInc;
  qryGen.Open;

  pCarregaDadosFormulEtiq(qryGen, ftiDadosEtiq);

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO TMP_FORBAU ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :FORMUL, ';
  strSQL := strSQL + '  :QTDBAS ) ';

  fltQtdBas := 0.0;

  For intContador := 1 To 20 Do
  Begin

    If (strCfgExi = 'V') Then
    Begin
      strFormul := qryGen.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      If MatchStr(strPulMl, ['1', '3']) Then
        fltQtdBas := fFormataFloat(qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat / 0.154, 1)
      Else If strPulMl = '2' Then
        fltQtdBas := qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End
    Else
    Begin
      strFormul := qryGen.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      If MatchStr(strPulMl, ['1', '3']) Then
        fltQtdBas := fFormataFloat(qryGen.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat / 0.154, 1)
      Else
        fltQtdBas := qryGen.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End;

    If (fEmptyStr(strFormul)) Then
      Break;

    With qryForBAU Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := fDescricaoColorante(strFormul);
      if fCfgSis('TOTPRD', varBoolean) then
        fltQtdBas := fltQtdBas * qryGen.FieldByName('QTD').AsFloat;

      if strPulMl = '3' then
      begin
        BautechPulsoParaOnca(fltQtdBas, intParteInteira, fltParteFracao);
        ParamByName('QTDBAS').AsString := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
      end
      else
      begin
        ParamByName('QTDBAS').AsString := FormatFloat('0.000', fltQtdBas);
      end;

      ExecSQL;
      Close;
    End;

  End;

  qryGen.Close;
  FreeAndNil(qryGen);
  pAtualizaTemporaria;

end;

procedure TfrmFatFormulacaoBautech.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FORBAU')) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FORBAU ';

  With qryForBau Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

end;

procedure TfrmFatFormulacaoBautech.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORBAU (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS VARCHAR(12) ) ';

  With qryForBau Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatFormulacaoBautech.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORBAU') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORBAU ';

    With qryForBau Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoBautech.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaFormulacoes;
end;

procedure TfrmFatFormulacaoBautech.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgFormulacao);
end;

procedure TfrmFatFormulacaoBautech.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoBautech.FormCreate(Sender: TObject);
begin
  inherited;
  qryForBau := fCriaQuery(Self);
  dtsForBau := fCriaDataSource(qryForBau);
  dbgFormulacao.DataSource := dtsForBau;
end;

procedure TfrmFatFormulacaoBautech.dbgFormulacaoKeyDown(Sender: TObject;
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

procedure TfrmFatFormulacaoBautech.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoBautech.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryForBau, ftiDadosEtiq);
end;

end.
