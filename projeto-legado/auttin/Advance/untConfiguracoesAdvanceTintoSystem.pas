unit untConfiguracoesAdvanceTintoSystem;

interface

uses
  SysUtils, Classes, Controls, Forms, untPai, StdCtrls, ExtCtrls, Mask,
  EditFocus, strUtils, Uni, DirectoryEditFocus, ComCtrls, untIConsultaTinta,
  untIConfTinta, untConfConsulta, BitBtnLockedIncrem, AppEvnts, Menus,
  Buttons, QColorLabel, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesAdvanceTintoSystem = class(TfrmPai)
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
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    lblProdutoVenda: TLabel;
    edtProdutoGranel: TEditFocus;
    edtDescricaoProdutoGranel: TEditFocus;
    lblEmbalagemGranel: TLabel;
    edtEmbalagemGranel: TEditFocus;
    edtDescricaoEmbalagemGranel: TEditFocus;
    lblAcuAbs: TLabel;
    edtAcuAbs: TEditFocus;
    lblAcuAbsDes: TColorLabel;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label1: TLabel;
    edtApreve: TEditFocus;
    fraPatAdv: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEmbalagemGranelKeyPress(Sender: TObject; var Key: Char);
  private
    consulta: IConsultaTinta;
    conf: IConfTinta;
    frmConfConsultaAdvanceTintoSystem: TfrmConfConsulta;

    procedure pCarregarConfs;
    procedure pSalvarConfs;
    procedure CarregarDescricoes;
    { Private declarations }
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmConfiguracoesAdvanceTintoSystem: TfrmConfiguracoesAdvanceTintoSystem;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesAdvanceTintoSystem }

procedure TfrmConfiguracoesAdvanceTintoSystem.pCarregarConfs;
begin
  chkUsaAdv.Checked := conf.fGetBoolean('USATIN'); 
  edtTraAdv.Text := conf.fGet('TRAADT'); 
  edtFatAdv.Text := conf.fGet('FATADT');
  edtNfmAdv.Text := conf.fGet('NFMADT');
  fraPatAdv.edtDirectory.text := conf.fGet('PATADV'); 
  edtProdutoGranel.Text := conf.fGet('PROGRA');
  edtEmbalagemGranel.Text := conf.fGet('EMBGRA');
  edtAcuAbs.Text    := conf.fGet('ACUABS');
  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.pSalvarConfs;
begin
  conf.pSetBoolean('USATIN', chkUsaAdv.Checked);
  conf.pSet('TRAADT', edtTraAdv.Text);
  conf.pSet('FATADT', edtFatAdv.Text);
  conf.pSet('NFMADT', edtNfmAdv.Text);
  conf.pSet('PATADV', fraPatAdv.edtDirectory.text);

  conf.pSet('PROGRA', edtProdutoGranel.Text);
  conf.pSet('EMBGRA', edtEmbalagemGranel.Text);
  conf.pSet('ACUABS', edtAcuAbs.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaAdvanceTintoSystem.pSalvarConfs;
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
  begin
    pSalvarConfs;
    Close;
  end;
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaAdvanceTintoSystem.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.CarregarDescricoes;
begin
  edtDescricaoProdutoGranel.Text := fGetDescricaoProdutoTinta(edtProdutoGranel.Text);
  edtDescricaoEmbalagemGranel.Text := fGetDescricaoProdutoTinta(edtEmbalagemGranel.Text)
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.edtEmbalagemGranelKeyPress(Sender: TObject; var Key: Char);
Var
  qryCadIte : TUniQuery;
  arrSel: TConsultasArray;
begin
  qryCadIte := fCriaQuery;
  Try
    If fPesqItem(conIteSimples, Self, TEditFocus(Sender), nil, qryCadIte, key, arrSel) Then
    Begin
      CarregarDescricoes;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryCadIte);
  End;
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmConfConsultaAdvanceTintoSystem.Free;
end;

procedure TfrmConfiguracoesAdvanceTintoSystem.FormCreate(Sender: TObject);
begin
  inherited;

  consulta := fGetConsultaTinta('ADT');
  conf := fGetConfTinta('ADT');

  conf.pInsereCodigo('USATIN', 'Utilizar esta tinta de maquina', fArqIniTinta(0, 'AdvanceTintoSystem', 'USATIN', ''));
  conf.pInsereCodigo('TRAADT', 'Trava para valor de venda ADV_PRE', fArqIniTinta(0, 'AdvanceTintoSystem', 'ADVTRA', ''));
  conf.pInsereCodigo('FATADT', 'Fator', fArqIniTinta(0, 'AdvanceTintoSystem', 'FATADV', ''));
  conf.pInsereCodigo('NFMADT', 'Próximo código nova fórmula', fArqIniTinta(0, 'AdvanceTintoSystem', 'NFMADT', ''));
  conf.pInsereCodigo('PATADV', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'AdvanceTintoSystem', 'PATADV', ''));

  conf.pInsereCodigo('PROGRA', 'Produto à Granel', '');
  conf.pInsereCodigo('EMBGRA', 'Embalagem à Granel', '');
  conf.pInsereCodigo('ACUABS', 'Acumulado / Absoluto', '1');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfs;
  frmConfConsultaAdvanceTintoSystem := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;
  CarregarDescricoes;
end;

function TfrmConfiguracoesAdvanceTintoSystem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    CarregarDescricoes;
    
    If Sender = edtTraAdv Then
    Begin
      If fEmptyStr(edtTraAdv.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com a trava para o valor de venda', ['OK']);
        Result := False;
      End
      Else If not MatchStr(edtTraAdv.Text, ['VEN', 'CUS']) Then
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

    else if Sender = edtNfmAdv then
    begin
      if fEmptyStr(edtNfmAdv.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Próximo Código deve ser preenchido!', ['OK']);
        Result := False;
      end;
    end
    else if Sender = edtProdutoGranel then
    begin
      if fEmptyStr(edtProdutoGranel.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O produto para venda à Granel deve ser preenchido!', ['OK']);
        Result := False;
      end
      else if fEmptyStr(edtDescricaoProdutoGranel.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O produto para venda à Granel não é válido!', ['OK']);
        Result := False;
      end;
    end
    else if Sender = edtEmbalagemGranel then
    begin
      if fEmptyStr(edtEmbalagemGranel.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O produto embalagem à Granel deve ser preenchido!', ['OK']);
        Result := False;
      end
      else if fEmptyStr(edtDescricaoEmbalagemGranel.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O produto embalagem à Granel não é válido!', ['OK']);
        Result := False;
      end;
    end
    else if Sender = edtAcuAbs then
    begin
      if fEmptyStr(edtAcuAbs.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Valores da formulação deve ser preenchido!', ['OK']);
        Result := False;
      end
      else if not MatchStr(edtAcuAbs.Text, ['1', '2']) then
      begin
        fMensagem('ATENÇÃO!', 'O valor da formulação deve ser preenchido com 1 ou 2', ['OK']);
        Result := False;
      end;
    end

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


end.
