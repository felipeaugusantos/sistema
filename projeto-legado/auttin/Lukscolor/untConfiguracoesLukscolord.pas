unit untConfiguracoesLukscolord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  ToolEdit, FilenameEditFocus, DirectoryEditFocus, AppEvnts, ComCtrls,
  untIConfTinta, untConfConsulta, untIConsultaTinta, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesLukscolord = class(TfrmPai)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    chkUsaLkd: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    edtTraLkd: TEditFocus;
    edtFatLkd: TEditFocus;
    Label4: TLabel;
    edtNfmLkd: TEditFocus;
    Label5: TLabel;
    btnGravarConf: TBitBtn;
    chkUsaFor: TCheckBox;
    fraTxtLkd: TfraDirectoryEditFocus;
    chkVenDin: TCheckBox;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaLukscolor: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesLukscolord: TfrmConfiguracoesLukscolord;

implementation

uses untFuncoes, untFuncoesSimples, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracoesLukscolord }

function TfrmConfiguracoesLukscolord.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtTraLkd) Then
    Begin
      If (fEmptyStr(edtTraLkd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraLkd.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraLkd.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtFatLkd) Then
    Begin
      If (fEmptyStr(edtFatLkd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If StrToFloat(edtFatLkd.Text) = 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser diferente de Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNfmLkd) Then
    Begin
      If (fEmptyStr(edtNfmLkd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O próximo codigo para novas formulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = fraTxtLkd) Then
    Begin
      If (fEmptyStr(fraTxtLkd.edtDirectory.text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para os arquivos deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        fraTxtLkd.edtDirectory.text := fGetPath(fraTxtLkd.edtDirectory.text);
        If (Not DirectoryExists(fraTxtLkd.edtDirectory.text)) Then
          CreateDir(fraTxtLkd.edtDirectory.text);
      End;
    End;
  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmConfiguracoesLukscolord.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA Lukscolor             *}
  {**************************************MV*}
  chkUsaLkd.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtTraLkd.Text    := conf.fGet('TRALKD');
  edtFatLkd.Text    := conf.fGet('FATLKD');
  edtNfmLkd.Text    := conf.fGet('NFMLKD');
  fraTxtLkd.edtDirectory.text    := conf.fGet('TXTLKD');
  chkVenDin.Checked := conf.fGetBoolean('VENDIN');
end;

procedure TfrmConfiguracoesLukscolord.pGravaArqIni;
begin
  conf.pSetBoolean('USATIN', chkUsaLkd.Checked);
  conf.pSetBoolean('VENDIN', chkVenDin.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('TXTLKD', fraTxtLkd.edtDirectory.text);
  conf.pSet('NFMLKD', edtNfmLkd.Text);
  conf.pSet('TRALKD', edtTraLkd.Text);
  conf.pSet('FATLKD', edtFatLkd.Text);

  frmConfConsultaLukscolor.pSalvarConfs;
end;

procedure TfrmConfiguracoesLukscolord.FormCreate(Sender: TObject);
begin
  inherited;
  fStartTransaction;
  pCarregaArqIni;

  conf := fGetConfTinta('LKS');
  tinta := fGetConsultaTinta('LKS');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('VENDIN', 'Venda Dinâmica', 'S');
  conf.pInsereCodigo('TXTLKD', 'Path para os arquivos', '');
  conf.pInsereCodigo('NFMLKD', 'Próximo Código Nova Fórmulas', '1');
  conf.pInsereCodigo('TRALKD', 'Trava de Preço', 'ven');
  conf.pInsereCodigo('FATLKD', 'Fator da Trava', '1,00');

  frmConfConsultaLukscolor := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  pCarregaArqIni;

end;

procedure TfrmConfiguracoesLukscolord.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;

      If chkVenDin.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'Por favor, entre em contato com a Citel, pois será necessário ' +
                              'executar um Script para a atualização da confirmação de documentos.', ['&Ok']);
      End;

      Close;
    End;
  End;
end;

end.
