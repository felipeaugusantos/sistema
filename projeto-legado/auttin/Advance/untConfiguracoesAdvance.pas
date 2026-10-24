unit untConfiguracoesAdvance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, strUtils, Uni,DirectoryEditFocus, ComCtrls,
  untConfConsulta, untIConfTinta, untIConsultaTinta, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesAdvance = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkUsaAdv: TCheckBox;
    edtTraAdv: TEditFocus;
    edtFatAdv: TEditFocus;
    edtNfmAdv: TEditFocus;
    chkCorob: TCheckBox;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    chkUtf: TCheckBox;
    rgTipoQuantidade: TRadioGroup;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label1: TLabel;
    edtApreve: TEditFocus;
    fraPatAdv: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    frmConfConsultaAdvance: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pCarregarConfs;
    procedure pSalvarConfs;
    { Private declarations }
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesAdvance: TfrmConfiguracoesAdvance;

implementation

uses untFuncTinta, untFuncoesSimples ;

{$R *.dfm}

{ TfrmConfiguracoesAdvance }

procedure TfrmConfiguracoesAdvance.pCarregarConfs;
begin
  conf := fGetConfTinta('ADV');

  chkUsaAdv.Checked := conf.fGetBoolean('USATIN');
  chkCorob.Checked  := conf.fGetBoolean('COROB_');
  edtTraAdv.Text    := conf.fGet('ADVTRA');
  edtFatAdv.Text    := conf.fGet('FATADV');
  edtNfmAdv.Text    := conf.fGet('NFMADV');
  fraPatAdv.edtDirectory.text    := conf.fGet('PATADV');
  chkUtf.Checked    := conf.fGetBoolean('UTF8');
  rgTipoQuantidade.ItemIndex := conf.fGetInteger('QTDORI');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesAdvance.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesAdvance.pSalvarConfs;
begin
  conf.pSetBoolean('USATIN', chkUsaAdv.Checked);
  conf.pSetBoolean('COROB_', chkCorob.Checked);
  conf.pSet('ADVTRA', edtTraAdv.Text);
  conf.pSet('FATADV', edtFatAdv.Text);
  conf.pSet('NFMADV', edtNfmAdv.Text);
  conf.pSet('PATADV', fraPatAdv.edtDirectory.text);

  conf.pSetBoolean('UTF8', chkUtf.Checked);
  conf.pSetInteger('QTDORI', rgTipoQuantidade.ItemIndex);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaAdvance.pSalvarConfs;
  fCommit;
end;

procedure TfrmConfiguracoesAdvance.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  pSalvarConfs;
  Close;
end;

procedure TfrmConfiguracoesAdvance.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaAdvance.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesAdvance.Destroy;
begin
  fRollBack;
  if Assigned(frmConfConsultaAdvance) then FreeAndNil(frmConfConsultaAdvance);
  inherited Destroy;
end;

procedure TfrmConfiguracoesAdvance.FormCreate(Sender: TObject);
begin
  inherited;
  fStartTransaction;

  conf  := fGetConfTinta('ADV');
  tinta := fGetConsultaTinta('ADV');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'ADVANCE', 'USATIN', ''));
  conf.pInsereCodigo('COROB_', 'Utilizar formato corob', fArqIniTinta(0, 'ADVANCE', 'COROB_', ''));
  conf.pInsereCodigo('ADVTRA', 'Trava para valor de venda ADV_PRE', fArqIniTinta(0, 'ADVANCE', 'ADVTRA', ''));
  conf.pInsereCodigo('FATADV', 'Fator', fArqIniTinta(0, 'ADVANCE', 'FATADV', ''));
  conf.pInsereCodigo('NFMADV', 'Próximo código nova fórmula', fArqIniTinta(0, 'ADVANCE', 'NFMADV', ''));
  conf.pInsereCodigo('PATADV', 'Path para arquivo de fórmula', fArqIniTinta(0, 'ADVANCE', 'PATADV', ''));

  conf.pInsereCodigo('UTF8', 'Arquivo no formato UTF-8', 'S');
  conf.pInsereCodigo('QTDORI', 'Quantidade das formulações no arquivo Origem', '0');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfs;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaAdvance := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

procedure TfrmConfiguracoesAdvance.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN)
    and (Assigned(ActiveControl))
    and (Assigned(ActiveControl.Parent))
    and (ActiveControl.Parent is TRadioGroup)then
    SelectNext(ActiveControl, True, True)
  else
    inherited;
end;

function TfrmConfiguracoesAdvance.fValidaCampos(Sender: TWinControl;
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
      Else If fStrToFloat(edtFatAdv.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser maior que zero!',['OK']);
        Result := False;
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
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


end.
