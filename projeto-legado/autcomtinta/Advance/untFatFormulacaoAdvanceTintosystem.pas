unit untFatFormulacaoAdvanceTintosystem;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, StdCtrls, Buttons, Controls, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, DB,  AppEvnts, Uni, BitBtnLockedIncrem, untTypesSistema,
  UniClientDataSet,  untFuncoesSimples, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulacaoAdvanceTintosystem = class(TfrmPaiSimples)
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
    qryTemporaria: TUniQuery;
    dtsForAdv: TDataSource;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAdicionaFormulacoes;
    procedure PreencheDados(const qryFormul: TDataSet; strTipDoc: String);
  public
    { Public declarations }
    strAutInc: String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmFatFormulacaoAdvanceTintosystem: TfrmFatFormulacaoAdvanceTintosystem;

implementation

uses  untFatFormulacaoEtiqueta,
  StrUtils,untFuncEspecificas,untTintaMaquina;

{$R *.dfm}

{ TfrmFatFormulacaoAdvanceTintosystem }

procedure TfrmFatFormulacaoAdvanceTintosystem.pAdicionaFormulacoes;
Var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  intContador: Integer;
  qryFormul: TUniQuery;

  strCodIte,
  strCodColRet,
  strDesCol: string;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    pRetItemEDescricaoColorante('ADT', strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

    If (Not fEmptyStr(strDesCol)) Then
    Begin
      Result := Result + '-' + strDesCol;
    End;
  end;

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

      If strCfgExi = 'V' Then
        strSQL := strSQL + '  DET_VOLPRO, '
      Else
        strSQL := strSQL + '  0.0 AS DET_VOLPRO, ';

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
      If (Pos(strCfgExi, 'O_OR_PD_') > 0) Then
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
      PreencheDados(qryFormul, strCfgExi);

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO TMP_FORADT ';
      strSQL := strSQL + 'VALUES ( ';
      strSQL := strSQL + '  :FORMUL, ';
      strSQL := strSQL + '  :QTDBAS ) ';

      fltQtdBas := 0;
      For intContador := 1 To 15 Do
      Begin
        If fGetConfTinta('ADT').fGet('ACUABS') = '2' Then
          fltQtdBas := 0.0;

        If (strCfgExi = 'V') Then
        Begin
          strFormul := qryFormul.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
          fltQtdBas := fltQtdBas + fFormataFloat(qryFormul.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat, 2);
        End
        Else
        Begin
          strFormul := qryFormul.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
          fltQtdBas := fltQtdBas + fFormataFloat(qryFormul.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat, 2);
        End;

        If (fEmptyStr(strFormul)) Then
          Break;

        With qryTemporaria Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('FORMUL').AsString := fDescricaoColorante(strFormul);
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

procedure TfrmFatFormulacaoAdvanceTintosystem.pAtualizaTemporaria;
var
  strSQL: String;
begin
  Try
    Try
      If (Not fTabelaExiste('TMP_FORADT')) Then
        pCriaTemporaria;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  TMP_FORADT ';

      With qryTemporaria Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00';
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.pCriaTemporaria;
var
  strSQL: String;
begin
  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FORADT (';
      strSQL := strSQL + '  TMP_FORMUL VARCHAR(50), ';
      strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';

      With qryTemporaria Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.pDeletaTemporaria;
var
  strSQL: String;
begin
  Try
    Try
      If fTabelaExiste('TMP_FORADT') Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'DROP TABLE TMP_FORADT ';

        With qryTemporaria Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
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
  End;
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.PreencheDados(const qryFormul: TDataSet; strTipDoc: String);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      if qryFormul.FieldByName(IIF(strTipDoc = 'V','DET_VOLPRO','FDO_VOLPRO')).AsFloat > 0 then
      begin
        qryGen.SQL.Text :=
          ' SELECT                             ' +
          '   ITE_CODITE                       ' +
          '   , ITE_DESITE                     ' +
          '   , ITE_REFERE                     ' +
          ' FROM                               ' +
          '   CADITE I                         ' +
          '   INNER JOIN MOVDET D              ' +
          '     ON I.ITE_CODITE = D.DET_ITEEMB ' +
          ' WHERE D.DET_NUMDOC = :NUMDOC       ' +
          '   AND D.DET_ESPDOC = :ESPDOC       ' +
          '   AND D.DET_CODEMP = :CODEMP       ' +
          '   AND D.DET_CODACA = :CODACA       ' +
          '   AND D.DET_EMPACA = :EMPACA       ';
        qryGen.ParamByName('NUMDOC').AsString := qryFormul.FieldByName('DET_NUMDOC').AsString;
        qryGen.ParamByName('ESPDOC').AsString := qryFormul.FieldByName('DET_ESPDOC').AsString;
        qryGen.ParamByName('CODEMP').AsString := qryFormul.FieldByName('DET_CODEMP').AsString;
        qryGen.ParamByName('CODACA').AsString := qryFormul.FieldByName('DET_CODACA').AsString;
        qryGen.ParamByName('EMPACA').AsString := qryFormul.FieldByName('DET_EMPACA').AsString;
        qryGen.Open;

        memBase.Text := Format('EMBALAGEM: %s - %s - %s', [qryGen.FieldByName('ITE_CODITE').AsString,
          qryGen.FieldByName('ITE_DESITE').AsString, qryGen.FieldByName('ITE_REFERE').AsString]);
      end
      else
      begin
        qryGen.SQL.Text :=
          ' SELECT                       ' +
          '   ITE_CODITE                 ' +
          '   , ITE_DESITE               ' +
          '   , ITE_REFERE               ' +
          ' FROM                         ' +
          '   CADITE I                   ' +
          ' WHERE I.ITE_CODITE = :CODITE ';
        qryGen.ParamByName('CODITE').AsString := qryFormul.FieldByName(IIF(strTipDoc = 'V','DET_CODITE','FDO_CODITE')).AsString;
        qryGen.Open;

        memBase.Text := Format('BASE: %s - %s - %s', [qryGen.FieldByName('ITE_CODITE').AsString,
          qryGen.FieldByName('ITE_DESITE').AsString, qryGen.FieldByName('ITE_REFERE').AsString]);
      end;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaFormulacoes;
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  pDeletaTemporaria;
  inherited;
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.dbgFormulacaoKeyDown(Sender: TObject;
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

destructor TfrmFatFormulacaoAdvanceTintosystem.Destroy;
begin
  if Assigned(dtsForAdv) then FreeAndNil(dtsForAdv);
  if Assigned(qryTemporaria) then FreeAndNil(qryTemporaria);
  inherited;
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoAdvanceTintosystem.btnImprimirClick(Sender: TObject);
begin
  inherited;
  TfrmFatFormulacaoEtiqueta.Create(Self).pImprimeEtiqueta(qryTemporaria,
    ftiDadosEtiq);
end;


constructor TfrmFatFormulacaoAdvanceTintosystem.Create(AOwner: TComponent);
begin
  inherited;
  qryTemporaria := fCriaQuery();
  dtsForAdv := fCriaDataSource(qryTemporaria);
  dbgFormulacao.DataSource := dtsForAdv;
end;

end.
