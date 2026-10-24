{*******************************************************}
{* ESSA UNI FOI CRIADA PARA FACILITAR A COMUNICAÇÃO    *}
{* ENTRE O AUTCOM E A AUTCOMTINTA                      *}
{****************************************************MV*}

unit untAutcomDllTinta;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, untFuncoesGenerica, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untGTinForTipos, Uni, Classes, untTypesSistema, untIExecutaSQLReplicacaoTinta;

type
  TfGTinForGeral = function (strIdePro, strIteTin, strTipPre, strLinTin, strCatalize: String;
    intLazQua: Integer; fltQtdEmb: Double; fltQtdIte: Double; strDescri: String;
    qryArqFor: TUniQuery; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double;
    strTipCor: String; strTextBase: String; intAcao: Integer; strIteCob: String;
    strCodEmpPrd: string; strPerformance: String = ''): Boolean; stdcall;


function fBaixarEstoqueColorantes(fGravaMovGer: TfGravaMovGer;
                                  fGravaMovDet: TfGravaMovDet;
                                  arrBaixaPigmentos: TBaixaPigmentosArray;
                                  strIdePro: String;
                                  fltQtdBaixar: Double;
                                  strClaFisIte,
                                  strCodTra,
                                  strCodVen,
                                  strCodCli,
                                  strConPag,
                                  strCliEst,
                                  strCliNom,
                                  strCliEnd,
                                  strCliBai,
                                  strCliCep,
                                  strCodCid,
                                  strCliTel: String;
                                  intCgcCpf: Integer;
                                  strCliCgc,
                                  strCliIes,
                                  strCli_Rg,
                                  strEspDoc,
                                  strNumDoc: String;
                                  blnNotEsp,
                                  blnCupEsp: Boolean;
                                  strClaFi2,
                                  strClaFi3,
                                  strDesCla: String;
                                  fltPorDes: Double;
                                  strCodDig,
                                  strCodCnd,
                                  strCodFpg: String;
                                  fltFatNot: Double;
                                  strCodRep,
                                  strCliCon,
                                  strEntFat,
                                  strCliFat,
                                  strOpeExp,
                                  strTabPre,
                                  strEntFut: String;
                                  blnBaiEntFut: Boolean;
                                  fltMargem: Double;
                                  strEmpOri,
                                  strCodDiv,
                                  strCodVe2: String;
                                  Var stlDetMls: TStringList;
                                  strCodEmp: String;
                                  Var strAutIncML: String;
                                  Var strAutIncTM: String;
                                  strCodAca : String = '';
                                  strEmpAca : String = '';
                                  objReplTinta : IExecutaSQLReplicacaoTinta = nil): Boolean;

  function fGravaForTin(strCodAca, strTexBas, strTipCor: String; intModDil: Integer; strEmpAca, strIteCob,
    strUniver: String; fltFatAce: Double; strCatali: String): Boolean;

implementation

uses
  untCadIte, untCadLote, SysUtils, Variants, Math, StrUtils;

function fBaixarEstoqueColorantes(fGravaMovGer: TfGravaMovGer;
                                  fGravaMovDet: TfGravaMovDet;
                                  arrBaixaPigmentos: TBaixaPigmentosArray;
                                  strIdePro: String;
                                  fltQtdBaixar: Double;
                                  strClaFisIte,
                                  strCodTra,
                                  strCodVen,
                                  strCodCli,
                                  strConPag,
                                  strCliEst,
                                  strCliNom,
                                  strCliEnd,
                                  strCliBai,
                                  strCliCep,
                                  strCodCid,
                                  strCliTel: String;
                                  intCgcCpf: Integer;
                                  strCliCgc,
                                  strCliIes,
                                  strCli_Rg,
                                  strEspDoc,
                                  strNumDoc: String;
                                  blnNotEsp,
                                  blnCupEsp: Boolean;
                                  strClaFi2,
                                  strClaFi3,
                                  strDesCla: String;
                                  fltPorDes: Double;
                                  strCodDig,
                                  strCodCnd,
                                  strCodFpg: String;
                                  fltFatNot: Double;
                                  strCodRep,
                                  strCliCon,
                                  strEntFat,
                                  strCliFat,
                                  strOpeExp,
                                  strTabPre,
                                  strEntFut: String;
                                  blnBaiEntFut: Boolean;
                                  fltMargem: Double;
                                  strEmpOri,
                                  strCodDiv,
                                  strCodVe2: String;
                                  Var stlDetMls: TStringList;
                                  strCodEmp: String;
                                  Var strAutIncML: String;
                                  Var strAutIncTM: String;
                                  strCodAca : String = '';
                                  strEmpAca : String = '';
                                  objReplTinta : IExecutaSQLReplicacaoTinta = nil): Boolean;
  Var
    strSQL: String;
    strNumDocML: String;
    strNumDocTM: String;
    intContador: Integer;
    intCont: Integer;

    fltSal_Ml: Double;
    fltSaldos: Double;
    strAutIncTmp: String;

    qryGenIte: TUniQuery;

    recServicos: TDadosServicos;

    fltQtdBaixarSalMl: Double;

    strSerie : String;

    arrDuplic : TarrDuplicata;

    function fGetNumeroLote: String;
      Var
        objCadLot: TCadLot;
    begin
      Result := '';

      If (fUsaRotinaWMS) Or (fCfgSis('CTLEST', varString) = 2) Then
      Begin
        objCadLot := TCadLot.Create(nil);
        Result := objCadLot.fRetLotePrincipalTintaMaquina(qryGenIte.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);
        FreeAndNil(objCadLot);
      End;
    end;

    function fRetClaFisColorante: String;
    Begin
      If (strEspDoc = 'PA') Then
        Result := '5888'
      Else
        Result := '5999';
    End;

    function fRetSalMlBaixar(strCodIte: String; intIndex: Integer): Double;
//      Var
//        intIndex: Integer;
    begin
      Result := 0.0;
//      For intIndex := Low(arrBaixaPigmentos) To High(arrBaixaPigmentos) Do
//      Begin
        If strCodIte = arrBaixaPigmentos[intIndex].strCodIte Then
          Result := arrBaixaPigmentos[intIndex].fltQtdBaixa;
//      End;
    end;

    function fGetTipoComponente(strCodIte: String): String;
      Var
        intIndex: Integer;
    begin
      Result := 'C';
      For intIndex := Low(arrBaixaPigmentos) To High(arrBaixaPigmentos) Do
      Begin
        If arrBaixaPigmentos[intIndex].strCodIte = strCodIte Then
        Begin
          Result := arrBaixaPigmentos[intIndex].strTipComp;

          //CT = Catalisador Advance Tintosystem
          If fEmptyStr(Result) Or (Result = 'CT') Then
            Result := 'C';

          Exit;
        End;
      End;
    end;

    function GetSqlCadIteBaixa(const strItensBaixa: string): string;
    begin
      Try
        Try
          Result :=
            ' SELECT                                                                           ' +
            '   ' + IfThen(fCfgSIs('TIPABF') = '1', 'I', 'G') + '.ITE_CODABF                   ' +
            '   , ABF_CODSIT_SAI_CCO AS ABF_CODSIT                                             ' +
            '   , ITE_CODFOR                                                                   ' +
            '   , I.ITE_CODITE                                                                 ' +
            '   , ITE_CODMAR                                                                   ' +
            '   , ITE_CODUNI                                                                   ' +
            '   , ITE_DESITE                                                                   ' +
            '   , ITE_INCPIS                                                                   ' +
            '   , ITE_PESOIT                                                                   ' +
            '   , ITE_REFERE                                                                   ' +
            '   , ITE_SAL_ML                                                                   ' +
            '   , ITE_SALDOS                                                                   ' +
            '   , IF(I.ITE_CNV_ML <= 0 OR I.ITE_CNV_ML IS NULL, 1, I.ITE_CNV_ML) AS ITE_FATTIN ' +
            ' FROM                                                                             ' +
            '   CADITE I                                                                       ' +
            '   INNER JOIN ITEGER G                                                            ' +
            '     ON I.ITE_CODITE = G.ITE_CODITE                                               ' +
            '   INNER JOIN ABFICM A                                                            ' +
            '     ON ' + IfThen(fCfgSIs('TIPABF') = '1', 'I', 'G') + '.ITE_CODABF = A.ABF_CODABF                                               ' +
            ' WHERE ABF_ESTADO = :ESTADO AND (                                                     ';

            Result := Result + ' I.ITE_CODITE = ' + QuotedStr(strItensBaixa);

            Result := Trim(Result);
            Result := Result +
              ')   AND G.ITE_CODEMP = :CODEMP ';
        Except
          on E: Exception do
          begin
            raise;
          end;
        End;
      Finally

      End;
    end;

begin
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
  qryGenIte := fCriaQuery(Nil);

  If ((strEspDoc = 'IF') And (fCfgSis('USNFCE', varBoolean) Or fUsaSat)) Then
    strSerie := fCfgSis('SERNFC')
  Else
    strSerie := fCfgSis('SERFSC');

  stlDetMls := TStringList.Create;
  stlDetMls.Clear;

  Result := True;
  {*******************************************}
  {* REALIZA TRANSFERENCIA DE SALDO EM ML    *}
  {****************************************MV*}
  For intContador := Low(arrBaixaPigmentos) To High(arrBaixaPigmentos) Do
  Begin

    If fEmptyStr(arrBaixaPigmentos[intContador].strCodIte) Then
      Break;

    arrBaixaPigmentos[intContador].fltQtdBaixa := arrBaixaPigmentos[intContador].fltQtdBaixa * fltQtdBaixar;

    strSQL := GetSqlCadIteBaixa(arrBaixaPigmentos[intContador].strCodIte);

    {*******************************************}
    {* PEGA DADOS DO ITEM PARA BAIXAR SALDO E  *}
    {* GRAVAR MOVDET                           *}
    {****************************************MV*}
    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := strCliEst;
      Open;
    End;

  {$IFNDEF LINUX}
    fltSal_Ml := 0.0;
  {$ENDIF}
    fltSaldos := 0.0;

    If fEmptyStr(qryGenIte.FieldByName('ITE_CODABF').AsString) Then
    Begin
      Raise Exception.Create('Produto ' + arrBaixaPigmentos[intContador].strCodIte + ' não está com o ' +
                             'código da abreviação fiscal preenchido no cadastro de produtos. Verifique.');
    End;

    If qryGenIte.FieldByName('ITE_FATTIN').AsFloat <= 0 Then
    Begin
      Raise Exception.Create('Produto ' + qryGenIte.FieldByName('ITE_CODITE').AsString + '-' +
                                          qryGenIte.FieldByName('ITE_DESITE').AsString + ' está com fator ' +
                                          'tintométrico configurado incorretamente. Verifique.');
    End;

    If qryGenIte.FieldByName('ITE_SAL_ML').AsFloat <= 0 Then
    Begin

      intCont := 1;
      While True Do
      Begin

        fltSal_Ml := (intCont * qryGenIte.FieldByName('ITE_FATTIN').AsFloat);
        If (fltSal_Ml + qryGenIte.FieldByName('ITE_SAL_ML').AsFloat > 0.0) Then
        Begin
          fltSaldos := intCont;
          Break;
        End;

        Inc(intCont);

      End;

      If (fltSaldos <= 0.0) {Or (fltSaldos > qryGenIte.FieldByName('ITE_SALDOS').AsFloat)} Then
      Begin
        qryGenIte.Next;
        Continue;
      End;

      {*******************************************}
      {* SOMA SALDO DE ML                        *}
      {****************************************MV*}
      Result := fAtualizaEstoqueML(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                   -fltSal_Ml,
                                   fGetNumeroLote,
                                   objReplTinta);

      If (Not Result) Then
        Break;

    End;

    {*******************************************}
    {* ALIMENTO A VARIÁVEL QUE IRÁ GRAVAR A    *}
    {* QUANTIDADE QUE FOI BAIXADA NO ESTOQUE NO*}
    {* REGISTRO DO TIPO "ML".                  *}
    {****************************************MV*}
    fltQtdBaixarSalMl := fRetSalMlBaixar(qryGenIte.FieldByName('ITE_CODITE').AsString, intContador);

    {*******************************************}
    {* GRAVA MOVGER/MOVDET PARA SALDO EM ML    *}
    {****************************************MV*}

    If (fEmptyStr(strNumDocML)) Then
    Begin

      strNumDocML := fRetSequencial('PRO_ML', VS_strCodEmp, fTamDocCadRec);

      strAutIncML := StringOfChar(' ', 20);

      Result := fGravaMovGer(strAutIncML,                                                 // Auto Incremento (Retorno)
                             strNumDocML,                                                 // Numero Documento
                             'ML',                                                      // Espécie
                             VS_strCodEmp,                                              // Empresa
                             strCodTra,                                        // Transportadora
                             strCodVen,                                        // Vendedor
                             '',                                                        // Fornecedor
                             strCodCli,                                        // Cliente
                             'C',                                                       // Tipo ((C)liente / (F)ornecedor)
                             VS_Date,                                                   // Data da Entrada
                             fTime(),                                                   // Hora da Entrada
                             VS_Date,                                                   // Data do Documento
                             strConPag,                                        // Condição de Pagamento
                             strCliEst,                                        // Estado do Cliente / Fornecedor
                             IIF(fEmptyStr(strCliNom), '', strCliNom), // Nome do Consumidor
                             strCliEnd,                                        // Endereço do Consumidor
                             strCliBai,                                        // Bairro do Consumidor
                             strCliCep,                                        // Cep do Consumidor
                             strCodCid,                                        // Cidade do Consumidor
                             strCliEst,                                        // Estado do Consumidor
                             strCliTel,                                        // Telefone do Consumidor
                             0,
                             IntToStr(intCgcCpf),                              // CNPJ / CGC
                             strCliCgc,                                        // CNPJ / CGC do consumidor
                             strCliIes,                                        // Inscrição estadual do Consumidor
                             strCli_Rg,                                        // Rg do Consumidor
                             0.0,                                                       // Base Simples Paulista
                             0.0,                                                       // Base de IPI
                             0.0,                                                       // Aliquota de IPI
                             0.0,                                                       // Total de IPI
                             0.0,                                                       // Base de ICMS
                             0.0,                                                       // Aliquota de ICMS
                             0.0,                                                       // Total de ICMS
                             0.0,                                                       // Valor de Substituição
                             0.0,                                                       // Aliquota de Substituição
                             0.0,                                                       // Base de Substituição
                             0.0,                                                       // Desconto Especial
                             0.0,                                                       // Valor Contábil
                             0.0,                                                       // Total dos Itens
                             0.0,                                                       // Total de Custo
                             0.0,                                                       // Total de Custo
                             0.0,                                                       // Total Médio
                             '',                                                        // Tipo de Frete
                             0.0,                                                       // Valor do Frete
                             0.0,                                                       // Peso Bruto
                             0.0,                                                       // Peso Liquido
                             0,                                                         // Volume
                             '',                                                        // Especie
                             '',                                                        // Marca
                             '',                                                        // Mensagem 1
                             '',                                                        // Mensagem 2
                             '',                                                        // Mensagem 3
                             '',                                                        // Mensagem 4
                             '',                                                        // Mensagem 5
                             True,                                                      // Indica se Faturado ou nao
                             strEspDoc,                                                      // Tipo de Faturamento
                             strNumDoc,                                        // Numero de Faturamento
                             strCodEmp,                                        // Empresa do Faturamento
                             VS_Date,                                                   // Data de Faturamento
                             strCodVen,                                        // Vendedor do Faturamento
                             strConPag,                                        // Condição de Pagamento do Faturamento
                             False,                                                     // Devolução Especial
                             0.0,                                                       // Valor do Faturamento
                             0.0,                                                       // Valor Parcela 01
                             0.0,                                                       // Valor Parcela 02
                             0.0,                                                       // Valor Parcela 03
                             0.0,                                                       // Valor Parcela 04
                             0.0,                                                       // Valor Parcela 05
                             0.0,                                                       // Valor Parcela 06
                             0.0,                                                       // Valor Parcela 07
                             0.0,                                                       // Valor Parcela 08
                             0.0,                                                       // Valor Parcela 09
                             0.0,                                                       // Valor Parcela 10
                             0.0,                                                       // Valor Parcela 11
                             0.0,                                                       // Valor Parcela 12
                             arrDuplic,                                                 // arrDuplic
                             strSerie,                                                  // Série
                             IIF(blnNotEsp Or blnCupEsp, 'S', 'N'),                         // Nota Especial
                             fRetClaFisColorante,                              // Classificação Fiscal
                             strClaFi2,                                        // Classificação Fiscal 2
                             strClaFi3,                                        // Classificação Fiscal 3
                             strDesCla,                                        // Natureza da Operação
                             fltPorDes,                                        // Percentual de Desconto
                             strCodDig,                                        // Código do Digitador
                             strCodCnd,                                        // Código da Condicao
                             strCodFpg,                                        // Código da Forma de Pagamento
                             fltFatNot,                                        // Fator para meia nota
                             recServicos,
                             0.0,                                                       // Despesa acessória
                             'V',                                                       // Origem do Documento (V)enda (D)evolução
                             'N',                                                       // Usa controle de entrega
                             strCodRep,                                                 // Representante
                             0.0,                                                       // Aliquota do IRPF (SERVIÇO)
                             0.0,                                                       // Valor do IRPF (SERVIÇO + PRODUTO)
                             0.0,                                                       // Aliquota do Pis (SERVIÇO)
                             0.0,                                                       // Valor do Pis (SERVIÇO + PRODUTO)
                             0.0,                                                       // Aliquota do Cofins (SERVIÇO)
                             0.0,                                                       // Valor do Cofins (SERVIÇO + PRODUTO)
                             0.0,                                                       // Aliquota do CSLL (SERVIÇO)
                             0.0,                                                       // Valor do CSLL (SERVIÇO + PRODUTO)
                             0.0,                                                       // Valor de IRPF que foi retido
                             0.0,                                                       // Valor de PIS que foi retido
                             0.0,                                                       // Valor de COFINS que foi retido
                             0.0,                                                       // Valor de CSLL que foi retido
                             '',                                                        // Notas de Documentos Acumulados
                             0.0,                                                       // Aliquota do IRPF (PRODUTOS)
                             0.0,                                                       // Aliquota do PIS (PRODUTOS)
                             0.0,                                                       // Aliquota do COFINS (PRODUTOS)
                             0.0,                                                       // Aliquota do CSLL (PRODUTOS)
                             0.0,                                                       // Valor de SERVIÇO que foi retido
                             '',                                                        // Notas de documentos acumulados (SERVIÇO)
                             0.0,                                                       // Percentual da Seguridade Social
                             0.0,                                                       // Valor da Seguridade Social
                             0.0,                                                       // Valor do IRPF Retido (Produto)
                             0.0,                                                       // Valor do IRPF Devido (Produto)
                             0.0,                                                       // Valor do IRPF Retido (Serviço)
                             0.0,                                                       // Valor do IRPF Devido (Serviço)
                             0.0,                                                       // Valor do PIS Retido (Produto)
                             0.0,                                                       // Valor do PIS Devido (Produto)
                             0.0,                                                       // Valor do PIS Retido (Serviço)
                             0.0,                                                       // Valor do PIS Devido (Serviço)
                             0.0,                                                       // Valor do COFINS Retido (Produto)
                             0.0,                                                       // Valor do COFINS Devido (Produto)
                             0.0,                                                       // Valor do COFINS Retido (Serviço)
                             0.0,                                                       // Valor do COFINS Devido (Serviço)
                             0.0,                                                       // Valor do CSLL Retido (Produto)
                             0.0,                                                       // Valor do CSLL Devido (Produto)
                             0.0,                                                       // Valor do CSLL Retido (Serviço)
                             0.0,                                                       // Valor do CSLL Devido (Serviço)
                             '',
                             0.0,                                                       // Base Orgão Público
                             0.0,                                                       // ICMS Orgão Público
                             0,                                                         // Número do Conhecimento de Frete
                             strCliCon,                                                 // Consumidor final
                             strEntFat,                                                 // Entrega no faturamento
                             strCliFat,                                                 // Cliente de Faturamento
                             strOpeExp,                                                 // Operador da Expedição
                             '',                                                        // Separador da Expedição
                             strTabPre,                                                 // Tabela de precos utilizada
                             '',
                             'N',       // Entrega Futura
                             blnBaiEntFut,    // Baixa de Entrega Futura
                             fltMargem,       // Margem de Lucro
                             0.0,             // Base do retido (caso tivesse) com ipi e frete de entrada
                             0.0,             // Valor do retido considerando a base acima.
                             'N',             // Gerar produção fora da loja
                             '',
                             VS_Date,        // Data de Entrega no Romaneio
                             '',             // Classificação fiscal 4
                             'N',            // AUTO-SERVIÇO
                             '',             //Codigo do Evento
                             '',             // ENDEREÇO DE ENTREGA
                             '',             // Conteúdo do CNFNFE
                             '',             // Motivo da Devolução
                             '',
                             True);          // Imprime Duplicatas na NF-e


      If (Not Result) Then
        Break;

    End;

    strAutIncTmp := StringOfChar(' ', 20);

    Result := fGravaMovDet(strAutIncTmp,
                           strAutIncML,
                           IfThen(fGetTipoComponente(qryGenIte.FieldByName('ITE_CODITE').AsString) = 'C', strNumDocML, strNumDoc) ,
                           IfThen(fGetTipoComponente(qryGenIte.FieldByName('ITE_CODITE').AsString) = 'C', 'ML', strEspDoc),
                           VS_strCodEmp,
                           qryGenIte.FieldByName('ITE_CODITE').AsString,
                           strCodVen,
                           strCodDiv,
                           qryGenIte.FieldByName('ITE_CODMAR').AsString,
                           '',
                           strCodCli,
                           VS_Date,
                           fTime(),
                           VS_Date,
                           strConPag,
                           'C',
                           strCliEst,
                           qryGenIte.FieldByName('ITE_DESITE').AsString,
                           qryGenIte.FieldByName('ITE_REFERE').AsString,
                           qryGenIte.FieldByName('ITE_CODUNI').AsString,
                           qryGenIte.FieldByName('ITE_CODFOR').AsString,
                           fltQtdBaixarSalMl,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           strCodRep,
                           strCodVe2,
                           0.0,
                           0.0,
                           0.0,
                           fRetClaFisColorante,
                           qryGenIte.FieldByName('ABF_CODSIT').AsString,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           True,
                           strEspDoc,
                           strNumDoc,
                           strCodEmp,       // Empresa do Faturamento
                           VS_Date,
                           strCodVen,
                           strConPag,
                           0.0,
                           strIdePro,
                           qryGenIte.FieldByName('ITE_INCPIS').AsString,
                           strSerie,
                           0.0,
                           IIF(blnNotEsp Or blnCupEsp, 'S', 'N'),
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0.0,
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0.0,
                           'N',
                           strCodDig,
                           strCodCnd,
                           strCodFpg,
                           '',
                           '',
                           0,
                           'N',
                           '',
                           0.0,
                           '',
                           'V',
                           '',
                           '',
                           '',
                           0,
                           '',
                           '',
                           strCliFat,
                           0,
                           0,
                           0.0,
                           strCodAca,
                           strEmpAca,
                           False,
                           False,
                           '',
                           '',
                           '',
                           strTabPre, // Tabela de Preço
                           '',
                           '',
                           '',
                           '',
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0,
                           'N',
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           fGetNumeroLote,
                           'N',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           'P',
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           '',
                           'N',
                           'N',
                           0,
                           0,
                           0,
                           '',
                           'N',
                           0,
                           '',
                           0,
                           'N',
                           '',
                           'NOR',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           'N',
                           '',
                           '',
                           0,
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           'N',
                           '',
                           'N',
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           False,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           '',
                           0,
                           0,
                           '',
                           '',
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           False,
                           '',
                           '',
                           '',
                           '',
                           False,
                           '',
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           False,
                           0,
                           0,
                           0,
                           0,
                           0,
                           'N',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           'N',
                           '',
                           '',
                           '',
                           0,
                           0,
                           False,
                           True,
                           False,
                           '',
                           0,
                           '',
                           0,
                           '',
                           '',
                           '',
                           'N',
                           '',
                           '',
                           0,
                           0,
                           strEntFut);

    If (Not Result) Then
      Break;

    stlDetMls.Add(strAutIncTmp);

    {*******************************************}
    {* GRAVA MOVGER/MOVDET PARA TRANSFERENCIA  *}
    {* DE SALDO EM ML                          *}
    {****************************************MV*}
    If (fltSaldos > 0.0) Then
    Begin

      If (fEmptyStr(strNumDocTM)) Then
      Begin

        strNumDocTM := fRetSequencial('PRO_TM', VS_strCodEmp, fTamDocCadRec);

        strAutIncTM := StringOfChar(' ', 20);

        Result := fGravaMovGer(strAutIncTM,                                                                      // Auto Incremento (Retorno)
                               strNumDocTM,                                                                      // Numero Documento
                               'TM',                                                                           // Espécie
                               VS_strCodEmp,                                                                   // Empresa
                               strCodTra,                                                             // Transportadora
                               strCodVen,                                                             // Vendedor
                               '',                                                                             // Fornecedor
                               strCodCli,                                                             // Cliente
                               'C',                                                                            // Tipo ((C)liente / (F)ornecedor)
                               VS_Date,                                                                        // Data da Entrada
                               fTime(),                                                                        // Hora da Entrada
                               VS_Date,                                                                        // Data do Documento
                               strConPag,                                                             // Condição de Pagamento
                               strCliEst,                                                             // Estado do Cliente / Fornecedor
                               IIF(fEmptyStr(strCliNom), '', strCliNom),                     // Nome do Consumidor
                               strCliEnd,                                                             // Endereço do Consumidor
                               strCliBai,                                                             // Bairro do Consumidor
                               strCliCep,                                                             // Cep do Consumidor
                               strCodCid,                                                             // Cidade do Consumidor
                               strCliEst,                                                             // Estado do Consumidor
                               strCliTel,                                                             // Telefone do Consumidor
                               0,
                               IntToStr(intCgcCpf),                                                   // CNPJ / CGC
                               strCliCgc,                                                             // CNPJ / CGC do consumidor
                               strCliIes,                                                             // Inscrição estadual do Consumidor
                               strCli_Rg,                                                             // Rg do Consumidor
                               0.0,                                                                            // Base Simples Paulista
                               0.0,                                                                            // Base de IPI
                               0.0,                                                                            // Aliquota de IPI
                               0.0,                                                                            // Total de IPI
                               0.0,                                                                            // Base de ICMS
                               0.0,                                                                            // Aliquota de ICMS
                               0.0,                                                                            // Total de ICMS
                               0.0,                                                                            // Valor de Substituição
                               0.0,                                                                            // Aliquota de Substituição
                               0.0,                                                                            // Base de Substituição
                               0.0,                                                                            // Desconto Especial
                               0.0,                                                                            // Valor Contábil
                               0.0,                                                                            // Total dos Itens
                               0.0,                                                                            // Total de Custo
                               0.0,                                                                            // Total de Custo
                               0.0,                                                                            // Total Médio
                               '',                                                                             // Tipo de Frete
                               0.0,                                                                            // Valor do Frete
                               0.0,                                                                            // Peso Bruto
                               0.0,                                                                            // Peso Liquido
                               0,                                                                              // Volume
                               '',                                                                             // Especie
                               '',                                                                             // Marca
                               '',                                                                             // Mensagem 1
                               '',                                                                             // Mensagem 2
                               '',                                                                             // Mensagem 3
                               '',                                                                             // Mensagem 4
                               '',                                                                             // Mensagem 5
                               True,                                                                           // Indica se Faturado ou nao
                               strEspDoc,                                                                           // Tipo de Faturamento
                               strNumDoc,                                                             // Numero de Faturamento
                               strCodEmp,                                                             // Empresa do Faturamento
                               VS_Date,                                                                        // Data de Faturamento
                               strCodVen,                                                             // Vendedor do Faturamento
                               strConPag,                                                             // Condição de Pagamento do Faturamento
                               False,                                                                          // Devolução Especial
                               0.0,                                                                            // Valor do Faturamento
                               0.0,                                                                            // Valor Parcela 01
                               0.0,                                                                            // Valor Parcela 02
                               0.0,                                                                            // Valor Parcela 03
                               0.0,                                                                            // Valor Parcela 04
                               0.0,                                                                            // Valor Parcela 05
                               0.0,                                                                            // Valor Parcela 06
                               0.0,                                                                            // Valor Parcela 07
                               0.0,                                                                            // Valor Parcela 08
                               0.0,                                                                            // Valor Parcela 09
                               0.0,                                                                            // Valor Parcela 10
                               0.0,                                                                            // Valor Parcela 11
                               0.0,                                                                            // Valor Parcela 12
                               arrDuplic,                                                                      // arrDuplic
                               strSerie,                                                                       // Série
                               IIF(blnNotEsp Or blnCupEsp, 'S', 'N'),                                              // Nota Especial
                               fRetClaFisColorante,                                                   // Classificação Fiscal
                               strClaFi2,                                                             // Classificação Fiscal 2
                               strClaFi3,                                                             // Classificação Fiscal 3
                               strDesCla,                                                             // Natureza da Operação
                               fltPorDes,                                                             // Percentual de Desconto
                               strCodDig,                                                             // Código do Digitador
                               strCodCnd,                                                             // Código da Condicao
                               strCodFpg,                                                             // Código da Forma de Pagamento
                               fltFatNot,                                                             // Fator para meia nota
                               recServicos,
                               0.0,                                                                            // Despesa acessória
                               'V',                                                                            // Origem do Documento (V)enda (D)evolução
                               'N',                                                                            // Usa controle de entrega
                               strCodRep,                                                                      // Representante
                               0.0,                                                                            // Aliquota do IRPF (SERVIÇO)
                               0.0,                                                                            // Valor do IRPF (SERVIÇO + PRODUTO)
                               0.0,                                                                            // Aliquota do Pis (SERVIÇO)
                               0.0,                                                                            // Valor do Pis (SERVIÇO + PRODUTO)
                               0.0,                                                                            // Aliquota do Cofins (SERVIÇO)
                               0.0,                                                                            // Valor do Cofins (SERVIÇO + PRODUTO)
                               0.0,                                                                            // Aliquota do CSLL (SERVIÇO)
                               0.0,                                                                            // Valor do CSLL (SERVIÇO + PRODUTO)
                               0.0,                                                                            // Valor de IRPF que foi retido
                               0.0,                                                                            // Valor de PIS que foi retido
                               0.0,                                                                            // Valor de COFINS que foi retido
                               0.0,                                                                            // Valor de CSLL que foi retido
                               '',                                                                             // Notas de Documentos Acumulados
                               0.0,                                                                            // Aliquota do IRPF (PRODUTOS)
                               0.0,                                                                            // Aliquota do PIS (PRODUTOS)
                               0.0,                                                                            // Aliquota do COFINS (PRODUTOS)
                               0.0,                                                                            // Aliquota do CSLL (PRODUTOS)
                               0.0,                                                                            // Valor de SERVIÇO que foi retido
                               '',                                                                             // Notas de documentos acumulados (SERVIÇO)
                               0.0,                                                                            // Percentual da Seguridade Social
                               0.0,                                                                            // Valor da Seguridade Social
                               0.0,                                                                            // Valor do IRPF Retido (Produto)
                               0.0,                                                                            // Valor do IRPF Devido (Produto)
                               0.0,                                                                            // Valor do IRPF Retido (Serviço)
                               0.0,                                                                            // Valor do IRPF Devido (Serviço)
                               0.0,                                                                            // Valor do PIS Retido (Produto)
                               0.0,                                                                            // Valor do PIS Devido (Produto)
                               0.0,                                                                            // Valor do PIS Retido (Serviço)
                               0.0,                                                                            // Valor do PIS Devido (Serviço)
                               0.0,                                                                            // Valor do COFINS Retido (Produto)
                               0.0,                                                                            // Valor do COFINS Devido (Produto)
                               0.0,                                                                            // Valor do COFINS Retido (Serviço)
                               0.0,                                                                            // Valor do COFINS Devido (Serviço)
                               0.0,                                                                            // Valor do CSLL Retido (Produto)
                               0.0,                                                                            // Valor do CSLL Devido (Produto)
                               0.0,                                                                            // Valor do CSLL Retido (Serviço)
                               0.0,                                                                            // Valor do CSLL Devido (Serviço)
                               '',                                                                             // Ordem de Produção
                               0.0,                                                                            // Base Orgão Público
                               0.0,                                                                            // ICMS Orgão Público
                               0,                                                                              // Número do Conhecimento de Frete
                               strCliCon,                                                                      // Consumidor final
                               strEntFat,                                                                      // Entrega no faturamento
                               strCliFat,                                                                      // Cliente de Faturamento
                               strOpeExp,                                                                      // Operador da Expedição
                               '',                                                                             // Separador da Expedição
                               strTabPre,                                                                      // Tabela de precos utilizada
                               '',
                               'N',       // Entrega Futura
                               blnBaiEntFut,    // Baixa de Entrega Futura
                               fltMargem,       // Margem de Lucro
                               0.0,             // Base do retido (caso tivesse) com ipi e frete de entrada
                               0.0,             // Valor do retido considerando a base acima.
                               'N',             // Gerar produção fora da loja
                               '',
                               VS_Date,         // Data de Entrega no Romaneio
                               '',              // Classificação fiscal 4
                               'N',             // AUTO-SERVIÇO
                               '',              //Codigo do Evento
                               '',              // ENDEREÇO DE ENTREGA
                               '',              // Conteúdo do CNFNFE
                               '',              // Motivo da Devolução
                               '',
                               True);           // Imprime Duplicatas na NF-e


        If (Not Result) Then
          Break;

      End;

      strAutIncTmp := StringOfChar(' ', 20);

      Result := fGravaMovDet(strAutIncTmp,
                             strAutIncTM,
                             strNumDocTM,
                             'TM',
                             VS_strCodEmp,
                             qryGenIte.FieldByName('ITE_CODITE').AsString,
                             strCodVen,
                             strCodDiv,
                             qryGenIte.FieldByName('ITE_CODMAR').AsString,
                             '',
                             strCodCli,
                             VS_Date,
                             fTime(),
                             VS_Date,
                             strConPag,
                             'C',
                             strCliEst,
                             qryGenIte.FieldByName('ITE_DESITE').AsString,
                             qryGenIte.FieldByName('ITE_REFERE').AsString,
                             qryGenIte.FieldByName('ITE_CODUNI').AsString,
                             qryGenIte.FieldByName('ITE_CODFOR').AsString,
                             fltSaldos,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             strCodRep,
                             strCodVe2,
                             0.0,
                             0.0,
                             0.0,
                             fRetClaFisColorante,
                             qryGenIte.FieldByName('ABF_CODSIT').AsString,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             qryGenIte.FieldByName('ITE_PESOIT').AsFloat * fltSaldos,
                             0.0,
                             0.0,
                             True,
                             strEspDoc,
                             strNumDoc,
                             strCodEmp,   // Empresa do Faturamento
                             VS_Date,
                             strCodVen,
                             strConPag,
                             0.0,
                             strIdePro,
                             qryGenIte.FieldByName('ITE_INCPIS').AsString,
                             strSerie,
                             0.0,
                             IIF(blnNotEsp Or blnCupEsp, 'S', 'N'),
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             'N',
                             strCodDig,
                             strCodCnd,
                             strCodFpg,
                             '',
                             '',
                             0,
                             'N',
                             '',
                             0.0,
                             '',
                             'V',
                             '',
                             '',
                             '',
                             0,
                             '',
                             '',
                             strCliFat,
                             0,
                             0,
                             0.0,
                             '',
                             '',
                             False,
                             True, //Filkar
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             'N',
                             '',
                             0,
                             0,
                             0,
                             0,
                             '',
                             fGetNumeroLote,
                             'N',
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0);

      If (Not Result) Then
        Break;

      {*******************************************}
      {* ATUALIZA SALDO NORMAL                   *}
      {****************************************MV*}
      Result := fAtualizaEstoqueCadIte(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                       'S',
                                       fltSaldos,
                                       0.0,
                                       fGetNumeroLote,
                                       True,
                                       False,
                                       objReplTinta);

      If (Not Result) Then
        Break;

    End;

  End;

  FreeAndNil(qryGenIte);

end;

function fGravaForTin(strCodAca, strTexBas, strTipCor: String; intModDil: Integer; strEmpAca, strIteCob,
  strUniver: String; fltFatAce: Double; strCatali: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Clear;

  If Not fEmptyStr(strCodAca) Then
  Begin
    qryGen.SQL.Text := 'SELECT COUNT(*) QTD FROM FORTIN WHERE FOR_CODACA = :CODACA AND FOR_EMPACA = :CODEMP';
    qryGen.ParamByName('CODACA').AsString := strCodAca;
    qryGen.ParamByName('CODEMP').AsString := strEmpAca;
    qryGen.Open;

    If qryGen.FieldByName('QTD').AsInteger = 0 Then
    Begin
      qryGen.SQL.Clear;
      qryGen.SQL.Add('INSERT INTO FORTIN');
      qryGen.SQL.Add('            (AUTOINCREM,');
      qryGen.SQL.Add('             FOR_EMPACA,');
      qryGen.SQL.Add('             FOR_MODDIL,');
      qryGen.SQL.Add('             FOR_TEXBAS,');
      qryGen.SQL.Add('             FOR_TIPCOR,');
      qryGen.SQL.Add('             FOR_ITECOB,');
      qryGen.SQL.Add('             FOR_UNIVER,');
      qryGen.SQL.Add('             FOR_FATACE,');
      qryGen.SQL.Add('             FOR_CODACA,');
      qryGen.SQL.Add('             FOR_CATALI) ');
      qryGen.SQL.Add('VALUES (:AUTOI,');
      qryGen.SQL.Add('        :CODEMP,');
      qryGen.SQL.Add('        :MODDIL,');
      qryGen.SQL.Add('        :TEXBAS,');
      qryGen.SQL.Add('        :TIPCOR,');
      qryGen.SQL.Add('        :ITECOB,');
      qryGen.SQL.Add('        :UNIVER,');
      qryGen.SQL.Add('        :FATACE,');
      qryGen.SQL.Add('        :CODACA,');
      qryGen.SQL.Add('        :CATALI);');

      qryGen.ParamByName('AUTOI').AsString := fRetAutoIncrem('FORTIN', VS_strCodEmp);
      qryGen.ParamByName('CODEMP').AsString := strEmpAca;
      qryGen.ParamByName('MODDIL').AsInteger := intModDil;
      qryGen.ParamByName('TEXBAS').AsString := strTexBas;
      qryGen.ParamByName('TIPCOR').AsString := strTipCor;
      If fEmptyStr(strIteCob) Then
        qryGen.ParamByName('ITECOB').Value := Null
      Else
        qryGen.ParamByName('ITECOB').AsString := strIteCob;
      qryGen.ParamByName('UNIVER').AsString := strUniver;
      qryGen.ParamByName('FATACE').AsFloat  := fltFatAce;
      qryGen.ParamByName('CODACA').AsString := strCodAca;
      qryGen.ParamByName('CATALI').AsString := strCatali;
      qryGen.ExecSQL;
    End;
  End;

  FreeAndNil(qryGen);
  Result := True;
end;

end.

