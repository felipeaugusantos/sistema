unit untDigDesfazerBaixaPedNaoEntregues;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, untFuncoesConsulta, untFuncoesSimples, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, untConsultas, untTypesSistema,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untPaiConfirma, untFuncoesPedidoSimples, untPai;

type
  TfrmDigDesfazerBaixaPedNaoEntregues = class(TfrmPai)
    lblPedido: TLabel;
    edtNumPed: TEditFocus;
    Label1: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    arrEmp: TConsultasArray;
    blnFechar: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmDigDesfazerBaixaPedNaoEntregues: TfrmDigDesfazerBaixaPedNaoEntregues;

implementation

uses
  untMensagemExplicativa;

{$R *.dfm}

procedure TfrmDigDesfazerBaixaPedNaoEntregues.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnFechar := False;
  If fVerificaCampos Then
  Begin
    blnFechar := true;
    If fMensagem('ATENÇÃO', 'Confirma a operação de desfazer baixa do pedido?', ['&Sim', '&Não']) = 1 Then
    Begin
      If Not fDesfazerBaixaPedidoNaoEntregue(edtNumPed.Text, 'PD', edtCodEmp.Text) Then
      begin
        fMensagem('', 'Houve um erro ao desfazer a baixa do pedido!', ['&Ok']);
        blnFechar := False;
      end
    End;
  End;



end;

procedure TfrmDigDesfazerBaixaPedNaoEntregues.btnSairClick(Sender: TObject);
begin
  blnFechar := True;
  inherited;

end;

procedure TfrmDigDesfazerBaixaPedNaoEntregues.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmDigDesfazerBaixaPedNaoEntregues.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  blnAcessoTodasAsEmpresas: Boolean;
begin
  inherited;

  blnAcessoTodasAsEmpresas := fCfgSis('ACEMPI', varBoolean);

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, blnAcessoTodasAsEmpresas) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigDesfazerBaixaPedNaoEntregues.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := blnFechar;
  blnFechar := True;
end;

procedure TfrmDigDesfazerBaixaPedNaoEntregues.FormCreate(Sender: TObject);
begin
  inherited;
  blnFechar := True;

end;

function TfrmDigDesfazerBaixaPedNaoEntregues.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := False;
  If (Sender = edtNumPed) Then
  Begin
    If (fEmptyStr(edtNumPed.Text)) Then
    Begin
      fMensagem('', 'O Número do Pedido deve ser preenchido!', ['&Ok']);
      Exit;
    End
    Else
    Begin
      If Not fVerificaSePedidoExiste(edtNumPed.Text, edtCodEmp.Text, 'PD') Then
      Begin
        fMensagem('', 'O pedido informado não existe!', ['&Ok']);
        Exit;
      End;
      If fValidaPedComQuantidadeBaixada(edtNumPed.Text, 'PD', edtCodEmp.Text) Then
      Begin
        fMensagem('', 'Somente será possível desfazer baixas de pedidos que'+#13+' não tiveram entradas e não foram entregues', ['&Ok']);
        Exit;
      End;
      If Not fValidaPedBaixado(edtNumPed.Text, 'PD', edtCodEmp.Text) Then
      Begin
        fMensagem('', 'Este pedido não esta baixado.', ['&Ok']);
        Exit;
      End;
    End;
  End
  Else If (Sender = edtCodEmp) And (fEmptyStr(edtCodEmp.Text)) Then
  Begin
    fMensagem('', 'O código da empresa deve ser preenchido!', ['&Ok']);
    pSetFocus(edtCodEmp);
    Exit;
  End;

 Result := True;

 If (Not Result) Then
  pSetFocus(Sender);
end;

end.
