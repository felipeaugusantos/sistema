unit untConfiguracoesUniverso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, strUtils, FilenameEditFocus,
  ComCtrls, untConfConsulta, untIConfTinta,
  untIConsultaTinta, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesUniverso = class(TfrmPai)
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
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    edtPatUni: TFilenameEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    frmConfConsultaUniverso: TfrmConfConsulta;
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
  frmConfiguracoesUniverso: TfrmConfiguracoesUniverso;

implementation

uses untFuncTinta, untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesUniverso }

function TfrmConfiguracoesUniverso.fValidaCampos(Sender: TWinControl;
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
    End

    Else If (Sender = edtDesOpe) Then
    begin
      If fEmptyStr(edtDesOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
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

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesUniverso.pCarregarConfs;
begin
  conf := fGetConfTinta('UNI');

  chkUsaUni.Checked := conf.fGetBoolean('USATIN');
  edtTraUni.Text := conf.fGet('UNITRA');
  edtFatUni.Text := conf.fGet('FATUNI');
  edtNfmUni.Text := conf.fGet('NFMUNI');
  edtPatUni.Text := conf.fGet('PATUNI');
  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesUniverso.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesUniverso.pSalvarConfs;
begin
{
  fArqIniTinta(1, 'UNIVERSO', 'USATIN', IfThen(chkUsaUni.Checked, 'S', 'N'));
  fArqIniTinta(1, 'UNIVERSO', 'UNITRA', edtTraUni.Text);
  fArqIniTinta(1, 'UNIVERSO', 'FATUNI', edtFatUni.Text);
  fArqIniTinta(1, 'UNIVERSO', 'NFMUNI', edtNfmUni.Text);
  fArqIniTinta(1, 'UNIVERSO', 'PATUNI', edtPatUni.Text);

}

  conf.pSetBoolean('USATIN', chkUsaUni.Checked);
  conf.pSet('UNITRA', edtTraUni.Text);
  conf.pSet('FATUNI', edtFatUni.Text);
  conf.pSet('NFMUNI', edtNfmUni.Text);
  conf.pSet('PATUNI', edtPatUni.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaUniverso.pSalvarConfs;
end;

procedure TfrmConfiguracoesUniverso.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaUniverso.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesUniverso.Destroy;
begin
  if Assigned(frmConfConsultaUniverso) then FreeAndNil(frmConfConsultaUniverso);
  inherited;
end;

procedure TfrmConfiguracoesUniverso.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('UNI');
  tinta := fGetConsultaTinta('UNI');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'UNIVERSO', 'USATIN', ''));
  conf.pInsereCodigo('UNITRA', 'Trava para valor de venda UNI_PRE', fArqIniTinta(0, 'UNIVERSO', 'UNITRA', ''));
  conf.pInsereCodigo('FATUNI', 'Fator', fArqIniTinta(0, 'UNIVERSO', 'FATUNI', ''));
  conf.pInsereCodigo('NFMUNI', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'UNIVERSO', 'NFMUNI', ''));
  conf.pInsereCodigo('PATUNI', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'UNIVERSO', 'PATUNI', ''));

  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfs;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaUniverso := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

procedure TfrmConfiguracoesUniverso.btnGravarConfClick(Sender: TObject);
begin
  pSalvarConfs;
  Close;
end;

end.
