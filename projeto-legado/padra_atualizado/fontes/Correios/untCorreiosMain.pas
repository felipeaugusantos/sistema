unit untCorreiosMain;

interface

uses
  System.SysUtils,
  Correios.Types;

  function fConsultaCep(const ACep: String; out ACidade, AEndereco, ABairro, AEstado: String): Boolean;
  function fBuscaCliente(const ANumCon, ANumCar: String; const AHomolo: Boolean): TServicosCliente;
  function fEnviaPreListaPostagem(const ANumDoc, AEspDoc, AEmpDoc, ACliDoc, ACodSer: String; const AQtdVol: Integer;
                                  out AJsonEnv, AJsonRet, AIdPost, ANumObj: String): Boolean;

implementation

uses
  untFuncoesSimples,
  untCorreiosLib,
  untSIGEPWebFuncoes;

function fConsultaCep(const ACep: String; out ACidade, AEndereco, ABairro, AEstado: String): Boolean;
var
  objCep: TCorreioCep;
begin
  Result := False;
  objCep := TCorreioCep.Create;

  try
    if fCfgCor('AUTOINCREM') = '' then
    begin
      pMensagemOk('Não existe contrato ativo com os Correios!' + sLineBreak +
                  'Para configurar, acesse o menu Cadastros > Auxiliares > Contratos - Correios');
      Exit;
    end;

    try
      objCep.Cep := ACep;

      Result := fExecutarModal(objCep.ConsultaCep, 'Consultando CEP no servidor dos Correios...', '');

      ACidade   := objCep.Cidade;
      AEndereco := objCep.Endereco;
      ABairro   := objCep.Bairro;
      AEstado   := objCep.Estado;
    except
      raise;
    end;
  finally
    FreeAndNil(objCep);
  end;
end;

function fBuscaCliente(const ANumCon, ANumCar: String; const AHomolo: Boolean): TServicosCliente;
var
  objServicos: TCorreiosServicos;
begin
  Result := nil;
  objServicos := TCorreiosServicos.Create;

  try
    if fCfgCor('AUTOINCREM') = '' then
    begin
      pMensagemOk('Não existe contrato ativo com os Correios!' + sLineBreak +
                  'Para configurar, acesse o menu Cadastros > Auxiliares > Contratos - Correios');
      Exit;
    end;

    try
      objServicos.NumContrato := ANumCon;
      objServicos.NumCartao   := ANumCar;
      objServicos.Homologacao := AHomolo;

      if fExecutarModal(objServicos.GetServicos, 'Comunicando com o servidor dos Correios...', '') then
        Result := objServicos.ServicosCliente;
    except
      raise;
    end;
  finally
    FreeAndNil(objServicos);
  end;
end;

function fEnviaPreListaPostagem(const ANumDoc, AEspDoc, AEmpDoc, ACliDoc, ACodSer: String;
  const AQtdVol: Integer; out AJsonEnv, AJsonRet, AIdPost, ANumObj: String): Boolean;
  var
    objPrePostagem: TCorreiosPrePostagem;
begin
  Result := False;
  objPrePostagem := TCorreiosPrePostagem.Create;

  try
    if fCfgCor('AUTOINCREM') = '' then
    begin
      pMensagemOk('Não existe contrato ativo com os Correios!' + sLineBreak +
                  'Para configurar, acesse o menu Cadastros > Auxiliares > Contratos - Correios');
      Exit;
    end;

    try
      objPrePostagem.NumeroDocumento  := ANumDoc;
      objPrePostagem.EspecieDocumento := AEspDoc;
      objPrePostagem.EmpresaDocumento := AEmpDoc;
      objPrePostagem.ClienteDocumento := ACliDoc;
      objPrePostagem.CodigoServico    := ACodSer;
      objPrePostagem.QtdVolumes       := AQtdVol;

      Result := objPrePostagem.EnviaPrePostagem;

      if not Result then
        Exit;

      AJsonEnv := objPrePostagem.JsonEnvio;
      AJsonRet := objPrePostagem.JsonRetorno;
      AIdPost  := objPrePostagem.IdPostagem;
      ANumObj  := objPrePostagem.NumeroObjeto;
    except
      raise;
    end;
  finally
    FreeAndNil(objPrePostagem);
  end;
end;

end.
