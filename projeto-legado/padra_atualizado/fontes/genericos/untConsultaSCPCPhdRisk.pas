unit untConsultaSCPCPhdRisk;

interface

uses Classes, XMLDoc, XMLIntf, untConsultaSCPC;

Type
  TSinteseCadastral = class(TComponent)
  private
    FCpf: String;
    FNome: String;
    FDataNascimento: String;
    FTituloEleitor: String;
    FNomeMae: String;
  public
    procedure Clear;
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
  published
    property strCpf: String read FCpf;
    property strNome: String read FNome;
    property strDataNascimento: String read FDataNascimento;
    property strTituloEleitor: String read FTituloEleitor;
    property strNomeMae: String read FNomeMae;
  end;

Type
  TSinteseCadastralCnpj = class(TComponent)
  private
    FRazaoSocial: String;
    FEndereco: String;
    FBairro: String;
    FCep: String;
    FCidade: String;
    FUf: String;
    FCondicao: String;
    FNaturezaJuridica: String;
    FDDD1: String;
    FDDD2: String;
    FTelefone1: String;
    FTelefone2: String;
  public
    procedure Clear;
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
  published
    property strRazaoSocial: String read FRazaoSocial;
    property strEndereco: String read FEndereco;
    property strBairro: String read FBairro;
    property strCep: String read FCep;
    property strCidade: String read FCidade;
    property strUf: String read FUf;
    property strCondicao: String read FCondicao;
    property strNaturezaJuridica: String read FNaturezaJuridica;
    property strDDD1: String read FDDD1;
    property strDDD2: String read FDDD1;
    property strTelefone1: String read FTelefone1;
    property strTelefone2: String read FTelefone2;
  end;

Type
  TConfiraFone = Class(TComponent)
  public
    strDDD: String;
    strTelefone: String;
    strCpf: String;
    strAssinante: String;
    strEndereco: String;
    strBairro: String;
    strCidade: String;
    strCep: String;
  end;

Type
  TListaConfiraFone = class(TComponent)
  private
    FConfiraFones: Array Of TConfiraFone;
    function getCount: Integer;
    function getConfiraFone(Index: Integer): TConfiraFone;
  public
    procedure Clear;
    procedure Add(Value: TConfiraFone);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property ConfiraFone[Index: Integer]: TConfiraFone read getConfiraFone; default;
  end;

Type
  TPassagem = Class(TComponent)
  public
    strCodigoEntidade: String;
    strCodigoSocio: String;
    strRazaoSocial: String;
    strCidade: String;
    strOrigemConsulta: String;
    strDataConsulta: String;
  end;

Type
  TListaPassagens = class(TComponent)
  private
    FPassagens: Array Of TPassagem;
    function getCount: Integer;
    function getPassagem(Index: Integer): TPassagem;
  public
    procedure Clear;
    procedure Add(Value: TPassagem);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property Passagem[Index: Integer]: TPassagem read getPassagem; default;
  end;

Type
  TDebito = Class(TComponent)
  public
    strOrigem: String;
    strDocumento: String;
    strRazaoSocial: String;
    strCidade: String;
    strDataInclusao: String;
    strDataAtraso: String;
    strValor: String;
  end;

Type
  TListaDebitos = class(TComponent)
  private
    FDebitos: Array Of TDebito;
    FDateFormat: String;
    FDateSeparator: Char;
    FTitulo: string;
    function getCount: Integer;
    function getDebito(Index: Integer): TDebito;
  public
    procedure Clear;
    procedure Add(Value: TDebito);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    property Titulo: String read FTitulo write FTitulo;
    property DateFormat: String read FDateFormat write FDateFormat;
    property DateSeparator: Char read FDateSeparator write FDateSeparator;

    property Count: Integer read getCount;
    property Debito[Index: Integer]: TDebito read getDebito; default;
  end;

Type
  TScpcPjAcim = Class(TComponent)
  public
    strContrato: String;
    strDataCadastro: String;
    strDataVencimento: String;
    strTipoRegistro: String;
    strTipoDocumento: String;
    strValor: String;
    strOrigem: String;
    strObservacao: String;
  end;

Type
  TListaScpcPjAcim = class(TComponent)
  private
    FArrScpcPj: Array Of TScpcPjAcim;
    function getCount: Integer;
    function getScpcPj(Index: Integer): TScpcPjAcim;
  public
    procedure Clear;
    procedure Add(Value: TScpcPjAcim);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property ScpcPj[Index: Integer]: TScpcPjAcim read getScpcPj; default;
  end;

Type
  TProtesto = Class(TComponent)
  public
    strTipo: String; // Fisica ou Juridica
    strNome: String;
    strData: String;
    strCartorio: String;
    strPraca: String;
    strValor: String;
  end;

Type
  TListaProtestos = class(TComponent)
  private
    FMensagem: String;
    FProtestos: Array Of TProtesto;
    function getCount: Integer;
    function getProtesto(Index: Integer): TProtesto;
  public
    procedure Clear;
    procedure Add(Value: TProtesto);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property Protesto[Index: Integer]: TProtesto read getProtesto; default;
    property strMensagem: String read FMensagem;
  end;

Type
  TAcao = Class(TComponent)
  public
    strAcao: String; // Acoes civeis ou Acoes
    strAcionado: String;
    strAutor: String;
    strData: String;
    strUltima: String;
    strVara: String;
    strCidade: String;
    strProcesso: String;
    strTipo: String;
    strValor: String;
    strQuantidade: String;
  end;

Type
  TListaAcoes = class(TComponent)
  private
    FAcoes: Array Of TAcao;
    function getCount: Integer;
    function getAcao(Index: Integer): TAcao;
  public
    procedure Clear;
    procedure Add(Value: TAcao);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property Acao[Index: Integer]: TAcao read getAcao; default;
  end;

Type
  TCheque = Class(TComponent)
  public
    strbanco: String;
    strdescricao: String;
    strUltimo: String;
    strQuantidade: String;
  end;

Type
  TListaCheques = class(TComponent)
  private
    FCheques: Array Of TCheque;
    function getCount: Integer;
    function getCheque(Index: Integer): TCheque;
  public
    procedure Clear;
    procedure Add(Value: TCheque);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property Cheque[Index: Integer]: TCheque read getCheque; default;
  end;

Type
  TBacen = Class(TComponent)
  public
    strBanco: String;
    strAgencia: String;
    strQuantidade: String;
    strDescAlinea: String;
    strDescBanco: String;
  end;

Type
  TListaBacen = class(TComponent)
  private
    FBacen: Array Of TBacen;
    function getCount: Integer;
    function getBacen(Index: Integer): TBacen;
  public
    procedure Clear;
    procedure Add(Value: TBacen);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property Bacen[Index: Integer]: TBacen read getBacen; default;
  end;

Type
  TVcqLocal = Class(TComponent)
  public
    strBanco: String;
    strAgencia: String;
    strChequeInicial: String;
    strChequeFinal: String;
    strValor: String;
    strAlinea: String;
    strContaCorrente: String;
    strRazaoSocial: String;
    strCidade: String;
  end;

Type
  TListaVcqLocal = class(TComponent)
  private
    FArrVcqLocal: Array Of TVcqLocal;
    function getCount: Integer;
    function getVcqLocal(Index: Integer): TVcqLocal;
  public
    procedure Clear;
    procedure Add(Value: TVcqLocal);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property VcqLocal[Index: Integer]: TVcqLocal read getVcqLocal; default;
  end;

Type
  TChequeSER = Class(TComponent)
  public
    strBanco: String;
    strAgencia: String;
    strChequeInicial: String;
    strChequeFinal: String;
    strValor: String;
    strAlinea: String;
    strContaCorrente: String;
    strRazaoSocial: String;
    strCidade: String;
  end;

Type
  TListaChequesSER = class(TComponent)
  private
    FChequesSER: Array Of TChequeSER;
    function getCount: Integer;
    function getChequeSER(Index: Integer): TChequeSER;
  public
    procedure Clear;
    procedure Add(Value: TChequeSER);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property ChequeSER[Index: Integer]: TChequeSER read getChequeSER; default;
  end;

Type
  TChequePre = Class(TComponent)
  public
    strData: String;
    strBanco: String;
    strAgencia: String;
    strCheque: String;
    strValor: String;
  end;

Type
  TListaChequesPre = class(TComponent)
  private
    FChequesPre: Array Of TChequePre;
    function getCount: Integer;
    function getChequePre(Index: Integer): TChequePre;
  public
    procedure Clear;
    procedure Add(Value: TChequePre);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property ChequePre[Index: Integer]: TChequePre read getChequePre; default;
  end;

Type
  TAlerta = Class(TComponent)
  public
    strDecricao: String;
    strData: String;
    strOrigem: String;
  end;

Type
  TListaAlertas = class(TComponent)
  private
    FAlertas: Array Of TAlerta;
    function getCount: Integer;
    function getAlerta(Index: Integer): TAlerta;
  public
    procedure Clear;
    procedure Add(Value: TAlerta);
    procedure LoadXml(node: IXmlNode);
    function AsString: String;
    destructor Destroy; override;

    property Count: Integer read getCount;
    property Alerta[Index: Integer]: TAlerta read getAlerta; default;
  end;

Type
  TConsultaSCPCPhdRisk = class(TConsultaSCPC)
  private
    FLogin: String;
    FSenha: String;
    FDocumento: String;
    FTipoConsulta: String;
    FXmlRetorno: TXMLDocument;
    FMsgErro: String;
    FSinteseCadastral: TSinteseCadastral;
    FSinteseCadastralCnpj: TSinteseCadastralCnpj;
    FConfiraFones: TListaConfiraFone;
    FPassagens: TListaPassagens;
    FDebitosLocacao: TListaDebitos;
    FDebitosAlimen: TListaDebitos;
    FScpcPjAcim: TListaScpcPjAcim;
    FProtestos: TListaProtestos;
    FAcoes: TListaAcoes;
    FCheques: TListaCheques;
    FChequesSER: TListaChequesSER;
    FChequesPre: TListaChequesPre;
    FBacen: TListaBacen;
    FVcqLoCal: TListaVcqLocal;
    FAlertas: TListaAlertas;
    FDebitos: TListaDebitos;
    procedure pSetDocumento(const Value: String);
  protected
    function fGetMsgErro: String; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetQtdCheques: Integer; override;
  public
    function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean; override;
    procedure pSaveToFile(Const strFileName: String); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

Const
  INT_COLUNAS = 50;
  NODE_REGISTRO = 'REGISTRO'; // Identificao dos Registros
  SCPC_SINTESE_CADASTRADAL = '11'; // Pessoa Fisica
  SCPC_JURIDICO_SIC_SINTESE_CADASTRADAL = '12'; // Pessoa Juridica

implementation

uses SysUtils, StrUtils, untFuncoesSimples, untConstantes, untFuncoes,
  untWebServerPhdrisk, untTypesSistema;

{ TSinteseCadastral }

procedure TSinteseCadastral.Clear;
begin
  FCpf := '';
  FNome := '';
  FDataNascimento := '';
  FTituloEleitor := '';
  FNomeMae := '';
end;

function TSinteseCadastral.AsString: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                 SINTESE CADASTRAL                ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  If Not fEmptyStr(FNome) Then
  Begin
    Result := Result + WrapText('C.P.F............: ' + FCpf,            #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Nome.............: ' + FNome,           #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data Nascimento..: ' + FDataNascimento, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Titulo de Eleitor: ' + FTituloEleitor,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Nome da Mae......: ' + FNomeMae,        #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End
  Else
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TSinteseCadastral.LoadXml(node: IXmlNode);
begin
  Clear;
  FCpf := fGetValorXml(node, 'cpf');
  FNome := fGetValorXml(node, 'nome');
  FTituloEleitor := fGetValorXml(node, 'titulo_de_eleitor');
  FNomeMae := fGetValorXml(node, 'nome_da_mae');
  FDataNascimento := fGetValorXml(node, 'data_do_nascimento');
end;

{ TSinteseCadastralCnpj }

procedure TSinteseCadastralCnpj.Clear;
begin
  FRazaoSocial := '';
  FEndereco := '';
  FBairro := '';
  FCep := '';
  FCidade := '';
  FUf := '';
  FCondicao := '';
  FNaturezaJuridica := '';
  FDDD1 := '';
  FDDD2 := '';
  FTelefone1 := '';
  FTelefone2 := '';
end;

function TSinteseCadastralCnpj.AsString: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '              SINTESE CADASTRAL - CNPJ            ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  If Not fEmptyStr(FRazaoSocial) Then
  Begin
    Result := Result + WrapText('Razao Social.....: ' + FRazaoSocial,      #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Endereco.........: ' + FEndereco,         #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Bairro...........: ' + FBairro,           #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('CEP..............: ' + FCep,              #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cidade...........: ' + FCidade,           #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('UF...............: ' + FUf,               #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Condicao.........: ' + FCondicao,         #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Natureza Juridica: ' + FNaturezaJuridica, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('DDD(1)...........: ' + FDDD1,             #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Telefone(1)......: ' + FTelefone1,        #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('DDD(2)...........: ' + FDDD2,             #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Telefone(2)......: ' + FTelefone2,        #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End
  Else
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TSinteseCadastralCnpj.LoadXml(node: IXmlNode);
begin
  Clear;
  FRazaoSocial := fGetValorXml(node, 'razao_social');
  FEndereco := fGetValorXml(node, 'endereco');
  FBairro := fGetValorXml(node, 'bairro');
  FCep := fGetValorXml(node, 'cep');
  FCidade := fGetValorXml(node, 'cidade');
  FUf := fGetValorXml(node, 'uf');
  FCondicao := fGetValorXml(node, 'condicao');
  FNaturezaJuridica := fGetValorXml(node, 'natureza_juridica');
  FDDD1 := fGetValorXml(node, 'ddd_1');
  FDDD2 := fGetValorXml(node, 'ddd_2');
  FTelefone1 := fGetValorXml(node, 'telefone_1');
  FTelefone2 := fGetValorXml(node, 'telefone_2');
end;

{ TListaConfiraFone }

procedure TListaConfiraFone.Add(Value: TConfiraFone);
begin
  SetLength(FConfiraFones, Succ(getCount));
  FConfiraFones[Pred(getCount)] := Value;
end;

function TListaConfiraFone.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                   CONFIRA FONE                   ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('DDD......: ' + Self[intIndex].strDDD,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Telefone.: ' + Self[intIndex].strTelefone,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('CPF......: ' + Self[intIndex].strCpf,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Assinante: ' + Self[intIndex].strAssinante, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Endereco.: ' + Self[intIndex].strEndereco,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Bairro...: ' + Self[intIndex].strBairro,    #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cidade...: ' + Self[intIndex].strCidade,    #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('CEP......: ' + Self[intIndex].strCep,       #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaConfiraFone.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FConfiraFones[intIndex]);
  SetLength(FConfiraFones, 0);
end;

destructor TListaConfiraFone.Destroy;
begin
  Clear;
  inherited;
end;

function TListaConfiraFone.getConfiraFone(Index: Integer): TConfiraFone;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FConfiraFones[Index];
end;

function TListaConfiraFone.getCount: Integer;
begin
  Result := Length(FConfiraFones);
end;

procedure TListaConfiraFone.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  confiraFoneNovo: TConfiraFone;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    confiraFoneNovo := TConfiraFone.Create(Self);

    confiraFoneNovo.strDDD := fGetValorXml(nodeRegistro, 'ddd');
    confiraFoneNovo.strTelefone := fGetValorXml(nodeRegistro, 'telefone');
    confiraFoneNovo.strCpf := fGetValorXml(nodeRegistro, 'cpf');
    confiraFoneNovo.strAssinante := fGetValorXml(nodeRegistro, 'assinante');
    confiraFoneNovo.strEndereco := fGetValorXml(nodeRegistro, 'endereco');
    confiraFoneNovo.strBairro := fGetValorXml(nodeRegistro, 'bairro');
    confiraFoneNovo.strCidade := fGetValorXml(nodeRegistro, 'cidade');
    confiraFoneNovo.strCep := fGetValorXml(nodeRegistro, 'cep');

    Add(confiraFoneNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

{ TListaPassagens }

procedure TListaPassagens.Add(Value: TPassagem);
begin
  SetLength(FPassagens, Succ(getCount));
  FPassagens[Pred(getCount)] := Value;
end;

function TListaPassagens.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      PASSAGEM                    ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Codigo da Entidade: ' + Self[intIndex].strCodigoEntidade,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Codigo do Socio...: ' + Self[intIndex].strCodigoSocio,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Razao Social......: ' + Self[intIndex].strRazaoSocial,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cidade............: ' + Self[intIndex].strCidade,          #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Origem da Consulta: ' + Self[intIndex].strOrigemConsulta,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data da Consulta..: ' + Self[intIndex].strDataConsulta,    #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaPassagens.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FPassagens[intIndex]);
  SetLength(FPassagens, 0);
end;

destructor TListaPassagens.Destroy;
begin
  Clear;
  inherited;
end;

function TListaPassagens.getPassagem(Index: Integer): TPassagem;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FPassagens[Index];
end;

function TListaPassagens.getCount: Integer;
begin
  Result := Length(FPassagens);
end;

procedure TListaPassagens.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  PassagemNovo: TPassagem;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    PassagemNovo := TPassagem.Create(Self);

    PassagemNovo.strCodigoEntidade  := fGetValorXml(nodeRegistro, 'codigo_da_entidade');
    PassagemNovo.strCodigoSocio     := fGetValorXml(nodeRegistro, 'codigo_do_socio');
    PassagemNovo.strRazaoSocial     := fGetValorXml(nodeRegistro, 'razao_social');
    PassagemNovo.strCidade          := fGetValorXml(nodeRegistro, 'cidade');
    PassagemNovo.strOrigemConsulta  := fGetValorXml(nodeRegistro, 'origem_da_consulta');
    PassagemNovo.strDataConsulta    := fGetValorXml(nodeRegistro, 'data_da_consulta');

    Add(PassagemNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

{ TListaDebitos }

procedure TListaDebitos.Add(Value: TDebito);
begin
  SetLength(FDebitos, Succ(getCount));
  FDebitos[Pred(getCount)] := Value;
end;

procedure TListaDebitos.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  debitoNovo: TDebito;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    debitoNovo := TDebito.Create(Self);

    debitoNovo.strOrigem := fGetValorXml(nodeRegistro, 'origem');
    debitoNovo.strDocumento := fGetValorXml(nodeRegistro, 'documento');
    debitoNovo.strRazaoSocial := fGetValorXml(nodeRegistro, 'razao_social');
    debitoNovo.strCidade := fGetValorXml(nodeRegistro, 'cidade');

    debitoNovo.strValor        := FormatFloat   ('#,##0.00',   fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);
    debitoNovo.strDataAtraso   := FormatDateTime('DD/MM/YYYY', fGetValorXml(nodeRegistro, 'data_do_atraso', varDate, FDateFormat, FDateSeparator));
    debitoNovo.strDataInclusao := FormatDateTime('DD/MM/YYYY', fGetValorXml(nodeRegistro, 'data_da_inclusao', varDate, FDateFormat, FDateSeparator));

    Add(debitoNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaDebitos.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + fPadC(FTitulo, INT_COLUNAS) + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Origem.......: ' + Self[intIndex].strOrigem,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Documento....: ' + Self[intIndex].strDocumento,    #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Razão Social.: ' + Self[intIndex].strRazaoSocial,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cidade.......: ' + Self[intIndex].strCidade,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data Inclusao: ' + Self[intIndex].strDataInclusao, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data Atraso..: ' + Self[intIndex].strDataAtraso,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Valor........: ' + Self[intIndex].strValor,        #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaDebitos.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FDebitos[intIndex]);
  SetLength(FDebitos, 0);
end;

constructor TListaDebitos.Create(AOwner: TComponent);
begin
  FDateSeparator := '-';
  FDateFormat := 'YYYY-MM-DD';
  FTitulo := 'DEBITOS';
end;

destructor TListaDebitos.Destroy;
begin
  Clear;
  inherited;
end;

function TListaDebitos.getCount: Integer;
begin
  Result := Length(FDebitos);
end;

function TListaDebitos.getDebito(Index: Integer): TDebito;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FDebitos[Index];
end;

{ TListaScpcPjAcim }

procedure TListaScpcPjAcim.Add(Value: TScpcPjAcim);
begin
  SetLength(FArrScpcPj, Succ(getCount));
  FArrScpcPj[Pred(getCount)] := Value;
end;

procedure TListaScpcPjAcim.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  scpcPjNovo: TScpcPjAcim;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    scpcPjNovo := TScpcPjAcim.Create(Self);

    scpcPjNovo.strOrigem := fGetValorXml(nodeRegistro, 'origem');
    scpcPjNovo.strContrato := fGetValorXml(nodeRegistro, 'contrato');
    scpcPjNovo.strObservacao := fGetValorXml(nodeRegistro, 'observacao');
    scpcPjNovo.strTipoRegistro := fGetValorXml(nodeRegistro, 'tipo_registro');
    scpcPjNovo.strTipoDocumento := fGetValorXml(nodeRegistro, 'tipo_documento');

    scpcPjNovo.strValor          := FormatFloat   ('#,##0.00',   fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);
    scpcPjNovo.strDataCadastro   := FormatDateTime('DD/MM/YYYY', fGetValorXml(nodeRegistro, 'data_cadastro', varDate));
    scpcPjNovo.strDataVencimento := FormatDateTime('DD/MM/YYYY', fGetValorXml(nodeRegistro, 'dt_vencimento', varDate));

    Add(scpcPjNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaScpcPjAcim.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                   SCPC PJ ACIM                   ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Origem........: ' + Self[intIndex].strOrigem,         #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Contrato......: ' + Self[intIndex].strContrato,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Tipo Registro.: ' + Self[intIndex].strTipoRegistro,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Tipo Documento: ' + Self[intIndex].strTipoDocumento,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data Cadastro.: ' + Self[intIndex].strDataCadastro,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data Vencimen.: ' + Self[intIndex].strDataVencimento, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Valor.........: ' + Self[intIndex].strValor,          #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Observacao....: ' + Self[intIndex].strObservacao,     #13#10, [' '], INT_COLUNAS) + #13#10;    

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaScpcPjAcim.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FArrScpcPj[intIndex]);
  SetLength(FArrScpcPj, 0);
end;

destructor TListaScpcPjAcim.Destroy;
begin
  Clear;
  inherited;
end;

function TListaScpcPjAcim.getCount: Integer;
begin
  Result := Length(FArrScpcPj);
end;

function TListaScpcPjAcim.getScpcPj(Index: Integer): TScpcPjAcim;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FArrScpcPj[Index];
end;

{ TListaProtestos }

procedure TListaProtestos.Add(Value: TProtesto);
begin
  SetLength(FProtestos, Succ(getCount));
  FProtestos[Pred(getCount)] := Value;
end;

procedure TListaProtestos.LoadXml(node: IXmlNode);
var
  protestoNovo: TProtesto;
  nodeRegistro: IXmlNode;
  nodePessoaFisica: IXmlNode;
  nodePessoaJuridica: IXmlNode;
begin
  Clear;

  FMensagem := fGetValorXml(node, 'mensagem');

  nodePessoaFisica := node.ChildNodes.FindNode('fisico');
  nodePessoaJuridica := node.ChildNodes.FindNode('jurídico');

  If Assigned(nodePessoaFisica) Then
  Begin
    nodeRegistro := nodePessoaFisica.ChildNodes.FindNode(NODE_REGISTRO);

    While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
    Begin
      protestoNovo := TProtesto.Create(Self);

      protestoNovo.strTipo := 'Fisica';

      protestoNovo.strNome := fGetValorXml(nodeRegistro, 'nome');
      protestoNovo.strPraca := fGetValorXml(nodeRegistro, 'praca');
      protestoNovo.strCartorio := fGetValorXml(nodeRegistro, 'cartorio');
      protestoNovo.strData := fGetValorXml(nodeRegistro, 'data');
      protestoNovo.strValor    := FormatFloat ('#,##0.00', fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);

      Add(protestoNovo);

      nodeRegistro := nodeRegistro.NextSibling;
    End;
  End;

  If Assigned(nodePessoaJuridica) Then
  Begin
    nodeRegistro := nodePessoaJuridica.ChildNodes.FindNode(NODE_REGISTRO);

    While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
    Begin
      protestoNovo := TProtesto.Create(Self);

      protestoNovo.strTipo := 'Juridica';

      protestoNovo.strPraca := fGetValorXml(nodeRegistro, 'praca');
      protestoNovo.strCartorio := fGetValorXml(nodeRegistro, 'cartorio');
      protestoNovo.strData := fGetValorXml(nodeRegistro, 'data');
      protestoNovo.strValor    := FormatFloat('#,##0.00', fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);

      Add(protestoNovo);

      nodeRegistro := nodeRegistro.NextSibling;
    End;
  End;

end;

function TListaProtestos.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                   PROTESTOS                      ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Tipo....: ' + Self[intIndex].strTipo,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Nome....: ' + Self[intIndex].strNome,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data....: ' + Self[intIndex].strData,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cartorio: ' + Self[intIndex].strCartorio, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Praca...: ' + Self[intIndex].strPraca,    #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Valor...: ' + Self[intIndex].strValor,    #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaProtestos.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FProtestos[intIndex]);
  SetLength(FProtestos, 0);
  FMensagem := '';
end;

destructor TListaProtestos.Destroy;
begin
  Clear;
  inherited;
end;

function TListaProtestos.getCount: Integer;
begin
  Result := Length(FProtestos);
end;

function TListaProtestos.getProtesto(Index: Integer): TProtesto;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FProtestos[Index];
end;

{ TListaAcoes }

procedure TListaAcoes.Add(Value: TAcao);
begin
  SetLength(FAcoes, Succ(getCount));
  FAcoes[Pred(getCount)] := Value;
end;

procedure TListaAcoes.LoadXml(node: IXmlNode);
var
  acaoNovo: TAcao;
  nodeAcoes: IXmlNode;
  nodeAcoesCiveis: IXmlNode;
  nodeRegistro: IXmlNode;
begin
  Clear;

  nodeAcoes := node.ChildNodes.FindNode('acoes');
  nodeAcoesCiveis := node.ChildNodes.FindNode('acoes_civeis');

  If Assigned(nodeAcoes) Then
  Begin
    nodeRegistro := nodeAcoes.ChildNodes.FindNode(NODE_REGISTRO);

    While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
    Begin
      acaoNovo := TAcao.Create(Self);

      acaoNovo.strAcao := 'Acoes';

      acaoNovo.strAcionado := fGetValorXml(nodeRegistro, 'acionado');
      acaoNovo.strAutor := fGetValorXml(nodeRegistro, 'autor');
      acaoNovo.strVara := fGetValorXml(nodeRegistro, 'va');
      acaoNovo.strCidade := fGetValorXml(nodeRegistro, 'cidade');
      acaoNovo.strProcesso := fGetValorXml(nodeRegistro, 'processo');
      acaoNovo.strTipo := fGetValorXml(nodeRegistro, 'tipo');
      acaoNovo.strData := fGetValorXml(nodeRegistro, 'data');
      acaoNovo.strValor    := FormatFloat('#,##0.00', fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);

      Add(acaoNovo);

      nodeRegistro := nodeRegistro.NextSibling;
    End;
  End;

  If Assigned(nodeAcoesCiveis) Then
  Begin
    nodeRegistro := nodeAcoesCiveis.ChildNodes.FindNode(NODE_REGISTRO);

    While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
    Begin
      acaoNovo := TAcao.Create(Self);

      acaoNovo.strAcao := 'Acoes Civeis';

      acaoNovo.strVara := fGetValorXml(nodeRegistro, 'vara');
      acaoNovo.strCidade := fGetValorXml(nodeRegistro, 'cidade');
      acaoNovo.strTipo := fGetValorXml(nodeRegistro, 'tipo');
      acaoNovo.strQuantidade := fGetValorXml(nodeRegistro, 'quantidade');
      acaoNovo.strUltima := fGetValorXml(nodeRegistro, 'ultima');

      Add(acaoNovo);

      nodeRegistro := nodeRegistro.NextSibling;
    End;
  End;
end;

function TListaAcoes.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      ACOES                       ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Acao......: ' + Self[intIndex].strAcao,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Acionado..: ' + Self[intIndex].strAcionado,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Autor.....: ' + Self[intIndex].strAutor,      #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Data......: ' + Self[intIndex].strData,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Ultima....: ' + Self[intIndex].strUltima,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Vara......: ' + Self[intIndex].strVara,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cidade....: ' + Self[intIndex].strCidade,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Processo..: ' + Self[intIndex].strProcesso,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Tipo......: ' + Self[intIndex].strTipo,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Valor.....: ' + Self[intIndex].strValor,      #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Quantidade: ' + Self[intIndex].strQuantidade, #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaAcoes.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FAcoes[intIndex]);
  SetLength(FAcoes, 0);
end;

destructor TListaAcoes.Destroy;
begin
  Clear;
  inherited;
end;

function TListaAcoes.getCount: Integer;
begin
  Result := Length(FAcoes);
end;

function TListaAcoes.getAcao(Index: Integer): TAcao;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FAcoes[Index];
end;

{ TListaCheques }

procedure TListaCheques.Add(Value: TCheque);
begin
  SetLength(FCheques, Succ(getCount));
  FCheques[Pred(getCount)] := Value;
end;

procedure TListaCheques.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  chequeNovo: TCheque;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    chequeNovo := TCheque.Create(Self);

    chequeNovo.strbanco := fGetValorXml(nodeRegistro, 'banco');
    chequeNovo.strdescricao := fGetValorXml(nodeRegistro, 'descricao');
    chequeNovo.strQuantidade := fGetValorXml(nodeRegistro, 'quantidade');
    chequeNovo.strUltimo := fGetValorXml(nodeRegistro, 'ultimo');

    Add(chequeNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaCheques.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      CHEQUES                     ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Banco.....: ' + Self[intIndex].strbanco,      #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Descricao.: ' + Self[intIndex].strdescricao,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Ultimo....: ' + Self[intIndex].strUltimo,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Quantidade: ' + Self[intIndex].strQuantidade, #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaCheques.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FCheques[intIndex]);
  SetLength(FCheques, 0);
end;

destructor TListaCheques.Destroy;
begin
  Clear;
  inherited;
end;

function TListaCheques.getCheque(Index: Integer): TCheque;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FCheques[Index];
end;

function TListaCheques.getCount: Integer;
begin
  Result := Length(FCheques);
end;

{ TListaBacen }

procedure TListaBacen.Add(Value: TBacen);
begin
  SetLength(FBacen, Succ(getCount));
  FBacen[Pred(getCount)] := Value;
end;

procedure TListaBacen.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  BacenNovo: TBacen;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    BacenNovo := TBacen.Create(Self);

    BacenNovo.strbanco := fGetValorXml(nodeRegistro, 'banco');
    BacenNovo.strAgencia := fGetValorXml(nodeRegistro, 'agencia');
    BacenNovo.strQuantidade := fGetValorXml(nodeRegistro, 'quantidade');
    BacenNovo.strDescAlinea := fGetValorXml(nodeRegistro, 'desc_alinea');
    BacenNovo.strDescBanco := fGetValorXml(nodeRegistro, 'desc_banco');

    Add(BacenNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaBacen.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                       BACEN                      ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Banco......: ' + Self[intIndex].strbanco,      #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Agencia....: ' + Self[intIndex].strAgencia,    #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Quantidade.: ' + Self[intIndex].strQuantidade, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Desc.Alinea: ' + Self[intIndex].strDescAlinea, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Desc.Banco.: ' + Self[intIndex].strDescBanco,  #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaBacen.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FBacen[intIndex]);
  SetLength(FBacen, 0);
end;

destructor TListaBacen.Destroy;
begin
  Clear;
  inherited;
end;

function TListaBacen.getBacen(Index: Integer): TBacen;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FBacen[Index];
end;

function TListaBacen.getCount: Integer;
begin
  Result := Length(FBacen);
end;

{ TListaVcqLocal }

procedure TListaVcqLocal.Add(Value: TVcqLocal);
begin
  SetLength(FArrVcqLocal, Succ(getCount));
  FArrVcqLocal[Pred(getCount)] := Value;
end;

procedure TListaVcqLocal.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  VcqLocalNovo: TVcqLocal;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    VcqLocalNovo := TVcqLocal.Create(Self);

    VcqLocalNovo.strBanco         := fGetValorXml(nodeRegistro, 'banco');
    VcqLocalNovo.strAgencia       := fGetValorXml(nodeRegistro, 'agencia');
    VcqLocalNovo.strChequeInicial := fGetValorXml(nodeRegistro, 'cheque_inicial');
    VcqLocalNovo.strChequeFinal   := fGetValorXml(nodeRegistro, 'cheque_final');
    VcqLocalNovo.strAlinea        := fGetValorXml(nodeRegistro, 'alinea');
    VcqLocalNovo.strContaCorrente := fGetValorXml(nodeRegistro, 'conta_corrente');
    VcqLocalNovo.strRazaoSocial   := fGetValorXml(nodeRegistro, 'razao_social');
    VcqLocalNovo.strCidade        := fGetValorXml(nodeRegistro, 'cidade');
    VcqLocalNovo.strValor         := FormatFloat('#,##0.00', fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);

    Add(VcqLocalNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaVcqLocal.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                     VCQ LOCAL                    ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Banco.......: ' + Self[intIndex].strbanco,         #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Agencia.....: ' + Self[intIndex].strAgencia,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('C.Corrente..: ' + Self[intIndex].strContaCorrente, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cheque Inic.: ' + Self[intIndex].strChequeInicial, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cheque Final: ' + Self[intIndex].strChequeFinal,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Alinea......: ' + Self[intIndex].strAlinea,        #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cidade......: ' + Self[intIndex].strCidade,        #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Razao Social: ' + Self[intIndex].strRazaoSocial,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Valor.......: ' + Self[intIndex].strValor,         #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaVcqLocal.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FArrVcqLocal[intIndex]);
  SetLength(FArrVcqLocal, 0);
end;

destructor TListaVcqLocal.Destroy;
begin
  Clear;
  inherited;
end;

function TListaVcqLocal.getVcqLocal(Index: Integer): TVcqLocal;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FArrVcqLocal[Index];
end;

function TListaVcqLocal.getCount: Integer;
begin
  Result := Length(FArrVcqLocal);
end;

{ TListaChequesSER }

procedure TListaChequesSER.Add(Value: TChequeSER);
begin
  SetLength(FChequesSER, Succ(getCount));
  FChequesSER[Pred(getCount)] := Value;
end;

procedure TListaChequesSER.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  chequeSERNovo: TChequeSER;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    chequeSERNovo := TChequeSER.Create(Self);

    chequeSERNovo.strBanco         := fGetValorXml(nodeRegistro, 'banco');
    chequeSERNovo.strAgencia       := fGetValorXml(nodeRegistro, 'agencia');
    chequeSERNovo.strChequeInicial := fGetValorXml(nodeRegistro, 'cheque_inicial');
    chequeSERNovo.strChequeFinal   := fGetValorXml(nodeRegistro, 'cheque_final');
    chequeSERNovo.strAlinea        := fGetValorXml(nodeRegistro, 'alinea');
    chequeSERNovo.strContaCorrente := fGetValorXml(nodeRegistro, 'conta_corrente');
    chequeSERNovo.strRazaoSocial   := fGetValorXml(nodeRegistro, 'razao_social');
    chequeSERNovo.strCidade        := fGetValorXml(nodeRegistro, 'cidade');
    chequeSERNovo.strValor         := FormatFloat('#,##0.00', fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);

    Add(chequeSERNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaChequesSER.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                   CHEQUES SERASA                 ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Banco.......: ' + Self[intIndex].strbanco,         #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Agencia.....: ' + Self[intIndex].strAgencia,       #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('C.Corrente..: ' + Self[intIndex].strContaCorrente, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cheque Inic.: ' + Self[intIndex].strChequeInicial, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cheque Final: ' + Self[intIndex].strChequeFinal,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Alinea......: ' + Self[intIndex].strAlinea,        #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cidade......: ' + Self[intIndex].strCidade,        #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Razao Social: ' + Self[intIndex].strRazaoSocial,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Valor.......: ' + Self[intIndex].strValor,         #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaChequesSER.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FChequesSER[intIndex]);
  SetLength(FChequesSER, 0);
end;

destructor TListaChequesSER.Destroy;
begin
  Clear;
  inherited;
end;

function TListaChequesSER.getChequeSER(Index: Integer): TChequeSER;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FChequesSER[Index];
end;

function TListaChequesSER.getCount: Integer;
begin
  Result := Length(FChequesSER);
end;

{ TListaChequesPre }

procedure TListaChequesPre.Add(Value: TChequePre);
begin
  SetLength(FChequesPre, Succ(getCount));
  FChequesPre[Pred(getCount)] := Value;
end;

procedure TListaChequesPre.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  chequePreNovo: TChequePre;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    chequePreNovo := TChequePre.Create(Self);

    chequePreNovo.strBanco   := fGetValorXml(nodeRegistro, 'banco');
    chequePreNovo.strAgencia := fGetValorXml(nodeRegistro, 'agencia');
    chequePreNovo.strCheque  := fGetValorXml(nodeRegistro, 'cheque');

    chequePreNovo.strData    := FormatDateTime('DD/MM/YYYY', fGetValorXml(nodeRegistro, 'data', varDate));
    chequePreNovo.strValor   := FormatFloat   ('#,##0.00',   fGetValorXml(nodeRegistro, 'valor', varDouble) / 100);

    Add(chequePreNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaChequesPre.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                    CHEQUES PRE                   ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Data....: ' + Self[intIndex].strData,    #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Banco...: ' + Self[intIndex].strbanco,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Agencia.: ' + Self[intIndex].strAgencia, #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Cheque..: ' + Self[intIndex].strCheque,  #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Valor...: ' + Self[intIndex].strValor,   #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaChequesPre.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FChequesPre[intIndex]);
  SetLength(FChequesPre, 0);
end;

destructor TListaChequesPre.Destroy;
begin
  Clear;
  inherited;
end;

function TListaChequesPre.getChequePre(Index: Integer): TChequePre;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FChequesPre[Index];
end;

function TListaChequesPre.getCount: Integer;
begin
  Result := Length(FChequesPre);
end;

{ TListaAlertas }

procedure TListaAlertas.Add(Value: TAlerta);
begin
  SetLength(FAlertas, Succ(getCount));
  FAlertas[Pred(getCount)] := Value;
end;

procedure TListaAlertas.LoadXml(node: IXmlNode);
var
  nodeRegistro: IXmlNode;
  alertaNovo: TAlerta;
begin
  Clear;

  nodeRegistro := node.ChildNodes.FindNode(NODE_REGISTRO);

  While Assigned(nodeRegistro) And (nodeRegistro.NodeName = NODE_REGISTRO) Do
  Begin
    alertaNovo := TAlerta.Create(Self);

    alertaNovo.strDecricao := fGetValorXml(nodeRegistro, 'descricao');
    alertaNovo.strOrigem := fGetValorXml(nodeRegistro, 'origem');
    alertaNovo.strData := fGetValorXml(nodeRegistro, 'data');

    Add(alertaNovo);

    nodeRegistro := nodeRegistro.NextSibling;
  End;

end;

function TListaAlertas.AsString: String;
Var
  intIndex: Integer;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                      ALERTAS                     ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;

  For intIndex := 0 To getCount - 1 Do
  Begin
    Result := Result + WrapText('Data......: ' + Self[intIndex].strData,     #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Origem....: ' + Self[intIndex].strOrigem,   #13#10, [' '], INT_COLUNAS) + #13#10;
    Result := Result + WrapText('Descricao.: ' + Self[intIndex].strDecricao, #13#10, [' '], INT_COLUNAS) + #13#10;

    Result := Result + #13#10;
  End;

  If getCount = 0 Then
    Result := Result + 'Nada consta' + #13#10;

  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + #13#10;
end;

procedure TListaAlertas.Clear;
var
  intIndex: Integer;
begin
  For intIndex := 0 To getCount - 1 Do
    FreeAndNil(FAlertas[intIndex]);
  SetLength(FAlertas, 0);
end;

destructor TListaAlertas.Destroy;
begin
  Clear;
  inherited;
end;

function TListaAlertas.getAlerta(Index: Integer): TAlerta;
begin
  If Index >= getCount Then
    Result := nil
  Else
    Result := FAlertas[Index];
end;

function TListaAlertas.getCount: Integer;
begin
  Result := Length(FAlertas);
end;

{ TConsultaSCPC }

constructor TConsultaSCPCPhdRisk.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FXmlRetorno := TXMLDocument.Create(Self);

  FSinteseCadastral := TSinteseCadastral.Create(Self);
  FSinteseCadastralCnpj := TSinteseCadastralCnpj.Create(Self);
  FConfiraFones := TListaConfiraFone.Create(Self);
  FPassagens := TListaPassagens.Create(Self);
  FDebitosLocacao := TListaDebitos.Create(Self);
  FDebitosAlimen := TListaDebitos.Create(Self);
  FScpcPjAcim := TListaScpcPjAcim.Create(Self);
  FProtestos := TListaProtestos.Create(Self);
  FAcoes := TListaAcoes.Create(Self);
  FCheques := TListaCheques.Create(Self);
  FChequesSER := TListaChequesSER.Create(Self);
  FChequesPre := TListaChequesPre.Create(Self);
  FBacen := TListaBacen.Create(Self);
  FVcqLoCal := TListaVcqLocal.Create(Self);
  FAlertas := TListaAlertas.Create(Self);
  FDebitos := TListaDebitos.Create(Self);

  FDebitosLocacao.Titulo := 'DEBITOS LOCACAO';
  FDebitosAlimen.Titulo := 'DEBITOS ALIMENTACAO';

  FDebitos.Titulo := 'DEBITOS';
  FDebitos.DateFormat := 'DD/MM/YYYY';
  FDebitos.DateSeparator := '/';

  FMsgErro := '';
  FDocumento := '';

  FLogin := fCfgSis('LOGPHD');
  FSenha := fCfgSis('SENPHD');
end;

destructor TConsultaSCPCPhdRisk.Destroy;
begin
  FreeAndNil(FSinteseCadastral);
  FreeAndNil(FSinteseCadastralCnpj);
  FreeAndNil(FConfiraFones);
  FreeAndNil(FPassagens);
  FreeAndNil(FXmlRetorno);
  FreeAndNil(FDebitosLocacao);
  FreeAndNil(FDebitosAlimen);
  FreeAndNil(FDebitosLocacao);
  FreeAndNil(FDebitosAlimen);
  FreeAndNil(FScpcPjAcim);
  FreeAndNil(FProtestos);
  FreeAndNil(FAcoes);
  FreeAndNil(FCheques);
  FreeAndNil(FChequesSER);
  FreeAndNil(FChequesPre);
  FreeAndNil(FBacen);
  FreeAndNil(FVcqLoCal);
  FreeAndNil(FAlertas);
  FreeAndNil(FDebitos);
  inherited Destroy;
end;

function TConsultaSCPCPhdRisk.fGetMsgErro: String;
begin
  Result := FMsgErro;
end;

function TConsultaSCPCPhdRisk.fGetQtdCheques: Integer;
begin
  Result := FCheques.Count + FChequesPre.Count + FChequesSER.Count;
end;

function TConsultaSCPCPhdRisk.fGetQtdProtestos: Integer;
begin
  Result := FAcoes.Count + FDebitos.Count + FProtestos.Count +
    FDebitosLocacao.Count + FDebitosAlimen.Count;
end;

function TConsultaSCPCPhdRisk.fGetRelatorio: String;
begin
  Result := '';
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                  CONSULTA SCPC                   ' + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + 'Data.....: ' + FormatDateTime('DD/MM/YYYY', VS_Date) + #13#10;
  Result := Result + 'Documento: ' + FDocumento + #13#10;
  Result := Result + '--------------------------------------------------' + #13#10;
  Result := Result + '                                                  ' + #13#10;
  Result := Result + FSinteseCadastral.AsString + #13#10;
  Result := Result + FSinteseCadastralCnpj.AsString + #13#10;
  Result := Result + FConfiraFones.AsString + #13#10;
  Result := Result + FPassagens.AsString + #13#10;
  Result := Result + FDebitos.AsString + #13#10;
  Result := Result + FDebitosLocacao.AsString + #13#10;
  Result := Result + FDebitosAlimen.AsString + #13#10;
  Result := Result + FScpcPjAcim.AsString + #13#10;
  Result := Result + FProtestos.AsString + #13#10;
  Result := Result + FAcoes.AsString + #13#10;
  Result := Result + FCheques.AsString + #13#10;
  Result := Result + FChequesSER.AsString + #13#10;
  Result := Result + FChequesPre.AsString + #13#10;
  Result := Result + FBacen.AsString + #13#10;
  Result := Result + FVcqLoCal.AsString + #13#10;
  Result := Result + FAlertas.AsString + #13#10;
end;

function TConsultaSCPCPhdRisk.fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;
Var
  strXmlEnvio: String;
  strsRetorno: TStringStream;
  nodeErro: IXmlNode;
  nodeRetorno: IXmlNode;
begin
  Result := False;
  pSetDocumento(strDocumento);

  FMsgErro := '';

  If fEmptyStr(FLogin) Or fEmptyStr(FSenha) Then
  Begin
    FMsgErro := 'Para acessar a consulta SCPC você deve possuir usuário e senha fornecidos pela empresa ' +
                'PHDRISK. Verifique se ambos foram informados corretamente nas configurações de sistema!';
    Exit;
  End;

  pSetDocumento(FDocumento);

  strXmlEnvio := '<consultaPHDRISK>'+
                    '<codigo>'    + FTipoConsulta + '</codigo>'    +
                    '<documento>' + FDocumento    + '</documento>' +
                 '</consultaPHDRISK>';

  Try
    strsRetorno := TStringStream.Create(GetWebServer_PhdriskPortType.consulta(FLogin, FSenha, strXmlEnvio));

    FXmlRetorno.LoadFromStream(strsRetorno);
    FXmlRetorno.Active := True;

    nodeErro := FXmlRetorno.ChildNodes.FindNode('ERRO');
    nodeRetorno := FXmlRetorno.ChildNodes.FindNode('RetornoPHDRISK');

    If Assigned(nodeErro) Then
    Begin
      FMsgErro := 'ERRO NA CONSULTA' + #13#10 + #13#10 +
                  'Codigo..: ' + fGetValorXml(nodeErro, 'CODIGO'  ) + #13#10 +
                  'Mensagem: ' + fGetValorXml(nodeErro, 'MENSAGEM') + #13#10 ;
    End

    Else If Not Assigned(nodeRetorno) Then
      FMsgErro := 'NAO FOI ENCONTRADO O RETORNO'

    Else
    Begin
      Result := True;

      FSinteseCadastral.LoadXml(nodeRetorno.ChildNodes.FindNode('sintese_cadastral'));
      FSinteseCadastralCnpj.LoadXml(nodeRetorno.ChildNodes.FindNode('sintese_cadastral_cnpj'));
      FConfiraFones.LoadXml(nodeRetorno.ChildNodes.FindNode('confiraFone'));
      FPassagens.LoadXml(nodeRetorno.ChildNodes.FindNode('passagem'));
      FDebitosLocacao.LoadXml(nodeRetorno.ChildNodes.FindNode('debitoLocacao'));
      FDebitosAlimen.LoadXml(nodeRetorno.ChildNodes.FindNode('debitoAlimentacao'));
      FScpcPjAcim.LoadXml(nodeRetorno.ChildNodes.FindNode('scpcPjAcim'));
      FProtestos.LoadXml(nodeRetorno.ChildNodes.FindNode('textoProtesto'));
      FAcoes.LoadXml(nodeRetorno.ChildNodes.FindNode('textoAcao'));
      FCheques.LoadXml(nodeRetorno.ChildNodes.FindNode('textoCheque'));
      FChequesSER.LoadXml(nodeRetorno.ChildNodes.FindNode('chequeSER'));
      FChequesPre.LoadXml(nodeRetorno.ChildNodes.FindNode('chequePreDatado'));
      FBacen.LoadXml(nodeRetorno.ChildNodes.FindNode('bacen'));
      FVcqLoCal.LoadXml(nodeRetorno.ChildNodes.FindNode('vcqLocal'));
      FAlertas.LoadXml(nodeRetorno.ChildNodes.FindNode('alerta'));
      FDebitos.LoadXml(nodeRetorno.ChildNodes.FindNode('debito'));
    End;
  Except
    On E: Exception Do
     Raise ExceptionAutcom.Create('Método especificado para consulta não está disponível no WebService da PHDRISK!'+#13+
                                  'Entre em contato com o Suporte da Citel.'+#13+
        'Erro original: ' + E.Message);
  End;
end;

procedure TConsultaSCPCPhdRisk.pSetDocumento(const Value: String);
Var
  strDocTmp: String;
begin
  strDocTmp := fTiraCaracEspeciais(Value, True, True, True);

  If fEmptyStr(strDocTmp) Then
    Raise ExceptionAutcom.Create('Informe o documento para consulta!')

  Else If (Length(strDocTmp) <= 11) Then
  Begin
    If (Not fValidaCPF(strDocTmp)) Then
      Raise ExceptionAutcom.Create('Não é um CPF Válido!')

    Else If (strDocTmp = fReplicatorStr(strDocTmp[1], Length(strDocTmp))) Then
      Raise ExceptionAutcom.Create('Não é um CPF Válido!');

    FTipoConsulta := SCPC_SINTESE_CADASTRADAL;
  End

  Else
  Begin
    If (Not fTestaCgc(strDocTmp)) Then
      Raise ExceptionAutcom.Create('Não é um CNPJ Válido!');

    FTipoConsulta := SCPC_JURIDICO_SIC_SINTESE_CADASTRADAL;
  End;

  FDocumento := strDocTmp;
end;

procedure TConsultaSCPCPhdRisk.pSaveToFile(const strFileName: String);
var
  stlTexto: TStringList;
begin
  If Not DirectoryExists(ExtractFilePath(strFileName)) Then
    fCriaDiretorio(ExtractFilePath(strFileName));

  stlTexto := TStringList.Create;
  stlTexto.Text := Self.fGetRelatorio;
  stlTexto.SaveToFile(strFileName);
  FreeAndNil(stlTexto);

  FXmlRetorno.SaveToFile(AnsiReplaceStr(strFileName,
    ExtractFileExt(strFileName), '.xml'));
end;

end.