unit untConfiguracoesWeg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, ComCtrls, untConfConsulta,
  untIConfTinta, untIConsultaTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesWeg = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkUsaWeg: TCheckBox;
    edtTraWeg: TEditFocus;
    edtFatWeg: TEditFocus;
    edtNfmWeg: TEditFocus;
    tbsConfCampos: TTabSheet;
    Label1: TLabel;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    fraPatWeg: TfraDirectoryEditFocus;
    chkUsaFor: TCheckBox;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaWeg: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pCarregarConfs;
    procedure pSalvarConfs;

  public
    destructor Destroy; override;
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  end;

var
  frmConfiguracoesWeg: TfrmConfiguracoesWeg;

implementation

uses untFuncTinta, untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesWeg }

procedure TfrmConfiguracoesWeg.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  pSalvarConfs;
  Close;
end;

procedure TfrmConfiguracoesWeg.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaWeg.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesWeg.Destroy;
begin
  if Assigned(frmConfConsultaWeg) then FreeAndNil(frmConfConsultaWeg);
  inherited;
end;

procedure TfrmConfiguracoesWeg.FormCreate(Sender: TObject);
begin
  inherited;

  tinta := fGetConsultaTinta('WEG');
  conf  := fGetConfTinta('WEG');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', '');
  conf.pInsereCodigo('WEGTRA', 'Trava para valor de venda WEG_PRE', '');
  conf.pInsereCodigo('FATWEG', 'Fator', '');
  conf.pInsereCodigo('NFMWEG', 'Próximo código nova fórmula', '');
  conf.pInsereCodigo('PATWEG', 'Path para arquivo de fórmula WEG', '');

  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfs;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaWeg := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

function TfrmConfiguracoesWeg.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtTraWeg Then
    Begin
      If fEmptyStr(edtTraWeg.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com a trava para o valor de venda', ['OK']);
        Result := False;
      End
      Else If Pos(edtTraWeg.Text, '_VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtFatWeg Then
    Begin
      If fEmptyStr(edtFatWeg.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(edtFatWeg.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser maior que zero!',['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDesOpe) Then
    Begin
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
    Begin
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

procedure TfrmConfiguracoesWeg.pCarregarConfs;
begin
  chkUsaWeg.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtTraWeg.Text    := conf.fGet('WEGTRA');
  edtFatWeg.Text    := conf.fGet('FATWEG');
  edtNfmWeg.Text    := conf.fGet('NFMWEG');
  fraPatWeg.edtDirectory.text    := conf.fGet('PATWEG');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesWeg.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesWeg.pSalvarConfs;
begin
  conf.pSetBoolean('USATIN', chkUsaWeg.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);

  conf.pSet('WEGTRA', edtTraWeg.Text);
  conf.pSet('FATWEG', edtFatWeg.Text);
  conf.pSet('NFMWEG', edtNfmWeg.Text);
  conf.pSet('PATWEG', fraPatWeg.edtDirectory.text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaWeg.pSalvarConfs;
end;

end.
