unit untConfiguracoesMazaImobiliaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus, Uni,
  DirectoryEditFocus, AppEvnts, UniClientDataSet, strUtils, untConfConsulta,
  untFuncTinta, untIConfTinta, untIConsultaTinta, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesMazaImobiliaria = class(TfrmPaiSimples)
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
    chkUsaMzi: TCheckBox;
    edtTraMzi: TEditFocus;
    edtFatMzi: TEditFocus;
    edtNfmMzi: TEditFocus;
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
    edtApreve: TEditFocus;
    Label9: TLabel;
    edtDesOpe: TEditFocus;
    fraPatMzi: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtUniLatExit(Sender: TObject);
    procedure edtUniLatKeyPress(Sender: TObject; var Key: Char);
    procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaMazaImobiliaria: TfrmConfConsulta;
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
  frmConfiguracoesMazaImobiliaria: TfrmConfiguracoesMazaImobiliaria;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesMazaImobiliaria }

procedure TfrmConfiguracoesMazaImobiliaria.pAtualizaVariaveisGlobais;
begin


end;

procedure TfrmConfiguracoesMazaImobiliaria.pCarregaArqIni;
begin

  conf := fGetConfTinta('MZI');

  chkUsaMzi.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtTraMzi.Text    := conf.fGet('TRAMZI');
  edtFatMzi.Text    := conf.fGet('FATMZI');
  edtNfmMzi.Text    := conf.fGet('NFMMZI');
  fraPatMzi.edtDirectory.text    := conf.fGet('PATMZI');

  edtUniGal.Text    := conf.fGet('MZIGAL');
  edtUniLat.Text    := conf.fGet('MZILAT');
  edtUniQua.Text    := conf.fGet('MZIQUA');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesMazaImobiliaria.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesMazaImobiliaria.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA MazaImobiliaria NOVO            *}
  {**************************************AC*}

  conf.pSetBoolean('USATIN', chkUsaMzi.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('TRAMZI', edtTraMzi.Text);
  conf.pSet('FATMZI', edtFatMzi.Text);
  conf.pSet('NFMMZI', edtNfmMzi.Text);
  conf.pSet('PATMZI', fraPatMzi.edtDirectory.text);

  conf.pSet('MZIGAL', edtUniGal.Text);
  conf.pSet('MZILAT', edtUniLat.Text);
  conf.pSet('MZIQUA', edtUniQua.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));


  frmConfConsultaMazaImobiliaria.pSalvarConfs;
end;

procedure TfrmConfiguracoesMazaImobiliaria.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesMazaImobiliaria.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('MZI');
  tinta := fGetConsultaTinta('MZI');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', '');
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', 'S');
  conf.pInsereCodigo('TRAMZI', 'Trava para valor de venda MZI_PRE', '');
  conf.pInsereCodigo('FATMZI', 'Fator', '');
  conf.pInsereCodigo('NFMMZI', 'Próximo código nova fórmula', '');
  conf.pInsereCodigo('PATMZI', 'Path para arquivo de fórmulas', '');
  conf.pInsereCodigo('MZIGAL', 'Unidade (Galão)', '');
  conf.pInsereCodigo('MZILAT', 'Unidade (Lata)', '');
  conf.pInsereCodigo('MZIQUA', 'Unidade (Quarto)', '');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pgcDados.ActivePageIndex := 0;

  frmConfConsultaMazaImobiliaria  := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  edtUniLatExit(edtUniGal);
  edtUniLatExit(edtUniLat);
  edtUniLatExit(edtUniQua);
end;

procedure TfrmConfiguracoesMazaImobiliaria.FormShow(Sender: TObject);
Var
  strQuaDesc : String;
  strGalDesc : String;
  strLatDesc : String;

  strQuaUnid : String;
  strGalUnid : String;
  strLatUnid : String;
begin
  inherited;
  pCarregaArqIni;

  pRetDescUnidade(edtUniQua.Text , strQuaDesc, strQuaUnid);
  pRetDescUnidade(edtUniGal.Text , strGalDesc, strGalUnid);
  pRetDescUnidade(edtUniLat.Text , strLatDesc, strLatUnid);

  edtUniQuaDescri.Text := strQuaDesc;
  edtUniGalDescri.Text := strGalDesc;
  edtUniLatDescri.Text := strLatDesc;

  edtUniQuaUni.Text := strQuaUnid;
  edtUniGalUni.Text := strGalUnid;
  edtUniLatUni.Text := strLatUnid;

end;

function TfrmConfiguracoesMazaImobiliaria.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CAMPOS DA MazaImobiliaria               *}
    {**************************************MV*}
    If (Sender = edtTraMzi) Then
    Begin

      If fEmptyStr(edtTraMzi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraMzi.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraMzi.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatMzi) Then
    Begin

      If fEmptyStr(edtFatMzi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatMzi.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtNfmMzi) Then
    Begin

      If (fEmptyStr(edtNfmMzi.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = fraPatMzi) Then
    Begin
      If (fEmptyStr(fraPatMzi.edtDirectory.text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

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

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesMazaImobiliaria.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaMazaImobiliaria.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesMazaImobiliaria.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

destructor TfrmConfiguracoesMazaImobiliaria.Destroy;
begin
  if Assigned(frmConfConsultaMazaImobiliaria) then FreeAndNil(frmConfConsultaMazaImobiliaria);
  inherited;
end;

procedure TfrmConfiguracoesMazaImobiliaria.edtUniLatExit(Sender: TObject);
  var
    strDescri, strUnid: String;
begin
  inherited;
  pRetDescUnidade(TEditFocus(Sender).Text, strDescri, strUnid);
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')).Text := strDescri;
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')).Text := strUnid;
end;

procedure TfrmConfiguracoesMazaImobiliaria.edtUniLatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqUnidade(Self, TEditFocus(Sender),
                     TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')),
                     TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')), Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesMazaImobiliaria.pRetDescUnidade(strCodUni: String;
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
