unit untCadWanProGeraArquivoAnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmCadWanProGeraArquivoAnt = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    tmrProgresso: TTimer;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    rdbGerBas: TRadioButton;
    rdbGerFor: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
  private
    { Private declarations }
    strDirecao: String;
  public
    { Public declarations }
  end;

var
  frmCadWanProGeraArquivoAnt: TfrmCadWanProGeraArquivoAnt;

implementation

uses  untWandaProAnt, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadWanProGeraArquivoAnt.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    blnGerarBases: Boolean;
    blnZapearBases: Boolean;
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin

    blnGerarBases := (rdbGerBas.Checked);

    blnZapearBases := False;
    If (blnGerarBases) Then
      blnZapearBases := (fMensagem('>>> ATENÇÃO <<<', 'Deseja gerar todas as bases novamente?' + #13#10 +
                                                      'Caso responda SIM, será necessário recadastrar todas as bases.',
                                                      ['Não', 'Sim']) = 2);

    pnlInfo.Caption := 'Gerando arquivo (COLOR PRO), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    If (fGeraWandaColorProAnt(blnGerarBases, blnZapearBases)) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';
    Close;
  End;
end;

procedure TfrmCadWanProGeraArquivoAnt.tmrProgressoTimer(Sender: TObject);
begin
  inherited;
  If strDirecao = 'D' Then
  Begin

    pnlProgInterno.Left := pnlProgInterno.Left + 5;

    If pnlProgInterno.Left + pnlProgInterno.Width >= pnlCentral.Width Then
      strDirecao := 'E';

  End
  Else
  Begin
    pnlProgInterno.Left := pnlProgInterno.Left - 5;

    If pnlProgInterno.Left <= 0 Then
      strDirecao := 'D';
  End;
end;

end.
