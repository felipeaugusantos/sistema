unit untConfiguracoesBrasimixAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  FilenameEditFocus, StrUtils,  AppEvnts, QColorLabel,
  Uni, ComCtrls, untConfConsulta, untIConfTinta,
  untIConsultaTinta,  BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesBrasimixAutomotiva = class(TfrmPai)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    pgcGeral: TPageControl;
    tbsGeral: TTabSheet;
    tbsEmbalagens: TTabSheet;
    Label6: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    Label19: TLabel;
    edtDesProBza: TEditFocus;
    edtProBza: TEditFocus;
    chkUsaLaz: TCheckBox;
    edtTraBza: TEditFocus;
    edtFatBza: TEditFocus;
    edtGalBza: TEditFocus;
    edtEmbBza: TEditFocus;
    chkUsaFor: TCheckBox;
    edtNfmBza: TEditFocus;
    Label1: TLabel;
    Label17: TLabel;
    edtMarBza: TEditFocus;
    Label18: TLabel;
    ColorLabel4: TColorLabel;
    edtAcuAbs: TEditFocus;
    gpbGalao: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    edtDesBzaIgl: TEditFocus;
    edtBzaIgl: TEditFocus;
    edtDesBzaGla: TEditFocus;
    edtBzaGla: TEditFocus;
    edtDesBzaGpo: TEditFocus;
    edtBzaGpo: TEditFocus;
    edtDesBzaGpu: TEditFocus;
    edtBzaGpu: TEditFocus;
    edtDesBzaGpe: TEditFocus;
    edtBzaGpe: TEditFocus;
    gpbLitro: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtDesBzaIem: TEditFocus;
    edtBzaIem: TEditFocus;
    edtDesBzaLla: TEditFocus;
    edtBzaLla: TEditFocus;
    edtDesBzaLpo: TEditFocus;
    edtBzaLpo: TEditFocus;
    edtDesBzaLpu: TEditFocus;
    edtBzaLpu: TEditFocus;
    edtDesBzaLpe: TEditFocus;
    edtBzaLpe: TEditFocus;
    lblBzaCop: TLabel;
    edtBzaCop: TEditFocus;
    edtDesBzaCop: TEditFocus;
    lblBzaSpr: TLabel;
    edtBzaSpr: TEditFocus;
    edtDesBzaSpr: TEditFocus;
    tbsConfCampos: TTabSheet;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label21: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    edtPatBza: TFilenameEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBzaIglKeyPress(Sender: TObject; var Key: Char);
    procedure edtProBzaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure pgcGeralChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaBrasimixAutomotiva: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    function  fRetornaDescricaoItem(edtCodIte: TEdit): TEdit;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesBrasimixAutomotiva: TfrmConfiguracoesBrasimixAutomotiva;

implementation

uses  untFuncTinta, untFuncoesSimples, Math, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesBrasimixAutomotiva }

function TfrmConfiguracoesBrasimixAutomotiva.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDesIte: TEdit;
begin

  Result := True;

  If (Sender = edtProBza) Then
  Begin
    If (fEmptyStr(edtProBza.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      fRetornaDescricaoItem(edtProBza);
      If (fEmptyStr(edtDesProBza.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtTraBza) Then
  Begin
    If (fEmptyStr(edtTraBza.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraBza.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraBza.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtNfmBza) Then
  Begin
    If (fEmptyStr(edtNfmBza.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O próximo código Nova Fórmula deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtNfmBza.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O próximo código Nova Fórmula deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatBza) Then
  Begin
    If (fEmptyStr(edtFatBza.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatBza.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtEmbBza) Then
  Begin
    If (fEmptyStr(edtEmbBza.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtEmbBza.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtGalBza) Then
  Begin
    If (fEmptyStr(edtGalBza.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtGalBza.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtMarBza) Then
  Begin
    If (fEmptyStr(edtMarBza.Text)) Then
    Begin
      edtMarBza.Text := '0,00';
    End
    Else If fStrToFloat(edtMarBza.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A margem para cálculo do preço de custo deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtPatBza) Then
  Begin
    If (fEmptyStr(edtPatBza.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo TXT deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtPatBza.Text := fGetPath(edtPatBza.Text);
      If (RightStr(edtPatBza.Text, 1) = '\') Then
        edtPatBza.Text := Copy(edtPatBza.Text, 1, Length(edtPatBza.Text)-1);
    End;
  End

  Else If (Sender = edtBzaIgl) Or
          (Sender = edtBzaGla) Or
          (Sender = edtBzaGpo) Or
          (Sender = edtBzaGpu) Or
          (Sender = edtBzaGpe) Or
          (Sender = edtBzaIem) Or
          (Sender = edtBzaLla) Or
          (Sender = edtBzaLpo) Or
          (Sender = edtBzaLpu) Or
          (Sender = edtBzaLpe) Then
  Begin

    If TEdit(Sender).Visible Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Todos os itens devem ser preenchidos!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        edtDesIte := fRetornaDescricaoItem(TEdit(Sender));
        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End

  Else If (Sender = edtBzaCop) Or
          (Sender = edtBzaSpr) Then
  Begin
    If TEdit(Sender).Visible Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        edtDesIte := fRetornaDescricaoItem(TEdit(Sender));
        edtDesIte.Clear;
      End
      Else
      Begin
        edtDesIte := fRetornaDescricaoItem(TEdit(Sender));
        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End

  Else If (Sender = edtAcuAbs) Then
  Begin
    Result := (Pos(edtAcuAbs.Text, '12') > 0);

    If Result Then
    Begin
      blnMudarFoco := False;
      pgcGeral.ActivePage := tbsEmbalagens;
    End;
  End

  Else if (Sender = edtDesOpe) Then
  begin
    If fEmptyStr(edtDesOpe.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else if fStrToFloat(edtDesOpe.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else if (Sender = edtApreve) Then
  begin
    If fEmptyStr(edtApreve.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else if fStrToFloat(edtApreve.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End;


end;

procedure TfrmConfiguracoesBrasimixAutomotiva.pCarregaArqIni;
begin
{
  chkUsaLaz.Checked := (fArqIniTinta(0, 'Brasimix Automotiva', 'USATIN', '') = 'S');
  chkUsaFor.Checked := (fArqIniTinta(0, 'USA_FORMUL', 'BZA', 'S') = 'S');

  edtProBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'PROBZA', '');
  edtTraBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'TRABZA', '');
  edtFatBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'FATBZA', '');
  edtEmbBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'EMBBZA', '');
  edtGalBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'GALBZA', '');
  edtMarBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'MARBZA', '');
  edtPatBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'PATBZA', '');
  edtBzaIgl.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZAIGL', '');
  edtBzaGla.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGLA', '');
  edtBzaGpo.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPO', '');
  edtBzaGpu.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPU', '');
  edtBzaGpe.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPE', '');
  edtBzaIem.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZAIEM', '');
  edtBzaLla.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZALLA', '');
  edtBzaLpo.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPO', '');
  edtBzaLpu.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPU', '');
  edtBzaLpe.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPE', '');
  edtBzaCop.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZACOP', '');
  edtBzaSpr.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'BZASPR', '');
  edtAcuAbs.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'ACUABS', '1');
  edtNfmBza.Text := fArqIniTinta(0, 'Brasimix Automotiva', 'NFMBZA', '');
}

  conf := fGetConfTinta('BZA');

  chkUsaLaz.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');

  edtProBza.Text := conf.fGet('PROBZA');
  edtTraBza.Text := conf.fGet('TRABZA');
  edtFatBza.Text := conf.fGet('FATBZA');
  edtEmbBza.Text := conf.fGet('EMBBZA');
  edtGalBza.Text := conf.fGet('GALBZA');
  edtMarBza.Text := conf.fGet('MARBZA');
  edtPatBza.Text := conf.fGet('PATBZA');
  edtBzaIgl.Text := conf.fGet('BZAIGL');
  edtBzaGla.Text := conf.fGet('BZAGLA');
  edtBzaGpo.Text := conf.fGet('BZAGPO');
  edtBzaGpu.Text := conf.fGet('BZAGPU');
  edtBzaGpe.Text := conf.fGet('BZAGPE');
  edtBzaIem.Text := conf.fGet('BZAIEM');
  edtBzaLla.Text := conf.fGet('BZALLA');
  edtBzaLpo.Text := conf.fGet('BZALPO');
  edtBzaLpu.Text := conf.fGet('BZALPU');
  edtBzaLpe.Text := conf.fGet('BZALPE');
  edtBzaCop.Text := conf.fGet('BZACOP');
  edtBzaSpr.Text := conf.fGet('BZASPR');
  edtAcuAbs.Text := conf.fGet('ACUABS');
  edtNfmBza.Text := conf.fGet('NFMBZA');
  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');

  fRetornaDescricaoItem(edtProBza);
  fRetornaDescricaoItem(edtBzaIgl);
  fRetornaDescricaoItem(edtBzaGla);
  fRetornaDescricaoItem(edtBzaGpo);
  fRetornaDescricaoItem(edtBzaGpu);
  fRetornaDescricaoItem(edtBzaGpe);
  fRetornaDescricaoItem(edtBzaIem);
  fRetornaDescricaoItem(edtBzaLla);
  fRetornaDescricaoItem(edtBzaLpo);
  fRetornaDescricaoItem(edtBzaLpu);
  fRetornaDescricaoItem(edtBzaLpe);
  fRetornaDescricaoItem(edtBzaCop);
  fRetornaDescricaoItem(edtBzaSpr);
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA BRASIMIX AUTOMOTIVA    *}
  {**************************************MV*}
{
  If chkUsaLaz.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  strVenDin := IfThen(chkVenDin.Checked, 'S', 'N');

  strUsaFor := IIF(chkUsaFor.Checked, 'S', 'N');

  fArqIniTinta(1, 'Brasimix Automotiva', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'USA_FORMUL', 'BZA', strUsaFor);
  fArqIniTinta(1, 'Brasimix Automotiva', 'PROBZA', edtProBza.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'TRABZA', edtTraBza.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'FATBZA', edtFatBza.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'EMBBZA', edtEmbBza.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'GALBZA', edtGalBza.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'MARBZA', edtMarBza.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'PATBZA', edtPatBza.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZAIGL', edtBzaIgl.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZAGLA', edtBzaGla.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZAGPO', edtBzaGpo.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZAGPU', edtBzaGpu.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZAGPE', edtBzaGpe.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZAIEM', edtBzaIem.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZALLA', edtBzaLla.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZALPO', edtBzaLpo.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZALPU', edtBzaLpu.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZALPE', edtBzaLpe.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZACOP', edtBzaCop.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'BZASPR', edtBzaSpr.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'ACUABS', edtAcuAbs.Text);
  fArqIniTinta(1, 'Brasimix Automotiva', 'NFMBZA', edtNfmBza.Text);
}

  conf.pSetBoolean('USATIN', chkUsaLaz.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('PROBZA', edtProBza.Text);
  conf.pSet('TRABZA', edtTraBza.Text);
  conf.pSet('FATBZA', edtFatBza.Text);
  conf.pSet('EMBBZA', edtEmbBza.Text);
  conf.pSet('GALBZA', edtGalBza.Text);
  conf.pSet('MARBZA', edtMarBza.Text);
  conf.pSet('PATBZA', edtPatBza.Text);
  conf.pSet('BZAIGL', edtBzaIgl.Text);
  conf.pSet('BZAGLA', edtBzaGla.Text);
  conf.pSet('BZAGPO', edtBzaGpo.Text);
  conf.pSet('BZAGPU', edtBzaGpu.Text);
  conf.pSet('BZAGPE', edtBzaGpe.Text);
  conf.pSet('BZAIEM', edtBzaIem.Text);
  conf.pSet('BZALLA', edtBzaLla.Text);
  conf.pSet('BZALPO', edtBzaLpo.Text);
  conf.pSet('BZALPU', edtBzaLpu.Text);
  conf.pSet('BZALPE', edtBzaLpe.Text);
  conf.pSet('BZACOP', edtBzaCop.Text);
  conf.pSet('BZASPR', edtBzaSpr.Text);
  conf.pSet('ACUABS', edtAcuAbs.Text);
  conf.pSet('NFMBZA', edtNfmBza.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaBrasimixAutomotiva.pSalvarConfs;
end;

function TfrmConfiguracoesBrasimixAutomotiva.fRetornaDescricaoItem(edtCodIte: TEdit): TEdit;
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(fComponentByName(gpbGalao, strNomEdt));
  If Not Assigned(edtDesIte) Then
    edtDesIte := TEdit(fComponentByName(gpbLitro, strNomEdt));
    If Not Assigned(edtDesIte) Then
      edtDesIte := TEdit(fComponentByName(tbsEmbalagens, strNomEdt));
      If Not Assigned(edtDesIte) Then
        edtDesIte := TEdit(fComponentByName(tbsGeral, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
  Result := edtDesIte;
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.btnGravarConfClick(
  Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(chkUsaLaz);
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('BZA');
  tinta := fGetConsultaTinta('BZA');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'Brasimix Automotiva', 'USATIN', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'BZA', 'S'));
  conf.pInsereCodigo('PROBZA', 'Produto para venda', fArqIniTinta(0, 'Brasimix Automotiva', 'PROBZA', ''));
  conf.pInsereCodigo('TRABZA', 'Trava para valor de venda BZA_PRE', fArqIniTinta(0, 'Brasimix Automotiva', 'TRABZA', ''));
  conf.pInsereCodigo('FATBZA', 'Fator', fArqIniTinta(0, 'Brasimix Automotiva', 'FATBZA', ''));
  conf.pInsereCodigo('EMBBZA', 'Preço de embalagem', fArqIniTinta(0, 'Brasimix Automotiva', 'EMBBZA', ''));
  conf.pInsereCodigo('GALBZA', 'Preço de galão', fArqIniTinta(0, 'Brasimix Automotiva', 'GALBZA', ''));
  conf.pInsereCodigo('MARBZA', 'Fator para cálculo do preço de Custo', fArqIniTinta(0, 'Brasimix Automotiva', 'MARBZA', ''));
  conf.pInsereCodigo('PATBZA', 'Path para arquivo (BRASIMIX.TXT)', fArqIniTinta(0, 'Brasimix Automotiva', 'PATBZA', ''));
  conf.pInsereCodigo('BZAIGL', 'Produto embalagem SINTETICO (Galão)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZAIGL', ''));
  conf.pInsereCodigo('BZAGLA', 'Produto embalagem LACA (Galão)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGLA', ''));
  conf.pInsereCodigo('BZAGPO', 'Produto embalagem POLIESTER (Galão)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPO', ''));
  conf.pInsereCodigo('BZAGPU', 'Produto embalagem P. U. (Galão)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPU', ''));
  conf.pInsereCodigo('BZAGPE', 'Produto embalagem EPOXI (Galão)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPE', ''));
  conf.pInsereCodigo('BZAIEM', 'Produto embalagem SINTETICO (Litro)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZAIEM', ''));
  conf.pInsereCodigo('BZALLA', 'Produto embalagem LACA (Litro)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZALLA', ''));
  conf.pInsereCodigo('BZALPO', 'Produto embalagem POLIESTER (Litro)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPO', ''));
  conf.pInsereCodigo('BZALPU', 'Produto embalagem P. U. (Litro)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPU', ''));
  conf.pInsereCodigo('BZALPE', 'Produto embalagem EPOXI (Litro)', fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPE', ''));
  conf.pInsereCodigo('BZACOP', 'Produto embalagem Copo', fArqIniTinta(0, 'Brasimix Automotiva', 'BZACOP', ''));
  conf.pInsereCodigo('BZASPR', 'Produto embalagem Spray', fArqIniTinta(0, 'Brasimix Automotiva', 'BZASPR', ''));
  conf.pInsereCodigo('ACUABS', 'Valores da Formulação', fArqIniTinta(0, 'Brasimix Automotiva', 'ACUABS', '1'));
  conf.pInsereCodigo('NFMBZA', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'Brasimix Automotiva', 'NFMBZA', ''));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pgcGeral.ActivePageIndex := 0;
  frmConfConsultaBrasimixAutomotiva := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);

  edtPatBza.Dialog.Dialog.Filter := 'Arquivos Texto|*.txt|Todos os arquivos|*.*';
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  pgcGeral.ActivePage := tbsGeral;
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  inherited;
  Key := '/';
  if fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
End;

procedure TfrmConfiguracoesBrasimixAutomotiva.pgcGeralChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcGeral.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.edtBzaIglKeyPress(
  Sender: TObject; var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin

    edtDesEdt := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);

  End;

end;

procedure TfrmConfiguracoesBrasimixAutomotiva.edtProBzaKeyPress(
  Sender: TObject; var Key: Char);
begin
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProBza);
  End;
end;

procedure TfrmConfiguracoesBrasimixAutomotiva.btnRestaurarClick(
  Sender: TObject);
begin
  inherited;
  frmConfConsultaBrasimixAutomotiva.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesBrasimixAutomotiva.Destroy;
begin
  if Assigned(frmConfConsultaBrasimixAutomotiva) then FreeAndNil(frmConfConsultaBrasimixAutomotiva);  
  inherited;
end;

end.
