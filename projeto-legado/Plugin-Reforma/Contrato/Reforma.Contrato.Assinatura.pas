unit Reforma.Contrato.Assinatura;

// Handshake estrutural entre o host e a DLL (RF do contrato). O VERSAO_CONTRATO
// (Reforma.Contrato.Exportacao) e um numero que alguem tem que lembrar de subir;
// esta unit calcula uma assinatura a partir do que o compilador gerou de fato para
// as interfaces do contrato (metodo, parametros, tipos, tamanho dos records), por
// RTTI. Exe e DLL calculam cada um a sua, chamando esta mesma funcao compilada no
// proprio modulo: se um dos dois foi compilado de um Reforma.Contrato.* diferente
// (campo trocado, parametro mudado, mesmo sem bump de versao), as assinaturas
// divergem sozinhas e o loader recusa a DLL, em vez de carregar com layout errado.
//
// Limite conhecido: RTTI de record por padrao traz o TypeSize mas nao,
// confiavelmente, a lista de campos (exigiria {$RTTI FIELDS(...)} em cada record).
// TypeSize pega a maioria dos erros reais (campo adicionado, removido ou trocado
// por um tipo de tamanho diferente); nao pega troca entre dois campos do mesmo
// tamanho. Para esse caso ainda vale a revisao manual do VERSAO_CONTRATO.

interface

function fReformaCalculaAssinatura: Cardinal;

implementation

uses
  System.SysUtils,
  System.Rtti,
  System.TypInfo,
  Reforma.Contrato.Host,
  Reforma.Contrato.Gravacao,
  Reforma.Contrato.Convert;

// FNV-1a: deterministico e sem dependencia de API de hash do RTL (evita duvida de
// qual overload do System.Hash existe em cada versao do Delphi). Cardinal faz as
// contas em 32 bits por wraparound proposital - por isso a checagem de overflow do
// projeto (ligada ou nao, {$Q+/-} e opcao de projeto, nao se pode supor) e desligada
// so dentro desta funcao e restaurada ao sair, sem depender do estado global.
{$IFOPT Q+}{$DEFINE REFORMA_ASSINATURA_RESTAURA_Q}{$OVERFLOWCHECKS OFF}{$ENDIF}
function fFNV1a(Const AstrTexto: String): Cardinal;
  Var
    intPos: Integer;
begin
  Result := 2166136261;

  For intPos := 1 To Length(AstrTexto) Do
  Begin
    Result := Result Xor Word(AstrTexto[intPos]);
    Result := Result * 16777619;
  End;
end;
{$IFDEF REFORMA_ASSINATURA_RESTAURA_Q}{$OVERFLOWCHECKS ON}{$UNDEF REFORMA_ASSINATURA_RESTAURA_Q}{$ENDIF}

function fDescricaoParametro(Const AParametro: TRttiParameter): String;
begin
  Result := '';

  If pfConst In AParametro.Flags Then
    Result := Result + 'const ';
  If pfVar In AParametro.Flags Then
    Result := Result + 'var ';
  If pfOut In AParametro.Flags Then
    Result := Result + 'out ';
  If pfArray In AParametro.Flags Then
    Result := Result + 'array ';

  If Assigned(AParametro.ParamType) Then
  Begin
    Result := Result + AParametro.ParamType.Name;

    // Tamanho do record: pega a maioria das mudancas de layout mesmo sem RTTI de campo.
    If AParametro.ParamType Is TRttiRecordType Then
      Result := Result + '#' + IntToStr(AParametro.ParamType.TypeSize);
  End
  Else
    Result := Result + '?';
end;

function fDescricaoMetodo(Const AMetodo: TRttiMethod): String;
  Var
    arrParametros: TArray<TRttiParameter>;
    intPos: Integer;
begin
  Result := AMetodo.Name + '(';
  arrParametros := AMetodo.GetParameters;

  For intPos := 0 To High(arrParametros) Do
  Begin
    If intPos > 0 Then
      Result := Result + ';';

    Result := Result + fDescricaoParametro(arrParametros[intPos]);
  End;

  Result := Result + ')';

  If AMetodo.MethodKind = mkFunction Then
    Result := Result + ':' + AMetodo.ReturnType.Name
  Else
    Result := Result + ':proc';

  Result := Result + '/' + IntToStr(Ord(AMetodo.CallingConvention));
end;

function fDescricaoInterface(Const AInfoTipo: PTypeInfo): String;
  Var
    ctxRtti: TRttiContext;
    tipInterface: TRttiInterfaceType;
    arrMetodos: TArray<TRttiMethod>;
    intPos: Integer;
begin
  ctxRtti := TRttiContext.Create;
  tipInterface := ctxRtti.GetType(AInfoTipo) As TRttiInterfaceType;
  arrMetodos := tipInterface.GetMethods;

  Result := tipInterface.Name + '{';

  For intPos := 0 To High(arrMetodos) Do
    Result := Result + fDescricaoMetodo(arrMetodos[intPos]) + '|';

  Result := Result + '}';
end;

// Exports nao tem RTTI: os do contrato que mudaram de assinatura ou ficaram obrigatorios entram aqui como texto, para
// a assinatura acompanhar a mudanca mesmo sem o bump do VERSAO_CONTRATO.
const
  EXPORTS_CONTRATO = 'fReformaAbaVisivel(const Integer):Boolean/stdcall|';

function fReformaCalculaAssinatura: Cardinal;
  Var
    strTexto: String;
begin
  // Toda interface do contrato que atravessa a fronteira exe/DLL entra aqui. Interface nova no contrato:
  // acrescentar a linha correspondente.
  strTexto := fDescricaoInterface(TypeInfo(IReformaConsulta)) +
              fDescricaoInterface(TypeInfo(IReformaBancoHost)) +
              fDescricaoInterface(TypeInfo(IDadosProduto)) +
              fDescricaoInterface(TypeInfo(ICalculoCustoHost)) +
              fDescricaoInterface(TypeInfo(ICalculoMargemHost)) +
              fDescricaoInterface(TypeInfo(IReformaHost)) +
              fDescricaoInterface(TypeInfo(IReformaTransacao)) +
              fDescricaoInterface(TypeInfo(IReformaGravacao)) +
              fDescricaoInterface(TypeInfo(IReformaProgresso)) +
              fDescricaoInterface(TypeInfo(IReformaTarefa)) +
              fDescricaoInterface(TypeInfo(IReformaConvertHost)) +
              fDescricaoInterface(TypeInfo(IReformaCalculoConvert)) +
              EXPORTS_CONTRATO;

  Result := fFNV1a(strTexto);
end;

end.
