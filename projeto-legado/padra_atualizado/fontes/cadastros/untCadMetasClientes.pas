unit untCadMetasClientes;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, untTypesSistema,
  EditFocus, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, Mask, MaskEditFocus, untfuncoesSimples,
  Uni, untMetCli, AppEvnts, QColorLabel, DBCtrls, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons,
  untImportCadMetasClientes;

type
  TTipoArray = (Marca, Fornecedor, Grupo, Departamento);

  TfrmCadMetasClientes = class(TfrmPai)
    pnlCliVen: TPanel;
    edtCodCli: TEditFocus;
    dbgMetas: TDBGridCitel;
    dtsMetas: TDataSource;
    cdsMetas: TUniClientDataSet;
    cdsMetasDTAINI: TDateTimeField;
    cdsMetasDTAFIN: TDateTimeField;
    pnlMetas: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    edtCodMar: TEditFocus;
    edtValDes: TEditFocus;
    edtDesMar: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtValMet: TEditFocus;
    Label2: TLabel;
    cdsMetasDESMAR: TStringField;
    cdsMetasCODMAR: TStringField;
    cdsMetasVALMET: TFloatField;
    cdsMetasVALDES: TFloatField;
    cdsMetasCODCLI: TStringField;
    cdsMetasCODEMP: TStringField;
    cdsMetasAUTINC: TStringField;
    edtDesCli: TEditFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    edtDesGru: TEditFocus;
    lbl3: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    lbl4: TLabel;
    edtTipMet: TEditFocus;
    ColorLabel2: TColorLabel;
    mskLinGru: TMaskEditFocus;
    cdsMetasCODGRU: TStringField;
    cdsMetasCODFOR: TStringField;
    cdsMetasTIPMET: TStringField;
    cdsMetasDESGRU: TStringField;
    cdsMetasNOMFOR: TStringField;
    cdsMetasLITRAG: TFloatField;
    pnlRodape: TPanel;
    dbtxt1: TDBText;
    btnConfirmar: TBitBtnLocked;
    btnGerarCredito: TBitBtnLocked;
    btnCredRealizados: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    edtDesDep: TEditFocus;
    lblCodDep: TLabel;
    edtCodDep: TEditFocus;
    cdsMetasCODDEP: TStringField;
    cdsMetasDESDEP: TStringField;
    pnlClientes: TPanel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    dbgClientes: TDBGridCitel;
    popSelecao: TPopupMenu;
    mniMarcarTodos: TMenuItem;
    mniDesmarcarTodos: TMenuItem;
    mniInverterSelecao: TMenuItem;
    Label3: TLabel;
    cdsClientes: TUniClientDataSet;
    cdsClientesMARCA: TStringField;
    cdsClientesCODCLI: TStringField;
    cdsClientesNOMCLI: TStringField;
    imgLista: TImageList;
    dtsClientes: TDataSource;
    pgbProgresso: TProgressBar;
    pnlMarcacao: TPanel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnInverteSelecao: TBitBtnLocked;
    Label5: TLabel;
    edtPercHeranca: TEditFocus;
    btnHerdar: TBitBtnLocked;
    btnImportacao: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    Label7: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgMetasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnGerarCreditoClick(Sender: TObject);
    procedure btnCredRealizadosClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure dbgClientesTitleClick(Column: TColumn);
    procedure dbgClientesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure cdsClientesAfterScroll(DataSet: TDataSet);
    procedure dbgClientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mniMarcarTodosClick(Sender: TObject);
    procedure mniDesmarcarTodosClick(Sender: TObject);
    procedure mniInverterSelecaoClick(Sender: TObject);
    procedure btnHerdarClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnInverteSelecaoClick(Sender: TObject);
    procedure btnImportacaoClick(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure btnHlpImpClick(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure pAplicaMetaCliente(var arrDados : TConsultasArray; tarTipo : TTipoArray; strCodCli: String);
    function fUsaArray : Boolean;
  private
    { Private declarations }
    objMetCli: TMetCli;
    strMetasExcluidas: String;
    strCodCli, strCodVen, strCodRed: String;

    procedure pLimpaEdits(blnCliVen: Boolean = False; blnMarca: Boolean = False);
    procedure pCarregaItensAlteracao;
    function fCarregaMetasCliente(strCodCliMeta: String; blnVendedor, blnApenasCarregaMetas: Boolean): Boolean;
    function fConcatDesc(strCodMar, strCodGru, strCodFor, strCodDep: String): String;
    function fCarregaClientes(strCodCliAux: string; blnApenasCarregaMetas: Boolean; strVenRed: string = ''): Boolean;
    procedure pDesmarcaClientes;
    procedure pInverteSelecao;
    procedure pMarcaClientes;
    procedure pAplicaMetaGrid(strCodEmp, strCodCli, strCodMar, strCodDep,
          strDesMar, strCodGru, strCodFor, strTipMet: string; dteDtaIni,
          dteDtaFim: TDate; dblValMet, dblValDes: Double);
    procedure pHerdaMeta(strCodEmp, strCodCli: string; dteDtaIni,
          dteDtaFin: TDate; dblPercHeranca: Double);
    function fPossuiClienteSelecionado: Boolean;
    function fRetornaArrayDados : TConsultasArray;
    procedure pAplicaMetasClientesSelecionados;
  public
    { Public declarations }
    arrMarca,
    arrGrupos,
    arrFornec,
    arrDep,
    arrDados     : TConsultasArray;
    tarTipo : TTipoArray;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    procedure pEscapePressed; override;
  end;

implementation

uses SysUtils, Variants, Forms, untGeraCredCliente, untConsultas, untFuncoesRel, untFuncoesRel2,
  untFuncoesConsulta;

{$R *.dfm}

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmCadMetasClientes.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {***********************}
    {* VALIDA CLIENTE      *}
    {********************RL*}
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O cliente deve ser informado!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtDesCli.Text) Then
        Begin
          fMensagem('', 'Cliente não encontrado !', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          if (strCodCli <> edtCodCli.Text) then
            Result := fCarregaClientes(edtCodCli.Text, False);
        End;
      End;
    End
    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************RL*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser preenchida!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        Try
          StrToDate(mskDtaIni.Text);
        Except
          fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    {***********************}
    {* VALIDA DATA FINAL   *}
    {********************RL*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data final deve ser preenchida!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        Try
          If StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text) Then
          Begin
            fMensagem('ATENÇÃO!','A data final deve ser maior que a data incial!',['&Ok']);
            Result := False;
          End;
        Except
          fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    {***********************}
    {* VALIDA TIPO DE META *}
    {********************RV*}
    Else If (Sender = edtTipMet) Then
    Begin
      If fEmptyStr(edtTipMet.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Tipo de meta deve ser preenchida!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Pos(edtTipMet.Text, 'V_L_') = 0) Then
        Begin
          fMensagem('ATENÇÃO!','O Tipo de meta deve ser "V" ou "L" preenchida!',['&Ok']);
          Result := False;
        End;
      End;
    End
    {***********************}
    {* VALIDA META         *}
    {********************RL*}
    Else If (Sender = edtValMet) Then
    Begin
      If fEmptyStr(edtValMet.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O valor da meta deve ser preenchido!',['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtValMet.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O valor da meta deve ser maior que zero!',['&Ok']);
        Result := False;
      End;
    End
    {***********************}
    {* VALIDA DESCONTO     *}
    {********************RL*}
    {***********************************}
    {* DEIXA ZERAR O VALOR DO DESCONTO *}
    {* 10/03/2011 - 08:35 ***********DP*}
    Else If (Sender = edtValDes) Then
    Begin
      If fEmptyStr(edtValDes.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O valor do desconto deve ser preenchido!',['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtValDes.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!','O valor do desconto deve ser maior ou igual a zero!',['&Ok']);
        Result := False;
      End;
    End
    else if (Sender = edtCodVen) then
    begin
      Result := fCarregaClientes('', False, 'V');
    end

    else if (Sender = edtCodRed) then
    begin
      Result := fCarregaClientes('', False, 'R');
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasClientes.mniDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcaClientes;
end;

procedure TfrmCadMetasClientes.mniInverterSelecaoClick(Sender: TObject);
begin
  inherited;
  pInverteSelecao;
end;

procedure TfrmCadMetasClientes.mniMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaClientes;
end;

procedure TfrmCadMetasClientes.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrGrupos, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

{************************}
{* CONSULTA LINHA/GRUPO *}
{*********************RV*}
procedure TfrmCadMetasClientes.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrGrupos, fUsaArray) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{************************}
{* CONSULTA MARCA       *}
{*********************RV*}
procedure TfrmCadMetasClientes.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, fUsaArray) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasClientes.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRede: TConsultasArray;
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************DO*}
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRede) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasClientes.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
var
  arrVendedor: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVendedor) Then
    if fValidaCampos(edtCodVen, True) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCadMetasClientes.fConcatDesc(strCodMar, strCodGru,
  strCodFor, strCodDep: String): String;
var
  strDescri: String;
begin
  strDescri := '';

  If (fRetNomMarca(strCodMar) <> '') Then
    strDescri := fRetNomMarca(strCodMar);

  If (fRetNomeLinhaGrupo(strCodGru) <> '') Then
  Begin
    If (strDescri <> '') Then
      strDescri := strDescri + '-' + fRetNomeLinhaGrupo(strCodGru)
    Else
      strDescri := fRetNomeLinhaGrupo(strCodGru);
  End;

  If (fRetNomFornecedor(strCodFor) <> '') Then
  Begin
    If (strDescri <> '') Then
      strDescri := strDescri + '-' + fRetNomFornecedor(strCodFor)
    Else
      strDescri := fRetNomFornecedor(strCodFor);
  End;

  If (fRetDescDepartamento(strCodDep) <> '') Then
  Begin
    If (strDescri <> '') Then
      strDescri := strDescri + '-' + fRetDescDepartamento(strCodDep)
    Else
      strDescri := fRetDescDepartamento(strCodDep);
  End;

  If (strDescri = '') Then
    strDescri := 'REGRA GERAL';

  Result := strDescri;
end;

procedure TfrmCadMetasClientes.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca', 6);

end;

{*******************************************}
{* CONSULTA CLIENTE                        *}
{****************************************RL*}
procedure TfrmCadMetasClientes.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasClientes.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDep, fRetNomDep, nil, 'do departamento', 3);
end;

procedure TfrmCadMetasClientes.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep, fUsaArray) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{************************}
{* CONSULTA FORNECEDOR  *}
{*********************RV*}
procedure TfrmCadMetasClientes.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtDesFor, arrFornec, fRetNomFornecedor, nil, 'do fornecedor', 8);
end;

procedure TfrmCadMetasClientes.edtCodForKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec, fUsaArray) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasClientes.pAplicaMetaGrid(strCodEmp, strCodCli, strCodMar, strCodDep, strDesMar, strCodGru, strCodFor, strTipMet: string;
      dteDtaIni, dteDtaFim: TDate; dblValMet, dblValDes: Double);
begin
  with cdsMetas do
  begin
    if not Locate('CODMAR;CODGRU;CODFOR;TIPMET;CODDEP;DTAINI;DTAFIN', VarArrayOf([strCodMar, strCodGru, strCodFor, strTipMet, strCodDep, dteDtaIni, dteDtaFim]), []) Then
      Insert
    else
      Edit;

    FieldByName('CODCLI').AsString   := strCodCli;
    FieldByName('CODMAR').AsString   := strCodMar;
    FieldByName('CODDEP').AsString   := strCodDep;
    FieldByName('DESMAR').AsString   := strDesMar;
    FieldByName('DTAINI').AsDateTime := dteDtaIni;
    FieldByName('DTAFIN').AsDateTime := dteDtaFim;
    FieldByName('VALMET').AsFloat    := dblValMet;
    FieldByName('VALDES').AsFloat    := dblValDes;
    FieldByName('CODEMP').AsString   := strCodEmp;
    FieldByName('CODGRU').AsString   := strCodGru;
    FieldByName('CODFOR').AsString   := strCodFor;
    FieldByName('TIPMET').AsString   := strTipMet;
    Post;
  end;
end;

function TfrmCadMetasClientes.fPossuiClienteSelecionado: Boolean;
var
  intRecNo: Integer;
begin

  Result := False;
  cdsClientes.DisableControls;
  intRecNo := cdsClientes.RecNo;
  try
    cdsClientes.First;
    while not cdsClientes.Eof do
    begin
      if cdsClientesMARCA.AsString = 'S' then
      begin
        Result := True;
        Break;
      end;
      cdsClientes.Next
    end;
  finally
    cdsClientes.RecNo := intRecNo;
    cdsClientes.EnableControls;
  end;
end;

function TfrmCadMetasClientes.fRetornaArrayDados: TConsultasArray;
begin
  if Length(arrMarca) > 1 then
  begin
    Result := arrMarca;
    tarTipo := Marca;
    Exit;
  end;

  if Length(arrGrupos) > 1 then
  begin
    Result := arrGrupos;
    tarTipo := Grupo;
    Exit;
  end;

  if Length(arrFornec) > 1 then
  begin
    Result := arrFornec;
    tarTipo := Fornecedor;
    Exit;
  end;

  if Length(arrDep) > 1 then
  begin
    Result := arrDep;
    tarTipo := Departamento;
    Exit;
  end;
end;

function TfrmCadMetasClientes.fUsaArray: Boolean;
begin
  Result := False;
  if (Length(arrFornec) > 1) or
     (Length(arrMarca)> 1) or
     (Length(arrDep) > 1) or
     (Length(arrGrupos) > 1) then
    Result := True;
end;

procedure TfrmCadMetasClientes.btnAdicionarClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  inherited;

  If (fEmptyStr(cdsClientesCODCLI.AsString)) Then
  Begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  End;

  cdsClientes.DisableControls;
  intRecNo := cdsClientes.RecNo;

  Try
    If (Not fPossuiClienteSelecionado) Then
    Begin
      cdsClientes.RecNo := intRecNo;
      cdsClientes.EnableControls;
      fMensagem('ATENÇÃO!','Nenhum cliente foi selecionado!',['&Ok']);
      Exit;
    End;

    arrDados := fRetornaArrayDados;
    pAplicaMetasClientesSelecionados;
  Except
    On E: Exception Do
    Begin
      cdsMetas.Cancel;
      cdsClientes.RecNo := intRecNo;
      cdsClientes.EnableControls;
      pMensagensErro(E.Message,'[TfrmCadMetasClientes.btnAdicionarClick]');
    End;
  End;

  cdsClientes.RecNo := intRecNo;
  cdsClientes.EnableControls;
  pLimpaEdits(False, True);
end;

procedure TfrmCadMetasClientes.pAplicaMetasClientesSelecionados;
  Var
    cdsClone: TUniClientDataSet;
    strDesMar: String;
    strCodCli: String;
begin
  cdsClone := TUniClientDataSet.Create(Nil);

  Try
    pCloneDataSet(cdsClone, cdsClientes);
    cdsClone.Filter := ' MARCA = ''S'' ';
    cdsClone.Filtered := True;

    cdsClone.First;

    While (Not cdsClone.Eof) Do
    Begin
      strCodCli := cdsClone.FieldByName('CODCLI').AsString;

      If (Length(arrDados) > 1) Then
      Begin
        pAplicaMetaCliente(arrDados, tarTipo, strCodCli);
        cdsClone.Next;
        Continue;
      End;

      strDesMar := fConcatDesc(edtCodMar.Text, mskLinGru.Text, edtCodFor.Text, edtCodDep.Text);

      pAplicaMetaGrid(VS_strCodEmp,
                      strCodCli,
                      edtCodMar.Text,
                      edtCodDep.Text,
                      strDesMar,
                      mskLinGru.Text,
                      edtCodFor.Text,
                      edtTipMet.Text,
                      StrToDate(mskDtaIni.Text),
                      StrToDate(mskDtaFin.Text),
                      fStrToFloat(edtValMet.Text),
                      fStrToFloat(edtValDes.Text));

      cdsClone.Next;
    End;

  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmCadMetasClientes.FormCreate(Sender: TObject);
begin
  inherited;
  objMetCli := TMetCli.Create(Self);
  cdsMetas.CreateDataSet;
  cdsClientes.CreateDataSet;
  strCodCli := '';
  strCodVen := '';
  strCodRed := '';
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmCadMetasClientes.dbgMetasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnCancelar.Click
  End
  Else If (Key = VK_Return) And (Not cdsMetas.FieldByName('CODMAR').IsNull) Then
    pCarregaItensAlteracao
  Else If (Key = VK_Delete) Then
  Begin
    If (Not cdsMetas.FieldByName('CODMAR').IsNull) Then
    Try
      If Not fEmptyStr(cdsMetas.FieldByName('AUTINC').AsString) Then
        strMetasExcluidas := strMetasExcluidas + QuotedStr(cdsMetas.FieldByName('AUTINC').AsString) + ',';
      cdsMetas.Delete;
      pSetFocus(dbgMetas);
      If cdsMetas.IsEmpty Then
        pSetFocus(edtCodMar);
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadMetasClientes.dbgMetasKeyDown]');
    End;
  End;
end;

procedure TfrmCadMetasClientes.dbgClientesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Column.Field = cdsClientesMARCA then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    if cdsClientesMARCA.AsString = 'S' then
      imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left +1, Rect.Top + 1, 1)
    else if cdsClientesMARCA.AsString = 'N' then
      imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left +1, Rect.Top + 1, 0);
  end;
end;

procedure TfrmCadMetasClientes.dbgClientesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    if not(cdsClientes.State in [dsInsert, dsEdit]) then
      cdsClientes.Edit;
    cdsClientesMARCA.AsString := IIF(cdsClientesMARCA.AsString = 'S', 'N', 'S');
    cdsClientes.Post;
  end;
end;

procedure TfrmCadMetasClientes.dbgClientesTitleClick(Column: TColumn);
var
  pntCoord: TPoint;
begin
  inherited;

  if Column.FieldName = 'MARCA' then
  begin
    GetCursorPos(pntCoord);
    popSelecao.Popup(pntCoord.X, pntCoord.Y);
  end;
end;

procedure TfrmCadMetasClientes.pLimpaEdits(blnCliVen: Boolean = False;
  blnMarca: Boolean = False);
begin
  If blnCliVen Then
  Begin
    edtCodCli.Clear;
    edtDesCli.Clear;
    edtCodVen.Clear;
    edtDesVen.Clear;
    edtCodRed.Clear;
    edtDesRed.Clear;
    pSetFocus(edtCodCli);
    strCodCli := '';
    strCodVen := '';
    strCodRed := '';
  End
  Else If blnMarca Then
  Begin
    edtCodMar.Clear;
    edtDesMar.Clear;
    mskLinGru.Clear;
    edtDesGru.Clear;
    edtCodFor.Clear;
    edtDesFor.Clear;
    edtTipMet.Text := 'V';
    edtValMet.Text := '0,00';
    edtValDes.Text := '0,00';
    edtCodDep.Clear;
    edtDesDep.Clear;
    pSetFocus(edtCodMar);
  End;
  If (blnCliVen And blnMarca) Then
    strMetasExcluidas := '';
end;

procedure TfrmCadMetasClientes.btnCancelarClick(Sender: TObject);
begin
  inherited;
  cdsMetas.Cancel;
  pLimpaEdits(False, True);
end;

procedure TfrmCadMetasClientes.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlMetas) And ((edtCodMar.Focused) Or (mskDtaIni.Focused) Or (mskDtaFin.Focused)) Then
  Begin
    btnCancelar.Click;
    pSetFocus(edtCodCli);
  End
  Else If (ActiveControl.Parent = pnlCliVen) And (Not fEmptyStr(edtCodCli.Text)) Then
  Begin
    pLimpaEdits(True);
    cdsMetas.EmptyDataSet;
  End
  Else
    inherited;
end;

procedure TfrmCadMetasClientes.pAplicaMetaCliente(Var arrDados: TConsultasArray; tarTipo: TTipoArray; strCodCli: String);
  Var
    intConta: Integer;
    fltValor: Double;
    edtCodigo: TEditFocus;
    mskCodGru: TMaskEditFocus;
    strDesMar: String;
begin
  edtCodigo := Nil;
  mskCodGru := Nil;

  fltValor := fStrToFloat(edtValMet.Text) / length(arrDados);

  Case tarTipo Of
    Marca        : edtCodigo := edtCodMar;
    Fornecedor   : edtCodigo := edtCodFor;
    Grupo        : mskCodGru := mskLinGru;
    Departamento : edtCodigo := edtCodDep;
  End;


  For intConta := 0 To Length(arrDados)-1 Do
  Begin
    If (tarTipo <> Grupo) Then
      edtCodigo.Text := arrDados[intConta].strCodigo
    Else
      mskCodGru.Text := arrDados[intConta].strCodigo;

    strDesMar := fConcatDesc(arrDados[intConta].strCodigo , mskLinGru.Text, edtCodFor.Text, edtCodDep.Text);

    pAplicaMetaGrid(VS_strCodEmp,
                    strCodCli,
                    edtCodMar.Text,
                    edtCodDep.Text,
                    strDesMar,
                    mskLinGru.Text,
                    edtCodFor.Text,
                    edtTipMet.Text,
                    StrToDate(mskDtaIni.Text),
                    StrToDate(mskDtaFin.Text),
                    fltValor,
                    fStrToFloat(edtValDes.Text));
  End;
end;

{*******************************************}
{* CARREGA ITENS DA GRID PARA ALTERAÇÃO    *}
{****************************************RL*}

procedure TfrmCadMetasClientes.pCarregaItensAlteracao;
begin
  With cdsMetas Do
  Begin
    mskDtaIni.Text := FieldByName('DTAINI').AsString;
    mskDtaFin.Text := FieldByName('DTAFIN').AsString;
    edtCodMar.Text := FieldByName('CODMAR').AsString;
    edtCodDep.Text := FieldByName('CODDEP').AsString;
    edtDesMar.Text := FieldByName('DESMAR').AsString;
    mskLinGru.Text := FieldByName('CODGRU').AsString;
    edtDesGru.Text := FieldByName('DESGRU').AsString;
    edtCodFor.Text := FieldByName('CODFOR').AsString;
    edtDesFor.Text := FieldByName('NOMFOR').AsString;
    edtTipMet.Text := FieldByName('TIPMET').AsString;
    edtDesDep.Text := FieldByName('DESDEP').AsString;
    edtValMet.Text := FloatToStrF(FieldByName('VALMET').AsFloat, ffFixed, 12, 2);
    edtValDes.Text := FloatToStrF(FieldByName('VALDES').AsFloat, ffFixed, 12, 2);
    pSetFocus(mskDtaIni);
  End;
end;

function  TfrmCadMetasClientes.fCarregaMetasCliente(strCodCliMeta: String; blnVendedor, blnApenasCarregaMetas: Boolean): Boolean;
begin
  Result := True;
  Try
    strMetasExcluidas := '';
    if blnApenasCarregaMetas then
    begin
      while not cdsMetas.Eof do
        cdsMetas.Delete;
    end
    else
    begin
      if not blnVendedor then
        cdsMetas.EmptyDataSet;
    end;
    objMetCli.pCarregaMetCli(strCodCliMeta);
    If (objMetCli.qryMetCli.RecordCount > 0) Then
    Begin
      With objMetCli.qryMetCli Do
      Begin
        While Not Eof Do
        begin
          cdsMetas.Insert;
          cdsMetas.FieldByName('CODCLI').AsString   := FieldByName('MCL_CODCLI').AsString;
          cdsMetas.FieldByName('CODMAR').AsString   := FieldByName('MCL_CODMAR').AsString;
          cdsMetas.FieldByName('CODDEP').AsString   := FieldByName('MCL_CODDEP').AsString;
          cdsMetas.FieldByName('DESMAR').AsString   := fConcatDesc(FieldByName('MCL_CODMAR').AsString, FieldByName('MCL_CODGRU').AsString, FieldByName('MCL_CODFOR').AsString, FieldByName('MCL_CODDEP').AsString);
          cdsMetas.FieldByName('DTAINI').AsDateTime := FieldByName('MCL_DTAINI').AsDateTime;
          cdsMetas.FieldByName('DTAFIN').AsDateTime := FieldByName('MCL_DTAFIN').AsDateTime;
          cdsMetas.FieldByName('VALMET').AsFloat    := FieldByName('MCL_VALMET').AsFloat;
          cdsMetas.FieldByName('VALDES').AsFloat    := FieldByName('MCL_VALDES').AsFloat;
          cdsMetas.FieldByName('LITRAG').AsFloat    := FieldByName('MCL_LITRAG').AsFloat;
          cdsMetas.FieldByName('CODEMP').AsString   := FieldByName('MCL_CODEMP').AsString;
          cdsMetas.FieldByName('AUTINC').AsString   := FieldByName('AUTOINCREM').AsString;
          cdsMetas.FieldByName('CODGRU').AsString   := FieldByName('MCL_CODGRU').AsString;
          cdsMetas.FieldByName('DESGRU').AsString   := fRetNomeLinhaGrupo(FieldByName('MCL_CODGRU').AsString);
          cdsMetas.FieldByName('CODFOR').AsString   := FieldByName('MCL_CODFOR').AsString;
          cdsMetas.FieldByName('NOMFOR').AsString   := fRetNomFornecedor(FieldByName('MCL_CODFOR').AsString);
          cdsMetas.FieldByName('TIPMET').AsString   := FieldByName('MCL_TIPMET').AsString;
          cdsMetas.FieldByName('DESDEP').AsString   := fRetDescDepartamento(FieldByName('MCL_CODDEP').AsString);
          cdsMetas.Post;
          Next;
        End;
      End;
      cdsMetas.First;
    End;
  Except
    Result := False;
  End;
end;

procedure TfrmCadMetasClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) And (btnConfirmar.Enabled) Then
  Begin
    Key := 0;
    btnConfirmar.Click;
  End
  Else If (Key = VK_F9) And ((ActiveControl) = dbgMetas) Then
    btnGerarCredito.Click
  Else If (Key = VK_F8) Then
    btnCredRealizados.Click;
end;

procedure TfrmCadMetasClientes.FormShow(Sender: TObject);
begin
  inherited;
end;

{*******************************************}
{* CADASTRA METAS                          *}
{****************************************RL*}
procedure TfrmCadMetasClientes.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(cdsClientesCODCLI.AsString) then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  end;

  if not fPossuiClienteSelecionado then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi selecionado!',['&Ok']);
    Exit;
  end;

  with cdsMetas do
  try
    fStartTransaction;
    if not fEmptyStr(strMetasExcluidas) then
    begin
      strMetasExcluidas := Copy(strMetasExcluidas, 1, Length(strMetasExcluidas) - 1);
      objMetCli.pDeletaMetCli(strMetasExcluidas);
    end;

    pgbProgresso.Position := 0;
    pgbProgresso.Max := cdsClientes.RecordCount;

    cdsClientes.First;
    while not cdsClientes.Eof do
    begin
      if cdsClientesMARCA.AsString = 'S' then
      begin
        First;
        objMetCli.pCarregaMetCli(cdsClientesCODCLI.AsString);
        while not Eof do
        begin
          objMetCli.pGravaMetCli(cdsClientesCODCLI.AsString,
                                 FieldByName('CODMAR').AsString,
                                 FieldByName('DTAINI').AsDateTime,
                                 FieldByName('DTAFIN').AsDateTime,
                                 FieldByName('VALMET').AsFloat,
                                 FieldByName('VALDES').AsFloat,
                                 FieldByName('LITRAG').AsFloat,
                                 FieldByName('CODEMP').AsString,
                                 FieldByName('AUTINC').AsString,
                                 FieldByName('CODGRU').AsString,
                                 FieldByName('CODFOR').AsString,
                                 FieldByName('TIPMET').AsString,
                                 FieldByName('CODDEP').AsString);
          Next;
        end;
      end;
      cdsClientes.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    end;
    pgbProgresso.Position := 0;
    fCommit;
    pLimpaEdits(True, True);
    cdsMetas.EmptyDataSet;
    cdsClientes.EmptyDataSet;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message,'[TfrmCadMetasClientes.btnConfirmarClick]');
      fRollBack;
    end;
  end;
end;

{**********************************************}
{* EXIBE TELA DE INF. DE CRÉDITO PARA GERAÇÃO *}
{* DO CRÉDITO DE UMA DETERMINADA META         *}
{*******************************************RL*}
procedure TfrmCadMetasClientes.btnGerarCreditoClick(Sender: TObject);
  Var
    qryTmp      : TUniQuery;
begin
  inherited;

  if fEmptyStr(cdsClientesCODCLI.AsString) then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  end;

  if cdsMetas.IsEmpty then
  begin
    fMensagem('ATENÇÃO!','Não há metas cadastradas!',['&Ok']);
    Exit;
  end;

  if cdsClientesMARCA.AsString = 'N' then
  begin
    fMensagem('ATENÇÃO!','Cliente não está selecionado para gerar crédito!',['&Ok']);
    Exit;
  end;

  if fEmptyStr(cdsMetas.FieldByName('AUTINC').AsString) then
  begin
    fMensagem('ATENÇÃO!','Confirme a meta antes de gerar crédito!',['&Ok']);
    Exit;
  end;

  frmGeraCredCliente := TfrmGeraCredCliente.Create(Self);
  With frmGeraCredCliente Do
  Try
    qryTmp := objMetCli.fMostraCredito(cdsMetas.FieldByName('CODCLI').AsString,
                                       cdsMetas.FieldByName('CODMAR').AsString,
                                       cdsMetas.FieldByName('CODGRU').AsString,
                                       cdsMetas.FieldByName('CODFOR').AsString,
                                       cdsMetas.FieldByName('TIPMET').AsString,
                                       cdsMetas.FieldByName('CODDEP').AsString,
                                       cdsMetas.FieldByName('DTAINI').AsDateTime,
                                       cdsMetas.FieldByName('DTAFIN').AsDateTime,
                                       cdsMetas.FieldByName('VALMET').AsFloat);
    If Not qryTmp.IsEmpty Then
    Begin
      cdsCredito.Insert;
      cdsCredito.FieldByName('MARCA').AsString    := fConcatDesc(qryTmp.FieldByName('CODMAR').AsString, qryTmp.FieldByName('CODGRU').AsString, qryTmp.FieldByName('CODFOR').AsString, qryTmp.FieldByName('CODDEP').AsString);
      cdsCredito.FieldByName('DTAINI').AsDateTime := qryTmp.FieldByName('DTAINI').AsDateTime;
      cdsCredito.FieldByName('DTAFIN').AsDateTime := qryTmp.FieldByName('DTAFIN').AsDateTime;
      cdsCredito.FieldByName('META').AsFloat      := qryTmp.FieldByName('META').AsFloat;
      cdsCredito.FieldByName('LITRAGEM').AsFloat  := qryTmp.FieldByName('LITRAGEM').AsFloat;
      cdsCredito.FieldByName('FATURA').AsFloat    := qryTmp.FieldByName('FATURA').AsFloat;
      cdsCredito.FieldByName('DESCON').AsFloat    := qryTmp.FieldByName('DESCON').AsFloat;
      cdsCredito.FieldByName('GRUPO').AsString    := qryTmp.FieldByName('GRUPO').AsString;
      cdsCredito.FieldByName('FORNEC').AsString   := qryTmp.FieldByName('FORNEC').AsString;
      cdsCredito.FieldByName('TIPMET').AsString   := qryTmp.FieldByName('TIPMET').AsString;
      cdsCredito.Post;
      cdsCredito.IndexFieldNames := 'DTAINI';
    End;
    FreeAndNil(qryTmp);
    {**********************************************}
    {* CONFIGURA GRID DE VISUALIZAÇÃO DE CRÉDITOS *}
    {*******************************************RV*}
    If (cdsCredito.FieldByName('TIPMET').AsString = 'V') Then
    Begin
      dbgCredito.Columns[0].Width   := 274;
      dbgCredito.Columns[5].Visible := False;
    End
    Else
    Begin
      dbgCredito.Columns[0].Width   := 208;
      dbgCredito.Columns[5].Visible := True;
    End;
    dbgCredito.Columns[9].Visible := False;
    If ShowModal = mrOk Then
    Begin
      fStartTransaction;
      If objMetCli.fGeraCadRec Then
        If objMetCli.fAtualizaMetCli Then
          fCommit;

      fCarregaClientes(cdsClientesCODCLI.AsString, True);
    End;
    Free;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadMetasClientes.btnGerarCreditoClick]');
      fRollBack;
    End;
  End;
  pSetFocus(dbgMetas);
end;

procedure TfrmCadMetasClientes.pHerdaMeta(strCodEmp, strCodCli: string;
      dteDtaIni, dteDtaFin: TDate; dblPercHeranca: Double);
var
  qryMetCli: TUniQuery;
begin
  qryMetCli := fCriaQuery;
  try
    with qryMetCli, qryMetCli.SQL do
    begin
      Close;
      Append(' SELECT                     ');
      Append('   MCL_CODCLI AS CODCLI,    ');
      Append('   MCL_CODMAR AS CODMAR,    ');
      Append('   MCL_CODGRU AS CODGRU,    ');
      Append('   MCL_CODFOR AS CODFOR,    ');
      Append('   MCL_CODDEP AS CODDEP,    ');
      Append('   MCL_TIPMET AS TIPMET,    ');
      Append('   MCL_VALMET AS VALMET,    ');
      Append('   MCL_VALDES AS VALDES,    ');
      Append('   MCL_CODEMP AS CODEMP     ');
      Append(' FROM                       ');
      Append('   METCLI                   ');
      Append(' WHERE MCL_DTABAI IS NULL   ');
      Append('   AND MCL_CODEMP = :CODEMP ');
      Append('   AND MCL_CODCLI = :CODCLI ');
      Append(' ORDER BY                   ');
      Append('   MCL_DTAFIN DESC          ');
      Append(' LIMIT 1                    ');
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      if not IsEmpty then
        pAplicaMetaGrid(FieldByName('CODEMP').AsString, FieldByName('CODCLI').AsString, FieldByName('CODMAR').AsString, FieldByName('CODDEP').AsString,
                        fConcatDesc(FieldByName('CODMAR').AsString, FieldByName('CODGRU').AsString, FieldByName('CODFOR').AsString, FieldByName('CODDEP').AsString),
                        FieldByName('CODGRU').AsString, FieldByName('CODFOR').AsString, FieldByName('TIPMET').AsString, dteDtaIni, dteDtaFin,
                        FieldByName('VALMET').AsFloat + (FieldByName('VALMET').AsFloat / 100 * dblPercHeranca), FieldByName('VALDES').AsFloat);
    end;
  finally
    FreeAndNil(qryMetCli);
  end;

end;

procedure TfrmCadMetasClientes.btnHerdarClick(Sender: TObject);
var
  intRecNo: Integer;
begin
  inherited;

  if fEmptyStr(cdsClientesCODCLI.AsString) then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  end;

  if not fPossuiClienteSelecionado then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi selecionado!',['&Ok']);
    Exit;
  end;

  if fMensagem('ATENÇÃO', 'Serão herdadas as metas do último período válido para os clientes selecionados, ' +
                          'acrescida do percentual de acréscimo, caso tenha sido informado. Deseja continuar?', ['&Sim', '&Não'], 2) = 1 then
  begin
    cdsClientes.DisableControls;
    intRecNo := cdsClientes.RecNo;
    cdsClientes.First;
    while not cdsClientes.Eof do
    begin
      if cdsClientesMARCA.AsString = 'S' then
        pHerdaMeta(VS_strCodEmp, cdsClientesCODCLI.AsString, StrToDate(mskDtaIni.Text),
                   StrToDate(mskDtaFin.Text), fStrToFloat(edtPercHeranca.Text));
      cdsClientes.Next;
    end;
    cdsClientes.RecNo := intRecNo;
    cdsClientes.EnableControls;
  end;

end;

procedure TfrmCadMetasClientes.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmCadMetasClientes.btnImportacaoClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TFrmImportCadMetasClientes, FrmImportCadMetasClientes);
  FrmImportCadMetasClientes.ShowModal;
  pFreeAndNil(FrmImportCadMetasClientes);
end;

procedure TfrmCadMetasClientes.btnInverteSelecaoClick(Sender: TObject);
begin
  inherited;
  pInverteSelecao;
end;

procedure TfrmCadMetasClientes.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaClientes;
end;

procedure TfrmCadMetasClientes.cdsClientesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  cdsMetas.Filtered := False;
  cdsMetas.Filter := 'CODCLI = ' + QuotedStr(cdsClientesCODCLI.AsString);
  cdsMetas.Filtered := True;
end;

{**************************************************}
{* EXIBE TELA DE INF. DE CRÉDITO PARA  VISUALIZAR *}
{* OS CRÉDITOS GERADOS PARA O CLIENTE INFORMADO   *}
{***********************************************RL*}
procedure TfrmCadMetasClientes.btnCredRealizadosClick(Sender: TObject);
begin

  inherited;

  if fEmptyStr(cdsClientesCODCLI.AsString) then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  end;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(170, 7330, [],
                        ['CODCLI','CODEMP'],
                        [cdsClientesCODCLI.AsString,
                        VS_strCodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadMetasClientes.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcaClientes;
end;

function TfrmCadMetasClientes.fCarregaClientes(strCodCliAux: string; blnApenasCarregaMetas: Boolean; strVenRed: string = ''): Boolean;
var
  qryClientes: TUniQuery;
  blnPerguntaConfirmacao: Boolean;
begin
  qryClientes := fCriaQuery;

  if not fEmptyStr(strCodCliAux) then
  begin
    if blnApenasCarregaMetas then
      Result := fCarregaMetasCliente(strCodCli, False, True)
    else
    begin
      if (strCodCli <> strCodCliAux) then
      begin
        blnPerguntaConfirmacao := IIF(not fEmptyStr(strCodVen) or not fEmptyStr(strCodRed), True, (not fEmptyStr(strCodCli)));

        if blnPerguntaConfirmacao then
          Result := fMensagem('ATENÇÃO', 'Serão carregadas as metas vinculadas à esse cliente. ' +
                                         'Qualquer informação não salva será perdida. Deseja continuar?', ['&Sim', '&Não'], 2) = 1
        else
          Result := True;
        if Result then
        begin
          strCodCli := strCodCliAux;
          strCodVen := '';
          edtCodVen.Clear;
          edtDesVen.Clear;
          strCodRed := '';
          edtCodRed.Clear;
          edtDesRed.Clear;
          cdsClientes.EmptyDataSet;
          if fCarregaMetasCliente(strCodCli, False, False) then
          begin
            cdsClientes.Append;
            cdsClientesMARCA.AsString := 'S';
            cdsClientesCODCLI.AsString := strCodCli;
            cdsClientesNOMCLI.AsString := fRetNomCliente(strCodCli);
            cdsClientes.Post;
          end;
          cdsClientes.First;
        end
        else
        begin
          if fEmptyStr(strCodCli) then
          begin
            edtCodCli.Clear;
            edtDesCli.Clear;
          end
          else
          begin
            edtCodCli.Text := strCodCli;
            edtDesCli.Text := fRetNomCliente(strCodCli);
          end;
        end;
      end
      else
        Result := True;
    end;
  end
  else
  begin
    if strVenRed = 'V' then
    begin
      edtDesVen.Text := fRetNomeOperador(edtCodVen.Text);
      if fEmptyStr(edtDesVen.Text) Then
      begin
        fMensagem('', 'Vendedor não encontrado !', ['&Ok']);
        Result := False;
      end
      else
      begin
        if (strCodVen <> edtCodVen.Text) then
        begin
          blnPerguntaConfirmacao := IIF(not fEmptyStr(strCodCli) or not fEmptyStr(strCodRed), True, (not fEmptyStr(strCodVen)));

          if blnPerguntaConfirmacao then
            Result := fMensagem('ATENÇÃO', 'Serão carregados os clientes vinculados à esse vendedor. ' +
                                           'Qualquer informação não salva será perdida. Deseja continuar?', ['&Sim', '&Não'], 2) = 1
          else
            Result := True;
          if Result then
          begin
            strCodCli := '';
            edtCodCli.Clear;
            edtDesCli.Clear;
            strCodRed := '';
            edtCodRed.Clear;
            edtDesRed.Clear;
            strCodVen := edtCodVen.Text;
            cdsClientes.EmptyDataSet;
            try
              with qryClientes, qryClientes.SQL do
              begin
                Close;
                Clear;
                Add('SELECT CLI_CODCLI, CLI_NOMCLI FROM CADCLI WHERE CLI_CODVEN = :CODVEN');
                ParamByName('CODVEN').AsString := edtCodVen.Text;
                Open;
                if not IsEmpty then
                begin
                  cdsMetas.DisableControls;
                  cdsClientes.DisableControls;
                  cdsMetas.EmptyDataSet;
                  pgbProgresso.Position := 0;
                  pgbProgresso.Max := RecordCount;
                  while not Eof do
                  begin
                    cdsClientes.Append;
                    cdsClientesMARCA.AsString := 'N';
                    cdsClientesCODCLI.AsString := FieldByName('CLI_CODCLI').AsString;
                    cdsClientesNOMCLI.AsString := FieldByName('CLI_NOMCLI').AsString;
                    cdsClientes.Post;
                    fCarregaMetasCliente(cdsClientesCODCLI.AsString, True, False);
                    pgbProgresso.Position := pgbProgresso.Position + 1;
                    Application.ProcessMessages;
                    Next;
                  end;
                  pgbProgresso.Position := 0;
                  cdsMetas.EnableControls;
                  cdsClientes.EnableControls;
                end;
              end;
            finally
              FreeAndNil(qryClientes);
            end;
            cdsClientes.First;
          end
          else
          begin
            if fEmptyStr(strCodVen) then
            begin
              edtCodVen.Clear;
              edtDesVen.Clear;
            end
            else
            begin
              edtCodVen.Text := strCodVen;
              edtDesVen.Text := fRetNomeOperador(strCodVen);
            end;
          end;
        end
        else
          Result := True;
      end;
    end
    else
    begin
      edtDesRed.Text := fRetNomeRedeLoja(edtCodRed.Text);
      if fEmptyStr(edtDesRed.Text) Then
      begin
        fMensagem('', 'Rede de Lojas não encontrada !', ['&Ok']);
        Result := False;
      end
      else
      begin
        if (strCodRed <> edtCodRed.Text) then
        begin
          blnPerguntaConfirmacao := IIF(not fEmptyStr(strCodCli) or not fEmptyStr(strCodVen), True, (not fEmptyStr(strCodRed)));

          if blnPerguntaConfirmacao then
            Result := fMensagem('ATENÇÃO', 'Serão carregados os clientes vinculados à essa rede de lojas. ' +
                                           'Qualquer informação não salva será perdida. Deseja continuar?', ['&Sim', '&Não'], 2) = 1
          else
            Result := True;
          if Result then
          begin
            strCodCli := '';
            edtCodCli.Clear;
            edtDesCli.Clear;
            strCodVen := '';
            edtCodVen.Clear;
            edtDesVen.Clear;
            strCodRed := edtCodRed.Text;
            cdsClientes.EmptyDataSet;
            try
              with qryClientes, qryClientes.SQL do
              begin
                Close;
                Clear;
                Add('SELECT CLI_CODCLI, CLI_NOMCLI FROM CADCLI WHERE CLI_CODRED = :CODRED');
                ParamByName('CODRED').AsString := edtCodRed.Text;
                Open;
                if not IsEmpty then
                begin
                  cdsMetas.DisableControls;
                  cdsClientes.DisableControls;
                  cdsMetas.EmptyDataSet;
                  pgbProgresso.Position := 0;
                  pgbProgresso.Max := RecordCount;
                  while not Eof do
                  begin
                    cdsClientes.Append;
                    cdsClientesMARCA.AsString := 'N';
                    cdsClientesCODCLI.AsString := FieldByName('CLI_CODCLI').AsString;
                    cdsClientesNOMCLI.AsString := FieldByName('CLI_NOMCLI').AsString;
                    cdsClientes.Post;
                    fCarregaMetasCliente(cdsClientesCODCLI.AsString, True, False);
                    pgbProgresso.Position := pgbProgresso.Position + 1;
                    Application.ProcessMessages;
                    Next;
                  end;
                  pgbProgresso.Position := 0;
                  cdsMetas.EnableControls;
                  cdsClientes.EnableControls;
                end;
              end;
            finally
              FreeAndNil(qryClientes);
            end;
            cdsClientes.First;
          end
          else
          begin
            if fEmptyStr(strCodRed) then
            begin
              edtCodRed.Clear;
              edtDesRed.Clear;
            end
            else
            begin
              edtCodRed.Text := strCodRed;
              edtDesRed.Text := fRetNomeRedeLoja(strCodRed);
            end;
          end;
        end
        else
          Result := True;
      end;
    end;
  end;
end;

procedure TfrmCadMetasClientes.pMarcaClientes;
var
  intRecNo: Integer;
begin
  if fEmptyStr(cdsClientesCODCLI.AsString) then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  end;

  cdsClientes.DisableControls;
  intRecNo := cdsClientes.RecNo;
  cdsClientes.First;
  while not cdsClientes.Eof do
  begin
    cdsClientes.Edit;
    cdsClientesMARCA.AsString := 'S';
    cdsClientes.Post;
    cdsClientes.Next;
  end;
  cdsClientes.RecNo := intRecNo;
  cdsClientes.EnableControls;
end;

procedure TfrmCadMetasClientes.pDesmarcaClientes;
var
  intRecNo: Integer;
begin
  if fEmptyStr(cdsClientesCODCLI.AsString) then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  end;

  cdsClientes.DisableControls;
  intRecNo := cdsClientes.RecNo;
  cdsClientes.First;
  while not cdsClientes.Eof do
  begin
    cdsClientes.Edit;
    cdsClientesMARCA.AsString := 'N';
    cdsClientes.Post;
    cdsClientes.Next;
  end;
  cdsClientes.RecNo := intRecNo;
  cdsClientes.EnableControls;
end;

procedure TfrmCadMetasClientes.pInverteSelecao;
var
  intRecNo: Integer;
begin
  if fEmptyStr(cdsClientesCODCLI.AsString) then
  begin
    fMensagem('ATENÇÃO!','Nenhum cliente foi carregado!',['&Ok']);
    Exit;
  end;

  cdsClientes.DisableControls;
  intRecNo := cdsClientes.RecNo;
  cdsClientes.First;
  while not cdsClientes.Eof do
  begin
    cdsClientes.Edit;
    cdsClientesMARCA.AsString := IIF(cdsClientesMARCA.AsString = 'S', 'N', 'S');
    cdsClientes.Post;
    cdsClientes.Next;
  end;
  cdsClientes.RecNo := intRecNo;
  cdsClientes.EnableControls;
end;

end.


