unit untFatCalcComissaoVendedor;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples, untFuncoes,
{$ENDIF}
  untFuncFatTypes, Uni, SysUtils, StrUtils;

Type
  TComissaoTabela = (tcoComVar, tcoComAta, tcoComDis);

Type
  TCalculoComissaoVendedor = class
    private
      FCodVen: String;
      FCodCli: String;
      FCliPer: String;
      FCodReg: String;
      FTabPre: String;
      FCodCnd: String;
      FConPag: String;
      FDevNota: Boolean;
      FDevEsp: Boolean;
      FGarantiaOuOutrasSaidasParaFornecedor: Boolean;
      FMarLuc: Double;
      FstrEspDoc: String;

      function fRetPerComCliente_Vendedor: Double;

      function fRetPerComRegiao(const item: TDadosFechamento;
                                strTipVendedor: String; blnRepresent: Boolean): Double;

      function fPerComVendedor(strCodVen: String): Double;
      function fRetPerComCndPgto: Double;
      function fDadosCliente(strCampo: String): String;
      function fRetPerSeqHierarquica(const item: TDadosFechamento; strTipVendedor: String; blnRepresent: Boolean = False): Double;
      function fRetDesSeqCom(intSeq: Integer): String;
      function fRetPerComFor(strCodFor, strCodOpe : String): Double;
      function fRetComissaoFaixaDescontoDepartamento(const item: TDadosFechamento): Double;
      function fRetornaComissaoTabela(strCodIte, strCodEmp, strTabPre: string; TipCom: TComissaoTabela): Double;
      function fRetornaComissaoVendedorProduto(strCodIte, strTabPre, strTipVen: string): Double;
      function fComissaoPorFaixaDeMargemPorVendedor(strOpcCom : String): Boolean;
      function fRetPerComFaixaTabPre(const item: TDadosFechamento): Double;
      function fRetPerComHierarquiaFaixaDesconto(const item: TDadosFechamento; strTipVendedor: String): Double;
      function fTemPerComHierarquiaFaixaDescontoGeral(strCodIte: String; fltPerDes: Double; var fltPerCom: Double; strTabPre: String): Boolean;
      function fTemPerComHierarquiaFaixaDescontoGerente(strCodGer, strCodIte: String; fltPerDes: Double; var fltPerCom: Double; strTabPre: String): Boolean;
      function fTemPerComHierarquiaFaixaDescontoVendedor(strCodVen, strCodIte: String; fltPerDes: Double; var fltPerCom: Double; strTabPre: String): Boolean;
      function fTemPerComHierarquiaFaixaDescontoCliente(strCodCli, strCodIte: String; fltPerDes: Double; var fltPerCom: Double; strTabPre: String): Boolean;
      function fTemPerComHierarquiaFaixaDescontoSubGerente(strCodSub, strCodIte: String; fltPerDes: Double; var fltPerCom: Double; strTabPre: String): Boolean;
      function fRetPerComHierarquiaFaixaDescTabPrecoLinhaGrupo(
        const item: TDadosFechamento): Double;
    Public
      constructor Create(strCodVen, strCodCli, strCliPer, strCodReg, strTabPre, strCodCnd, strConPag: String; blnDevNota: Boolean; blnDevEsp: Boolean = False; blnGarantiaOuOutrasSaidasParaFornecedor : Boolean = False; fltMarLuc : Double = 0; strEspDoc: String = '');

      function fRetornaComissaoPromocao(const item: TDadosFechamento; strTipVendedor: String): Double;
      function fUsaComissaoPromocao(const item: TDadosFechamento; strTipVendedor: String): Boolean;
      function fUtilizarPercentuaisDeComissaoDaPromocao(const item: TDadosFechamento; strTipVendedor: String): Boolean;
      function fRetPerComissao(const item: TDadosFechamento;
                               strTipVendedor: String;
                               blnRepresent: Boolean = False;
                               strOpcComiss: String = ''): Double; overload;
      function fRetPerComissao(const item: TDadosFechamento;
                               const strTipVendedor : String;
                               const blnRepresent: Boolean;
                               const strOpcComiss: String;
                               const strTabPre, strCodVen : String): Double; overload;
  End;

implementation

uses untConstantes, Data.DB, untTFaixaDescTabPrecoLinhaGrupo.Classes,
  untMargemMinima;

constructor TCalculoComissaoVendedor.Create(strCodVen, strCodCli, strCliPer, strCodReg, strTabPre, strCodCnd, strConPag: String; blnDevNota: Boolean; blnDevEsp: Boolean = False; blnGarantiaOuOutrasSaidasParaFornecedor : Boolean = False; fltMarLuc : Double = 0; strEspDoc: String = '');
begin
  FCodVen  := strCodVen;
  FCodCli  := strCodCli;
  FCliPer  := strCliPer;
  FCodReg  := strCodReg;
  FTabPre  := strTabPre;
  FCodCnd  := strCodCnd;
  FConPag  := strConPag;
  FDevNota := blnDevNota;
  FDevEsp  := blnDevEsp;
  FGarantiaOuOutrasSaidasParaFornecedor := blnGarantiaOuOutrasSaidasParaFornecedor;
  FMarLuc  := fltMarLuc;
  FstrEspDoc := strEspDoc;
end;

function TCalculoComissaoVendedor.fRetornaComissaoPromocao(const item: TDadosFechamento; strTipVendedor: String): Double;
begin
  If strTipVendedor = 'E' Then
    Result := item.fltProCAt
  Else If strTipVendedor = 'I' Then
    Result := item.fltProCva
  Else
    Result := item.fltProCdi
end;

function TCalculoComissaoVendedor.fUsaComissaoPromocao(const item: TDadosFechamento; strTipVendedor: String): Boolean;
begin
  Result := True;
      
  If fCfgSis('PROCOM', varBoolean) Then
  Begin
    Result := fRetornaComissaoPromocao(item, strTipVendedor) > 0;
  End;
end;

function TCalculoComissaoVendedor.fUtilizarPercentuaisDeComissaoDaPromocao(const item: TDadosFechamento; strTipVendedor: String): Boolean;
begin
  Result := (item.strPromoc = 'S') And (item.strComPro = 'P') And (fUsaComissaoPromocao(item, strTipVendedor));
end;

function TCalculoComissaoVendedor.fRetPerComissao(const item: TDadosFechamento; strTipVendedor: String; blnRepresent: Boolean = False; strOpcComiss: String = ''): Double;
  Var
    fltValLiq         : Double;
    fltPercentual     : Double;
    fltFator          : Double;
    qryGenTab         : TUniQuery;
    strOpcCom         : String;
    fltTotCus         : Double;
    strTipAtiCliente  : String;
    fltPrecoPraticado : double;
    fltComissao       : Double;
    fltCustoParaMargem : Double;
begin

  Result := 0.0;

  If fEmptyStr(strOpcComiss) Then
    strOpcCom := fCfgSis('OPCCOM')
  Else
    strOpcCom := strOpcComiss;

  If FDevNota And FDevEsp Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If FGarantiaOuOutrasSaidasParaFornecedor Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If (fCfgSis('PERMUT', varBoolean)) And (FCliPer = 'S') Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If (fCfgSis('USASER', varBoolean)) And (item.strCodIte = fCfgSis('ITESER')) Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If (fCfgSis('USASER', varBoolean)) And (item.strCodIte = fCfgSis('SERTER')) Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If (fCfgSis('FRECUP', varBoolean)) And (item.strCodIte = fCfgSis('ITEFRE')) Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If (item.strProEmb = 'S') Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If (Pos(FstrEspDoc, 'CR_CS_') > 0) Then
  Begin
    Result := 0.0;
    Exit;
  End;

  If (FDevNota) Then
  Begin
    If blnRepresent Then
      Result := item.fltCoDvRp
    Else
      Result := item.fltComDev;
    Exit;
  End;

  If fCfgSis('ALTPCO', VarBoolean) And (item.strAltPCo = 'S') Then
  Begin
    Result := item.fltPerCom;
    Exit;
  End;

  {*************************************************************}
  {* CASO SEJA COMISSÃO POR FAIXA DE DESCONTO POR DEPARTAMENTO *}
  {**********************************************************BZ*}
  If (strOpcCom = 'FD') Then
  Begin
    Result := fRetComissaoFaixaDescontoDepartamento(item);
    Exit;
  End;

  {*************************************************************}
  {* CASO SEJA PERCENTUAL POR CLIENTE/VENDEDOR (A VISTA/PRAZO) *}
  {**********************************************************JC*}
  If (strOpcCom = 'CV') Then
    Result := fRetPerComCliente_Vendedor

  {********************************************************************}
  {* CASO SEJA PERCENTUAL POR REGIAO/TINTA DE MAQUINA/DEMAIS PRODUTOS *}
  {*****************************************************************JC*}
  Else If (strOpcCom = 'R') Then
    Result := fRetPerComRegiao(item, strTipVendedor, blnRepresent)

  {*******************************************}
  {* CASO NÃO SEJA COMISSAO POR VENDEDOR OU  *}
  {* FORNECEDOR, USA COMISSÃO POR ITEM       *}
  {****************************************MV*}
  Else If (strOpcCom = 'V') Then
  Begin
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
      Result := fPerComVendedor(FCodVen);
  End

  {**************************************************************}
  {* CASO SEJA COMISSAO PROPORCIONAL AO LUCRO SOBRE MARGEM BRUTA*}
  {***********************************************************IV*}
  Else If (strOpcCom = 'L') Then
    Result := fRetPerComLucro( item.fltQtdIte,
                               item.fltUniOri,
                               item.fltTotCus * ( 1 + (IIF(fCfgSis('JURCUS', VarBoolean), item.fltTaxJur, 0) / 100) ),
                               item.fltTotIte - item.fltTaxEnt - item.fltDesEsp,
                               item.fltComInt )

  {****************************************************************}
  {* CASO SEJA COMISSAO PROPORCIONAL AO LUCRO SOBRE MARGEM LIQUIDA*}
  {*************************************************************DF*}
  Else If (strOpcCom = 'ML') Then Begin
    fltTotCus := fCalculaPrecoCustoRealVenda(item.fltUniOri,
                                             item.fltPreCus * ( 1 + (IIF(fCfgSis('JURCUS', VarBoolean), item.fltTaxJur, 0) / 100) ),
                                             item.fltOutVal,
                                             item.fltICMSai,
                                             item.fltImpFed,
                                             item.fltDesOpe,
                                             item.recDifalFCP.fltAlDifa ,
                                             IIF( ((item.fltValRet = 0) And (item.fltBasIcm <> 0)), item.recDifalFCP.fltPerFcp, 0) ) * item.fltQtdIte;

    Result := fRetPerComLucro( item.fltQtdIte,
                               item.fltUniOri,
                               fltTotCus,
                               item.fltTotIte - item.fltTaxEnt - item.fltDesEsp,
                               item.fltComInt,
                               item.fltTotCu2 )

  {*******************************************}
  {* CASO SEJA PERCENTUAL POR TABELA DE PREÇO*}
  {****************************************LU*}
  End Else If (strOpcCom = 'T') Then
  Begin

    {*******************************************}
    {* CASO O ITEM ESTEJA EM PROMOÇÃO, USA A   *}
    {* COMISSÃO CONFIGURADA NA PROMOÇÃO        *}
    {****************************************MV*}
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
    Begin
      If (fCfgSis('TABITE') = 'S') And (item.strTabPre <> '') Then
      Begin
        Case StrToInt(item.strTabPre) Of
          1: Result := fCfgSis('COMTP1', varDouble);
          2: Result := fCfgSis('COMTP2', varDouble);
          3: Result := fCfgSis('COMTP3', varDouble);
          4: Result := fCfgSis('COMTP4', varDouble);
          5: Result := fCfgSis('COMTP5', varDouble);
          6: Result := fCfgSis('COMTP6', varDouble);
          7: Result := fCfgSis('COMTP7', varDouble);
        End;
      End
      Else
      Begin
        Case StrToInt(FTabPre) Of
          1: Result := fCfgSis('COMTP1', varDouble);
          2: Result := fCfgSis('COMTP2', varDouble);
          3: Result := fCfgSis('COMTP3', varDouble);
          4: Result := fCfgSis('COMTP4', varDouble);
          5: Result := fCfgSis('COMTP5', varDouble);
          6: Result := fCfgSis('COMTP6', varDouble);
          7: Result := fCfgSis('COMTP7', varDouble);
        End;
      End;
    End;

  End
  Else If (strOpcCom = 'F') Then
    Result := item.fltComFor

  {********************************************************}
  {* SE FOR CONFIGURADO POR FAIXAS DE MARGEM POR VENDEDOR *}
  {*****************************************************MM*}
  Else If (strOpcCom = 'MV') Then
  Begin

    If item.fltQtdIte <> 0 Then
    Begin
      fltValLiq := item.fltUniTar - (item.fltTaxEnt / item.fltQtdIte) -
                                    (item.fltDesEsp / item.fltQtdIte);

      if (fCfgSis('PRPRMV') = 'PRECUS') then
        fltPrecoPraticado := item.fltPreCus
      else if (fCfgSis('PRPRMV') = 'PRECU2') then
        fltPrecoPraticado := item.fltPreCu2
      else
        fltPrecoPraticado := item.fltImpUlt;

      Result    := fRetPerComOpeMargem(fltPrecoPraticado, fltValLiq, FCodVen);
    End
    Else
      Result := 0;

  End

  Else If (fComissaoPorFaixaDeMargemPorVendedor(strOpcCom)) Then
  Begin

    If item.fltQtdIte <> 0 Then
    Begin
      fltValLiq := item.fltUniTar - (item.fltTaxEnt / item.fltQtdIte) -
                                    (item.fltDesEsp / item.fltQtdIte);

      if (fCfgSis('PRPRMV') = 'PRECUS') then
        fltPrecoPraticado := item.fltPreCus
      else if (fCfgSis('PRPRMV') = 'PRECU2') then
        fltPrecoPraticado := item.fltPreCu2
      else
        fltPrecoPraticado := item.fltImpUlt;

      Result    := fRetPerComOpeMargem(fltPrecoPraticado, fltValLiq, FCodVen, VS_strCodEmp);
    End
    Else
      Result := 0;

  End

  {************************************}
  {* SE FOR CONFIGURADO POR MARGEM    *}
  {*********************************AF*}
  Else If (strOpcCom = 'M') Then
  Begin
    If item.fltQtdIte <> 0 Then
    Begin
      If (TMargemMinima.UsaPrecoLiquido) Then
      Begin
        If (TMargemMinima.UsaPrecoMedio) Then
          fltCustoParaMargem := fFormataFloat(item.fltPreMed * item.fltQtdIte, 2) + item.fltOutVal
        Else
          fltCustoParaMargem := item.fltTotCus * ( 1 + (IIF(fCfgSis('JURCUS', VarBoolean), item.fltTaxJur, 0) / 100) ) + item.fltOutVal;

        Result := fRetPerComMargem(fCalculaPrecoVenda(2, fltCustoParaMargem,
                                                         item.fltTotIte - (item.fltTaxEnt) -
                                                                          (item.fltDesEsp),
                                                         0,
                                                         item.fltICMSai,
                                                         item.fltImpFed,
                                                         item.fltDesOpe,
                                                         0,
                                                         '',
                                                         '',
                                                         -1,
                                                         0,
                                                         False,
                                                         IIF( not fCfgSis('CLPVDI', varBoolean), item.recDifalFCP.fltAlDifa, 0),
                                                         IIF( not fCfgSis('CLPVDI', varBoolean) And (item.fltValRet = 0) And (item.fltBasIcm <> 0), item.recDifalFCP.fltPerFcp, 0)),
                                   '',
                                   IIF(fCfgSis('USACND',varBoolean),
                                       fRetConPagCodCnd(FCodCnd),
                                       FConPag))
      End
      Else
      Begin
        If (TMargemMinima.UsaPrecoMedio) Then
          fltCustoParaMargem := fFormataFloat(item.fltPreMed * item.fltQtdIte, 2)
        Else
          fltCustoParaMargem := item.fltTotCus * ( 1 + (IIF(fCfgSis('JURCUS', VarBoolean), item.fltTaxJur, 0) / 100) );

        Result := fRetPerComMargem(fCalculaPrecoVenda(2, fltCustoParaMargem,
                                                         item.fltTotIte - (item.fltTaxEnt) -
                                                                          (item.fltDesEsp),
                                                         0, 0, 0, 0, 0),
                                   '',
                                   IIF(fCfgSis('USACND',varBoolean),
                                       fRetConPagCodCnd(FCodCnd),
                                       FConPag));
      End;
    End
    Else
      Result := 0;
  End
  Else If (strOpcCom = 'MP') Then
  Begin
    If item.fltQtdIte <> 0 Then
    Begin
      If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
        Result := fRetornaComissaoPromocao(item, strTipVendedor)
      Else
        Result := fRetPerComMargem(fCalculaPrecoVenda(2, item.fltTotCus * ( 1 + (IIF(fCfgSis('JURCUS', VarBoolean), item.fltTaxJur, 0) / 100) ),
                                                      item.fltTotIte - (item.fltTaxEnt) -
                                                                       (item.fltDesEsp),
                                                      0, 0, 0, 0, 0),
                                   '',
                                   IIF(fCfgSis('USACND',varBoolean),
                                   fRetConPagCodCnd(FCodCnd),
                                   FConPag));
    End
    Else
      Result := 0;
  End
  {*****************************************}
  {* SE FOR CONFIGURADO POR DESCONTO GERAL *}
  {**************************************AF*}
  Else If (strOpcCom = 'G') Then
  Begin
    If item.fltQtdIte = 0 Then
    Begin
      Result := 0;
      Exit;
    End;

    {*******************************************}
    {* CASO O ITEM ESTEJA EM PROMOÇÃO, USA A   *}
    {* COMISSÃO CONFIGURADA NA PROMOÇÃO        *}
    {****************************************MV*}
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
    Begin

      fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                    (item.fltTaxEnt / item.fltQtdIte);

      If item.fltUniOri <> 0 Then
        fltPercentual := 100 - ((fltValLiq / item.fltUniOri) * 100)
      Else
        fltPercentual := 0;

      If fltPercentual < 0 Then
        fltPercentual := 0;

      Result := fRetPerComMargem(fltPercentual,'',IIF(fCfgSis('USACND',varBoolean),
                                                     fRetConPagCodCnd(FCodCnd),
                                                     FConPag));

    End;

  End
  Else If (strOpcCom = 'D') Then
  Begin

  {*************************************************}
  {* SE FOR CONFIGURADO COMO DESCONTO POR VENDEDOR *}
  {***30/11/2007********************************ER**}

    {*******************************************}
    {* CASO O ITEM ESTEJA EM PROMOÇÃO, USA A   *}
    {* COMISSÃO CONFIGURADA NA PROMOÇÃO        *}
    {****************************************MV*}
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
    Begin
      If item.fltQtdIte = 0 Then
      Begin
        Result := 0;
        Exit;
      End;

      {************************************************}
      {* RETORNA O PERC. DE COMISSÃO DE ACORDO COM    *}
      {* O DESCONTO CONCEDIDO, VERIFICANDO PELA FAIXA *}
      {* DE COMISSAO PARA ESTE VENDEDOR               *}
      {**30/11/2007*********************************ER*}

      fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                    (item.fltTaxEnt / item.fltQtdIte);

      fltPercentual := fFormataFloat(100 - ((fltValLiq / item.fltUniOri) * 100),2);
      iF fltPercentual < 0 Then
        fltPercentual := 0;

      qryGenTab := fCriaQuery(nil);

      With qryGenTab Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ');
        SQL.Add('    COM_PERCOM ');
        SQL.Add('FROM ');
        SQL.Add('  COMOPE ');
        SQL.Add('WHERE (:DESCON BETWEEN COM_PERINI AND COM_PERFIN) AND ');
        SQL.Add('       COM_CODOPE = :CODOPE ');
        ParamByName('DESCON').AsFloat  := fltPercentual;
        ParamByName('CODOPE').AsString := FCodVen;
        Open;

        If Not IsEmpty Then
          Result := qryGenTab.FieldByName('COM_PERCOM').AsFloat
        Else
          Result := 0;
      End;

      FreeAndNil(qryGenTab);

    End;

  End

  Else If (strOpcCom = 'C') Then
  Begin

    fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                  (item.fltTaxEnt / item.fltQtdIte);

    If item.fltUniOri <> 0 Then
      fltPercentual := 100 - ((fltValLiq / item.fltUniOri) * 100)
    Else
      fltPercentual := 0;

    If fltPercentual < 0 Then
      fltPercentual := 0;

    If strTipVendedor = 'E' Then
      fltComissao := IIF(fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor), fRetornaComissaoPromocao(item, strTipVendedor), item.fltComExt)
    Else If strTipVendedor = 'I' Then
      fltComissao := IIF(fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor), fRetornaComissaoPromocao(item, strTipVendedor), item.fltComInt)
    Else
      fltComissao := IIF(fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor), fRetornaComissaoPromocao(item, strTipVendedor), item.fltComDis);

    Result := fFormataFloat(fltComissao - (fltComissao * fRetPerComMargem(fltPercentual,'',IIF(fCfgSis('USACND',varBoolean),fRetConPagCodCnd(FCodCnd),FConPag)) / 100), 2);

  End

  Else If (strOpcCom = 'CC') Then
  Begin

    fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                  (item.fltTaxEnt / item.fltQtdIte);

    If item.fltUniOri <> 0 Then
      fltPercentual := 100 - ((fltValLiq / item.fltUniOri) * 100)
    Else
      fltPercentual := 0;

    If strTipVendedor = 'E' Then
      fltComissao := IIF(fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor), fRetornaComissaoPromocao(item, strTipVendedor), item.fltComExt)
    Else If strTipVendedor = 'I' Then
      fltComissao := IIF(fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor), fRetornaComissaoPromocao(item, strTipVendedor), item.fltComInt)
    Else
      fltComissao := IIF(fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor), fRetornaComissaoPromocao(item, strTipVendedor), item.fltComDis);

    Result := fFormataFloat(fltComissao - fRetPerComMargem(fltPercentual,'',IIF(fCfgSis('USACND',varBoolean),fRetConPagCodCnd(FCodCnd),FConPag)), 2);

    IF (Result < 0) Then
      Result := 0;

  End

  {*****************************************}
  {* SE FOR COMISSÃO DO CAD. DE CONDIÇÕES  *}
  {* DE PAGAMENTO                          *}
  {**************************************RV*}
  Else If (strOpcCom = 'O') Then
  Begin
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
      Result := fRetPerComCndPgto();
  End

  Else If (strOpcCom = 'PD') Then
  Begin
    {*********************************************}
    {* VERIFICA SE OBTÉM COMISSÃO DA LINHA/GRUPO *}
    {******************************************AL*}
    If (item.fltGPeCom > 0.0) Then
      Result := item.fltGPeCom
    Else
    Begin
      {************************************************************}
      {* OBTÉM COMISSÃO DA PROMOÇÃO, CASO ITEM ESTEJA EM PROMOÇÃO *}
      {*********************************************************AL*}
      If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
        Result := fRetornaComissaoPromocao(item, strTipVendedor)
      Else
      Begin
        {*************************************************************}
        {* CASO NAO TENHA O PERCENTUAL DE COMISSAO ACRESCIDO NO      *}
        {* CALCULO DO PRECO DE VENDA, UTILIZA PERCENTUAL DE COMISSAO *}
        {* DO VENDEDOR INTERNO E EXTERNO, DO CONTRARIO UTILIZA O     *}
        {* PERCENTUAL DA TABELA DE PRECO DO ITEM (ITE_COMTB?)        *}
        {**********************************************************JC*}
        If fCfgSis('PCMPRO') <> '2' Then {QUANDO O (PCMPRO IN (1,3)), CONSIDERAR A COMISSÃO DO VENDEDOR - KM}
        Begin
          If strTipVendedor = 'E' Then
            Result := item.fltComExt
          Else If strTipVendedor = 'I' Then
            Result := item.fltComInt
          Else
            Result := item.fltComDis
        End
        Else
          Result := item.fltComTbl;
      End;

      {****************************************}
      {* OBTEM PERCENTUAL DE DESCONTO DO ITEM *}
      {*************************************AL*}
      fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                    (item.fltTaxEnt / item.fltQtdIte);

      If item.fltUniOri <> 0 Then
        fltPercentual := 100 - ((fltValLiq / item.fltUniOri) * 100)
      Else
        fltPercentual := 0;

      If fltPercentual < 0 Then
        fltPercentual := 0;

      {********************************************************************************************}
      {* EFETUA CALCULO, QUE RETIRA UMA PORCENTAGEM DA COMISSÃO DE ACORDO COM A FAIXA DE DESCONTO *}
      {*****************************************************************************************AL*}
      Result := fFormataFloat(Result - (Result * (fRetPerComMargem(fltPercentual, strTipVendedor, IIF(fCfgSis('USACND',varBoolean),fRetConPagCodCnd(FCodCnd),FConPag)) / 100)), 2);
    End;
  End

  Else If (strOpcCom = 'PP') Then
  Begin
    {*********************************************}
    {* VERIFICA SE OBTÉM COMISSÃO DA LINHA/GRUPO *}
    {******************************************AL*}
    If (item.fltGPeCom > 0.0) Then
      Result := item.fltGPeCom
    Else
    Begin
      {************************************************************}
      {* OBTÉM COMISSÃO DA PROMOÇÃO, CASO ITEM ESTEJA EM PROMOÇÃO *}
      {*********************************************************AL*}
      If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
        Result := fRetornaComissaoPromocao(item, strTipVendedor)
      Else
      Begin
        {*************************************************************}
        {* CASO NAO TENHA O PERCENTUAL DE COMISSAO ACRESCIDO NO      *}
        {* CALCULO DO PRECO DE VENDA, UTILIZA PERCENTUAL DE COMISSAO *}
        {* DO VENDEDOR INTERNO E EXTERNO, DO CONTRARIO UTILIZA O     *}
        {* PERCENTUAL DA TABELA DE PRECO DO ITEM (ITE_COMTB?)        *}
        {**********************************************************JC*}
        If fCfgSis('PCMPRO') <> '2' Then {QUANDO O (PCMPRO IN (1,3)), CONSIDERAR A COMISSÃO DO VENDEDOR - KM}
        Begin
          If strTipVendedor = 'E' Then
            Result := item.fltComExt
          Else If strTipVendedor = 'I' Then
            Result := item.fltComInt
          Else
            Result := item.fltComDis
        End
        Else
          Result := item.fltComTbl;
      End;

      {**************************************************}
      {* OBTEM PERCENTUAL DE DESCONTO/ACRESCIMO DO ITEM *}
      {***********************************************AL*}
      fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                    (item.fltTaxEnt / item.fltQtdIte);

      If item.fltUniOri <> 0 Then
        fltFator := fltValLiq / item.fltUniOri
      Else
        fltFator := 1;

      {************************************************************************}
      {* EFETUA CALCULO, QUE RETIRA/ACRESCENTA UMA PORCENTAGEM DA COMISSÃO    *}
      {* PROPORCIONALMENTE AO VALOR DO ACRESCIMO/DESCONTO DADO NO PRODUTO.    *}
      {* PORÉM ESTE FATOR APLICADO AO PERCENTUAL DE COMISSÃO É LIMITADO PELAS *}
      {* CONFIGURACOES CFG_CVPPLI E CVPPLS (LIMITE INFERIOR E SUPERIOR)       *}
      {*********************************************************************JC*}
      If fltFator > fCfgSis('CVPPLS', VarDouble) Then
        fltFator := fCfgSis('CVPPLS', VarDouble)

      Else If fltFator < fCfgSis('CVPPLI', VarDouble) Then
        fltFator := fCfgSis('CVPPLI', VarDouble);

      Result := fFormataFloat(Result * fltFator, 2);
    End;
  End

  Else If (strOpcCom = 'SH') Then
  Begin
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
      Result := fRetPerSeqHierarquica(item, strTipVendedor, blnRepresent);
  End

  Else If (strOpcCom = 'TA') Then
  Begin
    strTipAtiCliente := fCampoTabela('CLI_TIPATI', 'CADCLI', ['CLI_CODCLI'], [FCodCli], False);

    If Pos(strTipAtiCliente, '_A_V_S_') <= 0 Then
    Begin
      Result := 0.00;
      Exit;
    End;

    Case strTipAtiCliente[1] Of
      'A' : Result := fCampoTabela('OPE_COMATA', 'CADOPE', ['OPE_CODOPE'], [FCodVen], False);
      'V' : Result := fCampoTabela('OPE_COMVAR', 'CADOPE', ['OPE_CODOPE'], [FCodVen], False);
      'S' : Result := fCampoTabela('OPE_COM_SM', 'CADOPE', ['OPE_CODOPE'], [FCodVen], False);
    End;

  End

  Else If (strOpcCom = 'FT') Then
  Begin
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
      Result := fRetPerComFaixaTabPre(item);
  End

  Else If (strOpcCom = 'MD') Then
  Begin

    Result := fRetPerComMargem(FMarLuc,
                               '',
                               IIF(fCfgSis('USACND',varBoolean),
                               fRetConPagCodCnd(FCodCnd),
                               FConPag));

  End

  Else If (strOpcCom = 'FTG') Then
  Begin
    If (item.strPromoc = 'S') And (fUsaComissaoPromocao(item, strTipVendedor)) Then
    Begin
      If strTipVendedor = 'E' Then
        Result := item.fltProCAt
      Else If strTipVendedor = 'I' Then
        Result := item.fltProCva
      Else
        Result := item.fltProCdi
    End
    Else
      Result := fRetPerComHierarquiaFaixaDescTabPrecoLinhaGrupo(item);
  End

  Else If (strOpcCom = 'PPT') Then
  Begin
    if strTipVendedor = 'I' then
    begin
      Result := fRetornaComissaoTabela(item.strCodIte, IIF(fEmptyStr(item.strEmpIte), VS_strCodEmp, item.strEmpIte), item.strTabPre, tcoComVar);
    end
    else if strTipVendedor = 'E' then
    begin
      Result := fRetornaComissaoTabela(item.strCodIte, IIF(fEmptyStr(item.strEmpIte), VS_strCodEmp, item.strEmpIte), item.strTabPre, tcoComAta);
    end
    else if strTipVendedor = 'D' then
    begin
      Result := fRetornaComissaoTabela(item.strCodIte, IIF(fEmptyStr(item.strEmpIte), VS_strCodEmp, item.strEmpIte), item.strTabPre, tcoComDis);
    end;
  End

  Else If (strOpcCom = 'VT') then
  Begin
    If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
      Result := fRetornaComissaoPromocao(item, strTipVendedor)
    Else
      Result := fRetornaComissaoVendedorProduto(item.strCodIte, item.strTabPre, strTipVendedor);
  End


  Else If (strOpcCom = 'HFD') Then
  Begin
    Result := fRetPerComHierarquiaFaixaDesconto(item, strTipVendedor);
  End
  {****************************************************************************************}
  {* CASO MUDAR A ESTRUTURA DO IF, MUDAR NA FUNÇÃO "fRetPerSeqHierarquica()" -> "PRODUTO" *}
  {* DUVIDAS FALAR COM RENAN                                                              *}
  {*************************************************************************************RN*}
  Else // (fCfgSis('OPCCOM') = 'P')
  Begin

    {*******************************************}
    {* VERIFICA SE A COMISSÃO DA LINHA / GRUPO *}
    {* É MAIOR QUE ZERO. CASO FOR, UTILIZA ES- *}
    {* SA COMISSÃO.                            *}
    {****************************************MV*}
    If (item.fltGPeCom > 0.0) Then
    Begin
      Result := item.fltGPeCom;
    End
    Else
    Begin
      {*******************************************}
      {* CASO SEJA COMISSÃO POR ITEM, E O ITEM   *}
      {* ESTEJA EM PROMOÇÃO, USA A COMISSÃO CON- *}
      {* FIGURADA NA PROMOÇÃO                     *}
      {****************************************MV*}
      If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
        Result := fRetornaComissaoPromocao(item, strTipVendedor)

      {*************************************************************}
      {* CASO POSSUA COMISSAO POR CLIENTE/FORNECEDOR OU            *}
      {* REGIAO/FORNECEDOR DO PRODUTO, PEGA O PERC. DO CADASTRADO  *}
      {**********************************************************JC*}
      Else If fPercDescComissClienteRegiao(FCodCli, item.strCodIte, 'PERCOM', fltPercentual) Then
        Result := fltPercentual

      Else
      Begin

        {*************************************************************}
        {* CASO NAO TENHA O PERCENTUAL DE COMISSAO ACRESCIDO NO      *}
        {* CALCULO DO PRECO DE VENDA, UTILIZA PERCENTUAL DE COMISSAO *}
        {* DO VENDEDOR INTERNO E EXTERNO, DO CONTRARIO UTILIZA O     *}
        {* PERCENTUAL DA TABELA DE PRECO DO ITEM (ITE_COMTB?)        *}
        {**********************************************************JC*}
        If fCfgSis('PCMPRO') <> '2' Then {QUANDO O (PCMPRO IN (1,3)), CONSIDERAR A COMISSÃO DO VENDEDOR - KM}
        Begin
          If strTipVendedor = 'E' Then
            Result := item.fltComExt
          Else If strTipVendedor = 'I' Then
            Result := item.fltComInt
          Else If strTipVendedor = 'T' Then
            Result := item.fltComDig
          Else
            Result := item.fltComDis
        End
        Else
          Result := item.fltComTbl;

      End;
    End;
  End;

end;

function TCalculoComissaoVendedor.fRetDesSeqCom(intSeq: Integer): String;
  Var
    qrySeqCom : TUniQuery;
begin
  qrySeqCom := fCriaQuery(Nil);

  With qrySeqCom Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COM_DESCRI FROM SEQCOM WHERE COM_SEQIND = ' + IntToStr(intSeq));
    Open;
    Result := FieldByName('COM_DESCRI').AsString;
    Close;
  End;

  FreeAndNil(qrySeqCom);
end;

function TCalculoComissaoVendedor.fRetornaComissaoTabela(strCodIte, strCodEmp,
  strTabPre: string; TipCom: TComissaoTabela): Double;
var
  qryComissao: TUniQuery;
begin
  Result := 0;
  qryComissao := fCriaQuery;

  try
    qryComissao.Close;
    qryComissao.SQL.Clear;

    qryComissao.SQL.Add('SELECT TAB_COMVAR, TAB_COMATA, TAB_COMDIS');
    qryComissao.SQL.Add('FROM COMTAB');
    qryComissao.SQL.Add('WHERE TAB_CODITE = :CODITE');
    qryComissao.SQL.Add('AND TAB_CODEMP = :CODEMP');
    qryComissao.SQL.Add('AND TAB_TABELA = :TABELA');

    qryComissao.ParamByName('CODITE').AsString  := strCodIte;
    qryComissao.ParamByName('CODEMP').AsString  := strCodEmp;
    qryComissao.ParamByName('TABELA').AsInteger := StrToIntDef(strTabPre ,1);

    qryComissao.Open;

    case TipCom of
      tcoComVar: Result := qryComissao.FieldByName('TAB_COMVAR').AsFloat;
      tcoComAta: Result := qryComissao.FieldByName('TAB_COMATA').AsFloat;
      tcoComDis: Result := qryComissao.FieldByName('TAB_COMDIS').AsFloat;
    end;
  finally
    FreeAndNil(qryComissao);
  end;
end;

function TCalculoComissaoVendedor.fRetornaComissaoVendedorProduto(strCodIte,
  strTabPre, strTipVen: string): Double;
var
  qryComissao: TUniQuery;
begin
  Result := 0;
  qryComissao := fCriaQuery;

  try
    qryComissao.Close;
    qryComissao.SQL.Clear;
    qryComissao.SQL.Add('SELECT COM_VENEXT, COM_VENINT');
    qryComissao.SQL.Add('FROM COMITE');
    qryComissao.SQL.Add('WHERE COM_CODITE = :CODITE');
    qryComissao.SQL.Add('AND COM_TABPRE = :TABPRE');

    qryComissao.ParamByName('CODITE').AsString := strCodIte;
    qryComissao.ParamByName('TABPRE').AsString := strTabPre;

    qryComissao.Open;

    if qryComissao.IsEmpty then
      Exit;

    if strTipVen = 'I' then
      Result := qryComissao.FieldByName('COM_VENINT').AsFloat
    else
      Result := qryComissao.FieldByName('COM_VENEXT').AsFloat;

  finally
    FreeAndNil(qryComissao);
  end;
end;

{*********************************************************}
{* SE O PERCENTUAL DA COMISSÃO NO CADASTRO DE CLIENTE    *}
{* FOR MAIOR QUE ZERO, RETORNA O PERCENTUAL DO CADASTRO  *}
{* DE CLIENTE, SENÃO RETORNA O PERCENTUAL DO CADASTRO DE *}
{* OPERADOR.                                             *}
{******************************************************PZ*}
function TCalculoComissaoVendedor.fRetPerComCliente_Vendedor: Double;
begin
  Result := fCampoTabela('CLI_PERCOM', 'CADCLI', ['CLI_CODCLI'], [FCodCli], False);

  If Result <= 0 Then
  Begin
    If (fStatusCndPag(FConPag) = A_VISTA) Then
      Result := fCampoTabela('OPE_PERCOM', 'CADOPE', ['OPE_CODOPE'], [FCodVen], False)
    Else
      Result := fCampoTabela('OPE_PERCO2', 'CADOPE', ['OPE_CODOPE'], [FCodVen], False);
  End;

end;

{*******************************************}
{* CALCULA A COMISSAO DO VENDEDOR/REPRESEN-*}
{* TANTE COM BASE NO CADASTRO DE REGIOES/  *}
{* TINTA DE MAQUINA OU DEMAIS PRODUTOS     *}
{****************************************JC*}
function TCalculoComissaoVendedor.fRetPerComRegiao(const item: TDadosFechamento; strTipVendedor: String; blnRepresent: Boolean): Double;
  Var
    qryGen          : TUniQuery;
    strSql          : String;
    strCodVenCli    : String;
    strCodRepCli    : String;
    fltValLiq       : Double;
    fltPercentual   : Double;
    blnOutroVendedor: Boolean;
begin
  strCodVenCli := fDadosCliente('CODVEN');
  strCodRepCli := fDadosCliente('CODREP');

  {**************************************************}
  {* CASO O CLIENTE ESTEJA DEFINIDO EM UMA REGIAO   *}
  {* VERIFICA SE E' OUTRO VENDEDOR                  *}
  {***********************************************JC*}
  blnOutroVendedor := (Not fEmptyStr(FCodReg)) And (strCodVenCli <> FCodVen) And (strCodRepCli <> FCodVen);

  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE    ';
  strSql := strSql + '   *                    ';
  strSql := strSql + ' FROM                   ';
  strSql := strSql + '   CADREG               ';
  strSql := strSql + ' WHERE                  ';
  strSql := strSql + '   REG_CODREG = :CODREG ';

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);
    ParamByName('CODREG').AsString := FCodReg;
    Open;

    {************************************************}
    {* CASO O CLIENTE POSSUA RELACIONAMENTO COM UMA *}
    {* DETERMINADA REGIAO PEGA O PERCENTUAL NO      *}
    {* CADASTRO DA MESMA SENDO:                     *}
    {* -COMISSAO INTERNO                            *}
    {* -COMISSAO EXTERNO REPRESESENTANTE LOJA       *}
    {* -COMISSAO EXTERNO REPRESENTANTE DISTRIBUIDOR *}
    {* -COMISSAO OUTROS                             *}
    {*********************************************JC*}
    If (Not IsEmpty) And (Not blnOutroVendedor) Then
    Begin

      If (FCodVen = strCodVenCli) And (FCodVen = strCodRepCli) Then
        Result := FieldByName('REG_COMOUT').AsFloat
      Else
      Begin
        If strTipVendedor = 'E' Then
          Result := FieldByName('REG_COMEXT').AsFloat
        Else If strTipVendedor = 'I' Then
          Result := FieldByName('REG_COMINT').AsFloat
        Else
          Result := FieldByName('REG_COMDIS').AsFloat
      End;

      {********************************************}
      {* CASO O VENDEDOR SEJA O PROPRIO REPRESEN  *}
      {* TANTE E SEJA CALCULO DE VENDEDOR         *}
      {* ZERA O RESULTADO POIS, A COMISSAO SERA   *}
      {* PAGA SOMENTE PARA O REPRESENTANTE        *}
      {*****************************************JC*}
      If (strCodRepCli = FCodVen) And (Not blnRepresent) Then
        Result := 0.0;

      {***********************************************}
      {* CASO O VENDEDOR NAO SEJA O DO CLIENTE E NEM *}
      {* O SEU REPRESENT E NAO SEJA CALCULO DO VENDE *}
      {* DOR ZERA RESULTA DO. POIS NAO VAI           *}
      {* PAGAR COMISSAO PARA O REPRESENTANTE         *}
      {********************************************JC*}
      If blnOutroVendedor And blnRepresent Then
        Result := 0.0;

    End
    {************************************************}
    {* CASO NAO USE CADASTRO DE REGIOES VERIFICA    *}
    {* SE O ITEM E' TINTA DE MAQUINA. SE SIM PEGA   *}
    {* O PERCENTUAL DA CONFIGURACAO CONFORME O TIPO *}
    {* DO VENDEDOR(INTERNO OU EXTERNO)              *}
    {*********************************************JC*}
    Else If item.strIdePro <> 'NOR' Then
    Begin
      If strTipVendedor = 'E' Then
        Result := fCfgSis('CTMEXT', varDouble)
      Else If strTipVendedor = 'I' Then
        Result := fCfgSis('CTMINT', varDouble)
      Else
        Result := fCfgSis('CTMDIS', varDouble)
    End
    Else
    {*******************************************}
    {* CASO NAO USE REGIAO (CLIENTE) E SEJA UM *}
    {* PRODUTO NORMAL CALCULA O PERCENTUAL COM *}
    {* BASE NO CADASTRO DE PRODUTOS            *}
    {****************************************JC*}
    Begin

      fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                    (item.fltTaxEnt / item.fltQtdIte);

      fltPercentual := 100 - ((fltValLiq / item.fltUniOri) * 100);
      iF fltPercentual < 0 Then
        fltPercentual := 0;

      If strTipVendedor = 'E' Then
        Result := fFormataFloat(item.fltComExt - (item.fltComExt * fRetPerComMargem(fltPercentual,'',IIF(fCfgSis('USACND',varBoolean),fRetConPagCodCnd(FCodCnd),FConPag)) / 100), 2)
      Else If strTipVendedor = 'I' Then
        Result := fFormataFloat(item.fltComInt - (item.fltComInt * fRetPerComMargem(fltPercentual,'',IIF(fCfgSis('USACND',varBoolean),fRetConPagCodCnd(FCodCnd),FConPag)) / 100), 2)
      Else
        Result := fFormataFloat(item.fltComDis - (item.fltComDis * fRetPerComMargem(fltPercentual,'',IIF(fCfgSis('USACND',varBoolean),fRetConPagCodCnd(FCodCnd),FConPag)) / 100), 2)

    End;

  End;

  FreeAndNil(qryGen);

end;

function TCalculoComissaoVendedor.fPerComVendedor(strCodVen: String): Double;
begin
  If (fStatusCndPag(FConPag) = A_VISTA) Then
    Result := fCampoTabela('OPE_PERCOM', 'CADOPE', ['OPE_CODOPE'], [strCodVen], False)
  Else
    Result := fCampoTabela('OPE_PERCO2', 'CADOPE', ['OPE_CODOPE'], [strCodVen], False);
end;

function TCalculoComissaoVendedor.fRetPerComCndPgto: Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE    ';
  strSQL := strSQL + '   CND_PERCOM           ';
  strSQL := strSQL + ' FROM                   ';
  strSQL := strSQL + '   CADCND               ';
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   CND_CODIGO = :CNDPAG ';
  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);
    ParamByName('CNDPAG').AsString := FCodCnd;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('CND_PERCOM').AsFloat
    Else
      Result := 0;
  End;
  FreeAndNil(qryGen);
end;

function TCalculoComissaoVendedor.fRetPerComFor(strCodFor,
  strCodOpe: String): Double;
  Var
    qryComFor : TUniQuery;
begin
  qryComFor := fCriaQuery(Nil);

  With qryComFor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT FOR_PERCOM ');
    SQL.Add('   FROM COMFOR ');
    SQL.Add('  WHERE FOR_CODFOR = :CODFOR ');
    SQL.Add('    AND FOR_CODOPE = :CODOPE ');
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('CODOPE').AsString := strCodOpe;
    Open;
    Result := FieldByName('FOR_PERCOM').AsFloat;
    Close;
  End;

  FreeAndNil(qryComFor);
end;

function TCalculoComissaoVendedor.fRetPerComHierarquiaFaixaDesconto(
  const item: TDadosFechamento; strTipVendedor: String): Double;
var
  fltPerDes: Double;
begin
  Result := 0;

  fltPerDes := IIF(item.fltUniOri > item.fltUniTar, ((item.fltUniOri - item.fltUniTar) / item.fltUniOri) * 100, 0);

  if fTemPerComHierarquiaFaixaDescontoCliente(FCodCli, item.strCodIte, fltPerDes, Result, item.strTabPre) then
    Exit;

  if fTemPerComHierarquiaFaixaDescontoVendedor(FCodVen, item.strCodIte, fltPerDes, Result, item.strTabPre) then
    Exit;

  if fTemPerComHierarquiaFaixaDescontoSubGerente(FCodVen, item.strCodIte, fltPerDes, Result, item.strTabPre) then
    Exit;

  if fTemPerComHierarquiaFaixaDescontoGerente(FCodVen, item.strCodIte, fltPerDes, Result, item.strTabPre) then
    Exit;

  if fTemPerComHierarquiaFaixaDescontoGeral(item.strCodIte, fltPerDes, Result, item.strTabPre) then
    Exit;

  If fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
  Begin
    Result := fRetornaComissaoPromocao(item, strTipVendedor);
    Exit;
  End;

  If Not fUtilizarPercentuaisDeComissaoDaPromocao(item, strTipVendedor) Then
    Result := fRetPerComHierarquiaFaixaDescTabPrecoLinhaGrupo(item);
end;

function TCalculoComissaoVendedor.fRetPerComHierarquiaFaixaDescTabPrecoLinhaGrupo(
  const item: TDadosFechamento): Double;
var
  intDecUni     : Integer;
  fltDesCon,
  fltValLiq,
  fltUniOri,
  fltPercentual : Double;
  strSQL,
  LTabelaPreco  : String;
  qrySelect     : TUniQuery;
begin
  fltValLiq := item.fltUniTar - (item.fltDesEsp / item.fltQtdIte) -
                                (item.fltTaxEnt / item.fltQtdIte);

  fltUniOri := item.fltUniOri;

  if fCfgSis('FTGCND', varBoolean) and (fStatusCndPag(FConPag) = A_VISTA) then
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT CND_ABADES, ';
    strSQL := strSQL + '       CND_DESMAX  ';
    strSQL := strSQL + '  FROM CADCND ';
    strSQL := strSQL + ' WHERE CND_CODIGO = :CODCND ';

    qrySelect := fCriaQuery;
    try
      qrySelect.Close;
      qrySelect.SQL.Clear;
      qrySelect.SQL.Add(strSQL);
      qrySelect.ParamByName('CODCND').AsString := FCodCnd;
      qrySelect.Open;

      fltDesCon := item.fltDesCon;
      intDecUni := fCfgSis('DECUNI', varInteger);

      if (fltDesCon = 0) and (fFormataFloat(fltUniOri, intDecUni) <> fFormataFloat(fltValLiq, intDecUni)) then
        fltDesCon := fFormataFloat(100 - fltValLiq * 100 / fltUniOri, intDecUni);

      if (qrySelect.FieldByName('CND_DESMAX').AsFloat > 0) then
      begin
        if (qrySelect.FieldByName('CND_ABADES').AsString = 'S') then
          fltUniOri := item.fltUniOri - (item.fltUniOri * qrySelect.FieldByName('CND_DESMAX').AsFloat / 100)
        else
        begin
          if (fltDesCon > qrySelect.FieldByName('CND_DESMAX').AsFloat) then
            fltUniOri := item.fltUniOri - (item.fltUniOri * qrySelect.FieldByName('CND_DESMAX').AsFloat / 100)
          else
            fltUniOri := item.fltUniOri - (item.fltUniOri * fltDesCon / 100);
        end;

        fltUniOri := fFormataFloat(fltUniOri, intDecUni);
      end;
    finally
      FreeAndNil(qrySelect);
    end;
  end;

  If fltUniOri <> 0 Then
    fltPercentual := fFormataFloat(100 - ((fltValLiq / fltUniOri) * 100),2)
  Else
    fltPercentual := 0;

  If (fCfgSis('TABITE') = 'S') And (item.strTabPre <> '') Then
    LTabelaPreco := item.strTabPre
  Else
    LTabelaPreco := FTabPre;

  Result := TComissaoFaixaDescTabPrecoLinhaGrupoDAO.
            fGetPercentualDesconto(LTabelaPreco,
                                   item.strCodGru,
                                   fltPercentual,
                                   fStatusCndPag(FConPag) = A_VISTA);
end;

function TCalculoComissaoVendedor.fRetPerComissao(const item: TDadosFechamento;
  const strTipVendedor: String; const blnRepresent: Boolean; const strOpcComiss,
  strTabPre, strCodVen: String): Double;
  Var
    strSavCodVen : String;
    strSavTabPre : String;
begin
  strSavCodVen := FCodVen;
  strSavTabPre := FTabPre;
  Try
    FCodVen  := strCodVen;
    FTabPre  := strTabPre;
    Result := Self.fRetPerComissao(item, strTipVendedor, blnRepresent, strOpcComiss);
  Finally
    FCodVen := strSavCodVen;
    FTabPre := strSavTabPre;
  End;
end;

function TCalculoComissaoVendedor.fRetPerSeqHierarquica(const item: TDadosFechamento; strTipVendedor: String; blnRepresent: Boolean = False): Double;
  Var
    intCnt : Integer;
    strDes : String;
begin
  Result := 0;

  For intCnt := 0 To 3 Do
  Begin
    strDes := fRetDesSeqCom(intCnt);

    If (strDes = 'PRODUTO') Then                                    // Para pegar o "Else Begin"
      Result := fRetPerComissao(item, strTipVendedor, blnRepresent, 'XX99999')
    Else If (strDes = 'LINHA e GRUPO') Then
      Result := item.fltGPeCom
    Else If (strDes = 'FORNECEDOR') Then
    Begin
      Result := fRetPerComFor(item.strCodFor, item.strCodVen);
      If fFormataFloat(Result, 2) = 0 Then
        Result := item.fltComFor;
    End
    Else If (strDes = 'VENDEDOR') Then
      Result := fRetPerComissao(item, strTipVendedor, blnRepresent, 'V');

    If (fFormataFloat(Result, 2) <> 0) Then
      Break;
  End;
end;

function TCalculoComissaoVendedor.fTemPerComHierarquiaFaixaDescontoCliente(
  strCodCli, strCodIte: String; fltPerDes: Double;
  var fltPerCom: Double; strTabPre: String): Boolean;
var
  qryCliente: TUniQuery;
begin
  qryCliente := fCriaQuery;

  try
    fltPerCom := 0;
    Result := False;

    qryCliente.Close;
    qryCliente.SQL.Clear;
    qryCliente.SQL.Add('SELECT H.HLC_PERCOM');
    qryCliente.SQL.Add('FROM HLCFAI H');
    qryCliente.SQL.Add('INNER JOIN COMHLC C');
    qryCliente.SQL.Add('ON(H.HLC_CODTAB = C.HLC_CODTAB)');
    qryCliente.SQL.Add('WHERE H.HLC_CODITE = :CODITE');
    qryCliente.SQL.Add('AND C.HLC_CODCLI = :CODCLI');
    qryCliente.SQL.Add('AND :PERDES BETWEEN H.HLC_DESINI AND H.HLC_DESFIN');

    if fCfgSis('TPCHFD', varBoolean) then
    begin
      qryCliente.SQL.Add('AND H.HLC_TABPRE = :TABPRE');
      qryCliente.ParamByName('TABPRE').AsString := strTabPre;
    end;

    qryCliente.ParamByName('CODITE').AsString := strCodIte;
    qryCliente.ParamByName('CODCLI').AsString := strCodCli;
    qryCliente.ParamByName('PERDES').AsFloat := fltPerDes;

    qryCliente.Open;

    if qryCliente.IsEmpty then
      Exit;

    fltPerCom := qryCliente.FieldByName('HLC_PERCOM').AsFloat;
    Result := True;
  finally
    FreeAndNil(qryCliente);
  end;
end;

function TCalculoComissaoVendedor.fTemPerComHierarquiaFaixaDescontoGeral(
  strCodIte: String; fltPerDes: Double; var fltPerCom: Double; strTabPre: String): Boolean;
var
  qryGeral: TUniQuery;
begin
  qryGeral := fCriaQuery;

  try
    fltPerCom := 0;
    Result := False;

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add('SELECT HLF_PERCOM');
    qryGeral.SQL.Add('FROM COMHLF');
    qryGeral.SQL.Add('WHERE HLF_CODITE = :CODITE');
    qryGeral.SQL.Add('AND :PERDES BETWEEN HLF_DESINI AND HLF_DESFIN');

    if fCfgSis('TPCHFD', varBoolean) then
    begin
      qryGeral.SQL.Add('AND HLF_TABPRE = :TABPRE');
      qryGeral.ParamByName('TABPRE').AsString := strTabPre;
    end;

    qryGeral.ParamByName('CODITE').AsString := strCodIte;
    qryGeral.ParamByName('PERDES').AsFloat := fltPerDes;

    qryGeral.Open;

    if qryGeral.IsEmpty then
      Exit;

    fltPerCom := qryGeral.FieldByName('HLF_PERCOM').AsFloat;
    Result := True;
  finally
    FreeAndNil(qryGeral);
  end;
end;

function TCalculoComissaoVendedor.fTemPerComHierarquiaFaixaDescontoGerente(
  strCodGer, strCodIte: String; fltPerDes: Double;
  var fltPerCom: Double; strTabPre: String): Boolean;
var
  qryGerente: TUniQuery;
begin
  qryGerente := fCriaQuery;

  try
    fltPerCom := 0;
    Result := False;

    qryGerente.Close;
    qryGerente.SQL.Clear;
    qryGerente.SQL.Add('SELECT H.HLG_PERCOM');
    qryGerente.SQL.Add('FROM HLGFAI H');
    qryGerente.SQL.Add('INNER JOIN COMHLG C');
    qryGerente.SQL.Add('ON(H.HLG_CODTAB = C.HLG_CODTAB)');
    qryGerente.SQL.Add('WHERE H.HLG_CODITE = :CODITE');
    qryGerente.SQL.Add('AND C.HLG_CODGER = :CODGER');
    qryGerente.SQL.Add('AND :PERDES BETWEEN H.HLG_DESINI AND H.HLG_DESFIN');

    if fCfgSis('TPCHFD', varBoolean) then
    begin
      qryGerente.SQL.Add('AND H.HLG_TABPRE = :TABPRE');
      qryGerente.ParamByName('TABPRE').AsString := strTabPre;
    end;

    qryGerente.ParamByName('CODITE').AsString := strCodIte;
    qryGerente.ParamByName('CODGER').AsString := strCodGer;
    qryGerente.ParamByName('PERDES').AsFloat := fltPerDes;

    qryGerente.Open;

    if qryGerente.IsEmpty then
      Exit;

    fltPerCom := qryGerente.FieldByName('HLG_PERCOM').AsFloat;
    Result := True;
  finally
    FreeAndNil(qryGerente);
  end;
end;

function TCalculoComissaoVendedor.fTemPerComHierarquiaFaixaDescontoSubGerente(
  strCodSub, strCodIte: String; fltPerDes: Double;
  var fltPerCom: Double; strTabPre: String): Boolean;
var
  qrySubGerente: TUniQuery;
begin
  qrySubGerente := fCriaQuery;

  try
    fltPerCom := 0;
    Result := False;

    qrySubGerente.Close;
    qrySubGerente.SQL.Clear;
    qrySubGerente.SQL.Add('SELECT H.HLS_PERCOM');
    qrySubGerente.SQL.Add('FROM HLSFAI H');
    qrySubGerente.SQL.Add('INNER JOIN COMHLS C');
    qrySubGerente.SQL.Add('ON(H.HLS_CODTAB = C.HLS_CODTAB)');
    qrySubGerente.SQL.Add('WHERE H.HLS_CODITE = :CODITE');
    qrySubGerente.SQL.Add('AND C.HLS_CODSUB = :CODSUB');
    qrySubGerente.SQL.Add('AND :PERDES BETWEEN H.HLS_DESINI AND H.HLS_DESFIN');

    if fCfgSis('TPCHFD', varBoolean) then
    begin
      qrySubGerente.SQL.Add('AND H.HLS_TABPRE = :TABPRE');
      qrySubGerente.ParamByName('TABPRE').AsString := strTabPre;
    end;

    qrySubGerente.ParamByName('CODITE').AsString := strCodIte;
    qrySubGerente.ParamByName('CODSUB').AsString := strCodSub;
    qrySubGerente.ParamByName('PERDES').AsFloat := fltPerDes;

    qrySubGerente.Open;

    if qrySubGerente.IsEmpty then
      Exit;

    fltPerCom := qrySubGerente.FieldByName('HLS_PERCOM').AsFloat;
    Result := True;
  finally
    FreeAndNil(qrySubGerente);
  end;
end;

function TCalculoComissaoVendedor.fTemPerComHierarquiaFaixaDescontoVendedor(
  strCodVen, strCodIte: String; fltPerDes: Double;
  var fltPerCom: Double; strTabPre: String): Boolean;
var
  qryVendedor: TUniQuery;
begin
  qryVendedor := fCriaQuery;

  try
    fltPerCom := 0;
    Result := False;

    qryVendedor.Close;
    qryVendedor.SQL.Clear;
    qryVendedor.SQL.Add('SELECT H.HLV_PERCOM');
    qryVendedor.SQL.Add('FROM HLVFAI H');
    qryVendedor.SQL.Add('INNER JOIN COMHLV C');
    qryVendedor.SQL.Add('ON(H.HLV_CODTAB = C.HLV_CODTAB)');
    qryVendedor.SQL.Add('WHERE H.HLV_CODITE = :CODITE');
    qryVendedor.SQL.Add('AND C.HLV_CODVEN = :CODVEN');
    qryVendedor.SQL.Add('AND :PERDES BETWEEN H.HLV_DESINI AND H.HLV_DESFIN');

    if fCfgSis('TPCHFD', varBoolean) then
    begin
      qryVendedor.SQL.Add('AND H.HLV_TABPRE = :TABPRE');
      qryVendedor.ParamByName('TABPRE').AsString := strTabPre;
    end;

    qryVendedor.ParamByName('CODITE').AsString := strCodIte;
    qryVendedor.ParamByName('CODVEN').AsString := strCodVen;
    qryVendedor.ParamByName('PERDES').AsFloat := fltPerDes;

    qryVendedor.Open;

    if qryVendedor.IsEmpty then
      Exit;

    fltPerCom := qryVendedor.FieldByName('HLV_PERCOM').AsFloat;
    Result := True;
  finally
    FreeAndNil(qryVendedor);
  end;
end;

function TCalculoComissaoVendedor.fComissaoPorFaixaDeMargemPorVendedor(strOpcCom : String): Boolean;
begin
  Result := (strOpcCom = 'MVI');
end;

function TCalculoComissaoVendedor.fDadosCliente(strCampo: String): String;
  Var
    qryDadCli: TUniQuery;
begin
  qryDadCli := fCriaQuery(Nil);

  With qryDadCli Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CLI_' + strCampo + ' FROM CADCLI WHERE CLI_CODCLI = :CODCLI ');
    ParamByName('CODCLI').AsString := FCodCli;
    Open;

    Result := Fields[0].AsString;
  End;

  FreeAndNil(qryDadCli);
end;

function TCalculoComissaoVendedor.fRetComissaoFaixaDescontoDepartamento(const item: TDadosFechamento): Double;
Var
  qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery(Nil);

  Try

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT DPD.COM_PERCOM ');
      SQL.Add('FROM COMDPG DPG');
      SQL.Add('  INNER JOIN COMDPD DPD ON DPD.COM_SEQCOM = DPG.AUTOINCREM ');
      if fCfgSis('CNDFAI', varBoolean) then
        SQL.Add('  INNER JOIN COMDPC DPC ON DPC.COM_SEQCOM = DPG.AUTOINCREM ');
      SQL.Add('  INNER JOIN CADITE ITE ON ITE.ITE_CODITE = :CODITE ');
      SQL.Add('  WHERE :DESCON BETWEEN DPD.COM_DESINI AND DPD.COM_DESFIN ');
      if fCfgSis('CNDFAI', varBoolean) then
        SQL.Add('    AND DPC.COM_CODCND = :CODCND ');
      SQL.Add('    AND DPG.COM_CODDEP = ITE.ITE_CODDEP ');

      ParamByName('CODITE').AsString := item.strCodIte;
      ParamByName('DESCON').AsFloat  := item.fltDesCon;
      if fCfgSis('CNDFAI', varBoolean) then
        ParamByName('CODCND').AsString := FCodCnd;
      Open;

      Result := FieldByName('COM_PERCOM').AsFloat;
    End;

  Finally
    FreeAndNil(qryTmp);
  End;

end;

function TCalculoComissaoVendedor.fRetPerComFaixaTabPre(const item: TDadosFechamento): Double;
  Var
    qryComFai : TUniQuery;
    fltValIte : Double;
    fltTotFin : Double;
begin
  qryComFai := fCriaQuery(Nil);
  Try
    With qryComFai Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');

      If (FConPag = '01000') Then
        SQL.Add(' IFNULL(FCP_COMVIS, 0) AS COMISSAO ')
      Else
        SQL.Add(' IFNULL(FCP_COMPRA, 0) AS COMISSAO ');

      SQL.Add('   FROM CADFCP ');
      SQL.Add('  WHERE FCP_TABPRE = :TABPRE ');

      If (FstrEspDoc = 'BR') Or (CLAFIS_BR.Contains(item.strClaFis)) Then
        fltValIte := 0
      Else
      Begin
        {**************************************************************}
        {* TRATADO PARA SOMAR O ICMORG AO DESESP PARA QUE O VALOR DE  *}
        {* DESCONTO SUFRAMA NÃO SEJA CONSIDERADO AO ATRIBUIR A TABELA *}
        {* DE PREÇO COM BASE NO VALOR TOTAL DO ITEM                   *}
        {**************************************************REQ 119579**}
        fltTotFin := item.fltTotite - item.fltDesEsp + item.fltIcmOrg;

        If (fCfgSis('DESEPJ', varBoolean)) And (item.fltDesCnd > 0) Then
        Begin
          fltTotFin := fltTotFin / ((100 - item.fltDesCnd)/100);
          fltTotFin := fFormataFloat(fltTotFin, 2);
        End;

        fltValIte := fFormataFloat((((item.fltUniOri - ((fltTotFin) / item.fltQtdIte)) * IIF((StrToIntDef(LeftStr(item.strClaFis, 1), 0) < 5), -1, 1)) / item.fltUniOri) * 100, 2);
      End;

      SQL.Add(' AND :VALBUS BETWEEN FCP_DESINI AND FCP_DESFIN ');
      ParamByName('TABPRE').AsString := item.strTabPre;
      ParamByName('VALBUS').AsFloat := fltValIte;
      Open;
      Result := FieldByName('COMISSAO').AsFloat;
      Close;
    End;
  Finally
    FreeAndNil(qryComFai);
  End;
end;

end.
