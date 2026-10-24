unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, untInterfacesMultiplus;

type
  TForm1 = class(TForm, IObserverTEF)
    edtPathMultiplus: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtCNPJParceiro: TEdit;
    Label3: TLabel;
    edtCNPJCliente: TEdit;
    mmoLog: TMemo;
    Label7: TLabel;
    edtHost: TEdit;
    Label8: TLabel;
    edtPorta: TEdit;
    Label10: TLabel;
    gpbOperacao: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    edtParcelas: TEdit;
    edtCupom: TEdit;
    edtValor: TEdit;
    btnOperacao: TButton;
    cmbOperacao: TComboBox;
    btnIniciarCfg: TButton;
    procedure btnOperacaoClick(Sender: TObject);
    procedure btnIniciarCfgClick(Sender: TObject);
  protected
    procedure Atualizar(ARetorno: IRetornoTEF);
  private
    { Private declarations }
    objTefMultPlus : ITefMultiplus;
    procedure Init();
  public
    { Public declarations }
  end;

  function fTefMultiplus(ACnpjCliente, ACnpParceiro, APathConector, AHost: String; APort: Integer): ITefMultiplus; stdcall; External 'libTEFMultiplus.dll' delayed;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Atualizar(ARetorno: IRetornoTEF);
  Var
    intCnt : Integer;
begin
  mmoLog.Lines.Add('StatusTEF.Status   -> ' + ARetorno.StatusTEF.strStatus);
  mmoLog.Lines.Add('StatusTEF.Mensagem -> ' + ARetorno.StatusTEF.strMensagem);
  mmoLog.Lines.Add(StringOfChar('-', 30));
  mmoLog.Lines.Add('DadosCartao.Cupom  -> ' + ARetorno.DadosCartao.strCupom);
  mmoLog.Lines.Add('DadosCartao.Valor  -> ' + ARetorno.DadosCartao.strValor);
  mmoLog.Lines.Add('');

  If (ARetorno.Cupom.Count > 0) Then
  Begin
    For intCnt := 0 To ARetorno.Cupom.Count-1 Do
      mmoLog.Lines.Add(ARetorno.Cupom.Strings[intCnt]);
  End;

  btnOperacao.Enabled := True;
end;

procedure TForm1.btnIniciarCfgClick(Sender: TObject);
begin
  Init();
  btnIniciarCfg.Enabled := False;
  gpbOperacao.Enabled := True;
end;

procedure TForm1.btnOperacaoClick(Sender: TObject);
begin
  btnOperacao.Enabled := False;
  Try
    mmoLog.Lines.Clear;
    Case cmbOperacao.ItemIndex Of
      0:
        objTefMultPlus.AdmFuncoesAdministrativas(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      1:
        objTefMultPlus.Debito(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      2:
        objTefMultPlus.CreditoAvista(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      3:
        objTefMultPlus.ConfirmacaoUltimaVendaPendente(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      4:
        objTefMultPlus.DesfazerUltimaVendaPendente(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      5:
        objTefMultPlus.CancelamentoEstorno(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      6:
        objTefMultPlus.CreditoParceladoLoja(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      7:
        objTefMultPlus.CreditoParceladoADM(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      8:
        objTefMultPlus.Reimpressao(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      9:
        objTefMultPlus.PagamentoContas(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      10:
        objTefMultPlus.ConsultaCDC(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      11:
        objTefMultPlus.ConsultaSaldoDebito(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      12:
        objTefMultPlus.ConsultaSaldoCredito(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      13:
        objTefMultPlus.Relatorios(edtParcelas.Text, edtCupom.Text, edtValor.Text);
      Else
        raise Exception.Create('Operação de TEF não implementada.')
    End;
  Finally
  End;
end;

procedure TForm1.Init;
begin
  If (Not Assigned(objTefMultPlus)) Then
  begin
    objTefMultPlus := fTefMultiplus(edtCNPJCliente.Text, edtCNPJParceiro.Text, edtPathMultiplus.Text, edtHost.Text, StrToInt(edtPorta.Text));
    objTefMultPlus.AdicionaObserver(Self);
  end;
end;

end.
