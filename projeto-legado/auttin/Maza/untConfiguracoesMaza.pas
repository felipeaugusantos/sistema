unit untConfiguracoesMaza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, strUtils, FilenameEditFocus,
  untConfConsulta, untIConfTinta, untIConsultaTinta,  ComCtrls,
  BitBtnLockedIncrem, JvExMask, JvToolEdit, frxClass, frxExportCSVTestabilidade;

type
  TfrmConfiguracoesMaza = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkUsaUni: TCheckBox;
    edtTraUni: TEditFocus;
    edtFatUni: TEditFocus;
    edtNfmUni: TEditFocus;
    edtPatUni: TFilenameEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    frmConfConsultaMaza: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;

    procedure pCarregarConfs;
    procedure pSalvarConfs;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    { Private declarations }
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesMaza: TfrmConfiguracoesMaza;

implementation

uses untFuncTinta, untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesMaza }

function TfrmConfiguracoesMaza.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtTraUni Then
    Begin
      If fEmptyStr(edtTraUni.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com a trava para o valor de venda', ['OK']);
        Result := False;
      End
      Else If Pos(edtTraUni.Text, '_VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtFatUni Then
    Begin
      If fEmptyStr(edtFatUni.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(edtFatUni.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser maior que zero!',['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtPatUni Then
    Begin
      If Not FileExists(edtPatUni.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O arquivo não existe!', ['OK']) = -1;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesMaza.pCarregarConfs;
begin
{
  chkUsaUni.Checked := fArqIniTinta(0, 'MAZA', 'USATIN', '') = 'S';
  edtTraUni.Text := fArqIniTinta(0, 'MAZA', 'MAZTRA', '');
  edtFatUni.Text := fArqIniTinta(0, 'MAZA', 'FATMAZ', '');
  edtNfmUni.Text := fArqIniTinta(0, 'MAZA', 'NFMMAZ', '');
  edtPatUni.Text := fArqIniTinta(0, 'MAZA', 'PATMAZ', '');
}

  chkUsaUni.Checked := conf.fGetBoolean('USATIN');
  edtTraUni.Text    := conf.fGet('MAZTRA');
  edtFatUni.Text    := conf.fGet('FATMAZ');
  edtNfmUni.Text    := conf.fGet('NFMMAZ');
  edtPatUni.Text    := conf.fGet('PATMAZ');
end;

procedure TfrmConfiguracoesMaza.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesMaza.pSalvarConfs;
begin
{
  fArqIniTinta(1, 'MAZA', 'USATIN', IfThen(chkUsaUni.Checked, 'S', 'N'));
  fArqIniTinta(1, 'MAZA', 'MAZTRA', edtTraUni.Text);
  fArqIniTinta(1, 'MAZA', 'FATMAZ', edtFatUni.Text);
  fArqIniTinta(1, 'MAZA', 'NFMMAZ', edtNfmUni.Text);
  fArqIniTinta(1, 'MAZA', 'PATMAZ', edtPatUni.Text);

}
  conf.pSetBoolean('USATIN', chkUsaUni.Checked);
  conf.pSet('MAZTRA', edtTraUni.Text);
  conf.pSet('FATMAZ', edtFatUni.Text);
  conf.pSet('NFMMAZ', edtNfmUni.Text);
  conf.pSet('PATMAZ', edtPatUni.Text);


  frmConfConsultaMaza.pSalvarConfs;
end;

procedure TfrmConfiguracoesMaza.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaMaza.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesMaza.Destroy;
begin
  if Assigned(frmConfConsultaMaza) then FreeAndNil(frmConfConsultaMaza);
  inherited;
end;

procedure TfrmConfiguracoesMaza.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('MAZ');
  tinta := fGetConsultaTinta('MAZ');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'MAZA', 'USATIN', ''));
  conf.pInsereCodigo('MAZTRA', 'Trava para valor de venda MAZ_PRE', fArqIniTinta(0, 'MAZA', 'MAZTRA', ''));
  conf.pInsereCodigo('FATMAZ', 'Fator', fArqIniTinta(0, 'MAZA', 'FATMAZ', ''));
  conf.pInsereCodigo('NFMMAZ', 'Próximo código Nova formúla', fArqIniTinta(0, 'MAZA', 'NFMMAZ', ''));
  conf.pInsereCodigo('PATMAZ', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'MAZA', 'PATMAZ', ''));


  pCarregarConfs;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaMaza := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

procedure TfrmConfiguracoesMaza.btnGravarConfClick(Sender: TObject);
begin
  pSalvarConfs;
  Close;
end;

end.
