unit untFatFormulacaoAdvanced;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB, untFuncEspecificas, AppEvnts, Uni, BitBtnLockedIncrem;

type
  TfrmFatFormulacaoAdvanced = class(TfrmPaiSimples)
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
  private
    { Private declarations }
    ftiDadosEtiq: TFormulEtiq;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAdicionaFormulacoes;
    procedure pRetBaseB(qryTinta: TUniQuery);
  public
    { Public declarations }
    strAutInc: String;
    strCaiTab: String;
  end;

var
  frmFatFormulacaoAdvanced: TfrmFatFormulacaoAdvanced;

implementation

uses untModuloSPR, untFuncoes, untFatFormulacaoEtiqueta, untFuncoesSimples,
  StrUtils;

{$R *.dfm}

{ TfrmFatFormulacaoAdvanced }

procedure TfrmFatFormulacaoAdvanced.pAdicionaFormulacoes;
  Var
    strSQL: String;
    strFormul: String;
    strCfgExi: String;

    fltQtdBas: Double;
    intContador: Integer;

    qryGen001: TUniQuery;
begin

  qryGen001 := fCriaQuery(Nil);

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
  strSQL := strSQL + '  DET_FORM15,';

  strSQL := strSQL + '  DET_ITETIN, ';

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

  strSQL := strSQL + 'FROM ';

  {******************}
  {*SE FOR ORÇAMENTO*}
  {***************PZ*}
  If (strCfgExi = 'O') Then
  Begin
    strSQL := AnsiReplaceStr(strSQL,'DET_','FDO_');
    strSQL := strSQL + '  TINDOR  ';
  End
  Else
    strSQL := strSQL + '  TINDET' + strCaiTab + ' ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

  qryGen001.Close;
  qryGen001.SQL.Clear;
  qryGen001.SQL.Add(strSQL);
  qryGen001.ParamByName('AUTINC').AsString := strAutInc;
  qryGen001.Open;

  pCarregaDadosFormulEtiq(qryGen001, ftiDadosEtiq);

  pRetBaseB(qryGen001);

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO TMP_FORSUV ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :FORMUL, ';
  strSQL := strSQL + '  :QTDBAS ) ';

  For intContador := 1 To 10 Do
  Begin

    If (strCfgExi = 'V') Then
    Begin
      strFormul := qryGen001.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      fltQtdBas := fFormataFloat(qryGen001.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat, 2);
    End
    Else
    Begin
      strFormul := qryGen001.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      fltQtdBas := fFormataFloat(qryGen001.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat, 2);
    End;

    If (fEmptyStr(strFormul)) Then
      Break;

    With frmModuloSPR.qryTemporaria3 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := strFormul;
      ParamByName('QTDBAS').AsFloat  := fltQtdBas;
      ExecSQL;
      Close;
    End;

  End;

  qryGen001.Close;
  FreeAndNil(qryGen001);
  pAtualizaTemporaria;

end;

procedure TfrmFatFormulacaoAdvanced.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FORSUV')) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FORSUV ';

  With frmModuloSPR.qryTemporaria3 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00';
  End;

end;

procedure TfrmFatFormulacaoAdvanced.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORSUV (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';

  With frmModuloSPR.qryTemporaria3 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatFormulacaoAdvanced.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORSUV') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORSUV ';

    With frmModuloSPR.qryTemporaria3 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoAdvanced.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaFormulacoes;
end;

procedure TfrmFatFormulacaoAdvanced.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoAdvanced.dbgFormulacaoKeyDown(Sender: TObject;
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

procedure TfrmFatFormulacaoAdvanced.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoAdvanced.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(frmModuloSPR.qryTemporaria3,
    ftiDadosEtiq);
end;

procedure TfrmFatFormulacaoAdvanced.pRetBaseB(qryTinta: TUniQuery);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   ITE_CODITE, ');
  qryGen.SQL.Add('   ITE_DESITE ');
  qryGen.SQL.Add(' FROM ADV_CADADV ');
  qryGen.SQL.Add('   INNER JOIN ADV_CADBAS ');
  qryGen.SQL.Add('     ON ADV_BASE02 = BAS_CODBAS ');
  qryGen.SQL.Add('       AND ADV_UNIDAD = BAS_UNIDAD ');
  qryGen.SQL.Add('   INNER JOIN CADITE ');
  qryGen.SQL.Add('     ON BAS_CODITE = ITE_CODITE ');
  qryGen.SQL.Add(' WHERE CONCAT(IFNULL(ADV_CARTA_,""), IFNULL(ADV_PRODUT, ""), IFNULL(ADV_FORMUL, ""), IFNULL(ADV_UNIDAD, "")) = :ITETIN; ');

  qryGen.ParamByName('ITETIN').AsString := qryTinta.FieldByName('DET_ITETIN').AsString;
  qryGen.Open;

  memBase.Lines.Add('PARTE B: ' + qryGen.FieldByName('ITE_CODITE').AsString + '-' +
    qryGen.FieldByName('ITE_DESITE').AsString);
end;

end.
