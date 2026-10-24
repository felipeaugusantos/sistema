unit untSelPedidoCompraImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxCheckBox, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untConfiguraImpressaoPedidoCompra, untTypesSistema, untConstantes;

type
  TfrmSelPedidoCompraImpressao = class(TfrmPaiConfirma)
    cxPedidosTbl: TcxGridDBTableView;
    cxPedidosLvl: TcxGridLevel;
    cxPedidos: TCxGrid;
    cxPedidosNUMPED: TcxGridDBColumn;
    cxPedidosCODEMP: TcxGridDBColumn;
    cxPedidosSELECI: TcxGridDBColumn;
    popAcao: TPopupMenu;
    mnuSeleciona: TMenuItem;
    mnuDeseleciona: TMenuItem;
    mnuEmpresaLogada: TMenuItem;
    dtsDados: TDataSource;
    pnlErr: TPanel;
    lblErr: TLabel;
    ERR_CONFIG: TcxGridDBColumn;
    procedure mnuSelecionaClick(Sender: TObject);
    procedure mnuDeselecionaClick(Sender: TObject);
    procedure mnuEmpresaLogadaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function fRecordCount: integer;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxPedidosTblCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxPedidosSELECIPropertiesChange(Sender: TObject);
  private
    FDados: TZClient;
    blnExportou : Boolean;

    procedure gerenciaSelecionados(opcao : integer);
    function  fValidaConfiguracoes: boolean;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);

    procedure pExportouEditorRelatorio(var message: TMessage); message WM_EXECUTOUEXPORTACAO;

    { Private declarations }
  public
    { Public declarations }
    objImpressaoRel: TConfiguraImpressaoPedidoCompra;
    strEspDoc: string;
    strCodEmp: string;
    blnImpRes: Boolean;
    blnSemQtd: Boolean;
    blnResUni: Boolean;
    blnLitMar: Boolean;
    blnImpVen: Boolean;
    blnRefere: Boolean;
    blnResAOb: Boolean;
    blnCodFab: Boolean;
    blnImpRef: Boolean;
    blnLocFis: Boolean;
    strPath: string;
    intQtVias: integer;
    intTipoCodBarras: integer;
    blnNovoReg: boolean;
    strCondPagBosh: string;
    strFornecedor: string;
    procedure fInserirPedidoGerado(strCodEmp: string; strNumPed: string);
    property RecordCount: integer read fRecordCount;
  end;

  const cTodos = 1;
        cNenhum = 0;
        cEmpresa = 2;
var
  frmSelPedidoCompraImpressao: TfrmSelPedidoCompraImpressao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesPedido, untCadPagBosch, untFornecedorBosh,
  untOpcPdfPedidoCompra;

procedure TfrmSelPedidoCompraImpressao.btnConfirmaClick(Sender: TObject);
  var
    strNomeFila, strTipImp: string;
    bImprimirRelatorioDireto, bExibirMensagemDeArquivoGerado: Boolean;
    utimoRegistro: Integer;
begin
  FDados.First;
  bImprimirRelatorioDireto := False;
  blnExportou := false;
  utimoRegistro := FDados.RecordCount;
  bExibirMensagemDeArquivoGerado := False;

  While not FDados.Eof do
  Begin
    If (FDados.FieldByName('SELECI').AsInteger = 1) Then
    Begin
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc := strEspDoc;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp := strCodEmp;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed := FDados.FieldByName('NUMPED').AsString;

      if FDados.RecNo = utimoRegistro then
        bExibirMensagemDeArquivoGerado:= True;

      objImpressaoRel.fImprimeRelatorio(strEspDoc,
                                        strCodEmp,
                                        FDados.FieldByName('NUMPED').AsString,
                                        bImprimirRelatorioDireto,
                                        bExibirMensagemDeArquivoGerado,
                                        True, Handle);
      If objImpressaoRel.blnImpressaoRel And (Not blnExportou) Then
        Break;

      If Not objImpressaoRel.blnImpressaoRel Then
        pImprimirPedido(TfraOpcPdfPedidoCompra.RecOpcaoImpressao,
                        FDados.FieldByName('NUMPED').AsString,
                        strEspDoc,
                        strCodEmp,
                        strPath,
                        strNomeFila,
                        strTipImp,
                        Not blnNovoReg,
                        strCondPagBosh,
                        True);
      FDados.Edit;
      FDados.FieldByName('SELECI').AsInteger := 0;
      FDados.Post;
      if not bImprimirRelatorioDireto then
        bImprimirRelatorioDireto := True;

    End;
    FDados.Next;
  End;
  FDados.First;
end;

procedure TfrmSelPedidoCompraImpressao.cxPedidosSELECIPropertiesChange(
  Sender: TObject);
begin
  inherited;
  cxPedidosTbl.DataController.DataSource.DataSet.Post;
end;

procedure TfrmSelPedidoCompraImpressao.cxPedidosTblCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
    Value: string;
begin
  Value := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  FDados.FieldByName('ERR_CONFIG').Index]));
  if  Value <> '' Then
      ACanvas.Font.Color  := clRed;
end;

procedure TfrmSelPedidoCompraImpressao.fInserirPedidoGerado(strCodEmp,
  strNumPed: string);
begin
  FDados.Insert;
  FDados.FieldByName('CODEMP').AsString  := strCodEmp;
  FDados.FieldByName('NUMPED').AsString  := strNumPed;
  FDados.Post;
end;

procedure TfrmSelPedidoCompraImpressao.FormCreate(Sender: TObject);
  var strSQL: string;
begin
  inherited;
  strSQL := strSQL + 'SELECT PCG_BAIXAD AS SELECI, ';
  strSQL := strSQL + '       PCG_NUMPED AS NUMPED,';
  strSQL := strSQL + '       PCG_CODEMP AS CODEMP,';
  strSQL := strSQL + '       PCG_DESMAI AS ERR_CONFIG';
  strSQL := strSQL + '       FROM PCMGER ';
  strSQL := strSQL + ' WHERE FALSE ';
  FDados := TZClient.Create(nil, strSQL);
  FDados.Open;
  dtsDados.DataSet := FDados;
  FDados.AfterScroll := pAfterScroll;
  FDados.BeforePost  := pBeforePost;
  cxPedidosTbl.DataController.DataSource := dtsDados;
end;

procedure TfrmSelPedidoCompraImpressao.FormShow(Sender: TObject);
begin
  inherited;
  FDados.First;
  While not FDados.Eof do
  Begin
    FDados.Edit;
    FDados.FieldByName('SELECI').AsInteger :=  1;
    FDados.Post;
    FDados.Next;
  End;
  FDados.First;
end;


function TfrmSelPedidoCompraImpressao.fRecordCount: integer;
begin
  Result := FDados.RecordCount;
end;

function TfrmSelPedidoCompraImpressao.fValidaConfiguracoes: boolean;
  var
    objFornecedorBosh :TFornecedorBosh;
    strErr: string;
    strConf: string;
begin
  strErr := '';
  Result := True;

  case TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao of
    2: begin
         if fEmptyStr(fCfgSis('SHORTS', varString, FDados.FieldByName('CODEMP').AsString)) Then
           strConf := '[SHORTS]';

         if fEmptyStr(fCfgSis('CDINTS', varString, FDados.FieldByName('CODEMP').AsString)) Then
           strConf := strConf + ' [CDINTS]' ;
         if not fEmptyStr(strConf) Then
           strErr := 'Será preciso configurar as seguintes configurações para continuar. ' +
                     'Empresa[' + FDados.FieldByName('CODEMP').AsString + ']: ' + strConf + '.';
       End;
   11: Begin
         objFornecedorBosh := TFornecedorBosh.Create();
         Try
           objFornecedorBosh.pCarregaFornecedor(strFornecedor);
           If fEmptyStr(objFornecedorBosh.TipoPedido) Or
              fEmptyStr(objFornecedorBosh.DivisaoVenda) Or
              fEmptyStr(objFornecedorBosh.TipoEntrega) Then
             strErr := 'O Fornecedor [' + strFornecedor + '] ' + ' não esta configurado. '+
                       'Configurações disponiveis no cadastro de fornecedor Aba - BOSCH';
         Finally
           FreeAndNil(objFornecedorBosh);
         End;
       End;
   10: Begin
         If fCfgSis('AVIDEN', varInteger,  FDados.FieldByName('CODEMP').AsString) = -1 Then
            strConf := '[AVIDEN]';
         If fCfgSis('AVINTR', varInteger,  FDados.FieldByName('CODEMP').AsString) = -1 Then
            strConf := strConf + '[AVINTR]';
         if not fEmptyStr(strConf) Then
           strErr := 'Será preciso configurar as seguintes configurações para continuar. ' +
                     'Empresa[' + FDados.FieldByName('CODEMP').AsString + ']: ' + strConf + '.';
       End;

  End;
  If Not fEmptyStr(strErr) Then
  begin
    Result := False;
    If (FDados.State in dsEditModes) Then
       FDados.FieldByName('ERR_CONFIG').AsString := strErr;
  End
end;

procedure TfrmSelPedidoCompraImpressao.gerenciaSelecionados(opcao: integer);
begin
  FDados.First;
  While not FDados.Eof do
  Begin
    FDados.Edit;
    case opcao of
       cTodos,
       cNenhum: FDados.FieldByName('SELECI').AsInteger := opcao;
       cEmpresa: FDados.FieldByName('SELECI').AsInteger := IIf(FDados.FieldByName('CODEMP').AsString = VS_StrCodEmp, 1, 0);
    end;
    FDados.Post;
    FDados.Next;
  End;
end;

procedure TfrmSelPedidoCompraImpressao.mnuDeselecionaClick(Sender: TObject);
begin
  gerenciaSelecionados(cNenhum);
end;

procedure TfrmSelPedidoCompraImpressao.mnuEmpresaLogadaClick(Sender: TObject);
begin
  gerenciaSelecionados(cEmpresa);
end;

procedure TfrmSelPedidoCompraImpressao.mnuSelecionaClick(Sender: TObject);
begin
  gerenciaSelecionados(cTodos);
end;

procedure TfrmSelPedidoCompraImpressao.pAfterScroll(DataSet: TDataSet);
begin
  pnlErr.Visible := not fEmptyStr(FDados.FieldByName('ERR_CONFIG').AsString);
  lblErr.Caption  := FDados.FieldByName('ERR_CONFIG').AsString;
end;

procedure TfrmSelPedidoCompraImpressao.pBeforePost(DataSet: TDataSet);
begin
  If FDados.FieldByName('SELECI').NewValue = 1 Then
     FDados.FieldByName('SELECI').AsString := IIf(fValidaConfiguracoes, 1 ,0);
end;

procedure TfrmSelPedidoCompraImpressao.pExportouEditorRelatorio(
  var message: TMessage);
begin
  blnExportou := True;
end;

end.
