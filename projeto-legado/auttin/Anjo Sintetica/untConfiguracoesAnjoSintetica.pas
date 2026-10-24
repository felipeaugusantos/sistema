unit untConfiguracoesAnjoSintetica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, ComCtrls, untConfConsulta,
  untIConfTinta, untIConsultaTinta, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesAnjoSintetica = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkUsaAja: TCheckBox;
    edtTraAja: TEditFocus;
    edtFatAja: TEditFocus;
    edtNfmAja: TEditFocus;
    tbsConfCampos: TTabSheet;
    Label1: TLabel;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    fraPatAja: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaAnjoSintetica: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pCarregarConfs;
    procedure pSalvarConfs;

  public
    { Public declarations }
    destructor Destroy; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  end;

var
  frmConfiguracoesAnjoSintetica: TfrmConfiguracoesAnjoSintetica;

implementation

uses untFuncoesSimples,untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracoesAnjoSintetica }

procedure TfrmConfiguracoesAnjoSintetica.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  pSalvarConfs;
  Close;
end;

procedure TfrmConfiguracoesAnjoSintetica.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaAnjoSintetica.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesAnjoSintetica.Destroy;
begin
  if Assigned(frmConfConsultaAnjoSintetica) then FreeAndNil(frmConfConsultaAnjoSintetica);  
  inherited Destroy;
end;

procedure TfrmConfiguracoesAnjoSintetica.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('AJA');
  tinta := fGetConsultaTinta('AJA');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', '');
  conf.pInsereCodigo('AJATRA', 'Trava para valor de venda AJA_PRE', '');
  conf.pInsereCodigo('FATAJA', 'Fator', '');
  conf.pInsereCodigo('NFMAJA', 'Próximo código nova fórmula', '');
  conf.pInsereCodigo('PATAJA', 'Path para arquivo de fórmula ANJOSINTÉTICA1', '');
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfs;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaAnjoSintetica := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

function TfrmConfiguracoesAnjoSintetica.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtTraAja Then
    Begin
      If fEmptyStr(edtTraAja.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com a trava para o valor de venda', ['OK']);
        Result := False;
      End
      Else If Pos(edtTraAja.Text, '_VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtFatAja Then
    Begin
      If fEmptyStr(edtFatAja.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(edtFatAja.Text) <= 0 Then
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
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesAnjoSintetica.pCarregarConfs;
begin
  conf := fGetConfTinta('AJA');

  chkUsaAja.Checked := conf.fGetBoolean('USATIN');
  edtTraAja.Text    := conf.fGet('AJATRA');
  edtFatAja.Text    := conf.fGet('FATAJA');
  edtNfmAja.Text    := conf.fGet('NFMAJA');
  fraPatAja.edtDirectory.text    := conf.fGet('PATAJA');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesAnjoSintetica.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesAnjoSintetica.pSalvarConfs;
begin

  conf.pSetBoolean('USATIN', chkUsaAja.Checked);
  conf.pSet('AJATRA', edtTraAja.Text);
  conf.pSet('FATAJA', edtFatAja.Text);
  conf.pSet('NFMAJA', edtNfmAja.Text);
  conf.pSet('PATAJA', fraPatAja.edtDirectory.text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaAnjoSintetica.pSalvarConfs;
end;

end.
