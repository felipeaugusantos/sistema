unit untConfiguracoesFutura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus,
  DirectoryEditFocus, AppEvnts, Uni, strUtils, untConfConsulta,
  untIConfTinta, untIConsultaTinta, BitBtnLockedIncrem, JvExMask,
  JvToolEdit, frxClass, frxExportCSVTestabilidade;

type
  TfrmConfiguracoesFutura = class(TfrmPaiSimples)
    pnlBotoesConf: TPanel;
    pnlCabecalho: TPanel;
    tbsConfCampos: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    chkUsaFut: TCheckBox;
    edtTraFut: TEditFocus;
    edtFatFut: TEditFocus;
    edtNfmFut: TEditFocus;
    edtPatFut: TFilenameEditFocus;
    chkUsaFor: TCheckBox;
    edtUniQuaDescri: TEditFocus;
    edtUniQuaUni: TEditFocus;
    edtUniGalDescri: TEditFocus;
    edtUniGalUni: TEditFocus;
    edtUniLatDescri: TEditFocus;
    edtUniLatUni: TEditFocus;
    edtUniQua: TEditFocus;
    edtUniGal: TEditFocus;
    edtUniLat: TEditFocus;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label8: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtUniLatExit(Sender: TObject);
    procedure edtUniLatKeyPress(Sender: TObject; var Key: Char);
    procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaFutura: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesFutura: TfrmConfiguracoesFutura;

implementation

uses untFuncTinta,  untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesFutura }

procedure TfrmConfiguracoesFutura.pAtualizaVariaveisGlobais;
begin


end;

procedure TfrmConfiguracoesFutura.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA Futura              *}
  {**************************************MV*}
{
  chkUsaFut.Checked := (fArqIniTinta(0, 'FUTURA', 'USATIN', '') = 'S');
  chkUsaFor.Checked := (fArqIniTinta(0, 'USA_FORMUL', 'FUT', 'S') = 'S');
  edtTraFut.Text    := fArqIniTinta(0, 'FUTURA', 'TRAFUT', '');
  edtFatFut.Text    := fArqIniTinta(0, 'FUTURA', 'FATFUT', '');
  edtNfmFut.Text    := fArqIniTinta(0, 'FUTURA', 'NFMFUT', '');
  edtPatFut.Text    := fArqIniTinta(0, 'FUTURA', 'PATFUT', '');

  edtUniGal.Text    :=fArqIniTinta(0, 'FUTURA', 'FUTGAL', '');
  edtUniLat.Text    :=fArqIniTinta(0, 'FUTURA', 'FUTLAT', '');
  edtUniQua.Text    :=fArqIniTinta(0, 'FUTURA', 'FUTQUA', '');

}
  {*****************************************}
  {* CARREGA DADOS DA FUTURA NOVO          *}
  {**************************************AC*}

  chkUsaFut.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtTraFut.Text    := conf.fGet('TRAFUT');
  edtFatFut.Text    := conf.fGet('FATFUT');
  edtNfmFut.Text    := conf.fGet('NFMFUT');
  edtPatFut.Text    := conf.fGet('PATFUT');

  edtUniGal.Text    := conf.fGet('FUTGAL');
  edtUniLat.Text    := conf.fGet('FUTLAT');
  edtUniQua.Text    := conf.fGet('FUTQUA');


  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesFutura.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesFutura.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA FUTURA                 *}
  {**************************************MV*}
{
  If chkUsaFut.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  strUsaFor := IIF(chkUsaFor.Checked, 'S', 'N');

  fArqIniTinta(1, 'FUTURA', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'USA_FORMUL', 'FUT', strUsaFor);
  fArqIniTinta(1, 'FUTURA', 'TRAFUT', edtTraFut.Text);
  fArqIniTinta(1, 'FUTURA', 'FATFUT', edtFatFut.Text);
  fArqIniTinta(1, 'FUTURA', 'NFMFUT', edtNfmFut.Text);
  fArqIniTinta(1, 'FUTURA', 'PATFUT', edtPatFut.Text);

  fArqIniTinta(1, 'FUTURA', 'FUTGAL', edtUniGal.Text);
  fArqIniTinta(1, 'FUTURA', 'FUTLAT', edtUniLat.Text);
  fArqIniTinta(1, 'FUTURA', 'FUTQUA', edtUniQua.Text);

}
  {*****************************************}
  {* GRAVA DADOS DA FUTURA NOVO            *}
  {**************************************AC*}

  conf.pSetBoolean('USATIN', chkUsaFut.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('TRAFUT', edtTraFut.Text);
  conf.pSet('FATFUT', edtFatFut.Text);
  conf.pSet('NFMFUT', edtNfmFut.Text);
  conf.pSet('PATFUT', edtPatFut.Text);

  conf.pSet('FUTGAL', edtUniGal.Text);
  conf.pSet('FUTLAT', edtUniLat.Text);
  conf.pSet('FUTQUA', edtUniQua.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaFutura.pSalvarConfs;
end;

procedure TfrmConfiguracoesFutura.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesFutura.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('FUT');
  tinta := fGetConsultaTinta('FUT');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'FUTURA', 'USATIN', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'FUT', 'S'));
  conf.pInsereCodigo('TRAFUT', 'Trava para valor de venda FUT_PRE', fArqIniTinta(0, 'FUTURA', 'TRAFUT', ''));
  conf.pInsereCodigo('FATFUT', 'Fator', fArqIniTinta(0, 'FUTURA', 'FATFUT', ''));
  conf.pInsereCodigo('NFMFUT', 'Próximo código nova fórmula', fArqIniTinta(0, 'FUTURA', 'NFMFUT', ''));
  conf.pInsereCodigo('PATFUT', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'FUTURA', 'PATFUT', ''));
  conf.pInsereCodigo('FUTGAL', 'Unidade (Galão)', fArqIniTinta(0, 'FUTURA', 'FUTGAL', ''));
  conf.pInsereCodigo('FUTLAT', 'Unidade (Lata)', fArqIniTinta(0, 'FUTURA', 'FUTLAT', ''));
  conf.pInsereCodigo('FUTQUA', 'Unidade (Quarto)', fArqIniTinta(0, 'FUTURA', 'FUTQUA', ''));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaFutura    := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  edtUniLatExit(edtUniGal);
  edtUniLatExit(edtUniLat);
  edtUniLatExit(edtUniQua);
end;

function TfrmConfiguracoesFutura.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CAMPOS DA FUTURA               *}
    {**************************************MV*}
    If (Sender = edtTraFut) Then
    Begin

      If fEmptyStr(edtTraFut.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraFut.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraFut.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatFut) Then
    Begin

      If fEmptyStr(edtFatFut.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatFut.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtNfmFut) Then
    Begin

      If (fEmptyStr(edtNfmFut.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtPatFut) Then
    Begin
      If (fEmptyStr(edtPatFut.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

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

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesFutura.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaFutura.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesFutura.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

destructor TfrmConfiguracoesFutura.Destroy;
begin
  if Assigned(frmConfConsultaFutura) then FreeAndNil(frmConfConsultaFutura);
  inherited;
end;

procedure TfrmConfiguracoesFutura.edtUniLatExit(Sender: TObject);
  var
    strDescri, strUnid: String;
begin
  inherited;
  pRetDescUnidade(TEditFocus(Sender).Text, strDescri, strUnid);
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')).Text := strDescri;
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')).Text := strUnid;
end;

procedure TfrmConfiguracoesFutura.edtUniLatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqUnidade(Self, TEditFocus(Sender),
                        TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')),
                        TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')),
                        nil, Key,  arrSel, False, False, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesFutura.pRetDescUnidade(strCodUni: String;
  out strDescri, strUnid: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriarQuery('SELECT UNI_SIGUNI, UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = "' + strCodUni + '"', Self);
  qryGen.Open;

  strDescri := qryGen.FieldByName('UNI_DESUNI').AsString;
  strUnid := qryGen.FieldByName('UNI_SIGUNI').AsString;
  FreeAndNil(qryGen);
end;

end.
