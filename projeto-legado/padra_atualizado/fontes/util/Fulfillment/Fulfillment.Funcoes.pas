unit Fulfillment.Funcoes;

interface

uses
  Classes, Uni, untFuncFat, untFuncoesSimples, System.SysUtils, untCadLote,
  System.StrUtils, Shared.Functions.DataSet, untTypesSistema, untEnderecamentoProduto,
  UniClientDataSet, Data.DB, Winapi.Windows, System.Variants,

  Fulfillment.Types,
  Fulfillment.Constantes,
  FulFillment.Classes,
  Fulfillment.Classes.NotaFiscal,
  Fulfillment.Classes.Parametros;

  function ExisteJsonPedidoMercadoLivre(AChave: String): Boolean;
  function GetValorTaxaMercadoLivre(AChave: String): Double;
  function GetValorFreteDescontadoMercadoLivre(AChave: String): Double;
  function GetValorFreteCompradorMercadoLivre(AChave: String): Double;
  function PedidoVinculadoFoiBaixado(ANumDoc, AEspDoc, ACodEmp: String): Boolean;
  function RetMSGImpossibilidadeDeImportarRetornoSimbolico(AChaveDeAcesso: String): String;

  function RetImportouDocumentoDeReferencia(AChaveDeAcesso : String) : Boolean;
  function ExisteDocumentoReferenciadoFulFillment(const AChaAce: String): Boolean;
  function ExisteAlgumDocumentoReferenciando(const AChaAce : String) : Boolean;
  function DocumentoEstaReferenciando(const AChaAce : String) : Boolean;

  function ValidaSaldoItem(ACodIte, ACodExt: String; AQtdIte: Double; ASalExt: Boolean; out ANumLot: String): Boolean;
  function NotaSaidaSimbolicaRefTransferenciaEntreDepositosMercadoLivre(AChave: String): Boolean;
  function NotaSaidaSimbolicaRefRetornoMercadoriaNaoEntregueMercadoLivre(AChave: String): Boolean;
  function RetCodigoDescricaoEQtdItensNota(ANFe: TNotaFiscal) : String;
  function ExistePedidoParaBaixaDosLotes(ACodIte, ACodExt: String; AItemNota: TItemNota; ANFe: TNotaFiscal; var LFatDor: IMyCampoTabela; AEhEstruturaBaixandoFilhos : Boolean = False; ATituloLote : String = '';  AHubMkp: String = ''): Boolean;
  function GetQtdItemNFe(AItem: TItemNota; ANFe: TNotaFiscal): Double;
  function InsereCidade(AIBGE, AUF: String): String;
  function DocumentoJaImportado(AChave : String): Boolean;
  function DocumentoJaImportadoECancelado(AChave : String): Boolean;
  function NotaFiscalDenegada(ANota: TNotaFiscal): Boolean;
  function UsaPainelWebCitel : Boolean;
  function EstoqueExternoTemClienteVinculado(ACodEst : String) : Boolean;
  function ClienteVinculadoTemEstoqueExterno(ACodCli : String) : Boolean;
  function TemEstoqueExternoVinculado(ACodEst : String) : Boolean;
  function MSGSemCodigoEstoqueExterno(ANumDoc, AEspDoc : String) : String;
  function MSGEstoqueExternoSemClienteVinculado(ANumDoc, AEspDoc : String) : String;

  function GerarPedidoDeEnderecamento(const ANFEIMP             : TUniQuery;
                                            AOpcGeracao         : TFulfillmentOpcGeracaoPDEndereca;
                                            AValidaRegraSemLote : Boolean = False;
                                            ACodigoDoItem       : String  = '') : Boolean;

  function NFEIMP_EstaProcessando(const AAcesso, AStatus : String) : Boolean;
  function RetornaEstrutura(ACodPai: String): TUniQuery;
  function FulfillmentUtilizaMultiplosRobosImportacao : Boolean;
  function FulfillmentQtdRobosImportacao : Integer;
  function FulfillmentQtdRobosExecutando : Integer;
  function UtilizaFulfillment(AHubMkp: String): Boolean;
  function CfgFulFillment(ACodCfg, AHubMkp: String; ACodEmp: String = ''): String;
  function ValidaPedidoDeVenda: Boolean;
  function GetValorCupomDescontoMercadoLivre(AChave: String): Double;
  function EhNaturezaDeRetirada(ANaturezaDeOperacao : String) : Boolean;
  function LoteEhFulfillment(ANumLot, ACodEmp, ACodIte : String) : Boolean;
  function ModeloDeMovimentacaoDeSaldo : TFulfillmentModeloDeMovimentacao;
  function RetornaQueryDadosLOTDOR(ANumDoc, AEspDoc, AEmpDoc, ACodIte : String) : TUniQuery;
  function PossuiRegistroNaTabelaESTEXT(ACodIte, ACodEmp, ACodEEE : String) : Boolean;
  function CFOPs_Fulfillment(AHubMkp : String) : String;
  function CfgSisFul(AConfiguracao, AHubMkp : String; AEmpresa : String = '') : String;
  function FulfillmentGuardar : Boolean;

  procedure CarregarCliente(AFatVenda: TFatVenda; ACodigo: String);
  procedure MarcarDocParaGerarPDReservaEstoque(AAcesso, AStatus : String);
  procedure GravaLogNFE(ANota: TNotaFiscal);
  procedure MarcarIncGor(const AendDocumento  : TEndDocumento; AChaAce : String);
  procedure CriaDataSetItensTL(var ACds: TUniClientDataSet);
  procedure FulfillmentLimparNFEIMP_PROCESSANDO;
  procedure ReenviaDocumentoParaProcessamento(AChave: String);

implementation

uses untFuncoes, untInterfaces;

function RetornaEstrutura(ACodPai: String): TUniQuery;
begin
  Result := fCriaQuery;

  Result.SQL.Add('SELECT DMT_ITESUB, DMT_QTDITE ');
  Result.SQL.Add('FROM GERMAT ');
  Result.SQL.Add('INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM ');
  Result.SQL.Add('WHERE GMT_CODITE = :CODITE');

  Result.ParamByName('CODITE').AsString := ACodPai;
  Result.Open;
end;

function FulfillmentUtilizaMultiplosRobosImportacao : Boolean;
begin
  Result := fCfgSis('MULROB', varBoolean);
end;

function FulfillmentQtdRobosImportacao : Integer;
begin
  Result := fCfgSis('QTDROB', varInteger);
end;

function FulfillmentQtdRobosExecutando : Integer;
  Const
    IMPORTA_FULFILLMENT_POR_CONEXAO_ = 'IMPORTA-FULFILLMENT-POR-CONEXAO_';
  Var
    qryLock: TUniQuery;
Begin

  qryLock := fCriaQuery(Nil);

  Try
    qryLock.SQL.Add('SELECT SQL_NO_CACHE COUNT(0) FROM LCKATC WHERE LCK_CHAACE LIKE "%' + IMPORTA_FULFILLMENT_POR_CONEXAO_ + '%" ');
    qryLock.Open;
    Result := qryLock.Fields[0].AsInteger;
  Finally
    FreeAndNil(qryLock);
  End;

end;

function UtilizaFulfillment(AHubMkp: String): Boolean;
begin

  If Not fCampoExiste('FULL_CFGSIS', 'SIS_HUBMKP') Then
    Exit(AHubMkp.Equals('MLB'));

  Result := fCampoTabela('COUNT(0)', 'FULL_CFGSIS', ['SIS_CODEMP', 'SIS_HUBMKP'], [VS_strCodEmp, AHubMkp]) > 0;

end;

function CfgFulFillment(ACodCfg, AHubMkp: String; ACodEmp: String = ''): String;
Begin

  Result := fCampoTabela('SIS_VALCFG', 'FULL_CFGSIS',
                        ['SIS_CODCFG', 'SIS_CODEMP', 'SIS_HUBMKP'],
                        ['CFG_' + ACodCfg, IIF(ACodEmp.IsEmpty, VS_strCodEmp, ACodEmp), AHubMkp], False);

End;

function ExisteDocumentoReferenciadoFulFillment(const AChaAce: String): Boolean;
begin
  Result := fCampoTabela('NFE_ACESSO', 'NFEIMP', ['NFE_REFNFE'], [AChaAce]) <> '';
end;

function ValidaPedidoDeVenda: Boolean;
begin

  Result := False;

  If Not fCfgSis('FULSLO', varBoolean) Then
    Exit;

  Result := True;

end;

function GetValorCupomDescontoMercadoLivre(AChave: String): Double;
begin
  Result := fCampoTabela('NFE_CUPMKT', 'NFEMLB', ['NFE_ACESSO', 'NFE_STATUS'], [AChave, 'AT']);
end;

function EhNaturezaDeRetirada(ANaturezaDeOperacao : String) : Boolean;
begin

  Result := True;

  If AnsiUpperCase(fRemoveAcento(ANaturezaDeOperacao)).Equals(NOTA_DE_RETIRADA) Then
    Exit;

  If AnsiUpperCase(fRemoveAcento(ANaturezaDeOperacao)).Equals(NOTA_DE_RETORNO_SIMBOLICO_QUE_ACOMPANHA_A_VENDA) Then
    Exit;

  Result := False;

end;

function LoteEhFulfillment(ANumLot, ACodEmp, ACodIte : String) : Boolean;
  var
    LQry : TUniQuery;
begin

  Result := False;

  If fEmptyStr(ANumLot) Then
    Exit;

  If fEmptyStr(ACodEmp) Then
    Exit;

  If fEmptyStr(ACodIte) Then
    Exit;

  LQry := fCriaQuery;

  Try

    LQry.SQL.Add('SELECT       ');
    LQry.SQL.Add('  LOT_FULFIL ');
    LQry.SQL.Add('FROM         ');
    LQry.SQL.Add('  CADLOT     ');
    LQry.SQL.Add('WHERE        ');
    LQry.SQL.Add('  LOT_NUMLOT = :NUMLOT AND ');
    LQry.SQL.Add('  LOT_CODEMP = :CODEMP AND ');
    LQry.SQL.Add('  LOT_CODITE = :CODITE ');

    LQry.ParamByName('NUMLOT').AsString := ANumLot;
    LQry.ParamByName('CODEMP').AsString := ACodEmp;
    LQry.ParamByName('CODITE').AsString := ACodIte;
    LQry.Open;

    Result := (Not LQry.IsEmpty) And (LQry.FieldByName('LOT_FULFIL').AsString.Equals('S'));

  Finally
    FreeAndNil(LQry);
  End;

end;

function ModeloDeMovimentacaoDeSaldo : TFulfillmentModeloDeMovimentacao;
Begin
  Result := IIF(fCfgSis('MODFUL', varInteger) = 1, fmmQuantidadeSeparada, fmmGerarPedidoParaGuardarAsDiferencas);
End;

function RetornaQueryDadosLOTDOR(ANumDoc, AEspDoc, AEmpDoc, ACodIte : String) : TUniQuery;
  const
    SQL = 'SELECT        '+
          '  LDO_NUMLOT AS NUMLOT, '+
          '  LDO_QTDITE AS QTDITE, '+
          '  LDO_QTDSEP AS QTDSEP  '+
          'FROM          '+
          '  LOTDOR      '+
          'WHERE         '+
          '  LDO_SEQFDO IN (SELECT       '+
          '                   AUTOINCREM '+
          '                 FROM         '+
          '                   FATDOR     '+
          '                 WHERE        '+
          '                   FDO_NUMDOC = :NUMDOC  AND '+
          '                   FDO_ESPDOC = :ESPDOC  AND '+
          '                   FDO_CODEMP = :CODEMP  AND '+
          '                   FDO_CODITE = :CODITE) AND (IFNULL(LDO_QTDSEP, 0) > 0) ';
Begin
  Result := fCriaQuery;
  Result.SQL.Add(SQL);
  Result.ParamByName('NUMDOC').AsString := ANumDoc;
  Result.ParamByName('ESPDOC').AsString := AEspDoc;
  Result.ParamByName('CODEMP').AsString := AEmpDoc;
  Result.ParamByName('CODITE').AsString := ACodIte;
  Result.Open;
End;

function PossuiRegistroNaTabelaESTEXT(ACodIte, ACodEmp, ACodEEE : String) : Boolean;
  var
    LEstExt : TUniQuery;
begin

  Result := False;

  If ACodIte.IsEmpty Then
    Exit;

  If ACodEmp.IsEmpty Then
    Exit;

  If ACodEEE.IsEmpty Then
    Exit;

  LEstExt := fCriaQuery(Nil);

  Try

    LEstExt.SQL.Add('SELECT            ');
    LEstExt.SQL.Add('  COUNT(*) AS TOT ');
    LEstExt.SQL.Add('FROM     ');
    LEstExt.SQL.Add('  ESTEXT ');
    LEstExt.SQL.Add('WHERE    ');
    LEstExt.SQL.Add('  EXT_CODITE = :CODITE AND ');
    LEstExt.SQL.Add('  EXT_CODEMP = :CODEMP AND ');
    LEstExt.SQL.Add('  EXT_CODEEE = :CODEEE');

    LEstExt.ParamByName('CODITE').AsString := ACodIte;
    LEstExt.ParamByName('CODEMP').AsString := ACodEmp;
    LEstExt.ParamByName('CODEEE').AsString := ACodEEE;
    LEstExt.Open;

    Result := (LEstExt.FieldByName('TOT').AsFloat > 0);

  Finally
    FreeAndNil(LEstExt);
  End;

end;

function CFOPs_Fulfillment(AHubMkp : String) : String;
  const
    CFOP_FULL = '_1949_2949_5949_6949_1999_5999_1907_2907_5905_6905_1102_2102_';
  var
    LCFOPs : TUniQuery;
begin

  LCFOPs := fCriaQuery(Nil);

  Try

    LCFOPs.SQL.Add('SELECT GROUP_CONCAT(DISTINCT FUL_CLAFIS SEPARATOR "_") AS CFOPS FROM ESTFUL WHERE FUL_HUBMKP = :HUBMKP ORDER BY FUL_CLAFIS');

    LCFOPs.ParamByName('HUBMKP').AsString := AHubMkp;
    LCFOPs.Open;

    Result := (IIF(Not LCFOPs.IsEmpty, LCFOPs.FieldByName('CFOPS').AsString, EmptyStr) + CFOP_FULL);

  Finally
    FreeAndNil(LCFOPs);
  End;

end;

function CfgSisFul(AConfiguracao, AHubMkp : String; AEmpresa : String = '') : String;
  Var
    LCfgSisFul : TUniQuery;
    LEmpresa   : String;
Begin

  LEmpresa := IIF(Not AEmpresa.IsEmpty, AEmpresa, VS_strCodEmp);

  LCfgSisFul := fCriaQuery(Nil);

  Try

    LCfgSisFul.SQL.Add('SELECT');
    LCfgSisFul.SQL.Add('  SIS_VALCFG');
    LCfgSisFul.SQL.Add('FROM');
    LCfgSisFul.SQL.Add('  FULL_CFGSIS');
    LCfgSisFul.SQL.Add('WHERE');
    LCfgSisFul.SQL.Add('  SIS_CODCFG = :CODCFG AND ');
    LCfgSisFul.SQL.Add('  SIS_CODEMP = :CODEMP AND ');
    LCfgSisFul.SQL.Add('  SIS_HUBMKP = :HUBMKP ');

    LCfgSisFul.ParamByName('CODCFG').AsString := ('CFG_' + AConfiguracao);
    LCfgSisFul.ParamByName('CODEMP').AsString := LEmpresa;
    LCfgSisFul.ParamByName('HUBMKP').AsString := AHubMkp;
    LCfgSisFul.Open;

    Result := IIF(Not LCfgSisFul.IsEmpty, LCfgSisFul.FieldByName('SIS_VALCFG').AsString, EmptyStr);

  Finally
    FreeAndNil(LCfgSisFul);
  End;

End;

function FulfillmentGuardar : Boolean;
  var
    LNumLot : String;
    LLocFis : String;
Begin

  LNumLot := fCfgSis('LTTAPC', varString);
  LLocFis := fCfgSis('LCTAPC', varString);

  Result := (Not fEmptyStr(LNumLot)) And (Not fEmptyStr(LLocFis));

End;

procedure FulfillmentLimparNFEIMP_PROCESSANDO;
  Var
    LLock : TUniQuery;
Begin

  LLock := fCriaQuery(Nil);

  Try

    LLock.SQL.Add('DELETE P FROM');
    LLock.SQL.Add('  NFEIMP_PROCESSANDO P');
    LLock.SQL.Add('WHERE');
    LLock.SQL.Add('  P.NFE_CON_ID = ' + QuotedStr(fGetConnectionID) + ' AND');
    LLock.SQL.Add('  (SELECT');
    LLock.SQL.Add('     COUNT(*)');
    LLock.SQL.Add('   FROM');
    LLock.SQL.Add('     NFEIMP N');
    LLock.SQL.Add('   WHERE');
    LLock.SQL.Add('     N.NFE_ACESSO = P.NFE_ACESSO AND');
    LLock.SQL.Add('     N.NFE_STATUS = P.NFE_STATUS AND');
    LLock.SQL.Add('     (N.NFE_IMPORT <> "S") AND');
    LLock.SQL.Add('     (N.NFE_IMPORT <> "I")) > 0');
    LLock.ExecSQL;

  Finally
    FreeAndNil(LLock);
  End;

end;

function NFEIMP_EstaProcessando(const AAcesso, AStatus: String): Boolean;
  var
    LQry : TUniQuery;
begin

  Result := False;

  If AAcesso.IsEmpty Then
    Exit;

  If AStatus.IsEmpty Then
    Exit;

  LQry := fCriaQuery;

  Try

    LQry.SQL.Add('SELECT               ');
    LQry.SQL.Add('  COUNT(*) AS TOT    ');
    LQry.SQL.Add('FROM                 ');
    LQry.SQL.Add('  NFEIMP_PROCESSANDO ');
    LQry.SQL.Add('WHERE                ');
    LQry.SQL.Add('  (NFE_ACESSO = :ACESSO) AND ');
    LQry.SQL.Add('  (NFE_STATUS = :STATUS) AND ');
    LQry.SQL.Add('  (NFE_CON_ID <> ' + QuotedStr(fGetConnectionID) + ')');

    LQry.ParamByName('ACESSO').AsString := AAcesso;
    LQry.ParamByName('STATUS').AsString := AStatus;
    LQry.Open;

    Result := (Not LQry.IsEmpty) And (LQry.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LQry);
  End;

end;

procedure CriaDataSetItensTL(var ACds: TUniClientDataSet);
begin
  ACds := TUniClientDataSet.Create(nil);

  ACds.FieldDefs.Add('CODITE', ftString, 5);
  ACds.FieldDefs.Add('ARMDES', ftString, VS_Size_NumLot);
  ACds.FieldDefs.Add('ARMORI', ftString, VS_Size_NumLot);
  ACds.FieldDefs.Add('QTDITE', ftFloat);
  ACds.CreateDataSet;
  ACds.Open;
end;

procedure MarcarIncGor(const AendDocumento  : TEndDocumento; AChaAce : String);
  var
    LQry    : TUniQuery;
    LEndere : TEnderecamentoProduto;
    LDocEnd : String;
    LSeqFgo : String;
begin

  If AChaAce.IsEmpty Then
    Exit;

  LEndere := TEnderecamentoProduto.Create;
  LQry    := fCriaQuery;

  Try

    LEndere.pLimpar;
    LEndere.endDocumento := AendDocumento;
    LDocEnd := LEndere.strDocumento;

    If LDocEnd.IsEmpty Then
      Exit;

    LQry.SQL.Add('SELECT FGO_SEQFGO FROM EXTGOR WHERE FGO_DOCEND = :DOCEND');
    LQry.ParamByName('DOCEND').AsString := LDocEnd;
    LQry.Open;

    If LQry.IsEmpty Then
      Exit;

    LSeqFgo := LQry.FieldByName('FGO_SEQFGO').AsString;

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add('UPDATE NFEIMP SET NFE_INCGOR = :INCGOR WHERE NFE_ACESSO = :ACESSO');
    LQry.ParamByName('INCGOR').AsString := LSeqFgo;
    LQry.ParamByName('ACESSO').AsString := AChaAce;
    LQry.ExecSQL;

  Finally
    FreeAndNil(LQry);
    FreeAndNil(LEndere);
  End;

end;

function ExisteAlgumDocumentoReferenciando(const AChaAce: String): Boolean;
  var
    LQry : TUniQuery;
begin

  LQry := fCriaQuery;

  Try

    LQry.SQL.Add('SELECT F.NFE_ACESSO FROM NFEIMP F WHERE F.NFE_REFNFE = :ACESSO');
    LQry.ParamByName('ACESSO').AsString := AChaAce;
    LQry.Open;

    Result := Not LQry.IsEmpty;

  Finally
    FreeAndNil(LQry);
  End;

end;

function DocumentoEstaReferenciando(const AChaAce : String) : Boolean;
  var
    LQry : TUniQuery;
begin

  LQry := fCriaQuery;

  Try

    LQry.SQL.Add('SELECT COUNT(*) AS TOT FROM NFEIMP F WHERE (F.NFE_ACESSO = :ACESSO) AND (IFNULL(F.NFE_REFNFE, "") <> "")');
    LQry.ParamByName('ACESSO').AsString := AChaAce;
    LQry.Open;

    Result := (LQry.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LQry);
  End;

end;

function GerarPedidoDeEnderecamento(const ANFEIMP             : TUniQuery;
                                          AOpcGeracao         : TFulfillmentOpcGeracaoPDEndereca;
                                          AValidaRegraSemLote : Boolean = False;
                                          ACodigoDoItem       : String  = '') : Boolean;
  var
    LValidaRegraComLote : Boolean;

  function fItemRealizaEnderecamento_Interna : Boolean;
  begin

    Result := False;

    If Not fCfgSis('DEVEND', VarBoolean) Then
      Exit;

    If Not fItemRealizaEnderecamento(ACodigoDoItem) Then
      Exit;

    Result := True;

  end;

begin

  LValidaRegraComLote := (AOpcGeracao = opcComLote);

  Result := False;

  If Not Assigned(ANFEIMP) Then
    Exit;

  If ANFEIMP.FieldByName('NFE_GERAJU').AsString.Equals('S') Then
    Exit;

  If ExisteAlgumDocumentoReferenciando(ANFEIMP.FieldByName('NFE_ACESSO').AsString) Then
    Exit;

  If Not ANFEIMP.FieldByName('NFE_GER_PD').AsString.Equals('S') Then
    Exit;

  {** Regra Obrigatória **}
  If (LValidaRegraComLote) Then
  Begin

    If Not ANFEIMP.FieldByName('NFE_TEMLOT').AsString.Equals('S') Then
      Exit;

  End Else If (AValidaRegraSemLote) Then
  Begin

    If (Not ANFEIMP.FieldByName('NFE_TEMLOT').AsString.Equals('S')) And
       (Not fItemRealizaEnderecamento_Interna) Then
      Exit;

  End Else
    Exit;

  Result := True;

end;

function MSGEstoqueExternoSemClienteVinculado(ANumDoc, AEspDoc: String): String;
begin
  Result := ANumDoc + '-' + AEspDoc + '-' + VS_strCodEmp;
  Result := 'Erro: Documento ' + Result + ' - Não pode ser importado pois não foi vinculado o código do cliente no cadastro do estoque externo!' + #13 +
            'Entre em contato com a Citel para que o cadastro seja ajustado e a nota possa ser importada.';
end;

function MSGSemCodigoEstoqueExterno(ANumDoc, AEspDoc: String): String;
begin
  Result := ANumDoc + '-' + AEspDoc + '-' + VS_strCodEmp;
  Result := 'Erro: Documento ' + Result + ' - Não pode ser importado pois não foi vinculado o código do estoque externo!' + #13 +
            'Entre em contato com a Citel para que o cadastro seja ajustado e a nota possa ser importada.';
end;

function TemEstoqueExternoVinculado(ACodEst: String): Boolean;
begin

  Result := True;

  If (Not fEmptyStr(ACodEst)) Then
    Exit;

  Result := False;

end;

function EstoqueExternoTemClienteVinculado(ACodEst: String): Boolean;
  const
    SQL = 'SELECT * FROM CADEEE WHERE EEE_CODEEE = :CODEEE';
  var
    LAux : TUniQuery;
begin

  LAux := fCriaQuery();

  Try

    LAux.SQL.Add(SQL);
    LAux.ParamByName('CODEEE').AsString := ACodEst;
    LAux.Open;

    Result := Not (LAux.IsEmpty) And Not fEmptyStr(LAux.FieldByName('EEE_CODCLI').AsString);

  Finally
    FreeAndNil(LAux);
  End;

end;

function ClienteVinculadoTemEstoqueExterno(ACodCli: String): Boolean;
var
  LAux : TUniQuery;
begin
  LAux := fCriaQuery();
  Try
    LAux.SQL.Add('SELECT * FROM CADEEE WHERE EEE_CODCLI = :CODCLI');
    LAux.ParamByName('CODCLI').AsString := ACodCli;
    LAux.Open;

    Result := Not (LAux.IsEmpty) And Not fEmptyStr(LAux.FieldByName('EEE_CODCLI').AsString);
  Finally
    FreeAndNil(LAux);
  End;
end;

function UsaPainelWebCitel : Boolean;
begin
  Result := False;

  If not fTabelaExiste('PCITEL') Then
    Exit;

  If not fCampoExiste('PCITEL', 'NFE_ORIGEM') Then
    Exit;

  If fEmptyStr(fCfgSis('PUBKEY', varString)) Then
    Exit;

  If not fCfgSis('PWCFUL', varBoolean) Then
    Exit;

  Result := true;
end;

function NotaFiscalDenegada(ANota: TNotaFiscal): Boolean;
begin
  Result := (ANota.strStatusNFE = '302');
end;

function DocumentoJaImportadoECancelado(AChave: String): Boolean;
  const
    SQL_CANCELADA = 'SELECT   '+
                    '  *      '+
                    'FROM     '+
                    '  CADFIS '+
                    'WHERE    '+
                    '  FIS_ACESSO = :ACESSO     AND '+
                    '  FIS_HISTOR = "CANCELADO" AND '+
                    '  FIS_VLCON1 IS NULL ';

    SQL_DELMOVGER = 'SELECT            ' +
                    '  COUNT(*) AS TOT ' +
                    'FROM              ' +
                    '  DEL_MOVGER      ' +
                    'WHERE GER_NUMDOC = :NUMDOC ' +
                    '  AND GER_ESPDOC = :ESPDOC ' +
                    '  AND GER_CODEMP = :CODEMP ' +
                    '  AND [CLIFOR]   = :CLIFOR ' +
                    '  AND GER_SERIE_ = :SERIE_ ';

  var
    LNota : TUniQuery;
    LNumDoc,
    LEspDoc,
    LCodEmp,
    LForCli,
    LTip_FC,
    LSerie_ : String;

    SQL_DELMOVGER_Final : String;

begin

  Result := False;

  LNota := fCriaQuery(Nil);

  Try

    LNota.Close;
    LNota.SQL.Clear;
    LNota.SQL.Add(SQL_CANCELADA);
    LNota.ParamByName('ACESSO').AsString := AChave;
    LNota.Open;

    If Not LNota.IsEmpty Then
    Begin

      LNumDoc := LNota.FieldByName('FIS_NUMDOC').AsString;
      LEspDoc := LNota.FieldByName('FIS_ESPDOC').AsString;
      LCodEmp := LNota.FieldByName('FIS_CODEMP').AsString;
      LForCli := LNota.FieldByName('FIS_FORCLI').AsString;
      LTip_FC := LNota.FieldByName('FIS_TIP_FC').AsString;
      LSerie_ := LNota.FieldByName('FIS_SERIE_').AsString;

      SQL_DELMOVGER_Final := IIF(LTip_FC.Equals('C'),
                                 SQL_DELMOVGER.Replace('[CLIFOR]', 'GER_CODCLI'),
                                 SQL_DELMOVGER.Replace('[CLIFOR]', 'GER_CODFOR'));

      LNota.Close;
      LNota.SQL.Clear;
      LNota.SQL.Add(SQL_DELMOVGER_Final);
      LNota.ParamByName('NUMDOC').AsString := LNumDoc;
      LNota.ParamByName('ESPDOC').AsString := LEspDoc;
      LNota.ParamByName('CODEMP').AsString := LCodEmp;
      LNota.ParamByName('CLIFOR').AsString := LForCli;
      LNota.ParamByName('SERIE_').AsString := LSerie_;
      LNota.Open;

      Result := (Not LNota.IsEmpty) And (LNota.FieldByName('TOT').AsInteger > 0);

    End;

  Finally
    FreeAndNil(LNota);
  End;

end;

function DocumentoJaImportado(AChave : String): Boolean;
const
  SQL_NOTA = 'SELECT 1 FROM CADFIS F                          '+
             'JOIN [TABELA] M ON F.FIS_NUMDOC = M.GER_NUMDOC  '+
             '               AND F.FIS_ESPDOC = M.GER_ESPDOC  '+
             '               AND F.FIS_CODEMP = M.GER_CODEMP  '+
             '               AND F.FIS_SERIE_ = M.GER_SERIE_  '+
             '               AND F.FIS_TIP_FC = M.GER_TIP_FC  '+
             'WHERE F.FIS_ACESSO = :ACESSO';
var
  LNota: TUniQuery;
begin

  LNota := fCriaQuery(Nil);

  Try

    LNota.SQL.Add(SQL_NOTA.Replace('[TABELA]', 'MOVGER'));
    LNota.SQL.Add('UNION');
    LNota.SQL.Add(SQL_NOTA.Replace('[TABELA]', 'NOTGER'));
    LNota.SQL.Add('UNION');
    LNota.SQL.Add(SQL_NOTA.Replace('[TABELA]', 'DEL_MOVGER'));
    LNota.SQL.Add('UNION');
    LNota.SQL.Add(SQL_NOTA.Replace('[TABELA]', 'DEL_NOTGER'));

    LNota.ParamByName('ACESSO').AsString := AChave;
    LNota.Open;

    Result := LNota.RecordCount > 0;

  Finally
    FreeAndNil(LNota);
  End;

end;

procedure GravaLogNFE(ANota: TNotaFiscal);
  Var
    LLogNFE : TUniQuery;
    LSQL : String;
    LCampoDtaEmiExiste : Boolean;
Begin
  LLogNFE := fCriaQuery(Nil);
  Try
    LCampoDtaEmiExiste := fCampoExiste('LOGNFE', 'NFE_DTAEMI');

    LSQL := 'INSERT INTO LOGNFE (  ';
    LSQL := LSQL + ' NFE_NUMDOC, ';
    LSQL := LSQL + ' NFE_ESPDOC, ';
    LSQL := LSQL + ' NFE_CODEMP, ';
    LSQL := LSQL + ' NFE_CODCLI, ';
    LSQL := LSQL + ' NFE_SERIE_, ';
    LSQL := LSQL + ' NFE_ACESSO, ';
    LSQL := LSQL + ' NFE_STATUS, ';
    LSQL := LSQL + ' NFE_HORINI, ';
    LSQL := LSQL + ' NFE_DTAAUT, ';
    LSQL := LSQL + ' NFE_OBSERV, ';
    LSQL := LSQL + ' NFE_TIP_FC, ';
    If (LCampoDtaEmiExiste) Then
      LSQL := LSQL + ' NFE_DTAEMI, ';
    LSQL := LSQL + ' NFE_PONIMP) VALUES ( ';
    LSQL := LSQL + ' :NUMDOC, ';
    LSQL := LSQL + ' :ESPDOC, ';
    LSQL := LSQL + ' :CODEMP, ';
    LSQL := LSQL + ' :CODCLI, ';
    LSQL := LSQL + ' :SERIE_, ';
    LSQL := LSQL + ' :ACESSO, ';
    LSQL := LSQL + ' :STATUS, ';
    LSQL := LSQL + ' nOw(),   ';
    LSQL := LSQL + ' nOw(),   ';
    LSQL := LSQL + ' :OBSERV, ';
    LSQL := LSQL + ' :TIP_FC, ';
    If (LCampoDtaEmiExiste) Then
      LSQL := LSQL + ' :DTAEMI, ';
    LSQL := LSQL + ' :PONIMP) ';

    LLogNFE.SQL.Add(LSQL);
    LLogNFE.ParamByName('NUMDOC').AsString := ANota.strNumDoc;
    LLogNFE.ParamByName('ESPDOC').AsString := 'NF';
    LLogNFE.ParamByName('SERIE_').AsString := ANota.strSerie;
    LLogNFE.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LLogNFE.ParamByName('CODCLI').AsString := ANota.strCodCli;
    LLogNFE.ParamByName('ACESSO').AsString := ANota.strChaveNfe;
    LLogNFE.ParamByName('STATUS').AsString := 'DN';
    LLogNFE.ParamByName('OBSERV').AsString := ANota.strMotivo;
    LLogNFE.ParamByName('TIP_FC').AsString := 'C';
    LLogNFE.ParamByName('PONIMP').AsString := '';
    If (LCampoDtaEmiExiste) Then
    Begin
      If (ANota.dtaDtaEnt <> 0) Then
        LLogNFE.ParamByName('DTAEMI').AsDateTime := ANota.dtaDtaEnt
      Else
        LLogNFE.ParamByName('DTAEMI').Value := Null;
    End;
    LLogNFE.ExecSQL;

  Finally
    FreeAndNil(LLogNFE);
  End;
End;

procedure MarcarDocParaGerarPDReservaEstoque(AAcesso, AStatus: String);
  const
    UPD = 'UPDATE NFEIMP SET NFE_GER_PD = "S" WHERE NFE_ACESSO = :ACESSO AND NFE_STATUS = :STATUS';
  var
    LQry : TUniQuery;
begin

  If AAcesso.IsEmpty Then
    Exit;

  If AStatus.IsEmpty Then
    Exit;

  LQry := fCriaQuery;

  Try
    LQry.SQL.Add(UPD);
    LQry.ParamByName('ACESSO').AsString := AAcesso;
    LQry.ParamByName('STATUS').AsString := AStatus;
    LQry.ExecSQL;
  Finally
    FreeAndNil(LQry);
  End;

end;

function InsereCidade(AIBGE, AUF: String): String;
  Var
    qryCadCid,
    qryDadCid : TUniQuery;
    strCodCid : String;
begin
  Result := '';
  qryDadCid := fCriaQuery(Nil);

  Try
    With qryDadCid Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT c.id_uf,              ');
      SQL.Add('       c.id_cidade,          ');
      SQL.Add('       c.cep,                ');
      SQL.Add('       c.nome AS cidade,     ');
      SQL.Add('       I.IBG_CODMUN AS IBGE  ');
      SQL.Add('FROM   IBG_CADIBG I INNER JOIN cidade c ON c.nome = I.IBG_NOMMUN  ');
      SQL.Add('WHERE  I.IBG_CODMUN = :IBGE AND id_uf = :ESTADO ');
      ParamByName('IBGE').AsString   := AIBGE;
      ParamByName('ESTADO').AsString := AUF;
      Open;
    End;

    If Not qryDadCid.IsEmpty Then
    Begin
      qryCadCid := fCriarQuery('SELECT * FROM CADCID WHERE FALSE');
      Try
        strCodCid := fAtualizaProCod('CADCID', 'CID_CODCID');

        If Not fEmptyStr(fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [strCodCid])) Then
          Raise Exception.Create('Já existe uma cidade com o código "' + strCodCid + '". '+
            'Favor verificar os próximos códigos - Tabela "CADCID"!');

        With qryCadCid Do
        Begin
          Open;
          Append;

          FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADCID', VS_strCodEmp);
          FieldByName('CID_CODCID').AsString   := strCodCid;
          FieldByName('CID_CODEMP').AsString   := VS_strCodEmp;
          FieldByName('CID_NOMCID').AsString   := UpperCase(fRemoveAcento(qryDadCid.FieldByName('cidade').AsString));
          FieldByName('CID_C_E_P_').AsString   := UpperCase(qryDadCid.FieldByName('cep').AsString);
          FieldByName('CID_CODCOR').AsString   := UpperCase(qryDadCid.FieldByName('id_cidade').AsString);
          FieldByName('CID_ESTADO').AsString   := UpperCase(qryDadCid.FieldByName('id_uf').AsString);
          FieldByName('CID_COIBGE').AsString   := UpperCase(qryDadCid.FieldByName('IBGE').AsString);
          FieldByName('CID_CODPAI').AsString   := '1058';
          FieldByName('CID_ORIGEM').AsString   := 'IMP.FULFILLMENT';
          Post;
        End;
      Finally
        FreeAndNil(qryCadCid);
      End;

      Result := strCodCid;
    End
    Else
      Result := '';

  Finally
    FreeAndNil(qryDadCid);
  End;

end;

function GetQtdItemNFe(AItem: TItemNota; ANFe: TNotaFiscal): Double;
Var
  LItem: TItemNota;
begin
  Result := 0;
  For LItem In ANFe.arrItemNota Do
    If LItem.strCodXml.Equals(AItem.strCodXml) Then
      Result := Result + LItem.fltQtdIte;
end;

function ExistePedidoParaBaixaDosLotes(ACodIte, ACodExt: String; AItemNota: TItemNota; ANFe: TNotaFiscal; var LFatDor: IMyCampoTabela; AEhEstruturaBaixandoFilhos: Boolean = False; ATituloLote : String = '';  AHubMkp: String = ''): Boolean;
  Var
    LQtdIteNFe: Double;
    LClienteEstoqueExterno: String;
    strTagXTexto : String;
begin

  Result := False;
  strTagXTexto := EmptyStr;

  If AHubMkp.Equals('MLB') Then
  Begin
    strTagXTexto := ANFe.strXTexto;

    If (Not fEmptyStr(strTagXTexto)) Then
      strTagXTexto := 'Tag xTexto..: '+ strTagXTexto + #13#10 +
                      'Documentação Mercado Livre: https://developers.mercadolivre.com.br/pt_br/obtendo-nota-fiscal';
  End;

  If fEmptyStr(ACodExt) Then
    Exit;

  If Not AEhEstruturaBaixandoFilhos Then
    If Not ValidaPedidoDeVenda Then
      If Not TCadLot.ProdutoTemLote(ACodIte) Then
        Exit;

  If Not Assigned(LFatDor) Then
    Exit;

  If LFatDor.FieldByName('FDO_JAFATU').AsString.Equals('1') Then
    Raise Exception.Create(MSG_REMESSA + #13#10 +
      'Msg Erro...: Item do pedido vinculado à nota de remessa já foi faturado.' + #13#10 +
      RetCodigoDescricaoEQtdItensNota(ANFe) +
      'Tags xml...: <cProd>' + AItemNota.strCodXml + '</cProd>, <xPed>' + AItemNota.strNumPed + '</xPed>.' +
      IfThen(fEmptyStr(strTagXTexto), '', #13#10 + strTagXTexto));

  LQtdIteNFe := GetQtdItemNFe(AItemNota, ANFe);

  If (Not AEhEstruturaBaixandoFilhos) And (Not fUsaRotinaWMS) And (Not ValidaPedidoDeVenda) And
     (LFatDor.FieldByName('FDO_NUMLOT').AsString.IsEmpty or LFatDor.FieldByName('FDO_NUMLOT').AsString.Equals('A DEFINIR')) Then
    Raise Exception.Create(MSG_REMESSA + #13#10 +
      'Msg Erro...: O produto não possui ' + ATituloLote + ' definido no pedido de venda.' + #13#10 +
      RetCodigoDescricaoEQtdItensNota(ANFe) + ' ' +
      'Quantidade.: ' + FormatFloat(fMskDigitos(4), LQtdIteNFe) + #13#10 +
      'Produto Ped: ' + fPadR(ACodIte + ' - ' + LFatDor.FieldByName('FDO_DESCRI').AsString, 60) + ' ' +
      'Quantidade.: ' + FormatFloat(fMskDigitos(4), LFatDor.FieldByName('FDO_QTDITE').AsFloat) + #13#10 +
      'Tags xml...: <cProd>' + AItemNota.strCodXml + '</cProd>, <xPed>' + AItemNota.strNumPed + '</xPed>.' +
      IfThen(fEmptyStr(strTagXTexto), '', #13#10 + strTagXTexto));

  LClienteEstoqueExterno := fCampoTabela('EEE_CODCLI', 'CADEEE', ['EEE_CODEEE'], [ACodExt], False);

  If Not LClienteEstoqueExterno.Equals(LFatDor.FieldByName('FDO_CODCLI').AsString) Then
    Raise Exception.Create(MSG_REMESSA + #13#10 +
      'Msg Erro...............: Pedido de venda vinculado possui cliente que não está ligado ao estoque externo.' + #13#10 +
      'Cliente Pedido.........: ' + LFatDor.FieldByName('FDO_CODCLI').AsString + ' - ' + fRetNomCliente(LFatDor.FieldByName('FDO_CODCLI').AsString) + #13#10 +
      'Cliente Estoque Externo: ' + LClienteEstoqueExterno + ' - ' + fRetNomCliente(LClienteEstoqueExterno) + #13#10 +
      RetCodigoDescricaoEQtdItensNota(ANFe) +
      'Tags xml...............: <cProd>' + AItemNota.strCodXml + '</cProd>, <xPed>' + AItemNota.strNumPed + '</xPed>.' +
      IfThen(fEmptyStr(strTagXTexto), '', #13#10 + strTagXTexto));

  Result := True;

end;

function RetCodigoDescricaoEQtdItensNota(ANFe: TNotaFiscal): String;
  var
    LItemNota : TItemNota;
    LItem     : String;
begin

  Result := '';

  If Not Assigned(ANFe) Then
    Exit;

  For LItemNota In ANFe.arrItemNota Do
  Begin

    LItem := LItemNota.strCodXml + ' - ' + LItemNota.strDescri + ' - Qtd.: ' + FormatFloat(fMskDigitos(4), LItemNota.fltQtdIte) + #13#10;

    If Result.IsEmpty Then
      Result := Result + 'Produto NFe: ' + LItem
    Else
      Result := Result + '             ' + LItem;

  End;

end;

function NotaSaidaSimbolicaRefRetornoMercadoriaNaoEntregueMercadoLivre(AChave: String): Boolean;
Var
  LValue,
  LXmlNFe,
  LXmlNFeRef : String;
begin
  LXmlNFe := fCampoTabela('NFE_ARQXML', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [AChave, 'AT']);

  If fEmptyStr(LXmlNFe) Then
    Exit(False);

  LValue := fExtractBetweenTags(LXmlNFe, '<CFOP>', '</CFOP>');

  If Not MatchStr(LValue, ['5949', '6949']) Then
    Exit(False);

  LValue := fExtractBetweenTags(fExtractBetweenTags(LXmlNFe, '<NFref>', '</NFref>'), '<refNFe>', '</refNFe>');

  If fEmptyStr(LValue) Then
    Exit(False);

  LXmlNFeRef := fCampoTabela('NFE_ARQXML', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [LValue, 'AT']);

  LValue := fExtractBetweenTags(LXmlNFeRef, '<CFOP>', '</CFOP>');

  If Not MatchStr(LValue, ['1202', '2202', '1411', '2411']) Then
    Exit(False);

  Result := True;
end;

function NotaSaidaSimbolicaRefTransferenciaEntreDepositosMercadoLivre(AChave: String): Boolean;
Var
  LValue,
  LXmlNFe,
  LXmlNFeRef : String;
begin
  LXmlNFe := fCampoTabela('NFE_ARQXML', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [AChave, 'AT']);

  If fEmptyStr(LXmlNFe) Then
    Exit(False);

  LValue := fExtractBetweenTags(LXmlNFe, '<CFOP>', '</CFOP>');

  If Not MatchStr(LValue, ['5949', '6949']) Then
    Exit(False);

  LValue := fExtractBetweenTags(fExtractBetweenTags(LXmlNFe, '<NFref>', '</NFref>'), '<refNFe>', '</refNFe>');

  If fEmptyStr(LValue) Then
    Exit(False);

  LXmlNFeRef := fCampoTabela('NFE_ARQXML', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [LValue, 'AT']);

  LValue := fExtractBetweenTags(LXmlNFeRef, '<CFOP>', '</CFOP>');

  If Not MatchStr(LValue, ['1949', '2949']) Then
    Exit(False);

  Result := True;
end;

function ValidaSaldoItem(ACodIte, ACodExt: String; AQtdIte: Double; ASalExt: Boolean; out ANumLot: String): Boolean;
  Var
    LSaldo: Double;
begin
  If ASalExt Then
    LSaldo := fCampoTabela('EXT_SALDO_', 'ESTEXT', ['EXT_CODITE','EXT_CODEMP','EXT_CODEEE'], [ACodIte, VS_strCodEmp, ACodExt])
  Else
  Begin
    If (Not fEmptyStr(ACodExt)) And TCadLot.ExisteLoteEstoqueExterno(ACodIte, ACodExt, ANumLot) Then
      LSaldo := fCampoTabela('LOT_SALDOS', 'CADLOT', ['LOT_CODITE','LOT_CODEMP','LOT_NUMLOT'], [ACodIte, VS_strCodEmp, ANumLot])
    Else
      LSaldo := fCampoTabela('ITE_SALDOS', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [ACodIte, VS_strCodEmp]);
  End;

  Result := fFormataFloat(LSaldo, 4) >= fFormataFloat(AQtdIte, 4);
end;

function RetImportouDocumentoDeReferencia(AChaveDeAcesso: String): Boolean;
  const
    SQL = 'SELECT COUNT(*) AS TOT FROM NFEIMP WHERE NFE_REFNFE = :REFNFE AND NFE_IMPORT = "S"';
  var
    LDocRef : TUniQuery;
begin

  Result := False;

  If AChaveDeAcesso.IsEmpty Then
    Exit;

  LDocRef := fCriaQuery;

  Try

    LDocRef.SQL.Add(SQL);
    LDocRef.ParamByName('REFNFE').AsString := AChaveDeAcesso;
    LDocRef.Open;

    Result := (Not LDocRef.IsEmpty) And (LDocRef.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LDocRef);
  End;

end;

function RetMSGImpossibilidadeDeImportarRetornoSimbolico(AChaveDeAcesso: String): String;
  Var
    LDocRef: TUniQuery;
begin

  LDocRef := fCriaQuery;

  Try
    LDocRef.SQL.Add('SELECT NFE_ACESSO,');
    LDocRef.SQL.Add('       CONCAT(NFE_NUMDOC, "-", NFE_ESPDOC, "-", NFE_CODEMP) AS NUMDOC');
    LDocRef.SQL.Add('FROM NFEIMP');
    LDocRef.SQL.Add('WHERE NFE_REFNFE = :REFNFE');
    LDocRef.ParamByName('REFNFE').AsString := AChaveDeAcesso;
    LDocRef.Open;

    Result := 'Não é possível importar o retorno simbólico pois a nota de venda relacionada ainda não foi importada e o sistema ' +
              'está configurado para só importar retorno simbólico após a importação da nota de venda [CFG_RETSIM].' + sLineBreak +
              'Depois que a venda for importada, através do painel coloque essa nota novamente na fila de importação.';

    If Not LDocRef.IsEmpty Then
      Result := Result + sLineBreak + 'Venda relacionada: ' + LDocRef.FieldByName('NUMDOC').AsString +
                                      ' - Chave de acesso da venda: ' + LDocRef.FieldByName('NFE_ACESSO').AsString + '.';
  Finally
    FreeAndNil(LDocRef);
  End;

end;

function PedidoVinculadoFoiBaixado(ANumDoc, AEspDoc, ACodEmp: String): Boolean;
begin
  Result := (fCampoTabela('FGO_JAFATU', 'FATGOR',
                         ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                         [ANumDoc, AEspDoc, ACodEmp]) = 1);
end;

function ExisteJsonPedidoMercadoLivre(AChave: String): Boolean;
begin
  Result := fCampoTabela('SUM(IF(NFE_ARQORD IS NULL, 0, 1))', 'NFEMLB', ['NFE_ACESSO', 'NFE_STATUS'], [AChave, 'AT']) > 0;
end;

function GetValorTaxaMercadoLivre(AChave: String): Double;
begin
  Result := fCampoTabela('NFE_VALTAX', 'NFEMLB', ['NFE_ACESSO', 'NFE_STATUS'], [AChave, 'AT']);
end;

function GetValorFreteDescontadoMercadoLivre(AChave: String): Double;
begin
  Result := fCampoTabela('NFE_VALFRE + NFE_FREVEN', 'NFEMLB', ['NFE_ACESSO', 'NFE_STATUS'], [AChave, 'AT']);
end;

function GetValorFreteCompradorMercadoLivre(AChave: String): Double;
begin
  Result := fCampoTabela('NFE_FRECLI', 'NFEMLB', ['NFE_ACESSO', 'NFE_STATUS'], [AChave, 'AT']);
end;

procedure CarregarCliente(AFatVenda: TFatVenda; ACodigo: String);
  Var
    LCli: TUniQuery;

  procedure CarregarEnderecoDeEntregaDoCliente(AAutEnt : String);
    var
      LEndEnt : TUniQuery;
  begin

    If fEmptyStr(AAutEnt) Then
      Exit;

    LEndEnt := fCriaQuery(Nil);

    Try

      LEndEnt.Close;
      LEndEnt.SQL.Add('SELECT        ');
      LEndEnt.SQL.Add('  ETC_ENDENT, ');
      LEndEnt.SQL.Add('  ETC_BAIENT, ');
      LEndEnt.SQL.Add('  ETC_CEPENT, ');
      LEndEnt.SQL.Add('  ETC_CIDENT, ');
      LEndEnt.SQL.Add('  ETC_TELENT  ');
      LEndEnt.SQL.Add('FROM       ');
      LEndEnt.SQL.Add('  ENTCLI   ');
      LEndEnt.SQL.Add('WHERE      ');
      LEndEnt.SQL.Add('  AUTOINCREM = :AUTINC');
      LEndEnt.ParamByName('AUTINC').AsString := AAutEnt;
      LEndEnt.Open;

      If LEndEnt.IsEmpty Then
        Exit;

      AFatVenda.strCliNum := '';
      AFatVenda.strCliTel := LEndEnt.FieldByName('ETC_TELENT').AsString;
      AFatVenda.strCliCom := LEndEnt.FieldByName('ETC_ENDENT').AsString;
      AFatVenda.strCliEnd := LEndEnt.FieldByName('ETC_ENDENT').AsString;

      AFatVenda.strCliBai := LEndEnt.FieldByName('ETC_BAIENT').AsString;
      AFatVenda.strCliCep := LEndEnt.FieldByName('ETC_CEPENT').AsString;
      AFatVenda.strCodCid := LEndEnt.FieldByName('ETC_CIDENT').AsString;

      AFatVenda.strCliCid := fRetNomCidade(AFatVenda.strCodCid);
      AFatVenda.strCliEst := fRetNomCidade(AFatVenda.strCodCid, 1);

    Finally
      FreeAndNil(LEndEnt);
    End;

  end;

  procedure CarregarEnderecoPrincipalDoCliente;
  begin

    AFatVenda.strCliNum := LCli.FieldByName('CLI_ENDNUM').AsString;
    AFatVenda.strCliCom := LCli.FieldByName('CLI_ENDCOM').AsString;
    AFatVenda.strCliEnd := LCli.FieldByName('CLI_ENDERE').AsString + ', ' +
                           LCli.FieldByName('CLI_ENDNUM').AsString + '  ' +
                           LCli.FieldByName('CLI_ENDCOM').AsString;

    AFatVenda.strCliBai := LCli.FieldByName('CLI_BAIRRO').AsString;
    AFatVenda.strCliCep := LCli.FieldByName('CLI_C_E_P_').AsString;
    AFatVenda.strCodCid := LCli.FieldByName('CLI_CODCID').AsString;

    AFatVenda.strCliCid := fRetNomCidade(AFatVenda.strCodCid);
    AFatVenda.strCliEst := fRetNomCidade(AFatVenda.strCodCid, 1);

  end;

begin

  LCli := fCriaQuery(Nil);

  Try

    LCli.SQL.Add('SELECT ');
    LCli.SQL.Add('  CLI_CODCLI, CLI_NOMCLI, CLI_NOMCLI, CLI_ENDNUM, CLI_ENDCOM, ');
    LCli.SQL.Add('  CLI_ENDERE, CLI_ENDNUM, CLI_ENDCOM, CLI_BAIRRO, CLI_C_E_P_, ');
    LCli.SQL.Add('  CLI_CODCID, CLI_FONE01, CLI_EMAIL3, CLI_EMAIL2, CLI_CLUFID, ');
    LCli.SQL.Add('  CLI_CLIFID, CLI_CODATI, CLI_CODATI, CLI_NUMR_G, CLI_C_G_C_, ');
    LCli.SQL.Add('  CLI_OBSERV, CLI_CODEAC, CLI_CGCCPF, CLI_I_E_S_ ');
    LCli.SQL.Add('FROM ');
    LCli.SQL.Add('  CADCLI ');
    LCli.SQL.Add('WHERE ');

    If fEmptyStr(ACodigo) Then
      LCli.SQL.Add('  CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" LIMIT 1')
    Else
    Begin
      LCli.SQL.Add('  CLI_CODCLI = :CODCLI ');
      LCli.ParamByName('CODCLI').AsString := ACodigo;
    End;

    LCli.Open;

    If Not LCli.IsEmpty Then
    Begin
      AFatVenda.strCodCli := LCli.FieldByName('CLI_CODCLI').AsString;
      AFatVenda.strCliNom := LCli.FieldByName('CLI_NOMCLI').AsString;
      AFatVenda.strCliOri := LCli.FieldByName('CLI_NOMCLI').AsString;
      AFatVenda.strCliCgc := LCli.FieldByName('CLI_C_G_C_').AsString;
      AFatVenda.intCGCCPF := LCli.FieldByName('CLI_CGCCPF').AsInteger;
      AFatVenda.strCliIes := LCli.FieldByName('CLI_I_E_S_').AsString;
      AFatVenda.strCliTel := LCli.FieldByName('CLI_FONE01').AsString;
      AFatVenda.strCliEma := LCli.FieldByName('CLI_EMAIL3').AsString;
      AFatVenda.strCliEm2 := LCli.FieldByName('CLI_EMAIL2').AsString;
      AFatVenda.strCluFid := LCli.FieldByName('CLI_CLUFID').AsString;
      AFatVenda.strCliFid := LCli.FieldByName('CLI_CLIFID').AsString;
      AFatVenda.strCliAti := LCli.FieldByName('CLI_CODATI').AsString;
      AFatVenda.blnConstr := (fAtividadeConstrutora(LCli.FieldByName('CLI_CODATI').AsString));
      AFatVenda.strCli_Rg := LCli.FieldByName('CLI_NUMR_G').AsString;
      AFatVenda.strObserv := LCli.FieldByName('CLI_OBSERV').AsString;
      AFatVenda.strCliDAc := LCli.FieldByName('CLI_CODEAC').AsString;

      If Not fEmptyStr(AFatVenda.strAutEnt) Then
        CarregarEnderecoDeEntregaDoCliente(AFatVenda.strAutEnt)
      Else
        CarregarEnderecoPrincipalDoCliente;

    End;

  Finally
    FreeAndNil(LCli);
  End;

end;

procedure ReenviaDocumentoParaProcessamento(AChave: String);
  Var
    LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    Try
      fStartTransaction;

      LQuery.SQL.Add('UPDATE NFEIMP');
      LQuery.SQL.Add('  SET NFE_IMPORT = "N"');
      LQuery.SQL.Add('WHERE NFE_ACESSO = :ACESSO');
      LQuery.SQL.Add('  AND NFE_IMPORT = "E"');
      LQuery.ParamByName('ACESSO').AsString := AChave;
      LQuery.ExecSQL;

      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add('DELETE FROM FULL_LOGERR');
      LQuery.SQL.Add('WHERE LOG_ACESSO = :ACESSO');
      LQuery.ParamByName('ACESSO').AsString := AChave;
      LQuery.ExecSQL;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollback;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
