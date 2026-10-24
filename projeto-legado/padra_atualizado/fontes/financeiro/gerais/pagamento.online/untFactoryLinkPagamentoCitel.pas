unit untFactoryLinkPagamentoCitel;

interface

uses untInterfaceLinkPagamentoCitel ;

  function fCriarLinkPagamentoCitel: ILinkPagamentoCitel;
  function fCriarLinkPagamentoCitelRepositorio: ILinkPagamentoCitelRepositorio;
  function fGetLinkPagamentoCitelFornecedor: ILinkPagamentoCitelFornecedor;
  function fGetLinkPagamentoCitelBandeiras: ILinkPagamentoCitelBandeiras;
  function fFornecedorLinkPagamentoCitel: TLinkPagamentoCitel;
  function fGetLinkPagamentoCitelNormalizaTipo: ILinkPagamentoCitelNormalizaTipo;

implementation

uses untImplementationLinkPagamentoCitelSiTef,
     untImplementationLinkPagamentoCitelCielo,
     untImplementationLinkPagamentoCitelCredPay,
     untImplementationLinkPagamentoCitelIpag,
     {$IFDEF LINUX}
     Services.Core.Connection.Manager, Services.Core.Settings
     {$ELSE }
     untFuncoesSimples
     {$ENDIF LINUX} ;

  function fFornecedorLinkPagamentoCitel: TLinkPagamentoCitel;
  var
    LintFornecedor: Integer ;
  begin
    LintFornecedor := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_LINKPG']) ;
    case LintFornecedor of
      2 : Result := pcSitef ;
      3 : Result := pcCielo ;
      5 : Result := pcCredPay ;
      7 : Result := pcIpag ;
    else
      Result := pcSitef ;
    end ;
  end;

  function fGetLinkPagamentoCitelNormalizaTipo: ILinkPagamentoCitelNormalizaTipo;
  var
    LOpcao: TLinkPagamentoCitel ;
  begin
    Result := Nil ;
    LOpcao := fFornecedorLinkPagamentoCitel ;
    case LOpcao of
      pcCielo: Result := TLinkPagamentoCitelNormalizaTipoCielo.New ;
      pcCredPay: Result := TLinkPagamentoCitelNormalizaTipoCredPay.New ;
      pcIpag: Result := TLinkPagamentoCitelNormalizaTipoIpag.New ;
    end ;
  end;

  function fCriarLinkPagamentoCitel: ILinkPagamentoCitel;
  var
    LOpcao: TLinkPagamentoCitel ;
  begin
    Result := Nil ;
    LOpcao := fFornecedorLinkPagamentoCitel ;
    case LOpcao of
      pcSitef: Result := TLinkPagamentoSitef.New ;
      pcCielo: Result := TLinkPagamentoCielo.New ;
      pcCredPay: Result := TLinkPagamentoCredPay.New ;
      pcIpag: Result := TLinkPagamentoIpag.New ;
    end ;
  end ;

  function fCriarLinkPagamentoCitelRepositorio: ILinkPagamentoCitelRepositorio;
  var
    LOpcao: TLinkPagamentoCitel ;
  begin
    Result := Nil ;
    LOpcao := fFornecedorLinkPagamentoCitel ;
    case LOpcao of
      pcSitef: Result := TLinkPagamentoCitelRepositorioSitef.New ;
      pcCielo: Result := TLinkPagamentoCitelRepositorioCielo.New ;
      pcCredPay: Result := TLinkPagamentoCitelRepositorioCredPay.New ;
      pcIpag: Result := TLinkPagamentoCitelRepositorioIpag.New ;
    end ;
  end ;

  function fGetLinkPagamentoCitelFornecedor: ILinkPagamentoCitelFornecedor;
  var
    LOpcao: TLinkPagamentoCitel ;
  begin
    Result := Nil ;
    LOpcao := fFornecedorLinkPagamentoCitel ;
    case LOpcao of
      pcSitef: Result := TLinkPagamentoCitelFornecedorSitef.New ;
      pcCielo: Result := TLinkPagamentoCitelFornecedorCielo.New ;
      pcCredPay: Result := TLinkPagamentoCitelFornecedorCredPay.New ;
      pcIpag: Result := TLinkPagamentoCitelFornecedorIpag.New ;
    end ;
  end ;

  function fGetLinkPagamentoCitelBandeiras: ILinkPagamentoCitelBandeiras;
  var
    LOpcao: TLinkPagamentoCitel ;
  begin
    Result := Nil ;
    LOpcao := fFornecedorLinkPagamentoCitel ;
    case LOpcao of
      pcCielo: Result := TLinkPagamentoCitelBandeirasCielo.New ;
      pcCredPay: Result := TLinkPagamentoCitelBandeirasCredPay.New ;
      pcIpag: Result := TLinkPagamentoCitelBandeirasIpag.New ;
    end ;
  end ;

end.
