{**********************************************************}
{* O GRID FOI TROCADO PARA PODER COLOCAR AS CONFIGURACOES *}
{* NO PADRAO NOVO (CFGTIN), MAS POR ENQUANTO DEIXAR LENDO *}
{* AS CONFIGURACOES DO OPCOES INI, E SOMENTE MUDAR        *}
{* QUANDO PASSAR TODAS PARA O BANCO ELIMINANDO DE VEZ     *}
{* A NECESSIDADE DO ARQUIVO "opcoestinta.ini"             *}
{*******************************************************PH*}
unit untConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Menus, AppEvnts, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData,
  Uni, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, UniClientDataSet, cxCheckBox, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  untConstantes, Datasnap.DBClient, untILibTintaDllRelacao,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConfiguracoes = class(TfrmPaiSimples)
    pnlBotoesConf: TPanel;
    pnlRodape: TPanel;
    GroupBox1: TGroupBox;
    rdbBases: TRadioButton;
    rdbProdutos: TRadioButton;
    Label1: TLabel;
    cmbTabela: TComboBox;
    rdbTabelaCliente: TRadioButton;
    cdsConfs: TUniClientDataSet;
    dtsConfs: TDataSource;
    cdsConfsTINTA: TStringField;
    cdsConfsUSATIN: TStringField;
    dbgConfs: TcxGrid;
    dbgViewConfs: TcxGridDBTableView;
    dbgViewConfsUSATIN: TcxGridDBColumn;
    dbgViewConfsTINTA: TcxGridDBColumn;
    dbgLvlConfs: TcxGridLevel;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    dbgViewConfsTIPTIN: TcxGridDBColumn;
    cdsConfsTIPTIN: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure lsvTintasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdbProdutosClick(Sender: TObject);
    procedure rdbBasesClick(Sender: TObject);
    procedure rdbTabelaClienteClick(Sender: TObject);
    procedure dbgViewConfsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgViewConfsKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbTabelaChange(Sender: TObject);
  private
    qryConfs: TUniQuery;
    strPreGerAnt: String;
    strTabelaAnt: String;
    procedure pCarregarIni;
    procedure pCarregarBanco;
    function fRetCfgSis(strConf: String): String;
    procedure pGravaLOGCFG(strValAnt: String; strValAtu: String; strCodCfg: String);
    procedure pSalvarConfs;
    function fTabelaPrecoAtiva: Boolean;
    function fRetornaNomeTintaDLLDiretorio(strIdePro: String;
      libTintaDllRelacao: ILibTintaDllRelacao; stlTintasDllDir: TStringList): String;
    function fRetornaIdeProDLLDiretorio(const strNomeTinta: String;
      libTintaDllRelacao: ILibTintaDllRelacao; stlTintasDllDir: TStringList): String;
    { Private declarations }
  public
    destructor Destroy; override;
    { Public declarations }
  end;

const
  arrTintas: array[1..42] of array[1..2] of string = (
    ('Suvinil', 'Suvinil'),
    ('Lazzumix', 'Lazzumix'),
    ('Coral Imobiliária', 'Coral Imobiliaria'),
    ('Bautech', 'Bautech'),
    ('Qualyvinil', 'Qualyvinil'),
    ('Ciacollor', 'Ciacollor'),
// Comentado a pedido do Ronaldo.Não será mais usada.
//    ('Coral Industrial', 'Coral Industrial'),
    ('Brasimix Imobiliaria', 'Brasimix Imobiliaria'),
    ('Brasimix Automotiva', 'Brasimix Automotiva'),
    ('Lukscolor', 'Lukscolor'),
    ('PPG', 'PPG'),
    ('Starmix', 'Starmix'),
    ('Dacar', 'Dacar'),
    ('Renner Imobiliária', 'Renner Imobiliária'),
    ('Sherwin Williams', 'Sherwin Williams'),
    ('Futura', 'Futura'),
    ('Maza Imobiliária', 'Maza Imobiliária'),
    ('Color Pro', 'Color Pro'),
    ('Killing', 'Killing'),
    ('Salcomix', 'Salcomix'),
    ('Axalta', 'Axalta'),
    ('Eucatex Imobiliaria', 'Eucatex Imobiliaria'),
    ('Skymix Automotiva', 'Skymix Automotiva'),
    ('Farben Automotiva', 'Farben Automotiva'),
    ('Glasurit', 'Glasurit'),
    ('Advance', 'Advance'),
    ('Universo', 'Universo'),
    ('Produto Acabado', 'Produto Acabado'),
    ('Resicolor', 'Resicolor'),
    ('Anjo', 'Anjo'),
    ('Weg', 'Weg'),
    ('Maza Automotiva', 'Maza Automotiva'),
    ('Nexa Autocolor', 'Nexa Autocolor'),
    ('Alessi Imobiliária', 'Alessi Imobiliária'),
    ('Velutex Imobiliária', 'Velutex Imobiliária'),
    ('BrazilianColor Automotiva', 'BrazilianColor Automotiva'),
    ('Iquine', 'Iquine'),
    ('Liko', 'Liko'),
    ('Recoa', 'Recoa'),
    ('Global Color', 'Global Color'),
    ('Anjo Sintética', 'Anjo Sintética'),
    ('Renner Industrial', 'Renner Industrial'),
    ('Annetta', 'Annetta'));

  {***************************************************}
  {* TINTAS DESCONTINUADAS, NÃO SERÃO MAIS USADAS    *}
  {************************************************NC*}
    //('Autocolor', 'Autocolor'),
    //('ColorBraz Imobiliaria', 'ColorBraz Imobiliaria'),
    //('General', 'General'),
    //('Maza', 'Maza'),
    //('Wanda', 'Wanda'),
    //('Zynamix', 'Zynamix'),

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses untFuncoesSimples,  StrUtils, untFuncTinta, untITintasDeMaquina,
  untILibTintaFactory, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoes }

procedure TfrmConfiguracoes.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgConfs);
  pCarregarBanco;
  pCarregarIni;

  rdbBases.Checked := (fRetCfgSis('PREGER') = '0');
  rdbProdutos.Checked := (fRetCfgSis('PREGER') = '1');
  rdbTabelaCliente.Checked := not (rdbBases.Checked or rdbProdutos.Checked);

  cmbTabela.ItemIndex := StrToInt(fRetCfgSis('TABPRE')) - 1;

  cdsConfs.First;
  dbgViewConfsTINTA.Focused := True;

  strPreGerAnt := fRetCfgSis('PREGER');
  strTabelaAnt := fRetCfgSis('TABPRE');
end;

function TfrmConfiguracoes.fRetCfgSis(strConf: String): String;
Var
  qryConf: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT  SQL_NO_CACHE       ';
    strSQL := strSQL + '   SIS_CODCFG,              ';
    strSQL := strSQL + '   SIS_VALCFG              ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   CFGSIS                   ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   SIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   SIS_CODCFG = :CODCFG     ';

    qryConf := fCriaQuery();
    qryConf.Close;
    qryConf.SQL.Clear;
    qryConf.SQL.Add(strSQL);
    qryConf.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConf.ParamByName('CODCFG').AsString := 'CFG_' + strConf;
    qryConf.Open;
    qryConf.First;

    Result := qryConf.FieldByName('SIS_VALCFG').AsString;
  Finally
    If Assigned(qryConf) Then
      FreeAndNil(qryConf);
  End;
end;

function TfrmConfiguracoes.fRetornaNomeTintaDLLDiretorio(
  strIdePro: String; libTintaDllRelacao: ILibTintaDllRelacao;
  stlTintasDllDir: TStringList): String;
var
  intCont: Integer;
begin
  Result := '';
  For intCont := 0 To stlTintasDllDir.Count - 1 Do
  Begin
    If libTintaDllRelacao.fGetChaveTinta(stlTintasDllDir[intCont]) = strIdePro Then
      Result := libTintaDllRelacao.fGetNomeTinta(stlTintasDllDir[intCont])
  End;
end;

function TfrmConfiguracoes.fRetornaIdeProDLLDiretorio(
  const strNomeTinta: String;
  libTintaDllRelacao: ILibTintaDllRelacao;
  stlTintasDllDir: TStringList): String;
var
  intCont: Integer;
begin
  Result := '';
  For intCont := 0 To stlTintasDllDir.Count - 1 Do
  Begin
    If SameText(libTintaDllRelacao.fGetNomeTinta(stlTintasDllDir[intCont]), strNomeTinta) Then
    Begin
      Result := libTintaDllRelacao.fGetChaveTinta(stlTintasDllDir[intCont]);
      Exit;
    End;
  End;
end;

function TfrmConfiguracoes.fTabelaPrecoAtiva: Boolean;
var
  strTabelasPre: string;
  intContador: Integer;
begin
  Result := True;

  If (Not cmbTabela.Enabled) Then
    Exit;

  strTabelasPre := fCfgSis('TABPRC');
  If Length(strTabelasPre) < 7 Then
    strTabelasPre := strTabelasPre + StringOfChar('N',7-Length(strTabelasPre));

  For intContador := 1 To Length(strTabelasPre) Do
  Begin
    If intContador = StrToInt(cmbTabela.Text) Then
    Begin
      If (strTabelasPre[intContador] <> 'S') Then
      Begin
        Result := False;
        Break;
      End;
    End;
  End;
end;

procedure TfrmConfiguracoes.btnGravarConfClick(Sender: TObject);
var
  strPreGer: string;
begin
  inherited;

  If Not fTabelaPrecoAtiva Then
  Begin
    fMensagem('ATENÇÃO!', 'A Tabela de preço selecionada não está ativa no faturamento.' + #13#10 +
                          'Favor configurá - la e depois prosseguir.', ['&Ok']);
    pSetFocus(cmbTabela);
    Exit;
  End;

  if fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 2 then
  begin
    Exit;
  end;

  pSalvarConfs;

  if rdbBases.Checked then
    strPreGer := '0'
  else if rdbProdutos.Checked then
    strPreGer := '1'
  else
    strPreGer := '2';

  fAtuCfgSis('PREGER', strPreGer);
  fAtuCfgSis('TABPRE', cmbTabela.Text);

  If strPreGerAnt <> strPreGer Then
   pGravaLOGCFG(strPreGerAnt, strPreGer, 'CFG_PREGER');

  If strTabelaAnt <> cmbTabela.Text Then
    pGravaLOGCFG(strTabelaAnt, cmbTabela.Text, 'CFG_TABPRE');

  if rdbTabelaCliente.Checked then
  begin
    fMensagem('ATENÇÃO!', 'Opção "Tabela do Cliente": antes de utilizar essa opção, por favor, ' +
      'faça o seguinte teste: faça um orçamento/pedido com as tintas utilizadas.' + #13#10 +
      'Carregue o orçamento/pedido e altere a tabela de preços. Caso os preços não estejam ' +
      'corretos, por favor, entre em contato com a citel. Obrigado.', ['&Ok']);
  end;

  Close;
end;

procedure TfrmConfiguracoes.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfiguracoes.cmbTabelaChange(Sender: TObject);
begin
  inherited;
  If Not fTabelaPrecoAtiva Then
  Begin
    fMensagem('ATENÇÃO!', 'A Tabela de preço selecionada não está ativa no faturamento.' + #13#10 +
                          'Favor configurá - la e depois prosseguir.', ['&Ok']);
    pSetFocus(cmbTabela);
  End;
end;

procedure TfrmConfiguracoes.lsvTintasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) then
  begin
    btnSairConf.Click;
  end;
end;

procedure TfrmConfiguracoes.rdbProdutosClick(Sender: TObject);
begin
  inherited;
  cmbTabela.Enabled := True;
end;

procedure TfrmConfiguracoes.rdbBasesClick(Sender: TObject);
begin
  inherited;
  cmbTabela.Enabled := False;
end;

procedure TfrmConfiguracoes.rdbTabelaClienteClick(Sender: TObject);
begin
  inherited;
  cmbTabela.Enabled := False;
end;

procedure TfrmConfiguracoes.dbgViewConfsKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
  begin
    cdsConfs.Edit;
    cdsConfsUSATIN.AsString := IfThen(cdsConfsUSATIN.AsString = 'S', 'N', 'S');
    cdsConfs.Post;
  end;
end;

destructor TfrmConfiguracoes.Destroy;
begin
  if Assigned(qryConfs) then FreeAndNil(qryConfs);  
  inherited Destroy;
end;

procedure TfrmConfiguracoes.dbgViewConfsKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
    btnSairConf.Click;

end;


procedure TfrmConfiguracoes.pCarregarBanco;
var
  strSigla, strTipo: string;
  tintas: ITintasDeMaquina;
  //Tintas que estao no diretorio auttin\tintas mas nao serao carregadas
  stlTintasDllDir: TStringList;
  libTintaDllRelacao: ILibTintaDllRelacao;
  libTintaFactory: ILibTintaFactory;
begin
  qryConfs := nil;
  stlTintasDllDir := nil;
  Try
    Try
      tintas := fGetTintasdeMaquina;

      stlTintasDllDir := TStringList.Create;
      libTintaFactory := GetLibTintaFactory;
      libTintaFactory.GetTintaDLLDiretorio(stlTintasDllDir);

      libTintaDllRelacao := fGetLibTintaDLLRelacao;

      qryConfs := fCriaQuery(Self);
      qryConfs.SQL.Text := 'SELECT DISTINCT * FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_CODCFG = "USATIN" AND CFG_GRUCFG = "CONFIGURACOES"';
      qryConfs.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryConfs.Open;

      while not qryConfs.Eof do
      begin
        {***********************************************}
        {* RENNER INDUSTRIAL E ANNETTA -> MOSTRA COMO  *}
        {* INDUSTRIAL E O FUNCIONAMENTO É IGUAL        *}
        {* IMOBILIÁRIA                                 *}
        {********************************************NC*}
        If Pos(qryConfs.FieldByName('CFG_IDEPRO').AsString, 'REN_SPA_ANN_AJA_INT_LIK_ADT_SIN_PRT_ALV_') > 0 Then
          strTipo := 'Industrial'
        Else If (Pos( qryConfs.FieldByName('CFG_IDEPRO').AsString, tintas.fGetImobiliarias ) > 0) then
          strTipo := 'Imobiliária'
        else if (Pos( qryConfs.FieldByName('CFG_IDEPRO').AsString, tintas.fGetIndustriais) > 0) Then
          strTipo := 'Industrial'
        else
          strTipo := 'Automotiva';

        If (qryConfs.FieldByName('CFG_VALCFG').AsString = 'S') Then
        Begin
          if IsTintaExistente(qryConfs.FieldByName('CFG_IDEPRO').AsString) then
          begin
            strSigla := fRetornaNomeTinta(qryConfs.FieldByName('CFG_IDEPRO').AsString);
            if (strSigla <> '') and (not cdsConfs.Locate('TINTA', strSigla, [])) then
              cdsConfs.AppendRecord([strSigla, qryConfs.FieldByName('CFG_VALCFG').AsString, strTipo]);
          end;
        End
        Else
        Begin
          strSigla := fRetornaNomeTinta(qryConfs.FieldByName('CFG_IDEPRO').AsString, False);

          //Carrega o nome das dlls das tintas que estao no diretorio auttin\tintas
          //porem nao foram carregadas pelo sistema por conta do CFGTIN(USATIN = N)
          If fEmptyStr(strSigla) Then
            strSigla := fRetornaNomeTintaDLLDiretorio(
              qryConfs.FieldByName('CFG_IDEPRO').AsString, libTintaDllRelacao,
                stlTintasDllDir);

          if (strSigla <> '') and (not cdsConfs.Locate('TINTA', strSigla, [])) then
            cdsConfs.AppendRecord([strSigla, qryConfs.FieldByName('CFG_VALCFG').AsString, strTipo]);
        End;

        qryConfs.Next;
      end;
    Except
      on E: Exception do
      begin
        raise Exception.CreateFmt('%s: %s [IDEPRO: %s]', [E.ClassName, E.Message, qryConfs.FieldByName('CFG_IDEPRO').AsString]);
      end;
    End;
  Finally
    If Assigned(stlTintasDllDir) Then FreeAndNil(stlTintasDllDir);
  End;
end;

procedure TfrmConfiguracoes.pCarregarIni;
var
  intContador: Integer;
  strNome: string;
begin
  for intContador := 1 to Length(arrTintas) do
  begin
    strNome := (arrTintas[intContador][2]);

    If (strNome = 'Produto Acabado') Then
      cdsConfs.AppendRecord([strNome, fRetCfgSis('UPROAC')]);
  end;
end;

procedure TfrmConfiguracoes.pGravaLOGCFG(strValAnt, strValAtu,
  strCodCfg: String);
Var
  qryLogCfg: TUniQuery;
begin
  qryLogCfg  := fCriaQuery();
  qryLogCfg.Close;
  qryLogCfg.SQL.Clear;
  qryLogCfg.SQL.Add('SELECT * FROM LOGCFG WHERE FALSE');
  qryLogCfg.Open;

  qryLogCfg.Insert;
  qryLogCfg.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCFG', VS_strCodEmp);
  qryLogCfg.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
  qryLogCfg.FieldByName('LOG_HORALT').AsDateTime := fTime();
  qryLogCfg.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
  qryLogCfg.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
  qryLogCfg.FieldByName('LOG_EMPCFG').AsString   := VS_strCodEmp;
  qryLogCfg.FieldByName('LOG_CODCFG').AsString   := strCodCfg;
  qryLogCfg.FieldByName('LOG_VALANT').AsString   := strValAnt;
  qryLogCfg.FieldByName('LOG_VALATU').AsString   := strValAtu;
  qryLogCfg.Post;

  If Assigned(qryLogCfg) Then
    FreeAndNil(qryLogCfg);
end;

procedure TfrmConfiguracoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConfs);
end;

procedure TfrmConfiguracoes.pSalvarConfs;
var
  strIdePro: string;
  stlTintasDllDir: TStringList;
  libTintaDllRelacao: ILibTintaDllRelacao;
  libTintaFactory: ILibTintaFactory;
begin
  stlTintasDllDir := nil;
  cdsConfs.DisableControls;
  Try
    stlTintasDllDir := TStringList.Create;
    libTintaFactory := GetLibTintaFactory;
    libTintaFactory.GetTintaDLLDiretorio(stlTintasDllDir);
    libTintaDllRelacao := fGetLibTintaDLLRelacao;

    cdsConfs.First;
    while not cdsConfs.Eof do
    begin
      strIdePro := fGetTintasdeMaquina.fGetIdePro(cdsConfsTINTA.AsString);

      If fEmptyStr(strIdePro) Then
        strIdePro := fRetornaIdeProDLLDiretorio(cdsConfsTINTA.AsString, libTintaDllRelacao, stlTintasDllDir);

      Try
        Try
          If (not fEmptyStr(strIdePro)) and qryConfs.Locate('CFG_IDEPRO', VarArrayOf([strIdePro]), []) Then
          Begin
            qryConfs.Edit;
            qryConfs.FieldByName('CFG_VALCFG').AsString := cdsConfsUSATIN.AsString;
            qryConfs.Post;
          End
          else If qryConfs.Locate('CFG_IDEPRO', VarArrayOf([fRetornaSiglaTinta(AnsiUpperCase(cdsConfsTINTA.AsString))]), []) Then
          Begin
            qryConfs.Edit;
            qryConfs.FieldByName('CFG_VALCFG').AsString := cdsConfsUSATIN.AsString;
            qryConfs.Post;
          End
          Else If cdsConfsTINTA.AsString = 'Produto Acabado' Then
          Begin
            fAtuCfgSis('UPROAC', cdsConfsUSATIN.AsString);
          End
          Else
          Begin
            fArqIniTinta(1, AnsiUpperCase(cdsConfsTINTA.AsString), 'USATIN', cdsConfsUSATIN.AsString);
          End;
        Except
          on E: ExceptionTintaNaoDisponivel do
          begin
          end;

          on E: Exception do
          begin
            raise;
          end;
        End;
      Finally
        cdsConfs.Next;
      End;
    end;
  Finally
    cdsConfs.EnableControls;
    If Assigned(stlTintasDllDir) Then
      FreeAndNil(stlTintasDllDir);
  End;
end;

end.

