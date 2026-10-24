unit untFatFormulacaoTintas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Grids,
  DBGridCitel, DBGrids, DB,  Uni, untFuncoesSimples, untTypesSistema, untTipoTinta, Math,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untTConfiguracaoGrids,
  untConfiguracaoGrids;

const
  cnstEspTinDet: String = 'NF_IF_PA_EP_FF_UC_';

type
  TfrmFatFormulacaoTintas = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    mmoBase: TMemo;
    pnlBotoesFor: TPanel;
    lblTipoFormulacao: TLabel;
    btnCancelarForm: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    cxGridFormulacao1: TcxGrid;
    cxGridFormulacao: TcxGridDBTableView;
    cxGridForCODITE: TcxGridDBColumn;
    cxGridForFORMUL: TcxGridDBColumn;
    cxGridForDESCRI: TcxGridDBColumn;
    cxGridForQTDBAS: TcxGridDBColumn;
    cxGridFormulacao1Level1: TcxGridLevel;
    btnConfigurarGrid: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarFormClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfigurarGridClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    qryFormul: TUniQuery;
    dtsFormul: TDataSource;
    ftiDadosEtiq: TFormulEtiq;
    blnPulsos: Boolean;
    FConfiguracaoGrid: TConfiguracaoGrids;
    { Private declarations }
    procedure pMostraFormulacoes;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pCriaTemporaria;
    function fRetChaveGrid(): String;

    procedure pCarregaEmbalagemAutomotiva(qryGen: TUniQuery; strCfgExi: String);
    procedure pFormataQuantidadeFormulacao;
    procedure pRetiraParteEspecifica(qryGen: TUniQuery; strCfgExi: String);
    function fRetDescricaoCatalisadorAdvanceTintosystems(strCodCol, strCfgExi: String; qryGen: TUniQuery; Var strCodIte: String): String;

    function fTintasQuantidadePulsos: Boolean;
    function fFormataEspecifico(fltQtdIte: Double; strIdePro: String): Double;
  public
    { Public declarations }
    strAutInc: String;
    strIdePro: String;
    strEspDoc: String;
    strDescri: String;
  end;

var
  frmFatFormulacaoTintas: TfrmFatFormulacaoTintas;

implementation

uses untConstantes, StrUtils, untFuncTinta, untCfgRel, TypesRel, untFuncoesEtiquetas;

{$R *.dfm}

procedure TfrmFatFormulacaoTintas.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoTintas.btnConfigurarGridClick(Sender: TObject);
Var
    LConfiguracaoGrids: TfrmConfiguracaoGrids;
begin
  inherited;

  pCriarFormularios(TfrmConfiguracaoGrids, LConfiguracaoGrids);

  Try
    LConfiguracaoGrids.ConfiguracaoGridsObj := FConfiguracaoGrid;
    LConfiguracaoGrids.ChaveGrid := fRetChaveGrid;
    LConfiguracaoGrids.DatasetCampos := cxGridFormulacao.DataController.Dataset;
    LConfiguracaoGrids.WidthAutomaticoCampos := False;
    LConfiguracaoGrids.ShowModal;

    if (LConfiguracaoGrids.Confirmar) Then
      FConfiguracaoGrid.CarregarDadosSalvos(cxGridFormulacao);
  finally
    FreeAndNil(LConfiguracaoGrids);
  end;
end;

procedure TfrmFatFormulacaoTintas.btnImprimirClick(Sender: TObject);
var
  strTipImp: String;
  prmDllEtq: TParamDllEtiquetas;
begin
  inherited;

  If fEmptyStr(ftiDadosEtiq.strNomImp) Then
  Begin
    Try
      qryCfgRel := fCriaQuery;
      TCfgRel.pCarregaConfImpr(qryCfgRel, 'frmFatFormulacaoItens_FORMUL');
      TCfgRel.fPreImpressao(qryCfgRel, ftiDadosEtiq.strNomImp, strTipImp, False);
    Finally
      FreeAndNil(qryCfgRel);
    End;
  End;

  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    prmDllEtq.tpeTipEtq := tpeFomulacaoTinta;
    prmDllEtq.dtsImpres := qryFormul;
    prmDllEtq.ftiDadEti := ftiDadosEtiq;
    prmDllEtq.strOperador := '';

    fImprimeEtiqueta(prmDllEtq);
  Finally
    FreeAndNil(prmDllEtq);
  End;
end;

function TfrmFatFormulacaoTintas.fFormataEspecifico(fltQtdIte: Double;
  strIdePro: String): Double;
Var
  intDec: Integer;
begin
  Result := fltQtdIte;

  If strIdePro = 'SKY' Then
    Result :=  fFormataFloatSky(fltQtdIte)
  Else If strIdePro = 'ROB' Then
  Begin
    intDec := StrToIntDef(fGetConfTinta('ROB').fGet('DECFOR'), 1);
    Result := StrToFloat(FloatToStrF(RoundTo(fltQtdIte, - intDec), ffFixed, 12, 3));
  End
  Else If strIdePro = 'ALA' Then
  Begin
    intDec := StrToIntDef(fGetConfTinta('ALA').fGet('DECFOR'), 1);
    Result := StrToFloat(FloatToStrF(RoundTo(fltQtdIte, - intDec), ffFixed, 12, 3));
  End
  Else If strIdePro = 'BLA' Then
  Begin
    intDec := StrToIntDef(fGetConfTinta('BLA ').fGet('DECFOR'), 1);
    Result := StrToFloat(FloatToStrF(RoundTo(fltQtdIte, - intDec), ffFixed, 12, 3));
  End;
end;

procedure TfrmFatFormulacaoTintas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxGridFormulacao1);
end;

procedure TfrmFatFormulacaoTintas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
  FreeAndNil(dtsFormul);
  FreeAndNil(qryFormul);

  If Assigned(FConfiguracaoGrid) Then
    FreeAndNil(FConfiguracaoGrid);
end;

procedure TfrmFatFormulacaoTintas.FormCreate(Sender: TObject);
begin
  inherited;
  qryFormul := fCriaQuery(Self);
  dtsFormul := fCriaDataSource(qryFormul);
  cxGridFormulacao.DataController.DataSource := dtsFormul;
end;

procedure TfrmFatFormulacaoTintas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) Then
  Begin
    btnCancelarForm.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnImprimir.Click;
  End;
end;

procedure TfrmFatFormulacaoTintas.FormShow(Sender: TObject);
begin
  inherited;
  pMostraFormulacoes;
  Self.Caption := 'Formulação - ' + fRetornaNomeTinta(strIdePro);

  FConfiguracaoGrid := TConfiguracaoGrids.Create(cxGridFormulacao1,
                                                 cxGridFormulacao,
                                                 fRetChaveGrid,
                                                 ['']);
end;

function TfrmFatFormulacaoTintas.fRetChaveGrid: String;
Var
  strTipTinta: String;
begin
  If fTipoTinta(strIdePro) = ttAutomotiva Then
    strTipTinta := '.Automotiva'
  Else
    strTipTinta := '.Industrial.Imobiliaria';

  Result := Concat(Self.Name, '.', cxGridFormulacao.Name, strTipTinta);
end;

function TfrmFatFormulacaoTintas.fRetDescricaoCatalisadorAdvanceTintosystems(
  strCodCol, strCfgExi: String; qryGen: TUniQuery; Var strCodIte: String): String;
var
  qryForTin: TUniQuery;
  strCodAca,
  strEmpAca: String;
  strCodEmb: String;
begin
  Result := '';

  If (Pos(strCfgExi, 'O_OR_PD_OP_OD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP') Then
  Begin
    strCodAca := qryGen.FieldByName('FDO_CODACA').AsString;
    strEmpAca := qryGen.FieldByName('FDO_EMPACA').AsString;
  End
  Else
  Begin
    strCodAca := qryGen.FieldByName('DET_CODACA').AsString;
    strEmpAca := qryGen.FieldByName('DET_EMPACA').AsString;
  End;

  Try
    qryForTin := fCriaQuery;
    With qryForTin Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT FOR_TIPCOR ');
      SQL.Add('   FROM FORTIN ');
      SQL.Add('  WHERE FOR_CODACA = :CODACA ');
      SQL.Add('    AND FOR_EMPACA = :EMPACA ');
      ParamByName('CODACA').AsString := strCodAca;
      ParamByName('EMPACA').AsString := strEmpAca;
      Open;

      If (Not fEmptyStr(FieldByName('FOR_TIPCOR').AsString)) Then
      Begin
        strCodEmb := FieldByName('FOR_TIPCOR').AsString;

        Close;
        SQL.Clear;
        SQL.Add(' SELECT BAS_DESCRI, ');
        SQL.Add('        BAS_CODITE  ');
        SQL.Add('   FROM ADT_CADBAS  ');
        SQL.Add('  WHERE BAS_CODBAS = :CODBAS ');
        SQL.Add('    AND BAS_CODEMB = :CODEMB ');
        SQL.Add('    AND BAS_DESCRI LIKE "%PARTE B%" '); //catalisador
        ParamByName('CODBAS').AsString := strCodCol;
        ParamByName('CODEMB').AsString := strCodEmb;
        Open;

        Result := FieldByName('BAS_DESCRI').AsString;

        strCodIte := FieldByName('BAS_CODITE').AsString;
      End;
    End;
  Finally
    FreeAndNil(qryForTin);
  End;
end;

function TfrmFatFormulacaoTintas.fTintasQuantidadePulsos: Boolean;
begin
  Result := Pos(strIdePro, 'UNI_KIL_EUC_CIM_SHE_LKS_SUV_CAL_SAY_') > 0;
end;

procedure TfrmFatFormulacaoTintas.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste(fNomeTabelaFormulacao(strIdePro))) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + fNomeTabelaFormulacao(strIdePro) + ' ';

  With qryFormul Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    pFormataQuantidadeFormulacao;
  End;
end;

procedure TfrmFatFormulacaoTintas.pCarregaEmbalagemAutomotiva(qryGen: TUniQuery; strCfgExi: String);
var
  qryBase: TUniQuery;
begin
  Try
    qryBase := fCriaQuery;
    With qryBase Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ITE_CODITE, ');
      SQL.Add('        ITE_DESITE  ');

      If ((Pos(strCfgExi, 'O_OR_PD_OP_OD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP')) And (Pos(strEspDoc, cnstEspTinDet) <= 0) Then
      Begin
        SQL.Add(' FROM FATDOR ');
        SQL.Add(' LEFT JOIN CADITE ON ITE_CODITE = FDO_ITEEMB ');
        SQL.Add('WHERE  ');
        SQL.Add('      FDO_NUMDOC = :NUMDOC AND ');
        SQL.Add('      FDO_ESPDOC = :ESPDOC AND ');
        SQL.Add('      FDO_CODEMP = :CODEMP AND ');
        SQL.Add('      FDO_CODCLI = :CODCLI AND ');
        SQL.Add('      FDO_CODITE = :CODITE AND ');
        SQL.Add('      FDO_CODACA = :CODACA AND ');
        SQL.Add('      FDO_EMPACA = :EMPACA ');

        ParamByName('NUMDOC').AsString := qryGen.FieldByName('FDO_NUMDOC').AsString;
        ParamByName('ESPDOC').AsString := qryGen.FieldByName('FDO_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryGen.FieldByName('FDO_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryGen.FieldByName('FDO_CODCLI').AsString;
        ParamByName('CODITE').AsString := qryGen.FieldByName('FDO_CODITE').AsString;
        ParamByName('CODACA').AsString := qryGen.FieldByName('FDO_CODACA').AsString;
        ParamByName('EMPACA').AsString := qryGen.FieldByName('FDO_EMPACA').AsString;
      End
      Else
      Begin
        SQL.Add(' FROM MOVDET ');
        SQL.Add(' LEFT JOIN CADITE ON ITE_CODITE = DET_ITEEMB ');
        SQL.Add('WHERE ');
        SQL.Add('      DET_NUMDOC = :NUMDOC AND ');
        SQL.Add('      DET_ESPDOC = :ESPDOC AND ');
        SQL.Add('      DET_CODEMP = :CODEMP AND ');
        SQL.Add('      DET_CODCLI = :CODCLI AND ');
        SQL.Add('      DET_CODITE = :CODITE AND ');
        SQL.Add('      DET_CODACA = :CODACA AND ');
        SQL.Add('      DET_EMPACA = :EMPACA ');

        ParamByName('NUMDOC').AsString := qryGen.FieldByName('DET_NUMDOC').AsString;
        ParamByName('ESPDOC').AsString := qryGen.FieldByName('DET_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryGen.FieldByName('DET_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryGen.FieldByName('DET_CODCLI').AsString;
        ParamByName('CODITE').AsString := qryGen.FieldByName('DET_CODITE').AsString;
        ParamByName('CODACA').AsString := qryGen.FieldByName('DET_CODACA').AsString;
        ParamByName('EMPACA').AsString := qryGen.FieldByName('DET_EMPACA').AsString;
      End;

      Open;

      If IsEmpty Then
        mmoBase.Text := 'VENDA SEM EMBALAGEM'
      Else
        mmoBase.Text := 'EMBALAGEM: ' + FieldByName('ITE_CODITE').AsString + ' - ' + FieldByName('ITE_DESITE').AsString;

      If Not fEmptyStr(strDescri) Then
        mmoBase.Text := mmoBase.Text + #13#10 + 'COR: ' +strDescri;
    End;
  Finally
    FreeAndNil(qryBase);
  End;
end;

procedure TfrmFatFormulacaoTintas.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE ' + fNomeTabelaFormulacao(strIdePro) + ' (';
  strSQL := strSQL + '  TMP_CODITE VARCHAR(10),  ';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50),  ';
  strSQL := strSQL + '  TMP_DESCRI VARCHAR(255), ';

  if (fTipoTinta(strIdePro) = ttImobiliaria) And ((fCfgSis('PULMLS') = '3') Or (fGetConfTinta(strIdePro).fGetInteger('UNIOPR') = 3)) And
    (strIdePro <> 'ADT') Then
    strSQL := strSQL + '  TMP_QTDBAS VARCHAR(35) ) '
  else
    strSQL := strSQL + '  TMP_QTDBAS NUMERIC(30,4) ) ';

  With qryFormul Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;
end;

procedure TfrmFatFormulacaoTintas.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste(fNomeTabelaFormulacao(strIdePro)) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE ' + fNomeTabelaFormulacao(strIdePro) + ' ';

    With qryFormul Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoTintas.pFormataQuantidadeFormulacao;
begin
  With qryFormul Do
  Begin
    If ((fCfgSis('PULMLS') <> '3')
      And (fGetConfTinta(strIdePro).fGetInteger('UNIOPR') <> 3)) Or (fTipoTinta(strIdePro) = ttAutomotiva)
        Or (strIdePro = 'ADT') Then
    Begin
      If strIdePro = 'ADV' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00'
      Else If strIdePro = 'ADT' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.00'
      Else If strIdePro = 'EUC' Then
      Begin
        If blnPulsos Then
          TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0';
      End
      Else If strIdePro = 'ALE' Then
      Begin
        If Not blnPulsos Then
          TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0000';
      End
      Else If strIdePro = 'FAR' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,###0.000'
      Else If strIdePro = 'DAC' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'BAU' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat :=  '#,#0.0000'
      Else If strIdePro = 'QUA' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat :=  '#,#0.0000'
      Else If strIdePro = 'CIA' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat :=  '#,#0.0000'
      Else If strIdePro = 'LAZ' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'BZI' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.00'
      Else If strIdePro = 'BZA' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'SKY' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If strIdePro = 'GEN' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If strIdePro = 'AJT' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If strIdePro = 'CIM' Then
      Begin
        If blnPulsos Then
          TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0';
      End
      Else If strIdePro = 'CID' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'LKS' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'FUT' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0000'
      Else If strIdePro = 'MZI' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If ((strIdePro = 'MZA') Or (strIdePro = 'MZD')) Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If (strIdePro = 'FAL') Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If (strIdePro = 'LCA') Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00'
      Else If (strIdePro = 'PFA') Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00'
      Else If (strIdePro = 'ALA') Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := fDisplayFormat(StrToIntDef(fGetConfTinta('ALA').fGet('DECFOR'), 1))
      Else If (strIdePro = 'BLA') Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := fDisplayFormat(StrToIntDef(fGetConfTinta('BLA').fGet('DECFOR'), 1))
      Else If strIdePro = 'KIL' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'GLA' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'SAL' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'DUP' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := fDisplayFormat(StrToIntDef(fGetConfTinta('DUP').fGet('DECFOR'), 1))
      Else If strIdePro = 'STA' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'DUX' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'WCP' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,#0.0'
      Else If strIdePro = 'PPG' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := fDisplayFormat(StrToIntDef(fGetConfTinta('PPG').fGet('DECNFM'), 2))
      Else If strIdePro = 'PPX' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := fDisplayFormat(StrToIntDef(fGetConfTinta('PPX').fGet('DECNFM'), 2))
      Else If strIdePro = 'RSI' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If strIdePro = 'ANJ' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00'
      Else If strIdePro = 'WEG' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.00'
      Else If strIdePro = 'NEX' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := fDisplayFormat(StrToIntDef(fGetConfTinta('NEX').fGet('DECNFM'), 2))
      Else If strIdePro = 'IQU' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,###0.000'
      Else If strIdePro = 'LIK' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.00'
      Else If strIdePro = 'AJA' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '0.000'
      Else If strIdePro = 'REN' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,###0.000'
      Else If strIdePro = 'DOX' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,###0.000'
      Else If strIdePro = 'SHE' Then
        TFloatField(FieldByName('TMP_QTDBAS')).DisplayFormat := '#,##0.000';
    End;
  End;

end;

procedure TfrmFatFormulacaoTintas.pMostraFormulacoes;
var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  fltQtdAdt: Double;
  intContador: Integer;
  qryGen: TUniQuery;

  strCodIte,
  strCodColRet,
  strDesCol,
  strLinha_: string;
  strDescri: String;

  intPulsos: Integer;
  intUniOpr: Integer;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := '';

    pRetItemEDescricaoColorante(strIdePro, strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp, strLinha_);

    If (Not fEmptyStr(strDesCol)) Then
    Begin
      Result := strDesCol;
    End
    Else If (strIdePro = 'ADT') Then
    Begin
      //Catalisador da advance tintosystems fica no cadastro de bases
      Result := fRetDescricaoCatalisadorAdvanceTintosystems(strCodCol, strCfgExi, qryGen, strCodIte);
    End;
  end;

begin
  If fEmptyStr(fNomeTabelaFormulacao(strIdePro)) Then
  Begin
    fMensagem('ATENÇÃO','Tabela de formulação da tinta de máquina [ ' + strIdePro  + ' ] não foi encontrada !', ['&Ok']);
    Exit;
  End;

  qryGen := nil;
  Try
    Try

      blnPulsos := fCfgSis('PULMLS') = '1';
      intPulsos := fCfgSis('PULMLS', varInteger);
      lblTipoFormulacao.Caption := IIF(blnPulsos,'Formulação em Pulsos',IIF(intPulsos = 2,'Formulação em MLs','Formulação em Onças'));

      intUniOpr := fGetConfTinta(strIdePro).fGetInteger('UNIOPR'); // A tinta tem a própria configuração
      if (intUniOpr > 0) then
        lblTipoFormulacao.Caption := IIF(intUniOpr = 1,'Formulação em Pulsos',IIF(intUniOpr = 2,'Formulação em MLs','Formulação em Onças'));

      if ((intPulsos = 1) And (intUniOpr = 1)) Or
         ((intPulsos = 1) And (intUniOpr = 0)) then
      begin
        if (Not fTintasQuantidadePulsos) And (fTipoTinta(strIdePro) = ttImobiliaria) then
          lblTipoFormulacao.Caption := 'Formulação em Mls';
      end;

      If ((fTipoTinta(strIdePro) = ttAutomotiva) Or (fTipoTinta(strIdePro) = ttIndustrial)) Or (strIdePro = 'ADT') Then
      Begin
        lblTipoFormulacao.Caption := 'Formulação em Gramas';
        If (fTipoTinta(strIdePro) = ttIndustrial) then
        Begin
          lblTipoFormulacao.Caption := 'Formulação em MLs';
          cxGridForFORMUL.Caption := 'Colorante';
        End
        Else
          cxGridForFORMUL.Caption := 'Base';
      End
      Else
        cxGridForFORMUL.Caption := 'Colorante';

      strCfgExi := fCfgSis('EXIDOC');
      qryGen := fCriaQuery(Nil);
      pAtualizaTemporaria;

      strSQL := '';
      strSQL := strSQL + ' SELECT         ';
      strSQL := strSQL + '   DET_NUMDOC   ';
      strSQL := strSQL + '   , DET_ESPDOC ';
      strSQL := strSQL + '   , DET_CODEMP ';
      strSQL := strSQL + '   , DET_CODCLI ';
      strSQL := strSQL + '   , DET_CODITE ';
      strSQL := strSQL + '   , DET_CODACA ';
      strSQL := strSQL + '   , DET_EMPACA ';
      strSQL := strSQL + '   , DET_IDEPRO ';
      strSQL := strSQL + '   , DET_DESCRI ';
      strSQL := strSQL + '   , DET_TIPPRE ';
      strSQL := strSQL + '   , DET_DTAENT ';
      strSQL := strSQL + '   , DET_HORENT ';
      strSQL := strSQL + '   , DET_MONTAD ';
      strSQL := strSQL + '   , DET_A_N_O_ ';
      strSQL := strSQL + '   , DET_QTDEMB ';
      strSQL := strSQL + '   , IF(DET_QTDEMB > DET_QTDITE, DET_QTDITE, IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE)) AS QTD ';
      strSQL := strSQL + '   , OPE_NOMOPE AS DET_NOMOPE  ';
      strSQL := strSQL + '   , DET_ITETIN ';
      strSQL := strSQL + '   , IFNULL(FOR_CATALI, "") AS FOR_CATALI ';

      strSQL := strSQL + '   , CLI_NOMCLI ';
      strSQL := strSQL + '   , CLI_ENDERE ';
      strSQL := strSQL + '   , CLI_ENDNUM ';
      strSQL := strSQL + '   , CLI_BAIRRO ';
      strSQL := strSQL + '   , CID_NOMCID ';
      strSQL := strSQL + '   , CID_ESTADO ';
      strSQL := strSQL + '   , CLI_C_E_P_ ';
      strSQL := strSQL + '   , CLI_FONE01 ';
      strSQL := strSQL + '   , CLI_FONE02 ';
      strSQL := strSQL + '   , CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP) AS DOCUME ';

      If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0)  Then
      Begin
        strSQL := strSQL + ' , DET_VOLPRO ';
        strSQL := strSQL + ' , DET_LINTIN ';
      End
      Else
      Begin
        strSQL := strSQL + ' , 0.0 AS DET_VOLPRO ';
        strSQL := strSQL + ' , DET_LINLIN ';
      End;

      for intContador := 1 to 20 do
      begin
        strSQL := strSQL + '   , DET_FORM' + fStrZero(intContador, 2) + ' ';
        strSQL := strSQL + '   , DET_QTDB' + fStrZero(intContador, 2) + ' / IF(DET_QTDEMB > DET_QTDITE, DET_QTDITE, IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE)) AS DET_QTDB' + fStrZero(intContador, 2) + ' ';
      end;

      strSQL := strSQL + 'FROM ';

      {******************}
      {*SE FOR ORÇAMENTO*}
      {***************PZ*}
      If ((Pos(strCfgExi, 'O_OR_PD_OP_OD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP')) And
        (Pos(strEspDoc, cnstEspTinDet) <= 0) Then
      Begin
        strSQL := AnsiReplaceStr(strSQL,'DET_','FDO_');
        strSQL := strSQL + '  TINDOR  A';

        strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI ';
        strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';

        strSQL := strSQL + '  LEFT JOIN CADOPE O ON OPE_CODOPE = FDO_CODVEN ';

        strSQL := strSQL + '  LEFT JOIN FORTIN ON FDO_CODACA = FOR_CODACA ';
        strSQL := strSQL + '                  AND FDO_EMPACA = FOR_EMPACA ';
      End
      Else
      Begin
        strSQL := strSQL + '  TINDET A ';

        strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
        strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';

        strSQL := strSQL + '  LEFT JOIN CADOPE O ON OPE_CODOPE = DET_CODVEN ';

        strSQL := strSQL + '  LEFT JOIN FORTIN ON DET_CODACA = FOR_CODACA ';
        strSQL := strSQL + '                  AND DET_EMPACA = FOR_EMPACA ';
      End;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  A.AUTOINCREM = :AUTINC ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('AUTINC').AsString := strAutInc;
      qryGen.Open;

      pCarregaDadosFormulEtiq(qryGen, ftiDadosEtiq, False, strEspDoc);
      pRetiraParteEspecifica(qryGen, strCfgExi);

      If (fTipoTinta(strIdePro) = ttAutomotiva) Or (Pos(strIdePro, 'KIN_') > 0) Then
        pCarregaEmbalagemAutomotiva(qryGen, strCfgExi);

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO  ' + fNomeTabelaFormulacao(strIdePro) + ' ';
      strSQL := strSQL + 'VALUES (    ';
      strSQL := strSQL + '  :CODITE,  ';
      strSQL := strSQL + '  :FORMUL,  ';
      strSQL := strSQL + '  :DESCRI,  ';
      strSQL := strSQL + '  :QTDBAS ) ';

      fltQtdBas := 0.0;
      fltQtdAdt := 0.0;
      For intContador := 1 To 20 Do
      Begin

        If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
          strLinha_ := qryGen.FieldByName('DET_LINTIN').AsString
        Else
          strLinha_ := qryGen.FieldByName('FDO_LINLIN').AsString;

        if ((fTipoTinta(strIdePro) = ttAutomotiva) Or (fTipoTinta(strIdePro) = ttIndustrial)) Then
        begin
          If fGetConfTinta(strIdePro).fGet('ACUABS') = '2' Then
            fltQtdBas := 0.0;
        end
        else
          fltQtdBas := 0;

        If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
        Begin
          strFormul := qryGen.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
          fltQtdBas := fltQtdBas + qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;

//          If qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat <= 0 Then
          If fEmptyStr(strFormul) Then
            Continue;
        End
        Else
        Begin
          strFormul := qryGen.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
          fltQtdBas := fltQtdBas + qryGen.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;

//          If qryGen.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat <= 0 Then
          If fEmptyStr(strFormul) Then
            Continue;
        End;

        if fTipoTinta(strIdePro) = ttImobiliaria then
        begin
          fltQtdBas := fltQtdBas / fGetFatorML(strIdePro);
        end;

        If ((fEmptyStr(strFormul)) Or (strFormul = '_')) Then
          Continue;

        With qryFormul Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('FORMUL').AsString := strFormul;

          if fCfgSis('TOTPRD', varBoolean) then
            fltQtdBas := fltQtdBas * qryGen.FieldByName('QTD').AsFloat;

          strDescri := fDescricaoColorante(strFormul);

          If (fCfgSis('IMPDOP') = '2') Then
            ParamByName('DESCRI').AsString := fRetNomProduto(strCodIte)
          Else
            ParamByName('DESCRI').AsString := strDescri;

          ParamByName('CODITE').AsString := strCodIte;

          If (fTipoTinta(strIdePro) = ttImobiliaria)Then
          Begin
            If ((intPulsos = 3) Or (intUniOpr = 3)) And (strIdePro <> 'ADT') Then
              ParamByName('QTDBAS').AsString := fGetQuantidadeOncaPulsoMl(fltQtdBas, strIdePro, strFormul)
            Else
              ParamByName('QTDBAS').AsFloat  := fStrToFloat(fGetQuantidadeOncaPulsoMl(fltQtdBas, strIdePro, strFormul));
          End
          Else
            ParamByName('QTDBAS').AsFloat := fFormataEspecifico(fltQtdBas, strIdePro);

          //Acumulado AdvanceTintoSystem
          If strIdePro = 'ADT' Then
          Begin
            If fGetConfTinta(strIdePro).fGet('ACUABS') = '1' Then
            Begin
              fltQtdAdt := fltQtdAdt + ParamByName('QTDBAS').AsFloat;
              ParamByName('QTDBAS').AsFloat := fltQtdAdt;
            End;
          End;

          ExecSQL;
          Close;
        End;

        pAtualizaTemporaria;
      End;
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

procedure TfrmFatFormulacaoTintas.pRetiraParteEspecifica(qryGen: TUniQuery; strCfgExi: String);
  Var
    qryTinta : TUniQuery;
begin
  If strIdePro = 'ADV' Then
  Begin
    Try
      qryTinta := fCriaQuery(Self);

      With qryTinta Do
      Begin
        SQL.Clear;
        SQL.Add(' SELECT ');
        SQL.Add('   ITE_CODITE, ');
        SQL.Add('   ITE_DESITE  ');
        SQL.Add(' FROM ADV_CADADV ');
        SQL.Add('   INNER JOIN ADV_CADBAS ');
        SQL.Add('     ON ADV_BASE02 = BAS_CODBAS ');
        SQL.Add('     AND ADV_UNIDAD = BAS_UNIDAD ');
        SQL.Add('   INNER JOIN CADITE ');
        SQL.Add('     ON BAS_CODITE = ITE_CODITE ');
        SQL.Add(' WHERE CONCAT(IFNULL(ADV_CARTA_,""), IFNULL(ADV_PRODUT, ""), IFNULL(ADV_FORMUL, ""), IFNULL(ADV_UNIDAD, "")) = :ITETIN; ');

        If qryGen.FindField('DET_ITETIN') <> Nil Then
          ParamByName('ITETIN').AsString := qryGen.FieldByName('DET_ITETIN').AsString
        Else
          ParamByName('ITETIN').AsString := qryGen.FieldByName('FDO_ITETIN').AsString;

        Open;

        If Not IsEmpty Then
          mmoBase.Lines.Add('PARTE B: ' + FieldByName('ITE_CODITE').AsString + '-' + FieldByName('ITE_DESITE').AsString);
      End;
    Finally
      FreeAndNil(qryTinta);
    End;
  End
  Else if strIdePro = 'ADT' then
  Begin
    Try
      qryTinta := fCriaQuery(Self);
      With qryTinta Do
      Begin
        SQL.Clear;
        SQL.Text :=
          ' SELECT                       ' +
          '   ITE_CODITE                 ' +
          '   , ITE_DESITE               ' +
          '   , ITE_REFERE               ' +
          ' FROM                         ' +
          '   CADITE I                   ' +
          ' WHERE I.ITE_CODITE = :CODITE ';
        qryTinta.ParamByName('CODITE').AsString := qryGen.FieldByName(IIF((strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0),'DET_CODITE','FDO_CODITE')).AsString;
        qryTinta.Open;

        mmoBase.Text := Format('BASE: %s - %s - %s', [qryTinta.FieldByName('ITE_CODITE').AsString,
          qryTinta.FieldByName('ITE_DESITE').AsString, qryTinta.FieldByName('ITE_REFERE').AsString]);

        If Not fEmptyStr(strDescri) Then
          mmoBase.Text := mmoBase.Text + #13#10 + 'COR: ' + strDescri;
      End;
    Finally
      FreeAndNil(qryTinta);
    End;
  End;

end;

end.
