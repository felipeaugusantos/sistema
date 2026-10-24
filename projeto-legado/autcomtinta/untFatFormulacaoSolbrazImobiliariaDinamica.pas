unit untFatFormulacaoSolbrazImobiliariaDinamica;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB,  AppEvnts, Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoSolbrazImobiliariaDinamica = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    dbgFormulacao: TDBGridCitel;
    pnlBotoesFor: TPanel;
    memBase: TMemo;
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
    qrySolImo: TUniQuery;
    dtsSolImo: TDataSource;
    ftiDadosEtiq: TFormulEtiq;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAdicionaFormulacoes;
  public
    { Public declarations }
    strAutInc: String;
  end;

var
  frmFatFormulacaoSolbrazImobiliariaDinamica: TfrmFatFormulacaoSolbrazImobiliariaDinamica;

implementation

uses  untFatFormulacaoEtiqueta, StrUtils,untFuncEspecificas, untTintaMaquina;

{$R *.dfm}

{ TfrmFatFormulacaoSolbrazImobiliariaDinamica }

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.pAdicionaFormulacoes;
  Var
    strSQL: String;
    strFormul: String;
    strCfgExi: String;
    fltQtdBas: Double;
    intContador: Integer;

    qryGen: TUniQuery;

    strCodIte,
    strCodColRet,
    strDesCol: string;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    pRetItemEDescricaoColorante('COL', strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

    If (Not fEmptyStr(strDesCol)) Then
    Begin
      Result := Result + '-' + strDesCol;
    End;
  end;


begin

  strCfgExi := fCfgSis('EXIDOC');

  qryGen := fCriaQuery(Nil);

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

  strSQL := strSQL + '  DET_QTDB01 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB01, ';
  strSQL := strSQL + '  DET_QTDB02 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB02, ';
  strSQL := strSQL + '  DET_QTDB03 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB03, ';
  strSQL := strSQL + '  DET_QTDB04 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB04, ';
  strSQL := strSQL + '  DET_QTDB05 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB05, ';
  strSQL := strSQL + '  DET_QTDB06 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB06 ';
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

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);
  qryGen.ParamByName('AUTINC').AsString := strAutInc;
  qryGen.Open;

  pCarregaDadosFormulEtiq(qryGen, ftiDadosEtiq);

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO TMP_FORSOL ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :FORMUL, ';
  strSQL := strSQL + '  :QTDBAS ) ';

  For intContador := 1 To 6 Do
  Begin

    If (strCfgExi = 'V') Then
    Begin
      strFormul := qryGen.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;

      {********************************}
      {* DIVIDE PELO FATOR DA TINTA   *}
      {*****************************PH*}

      fltQtdBas := qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat / 0.154;
  //                 (fGetFatorML(qryGen.FieldByName('DET_IDEPRO').AsString));
    End
    Else
    Begin
      strFormul := qryGen.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;

      {********************************}
      {* DIVIDE PELO FATOR DA TINTA   *}
      {*****************************PH*}

      fltQtdBas := qryGen.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat / 0.154;
    End;

    If (fEmptyStr(strFormul)) Then
      Break;

    With qrySolImo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := fDescricaoColorante(strFormul);
      if fCfgSis('TOTPRD', varBoolean) then
        fltQtdBas := fltQtdBas * qryGen.FieldByName('QTD').AsFloat;
      
      ParamByName('QTDBAS').AsFloat  := fltQtdBas;
      ExecSQL;
      Close;
    End;

  End;

  qryGen.Close;
  FreeAndNil(qryGen);
  pAtualizaTemporaria;

end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FORSOL')) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FORSOL ';

  With qrySolImo Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    (FieldByName('TMP_QTDBAS') As TFloatField).DisplayFormat := '#,#0.0';
  End;

end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORSOL (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';

  With qrySolImo Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORSOL') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORSOL ';

    With qrySolImo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaFormulacoes;
end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.FormActivate(
  Sender: TObject);
begin
  inherited;
  pSetFocus(dbgFormulacao);
end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.FormCreate(
  Sender: TObject);
begin
  inherited;
  qrySolImo := fCriaQuery(Self);
  dtsSolImo := fCriaDataSource(qrySolImo);
  dbgFormulacao.DataSource := dtsSolImo;
end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.dbgFormulacaoKeyDown(Sender: TObject;
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

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoSolbrazImobiliariaDinamica.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qrySolImo, ftiDadosEtiq);
end;

end.
