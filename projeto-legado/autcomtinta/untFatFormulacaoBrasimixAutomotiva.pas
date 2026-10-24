unit untFatFormulacaoBrasimixAutomotiva;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB,  AppEvnts, Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoBrasimixAutomotiva = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    dbgFormulacao: TDBGridCitel;
    pnlBotoesFor: TPanel;
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
    qryBraAut: TUniQuery;
    dtsBraAut: TDataSource;

    ftiDadosEtiq: TFormulEtiq;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pMostraFormulacoes;
  public
    { Public declarations }
    strAutInc: String;
  end;

var
  frmFatFormulacaoBrasimixAutomotiva: TfrmFatFormulacaoBrasimixAutomotiva;

implementation

uses  untFatFormulacaoEtiqueta,
  StrUtils,untIConfTinta, untTintaMaquina,untFuncEspecificas;

{$R *.dfm}

{ TfrmFatFormulacaoBrasimixAutomotiva }

procedure TfrmFatFormulacaoBrasimixAutomotiva.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FORBZA')) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FORBZA ';

  With qryBraAut Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    (FieldByName('TMP_QTDBAS') As TFloatField).DisplayFormat := '#,#0.0';
  End;
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORBZA (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';

  With qryBraAut Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORBZA') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORBZA ';

    With qryBraAut Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.pMostraFormulacoes;
  Var
    strSQL: String;
    strFormul: String;
    strCfgExi: String;
    fltQtdBas: Double;
    intContador: Integer;

    qryGen001: TUniQuery;
    conf: IConfTinta;

    strCodIte,
    strCodColRet,
    strDesCol: string;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    pRetItemEDescricaoColorante('BZA', strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

    If (Not fEmptyStr(strDesCol)) Then
    Begin
      Result := Result + '-' + strDesCol;
    End;
  end;
begin

  conf := fGetConfTinta('BZA');
  strCfgExi := fCfgSis('EXIDOC');

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
  strSQL := strSQL + 'INSERT INTO TMP_FORBZA ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :FORMUL, ';
  strSQL := strSQL + '  :QTDBAS ) ';

  fltQtdBas := 0.0;
  For intContador := 1 To 15 Do
  Begin

//    If fArqIniTinta(0, 'Brasimix Automotiva', 'ACUABS', '1') = '2' Then
    If conf.fGet('ACUABS') = '2' Then
      fltQtdBas := 0.0;

    If (strCfgExi = 'V') Then
    Begin
      strFormul := qryGen001.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      fltQtdBas := fltQtdBas + qryGen001.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End
    Else
    Begin
      strFormul := qryGen001.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      fltQtdBas := fltQtdBas + qryGen001.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End;

    If (fEmptyStr(strFormul)) Then
      Break;

    With qryBraAut Do
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

procedure TfrmFatFormulacaoBrasimixAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
  pMostraFormulacoes;
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgFormulacao);
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  qryBraAut := fCriaQuery(Self);
  dtsBraAut := fCriaDataSource(qryBraAut);
  dbgFormulacao.DataSource := dtsBraAut;
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.dbgFormulacaoKeyDown(Sender: TObject;
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

procedure TfrmFatFormulacaoBrasimixAutomotiva.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoBrasimixAutomotiva.btnImprimirClick(
  Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryBraAut, ftiDadosEtiq);
end;

end.
