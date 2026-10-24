unit untFatFormulacaoAutoColor;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB,  AppEvnts, Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoAutoColor = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    pnlBotoesFor: TPanel;
    dbgFormulacao: TDBGridCitel;
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
    qryAutCol: TUniQuery;
    dtsAutCol: TDataSource;

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
  frmFatFormulacaoAutoColor: TfrmFatFormulacaoAutoColor;

implementation

uses  untFatFormulacaoEtiqueta,
  StrUtils,untIConfTinta, untTintaMaquina,untFuncEspecificas;

{$R *.dfm}

{ TfrmFatFormulacaoAutoColor }

procedure TfrmFatFormulacaoAutoColor.pAtualizaTemporaria;
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

  With qryAutCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    (FieldByName('TMP_QTDBAS') As TFloatField).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmFatFormulacaoAutoColor.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORBZA (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';

  With qryAutCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;
end;

procedure TfrmFatFormulacaoAutoColor.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORBZA') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORBZA ';

    With qryAutCol Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoAutoColor.pMostraFormulacoes;
  Var
    strSQL: String;
    strFormul: String;
    strCfgExi: String;
    fltQtdBas: Double;
    intContador: Integer;

    qryGen001: TUniQuery;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('AUT');

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

  strSQL := strSQL + '  DET_QTDB01, ';
  strSQL := strSQL + '  DET_QTDB02, ';
  strSQL := strSQL + '  DET_QTDB03, ';
  strSQL := strSQL + '  DET_QTDB04, ';
  strSQL := strSQL + '  DET_QTDB05, ';
  strSQL := strSQL + '  DET_QTDB06, ';
  strSQL := strSQL + '  DET_QTDB07, ';
  strSQL := strSQL + '  DET_QTDB08, ';
  strSQL := strSQL + '  DET_QTDB09, ';
  strSQL := strSQL + '  DET_QTDB10, ';
  strSQL := strSQL + '  DET_QTDB11, ';
  strSQL := strSQL + '  DET_QTDB12, ';
  strSQL := strSQL + '  DET_QTDB13, ';
  strSQL := strSQL + '  DET_QTDB14, ';
  strSQL := strSQL + '  DET_QTDB15 ';
  strSQL := strSQL + '   , IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS QTD ';
  strSQL := strSQL + 'FROM ';

  {******************}
  {*SE FOR ORÇAMENTO*}
  {***************PZ*}
  If (Pos(strCfgExi, 'O_OR_PD_OP_') > 0) Or (strCfgExi = 'VP') Then
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

    //If fArqIniTinta(0, 'AUTOCOLOR', 'ACUABS', '1') = '2' Then
    If conf.fGet('ACUABS') = '2' Then
      fltQtdBas := 0.0;

    If (strCfgExi = 'V') Then
    Begin
      strFormul := qryGen001.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
  //    fltQtdBas := fltQtdBas + qryGen001.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
      fltQtdBas := fltQtdBas + qryGen001.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End
    Else
    Begin
      strFormul := qryGen001.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      fltQtdBas := fltQtdBas + qryGen001.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End;

    If (fEmptyStr(strFormul)) Then
      Break;

    With qryAutCol Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := strFormul;
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

procedure TfrmFatFormulacaoAutoColor.FormShow(Sender: TObject);
begin
  inherited;
  pMostraFormulacoes;

end;

procedure TfrmFatFormulacaoAutoColor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoAutoColor.FormCreate(Sender: TObject);
begin
  inherited;
  qryAutCol := fCriaQuery(Self);
  dtsAutCol := fCriaDataSource(qryAutCol);
  dbgFormulacao.DataSource := dtsAutCol;
end;

procedure TfrmFatFormulacaoAutoColor.dbgFormulacaoKeyDown(Sender: TObject;
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

procedure TfrmFatFormulacaoAutoColor.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoAutoColor.btnImprimirClick(
  Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryAutCol, ftiDadosEtiq);
end;

end.
