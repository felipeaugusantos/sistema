unit untFatFormulacaoAlessiImobiliariaDinamica;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB,  AppEvnts, Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoAlessiImobiliariaDinamica = class(TfrmPaiSimples)
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
    qryForAle: TUniQuery;
    dtsForAle: TDataSource;
    ftiDadosEtiq: TFormulEtiq;
    blnPulsos: Boolean;        
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAdicionaFormulacoes;

    function fRetornaQtdeEmOnce(fltQtdBas: Double): String;
  public
    { Public declarations }
    strAutInc: String;
  end;

var
  frmFatFormulacaoAlessiImobiliariaDinamica: TfrmFatFormulacaoAlessiImobiliariaDinamica;

implementation

uses  untFatFormulacaoEtiqueta, StrUtils,untFuncEspecificas, untTintaMaquina;

{$R *.dfm}

{ TfrmFatFormulacaoAlessiImobiliariaDinamica }

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.pAdicionaFormulacoes;
var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  strQtdBas: String;    
  intContador: Integer;

  qryGen: TUniQuery;

  strCodIte,
  strCodColRet,
  strDesCol: string;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    pRetItemEDescricaoColorante('ALE', strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

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
  //Usado para mostrar a quantidade em Once.
  strQtdBas := '';

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
  strSQL := strSQL + '  DET_FORM07, ';
  strSQL := strSQL + '  DET_FORM08, ';
  strSQL := strSQL + '  DET_FORM09, ';
  strSQL := strSQL + '  DET_FORM10, ';
  strSQL := strSQL + '  DET_FORM11, ';
  strSQL := strSQL + '  DET_FORM12, ';
  strSQL := strSQL + '  DET_FORM13, ';
  strSQL := strSQL + '  DET_FORM14, ';
  strSQL := strSQL + '  DET_FORM15, ';
{  strSQL := strSQL + '  DET_FORM16, ';
  strSQL := strSQL + '  DET_FORM17, ';
  strSQL := strSQL + '  DET_FORM18, ';
  strSQL := strSQL + '  DET_FORM19, ';
  strSQL := strSQL + '  DET_FORM20, ';}

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
{  strSQL := strSQL + '  DET_QTDB16 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB16, ';
  strSQL := strSQL + '  DET_QTDB17 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB17, ';
  strSQL := strSQL + '  DET_QTDB18 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB18, ';
  strSQL := strSQL + '  DET_QTDB19 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB19, ';
  strSQL := strSQL + '  DET_QTDB20 / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB20 ';}

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
  strSQL := strSQL + 'INSERT INTO TMP_FORALE ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :FORMUL, ';
  strSQL := strSQL + '  :QTDBAS ) ';

  fltQtdBas := 0.0;

  For intContador := 1 To 20 Do
  Begin
    strFormul := qryGen.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
    If blnPulsos Then
    begin
      if fCfgSis('TOTPRD', varBoolean) then
        strQtdBas := fRetornaQtdeEmOnce(qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat)
      else
        strQtdBas := fRetornaQtdeEmOnce(qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat * qryGen.FieldByName('QTD').AsFloat)
    end
    Else
    begin
      if fCfgSis('TOTPRD', varBoolean) then
        fltQtdBas := qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat * qryGen.FieldByName('QTD').AsFloat
      else
        fltQtdBas := qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
    end;

    If (fEmptyStr(strFormul)) Then
      Break;

    With qryForAle Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := fDescricaoColorante(strFormul);
      If blnPulsos Then
        ParamByName('QTDBAS').AsString := strQtdBas
      Else
        ParamByName('QTDBAS').AsFloat  := fltQtdBas;
      ExecSQL;
      Close;
    End;

  End;

  qryGen.Close;
  FreeAndNil(qryGen);
  pAtualizaTemporaria;

end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FORALE')) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FORALE ';

  With qryForAle Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    If Not blnPulsos Then
      (FieldByName('TMP_QTDBAS') As TFloatField).DisplayFormat := '#,#0.0000';
//    (FieldByName('TMP_QTDBAS') As TFloatField).DisplayFormat := '#,#0.0';
  End;

end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORALE (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  If blnPulsos Then
    strSQL := strSQL + '  TMP_QTDBAS VARCHAR(15) ) '
  Else
    strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';

  With qryForAle Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FORALE') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FORALE ';

    With qryForAle Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaFormulacoes;
end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.FormActivate(
  Sender: TObject);
begin
  inherited;
  pSetFocus(dbgFormulacao);
end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.FormCreate(
  Sender: TObject);
begin
  inherited;
  qryForAle := fCriaQuery(Self);
  dtsForAle := fCriaDataSource(qryForAle);
  dbgFormulacao.DataSource := dtsForAle;
end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.dbgFormulacaoKeyDown(Sender: TObject;
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

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoAlessiImobiliariaDinamica.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryForAle, ftiDadosEtiq);
end;

function TfrmFatFormulacaoAlessiImobiliariaDinamica.fRetornaQtdeEmOnce(
  fltQtdBas: Double): String;
 var
   intParteInteira: Integer;
   fltParteFracao,
   fltCalculo: Double;
begin
  Result := '';

  fltCalculo      := ((fltQtdBas / 48) / 0.61611520);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao  := fStrToFloat(FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));

  Result := IntToStr(intParteInteira) + 'Y' + FormatFloat('#,#0.00',fltParteFracao)
end;

end.
