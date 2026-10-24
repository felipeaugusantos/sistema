unit untImportCadMetasClientesConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, UniClientDataSet, Uni, Data.DB, Datasnap.DBClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ComCtrls, cxProgressBar, untFuncoesSimples,
  untGravando, frxDBSet;

type
  TfrmImportCadMetasClientesConfirma = class(TfrmPaiConfirma)
    dtsDadosUpd: TDataSource;
    dtsDadosIns: TDataSource;
    cdsClienteNaoImportadaRelatorio: TUniClientDataSet;
    cdsClienteNaoImportadaRelatorioCODCLI: TStringField;
    dtsClienteNaoImportadaRelatorio: TDataSource;
    cdsVendedorNaoImportadaRelatorio: TUniClientDataSet;
    cdsVendedorNaoImportadaRelatorioCODVEN: TStringField;
    dtsVendedorNaoImportadaRelatorio: TDataSource;
    cdsMarcaNaoImportadaRelatorio: TUniClientDataSet;
    cdsMarcaNaoImportadaRelatorioCODMAR: TStringField;
    dtsMarcaNaoImportadaRelatorio: TDataSource;
    cdsGrupoNaoImportadaRelatorio: TUniClientDataSet;
    cdsGrupoNaoImportadaRelatorioCODGRU: TStringField;
    DtsGrupoNaoImportadaRelatorio: TDataSource;
    cdsFornecedorNaoImportadaRelatorio: TUniClientDataSet;
    cdsFornecedorNaoImportadaRelatorioCODFOR: TStringField;
    dtsFornecedorNaoImportadaRelatorio: TDataSource;
    cdsDepartamentoNaoImportadaRelatorio: TUniClientDataSet;
    cdsDepartamentoNaoImportadaRelatorioCODDEP: TStringField;
    dtsDepartamentoNaoImportadaRelatorio: TDataSource;
    pgcContainer: TPageControl;
    tbsAltera: TTabSheet;
    Panel1: TPanel;
    btnDesmUpdAll: TBitBtnLocked;
    btnMarcUpdAll: TBitBtnLocked;
    btnMarcarUpd: TBitBtnLocked;
    tbsInclui: TTabSheet;
    cxgMetaInsert: TcxGrid;
    cxgMetaIns: TcxGridDBTableView;
    cxgMetaInsMARCADO: TcxGridDBColumn;
    cxgMetaLlv: TcxGridLevel;
    Panel2: TPanel;
    btnDesmarcarIncAll: TBitBtnLocked;
    btnMarcarIncAll: TBitBtnLocked;
    btnMarcarInc: TBitBtnLocked;
    cxgMetaInsCODCLI: TcxGridDBColumn;
    cxgMetaInsNOMCLI: TcxGridDBColumn;
    cxgMetaInsCODVEN: TcxGridDBColumn;
    cxgMetaInsNOMVEN: TcxGridDBColumn;
    cxgMetaInsDATINI: TcxGridDBColumn;
    cxgMetaInsDATFIM: TcxGridDBColumn;
    cxgMetaInsCODMAR: TcxGridDBColumn;
    cxgMetaInsNOMMAR: TcxGridDBColumn;
    cxgMetaInsCODGRU: TcxGridDBColumn;
    cxgMetaInsNOMGRU: TcxGridDBColumn;
    cxgMetaInsCODFOR: TcxGridDBColumn;
    cxgMetaInsNOMFOR: TcxGridDBColumn;
    cxgMetaInsCODDEP: TcxGridDBColumn;
    cxgMetaInsNOMDEP: TcxGridDBColumn;
    cxgMetaInsTIPMET: TcxGridDBColumn;
    cxgMetaInsVALMET: TcxGridDBColumn;
    cxgMetaInsPERDES: TcxGridDBColumn;
    cxgMetaUpd: TcxGrid;
    cxgMetaUpdView: TcxGridDBTableView;
    cxgMetaUpdMARCADO: TcxGridDBColumn;
    cxgMetaUpdCODCLI: TcxGridDBColumn;
    cxgMetaUpdNOMCLI: TcxGridDBColumn;
    cxgMetaUpdCODVEN: TcxGridDBColumn;
    cxgMetaUpdNOMVEN: TcxGridDBColumn;
    cxgMetaUpdDATINI: TcxGridDBColumn;
    cxgMetaUpdDATFIM: TcxGridDBColumn;
    cxgMetaUpdCODMAR: TcxGridDBColumn;
    cxgMetaUpdNOMMAR: TcxGridDBColumn;
    cxgMetaUpdCODGRU: TcxGridDBColumn;
    cxgMetaUpdNOMGRU: TcxGridDBColumn;
    cxgMetaUpdCODFOR: TcxGridDBColumn;
    cxgMetaUpdNOMFOR: TcxGridDBColumn;
    cxgMetaUpdCODDEP: TcxGridDBColumn;
    cxgMetaUpdNOMDEP: TcxGridDBColumn;
    cxgMetaUpdTIPMET: TcxGridDBColumn;
    cxgMetaUpdVALMET: TcxGridDBColumn;
    cxgMetaUpdPERDES: TcxGridDBColumn;
    cxgMetaUpdLlv: TcxGridLevel;
    cxgMetaUpdCODMAR_NOVO: TcxGridDBColumn;
    cxgMetaUpdNOMMAR_NOVO: TcxGridDBColumn;
    cxgMetaUpdCODGRU_NOVO: TcxGridDBColumn;
    cxgMetaUpdNOMGRU_NOVO: TcxGridDBColumn;
    cxgMetaUpdCODFOR_NOVO: TcxGridDBColumn;
    cxgMetaUpdNOMFOR_NOVO: TcxGridDBColumn;
    cxgMetaUpdCODDEP_NOVO: TcxGridDBColumn;
    cxgMetaUpdNOMDEP_NOVO: TcxGridDBColumn;
    cxgMetaUpdTIPMET_NOVO: TcxGridDBColumn;
    cxgMetaUpdVALMET_NOVO: TcxGridDBColumn;
    cxgMetaUpdPERDES_NOVO: TcxGridDBColumn;
    frxRepNaoImp: TfrxReport;
    frxRelatorio_Vendedor: TfrxDBDataset;
    frxRelatorio_Marca: TfrxDBDataset;
    frxRelatorio_Fornecedor: TfrxDBDataset;
    frxRelatorio_Cliente: TfrxDBDataset;
    frxRelatorio_Grupo: TfrxDBDataset;
    frxRelatorio_Departamento: TfrxDBDataset;
    btnVisProdNaoImp: TBitBtnLocked;
    cdsDadosIns: TUniClientDataSet;
    cdsDadosInsMARCADO: TIntegerField;
    cdsDadosInsCODCLI: TStringField;
    cdsDadosInsNOMCLI: TStringField;
    cdsDadosInsCODVEN: TStringField;
    cdsDadosInsNOMVEN: TStringField;
    cdsDadosInsDATINI: TStringField;
    cdsDadosInsDATFIM: TStringField;
    cdsDadosInsCODMAR: TStringField;
    cdsDadosInsNOMMAR: TStringField;
    cdsDadosInsCODGRU: TStringField;
    cdsDadosInsNOMGRU: TStringField;
    cdsDadosInsCODFOR: TStringField;
    cdsDadosInsNOMFOR: TStringField;
    cdsDadosInsCODDEP: TStringField;
    cdsDadosInsNOMDEP: TStringField;
    cdsDadosInsTIPMET: TStringField;
    cdsDadosInsVALMET: TFloatField;
    cdsDadosInsPERDES: TFloatField;
    cdsDadosUpd: TUniClientDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    cdsDadosUpdCODMAR_NOVO: TStringField;
    cdsDadosUpdNOMMAR_NOVO: TStringField;
    cdsDadosUpdCODGRU_NOVO: TStringField;
    cdsDadosUpdNOMGRU_NOVO: TStringField;
    cdsDadosUpdCODFOR_NOVO: TStringField;
    cdsDadosUpdNOMFOR_NOVO: TStringField;
    cdsDadosUpdCODDEP_NOVO: TStringField;
    cdsDadosUpdNOMDEP_NOVO: TStringField;
    cdsDadosUpdTIPMET_NOVO: TStringField;
    cdsDadosUpdVALMET_NOVO: TFloatField;
    cdsDadosUpdPERDES_NOVO: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure pIncluiVendedorNaoImportada(strCodigo: String);
    procedure pIncluiClienteNaoImportada(strCodigo: String);
    procedure pIncluiMarcaNaoImportada(strCodigo: String);
    procedure pIncluiGrupoNaoImportada(strCodigo: String);
    procedure pIncluiFornecedorNaoImportada(strCodigo: String);
    procedure pIncluiDepartamentoNaoImportada(strCodigo: String);
    procedure cxgMetaUpdViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgMetaInsCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure tbsAlteraShow(Sender: TObject);
    procedure tbsIncluiShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcarIncClick(Sender: TObject);
    procedure btnMarcarIncAllClick(Sender: TObject);
    procedure btnDesmarcarIncAllClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarUpdClick(Sender: TObject);
    procedure btnMarcUpdAllClick(Sender: TObject);
    procedure btnDesmUpdAllClick(Sender: TObject);
    procedure cxgMetaInsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgMetaUpdViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnVisProdNaoImpClick(Sender: TObject);

  private
    cdsDados: TUniClientDataSet;
    blnMarcar: Boolean;

    procedure pMarcar(cdsDados: TUniClientDataSet);
    procedure pMarcaDesmarcaTodos(blnMarca: boolean);
    function fVerificaSeExisteRegistroNoPeriodoInformado(cdsDados: TUniClientDataSet): Boolean;

    function fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
    function fIncluirRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
    function fAlterarRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
    function fValidaRetornaInfo(strInfoOld, strInfoNovo: String): Variant;
    function fRetornaInfoSePreenchido(strInfo: String): Variant;


  public

  end;

var
  frmImportCadMetasClientesConfirma: TfrmImportCadMetasClientesConfirma;

implementation

{$R *.dfm}

procedure TfrmImportCadMetasClientesConfirma.btnConfirmaClick(Sender: TObject);
Var
  frmIns: TfrmGravando;
  frmAlt: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmIns);
  Try
    frmIns.fExecutarAcao := fIncluirRegistroNoBanco;
    frmIns.lblGravando.Caption := 'Aguarde... Importando o Cadastro de Metas ';
    frmIns.Showmodal
  Finally
    pFreeAndNil(frmIns);
  End;

  pCriarFormularios(TfrmGravando, frmAlt);
  Try
    frmAlt.fExecutarAcao := fAlterarRegistroNoBanco;
    frmAlt.lblGravando.Caption := 'Aguarde... Atualizando o Cadastro de Metas';
    frmAlt.Showmodal
  Finally
    pFreeAndNil(frmAlt);
  End;

end;

procedure TfrmImportCadMetasClientesConfirma.btnDesmarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadMetasClientesConfirma.btnDesmUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadMetasClientesConfirma.btnMarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadMetasClientesConfirma.btnMarcarIncClick(Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosIns);
end;


procedure TfrmImportCadMetasClientesConfirma.btnMarcarUpdClick(Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosUpd);
end;

procedure TfrmImportCadMetasClientesConfirma.btnMarcUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadMetasClientesConfirma.btnVisProdNaoImpClick(
  Sender: TObject);
Var
  strNomEmp: String;
begin
  inherited;

  strNomEmp:= fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

  frxRepNaoImp.Script.Variables['NOMREL'] := 'RELATÓRIO DE REGISTROS NÃO IMPORTADOS';
  frxRepNaoImp.Script.Variables['NOMEMP'] := strNomEmp;
  frxRepNaoImp.DotMatrixReport            := False;
  frxRepNaoImp.PrintOptions.PrintMode     := pmScale;
  pPreviewReport(Self.Name, Self.Caption + ' (Registros não Importados)', frxRepNaoImp);

end;

procedure TfrmImportCadMetasClientesConfirma.cxgMetaInsCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If cdsDadosIns.RecordCount = 0 Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgMetaInsMARCADO.Index]) = '1' Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;

end;

procedure TfrmImportCadMetasClientesConfirma.cxgMetaInsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarIncClick(Sender);
  End;
end;

procedure TfrmImportCadMetasClientesConfirma.cxgMetaUpdViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If cdsDadosUpd.RecordCount = 0 Then
    Exit;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgMetaUpdMARCADO.Index] = '1') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
  If Pos('Novo', AViewInfo.Item.Caption) > 0 then
    ACanvas.Brush.Color := clMoneyGreen
end;

procedure TfrmImportCadMetasClientesConfirma.cxgMetaUpdViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarUpdClick(Sender);
  End;

end;

function TfrmImportCadMetasClientesConfirma.fAlterarRegistroNoBanco(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  qryGravar: TUniQuery;
begin
  ModalResult := mrOK;
  Result:= True;

  cdsDadosUpd.First;

  pgbProgresso.Properties.Max := cdsDadosUpd.RecordCount -1;

  qryGravar:= fCriaQuery();
  qryGravar.SQL.Add('UPDATE METCLI SET  ');
  qryGravar.SQL.Add('MCL_CODMAR = :CODMAR, MCL_CODGRU = :CODGRU, ');
  qryGravar.SQL.Add('MCL_CODFOR = :CODFOR, MCL_CODDEP = :CODDEP, ');
  qryGravar.SQL.Add('MCL_VALDES = :PERDES, MCL_VALMET = :VALMET  ');
  qryGravar.SQL.Add('WHERE MCL_CODCLI = :CODCLI ');
  qryGravar.SQL.Add('  AND MCL_DTAINI = :DATINI ');
  qryGravar.SQL.Add('  AND MCL_DTAFIN = :DATFIM ');
  qryGravar.SQL.Add('  AND MCL_CODEMP = :CODEMP ');
  qryGravar.SQL.Add('  AND MCL_TIPMET = :TIPMET ');

  Try
    While Not(cdsDadosUpd.Eof) do
    Begin
      If cdsDadosUpd.FieldByName('MARCADO').AsInteger = 1 Then
      Begin
        Try
          If fVerificaSeExisteRegistroNoPeriodoInformado(cdsDadosUpd) Then
          Begin
            qryGravar.Close;

            qryGravar.ParamByName('CODCLI').AsString := cdsDadosUpd.FieldByName('CODCLI').AsString;
            qryGravar.ParamByName('DATINI').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(cdsDadosUpd.FieldByName('DATINI').AsString));
            qryGravar.ParamByName('DATFIM').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(cdsDadosUpd.FieldByName('DATFIM').AsString));
            qryGravar.ParamByName('CODEMP').AsString := VS_strCodEmp;
            qryGravar.ParamByName('TIPMET').AsString := cdsDadosUpd.FieldByName('TIPMET').AsString;

            qryGravar.ParamByName('CODMAR').Value  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('CODMAR').AsString,
                                                                         cdsDadosUpd.FieldByName('CODMAR_NOVO').AsString);

            qryGravar.ParamByName('CODGRU').Value  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('CODGRU').AsString,
                                                                         cdsDadosUpd.FieldByName('CODGRU_NOVO').AsString);

            qryGravar.ParamByName('CODFOR').Value  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('CODFOR').AsString,
                                                                         cdsDadosUpd.FieldByName('CODFOR_NOVO').AsString);

            qryGravar.ParamByName('CODDEP').Value  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('CODDEP').AsString,
                                                                         cdsDadosUpd.FieldByName('CODDEP_NOVO').AsString);

            qryGravar.ParamByName('VALMET').Value  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALMET').AsString,
                                                                         cdsDadosUpd.FieldByName('VALMET_NOVO').AsString);

            qryGravar.ParamByName('PERDES').Value  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('PERDES').AsString,
                                                                         cdsDadosUpd.FieldByName('PERDES_NOVO').AsString);

            qryGravar.ExecSQL;
          End;
        Except
        on E: Exception do
          Begin
            pMensagensErro(E.Message, 'TfrmImportCadMetasClientesConfirma.fAlterarRegistroNoBanco');
          End;
        End;
      End;

      cdsDadosUpd.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    FreeAndNil(qryGravar);
  End;

end;

function TfrmImportCadMetasClientesConfirma.fIncluirRegistroNoBanco(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  qryGravar: TUniQuery;
begin
  ModalResult := mrOK;
  Result:= True;
  cdsDadosIns.First;

  pgbProgresso.Properties.Max := cdsDadosIns.RecordCount -1;

  qryGravar:= fCriaQuery();
  qryGravar.SQL.Add('INSERT INTO METCLI(MCL_CODMAR, MCL_CODGRU, MCL_CODFOR, MCL_CODDEP, ');
  qryGravar.SQL.Add('MCL_TIPMET, MCL_VALMET, MCL_VALDES, MCL_CODCLI, MCL_DTAINI, MCL_DTAFIN, MCL_CODEMP, AUTOINCREM) ');
  qryGravar.SQL.Add('VALUES(:CODMAR, :CODGRU, :CODFOR, :CODDEP, ');
  qryGravar.SQL.Add(':TIPMET, :VALMET, :VALDES, :CODCLI, :DTAINI, :DTAFIN, :CODEMP, :AUTINC) ');

  Try
    While Not(cdsDadosIns.Eof) do
    Begin
      If cdsDadosIns.FieldByName('MARCADO').AsInteger = 1 Then
      Begin
        Try
          If fVerificaSeExisteRegistroNoPeriodoInformado(cdsDadosIns) Then
          Begin
            qryGravar.Close;
            qryGravar.ParamByName('CODCLI').AsString := fRetornaInfoSePreenchido(cdsDadosIns.FieldByName('CODCLI').AsString);
            qryGravar.ParamByName('DTAINI').AsString := fRetornaInfoSePreenchido(FormatDateTime('yyyy-mm-dd', StrToDate(cdsDadosIns.FieldByName('DATINI').AsString)));
            qryGravar.ParamByName('DTAFIN').AsString := fRetornaInfoSePreenchido(FormatDateTime('yyyy-mm-dd', StrToDate(cdsDadosIns.FieldByName('DATFIM').AsString)));
            qryGravar.ParamByName('CODMAR').Value    := fRetornaInfoSePreenchido(cdsDadosIns.FieldByName('CODMAR').AsString);
            qryGravar.ParamByName('CODGRU').Value    := fRetornaInfoSePreenchido(cdsDadosIns.FieldByName('CODGRU').AsString);
            qryGravar.ParamByName('CODFOR').Value    := fRetornaInfoSePreenchido(cdsDadosIns.FieldByName('CODFOR').AsString);
            qryGravar.ParamByName('CODDEP').Value    := fRetornaInfoSePreenchido(cdsDadosIns.FieldByName('CODDEP').AsString);
            qryGravar.ParamByName('TIPMET').AsString := cdsDadosIns.FieldByName('TIPMET').AsString;
            qryGravar.ParamByName('VALMET').AsFloat  := cdsDadosIns.FieldByName('VALMET').AsFloat;
            qryGravar.ParamByName('VALDES').AsFloat  := cdsDadosIns.FieldByName('PERDES').AsFloat;
            qryGravar.ParamByName('CODEMP').AsString := VS_strCodEmp;
            qryGravar.ParamByName('AUTINC').AsString := fRetAutoIncrem('METCLI', VS_strCodEmp);
            qryGravar.ExecSQL;
          End;
        Except
          on E: Exception do
          Begin
            pMensagensErro(E.Message, 'TfrmImportCadMetasClientesConfirma.fIncluirRegistroNoBanco');
          End;
        End;
      End;

      cdsDadosIns.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    FreeAndNil(qryGravar);
  End;

end;

function TfrmImportCadMetasClientesConfirma.fMarcaDesmarcaTodosAux(
  prgProgresso: TcxProgressBar): Boolean;
begin
  prgProgresso.Properties.Max := cdsDados.RecordCount -1;
  cdsDados.DisableControls;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('MARCADO').AsInteger := IIf(blnMarcar, 1, 0);
      cdsDados.Post;
      cdsDados.Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    Result := True;
  Finally
    cdsDados.EnableControls;
  End;

end;

procedure TfrmImportCadMetasClientesConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  dtsDadosIns.DataSet:= cdsDadosIns;
  dtsDadosUpd.DataSet:= cdsDadosUpd
end;

procedure TfrmImportCadMetasClientesConfirma.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If pgcContainer.ActivePage = tbsInclui Then
  Begin
    Case Key Of
      VK_F2   : btnMarcarIncAllClick(Sender);
      VK_F3   : btnDesmarcarIncAllClick(Sender);
    End;
  End

  Else If pgcContainer.ActivePage = tbsAltera Then
  Begin
    Case Key Of
      VK_F2   : btnMarcUpdAllClick(Sender);
      VK_F3   : btnDesmUpdAllClick(Sender);
    End;
  End;

end;

function TfrmImportCadMetasClientesConfirma.fRetornaInfoSePreenchido(
  strInfo: String): Variant;
begin
  Result:= Null;
  If Not(fEmptyStr(strInfo)) Then
    Result:= strInfo;
end;

function TfrmImportCadMetasClientesConfirma.fValidaRetornaInfo(
  strInfoOld, strInfoNovo: String): Variant;
begin
  Result:= Null;
  If (Not(fEmptyStr(strInfoNovo))) Then
    Result  := strInfoNovo
  Else If Not(fEmptyStr(strInfoOld)) Then
    Result  := strInfoOld;
end;

procedure TfrmImportCadMetasClientesConfirma.pIncluiClienteNaoImportada(strCodigo: String);
begin
  cdsClienteNaoImportadaRelatorio.Insert;
  cdsClienteNaoImportadaRelatorioCODCLI.AsString := strCodigo;
  cdsClienteNaoImportadaRelatorio.Post;
end;


procedure TfrmImportCadMetasClientesConfirma.pIncluiDepartamentoNaoImportada(
  strCodigo: String);
begin
  cdsDepartamentoNaoImportadaRelatorio.Insert;
  cdsDepartamentoNaoImportadaRelatorioCODDEP.AsString := strCodigo;
  cdsDepartamentoNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadMetasClientesConfirma.pIncluiFornecedorNaoImportada(
  strCodigo: String);
begin
  cdsFornecedorNaoImportadaRelatorio.Insert;
  cdsFornecedorNaoImportadaRelatorioCODFOR.AsString := strCodigo;
  cdsFornecedorNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadMetasClientesConfirma.pIncluiGrupoNaoImportada(
  strCodigo: String);
begin
  cdsGrupoNaoImportadaRelatorio.Insert;
  cdsGrupoNaoImportadaRelatorioCODGRU.AsString := strCodigo;
  cdsGrupoNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadMetasClientesConfirma.pIncluiMarcaNaoImportada(
  strCodigo: String);
begin
  cdsMarcaNaoImportadaRelatorio.Insert;
  cdsMarcaNaoImportadaRelatorioCODMAR.AsString := strCodigo;
  cdsMarcaNaoImportadaRelatorio.Post;

end;

procedure TfrmImportCadMetasClientesConfirma.pIncluiVendedorNaoImportada(
  strCodigo: String);
begin
  cdsVendedorNaoImportadaRelatorio.Insert;
  cdsVendedorNaoImportadaRelatorioCODVEN.AsString := strCodigo;
  cdsVendedorNaoImportadaRelatorio.Post;
end;


procedure TfrmImportCadMetasClientesConfirma.pMarcaDesmarcaTodos(
  blnMarca: boolean);
var frmMarca: TfrmGravando;
begin
  blnMarcar := blnMarca;
  pCriarFormularios(TfrmGravando, frmMarca);
  Try
    frmMarca.lblGravando.Caption := 'Gerando informações ...';
    frmMarca.fExecutarAcao := fMarcaDesmarcaTodosAux;
    frmMarca.Showmodal;
  Finally
    pFreeAndNil(frmMarca);
  End;

end;


procedure TfrmImportCadMetasClientesConfirma.pMarcar(
  cdsDados: TUniClientDataSet);
begin
  cdsDados.Edit;
  cdsDados.FieldByName('MARCADO').AsInteger  := IIf(cdsDados.FieldByName('MARCADO').AsInteger = 1, 0, 1);
  cdsDados.Post;
end;

function TfrmImportCadMetasClientesConfirma.fVerificaSeExisteRegistroNoPeriodoInformado(
  cdsDados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If fEmptyStr(cdsDados.FieldByName('NOMCLI').AsString) Then
    Exit;

  If fEmptyStr(cdsDados.FieldByName('DATINI').AsString) Then
    Exit;

  If fEmptyStr(cdsDados.FieldByName('DATFIM').AsString) Then
    Exit;

  Result := True;
end;

procedure TfrmImportCadMetasClientesConfirma.tbsAlteraShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosUpd;

end;

procedure TfrmImportCadMetasClientesConfirma.tbsIncluiShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosIns;
end;

end.


