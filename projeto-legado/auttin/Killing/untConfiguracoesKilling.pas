unit untConfiguracoesKilling;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus,
  DirectoryEditFocus, AppEvnts, StrUtils,
  untConfConsulta, untIConsultaTinta, untIConfTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesKilling = class(TfrmPaiSimples)
    pnlBotoesConf: TPanel;
    pnlFundo: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    chkUsaKil: TCheckBox;
    edtTraKil: TEditFocus;
    edtFatKil: TEditFocus;
    edtNfmKil: TEditFocus;
    chkUsaFor: TCheckBox;
    tbsConfCampos: TTabSheet;
    pnlCabecalho: TPanel;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    edtPatKil: TFilenameEditFocus;
    grbConexao: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtSerKil: TEditFocus;
    edtUsuKil: TEditFocus;
    edtPorKil: TEditFocus;
    edtSenKil: TEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }

    frmConfConsultaKilling: TfrmConfConsulta;
    consulta: IConsultaTinta;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesKilling: TfrmConfiguracoesKilling;

implementation

uses
     untFuncTinta, untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesKilling }

procedure TfrmConfiguracoesKilling.pAtualizaVariaveisGlobais;
begin


end;

procedure TfrmConfiguracoesKilling.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA KILLING              *}
  {**************************************MV*}
{
  chkUsaKil.Checked := (fArqIniTinta(0, 'KILLING', 'USATIN', '') = 'S');
  chkUsaFor.Checked := (fArqIniTinta(0, 'USA_FORMUL', 'KIL', 'S') = 'S');
  edtTraKil.Text    := fArqIniTinta(0, 'KILLING', 'TRAKIL', '');
  edtFatKil.Text    := fArqIniTinta(0, 'KILLING', 'FATKIL', '');
  edtNfmKil.Text    := fArqIniTinta(0, 'KILLING', 'NFMKIL', '');
  edtPatKil.Text    := fArqIniTinta(0, 'KILLING', 'PATKIL', '');
}

  chkUsaKil.Checked := conf.fGetBoolean('USATIN'); //(fArqIniTinta(0, 'KILLING', 'USATIN', '') = 'S');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR'); //(fArqIniTinta(0, 'USA_FORMUL', 'KIL', 'S') = 'S');
  edtTraKil.Text    := conf.fGet('TRAKIL'); //fArqIniTinta(0, 'KILLING', 'TRAKIL', '');
  edtFatKil.Text    := conf.fGet('FATKIL'); //fArqIniTinta(0, 'KILLING', 'FATKIL', '');
  edtNfmKil.Text    := conf.fGet('NFMKIL'); //fArqIniTinta(0, 'KILLING', 'NFMKIL', '');
  edtPatKil.Text    := conf.fGet('PATKIL'); //fArqIniTinta(0, 'KILLING', 'PATKIL', '');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

  edtSerKil.Text    := conf.fGet('SERKIL');
  edtUsuKil.Text    := conf.fGet('USUKIL');
  edtPorKil.Text    := conf.fGet('PORKIL');
  edtSenKil.Text    := conf.fGet('SENKIL');
end;

procedure TfrmConfiguracoesKilling.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesKilling.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA KILLING                *}
  {**************************************MV*}
{
  If chkUsaKil.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  strUsaFor := IIF(chkUsaFor.Checked, 'S', 'N');

  fArqIniTinta(1, 'KILLING', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'USA_FORMUL', 'KIL', strUsaFor);
  fArqIniTinta(1, 'KILLING', 'TRAKIL', edtTraKil.Text);
  fArqIniTinta(1, 'KILLING', 'FATKIL', edtFatKil.Text);
  fArqIniTinta(1, 'KILLING', 'NFMKIL', edtNfmKil.Text);
  fArqIniTinta(1, 'KILLING', 'PATKIL', edtPatKil.Text);
}

  conf.pSetBoolean('USATIN', chkUsaKil.Checked); //fArqIniTinta(1, 'KILLING', 'USATIN', strUsaTin);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked); //fArqIniTinta(1, 'USA_FORMUL', 'KIL', strUsaFor);
  conf.pSet('TRAKIL', edtTraKil.Text); //fArqIniTinta(1, 'KILLING', 'TRAKIL', edtTraKil.Text);
  conf.pSet('FATKIL', edtFatKil.Text); //fArqIniTinta(1, 'KILLING', 'FATKIL', edtFatKil.Text);
  conf.pSet('NFMKIL', edtNfmKil.Text); //fArqIniTinta(1, 'KILLING', 'NFMKIL', edtNfmKil.Text);
  conf.pSet('PATKIL', edtPatKil.Text); //fArqIniTinta(1, 'KILLING', 'PATKIL', edtPatKil.Text);
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  conf.pSet('SERKIL', edtSerKil.Text);
  conf.pSet('USUKIL', edtUsuKil.Text);
  conf.pSet('PORKIL', edtPorKil.Text);
  conf.pSet('SENKIL', edtSenKil.Text);

  frmConfConsultaKilling.pSalvarConfs;
end;

procedure TfrmConfiguracoesKilling.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      pAtualizaVariaveisGlobais;
      Close;
    End;

  End;
end;

procedure TfrmConfiguracoesKilling.FormCreate(Sender: TObject);
begin
  inherited;
  consulta := fGetConsultaTinta('KIL');
  conf     := fGetConfTinta('KIL');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'KILLING', 'USATIN', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'KIL', 'S'));
  conf.pInsereCodigo('TRAKIL', 'Trava para valor de venda KIL_PRE', fArqIniTinta(0, 'KILLING', 'TRAKIL', ''));
  conf.pInsereCodigo('FATKIL', 'Fator', fArqIniTinta(0, 'KILLING', 'FATKIL', ''));
  conf.pInsereCodigo('NFMKIL', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'KILLING', 'NFMKIL', ''));
  conf.pInsereCodigo('PATKIL', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'KILLING', 'PATKIL', ''));
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  conf.pInsereCodigo('SERKIL', 'Servidor', 'localhost');
  conf.pInsereCodigo('USUKIL', 'Usuário', 'SYSDBA');
  conf.pInsereCodigo('PORKIL', 'Porta', '');
  conf.pInsereCodigo('SENKIL', 'Senha', 'masterkey');

  pCarregaArqIni;
  frmConfConsultaKilling   := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;

//  edtPatKil.Dialog.Dialog.Filter := 'Arquivos Texto|*.txt|Arquivos Access|*.mdb|Todos os arquivos|*.*';
  edtPatKil.Dialog.Dialog.Filter := 'Arquivos Texto|*.txt|Arquivos Firebird|*.gdb|Todos os arquivos|*.*';
end;

function TfrmConfiguracoesKilling.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CAMPOS DA KILLING              *}
    {**************************************MV*}
    If (Sender = edtTraKil) Then
    Begin

      If fEmptyStr(edtTraKil.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraKil.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraKil.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatKil) Then
    Begin

      If fEmptyStr(edtFatKil.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatKil.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtNfmKil) Then
    Begin

      If (fEmptyStr(edtNfmKil.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtPatKil) Then
    Begin
      If (fEmptyStr(edtPatKil.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

      End;
    End

    Else If (Sender = edtApreve) Then
    begin
      If fEmptyStr(edtApreve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtApreve.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtUsuKil) Then
    Begin

      If (fEmptyStr(edtUsuKil.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O usuário deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtSenKil) Then
    Begin
      If (fEmptyStr(edtSenKil.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A senha deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesKilling.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaKilling.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesKilling.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
