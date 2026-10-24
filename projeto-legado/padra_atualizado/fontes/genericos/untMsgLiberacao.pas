{************************************************************************}
{* Objeto criado para criar as mensagens de liberação, gerar a mensagem *}
{* em texto para o autcom, outra mensagem em texto para possível        *}
{* exibição em dipositivos                                              *}
{* móveis e um json que atualmente será utilizado no aplicativo         *}
{************************************************************************}
{* ao alterar algum objeto aqui, verifique os métodos getClone e Clear  *}
{* de cada um e os métodos fGetJsonObject e fGetObjectFromJson          *}
{* Existe a untLiberacaoFactory, para trabalhar com interface e dlls    *}
{************************************************************************}
{* Em caso de dúvidas, falar com Luiz Oliveira                          *}
{*********************************************************************LO*}

unit untMsgLiberacao;

interface

uses
  System.SysUtils, Classes, StrUtils, System.Generics.Collections, Rest.Json,
  System.json, TypInfo;

Type

//tipos
TTipoRegistroMsgLibera = (trTexto,  trQuebra, trSeparador, trTabela, trTextoCaption);
TTipoExibicaoMsgLibera = (teAmbos, teApp, teAutcom);
TTipoLinhaMsgLibera    = (tlCabecalho, tlValor, tlTotal, tlNull);
TAlinhamento           = (alEsquerda, alDireita, alCentro);

  // funções de conversão
  function fTipoRegistroMsgLiberaToString( enuTipoRegistroMsgLibera : TTipoRegistroMsgLibera ) : String;
  function fStringToTipoRegistroMsgLibera( strTipoRegistroMsgLibera : String )                 : TTipoRegistroMsgLibera;
  function fTipoExibicaoMsgLiberaToString( enuTipoExibicaoMsgLibera : TTipoExibicaoMsgLibera ) : String;
  function fStringToTipoExibicaoMsgLibera( strTipoExibicaoMsgLibera : String )                 : TTipoExibicaoMsgLibera;
  function fTipoLinhaMsgLiberaToString( enuTipoLinhaMsgLibera : TTipoLinhaMsgLibera )          : String;
  function fStringToTipoLinhaMsgLibera( strTipoLinhaMsgLibera : String )                       : TTipoLinhaMsgLibera;
  function fAlinhamentoToString( enuAlinhamento : TAlinhamento )                               : String;
  function fStringToAlinhamento( strAlinhamento : String )                                     : TAlinhamento;


type
//classe base para trabalhar com a lista de objetos em TMensagemLiberação
TRegistroMsgLibera = class(TPersistent)
  private
    FenuTipo         : TTipoRegistroMsgLibera;
    FenuTipoExibicao : TTipoExibicaoMsgLibera;

  public
    procedure Clear; virtual;
    function fGetClone : TRegistroMsgLibera;
    constructor Create; virtual;
    property enuTipo         : TTipoRegistroMsgLibera read FenuTipo         write FenuTipo         ;
    property enuTipoExibicao : TTipoExibicaoMsgLibera read FenuTipoExibicao write FenuTipoExibicao ;
end;

TColunaMsgLibera = class(TPersistent)
  private
    FintTamanho        : Integer;
    FstrTexto          : String;
    FenuTipoExibicao   : TTipoExibicaoMsgLibera;
    FblnExibeCaption   : Boolean;
    FstrCaption        : String;
    FenuAlinhamento    : TAlinhamento;

  public
    procedure Clear;
    function fGetClone : TColunaMsgLibera;

    constructor Create;
    property enuTipoExibicao : TTipoExibicaoMsgLibera read FenuTipoExibicao write FenuTipoExibicao ;
    property strTexto        : String                 read FstrTexto        write FstrTexto        ;
    property strCaption      : String                 read FstrCaption      write FstrCaption      ;
    property intTamanho      : Integer                read FintTamanho      write FintTamanho      ;
    property blnExibeCaption : boolean                read FblnExibeCaption write FblnExibeCaption ;
    property enuAlinhamento  : TAlinhamento           read FenuAlinhamento  write FenuAlinhamento  ;
end;

TLinhaMsgLibera = class(TPersistent)
  private
    FlstColunas      : TObjectList<TColunaMsgLibera>;
    FintAgrupador    : Integer;
    FenuTipoExibicao : TTipoExibicaoMsgLibera;
    FenuTipoLinha    : TTipoLinhaMsgLibera;
    FstrHint         : String;

  public
    procedure Clear;
    procedure pAddColuna(strCaption, strTexto : String; intTamanho : Integer; enuAlinhamento : TAlinhamento = alEsquerda; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; blnExibeCaption : Boolean = False);
    function  fIgual(objLinha : TLinhaMsgLibera) : boolean;
    function fGetClone : TLinhaMsgLibera;

    constructor Create;
    destructor Destroy; override;
    property enuTipoExibicao   : TTipoExibicaoMsgLibera        read FenuTipoExibicao write FenuTipoExibicao  ;
    property lstColunas        : TObjectList<TColunaMsgLibera> read FlstColunas      write FlstColunas       ;
    property intAgrupador      : integer                       read FintAgrupador    write FintAgrupador     ;
    property enuTipoLinha      : TTipoLinhaMsgLibera           read FenuTipoLinha    write FenuTipoLinha     ;
    property strHint           : String                        read FstrHint         write FstrHint          ;
end;

TRegistroMsgLiberaTabela = class(TRegistroMsgLibera)
  private
    FlstLinhas    : TObjectList<TLinhaMsgLibera>;
  public
    procedure Clear; override;
    function  isEmpty: Boolean;
    function  fIgual(objTabela : TRegistroMsgLiberaTabela) : boolean;
    function fGetTamanhoFinalCabecalho: Integer;

    constructor Create; override;
    destructor Destroy; override;

    property lstLinhas     : TObjectList<TLinhaMsgLibera> read FlstLinhas      write FlstLinhas;
end;

TRegistroMsgLiberaTexto = class(TRegistroMsgLibera)
  private
    FstrTexto       : String;
    FstrHint        : String;
    FenuAlinhamento : TAlinhamento;
    FintTamanho     : integer;
  public
    procedure Clear; override;

    property strTexto       : String       read FstrTexto       write FstrTexto       ;
    property strHint        : String       read FstrHint        write FstrHint        ;
    property enuAlinhamento : TAlinhamento read FenuAlinhamento write FenuAlinhamento ;
    property intTamanho     : integer      read FintTamanho     write FintTamanho     ;
end;

TRegistroMsgLiberaSeparador = class(TRegistroMsgLibera)
  private
    FintTamanho: integer;
  public
    procedure Clear; override;
    property intTamanho : integer read FintTamanho write FintTamanho;
end;

TRegistroMsgLiberaTextoCaption = class(TRegistroMsgLiberaTexto)
  private
    FstrCaption: String;
    FintTamanhoCaption: integer;
  public
    procedure Clear; override;
    property strCaption        : String  read FstrCaption        write FstrCaption;
    property intTamanhoCaption : integer read FintTamanhoCaption write FintTamanhoCaption;
end;

TMensagemLiberacao = class(TComponent)
  private
    FstrTitulo        : String;
    FstrJustificativa : String;
    FlstRegistros     : TObjectList<TRegistroMsgLibera>;
    FstrDirAce        : String;

    const
      LARGURA_TEXTO = 141;
      LARGURA_TEXTO_APP = 75;
  public
    procedure pAddTexto( strTexto: String; enuAlinhamento : TAlinhamento = alEsquerda; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; strHint : String = ''; intTamanho : integer = 0 );
    procedure pInsertTexto(intPosicao : integer; strTexto: String; enuAlinhamento : TAlinhamento = alEsquerda; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; strHint : String = ''; intTamanho : integer = 0);
    procedure pAddTextoCaption(strCaption, strTexto: String; intTamanhoCaption: integer = 0; enuAlinhamento : TAlinhamento = alEsquerda; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; strHint : String = ''; intTamanho : integer = 0);
    procedure pInsertTextoCaption(intPosicao : integer; strCaption, strTexto: String; intTamanhoCaption: integer = 0; enuAlinhamento : TAlinhamento = alEsquerda; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; strHint : String = ''; intTamanho : integer = 0);
    procedure pAddSeparador( intTamanho : integer = 0; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos );
    procedure pAddQuebra(enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos);

    procedure Clear;

    function fGetJsonObject                                : TJSONObject;
    function fGetObjectFromJson( strJson : String )        : boolean;
    function fGetMensagem(intQuantidadeLinhas: Integer = 0; blnLimitaQuantidadeDuplicata: Boolean = False): String;
    function fGetMensagemApp                               : String;
    function isEmpty                                       : Boolean;
    procedure pAddJustificativa(var stlMensagem : TStringList);

    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    property lstRegistros        : TObjectList<TRegistroMsgLibera> read FlstRegistros     write FlstRegistros     ;
    property strTitulo           : String                          read FstrTitulo        write FstrTitulo        ;
    property strJustificativa    : String                          read FstrJustificativa write FstrJustificativa ;
    property strDirAce           : String                          Read FstrDirAce        Write FstrDirAce        ;
end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  untFuncoesSimples,
{$ENDIF LINUX}
  untConstantes;

function fTipoRegistroMsgLiberaToString( enuTipoRegistroMsgLibera : TTipoRegistroMsgLibera ) : String;
begin
  Result :=  GetEnumName(TypeInfo(TTipoRegistroMsgLibera), Integer(enuTipoRegistroMsgLibera));
end;

function fStringToTipoRegistroMsgLibera( strTipoRegistroMsgLibera : String ) : TTipoRegistroMsgLibera;
begin
  Result :=  TTipoRegistroMsgLibera(GetEnumValue(TypeInfo(TTipoRegistroMsgLibera), strTipoRegistroMsgLibera));
end;


function fTipoExibicaoMsgLiberaToString( enuTipoExibicaoMsgLibera : TTipoExibicaoMsgLibera ) : String;
begin
  Result :=  GetEnumName(TypeInfo(TTipoExibicaoMsgLibera), Integer(enuTipoExibicaoMsgLibera));
end;

function fStringToTipoExibicaoMsgLibera( strTipoExibicaoMsgLibera : String ) : TTipoExibicaoMsgLibera;
begin
  Result :=  TTipoExibicaoMsgLibera(GetEnumValue(TypeInfo(TTipoExibicaoMsgLibera), strTipoExibicaoMsgLibera));
end;

function fTipoLinhaMsgLiberaToString( enuTipoLinhaMsgLibera : TTipoLinhaMsgLibera ) : String;
begin
  Result :=  GetEnumName(TypeInfo(TTipoLinhaMsgLibera), Integer(enuTipoLinhaMsgLibera));
end;

function fStringToTipoLinhaMsgLibera( strTipoLinhaMsgLibera : String ) : TTipoLinhaMsgLibera;
begin
  Result :=  TTipoLinhaMsgLibera(GetEnumValue(TypeInfo(TTipoLinhaMsgLibera), strTipoLinhaMsgLibera));
end;

function fAlinhamentoToString( enuAlinhamento : TAlinhamento ) : String;
begin
  Result :=  GetEnumName(TypeInfo(TAlinhamento), Integer(enuAlinhamento));
end;

function fStringToAlinhamento( strAlinhamento : String ) : TAlinhamento;
begin
  Result :=  TAlinhamento(GetEnumValue(TypeInfo(TAlinhamento), strAlinhamento));
end;

procedure TMensagemLiberacao.Clear;
begin
  FlstRegistros.Clear;

  FstrTitulo        := '';
  FstrJustificativa := '';
  FstrDirAce        := '';
end;


{ TMensagemLiberacao }

procedure TMensagemLiberacao.pAddSeparador( intTamanho : integer = 0; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos );
var
  objRegistro : TRegistroMsgLiberaSeparador;
begin

  objRegistro                 := TRegistroMsgLiberaSeparador.Create;
  objRegistro.intTamanho      := intTamanho;
  objRegistro.enuTipoExibicao := enuTipoExibicao;
  Self.lstRegistros.Add(objRegistro);

end;

procedure TMensagemLiberacao.pAddJustificativa(var stlMensagem : TStringList);
var
  stlJustificativa : TStringList;
begin
  if Trim(Self.strJustificativa) = '' then
    stlMensagem.Text := StringReplace(stlMensagem.Text, STRING_JUSTIFICATIVA, '', [rfReplaceAll])
  else
  begin
    stlJustificativa := TStringList.Create;
    try
      stlJustificativa.Add('');
      stlJustificativa.Add('JUSTIFICATIVA:');
      stlJustificativa.Add(Self.strJustificativa);

      if Pos(STRING_JUSTIFICATIVA, stlMensagem.Text) > 0 then
        stlMensagem.Text := StringReplace(stlMensagem.Text, STRING_JUSTIFICATIVA, stlJustificativa.Text, [rfReplaceAll])
      else
        stlMensagem.Add(stlJustificativa.Text);
    finally
      FreeAndNil(stlJustificativa);
    end;
  end;
end;

procedure TMensagemLiberacao.pAddQuebra(enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos);
var
  objRegistro : TRegistroMsgLibera;
begin

  objRegistro                 := TRegistroMsgLibera.Create;
  objRegistro.enuTipo         := trQuebra;
  objRegistro.enuTipoExibicao := enuTipoExibicao;
  Self.lstRegistros.Add( objRegistro );
end;

procedure TMensagemLiberacao.pAddTexto( strTexto : String; enuAlinhamento : TAlinhamento = alEsquerda; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; strHint : String = ''; intTamanho : integer = 0  );
var
  objRegistro : TRegistroMsgLiberaTexto;
begin

  objRegistro                 := TRegistroMsgLiberaTexto.Create;
  objRegistro.strTexto        := strTexto;
  objRegistro.enuTipoExibicao := enuTipoExibicao;
  objRegistro.enuAlinhamento  := enuAlinhamento;
  objRegistro.strHint         := strHint;
  objRegistro.intTamanho      := intTamanho;
  Self.lstRegistros.Add(objRegistro);

end;

procedure TMensagemLiberacao.pAddTextoCaption(strCaption, strTexto : String; intTamanhoCaption : integer = 0; enuAlinhamento : TAlinhamento = alEsquerda; enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; strHint : String = ''; intTamanho : integer = 0  );
var
  objRegistro : TRegistroMsgLiberaTextoCaption;
begin

  objRegistro                   := TRegistroMsgLiberaTextoCaption.Create;
  objRegistro.strTexto          := strTexto;
  objRegistro.strCaption        := strCaption;
  objRegistro.intTamanhoCaption := intTamanhoCaption;
  objRegistro.enuTipoExibicao   := enuTipoExibicao;
  objRegistro.enuAlinhamento    := enuAlinhamento;
  objRegistro.strHint           := strHint;
  objRegistro.intTamanho        := intTamanho;
  Self.lstRegistros.Add(objRegistro);

end;


procedure TMensagemLiberacao.pInsertTexto(intPosicao: integer; strTexto: String;
  enuAlinhamento: TAlinhamento; enuTipoExibicao: TTipoExibicaoMsgLibera;
  strHint: String; intTamanho: integer);
var
  objRegistro : TRegistroMsgLiberaTexto;
begin
  objRegistro                 := TRegistroMsgLiberaTexto.Create;
  objRegistro.strTexto        := strTexto;
  objRegistro.enuTipoExibicao := enuTipoExibicao;
  objRegistro.enuAlinhamento  := enuAlinhamento;
  objRegistro.strHint         := strHint;
  objRegistro.intTamanho      := intTamanho;
  Self.lstRegistros.Insert(IntPosicao, objRegistro);
end;

procedure TMensagemLiberacao.pInsertTextoCaption(intPosicao: integer;
  strCaption, strTexto: String; intTamanhoCaption: integer;
  enuAlinhamento: TAlinhamento; enuTipoExibicao: TTipoExibicaoMsgLibera;
  strHint: String; intTamanho: integer);
var
  objRegistro : TRegistroMsgLiberaTextoCaption;
begin

  objRegistro                   := TRegistroMsgLiberaTextoCaption.Create;
  objRegistro.strTexto          := strTexto;
  objRegistro.strCaption        := strCaption;
  objRegistro.intTamanhoCaption := intTamanhoCaption;
  objRegistro.enuTipoExibicao   := enuTipoExibicao;
  objRegistro.enuAlinhamento    := enuAlinhamento;
  objRegistro.strHint           := strHint;
  objRegistro.intTamanho        := intTamanho;
  Self.lstRegistros.Insert(intPosicao, objRegistro);
end;

constructor TMensagemLiberacao.Create(AOwner: TComponent);
begin
  FlstRegistros := TObjectList<TRegistroMsgLibera>.Create;
  Clear;
end;

destructor TMensagemLiberacao.Destroy;
begin
  If Assigned(FlstRegistros) Then
    FreeAndNil(FlstRegistros);
  inherited;
end;

function TMensagemLiberacao.fGetObjectFromJson( strJson : String): boolean;
var
  joMensagem : TJSONObject;

  jaRegistros : TJSONArray;
  joRegistro  : TJSONObject;
  jvRegistro  : TJSONValue;

  jaLinhas : TJSONArray;
  joLinha  : TJSONObject;
  jvLinha  : TJSONValue;

  jaColunas : TJSONArray;
  joColuna  : TJSONObject;
  jvColuna  : TJSONValue;

  objRegistro     : TRegistroMsgLibera;
  objLinha        : TLinhaMsgLibera;

  enuTipoRegistro : TTipoRegistroMsgLibera;
  enuTipoExibicao : TTipoExibicaoMsgLibera;
begin
  Result := False;

  strJson := fLimpaTagMsgOculta(strJson);

  joMensagem := TJSONObject.ParseJSONValue( strJson ) as TJSONObject;

  Self.strTitulo        := (joMensagem.GetValue('strTitulo')        as TJSONString).Value;
  Self.strJustificativa := (joMensagem.GetValue('strJustificativa') as TJSONString).Value;

  jaRegistros := (joMensagem.GetValue('lstRegistros') as TJSONArray);

  for jvRegistro in jaRegistros do
  begin
    if (jvRegistro is TJSONObject) then
    begin
      joRegistro      := (jvRegistro as TJSONObject);

      enuTipoExibicao := fStringToTipoExibicaoMsgLibera((joRegistro.GetValue('enuTipoExibicao') as TJSONString).Value);
      enuTipoRegistro := fStringToTipoRegistroMsgLibera((joRegistro.GetValue('enuTipo') as TJSONString).Value);
      case enuTipoRegistro of
        trTexto        :  begin
                            objRegistro                                          := TRegistroMsgLiberaTexto.Create;
                            objRegistro.enuTipo                                  := enuTipoRegistro;
                            objRegistro.enuTipoExibicao                          := enuTipoExibicao;
                            TRegistroMsgLiberaTexto(objRegistro).strTexto        := (joRegistro.GetValue('strTexto') as TJSONString).Value;
                            TRegistroMsgLiberaTexto(objRegistro).enuAlinhamento  := fStringToAlinhamento((joRegistro.GetValue('enuAlinhamento') as TJSONString).Value);
                            TRegistroMsgLiberaTexto(objRegistro).strHint         := (joRegistro.GetValue('strHint') as TJSONString).Value;
                            TRegistroMsgLiberaTexto(objRegistro).intTamanho      := (joRegistro.GetValue('intTamanho') as TJSONNumber).AsInt;
                          end;

        trSeparador    :  begin
                            objRegistro                                         := TRegistroMsgLiberaSeparador.Create;
                            objRegistro.enuTipo                                 := enuTipoRegistro;
                            objRegistro.enuTipoExibicao                         := enuTipoExibicao;
                            TRegistroMsgLiberaSeparador(objRegistro).intTamanho := (joRegistro.GetValue('intTamanho') as TJSONNumber).AsInt;
                          end;

        trTextoCaption :  begin
                            objRegistro                                                   := TRegistroMsgLiberaTextoCaption.Create;
                            objRegistro.enuTipo                                           := enuTipoRegistro;
                            objRegistro.enuTipoExibicao                                   := enuTipoExibicao;
                            TRegistroMsgLiberaTextoCaption(objRegistro).strTexto          := (joRegistro.GetValue('strTexto') as TJSONString).Value;
                            TRegistroMsgLiberaTextoCaption(objRegistro).strCaption        := (joRegistro.GetValue('strCaption') as TJSONString).Value;
                            TRegistroMsgLiberaTextoCaption(objRegistro).intTamanhoCaption := (joRegistro.GetValue('intTamanhoCaption') as TJSONNumber).AsInt;
                            TRegistroMsgLiberaTextoCaption(objRegistro).enuAlinhamento    := fStringToAlinhamento((joRegistro.GetValue('enuAlinhamento') as TJSONString).Value);
                            TRegistroMsgLiberaTextoCaption(objRegistro).strHint           := (joRegistro.GetValue('strHint') as TJSONString).Value;
                            TRegistroMsgLiberaTextoCaption(objRegistro).intTamanho        := (joRegistro.GetValue('intTamanho') as TJSONNumber).AsInt;
                          end;

        trTabela       :  begin
                            objRegistro                 := TRegistroMsgLiberaTabela.Create;
                            objRegistro.enuTipo         := enuTipoRegistro;
                            objRegistro.enuTipoExibicao := enuTipoExibicao;

                            jaLinhas := ( joRegistro.GetValue('lstLinhas') as TJSONArray );
                            for jvLinha in jaLinhas do
                            begin
                              if ( jvLinha is TJSONObject ) then
                              begin
                                objLinha := TLinhaMsgLibera.Create;
                                joLinha := ( jvLinha as TJSONObject );

                                objLinha.intAgrupador    := (joLinha.GetValue('intAgrupador') as TJSONNumber).AsInt;
                                objLinha.enuTipoLinha    := fStringToTipoLinhaMsgLibera( (joLinha.GetValue('enuTipoLinha') as TJSONString).Value );
                                objLinha.enuTipoExibicao := fStringToTipoExibicaoMsgLibera( (joLinha.GetValue('enuTipoExibicao') as TJSONString).Value );
                                objLinha.strHint         := (joLinha.GetValue('strHint') as TJSONString).Value;

                                jaColunas := ( joLinha.GetValue('lstColunas') as TJSONArray );
                                for jvColuna in jaColunas do
                                begin
                                  if ( jvColuna is TJSONObject ) then
                                  begin
                                    joColuna := ( jvColuna as TJSONObject );
                                    objLinha.pAddColuna(( joColuna.GetValue('strCaption') as TJSONString ).Value,
                                                        ( joColuna.GetValue('strTexto') as TJSONString ).Value,
                                                        ( joColuna.GetValue('intTamanho') as TJSONNumber ).AsInt,
                                                        fStringToAlinhamento( (joColuna.GetValue('enuAlinhamento') as TJSONString).Value ),
                                                        fStringToTipoExibicaoMsgLibera( (joColuna.GetValue('enuTipoExibicao') as TJSONString).Value ),
                                                        ( joColuna.GetValue('blnExibeCaption') as TJSONBool).AsBoolean );
                                  end;
                                end;

                                TRegistroMsgLiberaTabela(objRegistro).lstLinhas.Add(objLinha);

                              end;
                            end;
                          end;
        else
        begin
          begin
            objRegistro                 := TRegistroMsgLibera.Create;
            objRegistro.enuTipoExibicao := enuTipoExibicao;
            objRegistro.enuTipo         := enuTipoRegistro;
          end;
        end;
      end;

      Self.lstRegistros.Add(objRegistro);
      Result := True;
    end;
  end;

end;

function TMensagemLiberacao.isEmpty: Boolean;
begin
  Result := FlstRegistros.Count = 0;
end;

function TMensagemLiberacao.fGetJsonObject: TJSONObject;
var
  jaRegistros : TJSONArray;
  joRegistro  : TJSONObject;

  jaLinhas    : TJSONArray;
  joLinha     : TJSONObject;

  jaColunas   : TJSONArray;
  joColuna    : TJSONObject;

  objRegistro : TRegistroMsgLibera;
  objLinha    : TLinhaMsgLibera;
  objColuna   : TColunaMsgLibera;

begin
  Result      := TJSONObject.Create;
  jaRegistros := TJSONArray.Create;

  Result.AddPair(TJSONPair.Create('strTitulo', TJSONString.Create( strTitulo ) ) );
  Result.AddPair(TJSONPair.Create('strJustificativa', TJSONString.Create( strJustificativa ) ) );
  for objRegistro in Self.lstRegistros do
  begin
    joRegistro := TJSONObject.Create;
    joRegistro.AddPair(TJSONPair.Create('enuTipo'         , TJSONString.Create( fTipoRegistroMsgLiberaToString(objRegistro.enuTipo))));
    joRegistro.AddPair(TJSONPair.Create('enuTipoExibicao' , TJSONString.Create( fTipoExibicaoMsgLiberaToString(objRegistro.enuTipoExibicao))));
    case objRegistro.enuTipo of
      trTexto        : begin
                         joRegistro.AddPair(TJSONPair.Create('strTexto'       , TJSONString.Create(fLimpaTagMsgOculta(TRegistroMsgLiberaTexto(objRegistro).strTexto))));
                         joRegistro.AddPair(TJSONPair.Create('enuAlinhamento' , TJSONString.Create(fAlinhamentoToString(TRegistroMsgLiberaTexto(objRegistro).enuAlinhamento))));
                         joRegistro.AddPair(TJSONPair.Create('strHint'        , TJSONString.Create(TRegistroMsgLiberaTexto(objRegistro).strHint)));
                         joRegistro.AddPair(TJSONPair.Create('intTamanho'     , TJSONNumber.Create(TRegistroMsgLiberaTexto(objRegistro).intTamanho)));
                       end;

      trSeparador    : joRegistro.AddPair(TJSONPair.Create('intTamanho', TJSONNumber.Create(TRegistroMsgLiberaSeparador(objRegistro).intTamanho)));

      trTextoCaption : begin
                         joRegistro.AddPair(TJSONPair.Create('strTexto'         , TJSONString.Create(fLimpaTagMsgOculta(TRegistroMsgLiberaTextoCaption(objRegistro).strTexto))));
                         joRegistro.AddPair(TJSONPair.Create('strCaption'       , TJSONString.Create(fLimpaTagMsgOculta(TRegistroMsgLiberaTextoCaption(objRegistro).strCaption))));
                         joRegistro.AddPair(TJSONPair.Create('intTamanhoCaption', TJSONNumber.Create(TRegistroMsgLiberaTextoCaption(objRegistro).intTamanhoCaption)));
                         joRegistro.AddPair(TJSONPair.Create('enuAlinhamento'   , TJSONString.Create(fAlinhamentoToString(TRegistroMsgLiberaTexto(objRegistro).enuAlinhamento))));
                         joRegistro.AddPair(TJSONPair.Create('strHint'          , TJSONString.Create(TRegistroMsgLiberaTextoCaption(objRegistro).strHint)));
                         joRegistro.AddPair(TJSONPair.Create('intTamanho'       , TJSONNumber.Create(TRegistroMsgLiberaTextoCaption(objRegistro).intTamanho)));
                       end;

      trTabela       : begin
                         jaLinhas := TJSONArray.Create;

                         for objLinha in TRegistroMsgLiberaTabela(objRegistro).lstLinhas do
                         begin
                           joLinha := TJSONObject.Create;
                           joLinha.AddPair(TJSONPair.Create('enuTipoExibicao' , TJSONString.Create( fTipoExibicaoMsgLiberaToString(objLinha.enuTipoExibicao))));
                           joLinha.AddPair(TJsonPair.Create('intAgrupador'    , TJSONNumber.Create( objLinha.intAgrupador )));
                           joLinha.AddPair(TJsonPair.Create('enuTipoLinha'    , TJSONString.Create( fTipoLinhaMsgLiberaToString( objLinha.enuTipoLinha ) )));
                           joLinha.AddPair(TJSONPair.Create('strHint'         , TJSONString.Create( objLinha.strHint ) ) );

                           jaColunas := TJSONArray.Create;
                           for objColuna in objLinha.lstColunas do
                           begin
                             joColuna := TJSONObject.Create;

                             joColuna.AddPair(TJSONPair.Create('strTexto'        , TJSONString.Create(fLimpaTagMsgOculta( objColuna.strTexto ))));
                             joColuna.AddPair(TJSONPair.Create('intTamanho'      , TJSONNumber.Create( objColuna.intTamanho )));
                             joColuna.AddPair(TJSONPair.Create('strCaption'      , TJSONString.Create(fLimpaTagMsgOculta( objColuna.strCaption ))));
                             joColuna.AddPair(TJSONPair.Create('enuAlinhamento'  , TJSONString.Create(fAlinhamentoToString(objColuna.enuAlinhamento))));
                             joColuna.AddPair(TJSONPair.Create('enuTipoExibicao' , TJSONString.Create( fTipoExibicaoMsgLiberaToString(objColuna.enuTipoExibicao))));
                             joColuna.AddPair(TJSONPair.Create('blnExibeCaption' , TJSONBool.Create( objColuna.blnExibeCaption )));
                             jaColunas.Add(joColuna);
                           end;

                           joLinha.AddPair(TJSONPair.Create('lstColunas', jaColunas));

                           jaLinhas.Add(joLinha);
                         end;

                         joRegistro.AddPair(TJSONPair.Create('lstLinhas', jaLinhas));
                       end;

    end;

    jaRegistros.Add(joRegistro);
  end;

  Result.AddPair(TJSONPair.Create('lstRegistros', jaRegistros));

end;

function TMensagemLiberacao.fGetMensagem(intQuantidadeLinhas: Integer = 0; blnLimitaQuantidadeDuplicata: Boolean = False): String;
var
  objRegistro        : TRegistroMsgLibera;
  objLinha           : TLinhaMsgLibera;
  objColuna          : TColunaMsgLibera;
  strLinha           : String;
  strValor           : String;
  stlResult          : TStringList;
  intLarguraTabela   : integer;
  intLarguraTexto    : integer;
  intIncLinhas       : integer;
  enuUltimoTipoLinha : TTipoLinhaMsgLibera;

  //alinha o texto
  function fAlinha(strTexto : String; enuAlinhamento : TAlinhamento; intTamanho : integer; chrChar : Char = ' ') : String;
  var
    intDif   : integer;
    intLeft  : integer;
    intRight : integer;
  begin
    Result  := strTexto;

    if intTamanho > 0 then
    begin
      intDif := intTamanho - length(Result);

      if intDif > 0 then
      begin
        Case enuAlinhamento of
          alEsquerda : Result := Result + StringOfChar(chrChar,intDif);

          alDireita  : Result := StringOfChar(chrChar, intDif) + Result;

          alCentro   : begin
                         intLeft  := (intDif Div 2);
                         intRight := (intDif Div 2) + intDif Mod 2;

                         Result   := Result + StringOfChar(chrChar,intRight);
                         Result   := StringOfChar(chrChar, intLeft) + Result;
                       end;
        end;
      end;

      Result := Copy(Result, 1, intTamanho);
    end;
  end;

begin
  stlResult := TStringList.Create;
  try
    stlResult.Clear;
    for objRegistro in Self.lstRegistros do
    begin
      if objRegistro.enuTipoExibicao in [teAmbos, teAutcom] then
      begin
        case objRegistro.enuTipo of
          trTexto        : begin
                             //define a largura sem ultrapassar o limite configurado
                             if TRegistroMsgLiberaTexto(objRegistro).intTamanho > 0 then
                               intLarguraTexto := TRegistroMsgLiberaTexto(objRegistro).intTamanho
                             else
                               intLarguraTexto := LARGURA_TEXTO;

                             strValor := TRegistroMsgLiberaTexto(objRegistro).strTexto;
                             strValor := fAlinha(strValor, TRegistroMsgLiberaTexto(objRegistro).enuAlinhamento, intLarguraTexto);

                             stlResult.Add(strValor);
                           end;
          trQuebra       : stlResult.Add('');
          trSeparador    : begin
                             //define a largura sem ultrapassar o limite configurado
                             if TRegistroMsgLiberaSeparador(objRegistro).intTamanho = 0 then
                               stlResult.Add(StringOfChar('-',LARGURA_TEXTO))
                             else
                               stlResult.Add(StringOfChar('-',TRegistroMsgLiberaSeparador(objRegistro).intTamanho));
                           end;
          trTextoCaption : begin
                             strLinha := TRegistroMsgLiberaTextoCaption(objRegistro).strCaption;
                             //se for maior que zero, define o tamanho do caption e adiciona pontos à direita
                             if TRegistroMsgLiberaTextoCaption(objRegistro).intTamanhoCaption > 0 then
                               strLinha := fAlinha(strLinha, alEsquerda, TRegistroMsgLiberaTextoCaption(objRegistro).intTamanhoCaption, '.');


                             //se chega um caption, adiciona :
                             if Trim(strLinha) <> '' then
                               strLinha := strLinha + ': ';

                             //define o tamanho do texto para linhamento
                             if TRegistroMsgLiberaTexto(objRegistro).intTamanho > 0 then
                               intLarguraTexto := TRegistroMsgLiberaTexto(objRegistro ).intTamanho
                             else
                               intLarguraTexto := LARGURA_TEXTO - Length(strLinha);

                             strValor := TRegistroMsgLiberaTextoCaption(objRegistro).strTexto;
                             strValor := fAlinha(strValor, TRegistroMsgLiberaTexto(objRegistro).enuAlinhamento, intLarguraTexto);

                             strLinha := strLinha + strValor;
                             stlResult.Add(strLinha);
                           end;

          trTabela       : begin
                             { Exemplo de Formato da tabela                   }
                             {           -----------------------------------  }
                             { cabeçalho :|Campo1 |Campo2    |Campo3        | }
                             { cabeçalho :|Campo4                           | }
                             {           -----------------------------------  }
                             { Valor     :|Valor1 |Valor2    |Valor3        | }
                             { Valor     :|Valor4                           | }
                             {           -----------------------------------  }
                             { Total     :|                                   }

                             intLarguraTabela := 0;
                             intIncLinhas     := 0;
                             enuUltimoTipoLinha := tlNull;
                             for objLinha in TRegistroMsgLiberaTabela(objRegistro).lstLinhas do
                             begin
                               if objLinha.enuTipoExibicao in [teAmbos, teAutcom] then
                               begin

                                 strLinha := '|';
                                 case objLinha.enuTipoLinha of
                                   tlCabecalho :    begin
                                                      for objColuna in objLinha.lstColunas do
                                                      begin
                                                        if objColuna.enuTipoExibicao in [teAmbos, teAutcom] then
                                                        begin
                                                          strValor := fAlinha(objColuna.strTexto, objColuna.enuAlinhamento, objColuna.intTamanho);
                                                          strLinha := strLinha + strValor + ' |';
                                                        end;
                                                      end;

                                                      //define a largura da tabela na primeira vez, para gerar os separadores
                                                      if intLarguraTabela = 0 then
                                                        intLarguraTabela := Length(strLinha);

                                                      //se for mais de uma linha de cabeçalho seguida, não utiliza separador entre elas
                                                      if not (enuUltimoTipoLinha = tlCabecalho) then
                                                        stlResult.Add(StringOfChar('-',intLarguraTabela));

                                                      stlResult.Add(strLinha);

                                                    end;

                                   tlValor     :    begin

                                                      for objColuna in objLinha.lstColunas do
                                                      begin

                                                        If (intQuantidadeLinhas > 0) And (blnLimitaQuantidadeDuplicata) Then {Limita a quantidade de linhas no corpo da menssagem}
                                                        Begin
                                                          If intIncLinhas < intQuantidadeLinhas then
                                                          Begin
                                                            if objColuna.enuTipoExibicao in [teAmbos, teAutcom] then
                                                            begin

                                                              //se exibe caption na linha, adiciona o caption e :
                                                              if objColuna.blnExibeCaption then
                                                                strValor := objColuna.strCaption + ': '
                                                              else
                                                                strValor := '';

                                                              strValor := strValor + fAlinha(objColuna.strTexto, objColuna.enuAlinhamento, objColuna.intTamanho - Length(strValor));

                                                              strLinha := strLinha + strValor + ' |';
                                                            end;
                                                          End
                                                        End

                                                        Else

                                                        Begin
                                                          if objColuna.enuTipoExibicao in [teAmbos, teAutcom] then
                                                          begin

                                                            //se exibe caption na linha, adiciona o caption e :
                                                            if objColuna.blnExibeCaption then
                                                              strValor := objColuna.strCaption + ': '
                                                            else
                                                              strValor := '';

                                                            strValor := strValor + fAlinha(objColuna.strTexto, objColuna.enuAlinhamento, objColuna.intTamanho - Length(strValor));

                                                            strLinha := strLinha + strValor + ' |';
                                                          end;
                                                        End;

                                                      end;

                                                      //define a largura da tabela na primeira vez, para gerar os separadores
                                                      if intLarguraTabela = 0 then
                                                        intLarguraTabela := Length(strLinha);

                                                      if enuUltimoTipoLinha <> tlValor then
                                                        stlResult.Add(StringOfChar('-',intLarguraTabela));

                                                      If (intQuantidadeLinhas > 0) And (blnLimitaQuantidadeDuplicata) Then
                                                      Begin
                                                        If strLinha <> '|' then
                                                        Begin
                                                          stlResult.Add(strLinha);
                                                          intIncLinhas:= intIncLinhas + 1;
                                                        End;
                                                        If intIncLinhas = intQuantidadeLinhas Then
                                                        Begin
                                                          intIncLinhas:= intIncLinhas + 1;
                                                          stlResult.Add('"** Atenção! Quantidade limitada a '+intToStr(intQuantidadeLinhas)+' duplicatas na liberação remota!"');
                                                        End;
                                                      End
                                                      Else
                                                        stlResult.Add(strLinha);
                                                    end;

                                   tlTotal     :   begin
                                                     for objColuna in objLinha.lstColunas do
                                                     begin
                                                       if objColuna.enuTipoExibicao in [teAmbos, teAutcom] then
                                                       begin
                                                         //se exibe caption na linha, adiciona o caption e :
                                                         if objColuna.blnExibeCaption then
                                                           strValor := objColuna.strCaption + ': '
                                                         else
                                                           strValor := '';

                                                         strValor := strValor + fAlinha(objColuna.strTexto, objColuna.enuAlinhamento, objColuna.intTamanho - Length(strValor));

                                                         strLinha := strLinha + strValor + ' |';

                                                        end;
                                                     end;

                                                     //define a largura da tabela na primeira vez, para gerar os separadores
                                                     if intLarguraTabela = 0 then
                                                       intLarguraTabela := Length(strLinha);

                                                     //se for mais de uma linha de Total seguida, não utiliza separador entre elas
                                                     if not (enuUltimoTipoLinha = tlTotal) then
                                                       stlResult.Add(StringOfChar('-',intLarguraTabela));
                                                     stlResult.Add(strLinha);
                                                   end;
                                 end;

                                 enuUltimoTipoLinha := objLinha.enuTipoLinha;
                               end;
                             end;

                             // fecha a tabela
                             stlResult.Add(StringOfChar('-',intLarguraTabela));
                           end;
        end;

      end;
    end;

    //adiciona justificativa na mensagem
    pAddJustificativa(stlResult);

    Result := stlResult.Text;
  finally
    FreeAndNil(stlResult);
  end;
end;

function TRegistroMsgLiberaTabela.fGetTamanhoFinalCabecalho: Integer;
var
  objLinha           : TLinhaMsgLibera;
  objColuna          : TColunaMsgLibera;
begin
  Result := 0;
  for objLinha in Self.lstLinhas do
  begin
    if objLinha.enuTipoExibicao in [teAmbos, teAutcom] then
    begin
      case objLinha.enuTipoLinha of
        tlCabecalho : begin
                        for objColuna in objLinha.lstColunas do
                        begin
                          if objColuna.enuTipoExibicao in [teAmbos, teAutcom] then
                          begin
                            Result := Result + objColuna.intTamanho + 2; 
                          end;
                        end;
                      end;
      End;
    End;
  End;
  If Result > 0 Then
    Result := Result + 1;
end;

function TMensagemLiberacao.fGetMensagemApp: String;
var
  objRegistro : TRegistroMsgLibera;
  objLinha    : TLinhaMsgLibera;
  objColuna   : TColunaMsgLibera;
  strLinha    : String;
  strValor    : String;
  stlResult   : TStringList;
  intAgrupador: integer;
  intLarguraTexto : integer;
begin
  stlResult := TStringList.Create;
  try
    stlResult.Clear;
    for objRegistro in Self.lstRegistros do
    begin
      if objRegistro.enuTipoExibicao in [teAmbos, teApp] then
      begin
        case objRegistro.enuTipo of
          trTexto        : stlResult.Add(TRegistroMsgLiberaTexto(objRegistro).strTexto);
          trQuebra       : stlResult.Add('');
          trSeparador    : begin
                             if (TRegistroMsgLiberaSeparador(objRegistro).intTamanho = 0) or (TRegistroMsgLiberaSeparador(objRegistro).intTamanho > LARGURA_TEXTO_APP) then
                               intLarguraTexto := LARGURA_TEXTO_APP
                             else
                               intLarguraTexto := TRegistroMsgLiberaSeparador(objRegistro).intTamanho;

                             stlResult.Add(StringOfChar('-',intLarguraTexto))
                           end;
          trTextoCaption : begin
                             strLinha := Trim(TRegistroMsgLiberaTextoCaption(objRegistro).strCaption);
                             if strLinha <> '' then
                               strLinha := strLinha + ': ';
                             strLinha := strLinha + TRegistroMsgLiberaTextoCaption(objRegistro).strTexto;
                             stlResult.Add(strLinha);
                           end;

          trTabela       : begin
                             intAgrupador := -1;
                             for objLinha in TRegistroMsgLiberaTabela(objRegistro).lstLinhas do
                             begin
                               if objLinha.enuTipoExibicao in [teAmbos, teAutcom] then
                               begin

                                 if (intAgrupador = -1) or (intAgrupador <> objLinha.intAgrupador) then
                                   stlResult.Add('');

                                 intAgrupador := objLinha.intAgrupador;
                                 if objLinha.enuTipoLinha = tlTotal then
                                 begin
                                   stlResult.Add('');
                                   stlResult.Add('TOTAIS:');
                                 end;

                                 for objColuna in objLinha.lstColunas do
                                 begin
                                   if objColuna.enuTipoExibicao in [teAmbos, teApp] then
                                   begin
                                     strValor := Trim(objColuna.strCaption);
                                     if strValor <> '' then
                                       strValor := strValor + ': ';

                                     strValor := strValor + objColuna.strTexto;

                                     stlResult.Add( strValor );
                                   end;
                                 end;
                               end;

                             end;
                             stlResult.Add('');
                           end;
        end;
      end;
    end;

    pAddJustificativa(stlResult);

    Result := stlResult.Text;
  finally
    FreeAndNil(stlResult);
  end;
end;

{ TLinhaMsgLibera }

procedure TLinhaMsgLibera.Clear;
begin
  inherited;
  FlstColunas.Clear;
  FintAgrupador    := -1;
  FenuTipoLinha    := tlValor;
  FenuTipoExibicao := teAmbos;
  FstrHint         := '';
end;

constructor TLinhaMsgLibera.Create;
begin
  FlstColunas := TObjectList<TColunaMsgLibera>.Create;
  Clear;
  inherited;
end;

destructor TLinhaMsgLibera.Destroy;
begin
  FreeAndNil(FlstColunas);
  inherited;
end;

function TLinhaMsgLibera.fGetClone: TLinhaMsgLibera;
var
  objColunaOri : TColunaMsgLibera;
begin
  Result                 := TLinhaMsgLibera.Create;
  Result.enuTipoExibicao := Self.enuTipoExibicao;
  Result.intAgrupador    := Self.intAgrupador;
  Result.enuTipoLinha    := Self.enuTipoLinha;
  Result.strHint         := Self.strHint;

  for objColunaOri in Self.lstColunas do
    Result.lstColunas.Add(objColunaOri.fGetClone);



end;

function TLinhaMsgLibera.fIgual(objLinha: TLinhaMsgLibera): boolean;
var
  i : integer;
begin
  Result := Self.lstColunas.Count = objLinha.lstColunas.Count;
  if Result then
  begin
    for i := 0 to Self.lstColunas.Count - 1 do
    begin
      if Self.lstColunas[i].strTexto <> objLinha.lstColunas[i].strTexto then
      begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

procedure TLinhaMsgLibera.pAddColuna(strCaption, strTexto : String; intTamanho : Integer ; enuAlinhamento : TAlinhamento = alEsquerda;  enuTipoExibicao : TTipoExibicaoMsgLibera = teAmbos; blnExibeCaption : Boolean = False);
var
  objColuna : TColunaMsgLibera;
begin
  objColuna                   := TColunaMsgLibera.Create;
  objColuna.strTexto          := strTexto;
  objColuna.intTamanho        := intTamanho;
  objColuna.strCaption        := strCaption;
  objColuna.enuTipoExibicao   := enuTipoExibicao;
  objColuna.blnExibeCaption   := blnExibeCaption;
  objColuna.enuAlinhamento    := enuAlinhamento;
  lstColunas.Add(objColuna);
end;

{ String }

procedure TColunaMsgLibera.Clear;
begin
  FstrTexto          := '';
  FstrCaption        := '';
  FintTamanho        := 0;
  FenuTipoExibicao   := teAmbos;
  FblnExibeCaption   := False;
  FenuAlinhamento    := alEsquerda;
end;

constructor TColunaMsgLibera.Create;
begin
  clear;
end;


function TColunaMsgLibera.fGetClone: TColunaMsgLibera;
begin
  Result                 := TColunaMsgLibera.Create;
  Result.enuTipoExibicao := Self.enuTipoExibicao;
  Result.strTexto        := Self.strTexto;
  Result.strCaption      := Self.strCaption;
  Result.intTamanho      := Self.intTamanho;
  Result.blnExibeCaption := Self.blnExibeCaption;
  Result.enuAlinhamento  := Self.enuAlinhamento;
end;

{ TRegistroMsgLibera }

procedure TRegistroMsgLibera.Clear;
begin
  if      (Self is TRegistroMsgLiberaTabela) then
    FenuTipo := trTabela
  else if (Self is TRegistroMsgLiberaTextoCaption) then
    FenuTipo := trTextoCaption
  else if (Self is TRegistroMsgLiberaTexto) then
    FenuTipo := trTexto
  else if (Self is TRegistroMsgLiberaSeparador) then
    FenuTipo := trSeparador
  else
    FenuTipo := trQuebra;

  FenuTipoExibicao := teAmbos;
end;

constructor TRegistroMsgLibera.Create;
begin
  clear;
end;

function TRegistroMsgLibera.fGetClone: TRegistroMsgLibera;
var
  objLinhaOri : TLinhaMsgLibera;
begin
  Case Self.FenuTipo of
    trTexto,
    trTextoCaption : begin
                       if Self.FenuTipo = trTextoCaption then
                       begin
                         Result              := TRegistroMsgLiberaTextoCaption.Create;
                         TRegistroMsgLiberaTextoCaption(Result).strCaption         := TRegistroMsgLiberaTextoCaption(Self).strCaption;
                         TRegistroMsgLiberaTextoCaption(Result).intTamanhoCaption := TRegistroMsgLiberaTextoCaption(Self).intTamanhoCaption;
                       end
                       else
                         Result := TRegistroMsgLiberaTexto.Create;

                       TRegistroMsgLiberaTexto(Result).strTexto       := TRegistroMsgLiberaTexto(Self).strTexto;
                       TRegistroMsgLiberaTexto(Result).strHint        := TRegistroMsgLiberaTexto(Self).strTexto;
                       TRegistroMsgLiberaTexto(Result).enuAlinhamento := TRegistroMsgLiberaTexto(Self).enuAlinhamento;
                       TRegistroMsgLiberaTexto(Result).intTamanho     := TRegistroMsgLiberaTexto(Self).intTamanho;
                     end;

    trSeparador    : begin
                       Result := TRegistroMsgLiberaSeparador.Create;
                       TRegistroMsgLiberaSeparador(Result).intTamanho := TRegistroMsgLiberaSeparador(Self).intTamanho;
                     end;

    trTabela       : begin
                       Result := TRegistroMsgLiberaTabela.Create;

                       for objLinhaOri in TRegistroMsgLiberaTabela(Self).lstLinhas do
                         TRegistroMsgLiberaTabela(Result).lstLinhas.Add(objLinhaOri.fGetClone);
                     end;

    else             Result := TRegistroMsgLibera.Create;
  end;



  Result.enuTipo         := Self.enuTipo;
  Result.enuTipoExibicao := Self.enuTipoExibicao;
end;

{ TRegistroMsgLiberaTexto }

procedure TRegistroMsgLiberaTexto.Clear;
begin
  inherited;
  FstrTexto       := '';
  FstrHint        := '';
  FenuAlinhamento := alEsquerda;
  FintTamanho     := 0;
end;

{ TRegistroMsgLiberaTabela }

procedure TRegistroMsgLiberaTabela.Clear;
begin
  inherited;
  FlstLinhas.Clear;
end;

constructor TRegistroMsgLiberaTabela.Create;
begin
  FlstLinhas := TObjectList<TLinhaMsgLibera>.Create;
  inherited;
end;

destructor TRegistroMsgLiberaTabela.Destroy;
begin
  FreeAndNil(FlstLinhas);
  inherited;
end;


function TRegistroMsgLiberaTabela.fIgual(
  objTabela: TRegistroMsgLiberaTabela): boolean;
var
  i : integer;
begin
  Result := Self.lstLinhas.Count = objTabela.lstLinhas.Count;

  if Result then
  begin
    for i := 0 to Self.lstLinhas.Count - 1 do
    begin
      if not Self.lstLinhas[i].fIgual(objTabela.lstLinhas[i]) then
      begin
        Result := False;
        Break;
      end;
    end;
  end;

end;

function TRegistroMsgLiberaTabela.isEmpty: Boolean;
begin
  Result := FlstLinhas.Count = 0;
end;

{ TRegistroMsgLiberaTextoCaption }

procedure TRegistroMsgLiberaTextoCaption.Clear;
begin
  FstrCaption := '';
  FintTamanhoCaption := 0;
  inherited;
end;


{ TRegistroMsgLiberaSeparador }

procedure TRegistroMsgLiberaSeparador.Clear;
begin
  inherited;
  FintTamanho := 0;
end;

initialization

  RegisterClass(TRegistroMsgLibera);
  RegisterClass(TRegistroMsgLiberaTexto);
  RegisterClass(TRegistroMsgLiberaTextoCaption);
  RegisterClass(TRegistroMsgLiberaSeparador);
  RegisterClass(TRegistroMsgLiberaTabela);
  RegisterClass(TLinhaMsgLibera);
  RegisterClass(TColunaMsgLibera);

end.

