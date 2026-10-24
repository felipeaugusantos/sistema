unit untImportaPedidoXmlTela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  untEntNFEDigManual, cxCalendar, cxTextEdit, untTypesSistema, uni, untFuncoesConsulta;

type
  TfrmImportaPedidoXmlTela = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxvPedidos: TcxGridDBTableView;
    cxgPedidosLevel1: TcxGridLevel;
    cxgPedidos: TcxGrid;
    cxvPedidosColumn1: TcxGridDBColumn;
    cxvPedidosColumn2: TcxGridDBColumn;
    cxvPedidosColumn3: TcxGridDBColumn;
    cxvPedidosColumn4: TcxGridDBColumn;
    cxvPedidosColumn5: TcxGridDBColumn;
    cxvPedidosColumn6: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnExcluir: TBitBtnLocked;
    edtNumPed: TEditFocus;
    Label1: TLabel;
    Label228: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    cxvPedidosColumn7: TcxGridDBColumn;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
  private
    arrPedCompra : TConsultasArray;
    { Private declarations }
  public
    { Public declarations }
    objNFEDig: TNFEDigManual;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmImportaPedidoXmlTela: TfrmImportaPedidoXmlTela;

implementation

{$R *.dfm}

Uses
  untConstantes,
  untFuncoesSimples,
  untConsultas;

procedure TfrmImportaPedidoXmlTela.btnConfirmaClick(Sender: TObject);
begin
  If objNFEDig.cdsPedImp.RecordCount <= 0 Then
  Begin
    pMensagemOk('Informe o numero do pedido para confirmar!');
    ModalResult:= mrCancel;
    Exit;
  End;

  inherited;

end;

procedure TfrmImportaPedidoXmlTela.btnExcluirClick(Sender: TObject);
begin
  inherited;

  objNFEDig.pRemovePedido;
end;

procedure TfrmImportaPedidoXmlTela.cxvPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : btnSair.Click;
  End;

end;

procedure TfrmImportaPedidoXmlTela.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmImportaPedidoXmlTela.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
var
  qryPcmGer : TUniQuery;
  strDoc    : String;
begin

  If fPesqPedidoCompra(Self, nil, nil, Key , arrPedcompra, strDoc, '', 0 , False) Then
  Begin

      if Length(arrPedCompra) = 1 then
      begin
        qryPcmGer := fCriaQuery(nil);
        try
          qryPcmGer.SQL.Add('SELECT                                                          ');
          qryPcmGer.SQL.Add('  PCG_NUMPED                                                    ');
          qryPcmGer.SQL.Add('FROM                                                            ');
          qryPcmGer.SQL.Add('  PCMGER                                                        ');
          qryPcmGer.SQL.Add('WHERE                                                           ');
          qryPcmGer.SQL.Add('  AUTOINCREM IN ('+   fArrCodigosToLista('', arrPedCompra) + ') ');
          qryPcmGer.Open;

          edtNumPed.Text := qryPcmGer.FieldByName('PCG_NUMPED').AsString;

          blnMudarFoco := False;
          pSetFocus(edtNumPed);
        finally
          FreeAndNil(qryPcmGer);
        end;

      end
      else
      begin

        edtNumPed.Text := '000000000000';
        pSetFocus(edtNumPed);
      end;

  End;

end;

procedure TfrmImportaPedidoXmlTela.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If fPergunta('Confirma a importação dos pedidos?') Then
      If Not objNFEDig.fCarregaProdutosPedidos Then
        Action := caNone;

  End Else
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;
end;

procedure TfrmImportaPedidoXmlTela.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text:= VS_strCodEmp;
  edtNomEmp.Text:= fRetNomeEmpresa;
end;

procedure TfrmImportaPedidoXmlTela.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : btnConfirma.Click;
  End;

end;

procedure TfrmImportaPedidoXmlTela.FormShow(Sender: TObject);
begin
  inherited;

  blnVerificaCampos := False;

  objNFEDig.cdsPedImp.fLeDados('TfrmImportaPedidoXmlTela.FormShow');
  cxvPedidos.DataController.DataSource := objNFEDig.cdsPedImp.dtsSource;
end;

function TfrmImportaPedidoXmlTela.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumPed) Then
    Begin

      If fEmptyStr(edtNumPed.Text) Then
      Begin
        pMensagemOk('Informe o número do Pedido!');
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        pMensagemOk('Informe a empresa do Pedido!');
        Result := False;
      End Else
      Begin

        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End;

      End;


      If Result And
         fValidaCampos(edtNumPed) And
         blnBuscaPorChave Then
      Begin

        If length(arrPedCompra) > 1 Then
        Begin
          objNFEDig.strListaPedido:= fArrCodigosToLista('', arrPedCompra);
          objNFEDig.FPedidoCompra.Close;
          objNFEDig.FPedidoCompra.SQL.Clear;
          objNFEDig.FPedidoCompra.SQL.Text := objNFEDig.fSQLPedidosImportacao;
        End
        Else
          objNFEDig.strListaPedido:= '';

        If objNFEDig.fAdicionaPedidoImportacao(edtNumPed.Text, edtCodEmp.Text) Then
        Begin
          edtNumPed.Clear;
          blnMudarFoco := False;
          pSetFocus(edtNumPed);
        End

        Else Result := False;

      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
