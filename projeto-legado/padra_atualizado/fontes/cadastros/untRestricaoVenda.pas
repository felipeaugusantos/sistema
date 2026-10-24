unit untRestricaoVenda;

interface

uses
  System.Classes, EditFocus, Vcl.Controls, System.Generics.Collections,
  Vcl.ExtCtrls, System.SysUtils, Vcl.StdCtrls, Uni, UniClientDataSet,
  UniDataSetProvider, DB, Vcl.Forms, untTypesSistema;

type
  TFncPesquisaItemSelecao = function (var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean of object;
  TFncValidaCampos        = function (Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean of object;

  TItemSelecao = class
  strict private
    FCodigo      : String;
    FDescricao   : String;
    FCampo       : String;
    FFncPesquisa : TFncPesquisaItemSelecao;
    FEdtTamanho  : Integer;
    FEdtTipo     : TTipoTexto;

  public
    class function New: TItemSelecao;

    function Codigo(const Value: String): TItemSelecao; overload;
    function Codigo: String; overload;

    function Descricao(const Value: String): TItemSelecao; overload;
    function Descricao: String; overload;

    function Campo(const Value: String): TItemSelecao; overload;
    function Campo: String; overload;

    function FncPesquisa(const Value: TFncPesquisaItemSelecao): TItemSelecao; overload;

    function EdtTamanho(const Value: Integer): TItemSelecao; overload;
    function EdtTamanho: Integer; overload;

    function EdtTipo(const Value: TTipoTexto): TItemSelecao; overload;
    function EdtTipo: TTipoTexto; overload;

    function fExecutarPesquisa(var AKey: Char;
      var AArrayConsulta: TConsultasArray): Boolean;

  end;

  TListaItens = class
  strict private
    FRadioGroup      : TRadioGroup;
    FEdit            : TEditFocus;
    FLabel           : TLabel;
    FKeyPress        : TKeyPressEvent;
    FClickRadioGroup : TNotifyEvent;
    FForm            : TForm;
    FFncValidaCampos : TFncValidaCampos;

    procedure edtKeyPress(Sender: TObject; var Key: Char);
    procedure rdgClick(Sender: TObject);

  public
    constructor Create;

    class function New: TListaItens;

    function fAdicionaItem(const ACodigo, ADescricao, ACampo: String;
      const AFncPesquisa: TFncPesquisaItemSelecao; const AEdtTipo: TTipoTexto;
      const AEdtTamanho: Integer): TListaItens;

    function RadioGroup(const Value: TRadioGroup): TListaItens; overload;
    function RadioGroup: TRadioGroup; overload;

    function Edit(const Value: TEditFocus): TListaItens; overload;
    function Edit: TEditFocus; overload;

    function &Label(const Value: TLabel): TListaItens; overload;
    function &Label: TLabel; overload;

    function Item(const AItemIndex: Integer): TItemSelecao; overload;
    function Item(const ACodigo: String): TItemSelecao; overload;

    function fItemSelecionado: TItemSelecao;

    procedure pSelecionaItem(const ACodigo: String); overload;
    procedure pSelecionaItem(const AItemIndex: Integer); overload;

    function Form(const Value: TForm): TListaItens;
    function FncValidaCampos(const Value: TFncValidaCampos): TListaItens;

    procedure pLimparTudo;
    procedure pLimpar;
  end;

  TRestricaoVenda = class
  strict private
    FCodigoRestricaoVenda       : String;
    FListaNaoPermiteVenda       : TListaItens;
    FListaParaDestino           : TListaItens;
    FQryRestrivaoVenda          : TUniQuery;
    FCdsParaDestino             : TUniClientDataSet;
    FCdsNaoPermiteVenda         : TUniClientDataSet;
    FForm                       : TForm;
    FFncValidaCampos            : TFncValidaCampos;
    FListaRemoveNaoPermiteVenda : TStrings;
    FListaRemoveParaDestino     : TStrings;

    function GetItemNaoPermiteVenda: TItemSelecao;
    function GetItemParaDestino: TItemSelecao;

    procedure pCarregaItensNaoPermiteVenda;
    procedure pCarregaItensParaDestino;

    function fPesquisaFornecedor(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;
    function fPesquisaDepartamento(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;
    function fPesquisaMarca(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;
    function fPesquisaProduto(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;

    function fPesquisaEstado(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;
    function fPesquisaCidade(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;
    function fPesquisaRegiao(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;
    function fPesquisaCliente(var AKey: Char; var AArrayConsulta: TConsultasArray): Boolean;

    procedure pCarregaQryRestricaoVenda;
    procedure pCarregarDadosNaoPermiteVenda;
    procedure pCarregarDadosParaDestino;

    procedure pCriaDataSetNaoPermiteVenda;
    procedure pCriaDataSetParaDestino;

    procedure pAdicionarItemDataSet(const ACdsDataSet: TUniClientDataSet;
      const ALista: TListaItens; const ACodigo, ADescricao: String);

    procedure pRemoveNaoPermiteVenda;
    procedure pRemoveParaDestino;

    procedure pGravaNaoPermiteVenda;
    procedure pGravaParaDestino;

    procedure pHabilitaDesabilitaRadioGroup(
      const ACdsDataSet: TUniClientDataSet; const ALista: TListaItens);

  public
    constructor Create;
    destructor Destroy; override;

    class function New: TRestricaoVenda;

    function EditPesquisaNaoPermiteVenda(const Value: TEditFocus): TRestricaoVenda;
    function EditPesquisaParaDestino(const Value: TEditFocus): TRestricaoVenda;

    function RadioGroupNaoPermiteVenda(const Value: TRadioGroup): TRestricaoVenda;
    function RadioGroupParaDestino(const Value: TRadioGroup): TRestricaoVenda;

    function LabelTipoNaoPermiteVenda(const Value: TLabel): TRestricaoVenda;
    function LabelTipoParaDestino(const Value: TLabel): TRestricaoVenda;

    function Form(const Value: TForm): TRestricaoVenda;
    function FncValidaCampos(const Value: TFncValidaCampos): TRestricaoVenda;
    function CodigoRestricaoVenda(const Value: String): TRestricaoVenda;

    function fAdicionarNaoPermiteVenda(const ACodigo, ADescricao: String): TRestricaoVenda;
    function fAdicionarParaDestino(const ACodigo, ADescricao: String): TRestricaoVenda;

    function fRemoveNaoPermiteVenda(const ACodigo: String): TRestricaoVenda;
    function fRemoveParaDestino(const ACodigo: String): TRestricaoVenda;

    procedure pGravar;
    procedure pLimpar(const ALimparCodigoRestricaoVenda: Boolean=True);

    procedure pCarregarDadosComponentes;
    procedure pCarregarInformacoes;

    property qryRestricaoVenda    : TUniQuery         read FQryRestrivaoVenda;
    property cdsNaoPermiteVenda   : TUniClientDataSet read FCdsNaoPermiteVenda;
    property cdsParaDestino       : TUniClientDataSet read FCdsParaDestino;

    property itemNaoPermiteVenda  : TItemSelecao      read GetItemNaoPermiteVenda;
    property itemParaDestino      : TItemSelecao      read GetItemParaDestino;

  end;

const
  NPV_FORNECEDOR   = 'F';
  NPV_DEPARTAMENTO = 'D';
  NPV_MARCA        = 'P';
  NPV_PRODUTO      = 'M';
  PD_ESTADO        = 'E';
  PD_CIDADE        = 'C';
  PD_REGIAO        = 'R';
  PD_CLIENTE       = 'L';

implementation

uses
  untFuncoesSimples, untConsultas, untPanelCxClientes, untPnlDadosCliente,
  untPanelCxFornecedor, untPnlDadosFornecedor;

{ TItemSelecao }

class function TItemSelecao.New: TItemSelecao;
begin
  Result := Self.Create;
end;

function TItemSelecao.fExecutarPesquisa(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
begin
  Result := True;

  If Assigned(FFncPesquisa) Then
    Result := FFncPesquisa(AKey, AArrayConsulta);
end;

function TItemSelecao.FncPesquisa(const Value: TFncPesquisaItemSelecao): TItemSelecao;
begin
  Result := Self;
  FFncPesquisa := Value;
end;

function TItemSelecao.Codigo(const Value: String): TItemSelecao;
begin
  Result := Self;
  FCodigo := Value;
end;

function TItemSelecao.Descricao(const Value: String): TItemSelecao;
begin
  Result := Self;
  FDescricao := Value;
end;

function TItemSelecao.Campo(const Value: String): TItemSelecao;
begin
  Result := Self;
  FCampo := Value;
end;

function TItemSelecao.Campo: String;
begin
  Result := FCampo;
end;

function TItemSelecao.Codigo: String;
begin
  Result := FCodigo;
end;

function TItemSelecao.Descricao: String;
begin
  Result := FDescricao;
end;

function TItemSelecao.EdtTamanho: Integer;
begin
  Result := FEdtTamanho;
end;

function TItemSelecao.EdtTamanho(const Value: Integer): TItemSelecao;
begin
  Result := Self;
  FEdtTamanho := Value;
end;

function TItemSelecao.EdtTipo: TTipoTexto;
begin
  Result := FEdtTipo;
end;

function TItemSelecao.EdtTipo(const Value: TTipoTexto): TItemSelecao;
begin
  Result := Self;
  FEdtTipo := Value;
end;

{ TListaItens }

function TListaItens.fAdicionaItem(const ACodigo, ADescricao, ACampo: String;
  const AFncPesquisa: TFncPesquisaItemSelecao; const AEdtTipo: TTipoTexto;
  const AEdtTamanho: Integer): TListaItens;
begin
  Result := Self;

  If Not Assigned(FRadioGroup) Then
    Exit;

  FRadioGroup.Items.AddObject(ADescricao, TItemSelecao
                                             .New
                                             .Codigo(ACodigo)
                                             .Descricao(ADescricao)
                                             .Campo(ACampo)
                                             .FncPesquisa(AFncPesquisa)
                                             .EdtTipo(AEdtTipo)
                                             .EdtTamanho(AEdtTamanho));
end;

procedure TListaItens.pLimpar;
begin
  If Assigned(FRadioGroup) Then
    FRadioGroup.ItemIndex := 0;

  FRadioGroup.Enabled := True;
  FEdit.Clear;
end;

procedure TListaItens.pLimparTudo;
begin
  FRadioGroup.Items.Clear;
  pLimpar;
end;

function TListaItens.&Label(const Value: TLabel): TListaItens;
begin
  Result := Self;
  FLabel := Value;
end;

function TListaItens.&Label: TLabel;
begin
  Result := FLabel;
end;

class function TListaItens.New: TListaItens;
begin
  Result := Self.Create;
end;

constructor TListaItens.Create;
begin
  FRadioGroup := nil;
  FEdit       := nil;
  FLabel      := nil;
end;

procedure TListaItens.edtKeyPress(Sender: TObject; var Key: Char);
var
  LArrayConsulta : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    If fItemSelecionado.fExecutarPesquisa(Key, LArrayConsulta) Then
    Begin
      If Assigned(FFncValidaCampos) Then
        FFncValidaCampos(FEdit, True)
    End;
  End
  Else
  Begin
    If Assigned(FKeyPress) Then
      FKeyPress(Sender, Key);
  End;
end;

function TListaItens.Edit(const Value: TEditFocus): TListaItens;
begin
  Result := Self;
  FEdit := Value;

  If Assigned(FEdit.OnKeyPress) Then
    FKeyPress := FEdit.OnKeyPress;

  FEdit.OnKeyPress := edtKeyPress;
end;

function TListaItens.Edit: TEditFocus;
begin
  Result := FEdit;
end;

function TListaItens.Item(const ACodigo: String): TItemSelecao;
begin
  If Not Assigned(FRadioGroup) Then
    Exit(nil);

  pSelecionaItem(ACodigo);
  Result := fItemSelecionado;
end;

function TListaItens.Item(const AItemIndex: Integer): TItemSelecao;
begin
  If Not Assigned(FRadioGroup) Then
    Exit(nil);

  Result := FRadioGroup.Items.Objects[AItemIndex] as TItemSelecao;
end;

function TListaItens.RadioGroup: TRadioGroup;
begin
  Result := FRadioGroup;
end;

procedure TListaItens.rdgClick(Sender: TObject);
begin
  If Assigned(FClickRadioGroup) Then
    FClickRadioGroup(Sender);

  If Not Assigned(FRadioGroup) Then
    Exit;

  If Not Assigned(FLabel) Then
    Exit;

  If Not Assigned(FEdit) Then
    Exit;

  FLabel.Caption  := FRadioGroup.Items[FRadioGroup.ItemIndex];
  FEdit.MaxLength := fItemSelecionado.EdtTamanho;
  FEdit.TamCampo  := fItemSelecionado.EdtTamanho;
  FEdit.TipoTexto := fItemSelecionado.EdtTipo;
  FEdit.Clear;

  pSetFocus(FEdit);
end;

function TListaItens.fItemSelecionado: TItemSelecao;
begin
  If Not Assigned(FRadioGroup) Then
    Exit(nil);

  Result := FRadioGroup.Items.Objects[FRadioGroup.ItemIndex] as TItemSelecao;
end;

function TListaItens.FncValidaCampos(
  const Value: TFncValidaCampos): TListaItens;
begin
  Result := Self;
  FFncValidaCampos := Value;
end;

function TListaItens.Form(const Value: TForm): TListaItens;
begin
  Result := Self;
  FForm := Value;
end;

procedure TListaItens.pSelecionaItem(const AItemIndex: Integer);
begin
  If Not Assigned(FRadioGroup) Then
    Exit;

  FRadioGroup.ItemIndex := AItemIndex;
end;

procedure TListaItens.pSelecionaItem(const ACodigo: String);
var
  intContador : Integer;
begin
  If Not Assigned(FRadioGroup) Then
    Exit;

  For intContador := 0 to Pred(FRadioGroup.Items.Count) Do
  Begin
    If ACodigo = TItemSelecao(FRadioGroup.Items.Objects[intContador]).Codigo Then
    Begin
      FRadioGroup.ItemIndex := intContador;
      Break;
    End;
  End;
end;

function TListaItens.RadioGroup(const Value: TRadioGroup): TListaItens;
begin
  Result := Self;
  FRadioGroup := Value;

  If Assigned(FRadioGroup.OnClick) Then
    FClickRadioGroup := FRadioGroup.OnClick;

  FRadioGroup.OnClick := rdgClick;
end;

{ TRestricaoVenda }

function TRestricaoVenda.CodigoRestricaoVenda(
  const Value: String): TRestricaoVenda;
begin
  Result := Self;
  FCodigoRestricaoVenda := Value;
end;

constructor TRestricaoVenda.Create;
begin
  FListaNaoPermiteVenda := TListaItens.New;
  FListaParaDestino     := TListaItens.New;

  FQryRestrivaoVenda  := fCriaQuery(nil);

  pCarregaQryRestricaoVenda;
  pCriaDataSetNaoPermiteVenda;
  pCriaDataSetParaDestino;

  FListaRemoveNaoPermiteVenda := TStringList.Create;
  FListaRemoveParaDestino     := TStringList.Create;
end;

destructor TRestricaoVenda.Destroy;
begin
  FreeAndNil(FListaNaoPermiteVenda);
  FreeAndNil(FListaParaDestino);

  FreeAndNil(FListaNaoPermiteVenda);
  FreeAndNil(FListaParaDestino);

  FreeAndNil(FQryRestrivaoVenda);
  FreeAndNil(FCdsNaoPermiteVenda);
  FreeAndNil(FCdsParaDestino);

  inherited;
end;

function TRestricaoVenda.EditPesquisaNaoPermiteVenda(
  const Value: TEditFocus): TRestricaoVenda;
begin
  Result := Self;
  FListaNaoPermiteVenda.Edit(Value);
end;

function TRestricaoVenda.EditPesquisaParaDestino(
  const Value: TEditFocus): TRestricaoVenda;
begin
  Result := Self;
  FListaParaDestino.Edit(Value);
end;

procedure TRestricaoVenda.pAdicionarItemDataSet(
  const ACdsDataSet: TUniClientDataSet; const ALista: TListaItens;
  const ACodigo, ADescricao: String);
begin
  If ACdsDataSet.Locate('CODIGO', ACodigo, []) Then
  Begin
    fMensagem('', ALista.fItemSelecionado.Descricao+' já existe!', ['&Ok']);
    pSetFocus(ALista.Edit);
    Exit;
  End;

  ACdsDataSet.Append;
  ACdsDataSet.FieldByName('CODIGO').AsString    := ACodigo;
  ACdsDataSet.FieldByName('DESCRICAO').AsString := ADescricao;
  ACdsDataSet.Post;

  pHabilitaDesabilitaRadioGroup(ACdsDataSet, ALista);

  ALista.Edit.Clear;
  pSetFocus(ALista.Edit);
end;

function TRestricaoVenda.fAdicionarNaoPermiteVenda(const ACodigo,
  ADescricao: String): TRestricaoVenda;
begin
  Result := Self;

  pAdicionarItemDataSet(FCdsNaoPermiteVenda, FListaNaoPermiteVenda, ACodigo,
    ADescricao);
end;

function TRestricaoVenda.fAdicionarParaDestino(const ACodigo,
  ADescricao: String): TRestricaoVenda;
begin
  Result := Self;

  pAdicionarItemDataSet(FCdsParaDestino, FListaParaDestino, ACodigo,
    ADescricao);
end;

function TRestricaoVenda.FncValidaCampos(
  const Value: TFncValidaCampos): TRestricaoVenda;
begin
  Result := Self;
  FFncValidaCampos := Value;
end;

function TRestricaoVenda.Form(const Value: TForm): TRestricaoVenda;
begin
  Result := Self;
  FForm := Value;
end;

function TRestricaoVenda.GetItemNaoPermiteVenda: TItemSelecao;
begin
  Result := FListaNaoPermiteVenda.fItemSelecionado;
end;

function TRestricaoVenda.GetItemParaDestino: TItemSelecao;
begin
  Result := FListaParaDestino.fItemSelecionado;
end;

function TRestricaoVenda.LabelTipoNaoPermiteVenda(
  const Value: TLabel): TRestricaoVenda;
begin
  Result := Self;
  FListaNaoPermiteVenda.&Label(Value);
end;

function TRestricaoVenda.LabelTipoParaDestino(
  const Value: TLabel): TRestricaoVenda;
begin
  Result := Self;
  FListaParaDestino.&Label(Value);
end;

class function TRestricaoVenda.New: TRestricaoVenda;
begin
  Result := Self.Create;
end;

procedure TRestricaoVenda.pCarregaItensNaoPermiteVenda;
begin
  FListaNaoPermiteVenda.pLimparTudo;

  FListaNaoPermiteVenda
    .Form(FForm)
    .FncValidaCampos(FFncValidaCampos)
    .fAdicionaItem(NPV_FORNECEDOR, 'Fornecedor', 'NPV_CODFOR', fPesquisaFornecedor, ttNumerico, 8)
    .fAdicionaItem(NPV_DEPARTAMENTO, 'Departamento', 'NPV_CODDEP', fPesquisaDepartamento, ttNumerico, 3)
    .fAdicionaItem(NPV_MARCA, 'Marca', 'NPV_CODMAR', fPesquisaMarca, ttNumerico, 6)
    .fAdicionaItem(NPV_PRODUTO, 'Produto', 'NPV_CODITE', fPesquisaProduto, ttNumerico, 5)
    .pLimpar;
end;

procedure TRestricaoVenda.pCarregaItensParaDestino;
begin
  FListaParaDestino.pLimparTudo;

  FListaParaDestino
    .Form(FForm)
    .FncValidaCampos(FFncValidaCampos)
    .fAdicionaItem(PD_ESTADO, 'Estado', 'PDT_ESTADO', fPesquisaEstado, ttAlfabetico, 2)
    .fAdicionaItem(PD_CIDADE, 'Cidade', 'PDT_CODCID', fPesquisaCidade, ttNumerico, 5)
    .fAdicionaItem(PD_REGIAO, 'Região', 'PDT_CODREG', fPesquisaRegiao, ttNumerico, 5)
    .fAdicionaItem(PD_CLIENTE, 'Cliente', 'PDT_CODCLI', fPesquisaCliente, ttNumerico, 8)
    .pLimpar;
end;

procedure TRestricaoVenda.pCarregaQryRestricaoVenda;
begin
  FQryRestrivaoVenda.SQL.Text := ' SELECT * FROM RTVVND WHERE FALSE ';
end;

procedure TRestricaoVenda.pCarregarDadosComponentes;
begin
  pCarregaItensNaoPermiteVenda;
  pCarregaItensParaDestino;
end;

procedure TRestricaoVenda.pCarregarDadosNaoPermiteVenda;
var
  LqryDados  : TUniQuery;
  LCodigo    : String;
  LDescricao : String;
begin
  LqryDados := fCriaQuery(nil);
  Try
    LqryDados.Close;
    LqryDados.SQL.Text := ' SELECT '
                        + '        NPV_CODFOR '
                        + '      , NPV_CODDEP '
                        + '      , NPV_CODMAR '
                        + '      , NPV_CODITE '
                        + '      , FOR_NOMFOR '
                        + '      , DEP_DESCRI '
                        + '      , MAR_DESMAR '
                        + '      , ITE_DESITE '
                        + '   FROM RTVNPV '
                        + '   LEFT JOIN CADFOR ON FOR_CODFOR = NPV_CODFOR '
                        + '   LEFT JOIN CADDEP ON DEP_CODIGO = NPV_CODDEP '
                        + '   LEFT JOIN CADMAR ON MAR_CODMAR = NPV_CODMAR '
                        + '   LEFT JOIN CADITE ON ITE_CODITE = NPV_CODITE '
                        + '  WHERE NPV_CODRTV = :CODRTV ';
    LqryDados.ParamByName('CODRTV').AsString := FCodigoRestricaoVenda;
    LqryDados.Open;

    FCdsNaoPermiteVenda.EmptyDataSet;

    LqryDados.First;
    While Not LqryDados.Eof Do
    Begin
      If Not fEmptyStr(LqryDados.FieldByName('NPV_CODFOR').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('NPV_CODFOR').AsString;
        LDescricao := LqryDados.FieldByName('FOR_NOMFOR').AsString;

        If FListaNaoPermiteVenda.RadioGroup.Enabled Then
          FListaNaoPermiteVenda.pSelecionaItem(NPV_FORNECEDOR);
      End
      Else If Not fEmptyStr(LqryDados.FieldByName('NPV_CODDEP').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('NPV_CODDEP').AsString;
        LDescricao := LqryDados.FieldByName('DEP_DESCRI').AsString;

        If FListaNaoPermiteVenda.RadioGroup.Enabled Then
          FListaNaoPermiteVenda.pSelecionaItem(NPV_DEPARTAMENTO);
      End
      Else If Not fEmptyStr(LqryDados.FieldByName('NPV_CODMAR').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('NPV_CODMAR').AsString;
        LDescricao := LqryDados.FieldByName('MAR_DESMAR').AsString;

        If FListaNaoPermiteVenda.RadioGroup.Enabled Then
          FListaNaoPermiteVenda.pSelecionaItem(NPV_MARCA);
      End
      Else If Not fEmptyStr(LqryDados.FieldByName('NPV_CODITE').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('NPV_CODITE').AsString;
        LDescricao := LqryDados.FieldByName('ITE_DESITE').AsString;

        If FListaNaoPermiteVenda.RadioGroup.Enabled Then
          FListaNaoPermiteVenda.pSelecionaItem(NPV_PRODUTO);
      End;

      fAdicionarNaoPermiteVenda(LCodigo, LDescricao);
      LqryDados.Next;
    End;
  Finally
    FreeAndNil(LqryDados);
  End;
end;

procedure TRestricaoVenda.pCarregarDadosParaDestino;
var
  LqryDados  : TUniQuery;
  LCodigo    : String;
  LDescricao : String;
begin
  LqryDados := fCriaQuery(nil);
  Try
    LqryDados.Close;
    LqryDados.SQL.Text := ' SELECT '
                        + '        PDT_ESTADO '
                        + '      , PDT_CODCID '
                        + '      , PDT_CODREG '
                        + '      , PDT_CODCLI '
                        + '      , CID_NOMCID '
                        + '      , REG_DESREG '
                        + '      , CLI_NOMCLI '
                        + '   FROM RTVPDT '
                        + '   LEFT JOIN CADCID ON CID_CODCID = PDT_CODCID '
                        + '   LEFT JOIN CADREG ON REG_CODREG = PDT_CODREG '
                        + '   LEFT JOIN CADCLI ON CLI_CODCLI = PDT_CODCLI '
                        + '  WHERE PDT_CODRTV = :CODRTV ';
    LqryDados.ParamByName('CODRTV').AsString := FCodigoRestricaoVenda;
    LqryDados.Open;

    FCdsParaDestino.EmptyDataSet;

    LqryDados.First;
    While Not LqryDados.Eof Do
    Begin
      If Not fEmptyStr(LqryDados.FieldByName('PDT_ESTADO').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('PDT_ESTADO').AsString;
        LDescricao := fRetNomeEstado(LqryDados.FieldByName('PDT_ESTADO').AsString);

        If FListaParaDestino.RadioGroup.Enabled Then
          FListaParaDestino.pSelecionaItem(PD_ESTADO);
      End
      Else If Not fEmptyStr(LqryDados.FieldByName('PDT_CODCID').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('PDT_CODCID').AsString;
        LDescricao := LqryDados.FieldByName('CID_NOMCID').AsString;

        If FListaParaDestino.RadioGroup.Enabled Then
          FListaParaDestino.pSelecionaItem(PD_CIDADE);
      End
      Else If Not fEmptyStr(LqryDados.FieldByName('PDT_CODREG').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('PDT_CODREG').AsString;
        LDescricao := LqryDados.FieldByName('REG_DESREG').AsString;

        If FListaParaDestino.RadioGroup.Enabled Then
          FListaParaDestino.pSelecionaItem(PD_REGIAO);
      End
      Else If Not fEmptyStr(LqryDados.FieldByName('PDT_CODCLI').AsString) Then
      Begin
        LCodigo    := LqryDados.FieldByName('PDT_CODCLI').AsString;
        LDescricao := LqryDados.FieldByName('CLI_NOMCLI').AsString;

        If FListaParaDestino.RadioGroup.Enabled Then
          FListaParaDestino.pSelecionaItem(PD_CLIENTE);
      End;

      fAdicionarParaDestino(LCodigo, LDescricao);
      LqryDados.Next;
    End;
  Finally
    FreeAndNil(LqryDados);
  End;
end;

procedure TRestricaoVenda.pCarregarInformacoes;
begin
  If fEmptyStr(FCodigoRestricaoVenda) Then
    Exit;

  pLimpar(False);

  pCarregarDadosNaoPermiteVenda;
  pCarregarDadosParaDestino;

  pHabilitaDesabilitaRadioGroup(FCdsNaoPermiteVenda, FListaNaoPermiteVenda);
  pHabilitaDesabilitaRadioGroup(FCdsParaDestino, FListaParaDestino);
end;

procedure TRestricaoVenda.pCriaDataSetNaoPermiteVenda;
var
  LFieldDef : TFieldDef;
begin
  FCdsNaoPermiteVenda := TUniClientDataSet.Create(FForm);

  LFieldDef := FCdsNaoPermiteVenda.FieldDefs.AddFieldDef;
  LFieldDef.Name     := 'CODIGO';
  LFieldDef.DataType := ftString;
  LFieldDef.Size     := 20;
  LFieldDef.Required := True;

  LFieldDef := FCdsNaoPermiteVenda.FieldDefs.AddFieldDef;
  LFieldDef.Name     := 'DESCRICAO';
  LFieldDef.DataType := ftString;
  LFieldDef.Size     := 70;
  LFieldDef.Required := True;

  FCdsNaoPermiteVenda.CreateDataSet;
  FCdsNaoPermiteVenda.Open;
end;

procedure TRestricaoVenda.pCriaDataSetParaDestino;
var
  LFieldDef : TFieldDef;
begin
  FCdsParaDestino := TUniClientDataSet.Create(FForm);

  LFieldDef := FCdsParaDestino.FieldDefs.AddFieldDef;
  LFieldDef.Name     := 'CODIGO';
  LFieldDef.DataType := ftString;
  LFieldDef.Size     := 20;
  LFieldDef.Required := True;

  LFieldDef := FCdsParaDestino.FieldDefs.AddFieldDef;
  LFieldDef.Name     := 'DESCRICAO';
  LFieldDef.DataType := ftString;
  LFieldDef.Size     := 70;
  LFieldDef.Required := True;

  FCdsParaDestino.CreateDataSet;
  FCdsParaDestino.Open;
end;

procedure TRestricaoVenda.pGravaNaoPermiteVenda;
var
  LQryDados : TUniQuery;
  LCampo    : String;
begin
  LQryDados := fCriaQuery(Nil);
  Try
    LCampo := FListaNaoPermiteVenda.fItemSelecionado.Campo;

    LQryDados.Close;
    LQryDados.SQL.Text := 'SELECT * FROM RTVNPV '
                        + ' WHERE NPV_CODRTV = :CODRTV '
                        + '   AND '+LCampo+' = :'+LCampo;

    FCdsNaoPermiteVenda.First;
    While Not FCdsNaoPermiteVenda.Eof Do
    Begin
      LQryDados.Close;
      LQryDados.ParamByName('CODRTV').AsString := FCodigoRestricaoVenda;
      LQryDados.ParamByName(LCampo).AsString   := FCdsNaoPermiteVenda.FieldByName('CODIGO').AsString;
      LQryDados.Open;

      If LQryDados.IsEmpty Then
      Begin
        LQryDados.Append;
        LQryDados.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RTVNPV', VS_strCodEmp);
        LQryDados.FieldByName('NPV_CODRTV').AsString := FCodigoRestricaoVenda;
        LQryDados.FieldByName(LCampo).AsString       := FCdsNaoPermiteVenda.FieldByName('CODIGO').AsString;
        LQryDados.Post;
      End;

      FCdsNaoPermiteVenda.Next;
    End;
  Finally
    FreeAndNil(LQryDados);
  End;
end;

procedure TRestricaoVenda.pGravaParaDestino;
var
  LQryDados : TUniQuery;
  LCampo    : String;
begin
  LQryDados := fCriaQuery(Nil);
  Try
    LCampo := FListaParaDestino.fItemSelecionado.Campo;

    LQryDados.Close;
    LQryDados.SQL.Text := 'SELECT * FROM RTVPDT '
                        + ' WHERE PDT_CODRTV = :CODRTV '
                        + '   AND '+LCampo+' = :'+LCampo;

    FCdsParaDestino.First;
    While Not FCdsParaDestino.Eof Do
    Begin
      LQryDados.Close;
      LQryDados.ParamByName('CODRTV').AsString := FCodigoRestricaoVenda;
      LQryDados.ParamByName(LCampo).AsString   := FCdsParaDestino.FieldByName('CODIGO').AsString;
      LQryDados.Open;

      If LQryDados.IsEmpty Then
      Begin
        LQryDados.Append;
        LQryDados.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RTVPDT', VS_strCodEmp);
        LQryDados.FieldByName('PDT_CODRTV').AsString := FCodigoRestricaoVenda;
        LQryDados.FieldByName(LCampo).AsString       := FCdsParaDestino.FieldByName('CODIGO').AsString;
        LQryDados.Post;
      End;

      FCdsParaDestino.Next;
    End;
  Finally
    FreeAndNil(LQryDados);
  End;
end;

procedure TRestricaoVenda.pGravar;
begin
  pRemoveNaoPermiteVenda;
  pRemoveParaDestino;

  pGravaNaoPermiteVenda;
  pGravaParaDestino;
end;

procedure TRestricaoVenda.pHabilitaDesabilitaRadioGroup(
  const ACdsDataSet: TUniClientDataSet; const ALista: TListaItens);
begin
  ALista.RadioGroup.Enabled := (ACdsDataSet.RecordCount = 0) And
                               (fEmptyStr(FCodigoRestricaoVenda));
end;

function  TRestricaoVenda.fPesquisaCidade(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
begin
  Result := fPesqCidade(FForm, FListaParaDestino.Edit, Nil, Nil, Nil, AKey, AArrayConsulta);
end;

function  TRestricaoVenda.fPesquisaCliente(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
Var
  objfrmPnl : TPanelCxClientes;
begin
  Try
    objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
    objfrmPnl.strNomForm := FForm.name;

    Result := fPesqCliente(conCliCompleta, FForm, FListaParaDestino.Edit, Nil, Nil, AKey,
                AArrayConsulta, True, objfrmPnl)
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

function  TRestricaoVenda.fPesquisaDepartamento(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
begin
 Result :=  fPesqDepartamento(FForm, FListaNaoPermiteVenda.Edit, Nil, Nil, AKey, AArrayConsulta);
end;

function  TRestricaoVenda.fPesquisaEstado(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
begin
  Result := fPesqEstado(FForm, FListaParaDestino.Edit, Nil, Nil, AKey, AArrayConsulta);
end;

function  TRestricaoVenda.fPesquisaFornecedor(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
Var
  objPnlLegenda: TPanelCxFornecedor;
Begin
  Try
    objPnlLegenda := TPanelCxFornecedor.Create(TfrmPnlDadosFornecedor);

    Result := fPesqFornecedor(conForCompleta, FForm, FListaNaoPermiteVenda.Edit, Nil, Nil,
                AKey, AArrayConsulta, True, objPnlLegenda);
  Finally
    FreeAndNil(objPnlLegenda);
  End;
end;

function  TRestricaoVenda.fPesquisaMarca(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
begin
  Result := fPesqMarcas(FForm, FListaNaoPermiteVenda.Edit, Nil, Nil, AKey, AArrayConsulta);
end;

function  TRestricaoVenda.fPesquisaProduto(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
begin
  Result := fPesqItem(conIteSimples, FForm, FListaNaoPermiteVenda.Edit, Nil, Nil, AKey, AArrayConsulta, True, Nil, 'Consulta de Itens', '1');
end;

function TRestricaoVenda.fPesquisaRegiao(var AKey: Char;
  var AArrayConsulta: TConsultasArray): Boolean;
begin
  Result := fPesqRegiao(FForm, FListaParaDestino.Edit, Nil, Nil, AKey, AArrayConsulta);
end;

function TRestricaoVenda.fRemoveNaoPermiteVenda(
  const ACodigo: String): TRestricaoVenda;
begin
  Result := Self;

  If FCdsNaoPermiteVenda.Locate('CODIGO', ACodigo, []) Then
  Begin
    If Not fEmptyStr(FCodigoRestricaoVenda) Then
      FListaRemoveNaoPermiteVenda.Add(ACodigo);

    FCdsNaoPermiteVenda.Delete;
  End;

  pHabilitaDesabilitaRadioGroup(FCdsNaoPermiteVenda, FListaNaoPermiteVenda);
end;

function TRestricaoVenda.fRemoveParaDestino(
  const ACodigo: String): TRestricaoVenda;
begin
  Result := Self;

  If FCdsParaDestino.Locate('CODIGO', ACodigo, []) Then
  Begin
    If Not fEmptyStr(FCodigoRestricaoVenda) Then
      FListaRemoveParaDestino.Add(ACodigo);

    FCdsParaDestino.Delete;
  End;

  pHabilitaDesabilitaRadioGroup(FCdsParaDestino, FListaParaDestino);
end;

procedure TRestricaoVenda.pLimpar(const ALimparCodigoRestricaoVenda: Boolean);
begin
  If ALimparCodigoRestricaoVenda Then
    FCodigoRestricaoVenda := EmptyStr;

  FCdsNaoPermiteVenda.EmptyDataSet;
  FCdsParaDestino.EmptyDataSet;

  If Assigned(FListaNaoPermiteVenda) Then
    FListaNaoPermiteVenda.pLimpar;

  If Assigned(FListaParaDestino) Then
    FListaParaDestino.pLimpar;

  FListaRemoveNaoPermiteVenda.Clear;
  FListaRemoveParaDestino.Clear;
end;

procedure TRestricaoVenda.pRemoveNaoPermiteVenda;
var
  intContador : Integer;
  LQryDados   : TUniQuery;
  LCampo      : String;
begin
  If FListaRemoveNaoPermiteVenda.Count = 0 Then
    Exit;

  LQryDados := fCriaQuery(Nil);
  Try
    LCampo := FListaNaoPermiteVenda.fItemSelecionado.Campo;

    LQryDados.SQL.Text := 'DELETE FROM RTVNPV '
                        + ' WHERE NPV_CODRTV = :CODRTV '
                        + '   AND '+LCampo+' = :'+LCampo;

    For intContador := 0 to Pred(FListaRemoveNaoPermiteVenda.Count) Do
    Begin
      LQryDados.Close;
      LQryDados.ParamByName('CODRTV').AsString := FCodigoRestricaoVenda;
      LQryDados.ParamByName(LCampo).AsString   := FListaRemoveNaoPermiteVenda.Strings[intContador];
      LQryDados.ExecSQL;
    End;
  Finally
    FreeAndNil(LQryDados);
  End;
end;

procedure TRestricaoVenda.pRemoveParaDestino;
var
  intContador : Integer;
  LQryDados   : TUniQuery;
  LCampo      : String;
begin
  If FListaRemoveParaDestino.Count = 0 Then
    Exit;

  LQryDados := fCriaQuery(Nil);
  Try
    LCampo := FListaParaDestino.fItemSelecionado.Campo;

    LQryDados.SQL.Text := 'DELETE FROM RTVPDT '
                        + ' WHERE PDT_CODRTV = :CODRTV '
                        + '   AND '+LCampo+' = :'+LCampo;

    For intContador := 0 to Pred(FListaRemoveParaDestino.Count) Do
    Begin
      LQryDados.Close;
      LQryDados.ParamByName('CODRTV').AsString := FCodigoRestricaoVenda;
      LQryDados.ParamByName(LCampo).AsString   := FListaRemoveParaDestino.Strings[intContador];
      LQryDados.ExecSQL;
    End;
  Finally
    FreeAndNil(LQryDados);
  End;
end;

function TRestricaoVenda.RadioGroupNaoPermiteVenda(
  const Value: TRadioGroup): TRestricaoVenda;
begin
  Result := Self;
  FListaNaoPermiteVenda.RadioGroup(Value);
end;

function TRestricaoVenda.RadioGroupParaDestino(
  const Value: TRadioGroup): TRestricaoVenda;
begin
  Result := Self;
  FListaParaDestino.RadioGroup(Value);
end;

end.
