unit Yapay.Api.Inativar.Cobranca.V3;

interface

uses
  System.Variants,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  Yapay.Api.Helpers,
  Yapay.Api.Resources,
  Yapay.Api.Core,
  Yapay.Api.Cobranca.Base,
  Yapay.Api.Ambiente,
  Yapay.Api.Consulta.Cobranca.V3;

type
{$M+}
  TYapayApiTabelaParametrosInativarCobrancaV3 = class(TYapayApiTabelaParametrosBase)
  strict private
    Fid: int64;
  published
    property Id: int64 read Fid write Fid;
  end;

  TYapayApiRespostaInativarCobrancaV3ComSucesso = class(TYapayApiRespostaBaseComSucesso);

  TYapayApiInativarCobrancaV3 = class(TYapayApiCobrancaBase<TYapayApiTabelaParametrosInativarCobrancaV3,TYapayApiRespostaInativarCobrancaV3ComSucesso>)
  strict protected
    function GetEndereco: string; override;
  public
//    function Enviar: Boolean; override; //INATIVAR TRANSAÇÕES
    constructor Create; override;
  end;
{$M-}

implementation

{ TYapayApiInativarCobrancaV3 }

constructor TYapayApiInativarCobrancaV3.Create;
begin
  inherited;
  FMetodo := TYapayApiCoreMetodo.Post;
end;

function TYapayApiInativarCobrancaV3.GetEndereco: string;
begin
  case Conexao.Ambiente of
    Sandbox: result := rsYAPAY_API_INATIVAR_COBRANCA_V3_ENDERECO_SANDBOX;
    Producao: result := rsYAPAY_API_INATIVAR_COBRANCA_V3_ENDERECO_PRODUCAO;
    else
    begin
      result := NullAsStringValue;
    end;
  end;
  Result := StringReplace(result, ':id', TabelaParametros.Id.ToString, [rfReplaceAll, rfIgnoreCase]);
end;

//INATIVAR TRANSAÇÕES
//function TYapayApiInativarCobrancaV3.Enviar: Boolean;
//var
//  objConsultaCobranca: TYapayApiConsultaCobrancaV3;
//  objResposta: TYapayApiRespostaConsultaCobrancaV3ComSucesso;
//  objTransacao: TYapayApiRespostaConsultaCobrancaV3ComSucesso.TCobrancaTransacao;
//
//const
//  strCANCELAMENTO_PELA_LOJA = '6';
//
//begin
//  if inherited Enviar then
//  begin
//    objConsultaCobranca := TYapayApiConsultaCobrancaV3.Create;
//    try
//    objConsultaCobranca.TabelaParametros.Id := Self.TabelaParametros.Id;
//    objConsultaCobranca.Conexao := Self.Conexao;
//    Result := objConsultaCobranca.Enviar;
//    objResposta := TYapayApiRespostaConsultaCobrancaV3ComSucesso(objConsultaCobranca.Resposta);
//    if objResposta.Transactions.Count = 0 then
//      exit(True);
//
//    for objTransacao in objResposta.Transactions do
//    begin
//      FCore := TYapayApiCore.Create;
//      try
//        FCore.Metodo := TYapayApiCoreMetodo.Patch;
//        FCore.Debug := Self.Conexao.Debug;
//        FCore.Log := Self.Conexao.Log;
//
//        if Conexao.Ambiente = Sandbox then
//          FCore.BaseURL := 'https://api.intermediador.sandbox.yapay.com.br/api/v3/transactions/cancel'
//        else if Conexao.Ambiente = Producao then
//          FCore.BaseURL := 'https://api.intermediador.yapay.com.br/api/v3/transactions/cancel';
//
//        FCore.Access_Token := String.Empty; //TabelaParametros.Access_token;
//
//        FCore.JSONEnvio :=
//          '{' + sLineBreak +
//          '"access_token":"' + TabelaParametros.Access_token +'",' + sLineBreak +
//          '"transaction_id": ' + objTransacao.Id.ToString +',' + sLineBreak +
//          '"reason_cancellation_id": "' + strCANCELAMENTO_PELA_LOJA + '"' + sLineBreak +
//          '}';
//
//        FCore.Execute; <<<<aki
////        JSONEnvio := FCore.JSONEnvio;
////        JSONRetorno := FCore.JSONRetorno;
////        Result := ProcessaRetorno;
//      finally
//        if Assigned(FCore) then
//          FreeAndNil(FCore);
//      end;
//    end;
//    finally
//      if Assigned(objConsultaCobranca) then
//        FreeAndNil(objConsultaCobranca);
//    end;
//  end;
//end;


end.
