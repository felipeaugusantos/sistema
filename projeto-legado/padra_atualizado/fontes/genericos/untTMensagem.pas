unit untTMensagem;

interface

uses
  untTypesSistema, FulFillment.Classes, untFuncoesSimples;

type
  TEstiloFonte = (efArial = 1, efCourier = 2);

  IMensagemParams = interface
    ['{16CBD826-E2A0-4E8E-8E52-7443F7E04BB9}']
    function Titulo: String; overload;
    function Titulo(const Value: String): IMensagemParams; overload;

    function Texto: String; overload;
    function Texto(const Value: String): IMensagemParams; overload;

    function Botoes: TStringArray; overload;
    function Botoes(const Value: TStringArray): IMensagemParams; overload;

    function FocoBotao: Integer; overload;
    function FocoBotao(const Value: Integer): IMensagemParams; overload;

    function SaiComEsc: Boolean; overload;
    function SaiComEsc(const Value: Boolean): IMensagemParams; overload;

    function ObrigaEsc: Boolean; overload;
    function ObrigaEsc(const Value: Boolean): IMensagemParams; overload;

    function EstiloFonte: TEstiloFonte; overload;
    function EstiloFonte(const Value: TEstiloFonte): IMensagemParams; overload;

    function FormMaximizado: Boolean; overload;
    function FormMaximizado(const Value: Boolean): IMensagemParams; overload;

    function SomarTop: Integer; overload;
    function SomarTop(const Value: Integer): IMensagemParams; overload;

    function OcultaPainelBotoes: Boolean; overload;
    function OcultaPainelBotoes(const Value: Boolean): IMensagemParams; overload;

    function BotoesSemImagem: Boolean; overload;
    function BotoesSemImagem(const Value: Boolean): IMensagemParams; overload;

    function AlturaForm: Integer; overload;
    function AlturaForm(const Value: Integer): IMensagemParams; overload;

    function LarguraForm: Integer; overload;
    function LarguraForm(const Value: Integer): IMensagemParams; overload;

    function LarguraBotoes: Integer; overload;
    function LarguraBotoes(const Value: Integer): IMensagemParams; overload;

    function QuantLinhas: Integer; overload;
    function QuantLinhas(const Value: Integer): IMensagemParams; overload;

    function FulfillmentLog: TFulFillmentLogBuilder; overload;
    function FulfillmentLog(const Value: TFulFillmentLogBuilder): IMensagemParams; overload;
  end;

  IMensagem = interface
    ['{69956C45-22EC-46D8-864D-759AAB3A95DF}']
    function Show: Integer;
  end;


  TMensagemParams = class(TInterfacedObject, IMensagemParams)
  private
    FTitulo: String;
    FTexto: String;
    FBotoes: TStringArray;
    FFocoBotao: Integer;
    FSaiComEsc: Boolean;
    FObrigaEsc: Boolean;
    FEstiloFonte: TEstiloFonte;
    FFormMaximizado: Boolean;
    FSomarTop: Integer;
    FOcultaPainelBotoes: Boolean;
    FBotoesSemImagem: Boolean;
    FAlturaForm: Integer;
    FLarguraForm: Integer;
    FLarguraBotoes: Integer;
    FQuantLinhas: Integer;
    FFulfillmentLog: TFulFillmentLogBuilder;
  public
    function Titulo: String; overload;
    function Titulo(const Value: String): IMensagemParams; overload;

    function Texto: String; overload;
    function Texto(const Value: String): IMensagemParams; overload;

    function Botoes: TStringArray; overload;
    function Botoes(const Value: TStringArray): IMensagemParams; overload;

    function FocoBotao: Integer; overload;
    function FocoBotao(const Value: Integer): IMensagemParams; overload;

    function SaiComEsc: Boolean; overload;
    function SaiComEsc(const Value: Boolean): IMensagemParams; overload;

    function ObrigaEsc: Boolean; overload;
    function ObrigaEsc(const Value: Boolean): IMensagemParams; overload;

    function EstiloFonte: TEstiloFonte; overload;
    function EstiloFonte(const Value: TEstiloFonte): IMensagemParams; overload;

    function FormMaximizado: Boolean; overload;
    function FormMaximizado(const Value: Boolean): IMensagemParams; overload;

    function SomarTop: Integer; overload;
    function SomarTop(const Value: Integer): IMensagemParams; overload;

    function OcultaPainelBotoes: Boolean; overload;
    function OcultaPainelBotoes(const Value: Boolean): IMensagemParams; overload;

    function BotoesSemImagem: Boolean; overload;
    function BotoesSemImagem(const Value: Boolean): IMensagemParams; overload;

    function AlturaForm: Integer; overload;
    function AlturaForm(const Value: Integer): IMensagemParams; overload;

    function LarguraForm: Integer; overload;
    function LarguraForm(const Value: Integer): IMensagemParams; overload;

    function LarguraBotoes: Integer; overload;
    function LarguraBotoes(const Value: Integer): IMensagemParams; overload;

    function QuantLinhas: Integer; overload;
    function QuantLinhas(const Value: Integer): IMensagemParams; overload;

    function FulfillmentLog: TFulFillmentLogBuilder; overload;
    function FulfillmentLog(const Value: TFulFillmentLogBuilder): IMensagemParams; overload;

    constructor Create;
    class function New: IMensagemParams;
  end;

  TMensagem = class(TInterfacedObject, IMensagem)
  private
    FParametros: IMensagemParams;
  public
    constructor Create(AParametros: IMensagemParams);
    class function New(AParametros: IMensagemParams): IMensagem;
    function Show: Integer;
  end;

implementation

{ TMensagemParams }

function TMensagemParams.AlturaForm: Integer;
begin
  Result := FAlturaForm;
end;

function TMensagemParams.AlturaForm(const Value: Integer): IMensagemParams;
begin
  Result := Self;
  FAlturaForm := Value;
end;

function TMensagemParams.FormMaximizado: Boolean;
begin
  Result := FFormMaximizado;
end;

function TMensagemParams.FormMaximizado(const Value: Boolean): IMensagemParams;
begin
  Result := Self;
  FFormMaximizado := Value;
end;

function TMensagemParams.BotoesSemImagem: Boolean;
begin
  Result := FBotoesSemImagem;
end;

function TMensagemParams.BotoesSemImagem(const Value: Boolean): IMensagemParams;
begin
  Result := Self;
  FBotoesSemImagem := Value;
end;

function TMensagemParams.EstiloFonte: TEstiloFonte;
begin
  Result := FEstiloFonte;
end;

function TMensagemParams.EstiloFonte(const Value: TEstiloFonte): IMensagemParams;
begin
  Result := Self;
  FEstiloFonte := Value;
end;

function TMensagemParams.FocoBotao: Integer;
begin
  Result := FFocoBotao;
end;

function TMensagemParams.FocoBotao(const Value: Integer): IMensagemParams;
begin
  Result := Self;
  FFocoBotao := Value;
end;

function TMensagemParams.FulfillmentLog: TFulFillmentLogBuilder;
begin
  Result := FFulfillmentLog;
end;

function TMensagemParams.FulfillmentLog(const Value: TFulFillmentLogBuilder): IMensagemParams;
begin
  Result := Self;
  FFulfillmentLog := Value;
end;

function TMensagemParams.LarguraBotoes: Integer;
begin
  Result := FLarguraBotoes;
end;

function TMensagemParams.LarguraBotoes(const Value: Integer): IMensagemParams;
begin
  Result := Self;
  FLarguraBotoes := Value;
end;

function TMensagemParams.LarguraForm: Integer;
begin
  Result := FLarguraForm;
end;

function TMensagemParams.LarguraForm(const Value: Integer): IMensagemParams;
begin
  Result := Self;
  FLarguraForm := Value;
end;

function TMensagemParams.ObrigaEsc: Boolean;
begin
  Result := FObrigaEsc;
end;

function TMensagemParams.ObrigaEsc(const Value: Boolean): IMensagemParams;
begin
  Result := Self;
  FObrigaEsc := Value;
end;

function TMensagemParams.OcultaPainelBotoes: Boolean;
begin
  Result := FOcultaPainelBotoes;
end;

function TMensagemParams.OcultaPainelBotoes(const Value: Boolean): IMensagemParams;
begin
  Result := Self;
  FOcultaPainelBotoes := Value;
end;

function TMensagemParams.Botoes: TStringArray;
begin
  Result := FBotoes;
end;

function TMensagemParams.Botoes(const Value: TStringArray): IMensagemParams;
begin
  Result := Self;
  if Length(Value) > 0 then
    FBotoes := Value;
end;

function TMensagemParams.QuantLinhas: Integer;
begin
  Result := FQuantLinhas;
end;

function TMensagemParams.QuantLinhas(const Value: Integer): IMensagemParams;
begin
  Result := Self;
  FQuantLinhas := Value;
end;

function TMensagemParams.SaiComEsc: Boolean;
begin
  Result := FSaiComEsc;
end;

function TMensagemParams.SaiComEsc(const Value: Boolean): IMensagemParams;
begin
  Result := Self;
  FSaiComEsc := Value;
end;

function TMensagemParams.SomarTop: Integer;
begin
  Result := FSomarTop;
end;

function TMensagemParams.SomarTop(const Value: Integer): IMensagemParams;
begin
  Result := Self;
  FSomarTop := Value;
end;

function TMensagemParams.Texto: String;
begin
  Result := FTexto;
end;

function TMensagemParams.Texto(const Value: String): IMensagemParams;
begin
  Result := Self;
  FTexto := Value;
end;

function TMensagemParams.Titulo: String;
begin
  Result := FTitulo;
end;

function TMensagemParams.Titulo(const Value: String): IMensagemParams;
begin
  Result := Self;
  FTitulo := Value;
end;

constructor TMensagemParams.Create;
begin
  FTitulo := '';
  FTexto := '';
  FBotoes := ['&OK'];
  FFocoBotao := 1;
  FSaiComEsc := False;
  FObrigaEsc := False;
  FEstiloFonte := efArial;
  FFormMaximizado := False;
  FSomarTop := 0;
  FOcultaPainelBotoes := False;
  FBotoesSemImagem := False;
  FAlturaForm := 0;
  FLarguraForm := 0;
  FLarguraBotoes := 0;
  FQuantLinhas := -1;
  FFulfillmentLog := nil;
end;

class function TMensagemParams.New: IMensagemParams;
begin
  Result := Self.Create;
end;

{ TMensagem }

constructor TMensagem.Create(AParametros: IMensagemParams);
begin
  FParametros := AParametros;
end;

class function TMensagem.New(AParametros: IMensagemParams): IMensagem;
begin
  Result := Self.Create(AParametros);
end;

function TMensagem.Show: Integer;
begin
  if Assigned(FParametros.FulfillmentLog) then
  begin
    FParametros.FulfillmentLog.pSalvarLog(FParametros.Texto, True);
    Exit(0);
  end;

  Result := untFuncoesSimples.fMensagem(
    FParametros.Titulo,
    FParametros.Texto,
    FParametros.Botoes,
    FParametros.FocoBotao,
    FParametros.SaiComEsc,
    Integer(FParametros.EstiloFonte),
    FParametros.LarguraBotoes,
    FParametros.FormMaximizado,
    FParametros.SomarTop,
    FParametros.ObrigaEsc,
    FParametros.OcultaPainelBotoes,
    FParametros.BotoesSemImagem,
    FParametros.AlturaForm,
    FParametros.LarguraForm,
    FParametros.QuantLinhas);
end;

end.

