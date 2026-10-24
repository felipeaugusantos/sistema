unit untFatDigContatoCpfRG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, Mask, MaskEditFocus, untMskC_G_C_, untLabelRg, frxClass,
  frxExportCSVTestabilidade;

type
  TCfgObrigCampos = (tocCPF, tocRG, tocCPFouRG);
  TfrmFatDigContatoCpfRG = class(TfrmPai)
    pnlGeral: TPanel;
    lblCpf: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    edtNumCpf: TMaskEditC_G_C_;
    lblRG: TLabelRg;
    edtNumR_G: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cfgObrigCampos : TCfgObrigCampos;
    procedure ExibirCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodCli: String;
    strCliCtt: String;
    strProCtt: String;
  end;


implementation

uses  untfuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

{ TfrmFatDigContatoCpfRG }

function TfrmFatDigContatoCpfRG.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var 
    blnContatoEhOProprioCliente: Boolean;
begin

  Result := True;

  If (Sender = edtNumCpf) Then
  Begin
    If Not fEmptyStr(edtNumCpf.Text) Then
      Result := fValidaCnpjCpf(edtNumCpf.Text, True)
    Else
    If (cfgObrigCampos = tocCPF) Then
    Begin
      pMensagemOk('Deve ser informado o número do CPF do autorizado!');
      Result := False;
    End;
  End;

  If (Sender = edtNumR_G) Then
  Begin
    If (cfgObrigCampos = tocCPFouRG) Then
    Begin
      If fEmptyStr(edtNumCpf.Text) And fEmptyStr(edtNumR_G.Text) Then
      Begin
        pMensagemOk('Deve ser informado o número do CPF ou R.G. do autorizado!');
        Result := False;
      End
    End
    Else
    If (cfgObrigCampos = tocRG) Then
    Begin
      If fEmptyStr(edtNumR_G.Text) Then
      Begin
        pMensagemOk('Deve ser informado o número do R.G. do autorizado!');
        Result := False;
      End
    End;

    If Result Then
    Begin
      strCliCtt := '';
      strProCtt := '';
      blnContatoEhOProprioCliente := False;

      If Not fEmptyStr(edtNumCpf.Text) And Not fEmptyStr(edtNumR_G.Text) Then
      Begin
        strCliCtt := fCampoTabela('AUTOINCREM', 'CLICTT', ['CLI_CODCLI','CLI_NUMCPF','CLI_NUMR_G'], [strCodCli, edtNumCpf.Text, edtNumR_G.Text]);
          
        If fEmptyStr(strCliCtt) Then
        Begin  
          strProCtt := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI','CLI_C_G_C_','CLI_NUMR_G'], [strCodCli, edtNumCpf.Text, edtNumR_G.Text]);

          blnContatoEhOProprioCliente :=  Not strProCtt.IsEmpty;
        End;
      End
      Else If Not fEmptyStr(edtNumCpf.Text) Then
      Begin
        strCliCtt := fCampoTabela('AUTOINCREM', 'CLICTT', ['CLI_CODCLI','CLI_NUMCPF'], [strCodCli, edtNumCpf.Text]);

        If fEmptyStr(strCliCtt) Then  
        Begin
          strProCtt := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI','CLI_C_G_C_'], [strCodCli, edtNumCpf.Text]);

          blnContatoEhOProprioCliente :=  Not strProCtt.IsEmpty;  
        End;
      End
      Else If Not fEmptyStr(edtNumR_G.Text) Then
      Begin
        strCliCtt := fCampoTabela('AUTOINCREM', 'CLICTT', ['CLI_CODCLI','CLI_NUMR_G'], [strCodCli, edtNumR_G.Text]);

        If fEmptyStr(strCliCtt) Then  
        Begin
          strProCtt := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI','CLI_NUMR_G'], [strCodCli, edtNumR_G.Text]);
            
          blnContatoEhOProprioCliente :=  Not strProCtt.IsEmpty;
        End;
      End;

      If (Not blnContatoEhOProprioCliente) Then
      Begin
        If fEmptyStr(strCliCtt) Then
        Begin
          pMensagemOk('Dados informados incompatíveis, verifique com o responsável pelo cadastro do cliente!');
          Result := False;
        End
        Else If (fCampoTabela('CLI_AUTCTT', 'CLICTT', ['AUTOINCREM'], [strCliCtt]) <> 'S') Then
        Begin
          pMensagemOk('Contato não possui autorização para comprar!');
          Result := False;
        End;
      End;
    End;
  End;

end;

procedure TfrmFatDigContatoCpfRG.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatDigContatoCpfRG.ExibirCampos;
begin
  edtNumCpf.Visible := cfgObrigCampos in [tocCPFouRG, tocCPF];
  edtNumR_G.Visible := cfgObrigCampos in [tocCPFouRG, tocRG];
  lblCpf.Visible    :=  edtNumCpf.Visible;
  lblRG.Visible     :=  edtNumR_G.Visible;

  If (Not lblRG.Visible) Or (Not lblCpf.Visible) Then
  Begin
    Self.Height := 110;
    If (Not lblCpf.Visible) Then
    Begin
       lblRg.Top     := lblCpf.Top;
       edtNumR_G.Top := edtNumCpf.Top;
    End;
  End;
end;

procedure TfrmFatDigContatoCpfRG.FormCreate(Sender: TObject);
begin
  inherited;
  cfgObrigCampos := tocCPFouRG;
  case fCfgSis('ICRCTT', varInteger) of
    2: cfgObrigCampos := tocCPF;
    3: cfgObrigCampos := tocRG;
  end;

  ExibirCampos;
end;

procedure TfrmFatDigContatoCpfRG.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumCpf);
end;

end.

