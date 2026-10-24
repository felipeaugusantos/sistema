unit untCadVincularCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untGravando,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxGridLevel, MemDS, DBAccess, Uni,
  Datasnap.Provider, UniDataSetProvider, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, UniClientDataSet, cxButtons, cxGridCitel, cxCheckBox,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, cxProgressBar;

type
  TfrmCadVincularCep = class(TfrmPaiSimples)
    dbgVinculosCep: TcxGrid;
    dbgVinculosCepView: TcxGridDBTableView;
    Panel1: TPanel;
    Panel2: TPanel;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    dtsUf: TDataSource;
    dtsCidade: TDataSource;
    dtsBairro: TDataSource;
    dtsEndereco: TDataSource;
    qryBairro: TUniQuery;
    qryEndereco: TUniQuery;
    pnlDados: TPanel;
    gpbEstado: TGroupBox;
    gpbCidade: TGroupBox;
    gpbBairro: TGroupBox;
    gpbEndereco: TGroupBox;
    dtsVinculoCep: TDataSource;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    edtPesqEstado: TEdit;
    edtPesqCidade: TEdit;
    edtPesqBairro: TEdit;
    edtPesqEndereco: TEdit;
    qryBairroNOME_BAIRRO: TStringField;
    qryBairroNOME_CIDADE: TStringField;
    qryBairroESTADO: TStringField;
    qryEnderecoNOME_ENDERECO: TStringField;
    qryEnderecoSECCIONAMENTO: TStringField;
    qryEnderecoC_E_P: TStringField;
    qryEnderecoNOME_CIDADE: TStringField;
    qryEnderecoESTADO: TStringField;
    qryBairroCODIGO_BAIRRO: TIntegerField;
    qryEnderecoNOME_BAIRRO: TStringField;
    qryVinculoCep: TUniQuery;
    dspVinculoCep: TUniDataSetProvider;
    qryVinculoCepAUTOINCREM: TStringField;
    qryVinculoCepVIN_CODREG: TStringField;
    qryVinculoCepVIN_CODEMP: TStringField;
    qryVinculoCepVIN_ESTADO: TStringField;
    qryVinculoCepVIN_NOMCID: TStringField;
    qryVinculoCepVIN_BAIRRO: TStringField;
    qryVinculoCepVIN_ENDERE: TStringField;
    qryVinculoCepVIN_C_E_P_: TStringField;
    qryVinculoCepVIN_SECCIO: TStringField;
    pnlEstadoCidade: TPanel;
    pnlBairroEndereco: TPanel;
    pnlBotoesSairExcluir: TPanel;
    btnExcluirVinculo: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    Panel7: TPanel;
    dbgVinculoCEP: TDBGridCitel;
    Panel8: TPanel;
    pnlBotoesIncluirCancelar: TPanel;
    BitBtnLocked2: TBitBtnLocked;
    BitBtnLocked3: TBitBtnLocked;
    Panel9: TPanel;
    btnOpcoesSelecao: TcxButton;
    popOpcoesSelecao: TPopupMenu;
    mnuDesmarcarTodos: TMenuItem;
    mnuSelecionarTodos: TMenuItem;
    N1: TMenuItem;
    mnuInverterSelecao: TMenuItem;
    cdsVinculoCep: TUniClientDataSet;
    cdsVinculoCepVIN_ESTADO: TStringField;
    cdsVinculoCepVIN_NOMCID: TStringField;
    cdsVinculoCepVIN_BAIRRO: TStringField;
    cdsVinculoCepVIN_ENDERE: TStringField;
    cdsVinculoCepVIN_C_E_P_: TStringField;
    cdsVinculoCepVIN_SECCIO: TStringField;
    pnlBairro: TPanel;
    btnOpcoesSelecaoBairro: TcxButton;
    popOpcoesSelecaoBairro: TPopupMenu;
    mnuDesmarcarTodosBairro: TMenuItem;
    mnuSelecionarTodosBairro: TMenuItem;
    MenuItem3: TMenuItem;
    mnuInverterSelecaoBairro: TMenuItem;
    cdsUF: TUniClientDataSet;
    cdsUFESTADO_NOME: TStringField;
    cdsUFESTADO_UF: TStringField;
    cdsUFSELECIONADO: TLargeintField;
    cdsCidades: TUniClientDataSet;
    cdsCidadesSELECIONADO: TLargeintField;
    cdsCidadesCID_NOMCID: TStringField;
    cdsCidadesCID_CODCID: TIntegerField;
    gpbCep: TGroupBox;
    Panel10: TPanel;
    Panel11: TPanel;
    cxButton1: TcxButton;
    edtPesqCep: TEdit;
    qryEnderecoCEP: TUniQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    dtsEnderecoCEP: TDataSource;
    popOpcoesSelecaoCep: TPopupMenu;
    mnuDesmarcarTodosCep: TMenuItem;
    mnuSelecionarTodosCep: TMenuItem;
    MenuItem4: TMenuItem;
    mnuInverterSelecaoCep: TMenuItem;
    rgFiltro: TRadioGroup;
    qryEnderecoCEPSELECIONADO: TLargeintField;
    cxGridPopupMenu1: TcxGridPopupMenu;
    qryBairroSELECIONADO: TLargeintField;
    qryEnderecoSELECIONADO: TLargeintField;
    cdsVinculoCepAUTOINCREM: TStringField;
    cxGridEstadosTv: TcxGridDBTableView;
    cxGridEstadosLv: TcxGridLevel;
    cxGridEstados: TcxGrid;
    cxGridEstadosTvSELECIONADO: TcxGridDBColumn;
    cxGridEstadosTvESTADONOME: TcxGridDBColumn;
    cxGridEstadosTvUF: TcxGridDBColumn;
    cxgCidadesTv: TcxGridDBTableView;
    cxgCidadesLv: TcxGridLevel;
    cxgCidades: TcxGrid;
    cxgCidadesTvSELECIONADO: TcxGridDBColumn;
    cxgCidadesTvNome: TcxGridDBColumn;
    cxgCidadesTvCodigo: TcxGridDBColumn;
    cxgBairroTv: TcxGridDBTableView;
    cxgBairroLv: TcxGridLevel;
    cxgBairro: TcxGrid;
    cxgBairroTvSELECIONADO: TcxGridDBColumn;
    cxgBairroTvEstado: TcxGridDBColumn;
    cxgBairroTvCidade: TcxGridDBColumn;
    cxgBairroTvBairro: TcxGridDBColumn;
    cxgEnderecoCepTv: TcxGridDBTableView;
    cxgEnderecoCepLv: TcxGridLevel;
    cxgEnderecoCep: TcxGrid;
    cxgEnderecoCepTvSelecionado: TcxGridDBColumn;
    cxgEnderecoCepTvCEP: TcxGridDBColumn;
    cxgEnderecoCepTvEndereco: TcxGridDBColumn;
    cxgEnderecoCepTvBairro: TcxGridDBColumn;
    cxgEnderecoCepTvCidade: TcxGridDBColumn;
    cxgEnderecoCepTvUF: TcxGridDBColumn;
    cxgEnderecoCepTvSeccionamento: TcxGridDBColumn;
    cxgEnderecoTv: TcxGridDBTableView;
    cxgEnderecoLv: TcxGridLevel;
    cxgEndereco: TcxGrid;
    cxgEnderecoTvSelecionado: TcxGridDBColumn;
    cxgEnderecoTvEndereco: TcxGridDBColumn;
    cxgEnderecoTvBairro: TcxGridDBColumn;
    cxgEnderecoTvCidade: TcxGridDBColumn;
    cxgEnderecoTvUf: TcxGridDBColumn;
    cxgEnderecoTvSeccionamento: TcxGridDBColumn;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    spltBairro: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPesqEstadoChange(Sender: TObject);
    procedure edtPesqCidadeChange(Sender: TObject);
    procedure edtPesqBairroChange(Sender: TObject);
    procedure edtPesqEnderecoChange(Sender: TObject);
    procedure BitBtnLocked3Click(Sender: TObject);
    procedure BitBtnLocked2Click(Sender: TObject);
    procedure btnExcluirVinculoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mnuDesmarcarTodosClick(Sender: TObject);
    procedure mnuSelecionarTodosClick(Sender: TObject);
    procedure mnuInverterSelecaoClick(Sender: TObject);
    procedure mnuInverterSelecaoBairroClick(Sender: TObject);
    procedure mnuSelecionarTodosBairroClick(Sender: TObject);
    procedure mnuDesmarcarTodosBairroClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgCidadesTvSELECIONADOPropertiesChange(Sender: TObject);
    procedure rgFiltroClick(Sender: TObject);
    procedure edtPesqCepChange(Sender: TObject);
    procedure mnuDesmarcarTodosCepClick(Sender: TObject);
    procedure mnuSelecionarTodosCepClick(Sender: TObject);
    procedure mnuInverterSelecaoCepClick(Sender: TObject);
    procedure cxgBairroSelecionadoTvPropertiesChange(Sender: TObject);
    procedure dbgVinculoCEPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridEstadosTvSELECIONADOPropertiesChange(Sender: TObject);
    procedure cxgBairroTvSELECIONADOPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    FSqlBairro   : String;
    FSqlEndereco : String;
    FCodBairros  : String;
    stlEstados   : TStringList;
    stlCidades   : TStringList;

    function fRetornarSQLInsert: String;
    procedure pLimparTela(blnLimparVinculo : Boolean = false);
    function fCriarVinculo(AProgresso: TcxProgressBar): Boolean;
    procedure pSelecionarBairros;
    function fEstadosSelecionados: String;
    procedure pCarregaEstados;
    procedure pCarregaCidades;
    procedure pCarregaBairros;
    procedure pCarregaCEPs;
    function fCidadesSelecionadas: String;
    procedure AjustaFiltroGpbSel;
    procedure SelecaoCep(Tipo: integer);
    procedure SelecaoBairro(Tipo: integer);
    procedure SelecaoEndereco(Tipo: integer);
    function fVinculaRegiaoAEnderecos(AProgresso: TcxProgressBar): Boolean;
    function fEnderecoJaIncluido(const AEndereco, ASeccionamento, ACep, ACidade, AUF, ABairro: String): Boolean;
    function fGerarVinculo(AProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }
    strCodRegiao : String;
  end;

var
  frmCadVincularCep: TfrmCadVincularCep;

implementation

Uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadVincularCep.AjustaFiltroGpbSel;
begin
  If rgFiltro.ItemIndex = 0 then
  Begin
    gpbCep.Visible    := false;
    gpbCep.Align      := alNone;
    gpbBairro.Align   := alTop;
    spltBairro.Align  := alTop;
    spltBairro.Visible:= true;
    gpbEndereco.Align := alClient;
    gpbBairro.Visible   := true;
    gpbEndereco.Visible := true;

    pCarregaBairros;
  End
  Else
  Begin
    gpbBairro.Align     := alNone;
    gpbEndereco.Align   := alNone;
    spltBairro.Align    := alNone;
    spltBairro.Visible  := false;
    gpbBairro.Visible   := false;
    gpbEndereco.Visible := false;
    gpbCep.Align        := alClient;
    gpbCep.Visible      := true;

    pCarregaCEPs;
  End;
end;

procedure TfrmCadVincularCep.BitBtnLocked2Click(Sender: TObject);
begin
  inherited;
  TFrmGravando.fExecutarModalA(fCriarVinculo, 'Aguarde... Criando vínculo!', '');
end;

procedure TfrmCadVincularCep.BitBtnLocked3Click(Sender: TObject);
begin
  inherited;
  pLimparTela(true);
end;

procedure TfrmCadVincularCep.btnExcluirVinculoClick(Sender: TObject);
Var
  qryAux : TuniQuery;
begin
  inherited;

  if fMensagem('ATENÇÃO!', 'Deseja excluir todos os vínculos com a região selecionada?', ['&Sim', '&Não']) = 1 then
  begin
    Try
      qryAux := fCriaQuery;
      qryAux.SQL.Text :=
        ' DELETE FROM VINREG '+
        ' WHERE VIN_CODREG =:CODREG '+
        '   AND VIN_CODEMP =:CODEMP ';
      qryAux.ParamByName('CODREG').AsString := strCodRegiao;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ExecSQL;
    finally
      pLimparTela(true);
      FreeAndNil(qryAux);
    end;
  end;
end;

procedure TfrmCadVincularCep.cxgBairroSelecionadoTvPropertiesChange(
  Sender: TObject);
begin
  inherited;
  qryBairro.Post;
  pSelecionarBairros;
end;

procedure TfrmCadVincularCep.cxgBairroTvSELECIONADOPropertiesChange(
  Sender: TObject);
begin
  inherited;
  qryBairro.Post;
  pSelecionarBairros;
end;

procedure TfrmCadVincularCep.cxgCidadesTvSELECIONADOPropertiesChange(
  Sender: TObject);
  Var
    intLinha  : Integer;
    intIdx    : Integer;
    strCidade : String;
    blnSel    : Boolean;
begin
  inherited;
  intLinha  := cxgCidadesTv.Controller.FocusedRowIndex;

  strCidade  := cxgCidadesTv.ViewData.Rows[intLinha].Values[cxgCidadesTvCODIGO.Index];
  blnSel := TcxCheckBox(Sender).Checked;

  If (blnSel) Then
    stlCidades.Add(strCidade)
  Else
  Begin
    intIdx := stlCidades.IndexOf(strCidade);

    If (intIdx >= 0) Then
      stlCidades.Delete(intIdx);
  End;

  if rgFiltro.ItemIndex = 0 then
    TfrmGravando.fExecutarModal(pCarregaBairros, 'Aguarde, carregando bairros...', '')
  else
    TfrmGravando.fExecutarModal(pCarregaCEPs, 'Aguarde, carregando CEPs...', '');

end;

function TfrmCadVincularCep.fCidadesSelecionadas: String;
begin
  If (stlCidades.Count = 0) Then
    Result := QuotedStr('')
  Else
  If (stlCidades.Count = 1) Then
    Result := QuotedStr(stlCidades.Strings[0])
  Else
    Result := chr(39) + String.Join(chr(39)+','+chr(39), stlCidades.ToStringArray) + chr(39);
end;

procedure TfrmCadVincularCep.pCarregaBairros;
begin
  qryBairro.Close;
  qryBairro.MacroByName('ID_CIDADE').Value := fCidadesSelecionadas;
  qryBairro.Open;
end;

procedure TfrmCadVincularCep.cxGridEstadosTvSELECIONADOPropertiesChange(
  Sender: TObject);
  Var
    intLinha  : Integer;
    intIdxUf  : Integer;
    strUF  : String;
    blnSel : Boolean;
begin
  inherited;
  intLinha  := cxgridEstadosTv.Controller.FocusedRowIndex;


  strUf  := cxgridEstadosTv.ViewData.Rows[intLinha].Values[cxgridEstadosTvUF.Index];
  blnSel := TcxCheckBox(Sender).Checked;

  If (blnSel) Then
    stlEstados.Add(strUf)
  Else
  Begin
    intIdxUf := stlEstados.IndexOf(strUf);

    If (intIdxUf >= 0) Then
      stlEstados.Delete(intIdxUf);
  End;

  TfrmGravando.fExecutarModal(pCarregaCidades, 'Aguarde, carregando cidades...', '');
end;

procedure TfrmCadVincularCep.dbgVinculoCEPKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  LCont: Integer;
begin
  inherited;

  if (Key <> VK_DELETE) then
    Exit;

  if (dbgVinculoCEP.SelectedRows.Count > 1) then
  begin
    if (fMensagem('Atenção', 'Deseja excluir os ' + dbgVinculoCEP.SelectedRows.Count.ToString + ' vínculos selecionados?', ['&Sim', '&Não'], 2) = 2) then
      Exit;

    for LCont := 0 to Pred(dbgVinculoCEP.SelectedRows.Count) do
    begin
      cdsVinculoCep.Bookmark := dbgVinculoCEP.SelectedRows[LCont];

      if (not fEmptyStr(cdsVinculoCep.FieldByName('AUTOINCREM').AsString)) then
        fExecutaSQL('DELETE FROM VINREG WHERE AUTOINCREM = ' + QuotedStr(cdsVinculoCep.FieldByName('AUTOINCREM').AsString));

      cdsVinculoCep.Delete;
    end;

    dbgVinculoCEP.SelectedRows.Clear;

    Exit;
  end;

  if (fMensagem('Atenção', 'Deseja excluir este vínculo?', ['&Sim', '&Não'], 2) = 2) then
    Exit;

  if (not fEmptyStr(cdsVinculoCep.FieldByName('AUTOINCREM').AsString)) then
    fExecutaSQL('DELETE FROM VINREG WHERE AUTOINCREM = ' + QuotedStr(cdsVinculoCep.FieldByName('AUTOINCREM').AsString));

  cdsVinculoCep.Delete;
end;

procedure TfrmCadVincularCep.edtPesqCepChange(Sender: TObject);
Var Lfiltro : string;
begin
  inherited;

  If not fEmptyStr(edtPesqCep.Text) Then
  Begin
    Lfiltro := 'C_E_P LIKE ''%' + edtPesqCep.text+ '%''';
    qryEnderecoCEP.Filter   := Lfiltro;
    qryEnderecoCEP.Filtered := True;
  End
  Else
    qryEnderecoCEP.Filter := '';
end;

procedure TfrmCadVincularCep.mnuDesmarcarTodosBairroClick(Sender: TObject);
begin
  inherited;
  SelecaoBairro(2);
  pSelecionarBairros;
end;

procedure TfrmCadVincularCep.mnuDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  SelecaoEndereco(2);
end;

procedure TfrmCadVincularCep.pSelecionarBairros;
var Pos : TBookmark;
begin
  FCodBairros := EmptyStr;
  qryBairro.AfterScroll := Nil;
  qryBairro.DisableControls;
  qryEndereco.DisableControls;

  try
    Pos := qryBairro.GetBookmark;
    qryBairro.First;
    While not qryBairro.Eof Do
    Begin
      If qryBairroSELECIONADO.AsInteger = 1 Then
        pIncrementaListaStr( qryBairroCODIGO_BAIRRO.AsString, FCodBairros, True, True, ',', False);
      qryBairro.Next;
    End;
    qryBairro.GotoBookmark(Pos);

    if not fEmptyStr(FCodBairros) then
    begin
      qryEndereco.Close;
      qryEndereco.SQL.Text  := StringReplace(FSqlEndereco, '= :ID_BAIRRO', 'IN('+FCodBairros+')', [rfReplaceAll, rfIgnoreCase]);
      qryEndereco.Open;
    end
    else
    begin
      qryEndereco.Close;
      qryEndereco.SQL.Text  := StringReplace(FSqlEndereco, '= :ID_BAIRRO', 'IN(''0'')', [rfReplaceAll, rfIgnoreCase]);
      qryEndereco.Open;
    end;
    cxgEndereco.Refresh;
  finally
    qryBairro.EnableControls;
    qryEndereco.EnableControls;
  end;
end;

procedure TfrmCadVincularCep.rgFiltroClick(Sender: TObject);
begin
  inherited;
  AjustaFiltroGpbSel;
end;

procedure TfrmCadVincularCep.SelecaoCep(Tipo: integer);
// Tipo:  1 = Marcar todos; 2 = Desmarcar todos; 3 = Inverter Selecao
var LfiltroGrid, Lfiltro : string;
begin
  qryEnderecoCep.DisableControls;

  Lfiltro := qryEnderecoCep.Filter;
  if (cxgEnderecoCeptv.datacontroller.filter.root[0]) <> nil then
  Begin
    LfiltroGrid := cxgEnderecoCeptv.datacontroller.filter.root[0].criteria.filtertext;
    if not fEmptyStr(qryEnderecoCep.Filter) then
      qryEnderecoCep.Filter := qryEnderecoCep.Filter + ' AND ' + LfiltroGrid
    else qryEnderecoCep.Filter := LfiltroGrid;
    qryEnderecoCep.Filtered := True;
  End;

  qryEnderecoCep.First;
  while not qryEnderecoCep.Eof do
  begin
    qryEnderecoCep.Edit;
    if Tipo = 1 then
      qryEnderecoCEPSELECIONADO.AsInteger := 1
    else
      if Tipo = 2 then
        qryEnderecoCEPSELECIONADO.AsInteger := 0
      else
      begin
        if qryEnderecoCEPSELECIONADO.AsInteger = 1 then
          qryEnderecoCEPSELECIONADO.AsInteger := 0
        else
          qryEnderecoCEPSELECIONADO.AsInteger := 1;
      end;
    qryEnderecoCep.Post;
    qryEnderecoCep.Next;
  end;
  qryEnderecoCep.EnableControls;

  if not fEmptyStr(Lfiltro) then
    qryEnderecoCep.Filter := Lfiltro
  else
    qryEnderecoCep.Filter := '';
end;

procedure TfrmCadVincularCep.SelecaoBairro(Tipo: integer);
// Tipo:  1 = Marcar todos; 2 = Desmarcar todos; 3 = Inverter Selecao
var LfiltroGrid, Lfiltro : string;
begin
  qryBairro.DisableControls;

  Lfiltro := qryBairro.Filter;
  if (cxgBairrotv.datacontroller.filter.root[0]) <> nil then
  Begin
    LfiltroGrid := cxgBairrotv.datacontroller.filter.root[0].criteria.filtertext;
    if not fEmptyStr(qryBairro.Filter) then
      qryBairro.Filter := qryBairro.Filter + ' AND ' + LfiltroGrid
    else qryBairro.Filter := LfiltroGrid;
    qryBairro.Filtered := True;
  End;

  qryBairro.First;
  while not qryBairro.Eof do
  begin
    qryBairro.Edit;
    if Tipo = 1 then
      qryBairroSELECIONADO.AsInteger := 1
    else
      if Tipo = 2 then
        qryBairroSELECIONADO.AsInteger := 0
      else
      begin
        if qryBairroSELECIONADO.AsInteger = 1 then
          qryBairroSELECIONADO.AsInteger := 0
        else
          qryBairroSELECIONADO.AsInteger := 1;
      end;
    qryBairro.Post;
    qryBairro.Next;
  end;
  qryBairro.EnableControls;

  if not fEmptyStr(Lfiltro) then
    qryBairro.Filter := Lfiltro
  else
    qryBairro.Filter := '';
end;

procedure TfrmCadVincularCep.SelecaoEndereco(Tipo: integer);
// Tipo:  1 = Marcar todos; 2 = Desmarcar todos; 3 = Inverter Selecao
var LfiltroGrid, Lfiltro : string;
begin
  qryEndereco.DisableControls;

  Lfiltro := qryEndereco.Filter;
  if (cxgenderecotv.datacontroller.filter.root[0]) <> nil then
  begin
    LfiltroGrid := cxgEnderecotv.datacontroller.filter.root[0].criteria.filtertext;
    if not fEmptyStr(qryEndereco.Filter) then
      qryEndereco.Filter := qryEndereco.Filter + ' AND ' + LfiltroGrid
    else qryEndereco.Filter := LfiltroGrid;
    qryEndereco.Filtered := True;
  end;

  qryEndereco.First;
  while not qryEndereco.Eof do
  begin
    qryEndereco.Edit;
    if Tipo = 1 then
      qryEnderecoSELECIONADO.AsInteger := 1
    else
      if Tipo = 2 then
        qryEnderecoSELECIONADO.AsInteger := 0
      else
      begin
        if qryEnderecoSELECIONADO.AsInteger = 1 then
          qryEnderecoSELECIONADO.AsInteger := 0
        else
          qryEnderecoSELECIONADO.AsInteger := 1;
      end;
    qryEndereco.Post;
    qryEndereco.Next;
  end;
  qryEndereco.EnableControls;

  if not fEmptyStr(Lfiltro) then
    qryEndereco.Filter := Lfiltro
  else
    qryEndereco.Filter := '';
end;

procedure TfrmCadVincularCep.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  cdsVinculoCep.DisableControls;

  try
    TFrmGravando.fExecutarModalA(fGerarVinculo, 'Gerando vínculo...', '');
    TFrmGravando.fExecutarModalA(fVinculaRegiaoAEnderecos, 'Vinculando endereços a região...', '');
  finally
    fMensagem('ATENÇÃO!','Vínculo realizado com sucesso!' , ['&Ok']);
    pLimparTela(True);
    cdsVinculoCep.EnableControls;
    Self.Close;
  end;
end;

procedure TfrmCadVincularCep.edtPesqBairroChange(Sender: TObject);
Var
  Lfiltro : String;
begin
  inherited;

  If not fEmptyStr(edtPesqBairro.Text) Then
  Begin
    Lfiltro := 'NOME_BAIRRO LIKE ''%' + edtPesqBairro.text+ '%''';
    qryBairro.Filter   := Lfiltro;
    qryBairro.Filtered := True;
  End
  Else
    qryBairro.Filter := '';
end;

procedure TfrmCadVincularCep.edtPesqCidadeChange(Sender: TObject);
Var Lfiltro : string;
begin
  inherited;
 // pCarregaCidades;
  If not fEmptyStr(edtPesqCidade.Text) Then
  Begin
    Lfiltro := 'CID_NOMCID LIKE ''%' + edtPesqCidade.text+ '%''';
    cdsCidades.Filter   := Lfiltro;
    cdsCidades.Filtered := True;
  End
  Else
    cdsCidades.Filtered := False;
end;

procedure TfrmCadVincularCep.edtPesqEnderecoChange(Sender: TObject);
Var
  Lfiltro : String;
begin
  inherited;

  If Not fEmptyStr(edtPesqEndereco.text) Then
  Begin
    Lfiltro := 'NOME_ENDERECO LIKE ''%' + edtPesqEndereco.text+ '%''';
    qryEndereco.Filter   := Lfiltro;
    qryEndereco.Filtered := True;
  End
  Else
    qryEndereco.Filter := '';
end;

procedure TfrmCadVincularCep.edtPesqEstadoChange(Sender: TObject);
Var
  Lfiltro : String;
begin
  inherited;
  If not fEmptyStr(edtPesqEstado.Text) Then
  Begin
    Lfiltro := 'ESTADO_NOME LIKE ''%' + edtPesqEstado.text+ '%''';
    cdsUF.Filter   := Lfiltro;
    cdsUF.Filtered := True;
  End
  Else
    cdsUF.Filtered := False;
end;

procedure TfrmCadVincularCep.FormCreate(Sender: TObject);
begin
  inherited;

  FSqlBairro   := qryBairro.SQl.Text;
  FSqlEndereco := qryEndereco.SQl.Text;
  FCodBairros  := EmptyStr;

  pCarregaEstados;

  stlEstados := TStringList.Create;
  stlEstados.Sorted := True;
  stlEstados.Duplicates := dupIgnore;

  stlCidades := TStringList.Create;
  stlCidades.Sorted := True;
  stlCidades.Duplicates := dupIgnore;

  pnlInfo.Caption := '* Ao gerar vínculo, será atualizada a região de todos os endereços com os CEP vinculados.';
end;

procedure TfrmCadVincularCep.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCidades);
  FreeAndNil(stlEstados);
  inherited;
end;

procedure TfrmCadVincularCep.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;

  if (Key = vk_return) then
    selectNext(Screen.ActiveControl, true, true);
end;

procedure TfrmCadVincularCep.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtPesqEstado);

  qryVinculoCep.Close;
  qryVinculoCep.ParamByName('CODREG').AsString := strCodRegiao;
  qryVinculoCep.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryVinculoCep.Open;

  cdsVinculoCep.Open;

  AjustaFiltroGpbSel;
end;

function TfrmCadVincularCep.fRetornarSQLInsert: String;
begin
  Result :=
    ' INSERT INTO VINREG ' +
    '   (AUTOINCREM, VIN_CODREG, VIN_CODEMP, VIN_ESTADO, VIN_NOMCID, ' +
    '    VIN_BAIRRO, VIN_ENDERE, VIN_C_E_P_, VIN_SECCIO) ' +
    ' VALUES ';
end;

function TfrmCadVincularCep.fVinculaRegiaoAEnderecos(AProgresso: TcxProgressBar): Boolean;
var
  LVin : TUniQuery;
  LUpd : TUniQuery;
  LCont: Integer;
  LCep : TStringList;
begin
  Result := True;

  If fEmptyStr(strCodRegiao) Then
    Exit;

  fStartTransaction;

  Try
    LVin := fCriaQuery(Self);
    LUpd := fCriaQuery(Self);
    LCep   := TStringList.Create;

    Try
      LVin.Close;
      LVin.SQL.Clear;
      LVin.SQL.Add(' SELECT DISTINCT VIN_C_E_P_ AS C_E_P_ ');
      LVin.SQL.Add(' FROM VINREG WHERE VIN_CODREG = :CODREG ');
      LVin.ParamByName('CODREG').AsString := strCodRegiao;
      LVin.Open;

      AProgresso.Position := 0;
      AProgresso.Properties.Max := LVin.RecordCount;

      LVin.First;
      LCont := 0;

      while (Not LVin.Eof) do
      begin
        LCep.Add(LVin.FieldByName('C_E_P_').AsString);
        LCont := LCont + 1;

        if (LCont = 500) or (LVin.RecordCount = LVin.RecNo) then
        begin
          LUpd.Close;
          LUpd.SQL.Clear;
          LUpd.SQL.Add('UPDATE ENTCLI ');
          LUpd.SQL.Add('SET ETC_CODREG = :CODREG ');
          LUpd.SQL.Add('WHERE ETC_CEPENT IN (' + fCommaText(LCep, True) + ')');
          LUpd.ParamByName('CODREG').AsString := strCodRegiao;
          LUpd.ExecSQL;

          LUpd.Close;
          LUpd.SQL.Clear;
          LUpd.SQL.Add('UPDATE CADCLI ');
          LUpd.SQL.Add('SET CLI_CODREG = :CODREG ');
          LUpd.SQL.Add('WHERE CLI_C_E_P_ IN (' + fCommaText(LCep, True) + ')');
          LUpd.ParamByName('CODREG').AsString := strCodRegiao;
          LUpd.ExecSQL;

          LCont := 0;
          LCep.Clear;
        end;

        LVin.Next;
        AProgresso.Position := AProgresso.Position + 1;
        Application.ProcessMessages;
      end;
    finally
      FreeAndNil(LVin);
      FreeAndNil(LUpd);
      FreeAndNil(LCep);
    end;

    fCommit;
  except
    on E:Exception do
    begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadVincularCep.fVinculaRegiaoAEnderecos]');
    end;
  end;
end;

procedure TfrmCadVincularCep.mnuDesmarcarTodosCepClick(Sender: TObject);
begin
  inherited;
  SelecaoCep(2);
end;

procedure TfrmCadVincularCep.mnuInverterSelecaoBairroClick(Sender: TObject);
begin
  inherited;
  SelecaoBairro(3);
  pSelecionarBairros;
end;

procedure TfrmCadVincularCep.mnuInverterSelecaoCepClick(Sender: TObject);
begin
  inherited;
  SelecaoCep(3);
end;

procedure TfrmCadVincularCep.mnuInverterSelecaoClick(Sender: TObject);
begin
  inherited;
  SelecaoEndereco(3);
end;

function TfrmCadVincularCep.fCriarVinculo(AProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  cdsVinculoCep.DisableControls;

  try
    AProgresso.Position := 0;

    If (rgFiltro.ItemIndex = 0) then
    Begin
      qryEndereco.DisableControls;
      qryEndereco.First;
      AProgresso.Properties.Max := qryEndereco.RecordCount;

      while not qryEndereco.Eof Do
      Begin
        If qryEnderecoSELECIONADO.AsInteger = 1 then
        Begin
          if (not fEnderecoJaIncluido(dtsEndereco.DataSet.FieldByName('NOME_ENDERECO').AsString,
                                      dtsEndereco.DataSet.FieldByName('SECCIONAMENTO').AsString,
                                      dtsEndereco.DataSet.FieldByName('C_E_P').AsString,
                                      dtsEndereco.DataSet.FieldByName('NOME_CIDADE').AsString,
                                      dtsEndereco.DataSet.FieldByName('ESTADO').AsString,
                                      dtsEndereco.DataSet.FieldByName('NOME_BAIRRO').AsString)) then
          begin
            cdsVinculoCep.Insert;
            cdsVinculoCep.FieldByName('VIN_ENDERE').AsString := dtsEndereco.DataSet.FieldByName('NOME_ENDERECO').AsString;
            cdsVinculoCep.FieldByName('VIN_SECCIO').AsString := dtsEndereco.DataSet.FieldByName('SECCIONAMENTO').AsString;
            cdsVinculoCep.FieldByName('VIN_C_E_P_').AsString := dtsEndereco.DataSet.FieldByName('C_E_P').AsString;
            cdsVinculoCep.FieldByName('VIN_NOMCID').AsString := dtsEndereco.DataSet.FieldByName('NOME_CIDADE').AsString;
            cdsVinculoCep.FieldByName('VIN_ESTADO').AsString := dtsEndereco.DataSet.FieldByName('ESTADO').AsString;
            cdsVinculoCep.FieldByName('VIN_BAIRRO').AsString := dtsEndereco.DataSet.FieldByName('NOME_BAIRRO').AsString;
            cdsVinculoCep.Post;
          end;

          qryEndereco.Edit;
          qryEnderecoSELECIONADO.AsInteger := 0;
          qryEndereco.Post;
        end;

        AProgresso.Position := AProgresso.Position + 1;
        Application.ProcessMessages;

        qryEndereco.Next;
      End;

      qryEndereco.EnableControls;
    End
    Else
    Begin
      qryEnderecoCep.DisableControls;
      qryEnderecoCep.First;
      AProgresso.Properties.Max := qryEnderecoCep.RecordCount;

      while not qryEnderecoCep.Eof Do
      Begin
        If (qryEnderecoCEPSELECIONADO.AsInteger = 1) then
        Begin
          if (not fEnderecoJaIncluido(dtsEnderecoCEP.DataSet.FieldByName('NOME_ENDERECO').AsString,
                                      dtsEnderecoCEP.DataSet.FieldByName('SECCIONAMENTO').AsString,
                                      dtsEnderecoCEP.DataSet.FieldByName('C_E_P').AsString,
                                      dtsEnderecoCEP.DataSet.FieldByName('NOME_CIDADE').AsString,
                                      dtsEnderecoCEP.DataSet.FieldByName('ESTADO').AsString,
                                      dtsEnderecoCEP.DataSet.FieldByName('NOME_BAIRRO').AsString)) then
          begin
            cdsVinculoCep.Insert;
            cdsVinculoCep.FieldByName('VIN_ENDERE').AsString := dtsEnderecoCEP.DataSet.FieldByName('NOME_ENDERECO').AsString;
            cdsVinculoCep.FieldByName('VIN_SECCIO').AsString := dtsEnderecoCEP.DataSet.FieldByName('SECCIONAMENTO').AsString;
            cdsVinculoCep.FieldByName('VIN_C_E_P_').AsString := dtsEnderecoCEP.DataSet.FieldByName('C_E_P').AsString;
            cdsVinculoCep.FieldByName('VIN_NOMCID').AsString := dtsEnderecoCEP.DataSet.FieldByName('NOME_CIDADE').AsString;
            cdsVinculoCep.FieldByName('VIN_ESTADO').AsString := dtsEnderecoCEP.DataSet.FieldByName('ESTADO').AsString;
            cdsVinculoCep.FieldByName('VIN_BAIRRO').AsString := dtsEnderecoCEP.DataSet.FieldByName('NOME_BAIRRO').AsString;
            cdsVinculoCep.Post;
          end;

          qryEnderecoCEP.Edit;
          qryEnderecoCEPSELECIONADO.AsInteger := 0;
          qryEnderecoCEP.Post;
        End;

        AProgresso.Position := AProgresso.Position + 1;
        Application.ProcessMessages;

        qryEnderecoCep.Next;
      end;

      qryEnderecoCep.EnableControls;
    End;
  finally
    cdsVinculoCep.EnableControls;
  end;
end;

procedure TfrmCadVincularCep.pLimparTela(blnLimparVinculo : Boolean = false);
begin
  if not fEmptyStr(edtPesqEstado.Text) then
    edtPesqEstado.Clear;
  if not fEmptyStr(edtPesqCidade.Text) then
    edtPesqCidade.Clear;
  if not fEmptyStr(edtPesqBairro.Text) then
    edtPesqBairro.Clear;
  if fEmptyStr(edtPesqEndereco.Text) then
    edtPesqEndereco.Clear;
  pSetFocus(edtPesqEstado);

  if blnLimparVinculo then
    cdsVinculoCep.EmptyDataSet;
end;


function TfrmCadVincularCep.fEnderecoJaIncluido(const AEndereco, ASeccionamento,
  ACep, ACidade, AUF, ABairro: String): Boolean;
begin
  Result := cdsVinculoCep.Locate('VIN_ENDERE;VIN_SECCIO;VIN_C_E_P_;VIN_NOMCID;VIN_ESTADO;VIN_BAIRRO',
                                 VarArrayOf([AEndereco, ASeccionamento, ACep, ACidade, AUF, ABairro]),
                                 []);
end;

function TfrmCadVincularCep.fEstadosSelecionados: String;
begin
  If (stlEstados.Count = 0) Then
    Result := '""'
  Else
  If (stlEstados.Count = 1) Then
    Result := '"' + stlEstados.Strings[0] + '"'
  Else
    Result := '"' + String.Join('","', stlEstados.ToStringArray) + '"';
end;

function TfrmCadVincularCep.fGerarVinculo(AProgresso: TcxProgressBar): Boolean;
var
  LQry: TUniQuery;
  LValues: String;
  LCont: Integer;
begin
  inherited;
  Result := True;
  LQry := fCriaQuery;

  cdsVinculoCep.DisableControls;

  try
    try
      AProgresso.Position := 0;
      AProgresso.Properties.Max := cdsVinculoCep.RecordCount;

      cdsVinculoCep.First;
      LValues := '';
      LCont := 0;

      while Not cdsVinculoCep.Eof do
      begin
        if fEmptyStr(cdsVinculoCep.FieldByName('AUTOINCREM').AsString) then
        begin
          LValues := LValues + IIF((LCont > 0), ',', '')
                             + '("' + fRetAutoIncrem('VINREG', VS_strCodEmp) + '",'
                             + ' "' + strCodRegiao + '",'
                             + ' "' + VS_strCodEmp + '",'
                             + ' "' + cdsVinculoCep.FieldByName('VIN_ESTADO').AsString + '",'
                             + ' "' + cdsVinculoCep.FieldByName('VIN_NOMCID').AsString + '",'
                             + ' "' + cdsVinculoCep.FieldByName('VIN_BAIRRO').AsString + '",'
                             + ' "' + cdsVinculoCep.FieldByName('VIN_ENDERE').AsString + '",'
                             + ' "' + cdsVinculoCep.FieldByName('VIN_C_E_P_').AsString + '",'
                             + ' "' + cdsVinculoCep.FieldByName('VIN_SECCIO').AsString + '")';

          LCont := LCont + 1;
        end;

        if (LCont = 250) or ((LCont > 0) and (cdsVinculoCep.RecordCount = cdsVinculoCep.RecNo)) then
        begin
          LQry.Close;
          LQry.SQL.Clear;
          LQry.SQL.Add(fRetornarSQLInsert);
          LQry.SQL.Add(LValues);
          LQry.ExecSQL;

          LValues := '';
          LCont := 0;
        end;

        cdsVinculoCep.Next;
        AProgresso.Position := AProgresso.Position + 1;
        Application.ProcessMessages;
      end;
    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadVincularCep.fGerarVinculo]');
      end;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmCadVincularCep.pCarregaCEPs;
begin
  qryEnderecoCEP.Close;
  qryEnderecoCEP.MacroByName('ID_CIDADE').Value := fCidadesSelecionadas;
  qryEnderecoCEP.Open;
end;

procedure TfrmCadVincularCep.pCarregaCidades;
Var
  qryCidades : TUniQuery;
  strFiltro  : String;
begin
  inherited;

  strFiltro := edtPesqCidade.text;

  cdsCidades.DisableControls;
  Try
    qryCidades := fCriaQuery;
    Try
      qryCidades.Close;
      qryCidades.SQL.Clear;
      qryCidades.SQL.Add(' SELECT ');
      qryCidades.SQL.Add('   DISTINCT UPPER(nome) AS CID_NOMCID, ');
      qryCidades.SQL.Add('   id_cidade AS CID_CODCID, ');
      qryCidades.SQL.Add('   0 AS SELECIONADO ');
      qryCidades.SQL.Add(' FROM cidade ');
      qryCidades.SQL.Add(' WHERE IFNULL(nome ,"") <> "" ');
      qryCidades.SQL.Add('   AND id_uf IN ('+fEstadosSelecionados+') ');

      qryCidades.SQL.Add(' ORDER BY nome ASC ');
      qryCidades.Open;

      If (cdsCidades.Active) Then
      Begin
        cdsCidades.EmptyDataSet;
        stlCidades.Clear;
      End
      Else
      Begin
        cdsCidades.Close;
        cdsCidades.CreateDataSet;
        cdsCidades.Open;
      End;

      qryCidades.First;
      While (Not qryCidades.Eof) Do
      Begin
        pCloneRegistro(cdsCidades, qryCidades, True);
        qryCidades.Next;
      End;
      cdsCidades.Filter := 'CID_NOMCID <> ''X''';
      cdsCidades.Filtered := True;
    Finally
      FreeAndNil(qryCidades);
    End;
  Finally
    cdsCidades.EnableControls;
  End;
end;

procedure TfrmCadVincularCep.pCarregaEstados;
  Var
    qryUF : TUniQuery;
begin
  inherited;

  qryUF := fCriaQuery;
  Try
    qryUF.Close;
    qryUF.SQL.Clear;
    qryUF.SQL.Add(' SELECT ');
    qryUF.SQL.Add('   DISTINCT UPPER(nome) AS ESTADO_NOME, ');
    qryUF.SQL.Add('   UPPER(id_uf) AS ESTADO_UF, ');
    qryUF.SQL.Add('   0 AS SELECIONADO ');
    qryUF.SQL.Add(' FROM estado ');
    qryUF.SQL.Add(' WHERE IFNULL(id_uf ,"") <> "" ');
    qryUF.SQL.Add(' ORDER BY id_uf ASC ');
    qryUF.Open;

    cdsUF.Close;
    cdsUF.CreateDataSet;
    cdsUF.Open;

    qryUF.First;
    cdsUF.EmptyDataSet;
    While (Not qryUF.Eof) Do
    Begin
      pCloneRegistro(cdsUF, qryUF, True);
      qryUF.Next;
    End;
    cdsUF.Filter := 'ESTADO_NOME <> ''X''';
    cdsUF.Filtered := True;
  Finally
    FreeAndNil(qryUF);
  End;
end;

procedure TfrmCadVincularCep.mnuSelecionarTodosBairroClick(Sender: TObject);
begin
  inherited;
  SelecaoBairro(1);
  pSelecionarBairros;
end;

procedure TfrmCadVincularCep.mnuSelecionarTodosCepClick(Sender: TObject);
begin
  inherited;
  SelecaoCep(1);
end;

procedure TfrmCadVincularCep.mnuSelecionarTodosClick(Sender: TObject);
begin
  inherited;
  SelecaoEndereco(1);
end;

end.

