unit untImpressaoNFe;

interface

uses
{$IF Defined(UNIDAC)}
  Uni,
{$ELSE}
  ZDataset,
{$IFEND}
{$IF Defined(LINUX)}
  NFe.Modulo,
  FMX.frxClass, FMX.frxExportPDF, FMX.Graphics, FMX.Forms,
{$ELSE}
  untModulo,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, DBCtrls, Controls, Forms, Graphics,
  Windows, Messages, frxClass, frxExportPDF,
{$IFEND}
  DateUtils, SysUtils, Variants, Classes, strUtils, DB, MemDS,
  untConversao, ACBrNFeDANFEFR, ACBrNFe, untConexaoBD, untUtil,
  untValidadorXML, Math, ACBrUtil, untNfeDinamico, untNfsDinamico;

type
  TImpressaoNFe = class
  private
    NFe: TACBrNFe;
    DanfeConfiguracao: TACBrNFeDANFEFR;
    ConexaoBD : TConexaoBD;
    FDinEntrada: TNfeDinEntrada;
    FModoTeste: String;
    FResultadoTeste: TStringList;
    FVariaveisTeste: TStringList;
    FDadosTeste: TStrings;
    FDinUltimoErro: String;
    function fUsaNfeDinamica(const AChaveAcesso: String): Boolean;
    function fNfeDinamicaPreparou(const AChaveAcesso: String): Boolean;
    procedure pGravaLogNfeDin(const AChaveAcesso, AMensagem, AErro: String);
    procedure pExecutaModoTeste(const AChaveAcesso: String; ADinamico: Boolean);
    function fNotaComplemento(const AChaAce, ANFComp: String): Boolean;
    function fTrataCaracteresEspeciais(AText: string): string;
    function fRetMultiploVendaOuCompra(const qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}; strCampo_: String; strCodIte: String; intOrdIte: Integer): Double;
    procedure pCarregaDados(const AChaAce: String; qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}; blnCancelada: Boolean; ANFComp: String='');
    procedure pTratarInformacoesAdicionais(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    procedure pTratarClienteProduto(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    procedure pTratarDtaHraSai(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    procedure pTratarQtdeEtiquetas(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    procedure pTratarCodigoBoxRegiao(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    procedure pTratarDadosProdutosGeral(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});

    function fEhSomenteUmaVia(blnPDF_Gerar, blnReimpressao: Boolean; intQtdVias: Integer; blnEscolheuNaoImprimirViaNfe: Boolean): Boolean;
    function AtualizarFastFile(AConteudo: string): string;
    function fTemPontoDeImpressaoLayoutSimplificado(const strCodEmp : String) : Boolean;
  public
    constructor Create();
    destructor Destroy; override;

    property ModoTeste: String read FModoTeste write FModoTeste;
    property ResultadoTeste: TStringList read FResultadoTeste;
    property VariaveisTeste: TStringList read FVariaveisTeste;
    property DadosTeste: TStrings read FDadosTeste write FDadosTeste;

    procedure Configuracao(AImpressora, AChaveAcesso: string;
                           blnUsaCadImpressoras, ALayoutSimplificado, ALayoutSmartPOS: Boolean;
                           AstrPonImp: String='');

    procedure Imprimir(ACodigoEmpresa,
                       AChaveAcesso,
                       AImpressora       : String;
                       blnReimpressao    : Boolean = False;
                       blnPDF_Gerar      : Boolean = False;
                       strPDF_Diretorio  : String  = '';
                       blnPDF_Apresentar : Boolean = False;
                       blnPDF_Banco      : Boolean = False;
                       AArqXml           : String = '';
                       ANFComp           : String = '';
                       ALayoutSimplif    : String = '');

    procedure GerarBMP(ACodigoEmpresa,
                       AChaveAcesso,
                       APathBMP : String);
  end;

  TThreadFinalizarNFeImpressao = class(TThread)
  private
    class var FInstance: TThreadFinalizarNFeImpressao;
  private
    const FTimeout = 2;
  private
    FBegin: TDateTime;
    FPID: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(APID: Integer);

    class procedure Monitorar;
    class procedure Parar;
  end;

procedure pTarefaImprimir();

implementation

uses
  untConfImpressora,
{$IF Defined(LINUX)}
  untLogDanfe, untSpoolImpressao, untModuloReplicacao,
{$ELSE}
  untConfImpressaoNFe, {$IFDEF DEBUG}untImpNfdProvedores,{$ENDIF} {$IF Defined(UNIDAC)}untLogDanfe, untSpoolImpressao, untModuloReplicacao, Vcl.Printers {$ELSE} untModuloReplicacaoZeos {$IFEND},
{$IFEND}
  untImpressaoNFCe, untImpressaoRG, untImpressaoNFS, untImpressaoCCe, untImpressaoMDFe, untImpressaoCTe, ACBrNFeNotasFiscais, untNFe,
  untDicSis;

{ TThreadFinalizarNFeImpressao }

constructor TThreadFinalizarNFeImpressao.Create(APID: Integer);
begin
  inherited Create(True);

  FreeOnTerminate := False;

  FBegin := Date + Time;
  FPID   := APID;
end;

procedure TThreadFinalizarNFeImpressao.Execute;
begin
  while not Terminated do
  begin
    if MinutesBetween(Date + Time, FBegin) >= FTimeout then
    begin
      if not Terminated then
        KillProcess(FPID);

      Exit;
    end;

    Sleep(1000);
  end;
end;

class procedure TThreadFinalizarNFeImpressao.Monitorar;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance := TThreadFinalizarNFeImpressao.Create(GetCurrentProcessId);
    Self.FInstance.Start;
  end;
end;

class procedure TThreadFinalizarNFeImpressao.Parar;
begin
  if Assigned(Self.FInstance) then
  begin
    Self.FInstance.Terminate;
    Self.FInstance.WaitFor;
    FreeAndNil(Self.FInstance);
  end;
end;

{ TImpressaoNFe }

constructor TImpressaoNFe.Create();
begin
  ConexaoBD := TConexaoBD.Create(frmModulo.Database);
  NFe := TACBrNFe.Create(nil);
  DanfeConfiguracao := TACBrNFeDANFEFR.Create(nil);
  NFe.DANFE := DanfeConfiguracao;
  FModoTeste := '';
  FResultadoTeste := TStringList.Create;
  FVariaveisTeste := TStringList.Create;
end;

destructor TImpressaoNFe.Destroy();
begin
  ConexaoBD.Free();
  DanfeConfiguracao.Free();
  FreeAndNil(FDinEntrada);
  FreeAndNil(FResultadoTeste);
  FreeAndNil(FVariaveisTeste);
  NFe.Free();
  inherited;
end;

function TImpressaoNFe.fEhSomenteUmaVia(blnPDF_Gerar, blnReimpressao: Boolean; intQtdVias: Integer; blnEscolheuNaoImprimirViaNfe: Boolean): Boolean;
begin
  Result := False;

  If (blnPDF_Gerar) Or (blnReimpressao) Or (IIF(blnEscolheuNaoImprimirViaNfe, 1, intQtdVias) <= 0) Then
    Result := True;
end;

function TImpressaoNFe.fNotaComplemento(const AChaAce, ANFComp: String): Boolean;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If (Not fEmptyStr(ANFComp)) Then
  Begin
    Result := (ANFComp = 'S');
  End
  Else
  Begin
    qryGen := fCriaQuery(Nil);
    Try
      qryGen.SQL.Text := 'SELECT FIS_NFCOMP FROM CADFIS WHERE FIS_ACESSO = :ACESSO;';
      qryGen.ParamByName('ACESSO').AsString := AChaAce;
      qryGen.Open;
      Result := (qryGen.FieldByName('FIS_NFCOMP').AsString = 'S');
      qryGen.Close;
    Finally
      FreeAndNil(qryGen)
    End;
  End;
end;

function TImpressaoNFe.fRetMultiploVendaOuCompra(const qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}; strCampo_: String; strCodIte: String; intOrdIte: Integer): Double;

  function fRetMul: Double;
  begin
    Result := qryDoc.FieldByName(strCampo_).AsFloat;

    If (Result <=0) Then
      Result := 1;
  end;

begin
  Result := 1;
  Try
    If (Not qryDoc.IsEmpty) Then
    Begin
      qryDoc.First;
      If qryDoc.Locate('ORDITE;CODITE', VarArrayOf([intOrdIte+1, strCodIte]), []) Then
        Result := fRetMul
      Else If qryDoc.Locate('CODITE', strCodIte, []) Then
        Result := fRetMul;
    End;
  Except
    Result := 1;
  End;
end;

function TImpressaoNFe.fTrataCaracteresEspeciais(AText: string): string;
begin
  Result := AText;
  Result := AnsiReplaceStr(Result,'°','.');
  Result := AnsiReplaceStr(Result,'ª','.');
  Result := AnsiReplaceStr(Result,'½','1/2');
  Result := AnsiReplaceStr(Result,'¼','1/4');
  Result := AnsiReplaceStr(Result,'¾','3/4');
  Result := AnsiReplaceStr(Result,'¹','.');
  Result := AnsiReplaceStr(Result,'³','.');
  Result := AnsiReplaceStr(Result,'²','.');
  Result := AnsiReplaceStr(Result,'[','/');
  Result := AnsiReplaceStr(Result,']','/');
  Result := AnsiReplaceStr(Result,' ',''); // isso não é um espaço
end;

procedure TImpressaoNFe.pCarregaDados(const AChaAce: String; qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}; blnCancelada: Boolean; ANFComp: String='');
Const
  cstCmpComple = '/*COMPLE*/';
  cstCmpCupCnf = '/*CUPCNF*/';
  cstInfAdicDanfeSimplificada = '/*INFADICDANFESIMPLIFICADA*/';
Var
  LCodEmp: String;
  LSQLRef: String;
  LSQLAux: String;
  LPrefix: String;
  LPortadorNaoExibeDuplicata: String;
  LNotaComplemento: Boolean;
  LLeftInner: String;

  procedure pConverteMacro(const strMacro, strTabela, strCampo, strTextoSeExisteSim, strTextoSeExisteNao: string);
  begin
    If fCampoExiste(Trim(strTabela), Trim(strCampo)) Then
      LSQLAux := AnsiReplaceStr(LSQLAux, strMacro, strTextoSeExisteSim)
    Else
      LSQLAux := AnsiReplaceStr(LSQLAux, strMacro, strTextoSeExisteNao);
  end;

  function fRetSQLLisPed: String;
    var
      strSQLDel: String;
  begin
    Result := ' (SELECT GROUP_CONCAT(DISTINCT FATDOR.FDO_NUMDOC) FROM FATDOR ' +
              '   WHERE FATDOR.FDO_NUMFAT = G.GER_NUMDOC                     ' +
              '     AND FATDOR.FDO_EMPFAT = G.GER_CODEMP                     ' +
              '     AND FATDOR.FDO_TIPFAT = G.GER_ESPDOC                     ' +
              '     ORDER BY FATDOR.FDO_NUMDOC)                              ';
    If blnCancelada Then
    begin
      strSQLDel := Result;
      strSQLDel := AnsiReplaceStr(strSQLDel, 'FATDOR', 'DEL_FATDOR');
      Result := ' COALESCE('+strSQLDel+','+Result+') ';
    end;
  end;

  function fRetSQLDtENtr: String;
    var
      strSQLDel: String;
  begin
    Result := ' (SELECT DISTINCT(FATGOR.FGO_DTENTR) FROM FATGOR   ' +
              '   INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM '+
              '   WHERE FATDOR.FDO_NUMFAT = G.GER_NUMDOC          ' +
              '     AND FATDOR.FDO_EMPFAT = G.GER_CODEMP          ' +
              '     AND FATDOR.FDO_TIPFAT = G.GER_ESPDOC LIMIT 1) ';
    If blnCancelada Then
    begin
      strSQLDel := Result;
      strSQLDel := AnsiReplaceStr(strSQLDel, 'FATGOR', 'DEL_FATGOR');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'FATDOR', 'DEL_FATDOR');
      Result := ' COALESCE('+strSQLDel+','+Result+') ';
    end;
  end;

  function fRetSQLNumRom: String;
    var
      strSQLDel: String;
  begin
    Result := ' (SELECT DISTINCT(FATGOR.FGO_NUMROM) FROM FATGOR   ' +
              '   INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM '+
              '   WHERE FATDOR.FDO_NUMFAT = G.GER_NUMDOC          ' +
              '     AND FATDOR.FDO_EMPFAT = G.GER_CODEMP          ' +
              '     AND FATDOR.FDO_TIPFAT = G.GER_ESPDOC LIMIT 1) ';
    If blnCancelada Then
    begin
      strSQLDel := Result;
      strSQLDel := AnsiReplaceStr(strSQLDel, 'FATGOR', 'DEL_FATGOR');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'FATDOR', 'DEL_FATDOR');
      Result := ' COALESCE('+strSQLDel+','+Result+') ';
    end;
  end;

  function fRetSQLCupCnf: String;
  begin
    Result := '';

    Result := Result + ' ,(SELECT ';
    Result := Result + '       GROUP_CONCAT(DISTINCT DC.DET_NUMDOC, ';
    Result := Result + '       "-", ';
    Result := Result + '       DC.DET_ESPDOC, ';
    Result := Result + '       "-", ';
    Result := Result + '       DC.DET_CODEMP, ';
    Result := Result + '       ": ", ';
    Result := Result + '       FC.FIS_ACESSO, ';
    Result := Result + '       "\n" ORDER BY DC.DET_DTAENT SEPARATOR "" ) ';
    Result := Result + '     FROM MOVDET DC ';
    Result := Result + '    INNER JOIN CADFIS FC ';
    Result := Result + '       ON FC.FIS_NUMDOC = DC.DET_NUMDOC ';
    Result := Result + '      AND FC.FIS_ESPDOC = DC.DET_ESPDOC ';
    Result := Result + '      AND FC.FIS_SERIE_ = DC.DET_SERIE_ ';
    Result := Result + '      AND FC.FIS_CODEMP = DC.DET_CODEMP ';
    Result := Result + '      AND FC.FIS_FORCLI = DC.DET_CODCLI ';
    Result := Result + '      AND FC.FIS_TIP_FC = DC.DET_TIP_FC ';
    Result := Result + '    WHERE IF(RIGHT(G.GER_CLAFIS, 3) = "929", TRUE, FALSE) ';
    Result := Result + '      AND DC.DET_NUMFAT = G.GER_NUMDOC ';
    Result := Result + '      AND DC.DET_TIPFAT = G.GER_ESPDOC ';
    Result := Result + '      AND DC.DET_EMPFAT = G.GER_CODEMP ';
    Result := Result + '      AND DC.DET_CLIFAT = G.GER_CODCLI ';
    Result := Result + '      AND DC.DET_JAFATU = "1"  ';
    Result := Result + '      AND DC.DET_TIP_FC = "C"  ';
    Result := Result + '      AND DC.DET_ESPDOC = "IF" ';
    Result := Result + '      AND FC.FIS_ACESSO IS NOT NULL ';
    Result := Result + '    ORDER BY DC.DET_DTAENT) AS CUPCNF ';
  end;

  function fInformacoesAdicionaisDanfeSimplificada: String;
  begin
    Result := '';

    Result := Result + ' ,(SELECT                                         ';
    Result := Result + '     CONCAT(                                      ';
    Result := Result + '       "Data Disponível Envio:",                  ';
    Result := Result + '       IFNULL(E.FGO_DTDIEN, ""),                  ';
    Result := Result + '       "\n",                                      ';
    Result := Result + '       "Data Limite Envio:",                      ';
    Result := Result + '       IFNULL(E.FGO_DTLIEN, ""),                  ';
    Result := Result + '       "\n",                                      ';
    Result := Result + '       "Data Coleta Agendada:",                   ';
    Result := Result + '       IFNULL(E.FGO_DTCOAG, ""),                  ';
    Result := Result + '       "\n",                                      ';
    Result := Result + '       "Mensagem:",                               ';
    Result := Result + '       IFNULL(F.FGO_MENEXP, ""),                  ';
    Result := Result + '       " ",                                       ';
    Result := Result + '       IFNULL(F.FGO_MENEX2, ""),                  ';
    Result := Result + '       "\n",                                      ';
    Result := Result + '       "Cliente:",                                ';
    Result := Result + '       IFNULL(F.FGO_CODCLI, ""),                  ';
    Result := Result + '       "-",                                       ';
    Result := Result + '       IFNULL(L.CLI_NOMCLI, "")                   ';
    Result := Result + '     )                                            ';
    Result := Result + '     FROM MOVDET M                                ';
    Result := Result + '     JOIN FATGOR F ON F.FGO_NUMDOC = M.DET_NUM_PD ';
    Result := Result + '                  AND F.FGO_ESPDOC = M.DET_ESP_PD ';
    Result := Result + '                  AND F.FGO_CODEMP = M.DET_EMP_PD ';
    Result := Result + '     JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ';
    Result := Result + '     JOIN CADCLI L ON L.CLI_CODCLI = F.FGO_CODCLI ';
    Result := Result + '    WHERE M.DET_NUMDOC = G.GER_NUMDOC             ';
    Result := Result + '      AND M.DET_ESPDOC = G.GER_ESPDOC             ';
    Result := Result + '      AND M.DET_CODEMP = G.GER_CODEMP             ';
    Result := Result + '      AND M.DET_CODCLI = G.GER_CODCLI             ';
    Result := Result + '      AND M.DET_TIP_FC = "C" LIMIT 1) AS MSGDSP   ';
  end;

begin
  pRetornaParamSeExistir(consTagParamsEmp, LCodEmp, True);
  LCodEmp := IfEmptyStr(LCodEmp, ParamStr(2));

  LPortadorNaoExibeDuplicata := ConexaoBD.CarregarCFGSIS('PRSNDP');

  LNotaComplemento := fNotaComplemento(AChaAce, ANFComp);

  LLeftInner := IIF(LNotaComplemento, ' LEFT ', ' INNER ');

  qryDoc.Close;
  qryDoc.SQL.Clear;
  qryDoc.SQL.Add('SET @ORD = 0;');
  qryDoc.SQL.Add('SELECT @ORD:=@ORD+1 AS ORDITE, ');
  qryDoc.SQL.Add('       SUBQRYNOT.* FROM        ');
  qryDoc.SQL.Add('       (SELECT                 ');
  qryDoc.SQL.Add('       G.GER_CLAFIS AS CLAFIS, ');
  qryDoc.SQL.Add('       G.GER_VLRCON AS VLRCON, ');
  qryDoc.SQL.Add('       IFNULL(G.GER_VOLUME, 1) AS VOLUME, ');
  qryDoc.SQL.Add('       F.FIS_NUMDOC AS NUMDOC, ');
  qryDoc.SQL.Add('       F.FIS_ESPDOC AS ESPDOC, ');
  qryDoc.SQL.Add('       F.FIS_SERIE_ AS SERIE_, ');
  qryDoc.SQL.Add('       F.FIS_CODEMP AS CODEMP, ');
  qryDoc.SQL.Add('       F.FIS_HISTOR AS HISTOR, ');
  qryDoc.SQL.Add('       D.DET_CODITE AS CODITE, ');
  qryDoc.SQL.Add('       O.MOV_OBSERV AS OBSERV, ');
  qryDoc.SQL.Add('       O.MOV_OBSFIS AS OBSFIS, ');
  qryDoc.SQL.Add('       IFNULL(O.MOV_DTESNF, G.GER_DTAENT) AS DTESNF, ');
  qryDoc.SQL.Add('       IFNULL(O.MOV_HRESNF, G.GER_HORENT) AS HRESNF, ');

  If fCampoExiste('AUXMOV', 'AUX_OPCDOC') Then
    qryDoc.SQL.Add('     V.AUX_OPCDOC AS OPCDOC, ')
  Else
    qryDoc.SQL.Add('     CAST("" AS CHAR(1)) AS OPCDOC, ');

  If Not fEmptyStr(LPortadorNaoExibeDuplicata) Then
  Begin
    qryDoc.SQL.Add('     (SELECT IF(COUNT(*)>0, "N", "S") FROM CADREC         ');
    qryDoc.SQL.Add('       WHERE LOCATE(CADREC.CTR_CODPOR, "'+LPortadorNaoExibeDuplicata+'") ');
    qryDoc.SQL.Add('         AND CADREC.CTR_NUMDUP = G.GER_NUMDOC             ');
    qryDoc.SQL.Add('         AND CADREC.CTR_ESPDOC = G.GER_ESPDOC             ');
    qryDoc.SQL.Add('         AND CADREC.CTR_CODEMP = G.GER_CODEMP) AS EXIDUP, ');
  End
  Else
  Begin
    qryDoc.SQL.Add('     CAST("S" AS CHAR(1)) AS EXIDUP, ');
  End;

  qryDoc.SQL.Add('       CL.CLI_CELULA AS CELULA, ');
  qryDoc.SQL.Add('       CL.CLI_FANSOB AS FANSOB, ');
  qryDoc.SQL.Add('       CL.CLI_FONE02 AS FONE02, ');
  qryDoc.SQL.Add('       CL.CLI_ENDCOM AS ENDCOM, ');

  qryDoc.SQL.Add('       (SELECT CADCND.CND_CNDPAG FROM CADCND WHERE CADCND.CND_CODIGO = G.GER_CODCND LIMIT 1) AS CONPAG, ');
  qryDoc.SQL.Add('       (SELECT CADFPG.FPG_DESCRI FROM CADFPG WHERE CADFPG.FPG_CODIGO = G.GER_CODFPG LIMIT 1) AS FPGPAG, ');

  qryDoc.SQL.Add('       (SELECT CLIPRO.CLI_COD_NF FROM CLIPRO WHERE CLIPRO.CLI_CODITE = D.DET_CODITE AND CLIPRO.CLI_CODCLI = G.GER_CODCLI LIMIT 1) AS COD_NF, ');
  qryDoc.SQL.Add('       (SELECT CLIPRO.CLI_DES_NF FROM CLIPRO WHERE CLIPRO.CLI_CODITE = D.DET_CODITE AND CLIPRO.CLI_CODCLI = G.GER_CODCLI LIMIT 1) AS DES_NF, ');

  qryDoc.SQL.Add(        fRetSQLLisPed+' AS LISPED, ');

  qryDoc.SQL.Add('       G.GER_ENTFAT AS ENTFAT,  ');

  qryDoc.SQL.Add('       TR.TRA_CODTRA AS TRACOD,  ');
  qryDoc.SQL.Add('       TR.TRA_NOMTRA AS TRANOM,  ');
  qryDoc.SQL.Add('       TR.TRA_ENDERE AS TRAEND,  ');
  qryDoc.SQL.Add('       TR.TRA_BAIRRO AS TRABAI,  ');
  qryDoc.SQL.Add('       (SELECT CADCID.CID_NOMCID FROM CADCID WHERE CADCID.CID_CODCID = TR.TRA_CODCID LIMIT 1) AS TRACID, ');
  qryDoc.SQL.Add('       (SELECT CADCID.CID_ESTADO FROM CADCID WHERE CADCID.CID_CODCID = TR.TRA_CODCID LIMIT 1) AS TRAEST, ');

  { Req 380257: "DDDDDDDDDDDDTTEEEVVVTTT" }
  qryDoc.SQL.Add('       CONCAT(G.GER_NUMDOC, CASE G.GER_ESPDOC ' +
                                               ' WHEN "NF" THEN "01" ' +
                                               ' WHEN "IF" THEN "02" ' +
                                               ' WHEN "MI" THEN "03" ' +
                                               ' WHEN "FF" THEN "04" ' +
                                               ' WHEN "TE" THEN "05" ' +
                                               ' WHEN "BR" THEN "06" ' +
                                               ' WHEN "TR" THEN "07" ' +
                                               ' WHEN "DV" THEN "08" ' +
                                               ' WHEN "PD" THEN "09" ' +
                                               ' WHEN "D1" THEN "10" ' +
                                               ' WHEN "GC" THEN "11" ' +
                                             ' END, G.GER_CODEMP, "001", LPAD(CAST(IFNULL(GER_VOLUME, 1) AS SIGNED), 3, "0")) BRRMDP,  ');

  { Req 380846: Fax como WhatsApp da emrpesa }
  qryDoc.SQL.Add('       EP.EMP_F_A_X_ AS WHATSAPP,  ');

  qryDoc.SQL.Add(        fRetSQLDtENtr+' AS DTENTR,  ');

  qryDoc.SQL.Add('       '+cstCmpComple);

  qryDoc.SQL.Add('       ,COALESCE(CI.ITE_MLTVEN, 1) AS MLTVEN ');
  qryDoc.SQL.Add('       ,COALESCE(CI.ITE_MLTCOM, 1) AS MLTCOM ');
  qryDoc.SQL.Add('       ,CI.ITE_REFERE              AS REFITE ');

  If fTabelaExiste('CADDEP') Then
    qryDoc.SQL.Add('     ,(SELECT CADDEP.DEP_DESCRI FROM CADDEP WHERE CADDEP.DEP_CODIGO = CI.ITE_CODDEP LIMIT 1) AS DESDEP ')
  Else
    qryDoc.SQL.Add('     ,CAST("" AS CHAR(1)) AS DESDEP ');

  If fCampoExiste('MOVAUX', 'DET_BOXSEP') Then
    qryDoc.SQL.Add('     ,X.DET_BOXSEP AS BOXSEP ')
  Else
    qryDoc.SQL.Add('     ,CAST("" AS CHAR(1)) AS BOXSEP ');

  If fCampoExiste('CADREG', 'REG_DESREG') Then
    qryDoc.SQL.Add('     ,(SELECT CADREG.REG_DESREG FROM CADREG WHERE CADREG.REG_CODREG = CL.CLI_CODREG LIMIT 1) AS DESREG ')
  Else
    qryDoc.SQL.Add('     ,CAST("" AS CHAR(1)) AS DESREG ');

  qryDoc.SQL.Add('       ,(SELECT U.UNI_SIGUNI FROM CADUNI U WHERE U.UNI_CODUNI = D.DET_UNIDAD LIMIT 1) AS ITE_SIGUNV ');

  If fCampoExiste('CADUNI', 'UNI_PESLIT') Then
    qryDoc.SQL.Add('     ,(SELECT U.UNI_PESLIT FROM CADUNI U WHERE U.UNI_CODUNI = D.DET_UNIDAD LIMIT 1) AS UNI_PESLTV ')
  Else
    qryDoc.SQL.Add('     ,0.000 AS UNI_PESLTV ');

  If fCampoExiste('LOGNFE', 'NFE_VIANFE') Then
    qryDoc.SQL.Add('     ,(SELECT COALESCE(LOGNFE.NFE_VIANFE,-1) FROM LOGNFE WHERE LOGNFE.NFE_ACESSO = F.FIS_ACESSO LIMIT 1) AS VIANFE ')
  Else
    qryDoc.SQL.Add('     ,-1 AS VIANFE ');

  If fCampoExiste('LOGNFE', 'NFE_PONIMP') Then
    qryDoc.SQL.Add('     ,(SELECT LOGNFE.NFE_PONIMP FROM LOGNFE WHERE LOGNFE.NFE_ACESSO = F.FIS_ACESSO LIMIT 1) AS PONIMP ')
  Else
    qryDoc.SQL.Add('     ,CAST("" AS CHAR(1)) AS PONIMP ');

  If fTabelaExiste('DETANT') Then
    qryDoc.SQL.Add('     ,N.DET_PERDES_NOV AS PERNOV ')
  Else
    qryDoc.SQL.Add('     ,0.00 AS PERNOV ');

  If ConexaoBD.CarregarCFGSIS('ORDALF') = 'S' Then
  Begin
    If fCampoExiste('CADLOT', 'LOT_LOCSEP') And fCampoExiste('ITEGER', 'ITE_CODLSE') Then
      qryDoc.SQL.Add('   ,IFNULL(NULLIF(LOT_LOCSEP, ""), ITE_CODLSE) AS DET_CODLSE ')
    Else If fCampoExiste('ITEGER', 'ITE_CODLSE') Then
      qryDoc.SQL.Add('   ,ITE_CODLSE AS DET_CODLSE ')
    Else
      qryDoc.SQL.Add('   ,CAST("" AS CHAR(1)) AS DET_CODLSE ');
  End;

  qryDoc.SQL.Add('       ,(SELECT CONCAT(CADOPE.OPE_CODOPE,"-",CADOPE.OPE_NOMOPE) FROM CADOPE WHERE CADOPE.OPE_CODOPE = G.GER_CODVEN LIMIT 1) AS NOMVEN ');
  qryDoc.SQL.Add('       ,(SELECT ENTCLI.ETC_TELENT FROM ENTCLI WHERE ENTCLI.AUTOINCREM = V.AUX_ENTGER LIMIT 1) AS TELENT ');

  qryDoc.SQL.Add('       ,CI.ITE_PESOIT AS PESBRU                            ');
  qryDoc.SQL.Add('       ,CI.ITE_PESLIQ AS PESLIQ                            ');
  qryDoc.SQL.Add('       ,G.GER_TIP_FC  AS TIP_FC,                           ');
  qryDoc.SQL.Add(        fRetSQLNumRom+' AS NUMROM_PD                        ');
  qryDoc.SQL.Add('       ,G.GER_NUMROM   AS NUMROM_NF                        ');
  qryDoc.SQL.Add('       ,V.AUX_PLAVEI AS PLAVEI                             ');
  qryDoc.SQL.Add('       ,V.AUX_KM_VEI AS KM_VEI                             ');

  qryDoc.SQL.Add('       '+cstCmpCupCnf);
  qryDoc.SQL.Add('       '+cstInfAdicDanfeSimplificada);

  {Localizações Adicionais}
  If fCfgSis('CADLOC') = 'S' Then
  Begin
    qryDoc.SQL.Add('       ,(SELECT GROUP_CONCAT(DISTINCT CADLOC.LOC_DESCRI)                  ');
    qryDoc.SQL.Add('           FROM LOCFIS                                                    ');
    qryDoc.SQL.Add('          INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ');
    qryDoc.SQL.Add('                                CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ');
    qryDoc.SQL.Add('          WHERE LOCFIS.LOC_CODITE = D.DET_CODITE AND                      ');
    qryDoc.SQL.Add('                LOCFIS.LOC_CODEMP = D.DET_CODEMP AND                      ');
    qryDoc.SQL.Add('                CADLOC.LOC_ATIVO_ <> "N") AS LOCADI                       ');
  End
  Else
  Begin
    qryDoc.SQL.Add('       ,(SELECT GROUP_CONCAT(DISTINCT LOC_LOCFIS)    ');
    qryDoc.SQL.Add('           FROM LOCFIS                               ');
    qryDoc.SQL.Add('          WHERE LOC_CODITE = D.DET_CODITE AND        ');
    qryDoc.SQL.Add('                LOC_CODEMP = D.DET_CODEMP) AS LOCADI ');
  End;

  qryDoc.SQL.Add('  FROM CADFIS F                                            ');
  qryDoc.SQL.Add(LLeftInner+' JOIN MOVGER G ON F.FIS_CODEMP = G.GER_CODEMP   ');
  qryDoc.SQL.Add('                         AND F.FIS_NUMDOC = G.GER_NUMDOC   ');
  qryDoc.SQL.Add('                         AND F.FIS_ESPDOC = G.GER_ESPDOC   ');
  qryDoc.SQL.Add('                         AND F.FIS_SERIE_ = G.GER_SERIE_   ');
  qryDoc.SQL.Add('                         AND F.FIS_TIP_FC = G.GER_TIP_FC   ');
  qryDoc.SQL.Add('                         AND F.FIS_FORCLI = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) ');
  qryDoc.SQL.Add(LLeftInner+' JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM   ');
  qryDoc.SQL.Add('       LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM   ');
  qryDoc.SQL.Add('       LEFT JOIN AUXMOV V ON V.AUX_SEQGER = G.AUTOINCREM   ');
  qryDoc.SQL.Add('       LEFT JOIN MOVOBS O ON O.MOV_SEQGER = G.AUTOINCREM   ');

  If fTabelaExiste('MOVAUX') Then
    qryDoc.SQL.Add('     LEFT JOIN MOVAUX X ON X.DET_SEQGER = D.AUTOINCREM   ');

  If fTabelaExiste('DETANT') Then
    qryDoc.SQL.Add('     LEFT JOIN DETANT N ON N.AUTOINCREM = D.AUTOINCREM   ');

  qryDoc.SQL.Add('       LEFT JOIN CADITE CI ON CI.ITE_CODITE = D.DET_CODITE ');
  qryDoc.SQL.Add('       LEFT JOIN ITEGER IG ON IG.ITE_CODITE = D.DET_CODITE ');
  qryDoc.SQL.Add('                          AND IG.ITE_CODEMP = D.DET_CODEMP ');

  qryDoc.SQL.Add('       LEFT JOIN CADCLI CL ON CL.CLI_CODCLI = G.GER_CODCLI ');
  qryDoc.SQL.Add('       LEFT JOIN CADEMP EP ON EP.EMP_CODEMP = G.GER_CODEMP ');
  qryDoc.SQL.Add('       LEFT JOIN CADTRA TR ON TR.TRA_CODTRA = G.GER_CODTRA ');

  If ConexaoBD.CarregarCFGSIS('ORDALF') = 'S' Then
  Begin
    If fTabelaExiste('CADLOT') Then
    Begin
      qryDoc.SQL.Add('   LEFT JOIN CADLOT LT ON LT.LOT_NUMLOT = D.DET_NUMLOT ');
      qryDoc.SQL.Add('                      AND LT.LOT_CODITE = D.DET_CODITE ');
      qryDoc.SQL.Add('                      AND LT.LOT_CODEMP = D.DET_CODEMP ');
    End;
  End;

  qryDoc.SQL.Add('WHERE F.FIS_ACESSO = :ACESSO                               ');

  qryDoc.SQL.Add(fRetOrderByNota(ConexaoBD.CarregarCFGSIS('USA_RS'), ConexaoBD.CarregarCFGSIS('ORDALF'), 'D.AUTOINCREM'));

  qryDoc.SQL.Add('       ) AS SUBQRYNOT;');

  LSQLRef := qryDoc.SQL.Text;

  LPrefix := '';
  if blnCancelada then
  begin
    LSQLRef := AnsiReplaceStr(LSQLRef, 'MOVGER', 'DEL_MOVGER');
    LSQLRef := AnsiReplaceStr(LSQLRef, 'MOVDET', 'DEL_MOVDET');
    LSQLRef := AnsiReplaceStr(LSQLRef, 'MOVAUX', 'DEL_MOVAUX');
    LSQLRef := AnsiReplaceStr(LSQLRef, 'MOVTRI', 'DEL_MOVTRI');
    LSQLRef := AnsiReplaceStr(LSQLRef, 'MOVOBS', 'DEL_MOVOBS');
    LSQLRef := AnsiReplaceStr(LSQLRef, 'AUXMOV', 'DEL_AUXMOV');
    LSQLRef := AnsiReplaceStr(LSQLRef, 'CADREC', 'DEL_CADREC');
    LPrefix := 'DEL_';
  end;

  //MOVGER...
  LSQLAux := LSQLRef;
  pConverteMacro(cstCmpComple, LPrefix+'MOVTRI', 'DET_COMPLE', ' T.DET_COMPLE AS COMPLE ', ' CAST("" AS CHAR(50)) AS COMPLE ');
  LSQLAux := AnsiReplaceStr(LSQLAux, cstInfAdicDanfeSimplificada, fInformacoesAdicionaisDanfeSimplificada);

  qryDoc.SQL.Clear;
  qryDoc.SQL.Text := LSQLAux;

  qryDoc.ParamByName('ACESSO').AsString := AChaAce;
  qryDoc.Open;
  //...MOVGER

  If qryDoc.IsEmpty Then
  Begin
    qryDoc.Close;

    //NOTGER...
    LSQLAux := LSQLRef;
    pConverteMacro(cstCmpComple, LPrefix+'NOTTRI', 'DET_COMPLE', ' T.DET_COMPLE AS COMPLE ', ' CAST("" AS CHAR(50)) AS COMPLE ');

    LSQLAux := AnsiReplaceStr(LSQLAux, 'MOVGER', 'NOTGER');
    LSQLAux := AnsiReplaceStr(LSQLAux, 'MOVDET', 'NOTDET');
    LSQLAux := AnsiReplaceStr(LSQLAux, 'MOVAUX', 'NOTAUX');
    LSQLAux := AnsiReplaceStr(LSQLAux, 'MOVTRI', 'NOTTRI');
    LSQLAux := AnsiReplaceStr(LSQLAux, 'MOVOBS', 'NOTOBS');
    LSQLAux := AnsiReplaceStr(LSQLAux, 'AUXMOV', 'AUXNOT');

    LSQLAux := AnsiReplaceStr(LSQLAux, cstCmpCupCnf, fRetSQLCupCnf);
    LSQLAux := AnsiReplaceStr(LSQLAux, cstInfAdicDanfeSimplificada, fInformacoesAdicionaisDanfeSimplificada);

    qryDoc.SQL.Clear;
    qryDoc.SQL.Text := LSQLAux;

    qryDoc.ParamByName('ACESSO').AsString := AChaAce;
    qryDoc.Open;
    //...NOTGER
  End;
end;

function TImpressaoNFe.fUsaNfeDinamica(const AChaveAcesso: String): Boolean;
begin
  Result := False;
  {$IF not Defined(LINUX)}
  If (NFe.NotasFiscais.Count = 0) Or (NFe.NotasFiscais.Items[0].NFe.Ide.modelo <> 55) Then
    Exit;
  If (FModoTeste = '') And (ConexaoBD.CarregarCFGSIS('EDTIMN') <> 'S') Then
    Exit;
  Result := TNfeDinamico.fDisponivel(cstProvedorNotaFiscal);

  If (Not Result) And (FModoTeste = '') Then
    TNfsDinamico.pGravaLogDin('Aviso NfeImpressao NFe Dinamico', AChaveAcesso,
      'CFG_EDTIMN = S, mas a rotina dinamica da NF-e esta indisponivel (SCRIPT_PAINEL_003 ou provedor ' +
      cstProvedorNotaFiscal + ' sem dataset em IMPNFE_CDS): a impressao seguiu pela rotina antiga.', '', True);
  {$IFEND}
end;

procedure TImpressaoNFe.pGravaLogNfeDin(const AChaveAcesso, AMensagem, AErro: String);
begin
  If FModoTeste <> '' Then
    Exit;
  TNfsDinamico.pGravaLogDin('Erro NfeImpressao NFe Dinamico', AChaveAcesso, AMensagem, AErro);
end;

procedure TImpressaoNFe.pExecutaModoTeste(const AChaveAcesso: String; ADinamico: Boolean);
var
  lstNomes: TStringList;
  i: Integer;
begin
  FResultadoTeste.Clear;
  FVariaveisTeste.Clear;
  If Not ADinamico Then
  Begin
    FResultadoTeste.Add('Rotina dinamica indisponivel: verifique o SCRIPT_PAINEL_003 e o provedor ' +
      cstProvedorNotaFiscal + ' (IMPNFE_CDS).');
    Exit;
  End;

  If FModoTeste = 'V' Then
  Begin
    If Not fNfeDinamicaPreparou(AChaveAcesso) Then
    Begin
      FResultadoTeste.Add('Nao foi possivel preparar o relatorio com os datasets dinamicos:');
      FResultadoTeste.Add(FDinUltimoErro);
    End;
    TNfsDinamico.pListaVariaveis(DanfeConfiguracao.dmDanfe.frxReport, cstProvedorNotaFiscal, FVariaveisTeste);
    If Assigned(FDadosTeste) Then
    Begin
      lstNomes := TStringList.Create;
      Try
        TNfsDinamico.pNomesCds(cstProvedorNotaFiscal, lstNomes);
        For i := 0 To lstNomes.Count - 1 Do
          TNfsDinamico.pAddDadosTeste(lstNomes[i], DanfeConfiguracao.dmDanfe.fDataSetDinamico(lstNomes[i]), FDadosTeste);
      Finally
        FreeAndNil(lstNomes);
      End;
    End;
    Exit;
  End;

  If FModoTeste = 'C' Then
  Begin
    DanfeConfiguracao.dmDanfe.DinEntrada := Nil;
    If Not Assigned(DanfeConfiguracao.PreparedReport) Then
      FResultadoTeste.Add('Aviso: o relatorio pela rotina antiga nao foi preparado (' +
        Trim(DanfeConfiguracao.dmDanfe.frxReport.Errors.Text) + ').');

    DanfeConfiguracao.dmDanfe.DinEntrada := FDinEntrada;
    If Not fNfeDinamicaPreparou(AChaveAcesso) Then
      FResultadoTeste.Add('Aviso: o relatorio pela rotina nova nao foi preparado (' + FDinUltimoErro + ').');

    TNfeDinamico.pComparar(DanfeConfiguracao.dmDanfe, FResultadoTeste);
  End
  Else
  Begin
    If Not fNfeDinamicaPreparou(AChaveAcesso) Then
    Begin
      FResultadoTeste.Add('Nao foi possivel preparar o relatorio com os datasets dinamicos:');
      FResultadoTeste.Add(FDinUltimoErro);
      Exit;
    End;
    {$IF not Defined(LINUX)}
    DanfeConfiguracao.dmDanfe.frxReport.DesignReport;
    {$IFEND}
  End;
end;

function TImpressaoNFe.fNfeDinamicaPreparou(const AChaveAcesso: String): Boolean;
var
  strErro: String;
begin
  strErro := '';
  DanfeConfiguracao.dmDanfe.DinValidando := True;
  Try
    Try
      Result := Assigned(DanfeConfiguracao.PreparedReport);
      If Not Result Then
        strErro := DanfeConfiguracao.dmDanfe.frxReport.Errors.Text;
    Except
      On E: Exception Do
      Begin
        Result := False;
        strErro := E.ClassName + ': ' + E.Message;
      End;
    End;
  Finally
    DanfeConfiguracao.dmDanfe.DinValidando := False;
  End;

  FDinUltimoErro := strErro;

  If Not Result Then
    pGravaLogNfeDin(AChaveAcesso, 'Impressao dinamica da NF-e (provedor ' + cstProvedorNotaFiscal +
      ') falhou; a nota foi impressa pela rotina antiga.', strErro);
end;

procedure TImpressaoNFe.Imprimir(ACodigoEmpresa,
                                 AChaveAcesso,
                                 AImpressora       : String;
                                 blnReimpressao    : Boolean = False;
                                 blnPDF_Gerar      : Boolean = False;
                                 strPDF_Diretorio  : String  = '';
                                 blnPDF_Apresentar : Boolean = False;
                                 blnPDF_Banco      : Boolean = False;
                                 AArqXml           : String = '';
                                 ANFComp           : String = '';
                                 ALayoutSimplif    : String = '');

var
  LXml: WideString;
  intQtdVias: integer;
  I: Integer;
  strFisHis, strClaFis, strRazSoc, strEmail, strHomepage, strFone2, strCNAE, strIM, strCNPJ: String;
  blnEscolheuNaoImprimirViaNfe: Boolean;
  blnCancelada: Boolean;
  blnDinamico, blnDinFalhou: Boolean;
  blnUsaCadImpressoras, blnLayoutSimplificado, blnLayoutSmartPOS: Boolean;

  qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  function fEhLayoutSimplificado: Boolean;
  begin
    If blnPDF_Gerar And (Not fEmptyStr(ALayoutSimplif)) Then
      Result := (ALayoutSimplif = 'S')
    Else
   {$IF Defined(LINUX)}
    If blnPDF_Gerar Then
      // Geracao de PDF em servico Linux atende integracao (WS/marketplace), nunca a
      // preferencia de impressao da loja: a NF-e deve ser sempre a completa, ignorando
      // a configuracao de layout simplificado do ponto de impressao. A tag LSI, quando
      // informada pelo chamador, continua tendo precedencia (If acima).
      Result := False
    Else
   {$IFEND}
      Result := ConexaoBD.fPontoImpressaoUtilizaLayoutSimplificado(AChaveAcesso, qryDoc.FieldByName('PONIMP').AsString);
  end;

  procedure pConfiguraDanfe(ADinamico: Boolean);
  begin
    ConexaoBD.FLayoutDinamico := ADinamico;
    Try
      ConexaoBD.CarregarConfiguracao(AChaveAcesso, ACodigoEmpresa, 'NFE', NFe.NotasFiscais.Items[0].NFe.infNFe.Versao, strFisHis, strClaFis);
    Finally
      ConexaoBD.FLayoutDinamico := False;
    End;

    blnUsaCadImpressoras  := ConexaoBD.fUtilizaCadastroImpressoras {$IFDEF UNIDAC} Or fUtilizaSpoolImpressaoCitel{$ENDIF};
    blnLayoutSimplificado := fEhLayoutSimplificado;
    blnLayoutSmartPOS     := ConexaoBD.fDocumentoEmitidoSmartPOS(AChaveAcesso, qryDoc.FieldByName('OPCDOC').AsString) and not blnReimpressao;

    If (FModoTeste = 'R') Or (FModoTeste = 'P') Or (FModoTeste = 'S') Then
    Begin
      blnLayoutSimplificado := (FModoTeste = 'S');
      blnLayoutSmartPOS     := False;
      If FModoTeste = 'R' Then
        ConexaoBD.FConfiguracao.OrientacaoPagina := 1   // tiRetrato
      Else If FModoTeste = 'P' Then
        ConexaoBD.FConfiguracao.OrientacaoPagina := 2;  // tiPaisagem
    End;

    Configuracao(AImpressora,
                 AChaveAcesso,
                 blnUsaCadImpressoras,
                 blnLayoutSimplificado,
                 blnLayoutSmartPOS,
                 qryDoc.FieldByName('PONIMP').AsString);
  end;

begin
  pLogImp('Iniciando TImpressaoNFe.Imprimir()');
  pLogImp('ACodigoEmpresa....: ' + ACodigoEmpresa);
  pLogImp('AChaveAcesso......: ' + AChaveAcesso);
  pLogImp('AImpressora.......: ' + AImpressora);
  pLogImp('blnReimpressao....: ' + fBooleanToString(blnReimpressao));
  pLogImp('blnPDF_Gerar......: ' + fBooleanToString(blnPDF_Gerar));
  pLogImp('strPDF_Diretorio..: ' + strPDF_Diretorio);
  pLogImp('blnPDF_Apresentar.: ' + fBooleanToString(blnPDF_Apresentar));
  pLogImp('blnPDF_Banco......: ' + fBooleanToString(blnPDF_Banco));

  untUtil.VS_strCodEmp := ACodigoEmpresa;

  // Com o spool Citel a impressora vem do ponto de impressão: perguntar a padrão ao Windows
  // depende do Spooler e levanta "System Error. Code: 1722" quando ele está desligado.
  If fEmptyStr(AImpressora) {$IFDEF UNIDAC} And (Not fUtilizaSpoolImpressaoCitel(ACodigoEmpresa)) {$ENDIF} Then
  Begin
    AImpressora := fGetImpPadraoWindows;
    pLogImp('AImpressora.......: ' + AImpressora);
  End;

  blnCancelada := False;
  If blnReimpressao Then
    blnCancelada := ConexaoBD.fNfeCancelada(AChaveAcesso, ACodigoEmpresa);

  qryDoc := fCriaQuery(Nil);
  Try
    for I := 1 to 5 do
    begin
      pLogImp('pCarregaDados('+AChaveAcesso+') T' + IntToStr(I));

      pCarregaDados(AChaveAcesso, qryDoc, blnCancelada, ANFComp);

      if (not qryDoc.IsEmpty) or (blnCancelada) or (blnReimpressao) then
        Break;

      if (I = 5) then
      begin
        qryDoc.Close;
        blnCancelada := ConexaoBD.fNfeCancelada(AChaveAcesso, ACodigoEmpresa);
        pCarregaDados(AChaveAcesso, qryDoc, blnCancelada, ANFComp);
      end;

      Sleep(1000);
    end;

    if qryDoc.IsEmpty then
      raise Exception.Create('Não existe registro na tabela CADFIS com a chave de acesso ' + AChaveAcesso);

    If (Not fEmptyStr(AArqXml)) Then
      LXml := AArqXml
    Else
      LXml := ConexaoBD.CarregarXML(AChaveAcesso);

    NFe.NotasFiscais.Clear;
    NFe.NotasFiscais.LoadFromString(LXml);

    pTratarInformacoesAdicionais(qryDoc);
    pTratarDtaHraSai(qryDoc);
    pTratarQtdeEtiquetas(qryDoc);
    pTratarCodigoBoxRegiao(qryDoc);
    pTratarDadosProdutosGeral(qryDoc);

    if ConexaoBD.CarregarCFGSIS('CLIPRO') = 'S' then
    begin
      Nfe.DANFE.ClienteProduto := True;
      pTratarClienteProduto(qryDoc);
    end;

    strFisHis := '';
    strClaFis := '';
    if not qryDoc.IsEmpty then
    begin
      strFisHis := qryDoc.FieldByName('HISTOR').AsString;
      strClaFis := qryDoc.FieldByName('CLAFIS').AsString;
    end;

    blnDinamico := fUsaNfeDinamica(AChaveAcesso);
    blnDinFalhou := False;

    Try
      pConfiguraDanfe(blnDinamico);
    Except
      On E: Exception Do
      Begin
        If (Not blnDinamico) Or (FModoTeste <> '') Then
          Raise;
        pGravaLogNfeDin(AChaveAcesso, 'Impressao dinamica da NF-e (provedor ' + cstProvedorNotaFiscal +
          ') falhou ao carregar a configuracao/layout; a nota foi impressa pela rotina antiga.',
          E.ClassName + ': ' + E.Message);
        pLogImp('Impressao dinamica da NF-e falhou: seguindo pela rotina antiga');
        blnDinamico := False;
        pConfiguraDanfe(False);
      End;
    End;

    If blnDinamico And DanfeConfiguracao.LayoutSmartPOS Then
      blnDinamico := False;

    If blnDinamico Then
    Begin
      If Not Assigned(FDinEntrada) Then
        FDinEntrada := TNfeDinEntrada.Create;
      FDinEntrada.strProvedor := cstProvedorNotaFiscal;
      FDinEntrada.strXml      := LXml;
      FDinEntrada.strAcesso   := AChaveAcesso;
      FDinEntrada.strCodEmp   := ACodigoEmpresa;
      FDinEntrada.strNumDoc   := qryDoc.FieldByName('NUMDOC').AsString;
      FDinEntrada.strEspDoc   := qryDoc.FieldByName('ESPDOC').AsString;
      FDinEntrada.strSerie    := qryDoc.FieldByName('SERIE_').AsString;
      FDinEntrada.dsDoc       := qryDoc;
      DanfeConfiguracao.dmDanfe.DinEntrada := FDinEntrada;
      pLogImp('Impressao dinamica da NF-e ativa (provedor ' + cstProvedorNotaFiscal + ')');
    End
    Else
      DanfeConfiguracao.dmDanfe.DinEntrada := Nil;

    ConexaoBD.pGetDadosEmpresa(ACodigoEmpresa, strRazSoc, strEmail, strHomepage, strFone2, strCNAE, strIM, strCNPJ);

    NFe.DANFE.RazSoc                 := strRazSoc;
    NFe.DANFE.Email                  := strEmail;
    NFe.DANFE.HomePage               := strHomepage;
    NFe.DANFE.Fone2                  := strFone2;
    Nfe.DANFE.ImprimirTotalLiquido   := IIF(ConexaoBD.CarregarCFGSIS('VPRODN') = 'B', False, True);
    Nfe.DANFE.UFAgrupaNCM            := ConexaoBD.CarregarCFGSIS('UFANCM');
    Nfe.DANFE.CFOPTransf             := fTransform(ConexaoBD.CarregarCFGSIS('CLATRA'),4);
    Nfe.DANFE.ExibirLocalRetira      := ConexaoBD.CarregarCFGSIS('TAGEND');
    Nfe.DANFE.ExibirDuplicata        := True;
    Nfe.DANFE.ExibirDataHoraSaida    := ConexaoBD.CarregarCFGSIS('NFEDSE');

    if not qryDoc.IsEmpty then
    begin
      if not fEmptyStr(qryDoc.FieldByName('LISPED').AsString) then
        NFe.DANFE.NumeroPedidosFaturados := 'Pedidos: '+qryDoc.FieldByName('LISPED').AsString;
      NFe.DANFE.DtEntr                   := qryDoc.FieldByName('DTENTR').AsString;
      NFe.DANFE.DadosCndFpg              := fFormataCondPag(Trim(qryDoc.FieldByName('CONPAG').AsString)) + '-' + Trim(qryDoc.FieldByName('FPGPAG').AsString);
      NFe.DANFE.TomadorComplEnder        := qryDoc.FieldByName('ENDCOM').AsString;
      NFe.DANFE.TomadorCelular           := qryDoc.FieldByName('CELULA').AsString;
      NFe.DANFE.TomadorFone2             := qryDoc.FieldByName('FONE02').AsString;
      Nfe.DANFE.ExibirDuplicata          := IIF(qryDoc.FieldByName('EXIDUP').AsString='S', True, False);
      Nfe.DANFE.EntregaRetira            := IIF((qryDoc.FieldByName('ENTFAT').AsString = 'N'), 'R', 'E');
      Nfe.DANFE.TranspCodTra            := qryDoc.FieldByName('TRACOD').AsString;
      Nfe.DANFE.TranspNomTra            := qryDoc.FieldByName('TRANOM').AsString;
      Nfe.DANFE.TranspEndere            := qryDoc.FieldByName('TRAEND').AsString;
      Nfe.DANFE.TranspBairro            := qryDoc.FieldByName('TRABAI').AsString;
      Nfe.DANFE.TranspCidade            := qryDoc.FieldByName('TRACID').AsString;
      Nfe.DANFE.TranspEstado            := qryDoc.FieldByName('TRAEST').AsString;
      Nfe.DANFE.Romaneio                := qryDoc.FieldByName('BRRMDP').AsString;
      Nfe.DANFE.TelEnt                  := qryDoc.FieldByName('TELENT').AsString;
      Nfe.DANFE.Vendedor                := qryDoc.FieldByName('NOMVEN').AsString;
      Nfe.DANFE.WhatsApp                := qryDoc.FieldByName('WHATSAPP').AsString;
      Nfe.DANFE.TomadorNomFantasia      := qryDoc.FieldByName('FANSOB').AsString;
      Nfe.DANFE.NumRom                  := IfEmptyStr(qryDoc.FieldByName('NUMROM_PD').AsString, qryDoc.FieldByName('NUMROM_NF').AsString);
      Nfe.DANFE.PlacaVeiculo            := qryDoc.FieldByName('PLAVEI').AsString;
      Nfe.DANFE.KMVeiculo               := qryDoc.FieldByName('KM_VEI').AsString;
      Nfe.DANFE.PonImp                  := qryDoc.FieldByName('PONIMP').AsString;
      if not fEmptyStr(qryDoc.FieldByName('MSGDSP').AsString) then
        NFe.DANFE.InfAdicDanfeSimplificado := qryDoc.FieldByName('MSGDSP').AsString;
    end;

    {PDF}
    NFe.DANFE.PDF_Gerar      := blnPDF_Gerar;
    NFe.DANFE.PDF_Diretorio  := strPDF_Diretorio;
    NFe.DANFE.PDF_Apresentar := blnPDF_Apresentar;

    NFe.DANFE.chaveNFe := AChaveAcesso;

    NFe.DANFE.ImprimirQrCode := ConexaoBD.CarregarCFGSIS('NFEQRC') = 'S';
    if NFe.DANFE.ImprimirQrCode then
      NFe.DANFE.QrCode := ConexaoBD.fGetQrCode(AChaveAcesso, ACodigoEmpresa);

    NFe.DANFE.ImprimirQrCodeDadosAdicionais := ConexaoBD.CarregarCFGSIS('QRCNFE') = 'S';
    if NFe.DANFE.ImprimirQrCodeDadosAdicionais then
      NFe.DANFE.QrCodeDadosAdicionais := ConexaoBD.CarregarCFGSIS('URLNFE');

    blnEscolheuNaoImprimirViaNfe := False;

    if DanfeConfiguracao.LayoutSimplificado And (Not fEmptyStr(ConexaoBD.CarregarCFGSIS('VIANSI'))) then
    Begin
      intQtdVias := StrToIntDef(ConexaoBD.CarregarCFGSIS('VIANSI'), 1);
      If (fTemPontoDeImpressaoLayoutSimplificado(ACodigoEmpresa)) Then
      Begin
        pLogImp('fTemPontoDeImpressaoLayoutSimplificado = True');
        If (qryDoc.FieldByName('VIANFE').AsInteger > 0) Then
          intQtdVias := qryDoc.FieldByName('VIANFE').AsInteger;
      End;
      pLogImp('DanfeConfiguracao.LayoutSimplificado = True, intQtdVias = '+IntToStr(intQtdVias));
    End
    Else
    Begin
      intQtdVias := StrToIntDef(ConexaoBD.CarregarCFGSIS('VIANFE'), 1);
      If (qryDoc.FieldByName('VIANFE').AsInteger >= 0) Then
      Begin
        intQtdVias := qryDoc.FieldByName('VIANFE').AsInteger;
        blnEscolheuNaoImprimirViaNfe := (intQtdVias = 0);
      End;
    End;

    If fEhSomenteUmaVia(blnPDF_Gerar, blnReimpressao, intQtdVias, blnEscolheuNaoImprimirViaNfe) Then
    Begin
      intQtdVias := 1;
      pLogImp('fEhSomenteUmaVia = True - blnPDF_Gerar: ' + BoolToStr(blnPDF_Gerar) + ' - blnReimpressao: ' + BoolToStr(blnReimpressao));
    End;

    Nfe.DANFE.Reimpressao := blnReimpressao;

    if (DanfeConfiguracao.LayoutSimplificado) And (ConexaoBD.CarregarCFGSIS('DFSPVL') = 'S') then
    begin
      intQtdVias := 1;
      if not qryDoc.IsEmpty then
      begin
        Nfe.DANFE.QtdVolume := qryDoc.FieldByName('VOLUME').AsInteger;
        intQtdVias := Nfe.DANFE.QtdVolume;
      end;
    end;

    If FModoTeste <> '' Then
    Begin
      pExecutaModoTeste(AChaveAcesso, blnDinamico);
      Exit;
    End;

    If blnDinamico And (Not fNfeDinamicaPreparou(AChaveAcesso)) Then
    Begin
      blnDinFalhou := True;
      DanfeConfiguracao.dmDanfe.DinEntrada := Nil;
      ConexaoBD.CarregarConfiguracao(AChaveAcesso, ACodigoEmpresa, 'NFE', NFe.NotasFiscais.Items[0].NFe.infNFe.Versao, strFisHis, strClaFis);
      Configuracao(AImpressora,
                   AChaveAcesso,
                   blnUsaCadImpressoras,
                   blnLayoutSimplificado,
                   blnLayoutSmartPOS,
                   qryDoc.FieldByName('PONIMP').AsString);
      pLogImp('Impressao dinamica da NF-e falhou: seguindo pela rotina antiga');
    End;

    Try
      If Not blnPDF_Banco Then
      Begin
        pLogImp('NFe.NotasFiscais.Imprimir > intQtdVias = '+IntToStr(intQtdVias));
        for i := 1 to intQtdVias do
        begin
          Nfe.DANFE.NumDaVia := i;

          NFe.NotasFiscais.Imprimir;

          if intQtdVias > 1 then
          begin
            Sleep(1000);
          end;
        end;
      End;

      If Assigned(ConexaoBD) Then
      Begin
        If DanfeConfiguracao.PreparouRelatorio And (Not (blnDinFalhou And blnPDF_Banco)) Then
          ConexaoBD.pSalvarDFePDF(DanfeConfiguracao.dmDanfe.frxReport, AChaveAcesso, fEhLayoutSimplificado)
        Else
          ConexaoBD.pSalvarDFePDF(DanfeConfiguracao.PreparedReport, AChaveAcesso, fEhLayoutSimplificado)
      End;
    Except
      On E: Exception Do
      Begin
        If Assigned(DanfeConfiguracao.dmDanfe.DinEntrada) Then
          pGravaLogNfeDin(AChaveAcesso, 'Impressao dinamica da NF-e (provedor ' + cstProvedorNotaFiscal +
            ') falhou na impressao, depois da validacao; a impressao foi interrompida.',
            E.ClassName + ': ' + E.Message);
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryDoc);
  End;

  pLogImp('Finalizou TImpressaoNFe.Imprimir()');
end;

procedure TImpressaoNFe.GerarBMP(ACodigoEmpresa, AChaveAcesso, APathBMP: String);
// Renderiza a DANFE usando o layout NFE_LAYUNI e exporta como BMP para APathBMP.
// Segue o mesmo padrao de Imprimir() mas sem impressao fisica e sem PDF.
// ExitCode permanece inalterado aqui - quem chama (pGerarBMP_LayoutUnificado)
// e responsavel por setar ExitCode conforme o resultado.
Var
  LXml        : WideString;
  qryDoc      : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strFisHis   : String;
  strClaFis   : String;
begin
  pLogImp('TImpressaoNFe.GerarBMP > ' + AChaveAcesso);

  untUtil.VS_strCodEmp := ACodigoEmpresa;

  qryDoc := fCriaQuery(Nil);
  Try
    pCarregaDados(AChaveAcesso, qryDoc, False);

    If qryDoc.IsEmpty Then
      raise Exception.Create('GerarBMP: sem registro CADFIS para chave ' + AChaveAcesso);

    LXml := ConexaoBD.CarregarXML(AChaveAcesso);
    NFe.NotasFiscais.Clear;
    NFe.NotasFiscais.LoadFromString(LXml);

    pTratarInformacoesAdicionais(qryDoc);
    pTratarDtaHraSai(qryDoc);
    pTratarQtdeEtiquetas(qryDoc);
    pTratarCodigoBoxRegiao(qryDoc);
    pTratarDadosProdutosGeral(qryDoc);

    strFisHis := '';
    strClaFis := '';
    If Not qryDoc.IsEmpty Then
    Begin
      strFisHis := qryDoc.FieldByName('HISTOR').AsString;
      strClaFis := qryDoc.FieldByName('CLAFIS').AsString;
    End;

    ConexaoBD.CarregarConfiguracao(AChaveAcesso, ACodigoEmpresa, 'NFE',
      NFe.NotasFiscais.Items[0].NFe.infNFe.Versao, strFisHis, strClaFis);

    If Trim(ConexaoBD.FConfiguracao.LayoutUnificado) = '' Then
      raise Exception.Create('GerarBMP: NFE_LAYUNI vazio para empresa ' + ACodigoEmpresa);

    DanfeConfiguracao.Sistema      := 'NF-e desenvolvida por www.citelsoftware.com.br';
    DanfeConfiguracao.MostrarStatus  := False;
    DanfeConfiguracao.MostrarPreview := False;
    DanfeConfiguracao.Impressora     := '';
    DanfeConfiguracao.NFeCancelada   := ConexaoBD.FConfiguracao.NfeCancelada;
    DanfeConfiguracao.Logo           := ConexaoBD.FConfiguracao.Logo;
    DanfeConfiguracao.FastFile       := AtualizarFastFile(ConexaoBD.FConfiguracao.LayoutUnificado);

    NFe.DANFE.chaveNFe := AChaveAcesso;

    // Nao chama NFe.NotasFiscais.Imprimir para evitar impressao fisica.
    // pSalvarDFEBMP chama PrepareReport internamente se PreviewPages.Count = 0.
    ConexaoBD.pSalvarDFEBMP(DanfeConfiguracao.PreparedReport, APathBMP);

    pLogImp('TImpressaoNFe.GerarBMP < OK > ' + APathBMP);
  Finally
    FreeAndNil(qryDoc);
  End;
end;

procedure TImpressaoNFe.pTratarDtaHraSai(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
begin
  if not qryDoc.IsEmpty then
  begin
    if not qryDoc.FieldByName('DTESNF').IsNull then
      NFe.DANFE.Dtsai := qryDoc.FieldByName('DTESNF').AsDateTime;

    if not qryDoc.FieldByName('HRESNF').IsNull then
      Nfe.DANFE.Hrsai := qryDoc.FieldByName('HRESNF').AsDateTime;
  end;
end;

procedure TImpressaoNFe.pTratarClienteProduto(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
var
  intProd: integer;
  nota: ACBrNFeNotasFiscais.NotaFiscal;
  detItem: untNFe.TDetCollectionItem;
  strCodIteAutCom: String;

  function fLocCodIteAutCom(const strCod_Nf: String): String;
  begin
    Result := '';
    If (Not qryDoc.IsEmpty) Then
    Begin
      qryDoc.First;
      If qryDoc.Locate('COD_NF', strCod_Nf, []) Then
        Result := qryDoc.FieldByName('CODITE').AsString;
    End;
  end;

begin
  if (ConexaoBD.CarregarCFGSIS('NFEITE') = '1') then
  begin
    for intProd := 0 to NFe.NotasFiscais.Items[0].NFe.Det.Count - 1 do
    begin
      nota := NFe.NotasFiscais.Items[0];
      detItem := nota.NFe.Det.Items[intProd];
      strCodIteAutCom := fLocCodIteAutCom(detItem.Prod.cProd);
      detItem.Prod.cCodIte := strCodIteAutCom;
    end;
  end;
end;

procedure TImpressaoNFe.pTratarQtdeEtiquetas(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
var
  intProd: integer;
  nota: ACBrNFeNotasFiscais.NotaFiscal;
  detItem: untNFe.TDetCollectionItem;
  fltMltVen : Double;
  fltMltCom : Double;
  fltQtdEtq : Double;
begin
  if (ConexaoBD.CarregarCFGSIS('TIPVOL') = '3') then
  begin
    for intProd := 0 to NFe.NotasFiscais.Items[0].NFe.Det.Count - 1 do
    begin
      nota      := NFe.NotasFiscais.Items[0];
      detItem   := nota.NFe.Det.Items[intProd];

      fltMltVen := fRetMultiploVendaOuCompra(qryDoc, 'MLTVEN', detItem.Prod.cProd, intProd);
      fltMltCom := fRetMultiploVendaOuCompra(qryDoc, 'MLTCOM', detItem.Prod.cProd, intProd);

      fltQtdEtq := Ceil(Trunc(detItem.Prod.QCom / fltMltCom) + ((detItem.Prod.QCom - (Trunc(detItem.Prod.QCom / fltMltCom) * fltMltCom)) / fltMltVen));
      detItem.Prod.QtdEtq := fltQtdEtq;
    end;
  end;
end;

procedure TImpressaoNFe.pTratarCodigoBoxRegiao(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
begin
  if not qryDoc.IsEmpty then
  begin
    if not qryDoc.FieldByName('BOXSEP').IsNull then
      NFe.DANFE.CodBox := qryDoc.FieldByName('BOXSEP').AsString;
    if not qryDoc.FieldByName('DESREG').IsNull then
      NFe.DANFE.DesReg := qryDoc.FieldByName('DESREG').AsString;
  end;
end;

procedure TImpressaoNFe.pTratarInformacoesAdicionais(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
  Var
   strInfCplXml, strInfAdFiscoXml: string;
   strInfCplMovObs, strInfAdFiscoMovObs: string;
   strModalidades, strValores, strCarConPag, strParcelasCartao : string;
   stlPalavrasChaveQuebraTexto: TStringList;
   stlInformacaoGravadaMovObs : TStringList;
   intIdx, intNFRef: Integer;
   strClaFis, strClaFisFin, strChaveNFRef : String;
   vBCSTRet : Double;
   pST : Double;
   vICMSSubstituto : Double;
   vICMSSTRet : Double;
   strModalidadeValor: string;
   strDescrCartao: String;
begin
  strModalidades     := '';
  strValores         := '';
  strCarConPag       := '';
  strParcelasCartao  := '';
  strChaveNFRef      := '';
  strModalidadeValor := '';
  strDescrCartao     := '';
  vBCSTRet          := 0;
  pST               := 0;
  vICMSSubstituto   := 0;
  vICMSSTRet        := 0;

  stlPalavrasChaveQuebraTexto := TStringList.Create;
  stlInformacaoGravadaMovObs  := TStringList.Create;

  stlPalavrasChaveQuebraTexto.Add('NÃO APLICA DIFAL DA EMENDA');
  stlPalavrasChaveQuebraTexto.Add('Vlr Aprox dos Tributos');
  stlPalavrasChaveQuebraTexto.Add('Valor do ICMS DIFAL devido');
  stlPalavrasChaveQuebraTexto.Add('BC.FCP R$');
  stlPalavrasChaveQuebraTexto.Add('BC.FCP.ST R$');
  stlPalavrasChaveQuebraTexto.Add('BC.FCP.DIFAL R$');
  stlPalavrasChaveQuebraTexto.Add('ICMS DESONERADO: R$');
  stlPalavrasChaveQuebraTexto.Add('Total de IPI Devolvido:');
  stlPalavrasChaveQuebraTexto.Add('BC.ST Retido R$');
  stlPalavrasChaveQuebraTexto.Add('BC.Efetivo R$');

  if not qryDoc.IsEmpty then
  begin
    // Tratativa criada no requisito: 404310
    // Problema ocorre em notas fiscais canceladas, pois esse tratativa leva em conta a String exata
    // Porem na DEL_MOVOBS os caracteres de controle são perdidos.
    if ((qryDoc.FindField('HISTOR') <> Nil) and (qryDoc.FieldByName('HISTOR').AsString <> 'CANCELADO')) Then
    Begin
      strInfCplMovObs := ReplaceStr(qryDoc.FieldByName('OBSERV').AsString, '#', sLineBreak);
      strInfCplMovObs := ReplaceStr(strInfCplMovObs, ';', ',');
      strInfCplMovObs := Trim(fTrataCaracteresEspeciais(fTiraCaracEspeciais(strInfCplMovObs, False, False, False, False, False, True, True)));

      strInfAdFiscoMovObs := ReplaceStr(qryDoc.FieldByName('OBSFIS').AsString, '#', sLineBreak);
      strInfAdFiscoMovObs := ReplaceStr(strInfAdFiscoMovObs, ';', ',');
      strInfAdFiscoMovObs := Trim(fTrataCaracteresEspeciais(fTiraCaracEspeciais(strInfAdFiscoMovObs, False, False, False, False, False, True, True)));

      strInfCplXml := ReplaceStr(NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl, ';', ',');
      strInfCplXml := Trim(fTrataCaracteresEspeciais(fTiraCaracEspeciais(strInfCplXml, False, False, False, False, False, True, True)));

      strInfAdFiscoXml := ReplaceStr(NFe.NotasFiscais.Items[0].NFe.InfAdic.infAdFisco, ';', ',');
      strInfAdFiscoXml := Trim(fTrataCaracteresEspeciais(fTiraCaracEspeciais(strInfAdFiscoXml, False, False, False, False, False, True, True)));

      //Remove as mensagens que já estão gravadas na tabela MOVOBS (mensagem comercial)
      stlInformacaoGravadaMovObs.Text := strInfCplMovObs;
      For intIdx := 0 To stlInformacaoGravadaMovObs.Count -1 Do
        strInfCplXml := ReplaceStr(strInfCplXml, Trim(stlInformacaoGravadaMovObs[intIdx]), '');

      //Remove as mensagens que já estão gravadas na tabela MOVOBS (mensagem fiscal)
      stlInformacaoGravadaMovObs.Text := strInfAdFiscoMovObs;
      For intIdx := 0 To stlInformacaoGravadaMovObs.Count -1 Do
        strInfAdFiscoXml := ReplaceStr(strInfAdFiscoXml, Trim(stlInformacaoGravadaMovObs[intIdx]), '');

      //Faz a quebra de linha em palavras chave (como por exemplo "Valor do ICMS DIFAL")
      For intIdx := 0 To stlPalavrasChaveQuebraTexto.Count -1 Do
      Begin
        strInfCplXml := ReplaceStr(strInfCplXml, stlPalavrasChaveQuebraTexto[intIdx], sLineBreak + stlPalavrasChaveQuebraTexto[intIdx]);
        strInfAdFiscoXml := ReplaceStr(strInfAdFiscoXml, stlPalavrasChaveQuebraTexto[intIdx], sLineBreak + stlPalavrasChaveQuebraTexto[intIdx]);
      End;

      strInfCplXml := strInfCplMovObs + sLineBreak + strInfCplXml;
      strInfAdFiscoXml := strInfAdFiscoMovObs + sLineBreak + strInfAdFiscoXml;

      if (ConexaoBD.CarregarCFGSIS('INFFPG') = 'S') then
      begin
        ConexaoBD.pCarregaModalidadesPagamento(qryDoc.FieldByName('VLRCON').AsFloat,
                                               qryDoc.FieldByName('NUMDOC').AsString,
                                               qryDoc.FieldByName('ESPDOC').AsString,
                                               qryDoc.FieldByName('CODEMP').AsString,
                                               ' ',
                                               qryDoc.FieldByName('SERIE_').AsString,
                                               strModalidades,
                                               strValores,
                                               strCarConPag,
                                               strParcelasCartao,
                                               strDescrCartao);
      end;

      if (ConexaoBD.CarregarCFGSIS('MODVAL') = 'S') then
        ConexaoBD.pGetModalidade(qryDoc.FieldByName('NUMDOC').AsString,
                                 qryDoc.FieldByName('ESPDOC').AsString,
                                 qryDoc.FieldByName('CODEMP').AsString,
                                 strModalidadeValor);

      if not fEmptyStr(strModalidades) then
        strInfCplXml := strInfCplXml + strModalidades;

      if not fEmptyStr(strModalidadeValor) then
        strInfCplXml := strInfCplXml + strModalidadeValor;

      //Remove o execesso de quebras de linhas
      While Pos(sLineBreak + sLineBreak, strInfCplXml) > 0 Do
        strInfCplXml := ReplaceStr(strInfCplXml, sLineBreak + sLineBreak, sLineBreak);

      While Pos(sLineBreak + sLineBreak, strInfAdFiscoXml) > 0 Do
        strInfAdFiscoXml := ReplaceStr(strInfAdFiscoXml, sLineBreak + sLineBreak, sLineBreak);

      //Atualiza a mensagem agora já com as quebras de linha tratada
      NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := strInfCplXml;
      NFe.NotasFiscais.Items[0].NFe.InfAdic.infAdFisco := strInfAdFiscoXml;

      if (NFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.UF = 'SP') then
      begin
        strClaFis    := qryDoc.FieldByName('CLAFIS').AsString;
        strClaFisFin := RightStr(strClaFis, 3);

        for intNFRef := 0 to NFe.NotasFiscais.Items[0].NFe.Ide.NFref.Count - 1 do
          strChaveNFRef := strChaveNFRef + IIF(strChaveNFRef<>'', ', ', '') + NFe.NotasFiscais.Items[0].NFe.Ide.NFref.Items[intNFRef].refNFe;

        if (not fEmptyStr(strChaveNFRef)) then
        begin
          if (Pos(strClaFis, fCfgSis('FATCON')) > 0) then //faturamento consignação
            NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl + ' ' + 'CHAVE NF-E REFERENCIADA: ' + strChaveNFRef + ' - SIMPLES FATURAMENTO DE MERCADORIA EM CONSIGNACAO' + sLineBreak;

          if (Pos(strClaFis, fCfgSis('RETCON')) > 0) then //retorno consignação
            NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl + ' ' + 'CHAVE NF-E REFERENCIADA: ' + strChaveNFRef + ' - DEVOLUCAO (PARCIAL OU TOTAL) DE MERCADORIA EM CONSIGNACAO' + sLineBreak;

          if ((Pos(strClaFisFin, fCfgSis('CLADEM')) > 0)  or    //devolução demonstração
              (Pos(strClaFisFin, fCfgSis('CLAEFV')) > 0)  or    //baixa entrega futura (venda)
              (Pos(strClaFisFin, fCfgSis('CLAEFI')) > 0)) then  //baixa entrega futura (industrialização)
            NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl + ' ' + 'CHAVE NF-E REFERENCIADA: ' + strChaveNFRef + sLineBreak;

          if (Pos(strClaFisFin, fCfgSis('CLARCO')) > 0) then //remessa por conta e ordem
            NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl + ' ' + 'CHAVE NF-E REFERENCIADA: ' + strChaveNFRef + ' - NF-E EMITIDA NOS TERMOS DO ANEXO II DA PORTARIA SRE N.: 41, 21-06 2023' + sLineBreak;

          if (strClaFis = '5411') and (qryDoc.FieldByName('TIP_FC').AsString='F') then
            NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl + strChaveNFRef + sLineBreak;

        end;
      end;

      if Assigned(qryDoc.FindField('CUPCNF')) And (qryDoc.FieldByName('CLAFIS').AsString = '5929') And
         Not qryDoc.FieldByName('CUPCNF').IsNull then
        NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl + ' ' + qryDoc.FieldByName('CUPCNF').AsString + sLineBreak;

      if not fEmptyStr(NFe.NotasFiscais.Items[0].NFe.InfIntermed.CNPJ) then
        NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl +
                                                        sLineBreak + 'INTERMEDIADOR: '+
                                                        fFormataCpfCgc(NFe.NotasFiscais.Items[0].NFe.InfIntermed.CNPJ) + '-' +
                                                        NFe.NotasFiscais.Items[0].NFe.InfIntermed.idCadIntTran + sLineBreak;

      for intIdx := 0 to NFe.NotasFiscais.Items[0].NFe.Det.Count - 1 do
      begin

        vBCSTRet        := vBCSTRet        + NFe.NotasFiscais.Items[0].NFe.Det.Items[intIdx].Imposto.ICMS.vBCSTRet;
        pST             := pST             + NFe.NotasFiscais.Items[0].NFe.Det.Items[intIdx].Imposto.ICMS.pST;
        vICMSSubstituto := vICMSSubstituto + NFe.NotasFiscais.Items[0].NFe.Det.Items[intIdx].Imposto.ICMS.vICMSSubstituto;
        vICMSSTRet      := vICMSSTRet      + NFe.NotasFiscais.Items[0].NFe.Det.Items[intIdx].Imposto.ICMS.vICMSSTRet;

      end;

      NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl := NFe.NotasFiscais.Items[0].NFe.InfAdic.infCpl +
                                                      iif(vBCSTRet > 0, 'BC.ST Retido R$ '+FormatFloatBr( vBCSTRet ,'###,###,##0.00'), '')+
                                                      iif(pST > 0, ' % ST '+FormatFloatBr( pST ,'###,###,##0.00'), '')+
                                                      iif(vICMSSubstituto > 0, ' Vr.ICMS Substituto R$ '+FormatFloatBr( vICMSSubstituto ,'###,###,##0.00'), '')+
                                                      iif(vICMSSTRet > 0, ' Vr.ST Retido R$ '+FormatFloatBr( vICMSSTRet ,'###,###,##0.00'), '');
    end;
  End;

  FreeAndNil(stlPalavrasChaveQuebraTexto);
  FreeAndNil(stlInformacaoGravadaMovObs);
end;

procedure TImpressaoNFe.pTratarDadosProdutosGeral(qryDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
var
  intProd: integer;
  nota: ACBrNFeNotasFiscais.NotaFiscal;
  detItem: untNFe.TDetCollectionItem;
  strCodIte: String;
  intOrdIte: Integer;

  function fLocateAsFloat(const aValOri: Double; strField: String): Double;
  begin
    Result := aValOri;

    If (Not qryDoc.IsEmpty) Then
    Begin
      qryDoc.First;
      If qryDoc.Locate('ORDITE;CODITE', VarArrayOf([intOrdIte+1, strCodIte]), []) Then
        Result := qryDoc.FieldByName(strField).AsFloat
      Else If qryDoc.Locate('CODITE', strCodIte, []) Then
        Result := qryDoc.FieldByName(strField).AsFloat;
    End;
  end;

  function fLocateAsString(const aValOri: String; strField: String): String;
  begin
    Result := aValOri;

    If (Not qryDoc.IsEmpty) Then
    Begin
      qryDoc.First;
      If qryDoc.Locate('ORDITE;CODITE', VarArrayOf([intOrdIte+1, strCodIte]), []) Then
        Result := qryDoc.FieldByName(strField).AsString
      Else If qryDoc.Locate('CODITE', strCodIte, []) Then
        Result := qryDoc.FieldByName(strField).AsString;
    End;
  end;

begin
  for intProd := 0 to NFe.NotasFiscais.Items[0].NFe.Det.Count - 1 do
  begin
    nota := NFe.NotasFiscais.Items[0];
    detItem := nota.NFe.Det.Items[intProd];

    strCodIte := detItem.Prod.cProd;
    intOrdIte := intProd;

    detItem.Prod.Referencia := fLocateAsString(detItem.Prod.Referencia, 'REFITE');
    detItem.Prod.Comple     := fLocateAsString(detItem.Prod.Comple, 'COMPLE');
    detItem.Prod.xDeptoProd := fLocateAsString(detItem.Prod.xDeptoProd, 'DESDEP');
    detItem.Prod.COD_NF     := fLocateAsString(detItem.Prod.COD_NF, 'COD_NF');
    detItem.Prod.PesoBruto  := fLocateAsFloat(detItem.Prod.PesoBruto, 'PESBRU');
    detItem.Prod.PesoLiq    := fLocateAsFloat(detItem.Prod.PesoLiq, 'PESLIQ');
    detItem.Prod.PorcDESESP := fLocateAsFloat(detItem.Prod.PorcDESESP, 'PERNOV');
    detItem.Prod.nQuantidadeEmbalagem := (detItem.Prod.QCom / fRetMultiploVendaOuCompra(qryDoc, 'MLTVEN', detItem.Prod.cProd, intProd));
    detItem.Prod.LocAdi     := fLocateAsString(detItem.Prod.LocAdi, 'LOCADI');
  end;
end;

function TImpressaoNFe.AtualizarFastFile(AConteudo : string): string;
var
  LTexto : TStrings;
//  I : integer;
begin
  Result := EmptyStr;

  if AConteudo = EmptyStr then
    Exit;

  LTexto := TStringList.Create;
  try
    LTexto.Delimiter := #13;
    LTexto.CommaText := #13;
    LTexto.Text := AConteudo;
//    for I := 0 to LTexto.Count - 1 do
//    begin
//      if Pos('"memSistema"', LTexto.Strings[i]) > 0 then
//      begin
////        LTexto.Delete(I);
////        Break;
//      end;
//    end;
    Result := LTexto.Text;
  finally
    LTexto.Free;
  end;
end;

procedure TImpressaoNFe.Configuracao(AImpressora, AChaveAcesso: string;
                                     blnUsaCadImpressoras, ALayoutSimplificado, ALayoutSmartPOS: Boolean;
                                     AstrPonImp: String='');

  function RetornaMascaraQtd(AQtdCasasDecimais:Integer): string;
  begin
    Result := '#,###,##0';
    if (AQtdCasasDecimais > 0) then
      Result := Result + '.' + StringOfChar('0', AQtdCasasDecimais);
  end;

var
  blOK : Boolean;
  LImpressora: string;
  LImpressoraSpool: String;
begin
  LImpressora := AImpressora;

  if fEhParaImprimir(AImpressora) then
  Begin
  {$IFDEF UNIDAC}
    if fUtilizaSpoolImpressaoCitel(VS_strCodEmp) then
    Begin
      if not TSpoolImpressaoCitel.fGetPontoImpressao(LImpressora).Existe then
        LImpressoraSpool := ConexaoBD.fRetornaNomeImpressoraSpoolerImpressaoCitel(AChaveAcesso, AstrPonImp);
      if (LImpressoraSpool <> '') then
        LImpressora := LImpressoraSpool;
    End
    Else
  {$ENDIF}
    Begin
      LImpressora := ConexaoBD.fAcharImpressoraPeloPonto(LImpressora);
      LImpressora := ConexaoBD.fIdentificarNomeDaImpressora(LImpressora);
    End;
  End;

  pLogImp('fPreImpressao(' + LImpressora + ')');

  fPreImpressao(LImpressora, blnUsaCadImpressoras);

  DanfeConfiguracao.Sistema := 'NF-e desenvolvida por www.citelsoftware.com.br';

  DanfeConfiguracao.ExibirTotalTributos := False;
  DanfeConfiguracao.ExibirTotalTributosItem := False;
  DanfeConfiguracao.ExibeCampoFatura := IIF(fCfgSis('EXIFAT', VS_strCodEmp) = 'S', True, False);
  DanfeConfiguracao.ExibirLocalEntrega := False;
  DanfeConfiguracao.ExibirLocalRetirada := False;
  DanfeConfiguracao.ImprimirDetalhamentoEspecifico := False;

  DanfeConfiguracao.MostrarStatus   := False;
  DanfeConfiguracao.MostrarPreview  := False;
  DanfeConfiguracao.Impressora      := LImpressora;
  pLogImp('DanfeConfiguracao.Impressora = ' + LImpressora);
  DanfeConfiguracao.NFeCancelada    := ConexaoBD.FConfiguracao.NfeCancelada;

  DanfeConfiguracao.MargemEsquerda  := 0.0;
  DanfeConfiguracao.MargemSuperior  := 0.0;
  DanfeConfiguracao.MargemDireita   := 0.0;
  DanfeConfiguracao.MargemInferior  := 0.0;

  DanfeConfiguracao.CasasDecimais.Formato       := tdetMascara;
  DanfeConfiguracao.CasasDecimais._qCom         := ConexaoBD.FConfiguracao.QuantidadeDecimal;
  DanfeConfiguracao.CasasDecimais._vUnCom       := ConexaoBD.FConfiguracao.ValorUnDecimal;
  DanfeConfiguracao.CasasDecimais._Mask_qCom    := RetornaMascaraQtd(ConexaoBD.FConfiguracao.QuantidadeDecimal);
  DanfeConfiguracao.CasasDecimais._Mask_vUnCom  := RetornaMascaraQtd(ConexaoBD.FConfiguracao.ValorUnDecimal);

  DanfeConfiguracao.ImprimirUnQtVlComercial       := iuComercialETributavel;
  DanfeConfiguracao.ImprimirDadosDocReferenciados := False;
  DanfeConfiguracao.PosCanhoto                    := TPosRecibo( ConexaoBD.FConfiguracao.PosicaoRecibo );
  DanfeConfiguracao.Logo                          := ConexaoBD.FConfiguracao.Logo;
  DanfeConfiguracao.TipoDANFE                     := StrToTpImp(blOK, IntToStr(ConexaoBD.FConfiguracao.OrientacaoPagina) );
  DanfeConfiguracao.ClassifiVenda                 := ConexaoBD.FConfiguracao.ClassifiVenda;

  If ALayoutSimplificado And Not fEmptyStr(ConexaoBD.FConfiguracao.LayoutSimplificado) Then
  Begin
    pLogImp('Carregando layout modelo simplificado');
    DanfeConfiguracao.FastFile := AtualizarFastFile(ConexaoBD.FConfiguracao.LayoutSimplificado);
    DanfeConfiguracao.LayoutSimplificado := True;
  End
  Else If ALayoutSmartPOS And Not fEmptyStr(ConexaoBD.FConfiguracao.LayoutSmartPOS) Then
  Begin
    pLogImp('Carregando layout modelo Smart POS');
    DanfeConfiguracao.FastFile := AtualizarFastFile(ConexaoBD.FConfiguracao.LayoutSmartPOS);
    DanfeConfiguracao.LayoutSmartPOS := True;
  End
  Else
  Begin
    DanfeConfiguracao.LayoutSimplificado := False;
    DanfeConfiguracao.LayoutSmartPOS := False;
    case DanfeConfiguracao.TipoDANFE of
      tiPaisagem :
        Begin
          pLogImp('Carregando layout paisagem');
          DanfeConfiguracao.FastFile := AtualizarFastFile(ConexaoBD.FConfiguracao.LayoutPaisagem);
        End;
      tiRetrato:
        Begin
          pLogImp('Carregando layout retrato');
          DanfeConfiguracao.FastFile := AtualizarFastFile(ConexaoBD.FConfiguracao.LayoutRetrato);
        End;
    end;
  End;

  DanfeConfiguracao.MarcaDagua                    := ConexaoBD.FConfiguracao.MarcaDagua;
  DanfeConfiguracao.ImprimeTagObsCont             := ConexaoBD.FConfiguracao.ImprimeTagObsCont;
end;

function TImpressaoNFe.fTemPontoDeImpressaoLayoutSimplificado(const strCodEmp : String): Boolean;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;
  If fEmptyStr(strCodEmp) Then
    Exit;
  If (Not fTabelaExiste('PONIMP')) Then
    Exit;
  If (Not fCampoExiste('PONIMP', 'PON_NFESIM')) Then
    Exit;
  If (Not fCampoExiste('PONIMP', 'PON_VIAPON')) Then
    Exit;
  qryGen := fCriaQuery(Nil);
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qryGen.SQL.Add('   FROM PONIMP ');
    qryGen.SQL.Add('  WHERE PON_NFESIM = "S" ');
    qryGen.SQL.Add('    AND PON_CODEMP = :CODEMP ');
    qryGen.SQL.Add('    AND PON_VIAPON > 0 ');
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.Open;
    Result := (qryGen.FieldByName('CNT').AsInteger > 0);
  Finally
    FreeAndNil(qryGen)
  End;
end;

procedure pCarregarModulos;
begin
  pAbrirBanco(frmModulo);
end;

procedure pFinalizarModulos;
begin
  pGeraRegistroParaLogGeneral(frmModulo.Database, 'pFinalizarModulos > frmModulo.Database.Disconnect');

  frmModulo.Database.Disconnect;

  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
end;

function fExisteXML(const strTarefa: string;
                    var   strCodEmp: string;
                    var   strArqXml: string;
                    var   strNFComp: string;
                    const strChaAce: String): Boolean;
var
  ValidadorXML: TValidadorXML;
begin
  Result := True;

  If Pos('RG_IMPRIMIR', strTarefa) > 0 Then
    Exit;

  If Pos('MDFE_IMPRIMIR', strTarefa) > 0 Then
    Exit;

  ValidadorXML := TValidadorXML.Create();
  try
    Result := ValidadorXML.fExisteXML(strCodEmp,  // Código Empresa
                                      strArqXml,  // Conteúdo do campo XMLNFE->NFE_ARQXML (Caso Encontre) (Arquivo XML)
                                      strNFComp,  // Conteúdo do campo CADFIS->FIS_NFCOMP (Caso Encontre) (Nota de Complemento)
                                      strChaAce); // Chave de Acesso
  finally
    ValidadorXML.Free;
  end;
end;

procedure pGerarBMP_LayoutUnificado(AstrCodEmp, AstrChaAce, AstrDir, AstrLayUni: String);
Var
  DanfeNFe   : TImpressaoNFe;
  strPathBMP : String;
begin
  pLogImp('pGerarBMP_LayoutUnificado > ' + AstrChaAce);

  If UpperCase(AstrLayUni) <> 'S' Then
  Begin
    pLogImp('pGerarBMP_LayoutUnificado < LUN <> S > ExitCode := 1');
    ExitCode := 1;
    Exit;
  End;

  If fEmptyStr(AstrChaAce) Then
  Begin
    pLogImp('pGerarBMP_LayoutUnificado < CHA vazio > ExitCode := 1');
    ExitCode := 1;
    Exit;
  End;

  If fEmptyStr(AstrDir) Then
  Begin
    pLogImp('pGerarBMP_LayoutUnificado < DIR vazio > ExitCode := 1');
    ExitCode := 1;
    Exit;
  End;

  strPathBMP := IncludeTrailingPathDelimiter(AstrDir) +
                'etq-unif-' + AstrChaAce + '.bmp';

  DanfeNFe := TImpressaoNFe.Create();
  Try
    Try
      DanfeNFe.GerarBMP(AstrCodEmp, AstrChaAce, strPathBMP);
      ExitCode := 0;
    Except
      On E: Exception Do
      Begin
        pLogImp('pGerarBMP_LayoutUnificado ERRO: ' + E.Message);
        ExitCode := 1;
      End;
    End;
  Finally
    FreeAndNil(DanfeNFe);
  End;

  pLogImp('pGerarBMP_LayoutUnificado < ExitCode=' + IntToStr(ExitCode));
end;

procedure pTarefaImprimir();
Var
  intQtdMaxPar,
  intParam: Integer;

  strParams: String;
  strMsgAux: String;
  strParFis: String;

  strNFComp,
  strArqXml,
  strTarefa,
  strCodEmp,
  strChaAce,
  strNomImp,
  strReimpr,
  strPDFDir,
  strPDFApr,
  strNumDoc,
  strEspDoc,
  strCodCli,
  strModDsg,
  strLaySim,
  strLayUni: String;

  DanfeNFe  : TImpressaoNFe;
  DanfeNFCe : TImpressaoNFCe;
  DanfeRG   : TImpressaoRG;
  DanfeNFS  : TImpressaoNFS;
  DanfeCCe  : TImpressaoCCe;
  DanfeMDFe : TImpressaoMDFe;
  DanfeCTe  : TImpressaoCTe;

  blnReimpressao : Boolean;
  blnPDF_Apresentar : Boolean;

  blnTodosParametosPorTag: Boolean;
  blnTodosParametosPorPos: Boolean;

  function fTemCondicaoMinimaParaGerarPDF: Boolean;
  begin
    Result := True;

    If fEmptyStr(strChaAce) Then
    Begin
      pLogImp('CHAVE DE ACESSO VAZIA');
      Result := False;
    End;

    If fExistePdfNfe(strChaAce) Then
    Begin
      pLogImp('PDFNFE JÁ SALVA');
      Result := False;
    End;
  end;

begin
  // (uso interno de desenvolvimento/testes). Em RELEASE este bloco nao existe.
  {$IF (not Defined(LINUX)) and Defined(DEBUG)}
  For intParam := 1 To ParamCount Do
  Begin
    If SameText(ParamStr(intParam), 'ABRIR_EDITOR_LAYOUT_DINAMICO') Then
    Begin
      pCarregarModulos;
      Try
        frmImpNfdProvedores := TfrmImpNfdProvedores.Create(nil);
        Try
          frmImpNfdProvedores.ShowModal;
        Finally
          FreeAndNil(frmImpNfdProvedores);
        End;
      Finally
        pFinalizarModulos;
      End;
      Exit;
    End;
  End;
  {$IFEND}

  If fParametrosMisturados(strMsgAux) Then
  Begin
    pLogImp(strMsgAux);

    If Not KillProcess(GetCurrentProcessId) Then
      Application.Terminate;
  End;

  blnTodosParametosPorTag := fTodosParametosPorTag;
  blnTodosParametosPorPos := fTodosParametosPorPos;

  strParams := '';
  For intParam := 1 To ParamCount Do
  Begin
    strParFis := strParFis + ' ' + ParamStr(intParam);

    If blnTodosParametosPorTag Then
      strParams := strParams + ' ' + fExtraiValorParam(ParamStr(intParam))
    Else
      strParams := strParams + ' ' + ParamStr(intParam);

    pExtraiValorParam(ParamStr(intParam), consTagParamsPid, VS_PidMD5DicSis);

    If blnTodosParametosPorTag then
    Begin
      pExtraiValorParam(ParamStr(intParam), consTagParamsTrf, strTarefa);
      pExtraiValorParam(ParamStr(intParam), consTagParamsEmp, strCodEmp);
      pExtraiValorParam(ParamStr(intParam), consTagParamsChv, strChaAce);
      pExtraiValorParam(ParamStr(intParam), consTagParamsImp, strNomImp);
      pExtraiValorParam(ParamStr(intParam), consTagParamsRei, strReimpr);
      pExtraiValorParam(ParamStr(intParam), consTagParamsDir, strPDFDir);
      pExtraiValorParam(ParamStr(intParam), consTagParamsPrv, strPDFApr);
      pExtraiValorParam(ParamStr(intParam), consTagParamsDoc, strNumDoc);
      pExtraiValorParam(ParamStr(intParam), consTagParamsEsp, strEspDoc);
      pExtraiValorParam(ParamStr(intParam), consTagParamsCli, strCodCli);
      pExtraiValorParam(ParamStr(intParam), consTagParamsMDD, strModDsg);
      pExtraiValorParam(ParamStr(intParam), consTagParamsLsi, strLaySim);
      pExtraiValorParam(ParamStr(intParam), consTagParamsLun, strLayUni);
    End;
  End;

  {*************************************************************************************}
  {* A IDÉIA É QUE NO FUTURO TODOS OS PROGRAMAS FAÇAM A CHAMADA COM PARÂMETROS VIA     *}
  {* TAG IDENTIFICADORA O QUE FACILITA A INCLUSÃO DE NOVOS PARÂMETROS E EVITA ERROS    *}
  {* POIS NÚMEROS DE PARÂMETROS PODEM VARIAR CONFORME A NECESSIDADE (VIDE A            *}
  {* FRAGILIDADE DA FUNÇÃO pNormalizaParametros). ALÉM DO MAIS, A IDENTIFICAÇÃO POR    *}
  {* TAG PERMITE QUE VOCÊ PASSE OS PARÂMETROS NA ORDEM QUE QUISER. ENTÃO AS BOOLEANAS  *}
  {* blnTodosParametosPorPos E blnTodosParametosPorTag DETERMINAM NUM PERÍODO DE       *}
  {* TRANSIÇÃO COMO O NfeStatus.exe, NO CASO, DEVE ENTER A CHAMADA. NUM FUTURO ONDE SE *}
  {* SABE QUE TODOS OS PAINÉIS ESTÃO ATUALIZADOS E NÃO EXISTE MAIS PROGRAMADAS QUE     *}
  {* ENVOCAM O NfeStatus.exe SEM OS TRECHOS REFERENTES À blnTodosParametosPorPos PODEM *}
  {* SER REMOVIDOS, POR HORA O PROGRAMA FUNCIONA DAS DUAS FORMAS.                      *}
  {**********************************************************************************VA*}
  If blnTodosParametosPorPos Then
  Begin
    {***************************************************************************}
    {* NÃO CRIAR NOVOS PARÂMETROS IDENTIFICADOS POR POSIÇÃO!                   *}
    {* PARA NOVOS PARÂMETROS, CRIAR NOVAS TAG'S PARA IDENTIFICÁ-LOS.           *}
    {* ESSE BLOCO EXISTE SOMENTE PARA MANTER COMPATIBILIDADE COM AUTCOM ANTIGO.*}
    {************************************************************************VA*}
    intQtdMaxPar := IIF(VS_PidMD5DicSis = '', 4, 5);

    strTarefa := ParamStr(1);

    If Pos('RG_IMPRIMIR', strTarefa) > 0 Then
    Begin
      strCodEmp := ParamStr(2);
      strNumDoc := ParamStr(3);
      strEspDoc := ParamStr(4);
      strCodCli := ParamStr(5);
      strModDsg := ParamStr(6);
    End
    Else
    Begin
      strCodEmp := ParamStr(2);
      strChaAce := ParamStr(3);
      strNomImp := ParamStr(4);

      strReimpr := '';
      strPDFDir := '';
      strPDFApr := '';

      If Pos('NFE_IMPRIMIR_PDF', strTarefa) > 0 Then
      Begin
        If (ParamCount > intQtdMaxPar) Then
          strReimpr := ParamStr(5);

        strPDFDir := ParamStr(6);
        strPDFApr := ParamStr(7);
      End
      Else
      If Pos('NFS_IMPRIMIR_PDF', strTarefa) > 0 Then
      Begin
        strPDFDir := ParamStr(6);
        strPDFApr := ParamStr(7);
      End
      Else
      If Pos('NFCE_IMPRIMIR_PDF', strTarefa) > 0 Then
      Begin
        strPDFDir := ParamStr(6);
        strPDFApr := ParamStr(7);
      End
      Else
      If Pos(strTarefa, '_NFE_IMPRIMIR_NFS_IMPRIMIR_NFCE_IMPRIMIR_') > 0 Then
      Begin
        If (ParamCount > intQtdMaxPar) then
          strReimpr := ParamStr(5);
      End;

    End;
  End;

  strParams := Trim(strParams);
  strParFis := Trim(strParFis);

  pCarregarModulos;

  VS_strCodEmp    := strCodEmp;
  VS_strCodPnlDir := strCodEmp;
  Try
    Try
     {$IFDEF UNIDAC}
      objLogDanfe.objConexao := frmModulo.Database;
      objLogDanfe.strChaAce  := strChaAce;
     {$ENDIF}

      If blnTodosParametosPorTag Then
        pLogImp('Entrou > pTarefaImprimir > Parâmetros Chamada: ' + strParFis + ' | ' + 'Parâmetros Convertidos: ' + strParams + ' ' + '[TodosParametosPorTag]')
      Else
        pLogImp('Entrou > pTarefaImprimir > Parâmetros Chamada: ' + strParams + ' | ' + '[TodosParametosPorPos]');

      If (Length(strChaAce) = 44) Then
      Begin
        If (Not fExisteXML(strTarefa, strCodEmp, strArqXml, strNFComp, strChaAce)) And (Not fEmptyStr(strParams)) Then
        Begin
          pLogImp('XML NAO ENCONTRADO');
          Exit;
        End;
      End;

      If Pos('GERAR_XML', strTarefa) > 0 Then
      Begin
        Exit;
      End;

      blnReimpressao       := (strReimpr = 'REIMPRESSAO');
      blnPDF_Apresentar    := (strPDFApr = 'S');

      DefinirTimeZoneEmSessaoMySql(strCodEmp);

      If Pos('NFE_IMPRIMIR_PDF', strTarefa) > 0 Then
      begin
        DanfeNFe := TImpressaoNFe.Create();
        try
          DanfeNFe.Imprimir(strCodEmp,          // Código Empresa
                            strChaAce,          // Chave de Acesso
                            strNomImp,          // Impressora
                            blnReimpressao,     // Reimpressão
                            True,               // PDF - Gerar
                            strPDFDir,          // PDF - Diretório
                            blnPDF_Apresentar,  // PDF - Apresentar
                            False,              // PDF - Banco
                            strArqXml,          // Arquivo XML
                            strNFComp,          // Nota de Complemento S/N
                            strLaySim);         // Layout Simplificado S/N
        finally
          DanfeNFe.Free;
        end;
      end
      else If Pos('NFS_IMPRIMIR_PDF', strTarefa) > 0 Then
      begin
        DanfeNFS := TImpressaoNFS.Create();
        try
          DanfeNFS.Imprimir(strCodEmp,          // Código Empresa
                            'NS',               // Espécie do Documento
                            strChaAce,          // Chave de Acesso
                            strNomImp,          // Impressora
                            False,              // Modo de Designer
                            True,               // PDF - Gerar
                            strPDFDir,          // PDF - Diretório
                            blnPDF_Apresentar); // PDF - Apresentar

        finally
          DanfeNFS.Free;
        end;
      end
      else If Pos('NFCE_IMPRIMIR_PDF', strTarefa) > 0 Then
      begin
        DanfeNFCe := TImpressaoNFCe.Create();
        try
          DanfeNFCe.Imprimir(strCodEmp,          // Código Empresa
                             strChaAce,          // Chave de Acesso
                             strNomImp,          // Impressora
                             False,              // Modo de Designer
                             'NFCE',             // Modelo
                             True,               // PDF - Gerar
                             strPDFDir,          // PDF - Diretório
                             blnPDF_Apresentar); // PDF - Apresentar
        finally
          DanfeNFCe.Free;
        end;
      end
      else If Pos('NFE_IMPRIMIR', strTarefa) > 0 Then
      begin
        DanfeNFe := TImpressaoNFe.Create();
        try
          DanfeNFe.Imprimir(strCodEmp,       // Código Empresa
                            strChaAce,       // Chave de Acesso
                            strNomImp,       // Impressora
                            blnReimpressao,  // Reimpressão
                            False,           // PDF - Gerar
                            '',              // PDF - Diretório
                            False,           // PDF - Apresentar
                            False,           // PDF - Banco
                            strArqXml,       // Arquivo XML
                            strNFComp);      // Nota de Complemento S/N
        finally
          DanfeNFe.Free;
        end;
      end
      else If Pos('NFS_IMPRIMIR', strTarefa) > 0 Then
      begin
        DanfeNFS := TImpressaoNFS.Create();
        try
          DanfeNFS.Imprimir(strCodEmp,       // Código Empresa
                            'NS',            // Espécie do Documento
                            strChaAce,       // Chave de Acesso
                            strNomImp,       // Impressora
                            False,           // Modo de Designer
                            False,           // PDF - Gerar
                            '',              // PDF - Diretório
                            False,           // PDF - Apresentar
                            blnReimpressao);
        finally
          DanfeNFS.Free;
        end;
      end
      else If Pos('NFCE_IMPRIMIR', strTarefa) > 0 Then
      begin
        DanfeNFCe := TImpressaoNFCe.Create();
        try
          DanfeNFCe.Imprimir(strCodEmp,      // Código Empresa
                             strChaAce,      // Chave de Acesso
                             strNomImp,      // Impressora
                             False,          // Modo de Designer
                             'NFCE',         // Modelo
                             False,          // PDF - Gerar
                             '',             // PDF - Diretório
                             False,          // PDF - Apresentar
                             False,          // PDF - Banco
                             blnReimpressao);// Reimpressao
        finally
          DanfeNFCe.Free;
        end;
      end
      else If Pos('NFE_GERAR_PDF', strTarefa) > 0 Then
      begin
        If (Not fTemCondicaoMinimaParaGerarPDF) Then
          Exit;

        DanfeNFe := TImpressaoNFe.Create();
        try
          DanfeNFe.Imprimir(strCodEmp,  // Código Empresa
                            strChaAce,  // Chave de Acesso
                            strNomImp,  // Impressora
                            False,      // Reimpressão
                            False,      // PDF - Gerar
                            '',         // PDF - Diretório
                            False,      // PDF - Apresentar
                            True,       // PDF - Banco
                            strArqXml,  // Arquivo XML
                            strNFComp); // Nota de Complemento S/N
        finally
          DanfeNFe.Free;
        end;
      end
      else If Pos('NFS_GERAR_PDF', strTarefa) > 0 Then
      begin
        If (Not fTemCondicaoMinimaParaGerarPDF) Then
          Exit;

        DanfeNFS := TImpressaoNFS.Create();
        try
          DanfeNFS.Imprimir(strCodEmp, // Código Empresa
                            'NS',      // Espécie do documento
                            strChaAce, // Chave de Acesso
                            strNomImp, // Impressora
                            False,     // Modo de Designer
                            False,     // PDF - Gerar
                            '',        // PDF - Diretório
                            False,     // PDF - Apresentar
                            False,
                            True);
        finally
          DanfeNFS.Free;
        end;
      end
      else If Pos('NFCE_GERAR_PDF', strTarefa) > 0 Then
      begin
        If (Not fTemCondicaoMinimaParaGerarPDF) Then
          Exit;

        DanfeNFCe := TImpressaoNFCe.Create();
        try
          DanfeNFCe.Imprimir(strCodEmp, // Código Empresa
                             strChaAce, // Chave de Acesso
                             strNomImp, // Impressora
                             False,
                             'NFCE',
                             False,
                             '',
                             False,
                             True);
        finally
          DanfeNFCe.Free;
        end;
      end
      else If Pos('NFE_GERAR_BMP', strTarefa) > 0 Then
      begin
        pGerarBMP_LayoutUnificado(strCodEmp, strChaAce, strPDFDir, strLayUni);
      end
      else If Pos('RG_IMPRIMIR', strTarefa) > 0 Then
      begin
        DanfeRG := TImpressaoRG.Create();
        try
          DanfeRG.Imprimir(strCodEmp,              // Código Empresa
                           strNumDoc,              // Número Documento
                           strEspDoc,              // Espécie Documento
                           strCodCli,              // Codigo Cliente
                           StrToBool(strModDsg));  // Modo de Designer

        finally
          DanfeRG.Free;
        end;
      end
      else If Pos('CCE_IMPRIMIR', strTarefa) > 0 Then
      begin
        DanfeCCe := TImpressaoCCe.Create();
        try
          DanfeCCe.Imprimir(strCodEmp, // Código Empresa
                            strChaAce, // Chave de Acesso
                            strNomImp, // Impressora
                            False);    // Modo de Designer
        finally
          DanfeCCe.Free;
        end;
      end
      else If Pos('MDFE_IMPRIMIR', strTarefa) > 0 Then
      begin
        DanfeMDFe := TImpressaoMDFe.Create();
        try
          DanfeMDFe.Imprimir(strCodEmp, // Código Empresa
                             strChaAce, // Número Manifesto
                             strNomImp, // Impressora
                             False);    // Modo de Designer
        finally
          DanfeMDFe.Free;
        end;
      end
      else If Pos('CTE_IMPRIMIR', strTarefa) > 0 Then
      begin
        DanfeCTe := TImpressaoCTe.Create();
        try
          DanfeCTe.Imprimir(strCodEmp, // Código Empresa
                            strChaAce, // Número Conhecimento
                            strNomImp, // Impressora
                            False);    // Modo de Designer
        finally
          DanfeCTe.Free;
        end;
      end
      else
      begin
      {$IF Defined(LINUX)}
      {$ELSE}
        If fEmptyStr(strTarefa) Then
        Begin
          Application.CreateForm(TfrmConfImpressaoNFe,frmConfImpressaoNFe);
          Application.Run;
        End;
      {$IFEND}
      end;
    Except
      On E: Exception Do
      Begin
       {$IF Defined(LINUX)}
        Writeln(E.Message);
        pLogImp(E.Message);
       {$ELSE}
        pLogImp(E.Message);
        ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
       {$ENDIF}
      End;
    End;
  Finally
    pLogImp('pTarefaImprimir <');
    Try
      pFinalizarModulos;
    Finally
      TThreadFinalizarNFeImpressao.Parar;

      If Not KillProcess(GetCurrentProcessId) Then
        Application.Terminate;
    End;
  End;
end;

initialization

finalization
  TThreadFinalizarNFeImpressao.Parar;

end.

