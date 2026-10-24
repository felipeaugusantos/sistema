
unit untListaProdutosFCIDivergenteNFE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, frxClass, frxExportCSVTestabilidade, AppEvnts, Menus,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridCustomTableView, cxGridTableView,cxGridExportLink,
  cxGridDBTableView, DBClient, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, untZClient,
  cxCheckBox, cxGridBandedTableView, cxGridDBBandedTableView, uni, cxDropDownEdit, untTabelaPreco,
  cxCurrencyEdit, cxDataControllerConditionalFormattingRulesManagerDialog, cxProgressBar, untGravando,
  cxCalc;

type
  TrecProdutoNota = Record
    strNumNfe: string;
    strCodProdutoNota: string;
    strDescProdutoNota: string;
    strClassIPINota: String;
    intPorcentagemFCINota: Double;
    strNumFCINota: string;
    strCodBarNota: string;
    strCodForNota: string;
    strCESTNota: String;
    strCodFab: string;
    strSerie: String;
    strChaveAcesso: String;
    strDataEmissao: String;
  End;

  TrecProdutoBanco = Record
    strcodProd: string;
    strDesProd: string;
    strClassIPIProd: string;
    intPorcentagemFCIProd: Double;
    strNumFCIProd: string;
    strCESTProd: string;
    strCodBarProd: string;
    strCODABF: String;
  end;

  TTipoCampo =(tcClaIPI, tcFCI, tcPorFCI, tcCodBar, tcCEST);

  TfrmListaProdutosFCIDivergenteNFE = class(TfrmPaiConfirma)
    dtsConsulta: TDataSource;
    cxGrid: TcxGrid;
    cxGridLevel1: TcxGridLevel;
    btnDesmarcarFCI: TBitBtnLocked;
    btnMarcarTodosFCI: TBitBtnLocked;
    Panel1: TPanel;
    lblDiferenca: TLabel;
    btnMarcarTodosCI: TBitBtnLocked;
    btnDesmarcarCI: TBitBtnLocked;
    btnDesmarcarClaIPI: TBitBtnLocked;
    btnMarcarTodosClaIPI: TBitBtnLocked;
    cxbands: TcxGridDBBandedTableView;
    cxColNota: TcxGridDBBandedColumn;
    cxColProduto: TcxGridDBBandedColumn;
    cxColAtuFci: TcxGridDBBandedColumn;
    cxColFciNota: TcxGridDBBandedColumn;
    cxColFciCadIte: TcxGridDBBandedColumn;
    cxColAtuPCI: TcxGridDBBandedColumn;
    cxColPCINota: TcxGridDBBandedColumn;
    cxColPCICadIte: TcxGridDBBandedColumn;
    cxColAtuNCM: TcxGridDBBandedColumn;
    cxColNCMNota: TcxGridDBBandedColumn;
    cxColNCMCadIte: TcxGridDBBandedColumn;
    cxColIncCodBar: TcxGridDBBandedColumn;
    cxColPrincipalCompra: TcxGridDBBandedColumn;
    cxColCodBarNota: TcxGridDBBandedColumn;
    cxColQtdEmb: TcxGridDBBandedColumn;
    btnMarcarTodosCodBarras: TBitBtnLocked;
    btnDesmarcarTodosCodBarras: TBitBtnLocked;
    cxColCodBarProd: TcxGridDBBandedColumn;
    cxColBarPrinc: TcxGridDBBandedColumn;
    btnGeraCSV: TBitBtnLocked;
    cxbandsColumn1: TcxGridDBBandedColumn;
    cxColCODFOR: TcxGridDBBandedColumn;
    cxColNOMFOR: TcxGridDBBandedColumn;
    cxColCODABF: TcxGridDBBandedColumn;
    cxColDESABF: TcxGridDBBandedColumn;
    cxColSERDOC: TcxGridDBBandedColumn;
    cxColCDCESTCADASTRADO: TcxGridDBBandedColumn;
    cxColCDCESTVALIDO: TcxGridDBBandedColumn;
    cxColAtuCEST: TcxGridDBBandedColumn;
    cxColCESTCadIte: TcxGridDBBandedColumn;
    cxColCESTNovo: TcxGridDBBandedColumn;
    btnMarcarTodosCEST: TBitBtnLocked;
    btnDesmarcarTodosCEST: TBitBtnLocked;
    lblMsgInformativa: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcarTodosFCIClick(Sender: TObject);
    procedure btnDesmarcarFCIClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosCIClick(Sender: TObject);
    procedure btnMarcarTodosClaIPIClick(Sender: TObject);
    procedure btnDesmarcarCIClick(Sender: TObject);
    procedure btnDesmarcarClaIPIClick(Sender: TObject);
    procedure btnMarcarTodosCodBarrasClick(Sender: TObject);
    procedure btnDesmarcarTodosCodBarrasClick(Sender: TObject);
    procedure cxbandsKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cxColBarPrincPropertiesChange(Sender: TObject);
    procedure cxColQtdEmbPropertiesChange(Sender: TObject);
    procedure cxColAtuFciPropertiesChange(Sender: TObject);
    procedure cxColAtuPCIPropertiesChange(Sender: TObject);
    procedure cxColAtuNCMPropertiesChange(Sender: TObject);
    procedure cxColIncCodBarPropertiesChange(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure cxbandsCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxColNCMCadIteCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxColFciCadIteCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxColPCICadIteCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxColCESTNovoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxColCESTAtuPropertiesChange(Sender: TObject);
    procedure cxColCESTCadIteCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosCESTClick(Sender: TObject);
    procedure btnDesmarcarTodosCESTClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    qryConsulta: TUniQuery;
    blnAtuNCMdef: Boolean;
    blnAtuFCIDef: Boolean;
    blnAtuPCIDef: Boolean;
    blnPriComDef: Boolean;
    blnInsCodBarDef: Boolean;
    blnPrinciDef: Boolean;
    blnAtuCESTDef: Boolean;

    blnMostrarFCI: Boolean;
    blnMostrarPCI: Boolean;
    blnMostrarNCM: Boolean;
    blnMostrarCODBAR: Boolean;


    function fGetSQLEstrutura: string;
    function pSetInsertCodFab(strCodIte, strCodFab, strCodFor: String): String;
    function fGetTemRegistro: Boolean;
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
    procedure pGetDadosNCMProduto(var recProdutoBanco: TrecProdutoBanco);
    procedure pGetCodigoDeBarras(var recProdutoBanco: TrecProdutoBanco; strCodBarNota: string);
    procedure pGerenciaMarcaoGrid(TipoCampo: TTipoCampo; Valor: integer);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    function fRetCEST(strNCM, strCodIte: string; strCest: String = ''): string;
    procedure pAualizaCodBarra;
    procedure pCarregaCadastroCest;
    procedure pCarregaCadastroNCM;
    procedure pProcessaIntegridadeDadosCest(strCodCest, strCodNcm, strCodNCMAtual, strCodCestAtual: string);
    function fPermiteAlteracao: Boolean;
    function fTemItensSelecionados: Boolean;
    function fRegistroAlterado: Boolean;

    { Private declarations }
  public
    cdsConsulta: TZClient;
    procedure LimparCDS;
    procedure InserirItem(recProdutoNota: TrecProdutoNota);
    property  blnTemRegistro: Boolean Read fGetTemRegistro;

    { Public declarations }
  end;

var
  frmListaProdutosFCIDivergenteNFE: TfrmListaProdutosFCIDivergenteNFE;

implementation

uses untFuncoesSimples, untFuncoes, untCadCEST, untTypesSistema, untConsultas,
     untIteBar, untLiberacao, untMsgLiberacao, untCadNCM;

{$R *.dfm}

procedure TfrmListaProdutosFCIDivergenteNFE.btnGeraCSVClick(Sender: TObject);
Var
  frmAguarde: TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.lblGravando.Caption := 'Gerando Arquivo...';
      frmAguarde.fExecutarAcao := fGeraCSV;
      frmAguarde.ShowModal;
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'TfrmListaProdutosFCIDivergenteNFE.fGeraCSV');
  End;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnConfirmaClick(Sender: TObject);
var strCampos: string;
    blnAtualizouClaIpi,blnTabPrd: Boolean;
begin

  If (fTemItensSelecionados) Then
    If (Not fPermiteAlteracao) Then
    Begin
      fMensagem('','Acesso negado para atualização das informações!', ['&O K']);
      ModalResult := mrAbort;
      Exit;
    End;

  qryConsulta.SQL.Clear;
  cdsConsulta.First;
  blnTabPrd := fCfgSis('TABPRD', varBoolean);
  While not cdsConsulta.Eof do
  begin
    blnAtualizouClaIpi := False;
    try
      strCampos := '';
      qryConsulta.SQL.Clear;

      // Montagem do Update
      qryConsulta.SQL.Add('UPDATE  CADITE SET ');

      If cdsConsulta.FieldByName('SELFCI').AsInteger = 1 Then
        strCampos := ' ITE_NUMFCI = :ITE_NUMFCI ';

      If cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 1 Then
      begin
        strCampos := strCampos + IIF(Not fEmptyStr(strCampos), ' , ', '') + ' ITE_CLAIPI = :ITE_CLAIPI ';
        blnAtualizouClaIpi := True;
      End;

      If (cdsConsulta.FieldByName('SELCEST').AsInteger = 1) Or
         ((cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 1) And (cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger = 1)) Then
      begin
        If (cdsConsulta.FieldByName('CDCEST_NOVO').AsString <> '') Or (cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger = 1) Then
          strCampos := strCampos + IIF(Not fEmptyStr(strCampos), ' , ', '') + ' ITE_CDCEST = :ITE_CDCEST ';
      End;

      If cdsConsulta.FieldByName('SELPCI').AsInteger = 1 Then
        strCampos := strCampos + IIF(Not fEmptyStr(strCampos), ' , ', '') + ' ITE_PER_CI = :ITE_PER_CI ';

      If not fEmptyStr(strCampos) Then
      begin
        qryConsulta.SQL.Add(strCampos);
        qryConsulta.SQL.Add('  WHERE ITE_CODITE = :ITE_CODITE');
        // Atribuição dos parametros;

        If cdsConsulta.FieldByName('SELFCI').AsInteger = 1 Then
          qryConsulta.ParamByName('ITE_NUMFCI').Value := cdsConsulta.FieldByName('NUMFCI_NOTA').Value;
        If cdsConsulta.FieldByName('SELPCI').AsInteger = 1 Then
          qryConsulta.ParamByName('ITE_PER_CI').Value := cdsConsulta.FieldByName('PERFCI_NOTA').Value;

        If cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 1 Then
          qryConsulta.ParamByName('ITE_CLAIPI').Value := cdsConsulta.FieldByName('CLAIPI_NOTA').Value;

        If (cdsConsulta.FieldByName('SELCEST').AsInteger = 1) Or
           ((cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 1) And (cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger = 1)) Then
        begin
          if (cdsConsulta.FieldByName('CDCEST_NOVO').AsString <> '') Then
            qryConsulta.ParamByName('ITE_CDCEST').Value := cdsConsulta.FieldByName('CDCEST_NOVO').AsString
          Else If (cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger = 1) Then
            qryConsulta.ParamByName('ITE_CDCEST').Value := Null;
        End;

        qryConsulta.ParamByName('ITE_CODITE').Value := cdsConsulta.FieldByName('CODITE').Value;
        qryConsulta.ExecSQL;

        If blnAtualizouClaIpi And blnTabPrd Then
        begin
          qryConsulta.SQL.Clear;
          qryConsulta.SQL.Add('UPDATE ITEFOR SET ITE_CLAIPI = "' + cdsConsulta.FieldByName('CLAIPI_NOTA').AsString + '"');
          qryConsulta.SQL.Add(' WHERE ITE_CODITE = "' + cdsConsulta.FieldByName('CODITE').AsString + '"');
          qryConsulta.ExecSQL;
        End;
      end;
      if cdsConsulta.FieldByName('SELCODBAR').AsInteger = 1 Then
         pAualizaCodBarra;
       pSetInsertCodFab(cdsConsulta.FieldByName('CODITE').Value,
                        cdsConsulta.FieldByName('CODFAB').AsString,
                        cdsConsulta.FieldByName('CODFOR').AsString);

    except
      on e:Exception do
        pMensagensErro(e.Message, '[TfrmListaProdutosFCIDivergenteNFE.btnConfirmaClick]');
    end;
    cdsConsulta.Next;
  end;
  inherited;
End;

procedure TfrmListaProdutosFCIDivergenteNFE.btnDesmarcarCIClick(Sender: TObject);
begin
  If blnMostrarPCI Then
    pGerenciaMarcaoGrid(tcPorFCI, 0);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnDesmarcarClaIPIClick(Sender: TObject);
begin
  If blnMostrarNCM Then
    pGerenciaMarcaoGrid(tcClaIPI, 0);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnDesmarcarFCIClick(Sender: TObject);
begin
  If blnMostrarFCI Then
    pGerenciaMarcaoGrid(tcFCI, 0);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnDesmarcarTodosCESTClick(
  Sender: TObject);
begin
  inherited;
  If blnMostrarNCM Then
    pGerenciaMarcaoGrid(tcCEST, 0);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnDesmarcarTodosCodBarrasClick(Sender: TObject);
begin
  If blnMostrarCODBAR Then
    pGerenciaMarcaoGrid(tcCodBar, 0);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnMarcarTodosCESTClick(
  Sender: TObject);
begin
  inherited;
  If blnMostrarNCM Then
    pGerenciaMarcaoGrid(tcCEST, 1);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnMarcarTodosCIClick(Sender: TObject);
begin
  If blnMostrarPCI Then
    pGerenciaMarcaoGrid(tcPorFCI, 1);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnMarcarTodosClaIPIClick(Sender: TObject);
begin
  If blnMostrarNCM Then
    pGerenciaMarcaoGrid(tcClaIPI, 1);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnMarcarTodosCodBarrasClick(Sender: TObject);
begin
  If blnMostrarCODBAR Then
    pGerenciaMarcaoGrid(tcCodBar, 1);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.btnMarcarTodosFCIClick(Sender: TObject);
begin
  If blnMostrarFCI Then
     pGerenciaMarcaoGrid(tcFCI, 1);
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cdsConsultaAfterScroll(
  DataSet: TDataSet);
begin


  lblDiferenca.Caption := 'Divergencia(s) Encontrada(s):' + #$A#$D;
  If blnMostrarFCI And
     (cdsConsulta.FieldByName('NUMFCI_NOTA').AsString <> cdsConsulta.FieldByName('NUMFCI_PROD').AsString) then
    lblDiferenca.Caption := lblDiferenca.Caption + 'Ficha de Conteúdo de Importação [' + cdsConsulta.FieldByName('NUMFCI_NOTA').AsString + '], no cadastro de produto como [' + cdsConsulta.FieldByName('NUMFCI_PROD').AsString + ']. ' + #$A#$D;
  If blnMostrarPCI And
     (cdsConsulta.FieldByName('PERFCI_NOTA').AsString <> cdsConsulta.FieldByName('PERFCI_PROD').AsString) then
    lblDiferenca.Caption := lblDiferenca.Caption + 'Porcentagem do FCI divergente, Nota Fiscal [' + cdsConsulta.FieldByName('PERFCI_NOTA').AsString + '%], no cadastro de produto como [' + cdsConsulta.FieldByName('PERFCI_PROD').AsString + '%]. ' + #$A#$D;
  If blnMostrarNCM Then
  Begin
    If (cdsConsulta.FieldByName('NCM_CADASTRADO').AsInteger = 0) Then
      lblDiferenca.Caption := lblDiferenca.Caption + 'O código NCM [' +cdsConsulta.FieldByName('CLAIPI_NOTA').AsString+ '] não foi encontrado, para inserir presione [ ALT + F9 ] sobre a Coluna "Informação na Nota" ' + #$A#$D ;

    If (cdsConsulta.FieldByName('CLAIPI_NOTA').AsString <> cdsConsulta.FieldByName('CLAIPI_PROD').AsString) then
      lblDiferenca.Caption := lblDiferenca.Caption + 'Classificação Fiscal divergente, Nota Fiscal [' + cdsConsulta.FieldByName('CLAIPI_NOTA').AsString + '], no cadastro de produto como [' + cdsConsulta.FieldByName('CLAIPI_PROD').AsString + ']. ' + #$A#$D;
    If (cdsConsulta.FieldByName('CDCEST_NOVO').AsString = '')  Then
      lblDiferenca.Caption := lblDiferenca.Caption + 'O código CEST refêrente ao NCM [' +cdsConsulta.FieldByName('CLAIPI_NOTA').AsString+ '] não foi encontrado, para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
    Else If (cdsConsulta.FieldByName('CDCEST_NOVO').AsString <> cdsConsulta.FieldByName('CDCEST_PROD').AsString) then
    Begin
      If cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger = 0 Then
         lblDiferenca.Caption := lblDiferenca.Caption + 'O código CEST [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] não foi encontrado, para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
      Else If cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 0 Then
         lblDiferenca.Caption := lblDiferenca.Caption + 'O código CEST [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] foi encontrado, porém, esta relacionado com outro NCM. Para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
      Else
        lblDiferenca.Caption := lblDiferenca.Caption + 'O código CEST Importado [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] é diferente do cadastro de produto [' + cdsConsulta.FieldByName('CDCEST_PROD').AsString + ']' + #$A#$D;
    End
    Else If (cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger = 1) And (cdsConsulta.FieldByName('CDCEST_NOVO').AsString = cdsConsulta.FieldByName('CDCEST_PROD').AsString) then
    Begin
      If cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 0 Then
        lblDiferenca.Caption := lblDiferenca.Caption + 'O código CEST [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] foi encontrado, porém, esta relacionado com outro NCM. Para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
    End;

    If (cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 1) And (cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger = 1) Then
      lblDiferenca.Caption := lblDiferenca.Caption + '** Atenção: Ao selecionar esse NCM para atualizar, o CEST atual do cadastro do produto será apagado.' + #$A#$D ;

  End;
  If blnMostrarCODBAR And
     (cdsConsulta.FieldByName('CODBAR_NOTA').AsString <> cdsConsulta.FieldByName('CODBAR_PROD').AsString) then
    lblDiferenca.Caption := lblDiferenca.Caption + 'Código de Barras informado na Nota Fiscal [' + cdsConsulta.FieldByName('CODBAR_NOTA').AsString  + '], não foi encontrado no sistema.' + #$A#$D;
  If cdsConsulta.FieldByName('CODFAB').AsString <> '' Then
    lblDiferenca.Caption := lblDiferenca.Caption + 'O código de Fábrica [' + cdsConsulta.FieldByName('CODFAB').AsString  + '], não foi encontrado no sistema.' + #$A#$D;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxbandsCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  intIndex: Integer;
  blnMarcado: Boolean;
begin
  inherited;
  IF ACanvas.Font.Color <> clRed Then
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  End;
  intIndex := AViewInfo.Item.Index;

  blnMarcado := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColAtuFci.Index],'0') = '1';
  if (blnMarcado) And (intIndex In [cxColAtuFci.Index, cxColFciNota.Index, cxColFciCadIte.Index]) then
    ACanvas.Brush.Color := $004080FF;

  blnMarcado := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColAtuPCI.Index],'0') = '1';
  if (blnMarcado) And (intIndex In [cxColAtuPCI.Index, cxColPCINota.Index, cxColPCICadIte.Index]) then
    ACanvas.Brush.Color := clSkyBlue;

  blnMarcado := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColAtuNCM.Index],'0') = '1';
  if (blnMarcado) And (intIndex In [cxColAtuNCM.Index, cxColNCMNota.Index, cxColNCMCadIte.Index]) then
    ACanvas.Brush.Color := $008080FF;

  blnMarcado := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColAtuCEST.Index],'0') = '1';
  if (blnMarcado) And (intIndex In [cxColAtuCEST.Index, cxColCESTCadIte.Index, cxColCESTNovo.Index]) then
    ACanvas.Brush.Color :=  $008080FF;

  blnMarcado := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColIncCodBar.Index],'0') = '1';
  if (blnMarcado) And (intIndex In [cxColCodBarNota.Index, cxColCodBarProd.Index, cxColIncCodBar.Index, cxColBarPrinc.Index,
    cxColPrincipalCompra.Index, cxColQtdEmb.Index]) then
    ACanvas.Brush.Color := clHighlight;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxbandsKeyPress(
  Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    edtCodCest: TCustomEdit;
begin
  inherited;
  If cxColCESTNovo.Focused And (Key = '/') Then
  begin
    edtCodCest := TCustomEdit.Create(nil);
    Try
      If fPesqCest(Self,
                   edtCodCest,
                   nil,
                   Nil,
                   Key,
                   arrSel,
                   True,
                   IIf(cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 1, cdsConsulta.FieldByName('CLAIPI_NOTA').AsString,
                   cdsConsulta.FieldByName('CLAIPI_PROD').AsString)) Then
       Begin
         cdsConsulta.Edit;
         cdsConsulta.FieldByName('CDCEST_NOVO').AsString :=  edtCodCest.Text;

         pProcessaIntegridadeDadosCest(cdsConsulta.FieldByName('CDCEST_NOVO').AsString, cdsConsulta.FieldByName('CLAIPI_NOTA').AsString,
                                          cdsConsulta.FieldByName('CLAIPI_PROD').AsString, cdsConsulta.FieldByName('CDCEST_PROD').AsString);

         If cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 1 Then
         Begin
           cdsConsulta.FieldByName('SELCEST').AsInteger := 1;
           cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
         End
         Else If (cdsConsulta.FieldByName('CDCEST_NCM_ATUAL').AsInteger = 1) And (cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 0) Then
         Begin
           cdsConsulta.FieldByName('SELCEST').AsInteger := 1;
         End
         Else
         Begin
           If cdsConsulta.FieldByName('CDCEST_CEST_ATUAL').AsInteger = 0 Then
             cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;

           cdsConsulta.FieldByName('SELCEST').AsInteger := 0;
         End;

         cdsConsulta.Post;

       End;
    Finally
      FreeAndNil(edtCodCest);
    End;
  End;

end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColAtuFciPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If cdsConsulta.State = dsEdit Then
  Begin
    If cdsConsulta.FieldByName('NUMFCI_NOTA').AsString = cdsConsulta.FieldByName('NUMFCI_PROD').AsString Then
    Begin
      cdsConsulta.FieldByName('SELFCI').AsInteger := 0;
      cdsConsulta.Post;
    End;
  End;

end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColAtuNCMPropertiesChange(
  Sender: TObject);
begin
  If cdsConsulta.State = dsEdit Then
  Begin
    if cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 0 Then
    Begin
      If (cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 1) Then
      Begin
        cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;

        if cdsConsulta.FieldByName('CDCEST_CEST_IGUAL').AsInteger = 0 Then
          cdsConsulta.FieldByName('SELCEST').AsInteger := 1;
      End
      Else If cdsConsulta.FieldByName('CDCEST_CEST_ATUAL').AsInteger = 1 Then
      Begin
        cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
      End
      Else If (cdsConsulta.FieldByName('NCM_CADASTRADO').AsInteger = 1) And
              (cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger = 1) Then
      Begin
        cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
      End
      Else
      Begin
        cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;
      End;
    End
    Else
    Begin
      If cdsConsulta.FieldByName('CDCEST_NCM_ATUAL').AsInteger = 0 Then
        cdsConsulta.FieldByName('SELCEST').AsInteger := 0;

      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;
    End;

    cdsConsulta.Post;

 End;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColAtuPCIPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If cdsConsulta.State = dsEdit Then
  Begin
    If cdsConsulta.FieldByName('PERFCI_NOTA').AsString = cdsConsulta.FieldByName('PERFCI_PROD').AsString Then
    Begin
      cdsConsulta.FieldByName('SELPCI').AsInteger := 0;
      cdsConsulta.Post;
    End;
  End;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColBarPrincPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If cdsConsulta.State = dsEdit Then
  Begin
    If cdsConsulta.FieldByName('CODBAR_PRINC').AsInteger = 0 Then
    begin
      cdsConsulta.FieldByName('CODBAR_FATOR').AsInteger := 1;
      cdsConsulta.FieldByName('CODBAR_PRINC').AsInteger := 1;
      cdsConsulta.Post;
    End
  End;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColCESTAtuPropertiesChange(
  Sender: TObject);
begin
  if cdsConsulta.FieldByName('SELCEST').AsInteger = 0 Then
  Begin
    If cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 1 Then
    Begin
      cdsConsulta.FieldByName('SELCEST').AsInteger := 1;

      If cdsConsulta.FieldByName('CDCEST_NCM_IGUAL').AsInteger = 0 Then
        cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
    End
    Else If cdsConsulta.FieldByName('CDCEST_NCM_ATUAL').AsInteger = 1 Then
    Begin
      cdsConsulta.FieldByName('SELCEST').AsInteger := 1;
    End
    Else
    Begin
      cdsConsulta.FieldByName('SELCEST').AsInteger := 0;
    End;
  End
  Else
  Begin
    If cdsConsulta.FieldByName('CDCEST_CEST_ATUAL').AsInteger = 0 Then
      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;

    cdsConsulta.FieldByName('SELCEST').AsInteger := 0;
  End;

  cdsConsulta.Post;

end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColCESTCadIteCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColCESTNovo.Index] <> '') and
  ((Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColCESTNovo.Index]) <>
   (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColCDCESTCADASTRADO.Index]))  Then
      ACanvas.Font.Color := clRed;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColCESTNovoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean );
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColCDCESTCADASTRADO.Index] <> '1') Or
    (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColCDCESTVALIDO.Index] <> '1')  Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColFciCadIteCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColFciNota.Index] <>
    Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColFciCadIte.Index]  Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColIncCodBarPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If cdsConsulta.State = dsEdit Then
  begin
     If (cdsConsulta.FieldByName('SELCODBAR').NewValue = 0) and
       (cdsConsulta.FieldByName('CODBAR_NOTA').AsString =
       cdsConsulta.FieldByName('CODBAR_PROD').AsString) then
       cdsConsulta.Cancel
     Else If cdsConsulta.FieldByName('SELCODBAR').AsInteger = 1 Then
     Begin
       cdsConsulta.FieldByName('CODBAR_PRINCOM').AsInteger := 0;
       cdsConsulta.FieldByName('CODBAR_PRINC').AsInteger := 0;
       cdsConsulta.FieldByName('SELCODBAR').AsInteger := 0;
     End;
  End;

end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColNCMCadIteCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColNCMNota.Index] <>
    Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColNCMCadIte.Index]  Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColPCICadIteCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColPCINota.Index] <>
    Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColPCICadIte.Index]  Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.cxColQtdEmbPropertiesChange(
  Sender: TObject);
begin
  If cdsConsulta.State = dsEdit Then
     if cdsConsulta.FieldByName('CODBAR_PRINC').Value = 1 Then
        cdsConsulta.FieldByName('CODBAR_PRINC').Value := 1;
end;

function TfrmListaProdutosFCIDivergenteNFE.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
Var
  svdCsv: TSaveDialog;
  procedure pStepStatusGravacao;
  Begin
    If Assigned(cxProgress) Then
    Begin
      cxProgress.Position := cxProgress.Position + 1;
      Application.ProcessMessages;
    End;
  End;
  procedure pInfoStatusGravacao(strInformacao: String);
  Begin
    If Assigned(cxProgress) And (GetParentForm(cxProgress).FindComponent('lblGravando') <> Nil) Then
    Begin
      TLabel(GetParentForm(cxProgress).FindComponent('lblGravando')).Caption := strInformacao;
      Application.ProcessMessages;
    End;
  End;
begin
  Result := True;
  pInfoStatusGravacao('Gerando arquivo CSV. Aguarde...');

  cxProgress.Position := 0;
  cxProgress.Properties.Max := qryConsulta.RecordCount;

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';

  If svdCsv.Execute Then
  Begin
    cxColAtuFci.Visible := False;
    cxColAtuPCI.Visible := False;
    cxColAtuNCM.Visible := False;
    ExportGridToCSV(svdCsv.FileName,cxGrid, True, True,';');
    cxColAtuFci.Visible := blnMostrarFCI;
    cxColAtuPCI.Visible := blnMostrarPCI;
    cxColAtuNCM.Visible := blnMostrarNCM;
    cxColAtuCEST.Visible := blnMostrarNCM;
    fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);
  End;
  FreeAndNil(svdCsv);
End;

function TfrmListaProdutosFCIDivergenteNFE.fGetSQLEstrutura: string;
begin
  Result := Result + 'SELECT ';
  Result := Result + '       "000000000000" AS NUMNFE, ';
  Result := Result + '       ITE_DESITE AS PRODUT, ';
  Result := Result + '       1 AS SELFCI, ';
  Result := Result + '       ITE_NUMFCI AS NUMFCI_NOTA, ';
  Result := Result + '       ITE_NUMFCI AS NUMFCI_PROD, ';
  Result := Result + '       1 AS SELPCI, ';
  Result := Result + '       ITE_PER_CI AS PERFCI_NOTA, ';
  Result := Result + '       ITE_PER_CI AS PERFCI_PROD, ';
  Result := Result + '       1 AS SELCLAFIS, ';
  Result := Result + '       ITE_CLAIPI AS CLAIPI_NOTA, ';
  Result := Result + '       ITE_CLAIPI AS CLAIPI_PROD, ';
  Result := Result + '       ITE_CODITE AS CODITE, ';
  Result := Result + '       ITE_CDCEST AS CDCEST_NOVO, ';
  Result := Result + '       ITE_CDCEST AS CDCEST_PROD, ';
  Result := Result + '       1 AS SELCEST, ';
  Result := Result + '       0 CDCEST_CADASTRADO, ';
  Result := Result + '       0 NCM_CADASTRADO, ';
  Result := Result + '       0 CDCEST_NCM_VALIDO, ';
  Result := Result + '       0 CDCEST_NCM_ATUAL, ';
  Result := Result + '       0 CDCEST_CEST_NOTA_VAZIO, ';
  Result := Result + '       0 CDCEST_CEST_ATUAL, ';
  Result := Result + '       0 CDCEST_CEST_IGUAL, ';
  Result := Result + '       0 CDCEST_NCM_IGUAL, ';
  Result := Result + '       0 INF_AVISO_NCM, ';
  Result := Result + '       1  AS SELCODBAR, ';
  Result := Result + '       ITE_CODBAR AS CODBAR_NOTA, ';
  Result := Result + '       ITE_CODBAR AS CODBAR_PROD, ';
  Result := Result + '       0 AS CODBAR_PRINCOM, ';
  Result := Result + '       0 AS CODBAR_PRINC, ';
  Result := Result + '       1 AS CODBAR_FATOR, ';
  Result := Result + '       CAST("" AS CHAR(50)) AS CODFAB, ';
  Result := Result + '       ITE_CODFOR AS CODFOR, ';
  Result := Result + '       FOR_NOMFOR AS NOMFOR,';
  Result := Result + '       ITE_CODABF AS CODABF,';
  Result := Result + '       ABF_DESABF AS DESABF,';
  Result := Result + '       CAST("" AS CHAR(10)) AS NUMDOC,';
  Result := Result + '       CAST("" AS CHAR(10)) AS DTAEMI,';
  Result := Result + '       CAST("" AS CHAR(44)) AS CHVNFE,';
  Result := Result + '       CAST("" AS CHAR(10)) AS SERDOC';
  Result := Result + '  FROM CADITE ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';
  Result := Result + '  LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID ';
  Result := Result + '  LEFT JOIN ABFICM AB ON ITE_CODABF = ABF_CODABF AND CID_ESTADO = ABF_ESTADO ';
  Result := Result + ' WHERE FALSE ';
end;

procedure TfrmListaProdutosFCIDivergenteNFE.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If (ModalResult = mrAbort) Then
    CanClose := False;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.FormCreate(Sender: TObject);
begin
  inherited;
  cdsconsulta := TZClient.Create(NIL, fGetSQLEstrutura);
  cdsconsulta.fAbreClient(True, 'TfrmListaProdutosFCIDivergenteNFE.FormCreate');
  qryConsulta := fCriaQuery(Self);
  dtsConsulta.DataSet := cdsConsulta;
  blnAtuNCMdef    := fCfgSis('INCMDM') = 'M';
  blnAtuFCIDef    := fCfgSis('IFCIDM') = 'M';
  blnAtuPCIDef    := fCfgSis('IPCIDM') = 'M';
  blnPriComDef    := fCfgSis('PRCIDM') = 'M';
  blnPrinciDef    := fCfgSis('PRIIDM') = 'M';
  blnInsCodBarDef := fCfgSis('COBIDM') = 'M';
  blnAtuCESTDef   := fCfgSis('INCMDM') = 'M';

  blnMostrarFCI   := False;
  blnMostrarPCI   := False;
  blnMostrarNCM   := False;
  blnMostrarCODBAR:= False;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsConsulta);
  FreeAndNil(qryConsulta)
end;

procedure TfrmListaProdutosFCIDivergenteNFE.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    vk_f1: pGerenciaMarcaoGrid(tcFCI,    1);
    vk_f2: pGerenciaMarcaoGrid(tcFCI,    0);
    vk_f3: pGerenciaMarcaoGrid(tcPorFCI, 1);
    vk_f4: pGerenciaMarcaoGrid(tcPorFCI, 0);
      vk_f5: pGerenciaMarcaoGrid(tcClaIPI, 1);
    vk_f6: pGerenciaMarcaoGrid(tcClaIPI, 0);
    vk_f7: pGerenciaMarcaoGrid(tcCodBar, 1);
    vk_f8: pGerenciaMarcaoGrid(tcCodBar, 0);
    vk_f9:Begin
            If ssAlt In Shift Then
              pCarregaCadastroNCM
            Else
              pCarregaCadastroCest;
          End;
    vk_f10: pGerenciaMarcaoGrid(tcCEST, 1);
    vk_f11: btnGeraCSV.Click;
    vk_f12: pGerenciaMarcaoGrid(tcCEST, 0);
    end;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.FormShow(Sender: TObject);
begin
  cxBands.Bands[1].Visible := blnMostrarFCI;
  cxBands.Bands[2].Visible := blnMostrarPCI;
  cxBands.Bands[3].Visible := blnMostrarNCM;
  cxBands.Bands[4].Visible := blnMostrarNCM;
  cxBands.Bands[5].Visible := blnMostrarCODBAR;



  inherited;
  If blnAtuNCMdef Then
    pGerenciaMarcaoGrid(tcClaIPI, 1);
  If blnAtuFCIDef Then
    pGerenciaMarcaoGrid(tcFCI, 1);
  If blnAtuPCIDef Then
    pGerenciaMarcaoGrid(tcPorFCI, 0);
  If blnInsCodBarDef Then
    pGerenciaMarcaoGrid(tcCodBar, 1);
  If blnAtuCESTDef Then
    pGerenciaMarcaoGrid(tcCest, 1);

  cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
  cxbands.DataController.Groups.FullExpand;
end;

function TfrmListaProdutosFCIDivergenteNFE.fRetCEST(strNCM, strCodIte: string; strCest: String = ''): string;
begin
  Result := '';
  (*1 ° Primeiro verifica se o CEST relacionado ao produto hj ja tem o mesmo NCM *)
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD, CES_CDCEST');
  qryConsulta.SQL.Add('  FROM CDCEST');
  qryConsulta.SQL.Add(' WHERE CES_CODNCM = :CODNCM');
  If strCest <> '' Then
    qryConsulta.SQL.Add(' AND CES_CDCEST = "'+strCest+'"')
  Else
  begin
    qryConsulta.SQL.Add('   AND CES_CDCEST = (SELECT ITE_CDCEST FROM CADITE');
    qryConsulta.SQL.Add('                      WHERE ITE_CODITE = :CODITE)');
  End;
  qryConsulta.SQL.Add(' GROUP BY CES_CDCEST ');

  If strCest = '' Then
    qryConsulta.ParamByName('CODITE').AsString := strCodIte;
  qryConsulta.ParamByName('CODNCM').AsString := strNCM;
  qryConsulta.Open;
  //Se não proucura CEST com o mesmo NCM;
  If qryConsulta.FieldByName('QTD').AsInteger = 0 Then
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT CES_CDCEST');
    qryConsulta.SQL.Add('  FROM CDCEST');
    qryConsulta.SQL.Add(' WHERE CES_CODNCM = :CODNCM');
    If strCest <> '' Then
      qryConsulta.SQL.Add(' AND CES_CDCEST = "'+strCest+'"');
    qryConsulta.ParamByName('CODNCM').AsString := strNCM;
    qryConsulta.Open;
  End;
  If Not qryConsulta.IsEmpty Then
     Result := qryConsulta.FieldByName('CES_CDCEST').AsString;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.LimparCDS;
begin
  cdsConsulta.Close;
  cdsConsulta.Open;
end;


procedure TfrmListaProdutosFCIDivergenteNFE.InserirItem(recProdutoNota: TrecProdutoNota);
  var
    RecProdutoBanco: TrecProdutoBanco;
begin
  Try
    RecProdutoBanco.strcodProd := recProdutoNota.strCodProdutoNota;
    pGetDadosNCMProduto(RecProdutoBanco);
    pGetCodigoDeBarras(RecProdutoBanco, recProdutoNota.strCodBarNota);

    cdsConsulta.AfterScroll := nil;
    Try
      if RecProdutoBanco.intPorcentagemFCIProd > -1 then
      Begin
        If (RecProdutoBanco.strNumFCIProd <> recProdutoNota.strNumFCINota) Or
           ((RecProdutoBanco.strClassIPIProd <> recProdutoNota.strClassIPINota)
           Or ((recProdutoNota.strCESTNota <> '') And   (RecProdutoBanco.strCESTProd <> recProdutoNota.strCESTNota))) Or
           (RecProdutoBanco.intPorcentagemFCIProd <> recProdutoNota.intPorcentagemFCINota) Or
           (RecProdutoBanco.strCodBarProd <> recProdutoNota.strCodBarNota) Or
           (recProdutoNota.strCodFab <> '')  Then
        Begin
          If Not blnMostrarFCI Then
             blnMostrarFCI := (RecProdutoBanco.strNumFCIProd <> recProdutoNota.strNumFCINota);

          If Not blnMostrarNCM Then
             blnMostrarNCM := (RecProdutoBanco.strClassIPIProd <> recProdutoNota.strClassIPINota);

          If Not blnMostrarPCI Then
             blnMostrarPCI := (RecProdutoBanco.intPorcentagemFCIProd <> recProdutoNota.intPorcentagemFCINota);

          If Not blnMostrarCODBAR Then
             blnMostrarCODBAR := (RecProdutoBanco.strCodBarProd <> recProdutoNota.strCodBarNota);

          cdsConsulta.Insert;
          cdsConsulta.FieldByName('CODITE').AsString      := RecProdutoBanco.strcodProd;
          cdsConsulta.FieldByName('NUMNFE').AsString      := recProdutoNota.strNumNfe;
          cdsConsulta.FieldByName('PRODUT').AsString      := RecProdutoBanco.strcodProd + ' - ' + RecProdutoBanco.strDesProd;
          cdsConsulta.FieldByName('NUMFCI_NOTA').AsString := recProdutoNota.strNumFCINota;
          cdsConsulta.FieldByName('NUMFCI_PROD').AsString := RecProdutoBanco.strNumFCIProd;
          cdsConsulta.FieldByName('PERFCI_NOTA').AsFloat  := recProdutoNota.intPorcentagemFCINota;
          cdsConsulta.FieldByName('PERFCI_PROD').AsFloat  := RecProdutoBanco.intPorcentagemFCIProd;
          cdsConsulta.FieldByName('CLAIPI_NOTA').AsString := recProdutoNota.strClassIPINota;
          cdsConsulta.FieldByName('CLAIPI_PROD').AsString := RecProdutoBanco.strClassIPIProd;
          cdsConsulta.FieldByName('SELCLAFIS').AsInteger  := IIf(blnAtuNCMdef And blnMostrarNCM And
                                                                (recProdutoNota.strClassIPINota <> RecProdutoBanco.strClassIPIProd),
                                                                1, 0);
          cdsConsulta.FieldByName('SELFCI').AsInteger     := IIf(blnAtuFCIDef And blnMostrarFCI And
                                                             (recProdutoNota.strNumFCINota <> RecProdutoBanco.strNumFCIProd),
                                                             1, 0);

          cdsConsulta.FieldByName('SELPCI').AsInteger     := IIf(blnMostrarPCI And blnMostrarPCI And
                                                             (recProdutoNota.intPorcentagemFCINota <> RecProdutoBanco.intPorcentagemFCIProd),
                                                             1, 0);

          cdsConsulta.FieldByName('SELCEST').AsInteger     := IIf(blnAtuCESTDef And blnMostrarNCM And
                                                           (recProdutoNota.strCESTNota <> RecProdutoBanco.strCESTProd),
                                                           1, 0);

          If (recProdutoNota.strCESTNota <> '') And (recProdutoNota.strCESTNota <> '0000000') Then
          begin
            cdsConsulta.FieldByName('CDCEST_NOVO').AsString := recProdutoNota.strCESTNota;
          End
          Else
          Begin
            cdsConsulta.FieldByName('CDCEST_NOVO').AsString := fRetCEST(recProdutoNota.strClassIpiNota, RecProdutoBanco.strcodProd);
          End;

          pProcessaIntegridadeDadosCest(cdsConsulta.FieldByName('CDCEST_NOVO').AsString, recProdutoNota.strClassIPINota, RecProdutoBanco.strClassIPIProd, RecProdutoBanco.strCESTProd );

          cdsConsulta.FieldByName('CDCEST_PROD').AsString := RecProdutoBanco.strCESTProd;
          cdsConsulta.FieldByName('CODFOR').AsString      := recProdutoNota.strCodForNota;
          cdsConsulta.FieldByName('NOMFOR').AsString      := fRetNomFornecedor(recProdutoNota.strCodForNota);
          cdsConsulta.FieldByName('CODABF').AsString      := RecProdutoBanco.strCODABF;
          cdsConsulta.FieldByName('DESABF').AsString      := fRetDesAbfIcm(RecProdutoBanco.strCODABF);
          cdsConsulta.FieldByName('SERDOC').AsString      := recProdutoNota.strSerie;
          cdsConsulta.FieldByName('DTAEMI').AsString      := recProdutoNota.strDataEmissao;
          cdsConsulta.FieldByName('CHVNFE').AsString      := recProdutoNota.strChaveAcesso;

          If not blnMostrarNCM Then
            blnMostrarNCM := cdsConsulta.FieldByName('CDCEST_NOVO').AsString <> cdsConsulta.FieldByName('CDCEST_PROD').AsString;

          cdsConsulta.FieldByName('CODBAR_NOTA').AsString := RecProdutoNota.strCodBarNota;
          cdsConsulta.FieldByName('CODBAR_PROD').AsString := recProdutoBanco.strCodBarProd;


          cdsConsulta.FieldByName('CODBAR_FATOR').AsString := '1';
          cdsConsulta.FieldByName('SELCODBAR').AsInteger := IIF(blnInsCodBarDef And
                                                                blnMostrarCODBAR And
                                                               (RecProdutoBanco.strCodBarProd <> RecProdutoNota.strCodBarNota), 1, 0);
          If cdsConsulta.FieldByName('SELCODBAR').AsInteger = 0 Then
          Begin
            cdsConsulta.FieldByName('CODBAR_PRINCOM').AsInteger := 0;
            cdsConsulta.FieldByName('CODBAR_PRINC').AsInteger := 0;
          End
          Else
          Begin
            cdsConsulta.FieldByName('CODBAR_PRINCOM').AsInteger := IIF(blnPriComDef, 1, 0);
            cdsConsulta.FieldByName('CODBAR_PRINC').AsInteger := IIF(blnPrinciDef, 1, 0);
          End;

          cdsConsulta.FieldByName('CODFAB').AsString := recProdutoNota.strCodFab;
          If recProdutoNota.strCodFab <> '' Then
            cxBands.Bands[5].Visible := True;

          If ((cdsConsulta.FieldByName('CLAIPI_NOTA').AsString = cdsConsulta.FieldByName('CLAIPI_PROD').AsString) Or
             ((cdsConsulta.FieldByName('CDCEST_NOVO').AsString = cdsConsulta.FieldByName('CDCEST_PROD').AsString)
             Or ((cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger = 0) Or (cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 0))))  Then
            cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;


          if ((cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger = 0) Or (cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 0)) then
           cdsConsulta.FieldByName('SELCEST').AsInteger := 0;

          cdsConsulta.Post;
        end;
      end;

    Finally
      cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
    End;
  Except
    on e : Exception do
     pMensagensErro(e.Message, '[TfrmListaProdutosFCIDivergenteNFE.InserirItem]');
  End
end;

function TfrmListaProdutosFCIDivergenteNFE.fGetTemRegistro: Boolean;
Begin
  Result := cdsConsulta.RecordCount > 0;
End;

function TfrmListaProdutosFCIDivergenteNFE.pSetInsertCodFab(strCodIte, strCodFab, strCodFor: String): String;
  var strMsgErr: string;
begin
  qryConsulta.SQL.Clear;
  If (strCodIte = '') Or (strCodFab = '') Or (strCodFor = '') Then
    Exit;

  qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CADITE ');
  qryConsulta.SQL.Add(' WHERE ITE_CODITE = "' + strCodIte + '" ');
  qryConsulta.SQL.Add('  AND ITE_CODFOR = "' + strCodfOR + '" ');
  qryConsulta.SQL.Add('  AND IFNULL(ITE_CODFAB, "") = "" ');
  qryConsulta.Open;

  If qryConsulta.FieldByName('QTD').AsInteger = 1 Then
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('UPDATE CADITE SET ITE_CODFAB = :CODFAB');
    qryConsulta.SQL.Add(' WHERE ITE_CODITE = :CODITE ');
    qryConsulta.SQL.Add('   AND ITE_CODFOR = :CODFOR ');
    qryConsulta.ParamByName('CODITE').AsString := strCodIte;
    qryConsulta.ParamByName('CODFOR').AsString := strCodFor;
    qryConsulta.ParamByName('CODFAB').AsString := strCodFab;

    qryConsulta.ExecSQL;
  End
  Else If fValidaCodForFab(strCodFor, strCodFab, strCodite, strMsgErr) Then
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(' INSERT INTO ITEFOR (');
    qryConsulta.SQL.Add('   ITE_CODITE, ');
    qryConsulta.SQL.Add('   ITE_CODITF, ');
    qryConsulta.SQL.Add('   ITE_CODFOR, ');
    qryConsulta.SQL.Add('   ITE_CODEMP, ');
    qryConsulta.SQL.Add('   AUTOINCREM) ');
    qryConsulta.SQL.Add(' VALUES( ');
    qryConsulta.SQL.Add('   :CODITE, ');
    qryConsulta.SQL.Add('   :CODITF, ');
    qryConsulta.SQL.Add('   :CODFOR, ');
    qryConsulta.SQL.Add('   :CODEMP, ');
    qryConsulta.SQL.Add('   :AUTINC) ');

    qryConsulta.ParamByName('CODITE').AsString := cdsConsulta.FieldByName('CODITE').AsString;
    qryConsulta.ParamByName('CODITF').AsString := cdsConsulta.FieldByName('CODFAB').AsString;
    qryConsulta.ParamByName('CODFOR').AsString := cdsConsulta.FieldByName('CODFOR').AsString;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEFOR', VS_strCodEmp);;
    qryConsulta.ExecSQL;
  End;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.pGerenciaMarcaoGrid(TipoCampo: TTipoCampo; Valor: integer);
begin
  cdsConsulta.DisableControls;
  cdsConsulta.First;
  while not cdsConsulta.Eof do
  begin
    cdsConsulta.Edit;
    case TipoCampo of
      tcClaIPI:Begin
                  if Valor = 1 Then
                  Begin
                    If cdsConsulta.FieldByName('CDCEST_NCM_IGUAL').AsInteger = 1 Then
                    Begin
                      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;

                    End
                    Else
                    If (cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 1) Then
                    Begin
                      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
                      cdsConsulta.FieldByName('SELCEST').AsInteger := 1;
                    End
                    Else If cdsConsulta.FieldByName('CDCEST_CEST_ATUAL').AsInteger = 1 Then
                    Begin
                      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
                    End
                    Else If (cdsConsulta.FieldByName('NCM_CADASTRADO').AsInteger = 1) And
                            (cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger = 1) Then
                    Begin
                      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
                    End
                    Else
                    Begin
                      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;
                    End;
                  End
                  Else
                  Begin
                    If cdsConsulta.FieldByName('CDCEST_NCM_ATUAL').AsInteger = 0 Then
                      cdsConsulta.FieldByName('SELCEST').AsInteger := 0;

                    cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;
                  End;
               End;
      tcFCI   :Begin
                 If Not SameText(cdsConsulta.FieldByName('NUMFCI_NOTA').AsString,
                                  cdsConsulta.FieldByName('NUMFCI_PROD').AsString) Then
                   cdsConsulta.FieldByName('SELFCI').AsInteger := Valor;
               End;
      tcPorFCI:Begin
                 If (cdsConsulta.FieldByName('PERFCI_NOTA').AsFloat <>
                        cdsConsulta.FieldByName('PERFCI_PROD').AsFloat) Then
                    cdsConsulta.FieldByName('SELPCI').AsInteger := Valor;
               End;
      tcCodBar:Begin
                 If Not SameText(cdsConsulta.FieldByName('CODBAR_NOTA').AsString,
                                 cdsConsulta.FieldByName('CODBAR_PROD').AsString) Then
                   cdsConsulta.FieldByName('SELCODBAR').AsInteger := Valor;

                   If Valor = 0 Then
                   begin
                     cdsConsulta.FieldByName('CODBAR_PRINCOM').AsInteger := 0;
                     cdsConsulta.FieldByName('CODBAR_PRINC').AsInteger := 0;
                   End;
               End;
        tcCEST:Begin
                  if Valor = 1 Then
                  Begin
                    If cdsConsulta.FieldByName('CDCEST_CEST_IGUAL').AsInteger = 1 Then
                    Begin
                      cdsConsulta.FieldByName('SELCEST').AsInteger := 0;
                    End
                    Else
                    If cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 1 Then
                    Begin
                      cdsConsulta.FieldByName('SELCEST').AsInteger := 1;
                      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 1;
                    End
                    Else If cdsConsulta.FieldByName('CDCEST_NCM_ATUAL').AsInteger = 1 Then
                    Begin
                      cdsConsulta.FieldByName('SELCEST').AsInteger := 1;
                    End
                    Else
                    Begin
                      cdsConsulta.FieldByName('SELCEST').AsInteger := 0;
                    End;
                  End
                  Else
                  Begin
                    If cdsConsulta.FieldByName('CDCEST_CEST_ATUAL').AsInteger = 0 Then
                      cdsConsulta.FieldByName('SELCLAFIS').AsInteger := 0;

                    cdsConsulta.FieldByName('SELCEST').AsInteger := 0;
                  End;

               End;
    end;
    cdsConsulta.Post;
    cdsConsulta.Next;
  End;
  cdsConsulta.EnableControls;

end;

procedure TfrmListaProdutosFCIDivergenteNFE.pGetCodigoDeBarras(
  var recProdutoBanco: TrecProdutoBanco; strCodBarNota: string);
begin
  If strCodBarNota = '' Then
    Exit;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT BAR_CODBAR FROM ITEBAR');
  qryConsulta.SQL.Add('WHERE BAR_CODITE = :CODITE');
  qryConsulta.SQL.Add('  AND BAR_CODBAR = :CODBAR');
  qryConsulta.ParamByName('CODITE').AsString := recProdutoBanco.strcodProd;
  qryConsulta.ParamByName('CODBAR').AsString := strCodBarNota;
  qryConsulta.Open;
  If qryConsulta.IsEmpty Then
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT BAR_CODBAR FROM ITEBAR');
    qryConsulta.SQL.Add('WHERE BAR_CODITE = :CODITE');
    qryConsulta.SQL.Add('LIMIT 1');
    qryConsulta.ParamByName('CODITE').AsString := recProdutoBanco.strcodProd;
    qryConsulta.Open;
  End;
  If Not qryConsulta.IsEmpty Then
    recProdutoBanco.strCodBarProd := qryConsulta.FieldByName('BAR_CODBAR').AsString
  Else
    recProdutoBanco.strCodBarProd := '';
end;

procedure TfrmListaProdutosFCIDivergenteNFE.pGetDadosNCMProduto(var recProdutoBanco: TRecProdutoBanco);
begin
  qryConsulta.SQL.Clear;

  qryConsulta.SQL.Add('SELECT ');
  qryConsulta.SQL.Add('    CADITE.ITE_CLAIPI,');
  qryConsulta.SQL.Add('    CADITE.ITE_NUMFCI,');
  qryConsulta.SQL.Add('    CADITE.ITE_PER_CI,');
  qryConsulta.SQL.Add('    CADITE.ITE_CLAIPI,');
  qryConsulta.SQL.Add('    CADITE.ITE_DESITE,');
  qryConsulta.SQL.Add('    CADITE.ITE_CDCEST,');
  qryConsulta.SQL.Add('    IF(fCfgSis("CFG_TIPABF",ITEGER.ITE_CODEMP) = 1, CADITE.ITE_CODABF, ITEGER.ITE_CODABF) AS ITE_CODABF');
  qryConsulta.SQL.Add('  FROM CADITE');
  qryConsulta.SQL.Add('  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE');
  qryConsulta.SQL.Add('  WHERE CADITE.ITE_CODITE = :CODITE');
  qryConsulta.SQL.Add('  AND ITEGER.ITE_CODEMP = :CODEMP');

  qryConsulta.ParamByName('CODITE').AsString := recProdutoBanco.strcodProd;
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConsulta.Open;
  If not qryConsulta.IsEmpty then
  Begin
    recProdutoBanco.intPorcentagemFCIProd := qryConsulta.FieldByName('ITE_PER_CI').AsInteger;
    recProdutoBanco.strNumFCIProd         := qryConsulta.FieldByName('ITE_NUMFCI').AsString;
    recProdutoBanco.strDesProd            := qryConsulta.FieldByName('ITE_DESITE').AsString;
    recProdutoBanco.strClassIPIProd       := qryConsulta.FieldByName('ITE_CLAIPI').AsString;
    recProdutoBanco.strCESTProd           := qryConsulta.FieldByName('ITE_CDCEST').AsString;
    recProdutoBanco.strCODABF             := qryConsulta.FieldByName('ITE_CODABF').AsString;
  End
  Else
  Begin
    recProdutoBanco.strNumFCIProd := '';
    recProdutoBanco.intPorcentagemFCIProd := -1;
  end;
end;

procedure TfrmListaProdutosFCIDivergenteNFE.pAualizaCodBarra;
  Var
    objCodBar : TIteBar;
    blnPrinc  : Boolean;
    blnAtuCadIte: Boolean;
begin
  objCodBar := TIteBar.Create(opcOperacoes);
  Try
    // Adiciona o Codigo de Barras do Produto.
    if (cdsConsulta.FieldByName('SELCODBAR').AsInteger = 1) and
       (not fEmptyStr(cdsConsulta.Fieldbyname('CODBAR_NOTA').AsString)) then
    Begin
      objCodBar.pCarregaDados(cdsConsulta.FieldByName('CODITE').AsString);
      //Se não tiver cod de barras cadastrado marca este como principal e atualiza a cadite
      blnAtuCadIte := (fRetQtdIteBar(cdsConsulta.FieldbyName('CODITE').AsString) = 0);
      If blnAtuCadIte then
         blnPrinc := true
      else
         blnPrinc := cdsConsulta.FieldByname('CODBAR_PRINC').AsInteger = 1;

      objCodBar.pIncluiCodigo(cdsConsulta.FieldbyName('CODBAR_NOTA').AsString,
                              cdsConsulta.FieldByName('CODBAR_FATOR').AsInteger,
                              blnPrinc,
                              IIf(Not fTemPrincipalParaCompra(cdsConsulta.FieldByName('CODITE').AsString),
                                                              True,
                                                              cdsConsulta.FieldByname('CODBAR_PRINCOM').AsInteger = 1),
                              blnPrinc,
                              0,
                              '',
                              '',
                              '',
                              0,0,0,0,0,0,0,0,
                              blnAtuCadIte);

      objCodBar.pSalvaDados(cdsConsulta.FieldByName('CODITE').AsString, True);
      objCodBar.pCarregaDados('');
    End;
  Finally
    FreeAndNil(objCodBar);
  End;
End;

procedure TfrmListaProdutosFCIDivergenteNFE.pCarregaCadastroCest;
  Var
    frmCadCest: TfrmCadCest;
    strErro: String;
    blnDeletou: Boolean;
begin
  If (cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger = 1) And
     (cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 1) Then
    Exit;

  pCriarFormularios(TfrmCadCest, frmCadCest);
  Try
     frmCadCest.strNCM := cdsConsulta.FieldByName('CLAIPI_NOTA').AsString;
     frmCadCest.strCest := cdsConsulta.FieldByName('CDCEST_NOVO').AsString;
     frmCadCest.pInicializaDescricaoCEST;
     frmCadCest.Showmodal;
     cdsConsulta.Edit;

     cdsConsulta.FieldByName('CDCEST_NOVO').AsString := fRetCEST(cdsConsulta.FieldByName('CLAIPI_NOTA').AsString,
                                                                 cdsConsulta.FieldByName('CODITE').AsString,
                                                                 frmCadCest.strCest);


     If cdsConsulta.FieldByName('CDCEST_NOVO').AsString = ''
      Then
     Begin
       cdsConsulta.Cancel;
       Exit;
     End;

     If cdsConsulta.FieldByName('CDCEST_NOVO').AsString <> '' Then
     Begin
       cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger := 1;
       cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger := 1;
       cdsConsulta.Post;

       cdsConsulta.First;
       While not cdsConsulta.Eof do
       Begin
         strErro := '';
         blnDeletou := false;
         If (cdsConsulta.FieldByName('CLAIPI_NOTA').AsString = frmCadCest.strNCM) And
            (cdsConsulta.FieldByName('CDCEST_NOVO').AsString = frmCadCest.strCest) And
            (cdsConsulta.FieldByName('CDCEST_NOVO').AsString <> '') Then
         Begin
           cdsConsulta.Edit;
           cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger := 1;
           cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger := 1;
           cdsConsulta.Post;
           If blnMostrarNCM Then
           Begin
             If (cdsConsulta.FieldByName('CLAIPI_NOTA').AsString <> cdsConsulta.FieldByName('CLAIPI_PROD').AsString) then
               strErro := strErro + 'Classificação Fiscal divergente, Nota Fiscal [' + cdsConsulta.FieldByName('CLAIPI_NOTA').AsString + '], no cadastro de produto como [' + cdsConsulta.FieldByName('CLAIPI_PROD').AsString + ']. ' + #$A#$D;
             If (cdsConsulta.FieldByName('CDCEST_NOVO').AsString = '')  Then
               strErro := strErro + 'O código CEST refêrente ao NCM [' +cdsConsulta.FieldByName('CLAIPI_NOTA').AsString+ '] não foi encontrado, para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
             Else If (cdsConsulta.FieldByName('CDCEST_NOVO').AsString <> cdsConsulta.FieldByName('CDCEST_PROD').AsString) then
             Begin
               If cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger = 0 Then
                  strErro := strErro + 'O código CEST [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] não foi encontrado, para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
               Else If cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 0 Then
                  strErro := strErro + 'O código CEST [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] foi encontrado, porém, esta relacionado com outro NCM. Para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
               Else
                 strErro := strErro + 'O código CEST Importado [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] é diferente do cadastro de produto [' + cdsConsulta.FieldByName('CDCEST_PROD').AsString + ']' + #$A#$D;
             End
             Else If (cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger = 1) And (cdsConsulta.FieldByName('CDCEST_NOVO').AsString = cdsConsulta.FieldByName('CDCEST_PROD').AsString) then
             Begin
              If cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger = 0 Then
                strErro := strErro + 'O código CEST [' +cdsConsulta.FieldByName('CDCEST_NOVO').AsString+ '] foi encontrado, porém, esta relacionado com outro NCM. Para inserir presione [ F9 ] sobre a Coluna "Novo Código CEST" ' + #$A#$D
             End;
           End;
           If strErro = '' Then
           Begin
             cdsConsulta.Delete;
             blnDeletou := True;
           End;
         End;
         If not blnDeletou Then
           cdsConsulta.Next;

       End;


     End;




  Finally
    FreeAndNil(frmCadCest);
  End;

end;


procedure TfrmListaProdutosFCIDivergenteNFE.pCarregaCadastroNCM;
  Var
    frmCadNCM: TfrmCadNCM;
begin
  If (cdsConsulta.FieldByName('NCM_CADASTRADO').AsInteger = 1) Then
    Exit;

  If Not fVerificaAcessoSistema('frmCadNCM') Then
  Begin
    fMensagem('','Sem permissão para Cadastro de Nomenclatura Comum do Mercosul (NCM)',['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmCadNCM, frmCadNCM);
  Try
    frmCadNCM.Showmodal;

    If (Not fEmptyStr(fRetDescricaoNcm(cdsConsulta.FieldByName('CLAIPI_NOTA').asString, ''))) Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('NCM_CADASTRADO').AsInteger := 1;
      cdsConsulta.Post;
    End;
  Finally
    FreeAndNil(frmCadNCM);
  end;

end;

procedure TfrmListaProdutosFCIDivergenteNFE.pProcessaIntegridadeDadosCest(strCodCest, strCodNcm, strCodNCMAtual, strCodCESTAtual: string);
Begin
  If (strCodNcm = '') And (strCodCest = '') Then
    Exit;

  cdsConsulta.FieldByName('NCM_CADASTRADO').AsInteger := 0;
  If (Not fEmptyStr(fRetDescricaoNcm(strCodNcm, ''))) Then
    cdsConsulta.FieldByName('NCM_CADASTRADO').AsInteger := 1;

  cdsConsulta.FieldByName('CDCEST_CEST_IGUAL').AsInteger := 0;
  cdsConsulta.FieldByName('CDCEST_NCM_IGUAL').AsInteger := 0;

  If strCodCest = strCodCESTAtual Then
    cdsConsulta.FieldByName('CDCEST_CEST_IGUAL').AsInteger := 1;


  If strCodNcm = strCodNCMAtual Then
    cdsConsulta.FieldByName('CDCEST_NCM_IGUAL').AsInteger := 1;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT CES_CDCEST, CES_CODNCM FROM CDCEST ');
  qryConsulta.SQL.Add(' WHERE CES_CDCEST = ' + QuotedStr(strCodCest));
  qryConsulta.SQL.Add('   AND CES_CODNCM = ' + QuotedStr(strCodNCMAtual));

  qryConsulta.Open;
  If Not qryConsulta.IsEmpty Then
    cdsConsulta.FieldByName('CDCEST_NCM_ATUAL').AsInteger := 1
  Else
    cdsConsulta.FieldByName('CDCEST_NCM_ATUAL').AsInteger := 0;


  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT CES_CDCEST, CES_CODNCM FROM CDCEST ');
  qryConsulta.SQL.Add(' WHERE CES_CDCEST = ' + QuotedStr(strCodCestAtual));
  qryConsulta.SQL.Add('   AND CES_CODNCM = ' + QuotedStr(strCodNcm));

  qryConsulta.Open;
  If Not qryConsulta.IsEmpty Then
    cdsConsulta.FieldByName('CDCEST_CEST_ATUAL').AsInteger := 1
  Else
    cdsConsulta.FieldByName('CDCEST_CEST_ATUAL').AsInteger := 0;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT CES_CDCEST, CES_CODNCM FROM CDCEST ');
  qryConsulta.SQL.Add(' WHERE CES_CDCEST = ' + QuotedStr(strCodCest));
  qryConsulta.SQL.Add('   AND CES_CODNCM = ' + QuotedStr(strCodNcm));

  qryConsulta.Open;
  If Not qryConsulta.IsEmpty Then
  Begin
    cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger := 1;
    cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger := 1;
    Exit;
  End;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT CES_CDCEST, CES_CODNCM FROM CDCEST ');
  qryConsulta.SQL.Add(' WHERE CES_CDCEST = ' + QuotedStr(strCodCest));
  qryConsulta.Open;

  If Not qryConsulta.IsEmpty Then
  Begin
    cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger := 1;
    cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger := 0;
    cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger := 0;
    Exit;
  End
  Else
  Begin
    cdsConsulta.FieldByName('CDCEST_CADASTRADO').AsInteger := 0;
    cdsConsulta.FieldByName('CDCEST_NCM_VALIDO').AsInteger := 0;

    If (strCodCest = '') then
      cdsConsulta.FieldByName('CDCEST_CEST_NOTA_VAZIO').AsInteger := 1;
  End;


End;

function TfrmListaProdutosFCIDivergenteNFE.fTemItensSelecionados: Boolean;
Var
  LTemAlt : Boolean;
  LRecNum : Integer;
begin
  LTemAlt := False;
  LRecNum := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    LTemAlt := fRegistroAlterado;

    If (LTemAlt) Then
      Break;

    cdsConsulta.Next;
  End;
  Result := LTemAlt;
  cdsConsulta.RecNo := LRecNum;
  cdsConsulta.EnableControls;
end;

function TfrmListaProdutosFCIDivergenteNFE.fRegistroAlterado: Boolean;
begin
  Result := False;

  If (cdsConsulta.FieldByName('SELCLAFIS').AsInteger = 1) Then
    Exit(True);

  If (cdsConsulta.FieldByName('SELCEST').AsInteger = 1) Then
    Exit(True);

  If (cdsConsulta.FieldByName('SELCODBAR').AsInteger = 1) Then
    Exit(True);

  If (cdsConsulta.FieldByName('SELFCI').AsInteger = 1) Then
     Exit(True);

  If (cdsConsulta.FieldByName('SELPCI').AsInteger = 1) Then
    Exit(True);
end;

function TfrmListaProdutosFCIDivergenteNFE.fPermiteAlteracao: Boolean;
  Var
    objLiberacao: TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    strContCli : String;
Begin
  If (fCfgSis('ALTFCI') = 'N') Then
    Result := True
  Else
  Begin
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objLiberacao.intLarguraMotivos := 1800;
    Try
      objLiberacao.objMsgLibera.pAddTexto('Na importação da Nota Fiscal Eletronica de Entrada, após listadas divergencias entre NFe x AUTCOM ');
      objLiberacao.objMsgLibera.pAddTexto('(para FCI, NCM, CEST, COD DE BARRAS, COD FABRICA, PORCENTUAL CI), usuário solicita atualização do Cadastro do Produto. ');
      objLiberacao.objMsgLibera.pAddTexto('');

      objLiberacao.objMsgLibera.pAddTexto('Operador.......: ' + strLoginUsuarioLogado +
                                    '       Documento: ' + cdsConsulta.FieldByName('NUMNFE').AsString + '-NF-' + VS_strCodEmp +
                                    '       Data Emissão: ' + cdsConsulta.FieldByName('DTAEMI').AsString);
      objLiberacao.objMsgLibera.pAddTexto('Chave de Acesso: ' + cdsConsulta.FieldByName('CHVNFE').AsString );
      objLiberacao.objMsgLibera.pAddTexto('Fornecedor.....: ' +
                                          cdsConsulta.FieldByName('CODFOR').AsString + ' - ' +
                                          cdsConsulta.FieldByName('NOMFOR').AsString);

      objLiberacao.objMsgLibera.pAddQuebra;

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , ' '              , 7 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'NCM'            , 22 , alCentro , teAutcom);
      objLinha.pAddColuna(''  , 'CEST'           , 22 , alCentro  , teAutcom);
      objLinha.pAddColuna(''  , 'COD. BARRAS '   , 34 , alCentro  , teAutcom);
      objLinha.pAddColuna(''  , 'FCI'            , 82 , alCentro  , teAutcom);
      objLinha.pAddColuna(''  , 'PERCENTUAL (CI)', 22 , alCentro  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'ITEM '         , 7 , alEsquerda , teAutcom);
      //NCM
      objLinha.pAddColuna(''  , 'ATU.'          , 4 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'NFE'           , 6 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'AUTCOM'        , 8 , alCentro   , teAutcom);
      //CEST
      objLinha.pAddColuna(''  , 'ATU.'          , 4 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'NFE'           , 7 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'AUTCOM'        , 7 , alCentro   , teAutcom);
      //COD. BARRAS
      objLinha.pAddColuna(''  , 'ATU.'          , 4 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'NFE'           , 13, alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'AUTCOM'        , 13, alCentro   , teAutcom);
      //FCI
      objLinha.pAddColuna(''  , 'ATU.'          , 4 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'NFE'           , 37, alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'AUTCOM'        , 37, alCentro   , teAutcom);
      //PERCENTUAL CI
      objLinha.pAddColuna(''  , 'ATU.'          , 4 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'NFE'           , 6 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'AUTCOM'        , 8 , alCentro   , teAutcom);

      objTabela.lstLinhas.Add(objLinha);

      strContCli := '';

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        IF (fRegistroAlterado) then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('ITEM'  , cdsConsulta.FieldByName('PRODUT').AsString  , 7 , alEsquerda );
          //NCM
          objLinha.pAddColuna('ATU.'  , IIF(cdsConsulta.FieldByName('SELCLAFIS').AsString = '1', '[X]', '-'), 4 , alEsquerda , teAutcom);
          objLinha.pAddColuna('NFE'   , cdsConsulta.FieldByName('CLAIPI_NOTA').AsString , 6 , alCentro   , teAutcom);
          objLinha.pAddColuna('AUTCOM', cdsConsulta.FieldByName('CLAIPI_PROD').AsString , 8 , alCentro   , teAutcom);
          //CEST
          objLinha.pAddColuna('ATU.'  , IIF(cdsConsulta.FieldByName('SELCEST').AsString = '1', '[X]', '-') , 4 , alCentro , teAutcom);
          objLinha.pAddColuna('NFE'   , cdsConsulta.FieldByName('CDCEST_NOVO').AsString , 6 , alCentro   , teAutcom);
          objLinha.pAddColuna('AUTCOM', cdsConsulta.FieldByName('CDCEST_PROD').AsString , 8 , alCentro   , teAutcom);
          //COD. BARRAS
          objLinha.pAddColuna('ATU.'  , IIF(cdsConsulta.FieldByName('SELCODBAR').AsString = '1', '[X]', '-'), 4 , alCentro , teAutcom);
          objLinha.pAddColuna('NFE'   , cdsConsulta.FieldByName('CODBAR_NOTA').AsString , 13, alCentro   , teAutcom);
          objLinha.pAddColuna('AUTCOM', cdsConsulta.FieldByName('CODBAR_PROD').AsString , 13, alCentro   , teAutcom);
          //FCI
          objLinha.pAddColuna('ATU.'  , IIF(cdsConsulta.FieldByName('SELFCI').AsString = '1', '[X]', '-'), 4 , alCentro , teAutcom);
          objLinha.pAddColuna('NFE'   , cdsConsulta.FieldByName('NUMFCI_NOTA').AsString , 37, alCentro   , teAutcom);
          objLinha.pAddColuna('AUTCOM', cdsConsulta.FieldByName('NUMFCI_PROD').AsString , 37, alCentro   , teAutcom);
          //PERCENTUAL CI
          objLinha.pAddColuna('ATU.'  , IIF(cdsConsulta.FieldByName('SELPCI').AsString = '1', '[X]', '-'), 4 , alCentro , teAutcom);
          objLinha.pAddColuna('NFE'   , cdsConsulta.FieldByName('PERFCI_NOTA').AsString + '%', 6 , alCentro   , teAutcom);
          objLinha.pAddColuna('AUTCOM', cdsConsulta.FieldByName('PERFCI_PROD').AsString + '%', 8 , alCentro   , teAutcom);

          objTabela.lstLinhas.Add(objLinha);
        End;
        cdsConsulta.Next;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.strDirAce := 'PERMALTFCI';
      objLiberacao.strMsgSen := 'Permitir alterar no cadastro do produto: NCM, CEST, FCI, quando houver divergências na Importação de Nota Fiscal Eletronica';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
end;

end.
