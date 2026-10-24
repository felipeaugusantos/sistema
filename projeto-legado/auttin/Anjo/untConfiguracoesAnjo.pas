unit untConfiguracoesAnjo;

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
  TfrmConfiguracoesAnjo = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkUsaAnj: TCheckBox;
    edtTraAnj: TEditFocus;
    edtFatAnj: TEditFocus;
    edtNfmAnj: TEditFocus;
    tbsConfCampos: TTabSheet;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label8: TLabel;
    edtDesOpe: TEditFocus;
    Label9: TLabel;
    edtApreve: TEditFocus;
    fraPatAnj: TfraDirectoryEditFocus;
    fraPatAnj2: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaAnjo: TfrmConfConsulta;
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
  frmConfiguracoesAnjo: TfrmConfiguracoesAnjo;

implementation

uses untFuncoesSimples, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracoesAnjo }

procedure TfrmConfiguracoesAnjo.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  pSalvarConfs;
  Close;
end;

procedure TfrmConfiguracoesAnjo.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaAnjo.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesAnjo.Destroy;
begin
  if Assigned(frmConfConsultaAnjo) then FreeAndNil(frmConfConsultaAnjo);  
  inherited Destroy;
end;

procedure TfrmConfiguracoesAnjo.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('ANJ');
  tinta := fGetConsultaTinta('ANJ');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', '');
  conf.pInsereCodigo('ANJTRA', 'Trava para valor de venda ANJ_PRE', '');
  conf.pInsereCodigo('FATANJ', 'Fator', '');
  conf.pInsereCodigo('NFMANJ', 'Próximo código nova fórmula', '');
  conf.pInsereCodigo('PATANJ', 'Path para arquivo de fórmula ANJO1', '');
  conf.pInsereCodigo('ANJPAT', 'Path para arquivo de fórmula ANJO2', '');

  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfs;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaAnjo := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

function TfrmConfiguracoesAnjo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtTraAnj Then
    Begin
      If fEmptyStr(edtTraAnj.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com a trava para o valor de venda', ['OK']);
        Result := False;
      End
      Else If Pos(edtTraAnj.Text, '_VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtFatAnj Then
    Begin
      If fEmptyStr(edtFatAnj.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(edtFatAnj.Text) <= 0 Then
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

procedure TfrmConfiguracoesAnjo.pCarregarConfs;
begin
  conf := fGetConfTinta('ANJ');
  chkUsaAnj.Checked := conf.fGetBoolean('USATIN');
  edtTraAnj.Text    := conf.fGet('ANJTRA');
  edtFatAnj.Text    := conf.fGet('FATANJ');
  edtNfmAnj.Text    := conf.fGet('NFMANJ');
  fraPatAnj.edtDirectory.text    := conf.fGet('PATANJ');
  fraPatAnj2.edtDirectory.text   := conf.fGet('ANJPAT');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesAnjo.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesAnjo.pSalvarConfs;
begin
  conf.pSetBoolean('USATIN', chkUsaAnj.Checked);
  conf.pSet('ANJTRA', edtTraAnj.Text);
  conf.pSet('FATANJ', edtFatAnj.Text);
  conf.pSet('NFMANJ', edtNfmAnj.Text);
  conf.pSet('PATANJ', fraPatAnj.edtDirectory.text);
  conf.pSet('ANJPAT', fraPatAnj2.edtDirectory.text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaAnjo.pSalvarConfs;
end;

end.
