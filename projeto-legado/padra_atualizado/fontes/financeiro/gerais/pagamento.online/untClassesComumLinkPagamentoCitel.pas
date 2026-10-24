unit untClassesComumLinkPagamentoCitel;

interface

uses Classes ;

type
  TInfoCadcar = record
    CodCar: String ;
    DesCar: String ;
    TipTax: String ;
    PerDes: Double ;
    Period: Integer ;
    Excdia: Integer ;
  end;

  TGerarLinkPagamentoResposta = class
  private
    FstrDescricao: String;
    FstrIdLink: String;
    FstrNsu: String;
    FfltCodigoRetorno: Extended;
    FstrUrl: String;
  public
    property Descricao: String read FstrDescricao write FstrDescricao;
    property IdLink: String read FstrIdLink write FstrIdLink;
    property Nsu: String read FstrNsu write FstrNsu;
    property CodigoRetorno: Extended read FfltCodigoRetorno write FfltCodigoRetorno;
    property Url: String read FstrUrl write FstrUrl;
  end;

  TinfoCadCliLinkPagamentoCitel = class
  private
    FstrCLI_CODCLI: String ;
    FstrCLI_NOMCLI: String ;
    FstrCLI_EMAIL_: String ;
    FstrCLI_FONE01: String ;
    FstrCLI_CELULA: String ;
    FstrCLI_C_G_C_: String ;
    FstrCLI_ENDERE: String ;
    FstrCLI_ENDNUM: String ;
    FstrCLI_BAIRRO: String ;
    FstrCLI_C_E_P_: String ;
    FstrCID_NOMCID: String ;
    FstrCID_ESTADO: String ;
    FstrCID_PAIS__: String ;
  public
    property CLI_CODCLI: String read FstrCLI_CODCLI write FstrCLI_CODCLI ;
    property CLI_NOMCLI: String read FstrCLI_NOMCLI write FstrCLI_NOMCLI ;
    property CLI_EMAIL_: String read FstrCLI_EMAIL_ write FstrCLI_EMAIL_ ;
    property CLI_FONE01: String read FstrCLI_FONE01 write FstrCLI_FONE01 ;
    property CLI_CELULA: String read FstrCLI_CELULA write FstrCLI_CELULA ;
    property CLI_C_G_C_: String read FstrCLI_C_G_C_ write FstrCLI_C_G_C_ ;
    property CLI_ENDERE: String read FstrCLI_ENDERE write FstrCLI_ENDERE ;
    property CLI_ENDNUM: String read FstrCLI_ENDNUM write FstrCLI_ENDNUM ;
    property CLI_BAIRRO: String read FstrCLI_BAIRRO write FstrCLI_BAIRRO ;
    property CLI_C_E_P_: String read FstrCLI_C_E_P_ write FstrCLI_C_E_P_ ;
    property CID_NOMCID: String read FstrCID_NOMCID write FstrCID_NOMCID ;
    property CID_ESTADO: String read FstrCID_ESTADO write FstrCID_ESTADO ;
    property CID_PAIS__: String read FstrCID_PAIS__ write FstrCID_PAIS__ ;
  end ;

  TConsultaLinkPagamentoResposta = class
  private
    FstrAcquirer_id: String;
    FstrAcquirer_name: String;
    FstrAmount: String;
    FstrAuthorization_number: String;
    FstrAuthorizer_code: String;
    FstrAuthorizer_date: String;
    FstrAuthorizer_id: String;
    FstrAuthorizer_merchant_id: String;
    FstrAuthorizer_message: String;
    FstrCustomer_receipt: String;
    FstrEsitef_usn: String;
    FstrHost_usn: String;
    FstrIssuer: String;
    FstrMerchant_receipt: String;
    FstrMerchant_usn: String;
    Fstrid_link: String;
    FstrOrder_id: String;
    FstrPayment_date: String;
    FstrPayment_type: String;
    FstrSitef_usn: String;
    FstrStatus: String;
    FstrInstallments : String;
    FstrBrand: String;
    FstrInfoAdicional: String;
  public
    property acquirer_id: String read FstrAcquirer_id write FstrAcquirer_id;
    property acquirer_name: String read FstrAcquirer_name write FstrAcquirer_name;
    property amount: String read FstrAmount write FstrAmount;
    property authorization_number: String read FstrAuthorization_number write FstrAuthorization_number;
    property authorizer_code: String read FstrAuthorizer_code write FstrAuthorizer_code;
    property authorizer_date: String read FstrAuthorizer_date write FstrAuthorizer_date;
    property authorizer_id: String read FstrAuthorizer_id write FstrAuthorizer_id;
    property authorizer_merchant_id: String read FstrAuthorizer_merchant_id write FstrAuthorizer_merchant_id;
    property authorizer_message: String read FstrAuthorizer_message write FstrAuthorizer_message;
    property customer_receipt: String read FstrCustomer_receipt write FstrCustomer_receipt;
    property esitef_usn: String read FstrEsitef_usn write FstrEsitef_usn;
    property host_usn: String read FstrHost_usn write FstrHost_usn;
    property issuer: String read FstrIssuer write FstrIssuer;
    property merchant_receipt: String read FstrMerchant_receipt write FstrMerchant_receipt;
    property merchant_usn: String read FstrMerchant_usn write FstrMerchant_usn;
    property id_link: String read Fstrid_link write Fstrid_link;
    property order_id: String read FstrOrder_id write FstrOrder_id;
    property payment_date: String read FstrPayment_date write FstrPayment_date;
    property payment_type: String read FstrPayment_type write FstrPayment_type;
    property sitef_usn: String read FstrSitef_usn write FstrSitef_usn;
    property status: String read FstrStatus write FstrStatus;
    property installments: String read FstrInstallments write FstrInstallments;
    property brand: String read FstrBrand write FstrBrand;
    property infoAdicional: String read FstrInfoAdicional write FstrInfoAdicional;
  end ;

  TLinkPagamentoCitelFornecedores = class
  public
    class function fEhLinkPagamentoCitel(const AstrFornecedor: String): Boolean ;
    class function fParamSqlLinkPagamentoCitel: String ;
    class function fDescricao: String ;
  end ;

  TLinkPagamentoCitelHistoricoCartao = class
  public
    class function fHist01(AResposta: TConsultaLinkPagamentoResposta): String ;
    class function fHist02(AResposta: TConsultaLinkPagamentoResposta): String ;
  end;

  TLinkPagamentoCitelNormalizaTipo = class
  public
    class function fTipo(const AstrTipo: String): String ;
    class function fTipoAbreviado(const AstrTipo: String): String ;
  end;

  TlinkPagamentoCitelBandeiras = class
  public
    class procedure pPreencheCombo(AComboItens: TStrings) ;
  end ;

  TlinkPagamentoCitelAssociaCartao = class
  public
    class function fRetornaCodigoCartao(const AintParcela: Integer;
                                        const AstrBandeira,
                                              AstrTipo,
                                              AstrCodEmp,
                                              AstrCodCarDefault,
                                              AstrDesCarDefault,
                                              AstrTipTaxDefault: String;
                                        const AfltPerDesDefault: Double;
                                        const AintPeriodDefault,
                                              AintExcdiaDefault: Integer): TInfoCadcar ;
  end;

  TLinkPagamentoCitelCfg = class
  public
    class function fLinkPagamentoCitelLigado: Boolean ;
  end ;

implementation

uses untInterfaceLinkPagamentoCitel, StrUtils, SysUtils,
     untFactoryLinkPagamentoCitel, Data.DB, Uni
{$IFDEF LINUX}
  ,{$I '..\..\..\core\services.core.uses.inc'}
{$ELSE}
  ,untFuncoesSimples
{$ENDIF}
 ;

{ TLinkPagamentoCitelFornecedores }

class function TLinkPagamentoCitelFornecedores.fDescricao: String;
begin
  result := LinkPagamentoCitelDescricaoFornecedores[fFornecedorLinkPagamentoCitel] ;
end;

class function TLinkPagamentoCitelFornecedores.fEhLinkPagamentoCitel(
  const AstrFornecedor: String): Boolean;
begin
  Result := MatchStr(AstrFornecedor, LinkPagamentoCitelFornecedores) ;
end;

class function TLinkPagamentoCitelFornecedores.fParamSqlLinkPagamentoCitel: String;
var
  LItem: TLinkPagamentoCitel ;
begin
  Result := '' ;
  for LItem := Low(TLinkPagamentoCitel) to High(TLinkPagamentoCitel) do
  begin
    Result := Result + IfThen(Trim(Result) = '', '', ',' ) + QuotedStr(LinkPagamentoCitelFornecedores[LItem]) ;
  end ;
end;

{ TLinkPagamentoCitelCfg }

class function TLinkPagamentoCitelCfg.fLinkPagamentoCitelLigado: Boolean;
begin
  Result := MatchStr(fCfgSis('LINKPG', varString), LinkLinkPagamentoCitelCfg) ;
end;

{ TLinkPagamentoCitelHistoricoCartao }

class function TLinkPagamentoCitelHistoricoCartao.fHist01(
  AResposta: TConsultaLinkPagamentoResposta): String;
var
  LstrLink: String ;
begin
  Result := 'INTEGRAÇÃO: ' + UpperCase(TLinkPagamentoCitelFornecedores.fDescricao) ;
  LstrLink := fCfgSis('LINKPG', varString) ;
  if MatchStr(LstrLink, ['3', '5', '7']) then
    Result := 'BANDEIRA: ' + UpperCase(AResposta.brand) + ' TIPO: ' + TLinkPagamentoCitelNormalizaTipo.fTipo(AResposta.payment_type) ;
end;

class function TLinkPagamentoCitelHistoricoCartao.fHist02(
  AResposta: TConsultaLinkPagamentoResposta): String;
var
  LstrLink: String ;
begin
  Result := '' ;
  LstrLink := fCfgSis('LINKPG', varString) ;
  if MatchStr(LstrLink, ['3', '5', '7']) then
    Result := UpperCase(AResposta.infoAdicional) ;
end;

{ TLinkPagamentoCitelNormalizaTipo }

class function TLinkPagamentoCitelNormalizaTipo.fTipo(
  const AstrTipo: String): String;
var
  LobjTipo: ILinkPagamentoCitelNormalizaTipo ;
begin
  LobjTipo := fGetLinkPagamentoCitelNormalizaTipo ;
  if Assigned(LobjTipo) then
    Result := LobjTipo.fTipo(AstrTipo)
  else
    Result := AstrTipo ;
end;

class function TLinkPagamentoCitelNormalizaTipo.fTipoAbreviado(
  const AstrTipo: String): String;
var
  LobjTipo: ILinkPagamentoCitelNormalizaTipo ;
begin
  LobjTipo := fGetLinkPagamentoCitelNormalizaTipo ;
  if Assigned(LobjTipo) then
    Result := LobjTipo.fTipoAbreviado(AstrTipo)
  else
    Result := AstrTipo ;
end;

{ TlinkPagamentoCitelAssociaCartao }

class function TlinkPagamentoCitelAssociaCartao.fRetornaCodigoCartao(const AintParcela: Integer;
                                                                     const AstrBandeira,
                                                                           AstrTipo,
                                                                           AstrCodEmp,
                                                                           AstrCodCarDefault,
                                                                           AstrDesCarDefault,
                                                                           AstrTipTaxDefault: String;
                                                                     const AfltPerDesDefault: Double;
                                                                     const AintPeriodDefault,
                                                                           AintExcdiaDefault: Integer): TInfoCadcar;
var
  LstrTipoAbreviado: String ;
  LstrLink: String ;
  LqryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} ;
begin
  Result.CodCar := AstrCodCarDefault ;
  Result.DesCar := AstrDesCarDefault ;
  Result.TipTax := AstrTipTaxDefault ;
  Result.PerDes := AfltPerDesDefault ;
  Result.Period := AintPeriodDefault ;
  Result.Excdia := AintExcdiaDefault ;

  LstrLink := fCfgSis('LINKPG', varString) ;
  if MatchStr(LstrLink, ['3', '5']) then
  begin
    if not fCampoExiste('CADCAR', 'CAR_CIEBAN') then
      exit ;

    LstrTipoAbreviado := TLinkPagamentoCitelNormalizaTipo.fTipoAbreviado(AstrTipo) ;
    LqryConsulta := fCriaQuery ;
    try
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add('SELECT CAR_CODCAR, CAR_DESCAR, CAR_TIPTAX, CAR_PERDES, CAR_PERIOD, CAR_EXCDIA  ');
      LqryConsulta.SQL.Add('  FROM CADCAR ');
      LqryConsulta.SQL.Add(' WHERE CAR_STATUS = "S" AND ' + AintParcela.ToString + ' ');
      LqryConsulta.SQL.Add(' BETWEEN CAR_SUGPAR AND CAR_MAXPAR ');
      LqryConsulta.SQL.Add(' AND CAR_CODEMP = :CODEMP ');
      LqryConsulta.SQL.Add(' AND CAR_TIPCAR = :TIPCAR ');
      LqryConsulta.SQL.Add(' AND TRIM(CAR_CIEBAN) = :CIEBAN ');
      LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
      LqryConsulta.ParamByName('TIPCAR').AsString := LstrTipoAbreviado ;
      LqryConsulta.ParamByName('CIEBAN').AsString := Trim(UpperCase(AstrBandeira)) ;
      LqryConsulta.Open ;
      if LqryConsulta.IsEmpty then
      begin
        LqryConsulta.Close ;
        LqryConsulta.SQL.Clear ;
        LqryConsulta.SQL.Add('SELECT CAR_CODCAR, CAR_DESCAR, CAR_TIPTAX, CAR_PERDES, CAR_PERIOD, CAR_EXCDIA ');
        LqryConsulta.SQL.Add('  FROM CADCAR ');
        LqryConsulta.SQL.Add(' WHERE CAR_STATUS = "S" AND ' + AintParcela.ToString + ' ');
        LqryConsulta.SQL.Add(' BETWEEN CAR_SUGPAR AND CAR_MAXPAR ');
        LqryConsulta.SQL.Add(' AND CAR_CODEMP IS NULL ');
        LqryConsulta.SQL.Add(' AND CAR_TIPCAR = :TIPCAR ');
        LqryConsulta.SQL.Add(' AND TRIM(CAR_CIEBAN) = :CIEBAN ');
        LqryConsulta.ParamByName('TIPCAR').AsString := LstrTipoAbreviado ;
        LqryConsulta.ParamByName('CIEBAN').AsString := Trim(UpperCase(AstrBandeira)) ;
        LqryConsulta.Open ;
        if LqryConsulta.IsEmpty then
          exit ;

      end;
      Result.CodCar := LqryConsulta.FieldByName('CAR_CODCAR').AsString ;
      Result.DesCar := LqryConsulta.FieldByName('CAR_DESCAR').AsString ;
      Result.TipTax := LqryConsulta.FieldByName('CAR_TIPTAX').AsString ;
      Result.PerDes := LqryConsulta.FieldByName('CAR_PERDES').AsFloat ;
      Result.Period := LqryConsulta.FieldByName('CAR_PERIOD').AsInteger ;
      Result.Excdia := LqryConsulta.FieldByName('CAR_EXCDIA').AsInteger ;
    finally
      {$IFNDEF LINUX} FreeAndNil(LqryConsulta) ; {$ENDIF LINUX}
    end;
  end;
end;

{ TlinkPagamentoCitelBandeiras }

class procedure TlinkPagamentoCitelBandeiras.pPreencheCombo(
  AComboItens: TStrings);
var
  LobjBandeiras: ILinkPagamentoCitelBandeiras ;
begin
  LobjBandeiras := fGetLinkPagamentoCitelBandeiras ;
  if Assigned(LobjBandeiras) then
    LobjBandeiras.pPreencheCombo(AComboItens) ;
end;

end.
