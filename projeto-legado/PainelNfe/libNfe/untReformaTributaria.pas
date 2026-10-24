{
 IBS (Imposto sobre Bens e Serviços) - Substitui o ICMS e o ISS, sendo gerenciado por um Comitê Gestor formado por representantes dos Estados e Municípios.
 CBS (Contribuição sobre Bens e Serviços) - Substitui o PIS e a Cofins, sendo de competência da União. O IPI também será zerado, exceto para produtos que fazem parte de regimes tributários favorecidos, como a Zona Franca de Manaus.
 IS (Imposto Seletivo) - De competência federal, esse tributo será aplicado a produtos e serviços considerados prejudiciais à saúde e ao meio ambiente, como cigarros e bebidas alcoólicas.
}

unit untReformaTributaria;

interface

uses Classes, Contnrs, SysUtils, StrUtils, untInterfaces, untUtil, untConstantesNFe, NfeApiWSBean;

Type
  TReformaTributaria = class
  private
    fonteDados: IFonteDados;
    dadosEmitente: TDadosEmitente;
    dadosGerais: TDadosGerais;
    lstItens: TObjectList;
    stlArquivo: TStringList;
    FNFCeOffLine: Boolean;

    function fValidaValor(const strCodigoCST: String): Boolean;
    function fRetornaVazio(const fltValor: Double; blnValidaValor: Boolean): Boolean;
    function fValor(const fltValor: Double; intPrecisao, intDecimais: Integer; blnValidaValor: Boolean=False): String;
    procedure pDFeProdutoServicoTributacaoImpostoSeletivo;
    procedure pDFeProdutoServicoTributacaoIbsCbs;
    procedure pDFeProdutoServicoTributacaoCbs;
    procedure pDFeProdutoServicoTributacaoIbs_Uf;
    procedure pDFeProdutoServicoTributacaoIbs_Mun;
    procedure pDFeProdutoServicoTributacaoIbsTributacaoRegular;
    procedure pDFeProdutoServicoTributacaoIbsCreditoPresumido;
    procedure pDFeProdutoServicoTributacaoCbsCreditoPresumido;
    procedure pDFeProdutoServicoTributacaoIbsCbsMonofasico;
    procedure pDFeProdutoServicoTransferenciaCredito;
    procedure pDFeProdutoServicoCreditoPresumidoIbsZfm;
    procedure pDFeProdutoServicoGrupoAjusteDeCompetencia;
    procedure pDFeProdutoServicoDFeReferenciado;
    procedure pDFeProdutoServicoGrupoEstornoDeCredito;
    procedure pDFeIbsCbsSelTotais;
  public
    procedure pReformaTributaria(AdadosEmitente: TDadosEmitente; AdadosGerais: TDadosGerais; AlstItens: TObjectList; var AstlArquivo: TStringList; ANFCeOffLine: Boolean = false);

    constructor Create(fonteDados: IFonteDados);
    destructor Destroy; override;
  end;

implementation

constructor TReformaTributaria.Create(fonteDados: IFonteDados);
begin
  Self.fonteDados := fonteDados;
end;

destructor TReformaTributaria.Destroy;
begin
  inherited;
end;

function TReformaTributaria.fValidaValor(const strCodigoCST: String): Boolean;
begin
  Result := False;

  If pos(strCodigoCST, '011_200_210_') > 0 Then
    Exit;

  Result := True;
end;

function TReformaTributaria.fRetornaVazio(const fltValor: Double; blnValidaValor: Boolean): Boolean;
begin
  Result := False;

  If not blnValidaValor Then
    Exit;

  If (fltValor > 0) Then
    Exit;

  Result := True;
end;

function TReformaTributaria.fValor(const fltValor: Double; intPrecisao, intDecimais: Integer; blnValidaValor: Boolean=False): String;
begin
  Result := '';

  If fRetornaVazio(fltValor, blnValidaValor) Then
    Exit;

  Result := FloatToStrF(fltValor, ffNumber, intPrecisao, intDecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoImpostoSeletivo;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
begin

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria) Then
      Continue;

    If not Assigned(item.ReformaTributaria.SEL) Then
      Continue;

    If (item.ReformaTributaria.SEL.fltValor > 0) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-PRODUTO-SELETIVO|';                                                      // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                                // 003 - Nr.Item
      strLinha := strLinha + item.ReformaTributaria.SEL.strCodigoCST + '|';                                // 004 - CST do Imposto Seletivo. Código Situação Tributária do Imposto Seletivo
      strLinha := strLinha + item.ReformaTributaria.SEL.strClassTrib + '|';                                // 005 - Código de classificação tributario do imposto seletivo
      strLinha := strLinha + fValor(item.ReformaTributaria.SEL.fltBase,     15, 2) + '|';                  // 006 - Valor da Base de Cálculo do Imposto Seletivo
      strLinha := strLinha + fValor(item.ReformaTributaria.SEL.fltAliquota, 07, 4) + '|';                  // 007 - Alíquota do Imposto Seletivo
      strLinha := strLinha + fValor(0, 07, 4) + '|';                                                       // 008 - Alíquota específica por unidade de medida apropriada
      strLinha := strLinha + item.strUnTrib + '|';                                                         // 009 - Unidade de Medida Tributável
      strLinha := strLinha + fValor(item.fltQtdTri, 15, 4) + '|';                                          // 010 - Quantidade Tributável
      strLinha := strLinha + fValor(item.ReformaTributaria.SEL.fltValor, 15, 2) + '|';                     // 011 - Valor do Imposto Seletivo

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoIbsCbs;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
begin

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria) Then
      Continue;

    If not Assigned(item.ReformaTributaria.IBS_CBS) Then
      Continue;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-IBSCBS|';                                                            // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                    // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                    // 003 - Nr.Item
    strLinha := strLinha + item.ReformaTributaria.IBS_CBS.strCodigoCST + '|';                                // 004 - Código de Situação Tributária do IBS e CBS: 000 | 010 | 011 | 200 | 210 | 220 | 221 | 400 | 410 | 510 | 550 | 620 | 800 | 810 | 820
    strLinha := strLinha + item.ReformaTributaria.IBS_CBS.strClassTrib + '|';                                // 005 - Código de Classificação Tributária do IBS e CBS
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_CBS.fltBase, 15, 2) + '|';                      // 006 - Valor Base de cálculo. Obrigatório quando informado NFE-PRODUTOIBSCBS-UF, NFE-PRODUTO-IBSCBS-MUN, NFEPRODUTO-IBSCBS-CBS
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_CBS.fltValIBS , 15, 2) + '|';                   // 007 - Valor do IBS. Obrigatório quando informado NFE-PRODUTOIBSCBS-UF, NFE-PRODUTO-IBSCBS-MUN, NFEPRODUTO-IBSCBS-CBS

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoCbs;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
  blnValidaValor: Boolean;
begin

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria) Then
      Continue;

    If not Assigned(item.ReformaTributaria.CBS) Then
      Continue;

    If not Assigned(item.ReformaTributaria.IBS_CBS) Then
      Continue;

    If pos(item.ReformaTributaria.IBS_CBS.strCodigoCST, CST_REFORMA_TRIBUTARIA_SEM_ALIQUOTA) > 0 Then
      Continue;

    blnValidaValor := fValidaValor(item.ReformaTributaria.IBS_CBS.strCodigoCST);

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-IBSCBS-CBS|';                                                     // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                 // 003 - Nr.Item
    strLinha := strLinha + fValor(item.ReformaTributaria.CBS.fltAliquota, 07, 4)       + '|';             // 004 - Alíquota vigente da CBS.
    strLinha := strLinha + fValor(item.ReformaTributaria.CBS.fltPerDif,   07, 4, True) + '|';             // 005 - Percentual do diferimento
    strLinha := strLinha + fValor(item.ReformaTributaria.CBS.fltValDif,   15, 2, True) + '|';             // 006 - Valor do Diferimento
    strLinha := strLinha + fValor(item.ReformaTributaria.CBS.fltTriDev,   15, 2, True) + '|';             // 007 - Valor do tributo devolvido (“cashback” de desconto na Fatura)
    strLinha := strLinha + fValor(item.ReformaTributaria.CBS.fltPerRed,   07, 4, blnValidaValor) + '|';   // 008 - Percentual da redução de alíquota - cClassTrib
    strLinha := strLinha + fValor(item.ReformaTributaria.CBS.fltAlqEfe,   07, 4, blnValidaValor) + '|';   // 009 - Alíquota efetiva, após aplicação da redução de alíquota, incluindo o gCompraGov/pRedutor, se houver. pAliqEfet = pIBSMun *(1 – pRedAliq)*(1 - tag: gCompraGov/pRedutor)
    strLinha := strLinha + fValor(item.ReformaTributaria.CBS.fltValor,    15, 2)       + '|';             // 010 - Valor do CBS

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoIbs_Uf;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
  blnValidaValor: Boolean;
begin

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria) Then
      Continue;

    If not Assigned(item.ReformaTributaria.IBS_UF) Then
      Continue;

    If not Assigned(item.ReformaTributaria.IBS_CBS) Then
      Continue;

    If pos(item.ReformaTributaria.IBS_CBS.strCodigoCST, CST_REFORMA_TRIBUTARIA_SEM_ALIQUOTA) > 0 Then
      Continue;

    blnValidaValor := fValidaValor(item.ReformaTributaria.IBS_CBS.strCodigoCST);

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-IBSCBS-UF|';                                                       // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                  // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                  // 003 - Nr.Item
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_UF.fltAliquota, 07, 4)       + '|';           // 004 - Alíquota vigente do IBS da UF
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_UF.fltPerDif,   07, 4, True) + '|';           // 005 - Percentual do diferimento
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_UF.fltValDif,   15, 2, True) + '|';           // 006 - Valor do Diferimento
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_UF.fltTriDev,   15, 2, True) + '|';           // 007 - Valor do tributo devolvido (“cashback” de desconto na Fatura)
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_UF.fltPerRed,   07, 4, blnValidaValor) + '|'; // 008 - Percentual da redução de alíquota
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_UF.fltAlqEfe,   07, 4, blnValidaValor) + '|'; // 009 - Alíquota efetiva do IBS de competência das UF que será aplicada a Base de Cálculo. Alíquota efetiva, após aplicação da redução de alíquota, incluindo o gCompraGov/pRedutor, se houver. pAliqEfet = pIBSUF*(1 – pRedAliq)*(1 - tag: gCompraGov/pRedutor)
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_UF.fltValor,    15, 2)       + '|';           // 010 - Valor do IBS de competência da UF

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoIbs_Mun;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
  blnValidaValor: Boolean;
begin

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria) Then
      Continue;

    If not Assigned(item.ReformaTributaria.IBS_MUN) Then
      Continue;

    If not Assigned(item.ReformaTributaria.IBS_CBS) Then
      Continue;

    If pos(item.ReformaTributaria.IBS_CBS.strCodigoCST, CST_REFORMA_TRIBUTARIA_SEM_ALIQUOTA) > 0 Then
      Continue;

    blnValidaValor := fValidaValor(item.ReformaTributaria.IBS_CBS.strCodigoCST);

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-IBSCBS-MUN|';                                                       // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                   // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                   // 003 - Nr.Item
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_MUN.fltAliquota, 07, 4)       + '|';           // 004 - Alíquota vigente do IBS do Município
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_MUN.fltPerDif,   07, 4, True) + '|';           // 005 - Percentual do diferimento
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_MUN.fltValDif,   15, 2, True) + '|';           // 006 - Valor do Diferimento
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_MUN.fltTriDev,   15, 2, True) + '|';           // 007 - Valor do tributo devolvido (“cashback” de desconto na Fatura)
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_MUN.fltPerRed,   07, 4, blnValidaValor) + '|'; // 008 - Percentual da redução de alíquota do cClassTrib
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_MUN.fltAlqEfe,   07, 4, blnValidaValor) + '|'; // 009 - Alíquota Efetiva do IBS de competência do Município que será aplicada a Base de Cálculo. Alíquota efetiva, após aplicação da redução de alíquota, incluindo o gCompraGov/pRedutor, se houver. pAliqEfet = pIBSMun *(1 – pRedAliq)*(1 - tag: gCompraGov/pRedutor)
    strLinha := strLinha + fValor(item.ReformaTributaria.IBS_MUN.fltValor,    15, 2)       + '|';           // 010 - Valor do IBS de competência do Município

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoIbsTributacaoRegular;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
begin

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria) Then
      Continue;

    If not Assigned(item.ReformaTributaria.TRIB_REGULAR) Then
      Continue;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-IBSCBS-TRIB-REGULAR|';                                          // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                               // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                               // 003 - Nr.Item
    strLinha := strLinha + Item.ReformaTributaria.TRIB_REGULAR.strCodigoCST + '|';                      // 004 - Código de Situação Tributária do IBS e CBS: 000 | 010 | 011 | 200 | 210 | 220 | 221 | 400 | 410 | 510 | 550 | 620 | 800 | 810 | 820
    strLinha := strLinha + Item.ReformaTributaria.TRIB_REGULAR.strClassTrib + '|';                      // 005 - Código de Classificação Tributária do IBS e CBS
    strLinha := strLinha + fValor(Item.ReformaTributaria.TRIB_REGULAR.fltIBS_UF_Alq,  07, 4) + '|';     // 006 - Valor da alíquota do IBS da UF
    strLinha := strLinha + fValor(Item.ReformaTributaria.TRIB_REGULAR.fltIBS_UF_Val,  15, 2) + '|';     // 007 - Valor do Tributo do IBS da UF
    strLinha := strLinha + fValor(Item.ReformaTributaria.TRIB_REGULAR.fltIBS_MUN_Alq, 07, 4) + '|';     // 008 - Valor da alíquota do IBS do Município
    strLinha := strLinha + fValor(Item.ReformaTributaria.TRIB_REGULAR.fltIBS_NUM_Val, 15, 2) + '|';     // 009 - Valor do Tributo do IBS do Município
    strLinha := strLinha + fValor(Item.ReformaTributaria.TRIB_REGULAR.fltCBS_Alq,     07, 4) + '|';     // 010 - Valor da alíquota da CBS
    strLinha := strLinha + fValor(Item.ReformaTributaria.TRIB_REGULAR.fltCBS_Val,     15, 2) + '|';     // 011 - Valor do Tributo da CBS

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoIbsCreditoPresumido;
Var
  //item: TDadosItem;
  intContador: Integer;
  strLinha: String;
begin
  Exit;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    //item := TDadosItem(lstItens[intContador]);

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-IBS-CRED-PRES|';                                                  // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                 // 003 - Nr.Item
    strLinha := strLinha + '00|';                                                                         // 004 - Código de Classificação do Crédito Presumido - Utilizar tabela cCredPres
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 005 - Percentual do Crédito Presumido
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 006 - Valor do Crédito Presumido (Obrigatório quando valor Crédito Presumido em condição suspensiva não foi preenchido)
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 007 - Valor do Crédito Presumido Condição Suspensiva. Preencher apenas para cCredPres com indicação de Condição Suspensiva. (Obrigatório quando valor Crédito Presumido não foi preenchido)

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoCbsCreditoPresumido;
Var
  //item: TDadosItem;
  intContador: Integer;
  strLinha: String;
begin
  Exit;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    //item := TDadosItem(lstItens[intContador]);

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-CBS-CRED-PRES|';                                                  // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                 // 003 - Nr.Item
    strLinha := strLinha + '00|';                                                                         // 004 - Código de Classificação do Crédito Presumido - Utilizar tabela cCredPres
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 005 - Percentual do Crédito Presumido
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 006 - Valor do Crédito Presumido (Obrigatório quando valor Crédito Presumido em condição suspensiva não foi preenchido)
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 007 - Valor do Crédito Presumido Condição Suspensiva. Preencher apenas para cCredPres com indicação de Condição Suspensiva. (Obrigatório quando valor Crédito Presumido não foi preenchido)

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTributacaoIbsCbsMonofasico;
Var
  //item: TDadosItem;
  intContador: Integer;
  strLinha: String;
begin
  Exit;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    //item := TDadosItem(lstItens[intContador]);

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-IBSCBS-MONO|';                                                    // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                 // 003 - Nr.Item
    strLinha := strLinha + fValor(0, 15, 4) + '|';                                                        // 004 - Quantidade tributada na monofasia. Informar a BC quantidade conforme unidade de medida estabelecida na legislação para o produto
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 005 - Alíquota ad rem do IBS
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 006 - Alíquota ad rem do CBS
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 007 - Valor do IBS monofásico. O valor do imposto é obtido pela multiplicação da alíquota ad rem pela quantidade do produto conforme unidade de medida estabelecida na legislação.
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 008 - Valor do CBS monofásico. O valor do imposto é obtido pela multiplicação da alíquota ad rem pela quantidade do produto conforme unidade de medida estabelecida na legislação.
    strLinha := strLinha + fValor(0, 15, 4) + '|';                                                        // 009 - Quantidade tributada sujeita à retenção na monofasica. Informar a BC sujeita a retenção em quantidade conforme unidade de medida estabelecida na egislação para o produto.
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 010 - Alíquota ad rem do imposto sujeito a retenção IBS
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 011 - Valor do IBS monofásico sujeito a retenção. Valor do IBS com retenção, a ser somado ao valor de IBS a ser recolhido.
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 012 - Alíquota ad rem do imposto sujeito a retenção CBS
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 013 - Valor do CBS com retenção, a ser somado ao valor de CBS a ser recolhido.
    strLinha := strLinha + fValor(0, 15, 4) + '|';                                                        // 014 - Quantidade tributada retida anteriormente. Informar a BC do IBS em quantidade conforme unidade de medida estabelecida na legislação
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 015 - Alíquota ad rem do IBS retido anteriormente. Alíquota ad rem do IBS, estabelecida na legislação para o produto.
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 016 - Valor do IBS retido anteriormente. Alíquota ad rem do IBS, estabelecida na legislação para o produto.
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 017 - Alíquota ad rem da CBS retida anteriormente. Alíquota ad rem da CBS, estabelecida na legislação para o produto
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 018 - Valor da CBS retida anteriormente. O valor da CBS é obtido pela multiplicação da alíquota ad rem pela quantidade do produto conforme unidade de medida estabelecida na legislação.
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 019 - Percentual do diferimento do imposto monofásico. A ser aplicado em vIBSMono.
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 020 - Valor do IBS monofásico diferido. A ser deduzido do valor do IBS
    strLinha := strLinha + fValor(0, 07, 4) + '|';                                                        // 021 - Percentual do diferimento do imposto monofásico. A ser aplicado em vCBSMono
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 022 - Valor do CBS Monofásico diferido. A ser deduzido do valor da CBS
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 023 - Total de IBS Monofásico.
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 024 - Total de CBS Monofásico.

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoTransferenciaCredito;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
  fltValIBS: Double;
  fltValCBS: Double;
begin

  If not Assigned(dadosGerais.ReformaTributariaCreditoDebito) Then
    Exit;

  fltValIBS := dadosGerais.ReformaTributariaCreditoDebito.fltValIBS;
  fltValCBS := dadosGerais.ReformaTributariaCreditoDebito.fltValCBS;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria.IBS_CBS) Then
      Continue;

    If not (item.ReformaTributaria.IBS_CBS.strCodigoCST = '800') Then
      Continue;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-TRANSF-CREDITO|';                                                 // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                 // 003 - Nr.Item
    strLinha := strLinha + fValor(fltValIBS, 15, 2) + '|';                                                // 004 - Valor do IBS a ser transferido
    strLinha := strLinha + fValor(fltValCBS, 15, 2) + '|';                                                // 005 - Valor da CBS a ser transferida

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoCreditoPresumidoIbsZfm;
Var
  //item: TDadosItem;
  intContador: Integer;
  strLinha: String;
begin
  Exit;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    //item := TDadosItem(lstItens[intContador]);

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-CRED-PRES-IBS-ZFM|';                                              // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                 // 003 - Nr.Item
    strLinha := strLinha + '0|';                                                                          // 004 - Tipo de classificação conforme percentuais definidos no art. 450, § 1º, da LC 214/25 para o cálculo do crédito presumido: 0 - Sem Crédito Presumido 1 - Bens de consumo final (55%) 2 - Bens de capital (75%) 3 - Bens intermediários (90,25%) 4 - Bens de informática e outros definidos em legislação (100%)
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                        // 005 - Valor do crédito presumido calculado sobre o saldo devedor apurado. É obrigatório para nota de crédito com tpNFCredito = 02 - Apropriação de crédito presumido de IBS sobre o saldo devedor na ZFM (art. 450, § 1º, LC 214/25) Vedado para documentos que não sejam nota de crédito com tpNFCredito = 02 - Apropriação de crédito presumido de IBS sobre o saldo devedor na ZFM (art. 450, § 1º, LC 214/25)

    stlArquivo.Add(strLinha);
  End;
end;

procedure TReformaTributaria.pDFeProdutoServicoGrupoAjusteDeCompetencia;
Var
  strLinha: String;
  strMesAno: String;
  fltValIBS: Double;
  fltValCBS: Double;
begin
  If not Assigned(dadosGerais.ReformaTributariaCreditoDebito) Then
    Exit;

  strMesAno := dadosGerais.ReformaTributariaCreditoDebito.strMesAno;
  fltValIBS := dadosGerais.ReformaTributariaCreditoDebito.fltValIBS;
  fltValCBS := dadosGerais.ReformaTributariaCreditoDebito.fltValCBS;

  If fEmptyStr(strMesAno) Then
    Exit;

  strLinha := '';
  strLinha := strLinha + 'NFE-PRODUTO-AJUSTE-COMPETENCIA|';                                             // 001 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
  strLinha := strLinha + '1|';                                                                          // 003 - Nr.Item
  strLinha := strLinha + fRetSomenteNumeros(strMesAno) + '|';                                           // 004 - Mês e Ano referência do período de apuração, informar período atual ou retroativo (MMAAAA)
  strLinha := strLinha + fValor(fltValIBS, 15, 2) + '|';                                                // 005 - Valor do IBS
  strLinha := strLinha + fValor(fltValCBS, 15, 2) + '|';                                                // 006 - Valor do CBS

  stlArquivo.Add(strLinha);
end;

procedure TReformaTributaria.pDFeProdutoServicoGrupoEstornoDeCredito;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
  fltValIBS: Double;
  fltValCBS: Double;
begin

  If not (dadosGerais.strFinalidade = '6') Then
    Exit;

  If not (dadosGerais.strTipoDebito = '07') Then
    Exit;

  If not Assigned(dadosGerais.ReformaTributariaCreditoDebito) Then
    Exit;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(item.ReformaTributaria) Then
      Continue;

    If not Assigned(item.ReformaTributaria.IBS_UF) Then
      Continue;

    If not Assigned(item.ReformaTributaria.CBS) Then
      Continue;

    fltValIBS := item.ReformaTributaria.IBS_UF.fltValor;
    fltValCBS := item.ReformaTributaria.CBS.fltValor;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-ESTORNO-CREDITO|';                                                // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc)  + '|';                                                // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1)  + '|';                                                // 003 - Nr.Item
    strLinha := strLinha + fValor(fltValIBS, 15, 2) + '|';                                                // 004 - Valor do IBS a ser estornado
    strLinha := strLinha + fValor(fltValCBS, 15, 2) + '|';                                                // 005 - Valor do CBS a ser estornada

    stlArquivo.Add(strLinha);
  End;

  If fEmptyStr(strLinha) Then
  Begin
    fltValIBS := dadosGerais.ReformaTributariaCreditoDebito.fltValIBS;
    fltValCBS := dadosGerais.ReformaTributariaCreditoDebito.fltValCBS;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-ESTORNO-CREDITO|';                                                // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + '1|';                                                                          // 003 - Nr.Item
    strLinha := strLinha + fValor(fltValIBS, 15, 2) + '|';                                                // 004 - Valor do IBS a ser estornado
    strLinha := strLinha + fValor(fltValCBS, 15, 2) + '|';                                                // 005 - Valor do CBS a ser estornada

    stlArquivo.Add(strLinha);
  End;

end;

procedure TReformaTributaria.pDFeProdutoServicoDFeReferenciado;
Var
  item: TDadosItem;
  intContador: Integer;
  strLinha: String;
  strPriChvRef: String;
  strPriCnpjRef: String;

  function fEnviaDFeProdutoServicoDFeReferenciado: Boolean;
  begin
    Result := False;

    If (dadosGerais.strFinalidade = '4') Then
    Begin
      If not dadosGerais.blnDesativaDfeReferenciado Then
        Result := True;

      Exit;
    End;

    If (dadosGerais.strFinalidade = '6') Then
    Begin
      Result := True;
      Exit;
    End;

    If (dadosGerais.strFinalidade = '5') And (dadosGerais.strTipoCredito = '06') Then
    Begin
      Result := True;
      Exit;
    End;
    {********************************************************************************}
    {* ESSE TRECHO FOI FEITO PARA ATENDER VERSÕES QUE NÃO TEM O CAMPO DE FINALIDADE *}
    {*****************************************************************************BZ*}
    If fEmptyStr(dadosGerais.strFinalidade) And (Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO) > 0) Then
    begin
      If not dadosGerais.blnDesativaDfeReferenciado Then
        Result := True;

      Exit;
    end;
  end;

  function fEnviaItemDoDocumentoReferenciado: Boolean;
  begin
    Result := True;

    If not (dadosGerais.strFinalidade = '6') Then
      Exit;

    If not (dadosGerais.strTipoDebito = '03') Then
      Exit;

    Result := False;
  end;

  procedure pPreparaChaveReferenciada;
  begin
    If not fEmptyStr(item.strChvRef) Then
      Exit;

    If Assigned(dadosGerais.arrChavesReferenciadas) And (intContador >= Low(dadosGerais.arrChavesReferenciadas)) And
                                                        (intContador <= High(dadosGerais.arrChavesReferenciadas)) then
    Begin
      item.strChvRef := dadosGerais.arrChavesReferenciadas[intContador].strChaveAcessoNfe ;
    End;

    If fEmptyStr(item.strChvRef) Then
    Begin
      If Assigned(dadosGerais.arrChaveNFRefExportacao) And (intContador >= Low(dadosGerais.arrChaveNFRefExportacao)) And
                                                           (intContador <= High(dadosGerais.arrChaveNFRefExportacao)) then
      Begin
        item.strChvRef := dadosGerais.arrChaveNFRefExportacao[intContador];
      End;
    End;

    If fEmptyStr(item.strChvRef) Then
    Begin
      If Assigned(dadosGerais.arrChavesReferenciadas) Then
        item.strChvRef := dadosGerais.arrChavesReferenciadas[0].strChaveAcessoNfe;
    End;

    If fEmptyStr(item.strChvRef) Then
    Begin
      If Assigned(dadosGerais.arrChaveNFRefExportacao) Then
        item.strChvRef := dadosGerais.arrChaveNFRefExportacao[0];
    End;

    If fEmptyStr(strPriCnpjRef) And (Length(item.strChvRef) >= 20) Then
      strPriCnpjRef := Copy(item.strChvRef, 7, 14);

    If fEmptyStr(strPriChvRef) And not fEmptyStr(item.strChvRef) Then
      strPriChvRef := item.strChvRef;

    If (not fEmptyStr(strPriCnpjRef)) And (not (Pos(strPriCnpjRef, item.strChvRef) > 0)) Then
      item.strChvRef := strPriChvRef;

    item.strIteRef := IntToStr(intContador + 1);
  end;

  procedure pPreparaItemReferenciado;
  begin
    If not fEmptyStr(item.strIteRef) Then
      Exit;

    item.strIteRef := IntToStr(intContador + 1);
  end;

begin

  If not fEnviaDFeProdutoServicoDFeReferenciado Then
    Exit;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    pPreparaChaveReferenciada;
    pPreparaItemReferenciado;

    If fEmptyStr(item.strChvRef) Then
      Continue;

    If fEmptyStr(item.strIteRef) Then
      Continue;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-DOC-FISCAL-ELETRONICO|';                                          // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                                 // 003 - Nr.Item
    strLinha := strLinha + item.strChvRef + '|';                                                          // 004 - Chave de acesso do DF-e referenciado.
    strLinha := strLinha + IIF(fEnviaItemDoDocumentoReferenciado, item.strIteRef, '') + '|';              // 005 - Número do item do documento referenciado, corresponde ao atributo “nItem” do elemento “det” do documento original.

    stlArquivo.Add(strLinha);
  End;

end;

procedure TReformaTributaria.pDFeIbsCbsSelTotais;
Var
  strLinha: String;

  function fValorTotalNFeComReforma: Double;
  begin
    // Com a CFG_REFCIS o vNF (017) sai sem CBS/IBS/IS e o vNFTot os devolve
    Result := dadosGerais.ReformaTributariaTotal.fltValorTotalNFe;

    If Not dadosGerais.blnReformaNoValorContabil Then
      Exit;

    Result := dadosGerais.fltTotGer;

    If Not dadosGerais.blnReformaSomadaNoVNF Then
      Result := Result + dadosGerais.fltValorReformaContabil;
  end;

  function fEnviaTotalEstornadoDeIBSeCBS: Boolean;
  begin
    Result := False;

    If not (dadosGerais.strFinalidade = '6') Then
      Exit;

    If not (dadosGerais.strTipoDebito = '07') Then
      Exit;

    If not Assigned(dadosGerais.ReformaTributariaCreditoDebito) Then
      Exit;

    Result := True;
  end;

begin

  If not Assigned(dadosGerais.ReformaTributariaTotal) Then
    Exit;

  strLinha := '';
  strLinha := strLinha + 'NFE-TOTAL-IBSCBSSEL|';                                                                 // 001 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                          // 002 - ID Referência
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 003 - Total do imposto seletivo
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalBase       , 15, 2) + '|';       // 004 - Valor total da BC do IBS e da CBS
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalDifIBS_UF  , 15, 2) + '|';       // 005 - Valor total do diferimento IBS da UF
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 006 - Valor total de devolução de tributos IBS da UF
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_UF     , 15, 2) + '|';       // 007 - Valor total do IBS da UF
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalDifIBS_MUN , 15, 2) + '|';       // 008 - Valor total do diferimento IBS do Município
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 009 - Valor total de devolução de tributos IBS do Município
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_MUN    , 15, 2) + '|';       // 010 - Valor total do IBS do Município
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalGrupoIBS   , 15, 2) + '|';       // 011 - Valor total do grupo IBS
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 012 - Valor total do crédito presumido IBS
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 013 - Valor total do crédito presumido em condição suspensiva IBS
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalDifCBS     , 15, 2) + '|';       // 014 - Valor total do diferimento CBS
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 015 - Valor total de devolução de tributos CBS
  strLinha := strLinha + fValor(dadosGerais.ReformaTributariaTotal.fltValorTotalCBS        , 15, 2) + '|';       // 016 - Valor total da CBS
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 017 - Valor total do crédito presumido CBS
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 018 - Valor total do crédito presumido em condição suspensiva CBS
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 019 - Total do IBS monofásico
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 020 - Total da CBS monofásica
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 021 - Total do IBS monofásico sujeito a retenção
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 022 - Total do CBS monofásico sujeito a retenção
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 023 - Total do IBS monofásico retido anteriormente
  strLinha := strLinha + fValor(0, 15, 2) + '|';                                                                 // 024 - Total da CBS monofásica retida anteriormente
  strLinha := strLinha + fValor(fValorTotalNFeComReforma                                   , 15, 2, True) + '|'; // 025 - Valor total da NF-e com IBS / CBS / IS

  If fEnviaTotalEstornadoDeIBSeCBS Then
  Begin
    strLinha := strLinha + fValor(dadosGerais.ReformaTributariaCreditoDebito.fltValIBS     , 15, 2, True) + '|'; // 026 - Valor total do IBS estornado
    strLinha := strLinha + fValor(dadosGerais.ReformaTributariaCreditoDebito.fltValCBS     , 15, 2, True) + '|'; // 027 - Valor total da CBS estornada
  End
  Else If FNFCeOffLine Then
  Begin
    strLinha := strLinha +  '|';                                                                                 // 026 - Valor total do IBS estornado
    strLinha := strLinha +  '|';                                                                                 // 027 - Valor total da CBS estornada
  End;

  stlArquivo.Add(strLinha);
end;

procedure TReformaTributaria.pReformaTributaria(AdadosEmitente: TDadosEmitente; AdadosGerais: TDadosGerais; AlstItens: TObjectList; var AstlArquivo: TStringList; ANFCeOffLine: Boolean = false);
begin

  If not Assigned(AdadosEmitente) Then
    Exit;

  If not Assigned(AdadosGerais) Then
    Exit;

  If not Assigned(AstlArquivo) Then
    Exit;

  If not Assigned(AlstItens) Then
    Exit;

  If not fGeraSchemaReformaTributaria(fonteDados, AdadosGerais.strCodEmp) Then
    Exit;

  dadosEmitente := AdadosEmitente;
  dadosGerais   := AdadosGerais;
  stlArquivo    := AstlArquivo;
  lstItens      := AlstItens;
  FNFCeOffLine  := ANFCeOffLine;

  pDFeProdutoServicoTributacaoImpostoSeletivo;
  pDFeProdutoServicoTributacaoIbsCbs;
  pDFeProdutoServicoTributacaoIbs_Uf;
  pDFeProdutoServicoTributacaoIbs_Mun;
  pDFeProdutoServicoTributacaoCbs;
  pDFeProdutoServicoTributacaoIbsTributacaoRegular;
  pDFeProdutoServicoTributacaoIbsCreditoPresumido;
  pDFeProdutoServicoTributacaoCbsCreditoPresumido;
  pDFeProdutoServicoTributacaoIbsCbsMonofasico;
  pDFeProdutoServicoTransferenciaCredito;
  pDFeProdutoServicoCreditoPresumidoIbsZfm;
  pDFeProdutoServicoGrupoAjusteDeCompetencia;
  pDFeProdutoServicoGrupoEstornoDeCredito;
  pDFeProdutoServicoDFeReferenciado;
  pDFeIbsCbsSelTotais;

  AstlArquivo := stlArquivo;
end;

end.
