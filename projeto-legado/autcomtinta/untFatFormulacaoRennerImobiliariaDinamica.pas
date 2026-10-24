unit untFatFormulacaoRennerImobiliariaDinamica;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB,  AppEvnts, Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoRennerImobiliariaDinamica = class(TfrmPaiSimples)
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
    qryRenImo: TUniQuery;
    dtsRenImo: TDataSource;
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
  frmFatFormulacaoRennerImobiliariaDinamica: TfrmFatFormulacaoRennerImobiliariaDinamica;

implementation

uses  untFatFormulacaoEtiqueta,
  untTintaMaquina, StrUtils,untFuncEspecificas;

{$R *.dfm}

{ TfrmFatFormulacaoRennerImobiliariaDinamica }

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.pAdicionaFormulacoes;
var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  intContador: Integer;

  qryGen: TUniQuery;
  strQtdBas: String;

  strCodIte,
  strCodColRet,
  strDesCol: string;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    pRetItemEDescricaoColorante('REI', strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

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
  strSQL := strSQL + 'INSERT INTO TMP_FORREI ';
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

      fltQtdBas := qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
  //                 (fGetFatorML(qryGen.FieldByName('DET_IDEPRO').AsString));
    End
    Else
    Begin
      strFormul := qryGen.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;

      {********************************}
      {* DIVIDE PELO FATOR DA TINTA   *}
      {*****************************PH*}

      fltQtdBas := qryGen.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    End;

    if fCfgSis('TOTPRD', varBoolean) then
      fltQtdBas := fltQtdBas * qryGen.FieldByName('QTD').AsFloat;

    strQtdBas := fGetQuantidadeOncaPulsoMl(fltQtdBas, 'REI');    

    If (fEmptyStr(strFormul)) Then
      Break;

    With qryRenImo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := fDescricaoColorante(strFormul);
      ParamByName('QTDBAS').AsString := strQtdBas;
      ExecSQL;
      Close;
    End;

  End;

  qryGen.Close;
  FreeAndNil(qryGen);
  pAtualizaTemporaria;

end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FORREI')) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FORREI ';

  With qryRenImo Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORREI (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS VARCHAR(12) ) ';

  With qryRenImo Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORREI') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORREI ';

    With qryRenImo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaFormulacoes;
end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.FormActivate(
  Sender: TObject);
begin
  inherited;
  pSetFocus(dbgFormulacao);
end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.FormCreate(
  Sender: TObject);
begin
  inherited;
  qryRenImo := fCriaQuery(Self);
  dtsRenImo := fCriaDataSource(qryRenImo);
  dbgFormulacao.DataSource := dtsRenImo;
end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.dbgFormulacaoKeyDown(Sender: TObject;
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

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoRennerImobiliariaDinamica.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryRenImo, ftiDadosEtiq);
end;

end.
