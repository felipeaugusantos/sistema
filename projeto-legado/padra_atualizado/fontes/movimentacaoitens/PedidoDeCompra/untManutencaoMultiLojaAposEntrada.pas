unit untManutencaoMultiLojaAposEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  untTManutencaoMultiLojaAposEntrada, untConstantes, untFuncoesSimples,
  cxCurrencyEdit, cxCheckBox, cxContainer, cxProgressBar;

type
  TfrmManutecaoMultiLojaPosEntrada = class(TfrmPai)
    grpPedCom: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtNumPed: TEditFocus;
    edtPdEspDoc: TEditFocus;
    edtCodEmpPD: TEditFocus;
    edtDesEmpPD: TEditFocus;
    Panel1: TPanel;
    Panel2: TPanel;
    cxgPcmdet: TcxGridCitel;
    cxvPcmdet: TcxGridDBTableViewCitel;
    cxlPcmdet: TcxGridLevel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    cxgPcddet: TcxGridCitel;
    cxvPcddet: TcxGridDBTableViewCitel;
    cxlPcddet: TcxGridLevel;
    cxvPcmdetPCD_CODITE: TcxGridDBColumn;
    cxvPcmdetColumn2: TcxGridDBColumn;
    cxvPcmdetColumn3: TcxGridDBColumn;
    cxvPcmdetColumn5: TcxGridDBColumn;
    cxvPcmdetPCD_QTDRES: TcxGridDBColumn;
    cxvPcmdetColumn7: TcxGridDBColumn;
    cxvPcddetColumn1: TcxGridDBColumn;
    cxvPcddetColumn2: TcxGridDBColumn;
    cxvPcddetColumn3: TcxGridDBColumn;
    cxvPcddetColumn4: TcxGridDBColumn;
    Panel4: TPanel;
    cxgBaixarItem: TcxGridDBColumn;
    Label3: TLabel;
    cxvPcmdetColumn1: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnConfirma: TBitBtnLocked;
    btnCarregar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnConfirmaClick(Sender: TObject);

  private
    { Private declarations }
  public
    objManutencaoMultiLojaAposEntrada: TManutencaoMultiLojaAposEntrada;
    { Public declarations }
  end;

var
  frmManutecaoMultiLojaPosEntrada: TfrmManutecaoMultiLojaPosEntrada;

implementation

uses
  untGerenciaTransferenciaPedidoCompraMultiLoja;


{$R *.dfm}

procedure TfrmManutecaoMultiLojaPosEntrada.btnCarregarClick(Sender: TObject);
 var Pedido: TpedidoCompra;
begin
  inherited;
  Pedido.strNumped := edtNumPed.Text;
  Pedido.strCodEmp := edtCodEmpPD.Text;
  Pedido.strEspPed := edtPdEspDoc.Text;
  If objManutencaoMultiLojaAposEntrada.fCarregaPedido(Pedido) Then
  Begin
    btnCarregar.Enabled := False;
    grpPedCom.Enabled := False;
    btnConfirma.Enabled := True;

    cxvPcmdet.DataController.DataSource := objManutencaoMultiLojaAposEntrada.dtsPcmDet;
    cxvPcddet.DataController.DataSource := objManutencaoMultiLojaAposEntrada.dtsPcdDet;
  End;
end;

procedure TfrmManutecaoMultiLojaPosEntrada.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If btnConfirma.Enabled Then
    If objManutencaoMultiLojaAposEntrada.fGravaAlteracoes Then
    Begin
      grpPedCom.Enabled := True;
      edtNumPed.Clear;
      btnCarregar.Enabled := True;
      btnConfirma.Enabled := False;
      grpPedCom.Enabled := True;
      objManutencaoMultiLojaAposEntrada.Reinicia;
      pSetFocus(edtNumPed);
    End;
end;

procedure TfrmManutecaoMultiLojaPosEntrada.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If Assigned(objManutencaoMultiLojaAposEntrada.dtsPcmDet.DataSet) Then
    If objManutencaoMultiLojaAposEntrada.dtsPcmDet.DataSet.RecordCount > 0 Then
    Begin
      CanClose := False;
      if fPergunta('Deseja reiniciar?') Then
      Begin
        grpPedCom.Enabled := True;
        edtNumPed.Clear;
        btnCarregar.Enabled := True;
        btnConfirma.Enabled := False;
        grpPedCom.Enabled := True;
        objManutencaoMultiLojaAposEntrada.Reinicia;
        pSetFocus(edtNumPed);
      End;
    End;
end;

procedure TfrmManutecaoMultiLojaPosEntrada.FormCreate(Sender: TObject);

begin
  inherited;
  edtCodEmpPD.Text := VS_strCodEmp;
  edtDesEmpPD.Text := fRetNomeEmpresaSelec(edtCodEmpPD.Text);

  objManutencaoMultiLojaAposEntrada := TManutencaoMultiLojaAposEntrada.create;

end;

end.
