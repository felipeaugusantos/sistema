unit untConfiguracoesFarbenAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, DirectoryEditFocus, Shellapi,
  ComCtrls, ShellCtrls, Uni, untConfConsulta, untIConfTinta, Data.Db,
  untIConsultaTinta,  BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, QColorLabel;

type
  TfrmConfiguracoesFarbenAutomotiva = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    Label19: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    chkUsaTin: TCheckBox;
    edtProCod: TEditFocus;
    edtFarFat: TEditFocus;
    edtFarPre: TEditFocus;
    chkUsaFor: TCheckBox;
    edtProLT: TEditFocus;
    edtProGL: TEditFocus;
    edtProLTDes: TEditFocus;
    edtProGLDes: TEditFocus;
    edtProVen: TEditFocus;
    edtProVenDes: TEditFocus;
    edtProSP: TEditFocus;
    edtProCP: TEditFocus;
    edtProSPDes: TEditFocus;
    edtProCPDes: TEditFocus;
    edtProTb: TEditFocus;
    edtProTbDes: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label9: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    Label10: TLabel;
    edtProSY: TEditFocus;
    edtProSYDes: TEditFocus;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    btn1: TBitBtnLocked;
    edtUsuario: TEditFocus;
    edtSenha: TEditFocus;
    edtFarPat: TEditFocus;
    edtServidor: TEditFocus;
    edtPorta: TEditFocus;
    dlgOpen1: TOpenDialog;
    Label13: TLabel;
    edtAcuAbs: TEditFocus;
    ColorLabel4: TColorLabel;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit; strWhere : String = '');
    procedure FormShow(Sender: TObject);
    procedure edtProVenExit(Sender: TObject);
    procedure edtProVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure edtProSYExit(Sender: TObject);
    procedure edtProSYKeyPress(Sender: TObject; var Key: Char);
    procedure edtProLTExit(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaFarbenAutomotiva: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;
    function fRetNomProduto( strCodIte : String) : String;
  public
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pCarregaProduto(edtCod, edtDes: TEditFocus; blnEmbalagem : Boolean = false);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    destructor Destroy; override;
    { Public declarations }
  end;

Const
  strWhere = '((CADITE.ITE_PROEMB = ''S'') AND (CADITE.ITE_ITEATI = ''S''))';

var
  frmConfiguracoesFarbenAutomotiva: TfrmConfiguracoesFarbenAutomotiva;

implementation

uses untFuncTinta, StrUtils, untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesFarbenAutomotiva }

function TfrmConfiguracoesFarbenAutomotiva.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtFarPre) Then
    Begin
      If fEmptyStr(edtFarPre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtFarPre.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtFarPre.Text, 'VEN_CUS') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtFarFat) Then
    Begin
      If fEmptyStr(edtFarFat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFarFat.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtProCod) Then
    Begin
      If fEmptyStr(edtProCod.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O próximo código deve ser preenchido!', ['&Ok']);
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
    End

    Else If (Sender = edtAcuAbs) Then
    Begin
      if not (Pos(edtAcuAbs.Text, '12') > 0) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Só é permitido as opções 1 ou 2!', ['OK']);
      end;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesFarbenAutomotiva.pCarregaArqIni;
begin
  chkUsaTin.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');

  edtFarPre.Text := conf.fGet('FARPRE');
  edtFarPat.Text := conf.fGet('FARPAT');
  edtFarFat.Text := conf.fGet('FARFAT');
  edtProCod.Text := conf.fGet('PROCOD');
  edtProLT.Text  := conf.fGet('FARPLT');
  edtProGL.Text  := conf.fGet('FARPGL');
  edtProVen.Text := conf.fGet('FARPRO');
  edtProSP.Text  := conf.fGet('FARPSP');
  edtProCP.Text  := conf.fGet('FARPCP');
  edtProTb.Text  := conf.fGet('FARPTB');
  edtProSY.Text  := conf.fGet('FARPSY');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');
  edtAcuAbs.Text := conf.fGet('ACUABS');

  edtUsuario.text := conf.fGet('FARUSU');
  edtSenha.text   := conf.fGet('FARSEN');
  edtServidor.text:= conf.fGet('FARSER');
  edtPorta.text   := conf.fGet('FARPOR');

end;

procedure TfrmConfiguracoesFarbenAutomotiva.pCarregaProduto(edtCod, edtDes: TEditFocus; blnEmbalagem : Boolean = false);
begin
  If fEmptyStr(edtCod.Text) Then
    edtDes.Clear
  Else
  Begin
    If not (blnEmbalagem) Then
      edtDes.Text := untFuncoesSimples.fRetNomProduto(edtCod.Text)
    else
      edtDes.Text := fRetNomProduto(edtCod.Text);

    If fEmptyStr(edtDes.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&O k']);
      edtCod.Clear;
      pSetFocus(edtCod);
    End;
  End;
end;

function TfrmConfiguracoesFarbenAutomotiva.fRetNomProduto(strCodIte: String): String;
Var
  strSQL   : String;
  qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_DESITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ((CADITE.ITE_PROEMB = ''S'') AND (CADITE.ITE_ITEATI = ''S''))';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('ITE_DESITE').AsString
      Else
        Result := '';

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

procedure TfrmConfiguracoesFarbenAutomotiva.pGravaArqIni;
begin
  conf.pSetBoolean('USATIN', chkUsaTin.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('FARPRE', edtFarPre.Text);
  conf.pSet('FARPAT', edtFarPat.Text);
  conf.pSet('FARFAT', edtFarFat.Text);
  conf.pSet('PROCOD', edtProCod.Text);
  conf.pSet('FARPLT', edtProLT.Text);
  conf.pSet('FARPGL', edtProGL.Text);
  conf.pSet('FARPRO', edtProVen.Text);
  conf.pSet('FARPSP', edtProSP.Text);
  conf.pSet('FARPCP', edtProCP.Text);
  conf.pSet('FARPTB', edtProTb.Text);
  conf.pSet('FARPSY', edtProSy.Text);
  conf.pSet('FARUSU', edtUsuario.Text);
  conf.pSet('FARSEN', edtSenha.Text);
  conf.pSet('FARSER', edtServidor.text);
  conf.pSet('FARPOR', edtPorta.text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));
  conf.pSet('ACUABS', edtAcuAbs.Text);

  frmConfConsultaFarbenAutomotiva.pSalvarConfs;
end;

procedure TfrmConfiguracoesFarbenAutomotiva.btn1Click(Sender: TObject);
begin
  inherited;
  if (dlgOpen1.Execute) then
    edtFarPat.text := dlgOpen1.FileName;

end;

procedure TfrmConfiguracoesFarbenAutomotiva.btnGravarConfClick(
  Sender: TObject);
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

procedure TfrmConfiguracoesFarbenAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  tinta := fGetConsultaTinta('FAR');
  conf  := fGetConfTinta('FAR');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'Farben Automotiva', 'USATIN', 'S'));
  conf.pInsereCodigo('USAFOR', 'Usa formulação', fArqIniTinta(0, 'USA_FORMUL', 'FAR', 'S'));
  conf.pInsereCodigo('FARPRE', 'Trava para valor de venda FAR_PRE', fArqIniTinta(0, 'Farben Automotiva', 'FARPRE', ''));
  conf.pInsereCodigo('FARPAT', 'Path para os arquivos', fArqIniTinta(0, 'Farben Automotiva', 'FARPAT', ''));
  conf.pInsereCodigo('FARFAT', 'Fator', fArqIniTinta(0, 'Farben Automotiva', 'FARFAT', ''));
  conf.pInsereCodigo('PROCOD', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'Farben Automotiva', 'PROCOD', ''));
  conf.pInsereCodigo('FARPLT', 'Produto para embalagem (LT)', fArqIniTinta(0, 'Farben Automotiva', 'FARPLT', ''));
  conf.pInsereCodigo('FARPGL', 'Produto para embalagem (GL)', fArqIniTinta(0, 'Farben Automotiva', 'FARPGL', ''));
  conf.pInsereCodigo('FARPRO', 'Produto para venda', fArqIniTinta(0, 'Farben Automotiva', 'FARPRO', ''));
  conf.pInsereCodigo('FARPSP', 'Produto para embalagem (Lata)', fArqIniTinta(0, 'Farben Automotiva', 'FARPSP', ''));
  conf.pInsereCodigo('FARPCP', 'Produto para embalagem (Copo)', fArqIniTinta(0, 'Farben Automotiva', 'FARPCP', ''));
  conf.pInsereCodigo('FARPTB', 'Produto para embalagem (Tambor)', fArqIniTinta(0, 'Farben Automotiva', 'FARPTB', ''));
  conf.pInsereCodigo('FARPSY', 'Produto para embalagem (Spray)', fArqIniTinta(0, 'Farben Automotiva', 'FARPSY', ''));

  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  conf.pInsereCodigo('FARUSU', 'Usuário para conexão com banco de dados de importação', fArqIniTinta(0, 'Farben Automotiva', 'FARUSU', ''));
  conf.pInsereCodigo('FARSEN', 'Senha para conexão com banco de dados de importação', fArqIniTinta(0, 'Farben Automotiva', 'FARSEN', ''));
  conf.pInsereCodigo('FARSER', 'Servidor do banco de dados de importação', fArqIniTinta(0, 'Farben Automotiva', 'FARSER', ''));
  conf.pInsereCodigo('FARPOR', 'Porta de conexão com banco de dados de importação', fArqIniTinta(0, 'Farben Automotiva', 'FARPOR', ''));
  conf.pInsereCodigo('ACUABS', 'Valores de formulação', fArqIniTinta(0, 'Farben Automotiva', 'ACUABS', '1'));

  pCarregaArqIni;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaFarbenAutomotiva := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;


procedure TfrmConfiguracoesFarbenAutomotiva.pConsultaItem(edtItem, edtDesIte: TEdit; strWhere : String = '' );
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesFarbenAutomotiva.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesFarbenAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
  edtProLTDes.Text  := fRetNomProduto(edtProLT.Text);
  edtProGLDes.Text  := fRetNomProduto(edtProGL.Text);
  edtProVenDes.Text := untFuncoesSimples.fRetNomProduto(edtProVen.Text);
  edtProCPDes.Text  := fRetNomProduto(edtProCP.Text);
  edtProSPDes.Text  := fRetNomProduto(edtProSP.Text);
  edtProTbDes.Text  := fRetNomProduto(edtProTb.Text);
  edtProSyDes.Text  := fRetNomProduto(edtProSy.Text);
  pSetFocus(chkUsaTin);
end;


procedure TfrmConfiguracoesFarbenAutomotiva.edtProLTExit(Sender: TObject);
begin
  inherited;
  pCarregaProduto(TEditFocus(Sender), TEditFocus(FindComponent(TEditFocus(Sender).Name + 'Des')), true);
end;

procedure TfrmConfiguracoesFarbenAutomotiva.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaFarbenAutomotiva.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesFarbenAutomotiva.Destroy;
begin
  if Assigned(frmConfConsultaFarbenAutomotiva) then FreeAndNil(frmConfConsultaFarbenAutomotiva);  
  inherited;
end;

procedure TfrmConfiguracoesFarbenAutomotiva.edtProSYExit(Sender: TObject);
begin
  inherited;
  pCarregaProduto(TEditFocus(Sender), TEditFocus(FindComponent(TEditFocus(Sender).Name + 'Des')));
end;

procedure TfrmConfiguracoesFarbenAutomotiva.edtProSYKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    pConsultaItem(TEditFocus(Sender), TEditFocus(FindComponent(TEditFocus(Sender).Name + 'Des')), strWhere);
  End;
end;

procedure TfrmConfiguracoesFarbenAutomotiva.edtProVenExit(Sender: TObject);
begin
  inherited;
  pCarregaProduto(TEditFocus(Sender), TEditFocus(FindComponent(TEditFocus(Sender).Name + 'Des')));
end;

procedure TfrmConfiguracoesFarbenAutomotiva.edtProVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    pConsultaItem(TEditFocus(Sender), TEditFocus(FindComponent(TEditFocus(Sender).Name + 'Des')));
  End;
end;

end.

