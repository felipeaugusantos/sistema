unit untGerarOrdemdeProducaoPorArquivoDeImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, FilenameEditFocus, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ComCtrls, untTValidaExcel,
  System.Character, untZClient, uni, cxCurrencyEdit,
  untImportarArquivoParaAnalise_de_Compras_Totais,
  untGerarOrcamentoCompraAuto, cxProgressBar, System.strUtils,
  cxDBLookupComboBox, cxDropDownEdit, untSaldoLojas, untTProcessaArquivo_Deceuninck_Kommerling,
  EditFocus, ComboBoxFocus;

type
  TItensFatdor = Class
    ItemCodite: string;
    ItemDescricao: String;
    ItemQuantidade: Double;
    strCodCli: String;
  end;

  TfrmGerarOrdemdeProducaoPorArquivoDeImportacao = class(TfrmPai)
    pnHeader: TPanel;
    edtPath: TFilenameEditFocus;
    Label1: TLabel;
    btnCarregar: TBitBtnLocked;
    Panel2: TPanel;
    cxDados: TcxGrid;
    cxDadosDB: TcxGridDBTableView;
    cxDadosLvl: TcxGridLevel;
    dtsDados: TDataSource;
    cxDadosCODITE: TcxGridDBColumn;
    cxDadosDESITE: TcxGridDBColumn;
    cxDadosSIGUNI: TcxGridDBColumn;
    cxDadosSALDOS: TcxGridDBColumn;
    cxDadosSALDIS: TcxGridDBColumn;
    cxDadosPEDCOM: TcxGridDBColumn;
    cxDadosQTDIMP: TcxGridDBColumn;
    cxDadosQTDSUG: TcxGridDBColumn;
    cxDadosVLRUNI: TcxGridDBColumn;
    cxDadosVLRTOT: TcxGridDBColumn;
    cxDadosCODFOR: TcxGridDBColumn;
    cxDadosNOMFOR: TcxGridDBColumn;
    cxDadosIDENTIFICADO: TcxGridDBColumn;
    cxDadosMARCADO: TcxGridDBColumn;
    Panel3: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    pgbProgresso: TcxProgressBar;
    Label5: TLabel;
    Shape3: TShape;
    dtsDuplicados: TDataSource;
    Label6: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    lblEspecie: TLabel;
    edtCodEmp: TEditFocus;
    lblSerie: TLabel;
    pnlProdutoAcabado: TPanel;
    Label3: TLabel;
    lblProjeto: TLabel;
    cxDadosGRUPO: TcxGridDBColumn;
    btnGerarDocumentos: TBitBtnLocked;
    btnApagarProduto: TBitBtnLocked;
    btnApagarProdutos: TBitBtnLocked;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    cxDadosDBColumn1: TcxGridDBColumn;
    cxDadosDBColumn2: TcxGridDBColumn;
    procedure btnCarregarClick(Sender: TObject);


    function fValidaPedidoVenda: Boolean;
    procedure FormCreate(Sender: TObject);
    procedure cxDadosDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxDadosDBCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);

    procedure cxDadosDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxDadosDBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTotaisPorFornecedorClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxDadosDBKeyPress(Sender: TObject; var Key: Char);
    procedure cxDadosDBEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxDadosDBDblClick(Sender: TObject);
    function fAtendeCondicoesDeConsulta(blnKeyDeBusca, blnFocado, blnEmEdicao: Boolean): Boolean;
    procedure btnGerarDocumentosClick(Sender: TObject);
    procedure pGravaOrdem;
    procedure pReiniciaProcesso;

    function fGeraOrdemDeProducao(prg: TcxProgressBar): Boolean;
    procedure pRemoveOrdemCasoExista;
    function fGravaMovPro(var strSeqMovPro: String; strCodMovPro: String): boolean;
    function fGravaDETPRO(strSeqMovPro: String): boolean;
    function fProximoCodigo: String;
    function fOrdemProducaoExitebaixada: Boolean;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function fControlLeft(AShift: TShiftState; AButton: TMouseButton): Boolean;
    procedure btnApagarProdutoClick(Sender: TObject);
    procedure btnApagarProdutosClick(Sender: TObject);
    procedure edtDocumentoKeyPress(Sender: TObject; var Key: Char);
  private
    ItensFatdor : TItensFatdor;
    FOrdemDeProducaoExistente  : String;
    FOrdemDeProducaoExistenteSeqGer: String;
    ProcessaArquivo: TProcessaArquivo;
    qryCommand: TUniQuery;
    procedure pMarcaDesmarcaItem;
    procedure pPreencheProdutoAcabado;

    { Private declarations }
  public
    destructor Destroy; override;


    { Public declarations }
  end;

var
  frmGerarOrdemdeProducaoPorArquivoDeImportacao: TfrmGerarOrdemdeProducaoPorArquivoDeImportacao;



implementation

uses
  untFuncoesSimples, untGravando, untConsultas, untTypesSistema, untImportarListaDeMateriais,
  untFuncoes, untSelecionaItemDuplicadoCodFabrica;


{$R *.dfm}

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.btnApagarProdutoClick(
  Sender: TObject);
Var
  strDescricao: String;
begin
  inherited;
  strDescricao := dtsDados.DataSet.FieldByName('CODITE').AsString + ' - ' +
    dtsDados.DataSet.FieldByName('DESITE').AsString;
  if fPergunta('Confirma a exclusão do produto ' + strDescricao + '?') then
    dtsDados.DataSet.Delete;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.btnApagarProdutosClick(
  Sender: TObject);
begin
  inherited;
  if fPergunta('Confirma a exclusão dos produtos com quantidade maior que saldo disponível?') then
  Begin
    dtsDados.DataSet.First;
    dtsDados.DataSet.DisableControls;
    while Not dtsDados.DataSet.Eof do
    Begin
      if dtsDados.DataSet.FieldByName('QTDIMP').AsCurrency > dtsDados.DataSet.FieldByName('SALDIS').AsCurrency then
      Begin
        dtsDados.DataSet.Delete;
        Continue;
      End;
     dtsDados.DataSet.Next;
    End;
    ProcessaArquivo.blnTemItemSemSaldo := dtsDados.DataSet.IsEmpty;
    dtsDados.DataSet.EnableControls;
  End;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.btnCarregarClick(
  Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtPath.Text) Then
  Begin
    pMensagemOK('Arquivo não informado ou não existente!');
    pSetFocus(edtPath);
    Exit;
  End;

  FOrdemDeProducaoExistenteSeqGer := '';
  FOrdemDeProducaoExistente       := '';
  if Not fValidaPedidoVenda Then
    Exit;
  ProcessaArquivo.TipoLayout := tlDeceuninckOrdemProducao;
  dtsDados.DataSet := ProcessaArquivo.FQryDados;
  ProcessaArquivo.strNumPed := edtDocumento.Text;
  ProcessaArquivo.strEmpPed := edtCodEmp.Text;
  ProcessaArquivo.strEspPed := edtEspecie.Text;

  ProcessaArquivo.Arquivo := edtPath.Text;
  if fOrdemProducaoExitebaixada Then
    Exit;

  lblProjeto.Caption := ProcessaArquivo.Projeto;
  cxDadosDB.ViewData.Expand(True);
  cxDadosDB.DataController.DataSet.First;
  pnlProdutoAcabado.Enabled := True;
  pPreencheProdutoAcabado;
  pnHeader.Enabled := False;

end;

function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fOrdemProducaoExitebaixada: Boolean;
var qryConsulta : TUniQuery;
begin
  Result := False;
  qryConsulta := fCriaQuery;
  Try
    If fEmptyStr(ProcessaArquivo.Projeto) Then
    begin
      pMensagemOK('Não foi identificado o Projeto no arquivo!');
      pReiniciaProcesso;
      Exit(True)
    End;
    qryConsulta.SQL.Add('SELECT * FROM MOVPRO WHERE PRO_PROJEC = "'+ProcessaArquivo.Projeto+'"');
    qryConsulta.Open;
    If Not fEmptyStr(qryConsulta.FieldByName('PRO_DTABAI').AsString) Then
    Begin
      pMensagemOK('Ordem de Produção já importada e baixada!');
      pReiniciaProcesso;
      Exit(True);
    End;

    If qryConsulta.FieldByName('PRO_IMPDEF').AsString = 'S' Then
    Begin
      pMensagemOK('Ordem de Produção já foi importada como definitiva, para importar novamente tem que excluir a ordem ['+qryConsulta.FieldByName('PRO_CODPRO').AsString+']');
      pReiniciaProcesso;
      Exit(True);
    End;

    FOrdemDeProducaoExistente := qryConsulta.FieldByName('PRO_CODPRO').AsString;
    FOrdemDeProducaoExistenteSeqGer := qryConsulta.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryConsulta);
  end;
End;



procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.pPreencheProdutoAcabado;
var qryConsulta : TUniQuery;
    strIORPRO: String;
begin
  strIORPRO := fCfgSis('IORPRO', varString);
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT CONCAT(ITE_CODITE,"-", ITE_DESITE) AS ITEM, ' +
      'ITE_CODITE AS CODITE, ITE_DESITE AS DESITE, SUM(FDO_QTDITE) AS QTDITE, FDO_CODCLI AS CODCLI FROM FATDOR, CADITE ');
    qryConsulta.SQL.Add(' WHERE FDO_NUMDOC = "'+edtDocumento.Text+'"');
    qryConsulta.SQL.Add('   AND FDO_ESPDOC = "PD"');
    qryConsulta.SQL.Add('   AND FDO_CODEMP = "'+VS_StrCodEmp+'"');
    qryConsulta.SQL.Add('   AND ITE_CODITE = "'+ strIORPRO+ '"');
    qryConsulta.SQL.Add('   GROUP BY ITE_CODITE');
    qryConsulta.Open;

    ItensFatdor:= TItensFatdor.Create;
    ItensFatdor.ItemCodite := qryConsulta.FieldByName('CODITE').AsString;
    ItensFatdor.ItemDescricao := qryConsulta.FieldByName('DESITE').AsString;
    ItensFatdor.ItemQuantidade := 1;
    ItensFatdor.strCodCli := qryConsulta.FieldByName('CODCLI').AsString;

    edtCodIte.Text := qryConsulta.FieldByName('CODITE').AsString;
    edtDesIte.Text := qryConsulta.FieldByName('DESITE').AsString;
  finally
    freeAndNil(qryConsulta);
  End;

end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.pRemoveOrdemCasoExista;
begin
  If FOrdemDeProducaoExistenteSeqGer = '' Then
    Exit;

  qryCommand.SQL.Clear;
  qryCommand.sql.Add('DELETE FROM MOVPRO WHERE AUTOINCREM = "'+FOrdemDeProducaoExistenteSeqGer+'"');
  qryCommand.ExecSQL;

  qryCommand.SQL.Clear;
  qryCommand.sql.Add('DELETE FROM DETPRO WHERE DOP_SEQGER = "'+FOrdemDeProducaoExistenteSeqGer+'"');
  qryCommand.ExecSQL;

end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.btnGerarDocumentosClick(
  Sender: TObject);
begin
  inherited;
  ProcessaArquivo.FQryDados.DisableControls;
  Try
    {If ProcessaArquivo.blnTemItemSemSaldo then
    begin
      pMensagemOK('Exitem itens sem saldo disponível, não será possível gerar Ordem de Produção!');
      Exit;
    end;}

    If fEmptyStr(edtCodIte.Text) Then
    begin
      pMensagemOK('Por favor identifique o Item do pedido!');
      Exit;
    End;

     pGravaOrdem;
  Finally
    ProcessaArquivo.FQryDados.EnableControls;
  End;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.btnTotaisPorFornecedorClick(
  Sender: TObject);
begin
  inherited;
  ProcessaArquivo.pVisualizaTotais;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.cxDadosDBCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
  var blnEditing: Boolean;
begin
  inherited;
  blnEditing := True;
  If ProcessaArquivo.FqryDados.FieldByname('IDENTIFICADO').AsInteger = tsiNaoEncontrado Then
    blnEditing := False;
//  cxDadosCODFOR.Options.Editing := blnEditing;
  cxDadosQTDSUG.Options.Editing := blnEditing;
  cxDadosCODITE.Options.Editing := Not  blnEditing;
end;

function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fControlLeft(AShift: TShiftState; AButton: TMouseButton): Boolean;
begin
 Result := false;
 if (AShift = [ssCtrl]) then
   If (AButton = mbLeft) Then
     result := True;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.cxDadosDBCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  {If fControlLeft(AShift, AButton) Then
    pMarcaDesmarcaItem;}
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.cxDadosDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not VarIsNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosMARCADO.Index]) Then
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosMARCADO.Index] = 1 Then
    Begin
      ACanvas.Brush.Color :=  clAqua;
      ACanvas.Font.Color :=  clBlack;
    End;

  If Not VarIsNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosIDENTIFICADO.Index]) Then
  Begin
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosIDENTIFICADO.Index] = tsiNaoEncontrado Then
      ACanvas.Font.Color := clRed;
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosIDENTIFICADO.Index] = tsiDuplicado Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.cxDadosDBDblClick(
  Sender: TObject);
begin
  ProcessaArquivo.pEscolheItensDuplicados;
end;


function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fAtendeCondicoesDeConsulta(blnKeyDeBusca, blnFocado, blnEmEdicao: Boolean): Boolean;
begin
  Result := False;
  if blnKeyDeBusca Then
   if blnFocado Then
     if blnEmEdicao Then
       Result := True;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.cxDadosDBEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  var qryConIte: TUniQuery;
    arrSel: TConsultasArray;
    IntRecNo: Integer;
begin
  inherited;
  qryConIte := fCriaQuery;
  Try
    If fAtendeCondicoesDeConsulta(fEntraCons(Key) ,cxDadosCODITE.Focused , cxDadosCODITE.Options.Editing) Then
    Begin
      if fPesqItem(conIteSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel,
                   True,
                   Nil,
                   'Consulta de Itens',
                   '1',
                   '',
                   0,
                   false,
                   false,
                   0) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODITE').AsString :=  qryConIte.FieldByName('ITE_CODITE').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;
      End;
    End;
    If fAtendeCondicoesDeConsulta(fEntraCons(Key), cxDadosCODFOR.Focused, cxDadosCODFOR.Options.Editing) Then
    Begin
      if fPesqFornecedor(conForSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODFOR').AsString :=  qryConIte.FieldByName('FOR_CODFOR').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;

      End;
    End;
  Finally
    FreeAndNil(qryConIte);
  End;

end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.cxDadosDBKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = [ssShift]) then
   if (Key in [VK_UP, VK_DOWN]) Then
     pMarcaDesmarcaItem;

end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.cxDadosDBKeyPress(
  Sender: TObject; var Key: Char);
  var qryConIte: TUniQuery;
    arrSel: TConsultasArray;
    IntRecNo: Integer;
begin
  inherited;
  qryConIte := fCriaQuery;
  Try
    If fAtendeCondicoesDeConsulta(fEntraCons(Key), cxDadosCODITE.Focused, cxDadosCODITE.Options.Editing) Then
    Begin
      if fPesqItem(conIteSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel,
                   True,
                   Nil,
                   'Consulta de Itens',
                   '1',
                   '',
                   0,
                   false,
                   false,
                   0) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODITE').AsString :=  qryConIte.FieldByName('ITE_CODITE').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;
      End;
    End;
    If fAtendeCondicoesDeConsulta(fEntraCons(Key), cxDadosCODFOR.Focused, cxDadosCODFOR.Options.Editing) Then
    Begin
      if fPesqFornecedor(conForSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODFOR').AsString :=  qryConIte.FieldByName('FOR_CODFOR').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;
      End;
    End;
  Finally
    FreeAndNil(qryConIte);
  End;
end;

destructor TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.Destroy;
begin
  FreeAndNil(ItensFatdor);
  FreeAndNil(qryCommand);
  inherited;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.edtDocumentoKeyPress(Sender: TObject; var Key: Char);
  Var
  qryPedido : TUniQuery;
  arrDoc : TConsultasArray;
begin
  inherited;
  qryPedido := fCriaQuery(Self);
  If fPesqPedOrc(conPedSimples, Self, edtEspecie.Text, edtEspecie.Text, VS_strCodEmp, edtDocumento, edtEspecie, Nil, qryPedido, Key, arrDoc) Then
  Begin
    If fValidaCampos(edtDocumento, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  FreeAndNil(qryPedido);
end;

function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fGeraOrdemDeProducao(
  prg: TcxProgressBar): Boolean;
var strSeqMovPro: String;
    strCodMovPro: String;
begin
  Result := True;
  Try
    fStartTransaction;
    pRemoveOrdemCasoExista;
    ProcessaArquivo.FQryDados.First;
    fGravaMovPro(strSeqMovPro, strCodMovPro);
    prg.Properties.Max :=  ProcessaArquivo.FQryDados.RecordCount;
    while not ProcessaArquivo.FQryDados.Eof do
    begin
      fGravaDETPRO(strSeqMovPro);
      ProcessaArquivo.FQryDados.Next;
      prg.Position := ProcessaArquivo.FQryDados.RecNo;
      Application.ProcessMessages;
    End;
    fCommit;
  Except
    on e: exception do
    Begin
      fRollBack;
      pMensagensErro(e.message, '[TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fGeraOrdemDeProduca]');
      Result := False;
    End;
  End;
end;


function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fGravaDETPRO(strSeqMovPro: String): boolean;
begin
  If ProcessaArquivo.FQryDados.FieldByName('IDENTIFICADO').AsInteger = 0 Then
    Exit(True);

  qryCommand.SQl.Clear;
  qryCommand.SQL.Add('INSERT INTO DETPRO ( DOP_SEQGER,  DOP_SEQUEN,   DOP_CODEMP,   DOP_ITESUB,  DOP_QTDITE,  DOP_NUMLOT,  DOP_NUMFAS, AUTOINCREM, DOP_QTDARQ)');
  qryCommand.SQL.Add('            VALUES (:DOP_SEQGER, :DOP_SEQUEN,  :DOP_CODEMP,  :DOP_ITESUB, :DOP_QTDITE, :DOP_NUMLOT, :DOP_NUMFAS, :AUTOINCREM, :DOP_QTDITE)');

  qryCommand.ParamByName('DOP_SEQGER').AsString := strSeqMovPro;
  qryCommand.ParamByName('DOP_SEQUEN').AsString := fAtualizaProCod('DETPRO', 'DOP_SEQUEN');
  qryCommand.ParamByName('DOP_CODEMP').AsString := VS_StrCodEmp;
  qryCommand.ParamByName('DOP_ITESUB').AsString := ProcessaArquivo.FQryDados.FieldByName('CODITE').AsString;
  qryCommand.ParamByName('DOP_QTDITE').AsFloat := ProcessaArquivo.FQryDados.FieldByName('QTDIMP').AsFloat;
  qryCommand.ParamByName('DOP_NUMFAS').AsInteger := ProcessaArquivo.FQryDados.RecNo;
  qryCommand.ParamByName('DOP_NUMLOT').Clear;
  qryCommand.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('DETPRO', VS_StrCodEmp);
  qryCommand.ExecSQL;

  qryCommand.SQl.Clear;
  qryCommand.SQl.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = "'+ProcessaArquivo.FQryDados.FieldByName('CODITE').AsString+'" AND ITE_CODEMP = "'+VS_StrCodEmp+'"');
  qryCommand.ExecSQL;

  Result := True;
end;

function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fProximoCodigo: String;
begin
  Result := fAtualizaProCod('MOVPRO', 'PRO_CODPRO');
end;


function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fGravaMovPro(var strSeqMovPro: String; strCodMovPro: String): boolean;
Var
  blnImpDef: Boolean;
begin
  blnImpDef := fPergunta('A importação é definitiva?');

  qryCommand.SQl.Clear;
  qryCommand.SQl.Add('INSERT INTO MOVPRO ( AUTOINCREM,  PRO_CODEMP,  PRO_CODPRO,  PRO_CODITE,  PRO_QTDAPR,  PRO_DTAPRO, PRO_DTACAD,   PRO_NUMPED,  PRO_ESPPED,  PRO_EMPPED,  PRO_CODCLI,  PRO_PROJEC, PRO_IMPDEF, PRO_PRINCI)  VALUES');
  qryCommand.SQl.Add('                   (:AUTOINCREM, :PRO_CODEMP, :PRO_CODPRO, :PRO_CODITE, :PRO_QTDAPR, :PRO_DTAPRO, :PRO_DTACAD, :PRO_NUMPED, :PRO_ESPPED, :PRO_EMPPED, :PRO_CODCLI, :PRO_PROJEC, :PRO_IMPDEF, :PRO_PRINCI)');


  strSeqMovPro := fRetAutoIncrem('MOVPRO', VS_StrCodemp);

  If Not fEmptyStr(FOrdemDeProducaoExistente) Then
    strCodMovPro := FOrdemDeProducaoExistente
  Else
    strCodMovPro := fProximoCodigo;

  FOrdemDeProducaoExistente := strCodMovPro;
  qryCommand.ParamByName('AUTOINCREM').AsString := strSeqMovPro;
  qryCommand.ParamByName('PRO_CODEMP').AsString := VS_StrCodEmp;
  qryCommand.ParamByName('PRO_CODPRO').AsString := strCodMovPro;
  qryCommand.ParamByName('PRO_CODITE').AsString := ItensFatdor.ItemCodite;
  qryCommand.ParamByName('PRO_QTDAPR').AsFloat := 1;
  qryCommand.ParamByName('PRO_DTAPRO').AsDateTime := fNow;
  qryCommand.ParamByName('PRO_DTACAD').AsDateTime := fNow;
  qryCommand.ParamByName('PRO_NUMPED').AsString := edtDocumento.Text;
  qryCommand.ParamByName('PRO_ESPPED').AsString := edtEspecie.Text;
  qryCommand.ParamByName('PRO_EMPPED').AsString := edtCodEmp.Text;
  qryCommand.ParamByName('PRO_CODCLI').AsString := ItensFatdor.strCodCli;
  qryCommand.ParamByName('PRO_PROJEC').AsString := lblProjeto.Caption;
  qryCommand.ParamByName('PRO_IMPDEF').AsString := IfThen(blnImpDef, 'S','N');
  qryCommand.ParamByName('PRO_PRINCI').AsString := 'S';

  qryCommand.ExecSQL;
  Result := True;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.FormCloseQuery(
  Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  If Not pnHeader.Enabled Then
  begin
    If fPergunta('Reinicar processo?') Then
    begin
       pReiniciaProcesso;
       canClose := False;
    end;
  End;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.FormCreate(Sender: TObject);
begin
  inherited;
  ItensFatdor := TItensFatdor.Create;

  FOrdemDeProducaoExistenteSeqGer := '';
  FOrdemDeProducaoExistente       := '';

  edtCodEmp.Text := VS_StrCodEmp;
  edtEspecie.Text := 'PD';
  ProcessaArquivo := TProcessaArquivo.Create(pgbProgresso, toAnaliseDeCompra);
  qryCommand := fCriaQuery;
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case  Key  of
    VK_F1 : btnGerarDocumentos.OnClick(Sender);
    VK_F2 : btnApagarProdutos.Click;
    VK_DELETE : btnApagarProduto.Click;
  End;
end;

function TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.fValidaPedidoVenda: Boolean;
var qryConsulta : TUniQuery;
begin
  result := True;
  Try

    qryConsulta := fCriaQuery;
    qryConsulta.SQL.Add('SELECT FGO_JAFATU FROM FATGOR');
    qryConsulta.SQL.Add(' WHERE FGO_NUMDOC = "'+edtDocumento.Text+'"');
    qryConsulta.SQL.Add('   AND FGO_ESPDOC = "PD"');
    qryConsulta.SQL.Add('   AND FGO_CODEMP = "'+VS_StrCodEmp+'"');
    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
    begin
      result := False;
      pMensagemOK('Documento não foi encontrado!')
    End;

    If qryConsulta.FieldByName('FGO_JAFATU').AsInteger > 0  Then
    begin
      result := False;
      pMensagemOK('Documento ja foi faturado!')
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
  {}
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.pGravaOrdem;
var frmGravando: TFrmGravando;
begin
  pCriarFormularios(TFrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Gerando Ordem de Produção';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fGeraOrdemDeProducao;
    frmGravando.ShowModal;

    If frmGravando.blnConfirma Then
    begin
      pMensagemOK('Ordem de Produção Gerada: ' +FOrdemDeProducaoExistente +'!');
      pReiniciaProcesso;
    End;

  Finally
    FreeAndNil(frmGravando);
  End;



end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.pReiniciaProcesso;
begin
  pnHeader.Enabled := True;
  edtDocumento.Text := '';
  edtPath.Text := '';

  ProcessaArquivo.FQryDados.EmptyDataSet;
  pSetFocus(edtPath);
end;

procedure TfrmGerarOrdemdeProducaoPorArquivoDeImportacao.pMarcaDesmarcaItem;
var blnMarca: Boolean;
begin
  If ProcessaArquivo.FqryDados.FieldByName('IDENTIFICADO').AsInteger = tsiNaoEncontrado Then
    Exit;
  ProcessaArquivo.FqryDados.Edit;
  blnMarca := ProcessaArquivo.FqryDados.FieldByName('MARCADO').AsInteger = 0;
  ProcessaArquivo.FqryDados.FieldByName('MARCADO').AsInteger := IIf(blnMarca, 1, 0);
  lblProjeto.Caption  := '';
  ProcessaArquivo.FqryDados.Post;
end;

end.
