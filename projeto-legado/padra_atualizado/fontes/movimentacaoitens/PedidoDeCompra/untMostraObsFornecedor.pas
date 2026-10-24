unit untMostraObsFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, MemoFocus, untZClient, untFuncoesSimples, DB;

type
  TfrmMostraObsFornecedor = class(TfrmPaiSimples)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    memObserv: TMemoFocus;
    btnAlterar: TBitBtnLocked;
    btnFechar: TBitBtnLocked;
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    qryFor: TZClient;
    procedure btnSalvarClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    class procedure pMostrarObservacaoFornecedor(strCodFor: string);
    function Showmodal(objZClient: TZClient): Integer;reintroduce;

  end;

var
  frmMostraObsFornecedor: TfrmMostraObsFornecedor;

implementation

{$R *.dfm}

procedure TfrmMostraObsFornecedor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  btnAlterar.Caption := '[F10] - Salvar';
  memObserv.ReadOnly := False;
  memObserv.SelStart := Length(memObserv.Texto);
  pSetFocus(memObserv);
  btnAlterar.OnClick := btnSalvarClick;
end;

procedure TfrmMostraObsFornecedor.btnSalvarClick(Sender: TObject);
begin
  qryFor.Edit;
  qryFor.FieldByName('FOR_OBSCMP').AsString := memObserv.Text;
  If qryFor.fSalva Then
    fMensagem('AVISO!', 'Alteração efetuada com sucesso!', ['&O k']);
  Close;
end;

procedure TfrmMostraObsFornecedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  IF key = vk_escape Then
    Close;

  if btnAlterar.Visible Then
  Begin
    If key in [vk_f2, vk_f10] Then
      btnAlterar.Click;
  End;

end;

class procedure TfrmMostraObsFornecedor.pMostrarObservacaoFornecedor(
  strCodFor: string);
  var
    qryConsulta : TZClient;
begin
  qryConsulta := TZClient.Create(nil, 'SELECT FOR_CODFOR, FOR_OBSCMP FROM CADFOR WHERE FOR_CODFOR = ' + fQuotedStr(strCodFor));
  Try
    qryConsulta.pSetProvider;
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
      Exit;
    If fEmpTyStr(qryConsulta.FieldByName('FOR_OBSCMP').AsString) Then
      Exit;
    pCriarFormularios(TfrmMostraObsFornecedor, frmMostraObsFornecedor);
    Try
      frmMostraObsFornecedor.ShowModal(qryConsulta);
    Finally
      FreeAndNil(frmMostraObsFornecedor);
    End
  Finally
    FreeAndNil(qryConsulta);
  End
end;

function TfrmMostraObsFornecedor.Showmodal(objZClient: TZClient): Integer;
begin
  qryFor := objZClient;
  memObserv.Texto := objZClient.FieldByName('FOR_OBSCMP').AsString;
  btnAlterar.Visible := fVerificaAcessoSistema('FOBCMP', strLoginUsuarioLogado);
  Result := inherited ShowModal;
end;

end.
