unit untConfiguracoesEucatex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, Uni, StrUtils, DBCtrls, DB,
  ComCtrls, untIConsultaTinta, untConfConsulta,  untIConfTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  DirectoryEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesEucatex = class(TfrmPai)
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtTraEuc: TEditFocus;
    edtFatEuc: TEditFocus;
    edtNfmEuc: TEditFocus;
    chkUsaEuc: TCheckBox;
    edtUniQuaDescri: TEditFocus;
    edtUniQuaUni: TEditFocus;
    edtUniGalDescri: TEditFocus;
    edtUniGalUni: TEditFocus;
    edtUniLatDescri: TEditFocus;
    edtUniLatUni: TEditFocus;
    edtUniQua: TEditFocus;
    edtUniGal: TEditFocus;
    edtUniLat: TEditFocus;
    chkUsaDbf: TCheckBox;
    chkManual: TCheckBox;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    rgTipoGeracao: TRadioGroup;
    Label8: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    fraPatEuc: TfraDirectoryEditFocus;
    procedure edtUniLatKeyPress(Sender: TObject; var Key: Char);
    procedure edtUniLatExit(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }

    frmConfConsultaEucatex: TfrmConfConsulta;
    consulta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
    function fValidaUnidade(strCodUni: String): Boolean;
//    function fValidaArquivos: Boolean;
    function fValidaPath: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesEucatex: TfrmConfiguracoesEucatex;

implementation

uses untFuncTinta, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesEucatex }

function TfrmConfiguracoesEucatex.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtTraEuc Then
    Begin
      If (fEmptyStr(edtTraEuc.Text)) Then
      Begin
        fMensagem('', 'Entre com a trava para o valor de venda!', ['OK']);
        Result := False;
      end
      Else If Pos(edtTraEuc.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtFatEuc) Then
    Begin

      If fEmptyStr(edtFatEuc.Text) Then
      Begin
        fMensagem('', 'Entre com um valor para trava!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(edtFatEuc.Text) <= 0.0 Then
      Begin
        fMensagem('', 'Fator da trava deve ser maior que zero!', ['OK']);
        Result := False;
      End;

    End

    Else If (Sender = edtNfmEuc) Then
    Begin

      If fEmptyStr(edtNfmEuc.Text) Then
      Begin
        fMensagem('' ,'Entre com o próximo código!', ['OK']);
        Result := False;
      End;

    End

    else if (Sender = edtDesOpe) then
    begin

      if fEmptyStr(edtDesOpe.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtDesOpe.Text) < 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end;

    end

    else if (Sender = edtApreve) then
    begin

      if fEmptyStr(edtApreve.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtApreve.Text) < 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end;

    end


    Else If (sender = fraPatEuc) Then
    Begin
      fraPatEuc.edtDirectory.text := AnsiReplaceStr(fraPatEuc.edtDirectory.text, '"', '');

      If Not fEmptyStr(fraPatEuc.edtDirectory.text) Then
      Begin
        Result := fValidaPath;
      End;
    End

    Else If (Sender = edtUniQua) or (Sender = edtUniLat) or (Sender = edtUniGal) Then
    Begin

      If (fEmptyStr(TEditFocus(Sender).Text)) Then
      Begin
        fMensagem('', 'A unidade Quarto deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If Not (fValidaUnidade(TEditFocus(Sender).Text)) Then
      Begin
        fMensagem('', 'A unidade não é válida!', ['OK']);
        Result := False;
      End;

    End;

  end;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmConfiguracoesEucatex.fValidaPath: Boolean;
var
  search_rec: TSearchRec;
begin
  Result := True;

  if not DirectoryExists(fraPatEuc.edtDirectory.text) then
  begin
    Result := False;
    fMensagem('ATENÇÃO', 'O caminho do path para o arquivo de fórmulas não existe !', ['OK']);
  end
  else if FindFirst(fraPatEuc.edtDirectory.text + '\*.' + IIF(rgTipoGeracao.ItemIndex = 0, 'xls', 'txt'), faAnyFile, search_rec) <> 0 then
  begin
    Result := False;
    fMensagem('ATENÇÃO', Format('Nenhum arquivo do tipo [%s] foi encontrado no diretório informado !', [IIF(rgTipoGeracao.ItemIndex = 0, 'xls', 'txt')]), ['OK']);
  end;
end;

function TfrmConfiguracoesEucatex.fValidaUnidade(
  strCodUni: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM CADUNI WHERE UNI_CODUNI = :CODUNI';
  qryGen.ParamByName('CODUNI').AsString := strCodUni;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmConfiguracoesEucatex.pCarregaArqIni;
begin
  conf := fGetConfTinta('EUC');

  chkUsaEuc.Checked := conf.fGetBoolean('USATIN');
  edtTraEuc.Text    := conf.fGet('EUCTRA');
  edtFatEuc.Text    := conf.fGet('EUCFAT');
  edtNfmEuc.Text    := conf.fGet('EUCNFM');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

//  fraPatEuc.DialogFiles.Text := conf.fGet('EUCPAT');
  fraPatEuc.edtDirectory.text    := conf.fGet('EUCPAT');
  edtUniGal.Text    := conf.fGet('EUCGAL');
  edtUniLat.Text    := conf.fGet('EUCLAT');
  edtUniQua.Text    := conf.fGet('EUCQUA');
  chkUsaDbf.Checked := conf.fGetBoolean('USADBF');
  chkManual.Checked := conf.fGetBoolean('EUCMAN');
  rgTipoGeracao.ItemIndex := conf.fGetInteger('TIPGER');

end;

procedure TfrmConfiguracoesEucatex.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesEucatex.pGravaArqIni;
begin
{
  fArqIniTinta(1, 'Eucatex Imobiliaria', 'USATIN', IfThen(chkUsaEuc.Checked, 'S', 'N'));
  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCTRA', edtTraEuc.Text);
  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCFAT', edtFatEUC.Text);
  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCNFM', edtNfmEuc.Text);

  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCPAT', fraPatEuc.edtDirectory.text);

  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCGAL', edtUniGal.Text);
  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCLAT', edtUniLat.Text);
  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCQUA', edtUniQua.Text);
  fArqIniTinta(1, 'USA_FORMUL', 'EUC', 'S');

  fArqIniTinta(1, 'Eucatex Imobiliaria', 'USADBF', IfThen(chkUsaDbf.Checked, 'S', 'N'));
  fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCMAN', IfThen(chkManual.Checked, 'S', 'N'));
}

  conf.pSetBoolean('USATIN', chkUsaEuc.Checked); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'USATIN', IfThen(chkUsaEuc.Checked, 'S', 'N'));
  conf.pSet('EUCTRA', edtTraEuc.Text); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCTRA', edtTraEuc.Text);
  conf.pSet('EUCFAT', edtFatEUC.Text); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCFAT', edtFatEUC.Text);
  conf.pSet('EUCNFM', edtNfmEuc.Text); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCNFM', edtNfmEuc.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  conf.pSet('EUCPAT', Trim(fraPatEuc.edtDirectory.text));//Trim(fraPatEuc.DialogFiles.Text)); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCPAT', fraPatEuc.edtDirectory.text);

  conf.pSet('EUCGAL', edtUniGal.Text); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCGAL', edtUniGal.Text);
  conf.pSet('EUCLAT', edtUniLat.Text); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCLAT', edtUniLat.Text);
  conf.pSet('EUCQUA', edtUniQua.Text); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCQUA', edtUniQua.Text);
  conf.pSet('USAFOR', 'S'); //fArqIniTinta(1, 'USA_FORMUL', 'EUC', 'S');

  conf.pSetBoolean('USADBF', chkUsaDbf.Checked); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'USADBF', IfThen(chkUsaDbf.Checked, 'S', 'N'));
  conf.pSetBoolean('EUCMAN', chkManual.Checked); //fArqIniTinta(1, 'Eucatex Imobiliaria', 'EUCMAN', IfThen(chkManual.Checked, 'S', 'N'));
  conf.pSetInteger('TIPGER', rgTipoGeracao.ItemIndex);

  frmConfConsultaEucatex.pSalvarConfs;
end;

procedure TfrmConfiguracoesEucatex.pRetDescUnidade(strCodUni: String;
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

procedure TfrmConfiguracoesEucatex.edtUniLatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqUnidade(Self, TEditFocus(Sender),
                        TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')),
                        TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')), Nil, key, arrSel) Then
    SelectNext(ActiveControl, True, True);
End;

procedure TfrmConfiguracoesEucatex.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaEucatex.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesEucatex.Destroy;
begin
  if Assigned(frmConfConsultaEucatex) then FreeAndNil(frmConfConsultaEucatex);
  inherited;
end;

procedure TfrmConfiguracoesEucatex.edtUniLatExit(Sender: TObject);
  var
    strDescri, strUnid: String;
begin
  inherited;
  pRetDescUnidade(TEditFocus(Sender).Text, strDescri, strUnid);
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')).Text := strDescri;
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')).Text := strUnid;
end;

procedure TfrmConfiguracoesEucatex.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      Close;
    End;
  End;
end;

procedure TfrmConfiguracoesEucatex.FormCreate(Sender: TObject);
begin
  inherited;
  conf     := fGetConfTinta('EUC');
  consulta := fGetConsultaTinta('EUC');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'Eucatex Imobiliaria', 'USATIN', ''));
  conf.pInsereCodigo('EUCTRA', 'Trava para valor de venda EUC_PRE', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCTRA', ''));
  conf.pInsereCodigo('EUCFAT', 'Fator', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCFAT', ''));
  conf.pInsereCodigo('EUCNFM', 'Próximo código nova Fórmula', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCNFM', ''));
  conf.pInsereCodigo('DESOPE', 'Despesa Operacional da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  conf.pInsereCodigo('EUCPAT', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCPAT', ''));
  conf.pInsereCodigo('EUCGAL', 'Unidade(Galão)', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCGAL', ''));
  conf.pInsereCodigo('EUCLAT', 'Unidade(Lata)', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCLAT', ''));
  conf.pInsereCodigo('EUCQUA', 'Unidade(Quarto)', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCQUA', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'EUC', 'S'));

  conf.pInsereCodigo('USADBF', 'Utilizar Base de Dados DBF', fArqIniTinta(0, 'Eucatex Imobiliaria', 'USADBF', ''));
  conf.pInsereCodigo('EUCMAN', 'Máquina Manual', fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCMAN', ''));
  conf.pInsereCodigo('TIPGER', 'Tipo da geração (Excel ou Txt)', '0');


  frmConfConsultaEucatex  := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmConfiguracoesEucatex.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  edtUniLatExit(edtUniGal);
  edtUniLatExit(edtUniLat);
  edtUniLatExit(edtUniQua);
  pSetFocus(chkUsaEuc);
end;
{
function TfrmConfiguracoesEucatex.fValidaArquivos: Boolean;
var
  strMensagem: string;
  strArquivo: string;
begin
  Result := True;
  strMensagem := '';
  for strArquivo in fraPatEuc.DialogFiles do
  begin
    if not FileExists(strArquivo) then
    begin
      strMensagem := strMensagem + strArquivo + #13#10;
    end;
  end;

  if not fEmptyStr(strMensagem) then
  begin
    Result := False;
    strMensagem := #13#10 + Trim(strMensagem);
    fMensagem('ATENÇÃO', Format('Os arquivos abaixo não existem [%s]', [strMensagem]), ['OK']);
  end;
end;
}

end.

