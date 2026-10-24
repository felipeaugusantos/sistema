{**********************************************************************************************}
{* Tela responsável por exibir as formulações de umta dll de tinta, essa tela é generica para *}
{* todas as tintas                                                                            *}
{*******************************************************************************************PH*}
unit untFatFormulacaoLibTintas;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB, untFuncEspecificas, AppEvnts, Uni, BitBtnLockedIncrem,
  untTintaMaquina, DBClient, untClientDataSetFactory, untILibTinta, untFuncoessimples,
  untTypesSistema, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoLibTintas = class(TfrmPaiSimples)
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
    libTinta: ILibTinta;
    qryTemp: TUniQuery;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAdicionaFormulacoes;
  public
    { Public declarations }
    strAutInc: String;
    constructor Create(AOwner: TComponent; const libTinta: ILibTinta); reintroduce;
    destructor Destroy; override;

  end;

var
  frmFatFormulacaoLibTintas: TfrmFatFormulacaoLibTintas;

implementation

uses untModuloSPR, untFuncoes, untFatFormulacaoEtiqueta,
  StrUtils, untUniQueryDataSetWrapper;

{$R *.dfm}

{ TfrmFatFormulacaoLibTintas }

procedure TfrmFatFormulacaoLibTintas.pAdicionaFormulacoes;
Var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  intCont: Integer;
  qryFormul: TUniQuery;
begin
  qryFormul := nil;
  Try
    Try
      qryFormul := fCriaQuery(Nil);

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
      strSQL := strSQL + '  DET_ITETIN, ';
      strSQL := strSQL + '  DET_VOLPRO, ';

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
      strSQL := strSQL + '  OPE_NOMOPE AS DET_NOMOPE  ';
      strSQL := strSQL + 'FROM ';

      {******************}
      {*SE FOR ORÇAMENTO*}
      {***************PZ*}
      If (Pos(strCfgExi, 'O_OP_') > 0) Or (strCfgExi = 'VP') Then
      Begin
        strSQL := AnsiReplaceStr(strSQL,'DET_','FDO_');
        strSQL := strSQL + '  TINDOR T ';
        strSQL := strSQL + '  LEFT JOIN CADOPE O ON OPE_CODOPE = FDO_CODVEN ';
      End
      Else
      Begin
        strSQL := strSQL + '  TINDET T ';
        strSQL := strSQL + '  LEFT JOIN CADOPE O ON OPE_CODOPE = DET_CODVEN ';
      End;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  T.AUTOINCREM = :AUTINC ';

      qryFormul.Close;
      qryFormul.SQL.Clear;
      qryFormul.SQL.Add(strSQL);
      qryFormul.ParamByName('AUTINC').AsString := strAutInc;
      qryFormul.Open;

      pCarregaDadosFormulEtiq(qryFormul, ftiDadosEtiq);

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO TMP_FOR' + libTinta.IdePro;
      strSQL := strSQL + ' VALUES ( ';
      strSQL := strSQL + '  :FORMUL, ';
      strSQL := strSQL + '  :QTDBAS ) ';

      fltQtdBas := 0;
      For intCont := 1 To 15 Do
      Begin
        If fGetConfTinta(libTinta.IdePro).fGet('ACUABS') = '2' Then
          fltQtdBas := 0.0;

        If (strCfgExi = 'V') Then
        Begin
          strFormul := qryFormul.FieldByName('DET_FORM' + fStrZero(IntToStr(intCont), 2)).AsString;
          fltQtdBas := fltQtdBas + fFormataFloat(qryFormul.FieldByName('DET_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat, 2);
        End
        Else
        Begin
          strFormul := qryFormul.FieldByName('FDO_FORM' + fStrZero(IntToStr(intCont), 2)).AsString;
          fltQtdBas := fltQtdBas + fFormataFloat(qryFormul.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat, 2);
        End;

        If (fEmptyStr(strFormul)) Then
          Break;

        With qryTemp Do
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
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    pAtualizaTemporaria;
    if Assigned(qryFormul) then FreeAndNil(qryFormul);
  End;
end;

procedure TfrmFatFormulacaoLibTintas.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste('TMP_FOR' + libTinta.IdePro)) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_FOR' + libTinta.IdePro;

  With qryTemp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00';
  End;

end;

procedure TfrmFatFormulacaoLibTintas.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FOR' + libTinta.IdePro + ' (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
  strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';

  With qryTemp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatFormulacaoLibTintas.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_FOR' + libTinta.IdePro) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_FOR' + libTinta.IdePro + ' ';

    With qryTemp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoLibTintas.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaFormulacoes;
end;

procedure TfrmFatFormulacaoLibTintas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  pDeletaTemporaria;
  inherited;
end;

procedure TfrmFatFormulacaoLibTintas.dbgFormulacaoKeyDown(Sender: TObject;
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

destructor TfrmFatFormulacaoLibTintas.Destroy;
begin
  if Assigned(qryTemp) then
    FreeAndNil(qryTemp);

  inherited;
end;

procedure TfrmFatFormulacaoLibTintas.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoLibTintas.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryTemp,
    ftiDadosEtiq);
end;


constructor TfrmFatFormulacaoLibTintas.Create(AOwner: TComponent; const libTinta: ILibTinta);
begin
  inherited Create(AOwner);
  Self.libTinta := libTinta;
  Self.qryTemp := fCriaQuery();
end;

end.
