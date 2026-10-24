unit untConfiguracoesAdvanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  ToolEdit, FilenameEditFocus, EditFocus, strUtils, Uni,
  DirectoryEditFocus, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesAdvanced = class(TfrmPai)
    pnlCabecalho: TPanel;
    chkUsaAdv: TCheckBox;
    Label2: TLabel;
    Label20: TLabel;
    edtTraAdv: TEditFocus;
    Label3: TLabel;
    edtFatAdv: TEditFocus;
    Label4: TLabel;
    edtNfmAdv: TEditFocus;
    Label5: TLabel;
    btnGravarConf: TBitBtn;
    fraPatAdv: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pCarregarConfs;
    procedure pSalvarConfs;
    { Private declarations }
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmConfiguracoesAdvanced: TfrmConfiguracoesAdvanced;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesAdvanced }

procedure TfrmConfiguracoesAdvanced.pCarregarConfs;
begin
  chkUsaAdv.Checked := fArqIniTinta(0, 'ADVANCED', 'USATIN', '') = 'S';
  edtTraAdv.Text := fArqIniTinta(0, 'ADVANCED', 'ADVTRA', '');
  edtFatAdv.Text := fArqIniTinta(0, 'ADVANCED', 'FATADV', '');
  edtNfmAdv.Text := fArqIniTinta(0, 'ADVANCED', 'NFMADV', '');
  fraPatAdv.edtDirectory.text := fArqIniTinta(0, 'ADVANCED', 'PATADV', '');
end;

procedure TfrmConfiguracoesAdvanced.pSalvarConfs;
begin
  fArqIniTinta(1, 'ADVANCED', 'USATIN', IfThen(chkUsaAdv.Checked, 'S', 'N'));
  fArqIniTinta(1, 'ADVANCED', 'ADVTRA', edtTraAdv.Text);
  fArqIniTinta(1, 'ADVANCED', 'FATADV', edtFatAdv.Text);
  fArqIniTinta(1, 'ADVANCED', 'NFMADV', edtNfmAdv.Text);
  fArqIniTinta(1, 'ADVANCED', 'PATADV', fraPatAdv.edtDirectory.text);
  fArqIniTinta(1, 'ADVANCED', 'VENDIN', 'S');
end;

procedure TfrmConfiguracoesAdvanced.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  pSalvarConfs;
end;

procedure TfrmConfiguracoesAdvanced.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregarConfs;
end;

function TfrmConfiguracoesAdvanced.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtTraAdv Then
    Begin
      If fEmptyStr(edtTraAdv.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com a trava para o valor de venda', ['OK']);
        Result := False;
      End
      Else If Pos(edtTraAdv.Text, '_VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtFatAdv Then
    Begin
      If fEmptyStr(edtFatAdv.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If StrToFloat(edtFatAdv.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser maior que zero!',['OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    Sender.SetFocus;
end;


end.
