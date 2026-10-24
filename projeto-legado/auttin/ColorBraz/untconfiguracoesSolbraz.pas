unit untConfiguracoesSolbraz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, DBCtrls, DBEditFocus, Uni,
  ComCtrls, untIConsultaTinta, untConfConsulta,  untIConfTinta,
  BitBtnLockedIncrem, JvExMask, JvToolEdit, frxClass, frxExportCSVTestabilidade;

type
  TfrmConfiguracoesSolBraz = class(TfrmPai)
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
    edtTraSol: TEditFocus;
    edtFatSol: TEditFocus;
    edtNfmSol: TEditFocus;
    edtPatSol: TFilenameEditFocus;
    chkUsaSol: TCheckBox;
    edtUniQuaDescri: TEditFocus;
    edtUniQuaUni: TEditFocus;
    edtUniGalDescri: TEditFocus;
    edtUniGalUni: TEditFocus;
    edtUniLatDescri: TEditFocus;
    edtUniLatUni: TEditFocus;
    edtUniQua: TEditFocus;
    edtUniGal: TEditFocus;
    edtUniLat: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtUniQuaKeyPress(Sender: TObject; var Key: Char);
    procedure edtUniQuaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
  private
    { Private declarations }

    frmConfConsultaSolbraz: TfrmConfConsulta;
    consulta: IConsultaTinta ;
    conf: IConfTinta;
  public
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaUnidade(strCodUni: String): Boolean;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesSolBraz: TfrmConfiguracoesSolBraz;

implementation

uses Math, untFuncTinta, untFuncoesSimples, StrUtils, DB;

{$R *.dfm}

{ TfrmConfiguracoesSolbraz }

function TfrmConfiguracoesSolBraz.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtTraSol Then
    Begin
      If (fEmptyStr(edtTraSol.Text)) Then
      Begin
        fMensagem('', 'Entre com a trava para o valor de venda!', ['OK']);
        Result := False;
      end
      Else If Pos(edtTraSol.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtFatSol) Then
    Begin

      If fEmptyStr(edtFatSol.Text) Then
      Begin
        fMensagem('', 'Entre com um valor para trava!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(edtFatSol.Text) <= 0.0 Then
      Begin
        fMensagem('', 'Fator da trava deve ser maior que zero!', ['OK']);
        Result := False;
      End;

    End

    Else If (Sender = edtNfmSol) Then
    Begin

      If fEmptyStr(edtNfmSol.Text) Then
      Begin
        fMensagem('' ,'Entre com o próximo código!', ['OK']);
        Result := False;
      End;

    End

    Else If (sender = edtPatSol) Then
    Begin

      If fEmptyStr(edtPatSol.Text) Then
      Begin
        fMensagem('', 'Entre com o path para o arquivo!', ['OK']);
        Result := False;
      End

      Else If Not (FileExists(edtPatSol.Text)) Then
      Begin
        fMensagem('', 'O arquivo não existe!', ['OK']);
        Result := False;
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

procedure TfrmConfiguracoesSolBraz.pCarregaArqIni;
begin
{
  chkUsaSol.Checked := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'USATIN', '') = 'S';
  edtTraSol.Text    := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLTRA', '');
  edtFatSol.Text    := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLFAT', '');
  edtNfmSol.Text    := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLNFM', '');
  edtPatSol.Text    := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLPAT', '');
  edtUniGal.Text    := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLGAL', '');
  edtUniLat.Text    := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLLAT', '');
  edtUniQua.Text    := fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLQUA', '');
}

  chkUsaSol.Checked := conf.fGetBoolean('USATIN');
  edtTraSol.Text    := conf.fGet('SOLTRA');
  edtFatSol.Text    := conf.fGet('SOLFAT');
  edtNfmSol.Text    := conf.fGet('SOLNFM');
  edtPatSol.Text    := conf.fGet('SOLPAT');
  edtUniGal.Text    := conf.fGet('SOLGAL');
  edtUniLat.Text    := conf.fGet('SOLLAT');
  edtUniQua.Text    := conf.fGet('SOLQUA'); 

end;

procedure TfrmConfiguracoesSolBraz.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesSolBraz.pGravaArqIni;
begin
{
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'USATIN', IfThen(chkUsaSol.Checked, 'S', 'N'));
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLTRA', edtTraSol.Text);
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLFAT', edtFatSol.Text);
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLNFM', edtNfmSol.Text);
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLPAT', edtPatSol.Text);
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLGAL', edtUniGal.Text);
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLLAT', edtUniLat.Text);
  fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLQUA', edtUniQua.Text);

  fArqIniTinta(1, 'USA_FORMUL', 'COL', 'S');
}

  conf.pSetBoolean('USATIN', chkUsaSol.Checked);
  conf.pSet('SOLTRA', edtTraSol.Text);
  conf.pSet('SOLFAT', edtFatSol.Text);
  conf.pSet('SOLNFM', edtNfmSol.Text);
  conf.pSet('SOLPAT', edtPatSol.Text);
  conf.pSet('SOLGAL', edtUniGal.Text);
  conf.pSet('SOLLAT', edtUniLat.Text);
  conf.pSet('SOLQUA', edtUniQua.Text);

  conf.pSet('USAFOR', 'S');

  frmConfConsultaSolbraz.pSalvarConfs;
end;

procedure TfrmConfiguracoesSolBraz.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesSolBraz.FormCreate(Sender: TObject);
begin
  inherited;
  conf     := fGetConfTinta('COL');
  consulta := fGetConsultaTinta('COL');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'USATIN', ''));
  conf.pInsereCodigo('SOLTRA', 'Trava para valor de venda SOL_PRE', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLTRA', ''));
  conf.pInsereCodigo('SOLFAT', 'Fator', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLFAT', ''));
  conf.pInsereCodigo('SOLNFM', 'Fator', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLNFM', ''));
  conf.pInsereCodigo('SOLPAT', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLPAT', ''));
  conf.pInsereCodigo('SOLGAL', 'Unidade(Galão)', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLGAL', ''));
  conf.pInsereCodigo('SOLLAT', 'Unidade(lata)', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLLAT', ''));
  conf.pInsereCodigo('SOLQUA', 'Unidade(Quarto)', fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLQUA', ''));
  
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'COL', 'S'));

  frmConfConsultaSolbraz  := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmConfiguracoesSolBraz.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  edtUniQuaExit(edtUniGal);
  edtUniQuaExit(edtUniLat);
  edtUniQuaExit(edtUniQua);
  pSetFocus(chkUsaSol);
end;

procedure TfrmConfiguracoesSolBraz.edtUniQuaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadUni : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadUni := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;
    stlIndCampos := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	UNI_CODUNI AS "Código", ';
    strSQL := strSQL + ' 	UNI_DESUNI AS "Descrição", ';
    strSQL := strSQL + ' 	UNI_SIGUNI AS "Unidade", ';
    strSQL := strSQL + '  UNI_PESLIT AS "Peso Litro", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	CADUNI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	UNI_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlIndice.Add('UNI_CODUNI');
    stlIndice.Add('UNI_DESUNI');
    stlIndice.Add('UNI_SIGUNI');

    stlDescricao.Add('Código');
    stlDescricao.Add('Descrição');
    stlDescricao.Add('Unidade');

    stlIndCampos.Add('UNI_CODUNI');
    stlIndCampos.Add('UNI_DESUNI');
    stlIndCampos.Add('UNI_SIGUNI');

    utcRegistros.Limpar(Self.Name + 'CADUNI');
    If pConsultaComp(Self, qryCadUni, 'CADUNI', strSQL, stlIndice, stlDescricao) Then
    Begin

      TEditFocus(Sender).Text := qryCadUni.FieldByName('UNI_CODUNI').AsString;
      TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')).Text := qryCadUni.FieldByName('UNI_DESUNI').AsString;
      TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')).Text := qryCadUni.FieldByName('UNI_SIGUNI').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadUni);
  End;
end;

procedure TfrmConfiguracoesSolBraz.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaSolbraz.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesSolBraz.Destroy;
begin
  if Assigned(frmConfConsultaSolbraz) then FreeAndNil(frmConfConsultaSolbraz);  
  inherited;
end;

procedure TfrmConfiguracoesSolBraz.edtUniQuaExit(Sender: TObject);
  var
    strDescri, strUnid: String;
begin
  inherited;
  pRetDescUnidade(TEditFocus(Sender).Text, strDescri, strUnid);
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')).Text := strDescri;
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')).Text := strUnid;
end;

procedure TfrmConfiguracoesSolBraz.pRetDescUnidade(strCodUni: String;
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

function TfrmConfiguracoesSolBraz.fValidaUnidade(
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

end.

