unit AgrupamentoDeOndaDeSeparacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  MemDS, DBAccess, Uni, Datasnap.Provider, UniDataSetProvider, cxProgressBar,
  Datasnap.DBClient, UniClientDataSet, untCorGrid, System.UITypes, untTLock,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxButtonEdit, cxImage,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList,
  Expedicao.TemporariaPedidosExpedicao, untTypesSistema, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  AgrupamentoDeOndaDeSeparacao.Impressao,
  AgrupamentoDeOndaDeSeparacao.Classes,
  AgrupamentoDeOndaDeSeparacao.Classes.DefinicaoDeLotes,
  AgrupamentoDeOndaDeSeparacao.Funcoes,
  AgrupamentoDeOndaDeSeparacao.Types;

type
  TTipoOnda = (toRemessaDePedido, toRemessaDeSeparacao);

type
  TfrmAgrupamentoDeOndaDeSeparacao = class(TfrmPai)
    btnGerarRemessaDeSeparacao: TBitBtnLocked;
    btnDesagrupar: TBitBtnLocked;
    dtsOndas: TDataSource;
    cdsOndas: TUniClientDataSet;
    dspOndas: TUniDataSetProvider;
    qryOndas: TUniQuery;
    cdsOndasONDFIN: TStringField;
    cdsOndasONDGRO: TStringField;
    cdsOndasNOMOPE: TStringField;
    cdsOndasTOTQIT: TFloatField;
    cdsOndasMARDES: TStringField;
    cdsOndasONDKIT: TStringField;
    pnlLegendas: TPanel;
    lblOndaKits: TLabel;
    shpOndaKits: TShape;
    btnReimpressao: TBitBtnLocked;
    btnAlterarLocalizacao: TBitBtnLocked;
    btnAgrupar: TBitBtnLocked;
    btnPesquisarPedido: TBitBtnLocked;
    cdsOndasONDAOP: TStringField;
    cdsOndasONDAHR: TStringField;
    cdsOndasBUTTON: TStringField;
    pnlRemessaDeSeparacao_01: TPanel;
    pnlRemessaDeSeparacao_02: TPanel;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    cdsOndasSTATUS: TStringField;
    cdsOndasDESSTA: TStringField;
    lblOndaUnitario: TLabel;
    shpOndaUnitario: TShape;
    shpOndaCarrinho: TShape;
    lblOndaCarrinho: TLabel;
    cdsOndasTIPPED: TStringField;
    cxgOndasDBTableView: TcxGridDBTableView;
    cxgOndasLevel: TcxGridLevel;
    cxgOndas: TcxGrid;
    cxgOndasDBTableViewONDFIN: TcxGridDBColumn;
    cxgOndasDBTableViewONDGRO: TcxGridDBColumn;
    cxgOndasDBTableViewTIPPED: TcxGridDBColumn;
    cxgOndasDBTableViewBUTTON: TcxGridDBColumn;
    cxgOndasDBTableViewDTAOND: TcxGridDBColumn;
    cxgOndasDBTableViewNOMOPE: TcxGridDBColumn;
    cxgOndasDBTableViewTOTQIT: TcxGridDBColumn;
    cxgOndasDBTableViewDESSTA: TcxGridDBColumn;
    cxgOndasDBTableViewONDADT: TcxGridDBColumn;
    cxgOndasDBTableViewONDAHR: TcxGridDBColumn;
    cxgOndasDBTableViewONDAOP: TcxGridDBColumn;
    cxgOndasDBTableViewMARDES: TcxGridDBColumn;
    cxiImagens: TcxImageList;
    lblRemessaPedido: TLabel;
    cdsOndasDTAOND: TDateField;
    cdsOndasONDADT: TDateField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarRemessaDeSeparacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesagruparClick(Sender: TObject);
    procedure btnReimpressaoClick(Sender: TObject);
    procedure btnAgruparClick(Sender: TObject);
    procedure btnAlterarLocalizacaoClick(Sender: TObject);
    procedure btnPesquisarPedidoClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure cdsOndasCalcFields(DataSet: TDataSet);
    procedure cxgOndasDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgOndasDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgOndasDBTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxgOndasDBTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormDestroy(Sender: TObject);

  private

    TipoOnda : TTipoOnda;

    FUltimaTemporariaPedidosAbertoExpedicao : String;
    FModoSomenteImpressaoRemessasDePedidos : Boolean;
    FRemessaDeSeparacao : String;

    FCorDocSel      : TColor;
    FCorDocPosFonte : TColor;
    FCorDocPosFundo : TColor;
    FCorDocSelPos   : TColor;
    FTemporariaPedidosExpedicao : TTemporariaPedidosExpedicao;

    procedure AtualizarRegistroOperadorItem(const ADadosRemessa: TUniQuery; const AAtualizar: Boolean);
    function GetQryDadosDaRemessa: TUniQuery;
    function RetornaTemporariaPedidosPendentes: String;
    procedure SetarFromFatgor(var AResult: String; const ATmpPedidosPendentes: String);
    procedure CarregarCores;

    procedure AtualizarRemessas;
    procedure AtualizarGrid;

    procedure Marcar;
    procedure Desmarcar;
    procedure Selecionar;

    function PodeSelecionar : Boolean;
    function TemSelecionado : Boolean;

    function RealizarDesagrupamento : Boolean;
    procedure UpdateDesagrupar(ARemessaDeSeparacao : String);

    function RetSQLRemessaDePedido(const ATmpPedidosPendentes: String): String;
    function RetSQLRemessaDeSeparacao(const ATmpPedidosPendentes: String) : String;
    function RetSQLImpressaoRemessaDePedido(ARemessaDePedido, ASeparador : String) : String;

    function fEhRemessaDeSeparacao : Boolean;
    function fEhRemessaDePedido    : Boolean;

    procedure AtualizaDadosRemessaDeSeparacao(const AAtualizarOperadorItem: Boolean);

    function TemRemessaSelecionadaComStatusIniciadaOuFinalizada : Boolean;
    function TemRemessaComOutroTipoDePedidoSelecionado(strTipoPedido: String): Boolean;

    function  ClonaSelecionados : TUniClientDataSet;
    procedure SelecionaClonados(AClonados : TUniClientDataSet);

  public
    procedure pSetTipoOnda(ATipoOnda : TTipoOnda);
    procedure pSetModoSomenteImpressaoRemessasDePedidos;
    procedure pSetRemessaDeSeparacao(ARemessaDeSeparacao : String);
  end;

var
  FLock : TLock;

implementation

uses
  untGravando, untFuncoesSimples, untQckSintetizaItensSep,
  untMovimentacaoProgramada, untFatDefineLotesPedidoWMS, untFatExpedicao,
  untMensagemExplicativa_ComConsultaProdutos,
  untLibExt, untSaldoLojas, untFatGor, untDefineLotesWMS, untConstantes;

{$R *.dfm}

{ TfrmAgrupamentoDeOndaDeSeparacao }

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnGerarRemessaDeSeparacaoClick(Sender: TObject);
  var
    frmAgrupamentoDeOndaDeSeparacao: TfrmAgrupamentoDeOndaDeSeparacao;
begin

  If Not btnGerarRemessaDeSeparacao.Visible Then
    Exit;

  pCriarFormularios(TfrmAgrupamentoDeOndaDeSeparacao, frmAgrupamentoDeOndaDeSeparacao);

  Try
    frmAgrupamentoDeOndaDeSeparacao.pSetTipoOnda(toRemessaDePedido);
    frmAgrupamentoDeOndaDeSeparacao.ShowModal;
    AtualizarRemessas;
  Finally
    pFreeAndNil(frmAgrupamentoDeOndaDeSeparacao);
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnImprimirClick(Sender: TObject);
  var
    LDestino    : String;
    LSeparador  : String;
    LRemessaDePedido        : String;
    frmQckSintetizaItensSep : TfrmQckSintetizaItensSep;
begin

  If Not TemSelecionado Then
  Begin
    fMensagem('Atenção', 'É preciso selecionar as (Remessas de Pedidos) para realizar a impressão!', ['&Ok']);
    Exit;
  End;

  If fMensagem('','Saída',['&Vídeo','&Imprimir']) = 1 Then
    LDestino := 'V'
  Else
    LDestino := 'I';

  LSeparador := strLoginUsuarioLogado;
  pCriarFormularios(TfrmQckSintetizaItensSep, frmQckSintetizaItensSep);

  cdsOndas.DisableControls;

  Try

    cdsOndas.First;
    While Not cdsOndas.Eof Do
    Begin

      If (cdsOndasMARDES.AsString = SELECIONADO) Then
      Begin
        LRemessaDePedido := cdsOndas.FieldByName('ONDFIN').AsString;
        frmQckSintetizaItensSep.pImprimir(RetSQLImpressaoRemessaDePedido(LRemessaDePedido, LSeparador), Self.Name, LDestino, LSeparador, LRemessaDePedido, False, True);
      End;

      cdsOndas.Next;

    End;

  Finally

    If Assigned(frmQckSintetizaItensSep) Then
      pFreeAndNil(frmQckSintetizaItensSep);

    cdsOndas.EnableControls;

  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnMarcarTodosClick(Sender: TObject);
begin

  inherited;

  cdsOndas.DisableControls;

  Try

    cdsOndas.First;
    While Not cdsOndas.Eof Do
    Begin
      Marcar;
      cdsOndas.Next;
    End;

  Finally
    cdsOndas.EnableControls;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnPesquisarPedidoClick(Sender: TObject);
  var
    frmFatExpedicao : TfrmFatExpedicao;
begin

  inherited;

  pCriarFormularios(TfrmFatExpedicao, frmFatExpedicao);

  Try
    frmFatExpedicao.pSetApenasGeracaoDeRemessaDePedido;
    frmFatExpedicao.ShowModal;
  Finally
    pFreeAndNil(frmFatExpedicao);
    AtualizarRemessas;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnDesagruparClick(Sender: TObject);
begin

  If Not btnDesagrupar.Visible Then
    Exit;

  If Not fEhRemessaDeSeparacao Then
    Exit;

  If Not TemSelecionado Then
  Begin
    fMensagem('Atenção', 'É preciso selecionar as (Remessas de Separação) para realizar o desagrupamento!', ['&Ok']);
    Exit;
  End;

  If TemRemessaSelecionadaComStatusIniciadaOuFinalizada Then
  Begin
    fMensagem('Atenção', 'Não é possível cancelar uma remessa de separação com status (Separando), (Finalizado) ou (Parcialmente Finalizado)!', ['&Ok']);
    Exit;
  End;

  If Not fPergunta('Deseja realmente cancelar a(s) remessa(s) de separação selecionada(s)?') Then
    Exit;

  If RealizarDesagrupamento Then
  Begin
    fMensagem('', 'Desagrupamento realizado com sucesso!', ['&OK']);
    AtualizarRemessas;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnDesmarcarTodosClick(Sender: TObject);
begin

  inherited;

  cdsOndas.DisableControls;

  Try

    cdsOndas.First;
    While Not cdsOndas.Eof Do
    Begin
      Desmarcar;
      cdsOndas.Next;
    End;

  Finally
    cdsOndas.EnableControls;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnAgruparClick(Sender: TObject);
  var
    LRemessaDeSeparacao : TRemessaDeSeparacao;
    LGeracao : TGeracao;
    LClone   : TUniClientDataSet;
begin
  inherited;

  If Not btnAgrupar.Visible Then
    Exit;

  If Not TemSelecionado Then
  Begin
    fMensagem('Atenção', 'É preciso selecionar as (Remessas de Pedidos) para realizar o agrupamento!', ['&Ok']);
    Exit;
  End;

  LClone   := ClonaSelecionados;
  LGeracao := geTenteNovamente;

  While (LGeracao = geTenteNovamente) Do
  Begin

    LRemessaDeSeparacao := TRemessaDeSeparacao.New(Self.Name);

    Try

      LRemessaDeSeparacao.setOndas(cdsOndas);
      LGeracao := LRemessaDeSeparacao.Gerar;

      Case LGeracao Of

        geGerouComSucesso: Begin

                             If Not fEmptyStr(LRemessaDeSeparacao.RemessaDeSeparacaoGerada) Then
                             Begin

                               fMensagem('', 'Agrupamento realizado com sucesso! Remessa de Separação Nº: ' + LRemessaDeSeparacao.RemessaDeSeparacaoGerada, ['&OK']);

                               If fPergunta('Deseja realizar a impressão da Remessa de Separação?') Then
                                 fExecutarModal(LRemessaDeSeparacao.RealizarImpressao, 'Aguarde, imprimindo remessa de separação', '');

                             End;

                             AtualizarRemessas;

                           End;

        geTenteNovamente : Begin

                             AtualizarRemessas;
                             SelecionaClonados(LClone);

                             If TemSelecionado Then
                               Continue;

                           End;

      End;

      Break;

    Finally
      FreeAndNil(LRemessaDeSeparacao);
    End;

  End;

  If Assigned(LClone) Then
    FreeAndNil(LClone);

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnAlterarLocalizacaoClick(Sender: TObject);
  var
    LItensRemessa : TItensRemessa;
begin
  inherited;

  If Not btnAlterarLocalizacao.Visible Then
    Exit;

  If Not fEhRemessaDeSeparacao Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  AtualizaDadosRemessaDeSeparacao(False);

  If Not cdsOndasSTATUS.AsString.Equals('A') Then
  Begin
    fMensagem('Atenção', 'Não é possível "Alterar Loc. De Separação" de uma remessa de separação com status (Separando), (Finalizado) ou (Parcialemente Finalizado)!', ['&Ok']);
    Exit;
  End;

  if fPossuiQuantidadeSeparada(cdsOndasONDGRO.AsString) then
  begin
    fMensagem('Atenção', 'Não é possível "Alterar Loc. De Separação" de uma remessa de separação que já tenha quantidade separada!', ['&Ok']);
    Exit;
  end;

  If TRemessaDeSeparacao.DefinicaoDeLotes(cdsOndasONDGRO.AsString, True, LItensRemessa) Then
    fMensagem('', 'Alteração realizada com sucesso!', ['&OK']);

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.btnReimpressaoClick(Sender: TObject);
  var
    frmAgrupamentoDeOndaDeSeparacaoImpressao: TfrmAgrupamentoDeOndaDeSeparacaoImpressao;
begin

  inherited;

  If Not btnReimpressao.Visible Then
    Exit;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  frmAgrupamentoDeOndaDeSeparacaoImpressao := TfrmAgrupamentoDeOndaDeSeparacaoImpressao.Create(Self);

  Try
    frmAgrupamentoDeOndaDeSeparacaoImpressao.SetRemessaDeSeparacao(cdsOndasONDGRO.AsString);
    frmAgrupamentoDeOndaDeSeparacaoImpressao.ShowModal;
  Finally
    pFreeAndNil(frmAgrupamentoDeOndaDeSeparacaoImpressao);
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  FLock := TLock.Create;

  CarregarCores();
  cxgOndasDBTableView.OnKeyDown := pOnKeyDown;
  FModoSomenteImpressaoRemessasDePedidos := False;
  FRemessaDeSeparacao := '';
  FTemporariaPedidosExpedicao := TTemporariaPedidosExpedicao.Create;
  FUltimaTemporariaPedidosAbertoExpedicao := EmptyStr;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.FormDestroy(Sender: TObject);
begin
  FTemporariaPedidosExpedicao.pApagarTemporaria(FUltimaTemporariaPedidosAbertoExpedicao);
  FreeAndNil(FTemporariaPedidosExpedicao);

  FreeAndNil(FLock);
  inherited;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) And (fEhRemessaDePedido) Then
    btnAgruparClick(Sender)
  Else If (Key = VK_F10) And (fEhRemessaDeSeparacao) Then
    btnGerarRemessaDeSeparacaoClick(Sender)
  Else If (key = VK_F6) Then
    btnDesagruparClick(Sender)
  Else If (key = VK_F7) Then
    btnReimpressaoClick(Sender)
  Else If (key = VK_F8) Then
    btnAlterarLocalizacaoClick(Sender)
  Else If (key = VK_F9) Then
    btnPesquisarPedidoClick(Sender);

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.FormShow(Sender: TObject);
  const
    REMESSAO_PEDIDO   = 'Geração de Remessa de Separação';
    REMESSA_SEPARACAO = 'Painel de Remessa de Separação';
begin
  inherited;

   btnAgrupar.Visible                 := False;
   btnPesquisarPedido.Visible         := False;
   btnDesagrupar.Visible              := False;
   btnReimpressao.Visible             := False;
   btnGerarRemessaDeSeparacao.Visible := False;
   btnAlterarLocalizacao.Visible      := False;

  If FModoSomenteImpressaoRemessasDePedidos Then
  Begin
    pnlRemessaDeSeparacao_01.Visible := True;
    pnlRemessaDeSeparacao_02.Visible := True;
    Self.pnlRemessaDeSeparacao_01.Caption := 'Remessa de Separação - ' + FRemessaDeSeparacao;
  End
  Else
  Begin
    btnAgrupar.Visible                 := fEhRemessaDePedido;
    btnPesquisarPedido.Visible         := fEhRemessaDePedido;
    btnDesagrupar.Visible              := fEhRemessaDeSeparacao;
    btnReimpressao.Visible             := fEhRemessaDeSeparacao;
    btnGerarRemessaDeSeparacao.Visible := fEhRemessaDeSeparacao;
    btnAlterarLocalizacao.Visible      := fEhRemessaDeSeparacao;
    Self.Caption := IIF(fEhRemessaDePedido, REMESSAO_PEDIDO, REMESSA_SEPARACAO);
  End;

  cxgOndasDBTableViewONDGRO.Visible := fEhRemessaDeSeparacao;
  cxgOndasDBTableViewBUTTON.Visible := fEhRemessaDeSeparacao;
  cxgOndasDBTableViewDTAOND.Visible := fEhRemessaDeSeparacao;
  cxgOndasDBTableViewDESSTA.Visible := fEhRemessaDeSeparacao;

  cxgOndasDBTableViewONDFIN.Visible := fEhRemessaDePedido;
  cxgOndasDBTableViewONDADT.Visible := fEhRemessaDePedido;
  cxgOndasDBTableViewONDAHR.Visible := fEhRemessaDePedido;
  cxgOndasDBTableViewONDAOP.Visible := fEhRemessaDePedido;
  cxgOndasDBTableViewTIPPED.Visible := True;

  AtualizarRemessas;
  pSetFocus(cxgOndas);

end;

function TfrmAgrupamentoDeOndaDeSeparacao.PodeSelecionar: Boolean;
  const
    MSG = 'Não pode ser gerado agrupamento entre tipos de pedidos diferentes:' + #13 +
          ' - Remessa de Separação exclusivamente de pedidos de kits;' + #13 +
          ' - Remessa de Separação exclusivamente de pedidos unitários;'+
          ' - Remessa de Separação exclusivamente de pedidos de carrinho;';
begin
  Result := True;

  If TemRemessaComOutroTipoDePedidoSelecionado(cdsOndasTIPPED.AsString) Then
  Begin
    fMensagem('Atenção', MSG, ['&Ok']);
    Exit(False);
  End;
end;

function TfrmAgrupamentoDeOndaDeSeparacao.TemRemessaComOutroTipoDePedidoSelecionado(strTipoPedido: String): Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  Result := False;

  If (Not cdsOndas.Active) Or (cdsOndas.IsEmpty) Then
    Exit;

  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, cdsOndas);

    cdsClone.Filtered := False;
    cdsClone.Filter   := 'TIPPED <> ' + QuotedStr(strTipoPedido) + ' AND MARDES = ' + QuotedStr(SELECIONADO);
    cdsClone.Filtered := True;

    Result := Not cdsClone.IsEmpty;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.SetarFromFatgor(var AResult: String; const ATmpPedidosPendentes: String);
begin
  If (Not fEmptyStr(ATmpPedidosPendentes)) Then
  Begin
    AResult := AResult + ' FROM ' + ATmpPedidosPendentes + ' AS TPDEXP ';
    AResult := AResult + ' JOIN FATGOR F ON F.AUTOINCREM = TPDEXP.TMP_AUTINC ';
  End
  Else
    AResult := AResult + ' FROM FATGOR F ';
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.pSetModoSomenteImpressaoRemessasDePedidos;
begin
  FModoSomenteImpressaoRemessasDePedidos := True;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.pSetRemessaDeSeparacao(ARemessaDeSeparacao: String);
begin
  FRemessaDeSeparacao := ARemessaDeSeparacao;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.pSetTipoOnda(ATipoOnda: TTipoOnda);
begin
  TipoOnda := ATipoOnda;
end;

function TfrmAgrupamentoDeOndaDeSeparacao.RealizarDesagrupamento: Boolean;
  var
    LClone : TUniClientDataSet;
begin

  Result := False;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  LClone := TUniClientDataSet.Create(Nil);

  Try

    fStartTransaction();

    Try

      pCloneDataSet(LClone, cdsOndas);

      LClone.First;
      While Not LClone.Eof Do
      Begin

        If (LClone.FieldByName('MARDES').AsString = SELECIONADO) Then
          UpdateDesagrupar(LClone.FieldByName('ONDGRO').AsString);

        LClone.Next;
      End;

    Finally
      FreeAndNil(LClone);
    End;

    Result := fCommit();

  Except

    On E: Exception Do
    Begin
      fRollBack();
      fMensagem('Erro', 'Erro ao realizar o desagrupamento: ' + E.Message, ['&OK']);
    End;

  End;

end;

function TfrmAgrupamentoDeOndaDeSeparacao.RetornaTemporariaPedidosPendentes: String;
begin
  Result := EmptyStr;

  If (fCfgSis('UTTEXP', varString) = 'N') Then
    Exit;

  If (FModoSomenteImpressaoRemessasDePedidos) Then
    Exit;

  FTemporariaPedidosExpedicao.pApagarTemporaria(FUltimaTemporariaPedidosAbertoExpedicao);
  Result := FTemporariaPedidosExpedicao.fGerarNovaTemporaria;
  FUltimaTemporariaPedidosAbertoExpedicao := Result;
end;

function TfrmAgrupamentoDeOndaDeSeparacao.RetSQLImpressaoRemessaDePedido(ARemessaDePedido, ASeparador: String): String;
begin
  Result := AgrupamentoDeOndaDeSeparacao.Funcoes.RetSQLImpressaoRemessaDePedido(ARemessaDePedido, ASeparador);
end;

function TfrmAgrupamentoDeOndaDeSeparacao.RetSQLRemessaDePedido(const ATmpPedidosPendentes: String) : String;
begin

  Result := '';
  Result := Result + 'SELECT    ';
  Result := Result + '  FGO_SEQSEP AS ONDFIN, ';
  Result := Result + '  FGO_SEQOND AS ONDGRO, ';
  Result := Result + '  IF(IFNULL(FGO_ONDKIT, "N") = "S", "K", "") AS ONDKIT, ';
  Result := Result + '  TIPPED, ';
  Result := Result + '  FGO_CODVEN AS CODVEN, ';
  Result := Result + '      MARDES AS MARDES, ';
  Result := Result + '        0.00 AS TOTQIT, ';
  Result := Result + '  CAST(" " AS CHAR(100)) AS NOMOPE, ';

  Result := Result + '  ONDAOP, ONDADT, ONDAHR, DTAOND, ';
  Result := Result + '  CAST(" " AS CHAR(1)) AS BUTTON, ';
  Result := Result + '  CAST("A" AS CHAR(1)) AS STATUS  ';

  Result := Result + 'FROM (    ';

  Result := Result + '  SELECT           ';
  Result := Result + '    "N" AS FATAUT, ';
  Result := Result + '    E.FGO_SEQSEP,  ';
  Result := Result + '    E.FGO_SEQOND,  ';
  Result := Result + '    E.FGO_ONDKIT,  ';
  Result := Result + '    CASE ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDUNI, "N") = "S" THEN "U" ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDKIT, "N") = "S" THEN "K" ';
  Result := Result + '      ELSE "C" ';
  Result := Result + '    END AS TIPPED, ';
  Result := Result + '    F.FGO_CODVEN,  ';
  Result := Result + '    O.OPE_NOMOPE,  ';
  Result := Result + '    "D" AS MARDES, ';
  Result := Result + '    CONCAT(E.FGO_ONDAOP, "-", O1.OPE_NOMOPE) AS ONDAOP, ';
  Result := Result + '    E.FGO_ONDADT AS ONDADT, ';
  Result := Result + '    CAST(E.FGO_ONDAHR AS CHAR(8))  AS ONDAHR, ';
  Result := Result + '    E.FGO_DTAOND AS DTAOND ';

  SetarFromFatgor(Result, ATmpPedidosPendentes);

  Result := Result + '    INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM) ';
  Result := Result + '    LEFT  JOIN CADOPE O ON (O.OPE_CODOPE = F.FGO_CODVEN) ';
  Result := Result + '    LEFT  JOIN CADOPE O1 ON (O1.OPE_CODOPE = E.FGO_ONDAOP) ';
  Result := Result + '  WHERE                                                  ';

  If FModoSomenteImpressaoRemessasDePedidos Then
    Result := Result + '    E.FGO_SEQOND = ' + FRemessaDeSeparacao.QuotedString
  Else
  Begin
    Result := Result + '    ((E.FGO_SEQSEP IS NOT NULL) AND (E.FGO_SEQSEP <> "")) AND (E.FGO_SEQOND IS NULL) AND ';
    Result := Result + '    (F.FGO_ESPDOC = "PD") AND (F.FGO_JAFATU = 0) AND (E.FGO_EMPEXP = :CODEMP) ';
  End;

  Result := Result + '  UNION ALL ';

  Result := Result + '  SELECT           ';
  Result := Result + '    "S" AS FATAUT, ';
  Result := Result + '    E.FGO_SEQSEP,  ';
  Result := Result + '    E.FGO_SEQOND,  ';
  Result := Result + '    E.FGO_ONDKIT,  ';
  Result := Result + '    CASE ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDUNI, "N") = "S" THEN "U" ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDKIT, "N") = "S" THEN "K" ';
  Result := Result + '      ELSE "C" ';
  Result := Result + '    END AS TIPPED, ';
  Result := Result + '    F.FGO_CODVEN,  ';
  Result := Result + '    O.OPE_NOMOPE,  ';
  Result := Result + '    "D" AS MARDES, ';
  Result := Result + '    CONCAT(E.FGO_ONDAOP, "-", O1.OPE_NOMOPE) AS ONDAOP, ';
  Result := Result + '    E.FGO_ONDADT AS ONDADT, ';
  Result := Result + '    CAST(E.FGO_ONDAHR AS CHAR(8))  AS ONDAHR, ';
  Result := Result + '    E.FGO_DTAOND AS DTAOND ';

  SetarFromFatgor(Result, ATmpPedidosPendentes);

  Result := Result + '    INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM)    ';
  Result := Result + '    INNER JOIN FATAUT A ON (F.FGO_NUMDOC = A.FAT_NUMDOC AND ';
  Result := Result + '                            F.FGO_ESPDOC = A.FAT_ESPDOC AND ';
  Result := Result + '                            F.FGO_CODEMP = A.FAT_EMPDOC)    ';
  Result := Result + '    LEFT  JOIN CADOPE O ON (O.OPE_CODOPE = F.FGO_CODVEN)    ';
  Result := Result + '    LEFT  JOIN CADOPE O1 ON (O1.OPE_CODOPE = E.FGO_ONDAOP)  ';
  Result := Result + '  WHERE ';

  If FModoSomenteImpressaoRemessasDePedidos Then
    Result := Result + '   E.FGO_SEQOND = ' + FRemessaDeSeparacao.QuotedString + ') AS TAB GROUP BY FGO_SEQSEP '
  Else
  Begin
    Result := Result + '    ((E.FGO_SEQSEP IS NOT NULL) AND (E.FGO_SEQSEP <> "")) AND (E.FGO_SEQOND IS NULL) AND ';
    Result := Result + '     E.FGO_EMPEXP = :CODEMP   AND                             ';
    Result := Result + '     A.FAT_ESPDOC = "PD"      AND                             ';
    Result := Result + '     A.FAT_NUMFAT IS NOT NULL AND                             ';
    Result := Result + '     A.FAT_DTLBEX IS NULL) AS TAB GROUP BY FGO_SEQSEP ';
  End;

end;

function TfrmAgrupamentoDeOndaDeSeparacao.RetSQLRemessaDeSeparacao(const ATmpPedidosPendentes: String) : String;
begin

  Result := '';
  Result := Result + 'SELECT    ';
  Result := Result + '  FGO_SEQSEP AS ONDFIN, ';
  Result := Result + '  FGO_SEQOND AS ONDGRO, ';
  Result := Result + '  IF(IFNULL(FGO_ONDKIT, "N") = "S", "K", "") AS ONDKIT, ';
  Result := Result + '  TIPPED, ';
  Result := Result + '  FGO_CODVEN AS CODVEN, ';
  Result := Result + '      MARDES AS MARDES, ';
  Result := Result + '        0.00 AS TOTQIT, ';
  Result := Result + '  CAST(" " AS CHAR(100)) AS NOMOPE, ';

  Result := Result + '  ONDAOP, ONDADT, ONDAHR, DTAOND, ';
  Result := Result + '  CAST(" " AS CHAR(1)) AS BUTTON, ';

  Result := Result + '  CAST(" " AS CHAR(1)) AS STATUS ';

  Result := Result + 'FROM (    ';

  Result := Result + '  SELECT           ';
  Result := Result + '    "N" AS FATAUT, ';
  Result := Result + '    E.FGO_SEQSEP,  ';
  Result := Result + '    E.FGO_SEQOND,  ';
  Result := Result + '    E.FGO_ONDKIT,  ';
  Result := Result + '    CASE ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDUNI, "N") = "S" THEN "U" ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDKIT, "N") = "S" THEN "K" ';
  Result := Result + '      ELSE "C" ';
  Result := Result + '    END AS TIPPED, ';
  Result := Result + '    F.FGO_CODVEN,  ';
  Result := Result + '    "D" AS MARDES, ';
  Result := Result + '    CONCAT(E.FGO_ONDAOP, "-", O1.OPE_NOMOPE) AS ONDAOP, ';
  Result := Result + '    E.FGO_ONDADT AS ONDADT, ';
  Result := Result + '    CAST(E.FGO_ONDAHR AS CHAR(8))  AS ONDAHR, ';
  Result := Result + '    E.FGO_DTAOND AS DTAOND ';

  SetarFromFatgor(Result, ATmpPedidosPendentes);

  Result := Result + '    INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM) ';
  Result := Result + '    LEFT  JOIN CADOPE O1 ON (O1.OPE_CODOPE = E.FGO_ONDAOP) ';
  Result := Result + '  WHERE                                                  ';
  Result := Result + '    ((E.FGO_SEQOND IS NOT NULL) AND (E.FGO_SEQOND <> "")) AND ';
  Result := Result + '    (F.FGO_ESPDOC = "PD") AND (F.FGO_JAFATU = 0) AND (E.FGO_EMPEXP = :CODEMP) ';

  Result := Result + '  UNION ALL ';

  Result := Result + '  SELECT           ';
  Result := Result + '    "S" AS FATAUT, ';
  Result := Result + '    E.FGO_SEQSEP,  ';
  Result := Result + '    E.FGO_SEQOND,  ';
  Result := Result + '    E.FGO_ONDKIT,  ';
  Result := Result + '    CASE ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDUNI, "N") = "S" THEN "U" ';
  Result := Result + '      WHEN IFNULL(E.FGO_ONDKIT, "N") = "S" THEN "K" ';
  Result := Result + '      ELSE "C" ';
  Result := Result + '    END AS TIPPED, ';
  Result := Result + '    F.FGO_CODVEN,  ';
  Result := Result + '    "D" AS MARDES, ';
  Result := Result + '    CONCAT(E.FGO_ONDAOP, "-", O1.OPE_NOMOPE) AS ONDAOP, ';
  Result := Result + '    E.FGO_ONDADT AS ONDADT, ';
  Result := Result + '    CAST(E.FGO_ONDAHR AS CHAR(8))  AS ONDAHR, ';
  Result := Result + '    E.FGO_DTAOND AS DTAOND ';

  SetarFromFatgor(Result, ATmpPedidosPendentes);

  Result := Result + '    INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM)    ';
  Result := Result + '    INNER JOIN FATAUT A ON (F.FGO_NUMDOC = A.FAT_NUMDOC AND ';
  Result := Result + '                            F.FGO_ESPDOC = A.FAT_ESPDOC AND ';
  Result := Result + '                            F.FGO_CODEMP = A.FAT_EMPDOC)    ';
  Result := Result + '    LEFT  JOIN CADOPE O1 ON (O1.OPE_CODOPE = E.FGO_ONDAOP)  ';
  Result := Result + '  WHERE ';
  Result := Result + '    ((E.FGO_SEQOND IS NOT NULL) AND (E.FGO_SEQOND <> "")) AND ';
  Result := Result + '     E.FGO_EMPEXP = :CODEMP   AND                             ';
  Result := Result + '     A.FAT_ESPDOC = "PD"      AND                             ';
  Result := Result + '     A.FAT_NUMFAT IS NOT NULL AND                             ';
  Result := Result + '     A.FAT_DTLBEX IS NULL) AS TAB GROUP BY FGO_SEQOND ';

end;

function TfrmAgrupamentoDeOndaDeSeparacao.TemRemessaSelecionadaComStatusIniciadaOuFinalizada: Boolean;
  var
    LClone : TUniClientDataSet;
begin

  Result := False;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  LClone := TUniClientDataSet.Create(Nil);

  Try

    AtualizaDadosRemessaDeSeparacao(False);
    pCloneDataSet(LClone, cdsOndas);

    LClone.First;
    While Not LClone.Eof Do
    Begin

      If (LClone.FieldByName('MARDES').AsString = SELECIONADO) Then
        If Not LClone.FieldByName('STATUS').AsString.Equals('A') Then
          Exit(True);

      LClone.Next;
    End;

  Finally
    FreeAndNil(LClone);
  End;

end;

function TfrmAgrupamentoDeOndaDeSeparacao.TemSelecionado: Boolean;
  var
    LClone: TUniClientDataSet;
begin

  Result := False;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  LClone := TUniClientDataSet.Create(Nil);

  Try

    pCloneDataSet(LClone, cdsOndas);

    LClone.Filtered := False;
    LClone.Filter   := 'MARDES = ' + QuotedStr(SELECIONADO);
    LClone.Filtered := True;

    Result := (LClone.RecordCount > 0);

  Finally
    FreeAndNil(LClone);
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.AtualizarGrid;
  Var
    LSQL : String;
    LTmpPedidosPendentes : String;
begin
  LTmpPedidosPendentes := RetornaTemporariaPedidosPendentes;

  If (fEhRemessaDePedido) Then
    LSQL := RetSQLRemessaDePedido(LTmpPedidosPendentes)
  Else
    LSQL := RetSQLRemessaDeSeparacao(LTmpPedidosPendentes);

  qryOndas.Close;
  qryOndas.SQL.Clear;
  qryOndas.SQL.Add(LSQL);

  If qryOndas.FindParam('CODEMP') <> Nil Then
    qryOndas.ParamByName('CODEMP').AsString := VS_strCodEmp;

  cdsOndas.Close;
  cdsOndas.SetProvider(dspOndas);

  qryOndas.Open;
  pSetaClient(qryOndas);
  cdsOndas.Open;
  AtualizaDadosRemessaDeSeparacao(True);
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.AtualizarRemessas;
begin
  TFrmGravando.fExecutarModal(AtualizarGrid, 'Aguarde... Atualizando ondas!', '');
end;

function TfrmAgrupamentoDeOndaDeSeparacao.GetQryDadosDaRemessa: TUniQuery;
begin
  Result := fCriaQuery;
  Result.SQL.Clear;
  Result.SQL.Add(' SELECT CAST(GROUP_CONCAT(DISTINCT O.OPE_NOMOPE SEPARATOR ", ") AS CHAR(100)) AS OPERADOR, ');
  Result.SQL.Add('        SUM(D.FDO_QTDITE) AS TOTAL_QTDITE ');
  Result.SQL.Add('   FROM FATGOR F ');
  Result.SQL.Add('  INNER JOIN FATDOR D ON D.FDO_SEQGER = F.AUTOINCREM ');
  Result.SQL.Add('  INNER JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ');
  Result.SQL.Add('  INNER JOIN CADOPE O ON O.OPE_CODOPE = F.FGO_CODVEN ');

  If (fEhRemessaDePedido) Then
    Result.SQL.Add('  WHERE E.FGO_SEQSEP = :SEQUEN ')
  Else
    Result.SQL.Add('  WHERE E.FGO_SEQOND = :SEQUEN ');
End;

procedure TfrmAgrupamentoDeOndaDeSeparacao.AtualizarRegistroOperadorItem(const ADadosRemessa: TUniQuery; const AAtualizar: Boolean);
begin
  If (Not AAtualizar) Then
    Exit;
  ADadosRemessa.Close;
  If (fEhRemessaDePedido) Then
    ADadosRemessa.ParamByName('SEQUEN').AsString := String(cdsOndasONDFIN.Value)
  Else
    ADadosRemessa.ParamByName('SEQUEN').AsString := String(cdsOndasONDGRO.Value);
  ADadosRemessa.Open;
  cdsOndasNOMOPE.Value := AnsiString(ADadosRemessa.FieldByName('OPERADOR').AsString);
  cdsOndasTOTQIT.Value := ADadosRemessa.FieldByName('TOTAL_QTDITE').AsFloat;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.AtualizaDadosRemessaDeSeparacao(const AAtualizarOperadorItem: Boolean);
  Var
    LQryDadosRemessa : TUniQuery;
    LPosicao : TBookmark;
begin
  LQryDadosRemessa := GetQryDadosDaRemessa;
  Try
    LPosicao := cdsOndas.GetBookmark;
    cdsOndas.DisableControls;
    Try
      cdsOndas.First;
      While Not cdsOndas.Eof Do
      Begin
        cdsOndas.Edit;
        cdsOndasSTATUS.Value := AnsiString(fRetornaStatusRemessaDeSeparacao(cdsOndasONDGRO.AsString));
        AtualizarRegistroOperadorItem(LQryDadosRemessa, AAtualizarOperadorItem);
        cdsOndas.Post;
        cdsOndas.Next;
      End;
    Finally
      cdsOndas.EnableControls;
      If cdsOndas.BookmarkValid(LPosicao) Then
        cdsOndas.GotoBookmark(LPosicao);
    End;
  Finally
    FreeAndNil(LQryDadosRemessa);
  End;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.CarregarCores;
  var
    LCorGrid: TCorGrid;
begin

  Try

    LCorGrid := TCorGrid.Create('frmFatExpedicao', 'dbgPedidos');

    //FONTE - Documento posicionado fonte
    FCorDocPosFonte := LCorGrid.CarregarCor('DocPosFonte');

    //FONTE - Documento posicionado e selecionado
    FCorDocSelPos := LCorGrid.CarregarCor('DocSelPos');

    //FUNDO - Documento selecionado
    FCorDocSel := LCorGrid.CarregarCor('DocSel');

    //FUNDO - Documento posicionado fundo
    FCorDocPosFundo := LCorGrid.CarregarCor('DocPosFundo');

  Finally
    FreeAndNil(LCorGrid);
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.cdsOndasCalcFields(DataSet: TDataSet);
begin
  inherited;

  If Not DataSet.Active Then
    Exit;

  If DataSet.FieldByName('STATUS').AsString.Equals('A') Then
    DataSet.FieldByName('DESSTA').AsString := 'Aguardando Separação';

  If DataSet.FieldByName('STATUS').AsString.Equals('S') Then
    DataSet.FieldByName('DESSTA').AsString := 'Separando';

  If DataSet.FieldByName('STATUS').AsString.Equals('F') Then
    DataSet.FieldByName('DESSTA').AsString := 'Finalizado';

  If DataSet.FieldByName('STATUS').AsString.Equals('P') Then
    DataSet.FieldByName('DESSTA').AsString := 'Parcialmente Finalizado';
end;

function TfrmAgrupamentoDeOndaDeSeparacao.ClonaSelecionados: TUniClientDataSet;
begin

  Result := TUniClientDataSet.Create(Nil);

  pCloneDataSet(Result, cdsOndas);

  Result.Filtered := False;
  Result.Filter   := 'MARDES = ' + QuotedStr(SELECIONADO);
  Result.Filtered := True;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.cxgOndasDBTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    frmAgrupamentoDeOndaDeSeparacao: TfrmAgrupamentoDeOndaDeSeparacao;
begin
  inherited;

  If Not (TcxGridDBColumn(ACellViewInfo.Item).DataBinding.FieldName = 'BUTTON') Then
    Exit;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmAgrupamentoDeOndaDeSeparacao, frmAgrupamentoDeOndaDeSeparacao);
  Try
    frmAgrupamentoDeOndaDeSeparacao.pSetTipoOnda(toRemessaDePedido);
    frmAgrupamentoDeOndaDeSeparacao.pSetModoSomenteImpressaoRemessasDePedidos;
    frmAgrupamentoDeOndaDeSeparacao.pSetRemessaDeSeparacao(cdsOndasONDGRO.AsString);
    frmAgrupamentoDeOndaDeSeparacao.ShowModal;
  Finally
    pFreeAndNil(frmAgrupamentoDeOndaDeSeparacao);
  End;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.cxgOndasDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  Selecionar;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.cxgOndasDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgOndasDBTableViewMARDES.Index]) = SELECIONADO) Then
  Begin
    ACanvas.Brush.Color := FCorDocSel;
    ACanvas.Font.Color := clBlack;
  End

  Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgOndasDBTableViewTIPPED.Index]) = KIT) Then
    ACanvas.Brush.Color := shpOndaKits.Brush.Color

  Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgOndasDBTableViewTIPPED.Index]) = CARRINHO) Then
    ACanvas.Brush.Color := shpOndaCarrinho.Brush.Color;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.cxgOndasDBTableViewKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) Or (Key = #32) Then
    Selecionar;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.Desmarcar;
begin
  If fEhRemessaDePedido Then
    FLock.fLock_Unlock('SEQSEP' + cdsOndasONDFIN.AsString, False, False,
                       False, '', True, '', True, True, False, False, False);

  cdsOndas.Edit;
  cdsOndasMARDES.AsString := DESMARCADO;
  cdsOndas.Post;
end;

function TfrmAgrupamentoDeOndaDeSeparacao.fEhRemessaDePedido: Boolean;
begin
  Result := (TipoOnda = toRemessaDePedido);
end;

function TfrmAgrupamentoDeOndaDeSeparacao.fEhRemessaDeSeparacao: Boolean;
begin
  Result := (TipoOnda = toRemessaDeSeparacao);
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.Marcar;
begin
  If fEhRemessaDePedido Then
  begin

    If Not FLock.fLock_Unlock('SEQSEP' + cdsOndasONDFIN.AsString, True, False,
                              False, '', True, '', True, True, False, False, False) Then
    Begin
      pMensagemOk('Esta remessa está sendo utilizada em outra estação por ' +
        fGetHostLock('SEQSEP' + cdsOndasONDFIN.AsString) + '!');
      Exit;
    End;

  End;

  cdsOndas.Edit;
  cdsOndasMARDES.AsString := SELECIONADO;
  cdsOndas.Post;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.SelecionaClonados(AClonados: TUniClientDataSet);
begin

  If Not Assigned(AClonados) Then
    Exit;

  AClonados.First;
  While Not AClonados.Eof Do
  Begin

    If cdsOndas.Locate('ONDFIN', AClonados.FieldByName('ONDFIN').AsString, []) Then
      Selecionar;

    AClonados.Next;

  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.Selecionar;
  var
    blnPodeSelecionar : Boolean;
begin

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  If (cdsOndasMARDES.AsString = SELECIONADO) Then
  Begin
    Desmarcar
  End
  Else
  Begin

    blnPodeSelecionar := False;

    If (fEhRemessaDeSeparacao) Then
      blnPodeSelecionar := True
    Else If (fEhRemessaDePedido) And (PodeSelecionar) Then
      blnPodeSelecionar := True;

    If blnPodeSelecionar Then
      Marcar;

  End;

  pSetFocus(cxgOndas);

end;

procedure TfrmAgrupamentoDeOndaDeSeparacao.UpdateDesagrupar(ARemessaDeSeparacao: String);
  const
    EXT = 'UPDATE EXTGOR SET FGO_SEQOND = NULL WHERE FGO_SEQOND = :SEQOND';
    OND = 'DELETE FROM ONDSEP WHERE OND_SEQOND = :SEQOND';
    LDO = 'DELETE FROM LOTDOR WHERE LDO_SEQFDO IN ' +
          '(SELECT        ' +
          '  D.AUTOINCREM ' +
          'FROM           ' +
          '  FATGOR G     ' +
          '  INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = G.AUTOINCREM) ' +
          '  INNER JOIN FATDOR D ON (D.FDO_SEQGER = G.AUTOINCREM) ' +
          'WHERE ' +
          '  E.FGO_SEQOND = :SEQOND) ';
  var
    LQry : TUniQuery;
begin

  If ARemessaDeSeparacao.IsEmpty Then
    Exit;

  LQry := fCriaQuery();

  Try

    {Apagar ONDSEP}
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(OND);
    LQry.ParamByName('SEQOND').AsString := ARemessaDeSeparacao;
    LQry.ExecSQL;

    {Apagar LOTDOR}
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(LDO);
    LQry.ParamByName('SEQOND').AsString := ARemessaDeSeparacao;
    LQry.ExecSQL;

    {Apagar FGO_SEQOND}
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(EXT);
    LQry.ParamByName('SEQOND').AsString := ARemessaDeSeparacao;
    LQry.ExecSQL;

  Finally
    FreeAndNil(LQry);
  End;

end;

end.
