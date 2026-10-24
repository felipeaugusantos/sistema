unit untFatComboVenda;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  Windows, EditFocus, Forms, StdCtrls, untFuncoesSimples,
  Vcl.CheckLst, cxProgressBar, UniClientDataSet, UniDataSetProvider,
  Graphics, Controls,
{$ENDIF}
  Classes, StrUtils, SysUtils, Uni, DB, Variants, untTypesSistema;

Type
  TComVen = Class(TComponent)
    private
      class var FItensJaExibidosBanner: TStringList;
    private
      strDeveAbrirTelaIndicacaoProdCombo : String;
      qryGeneri: TUniQuery;
      strCodIte: String;
      strIteCom: String;
      strIteAti: String;
      strLotAti: String;
      strCodEmp: String;
      strTabPre: String;
      fltQtdIte: Double;
      fltQtdCom: Double;
      fltQtdAti: Double;
      strBrinde: String;
      strEntRet: String;

      blnFilAti: Boolean;
      blnFilCom: Boolean;
      blnTemCom: Boolean;
      blnAbrTel: Boolean;
      blnSelPro: Boolean;

      qryProCom: TUniQuery;
      qryProSim: TUniQuery;
      qryProInd: TUniQuery;

      dspProCom: TUniDataSetProvider;
      dspProSim: TUniDataSetProvider;
      dspProInd: TUniDataSetProvider;

      cdsProSim: TUniClientDataSet;
      cdsProInd: TUniClientDataSet;
      cdsBanner: TUniClientDataSet;

      stlProSel: TStringList;

      function getCodIte: String;
      function getIteCom: String;
      function getFilAti: Boolean;
      function getFilCom: Boolean;
      function getTabPre: String;
      function getQtdIte: Double;
      function getAbrTel: Boolean;
      function getSelPro: Boolean;

      procedure setFilAti(Value: Boolean);
      procedure setFilCom(Value: Boolean);
      procedure setTemCom(Value: Boolean);
      procedure setIteAti(Value: String);
      procedure setLotAti(Value: String);
      procedure setQtdAti(Value: Double);

      procedure pCriaComponentes;
      procedure pDestroiComponentes;
      procedure pSetaParametrosCombo(qryCombo: TUniQuery);
      procedure pSetaParametrosSimilares(qrySimilar: TUniQuery);
      procedure pSetaParametrosProdIndicacao(qryIndicac: TUniQuery);
      procedure pSetaParametrosProdIndicacaoBanner(qryIndicac: TUniQuery);
      procedure pCarregaProdutosCombo;
      procedure pCarregaProdutosSimilares;
      procedure pCarregaProdutosIndicacaoCombo;
      procedure pCarregaProdutosComboGeral;
      procedure pCriaClientProdIndicacaoBanner;

      function  fGetSQLCombo(AField: String = ''): String;
      function  fGetSQLSimilares: String;
      function  fGetSQLProdIndicacao: String;
      function  fGetSQLProdIndicacaoBanner(strTabPre: String): String;

      function  fCalculaPrecoVendaCombo(pgbProgresso: TcxProgressBar): Boolean;
      function  fCalculaPrecoVendaSimilar(pgbProgresso: TcxProgressBar): Boolean;

    public
      cdsProCom: TUniClientDataSet;

      procedure setCodIte(Value: String);
      procedure setIteCom(Value: String);
      procedure setCodEmp(Value: String);
      procedure setTabPre(Value: String);
      procedure setQtdIte(Value: Double);
      procedure setAbrTel(Value: Boolean);
      procedure setSelPro(Value: Boolean);
      procedure setEntRet(Value: String);
      procedure pLimpaProdutosSelecionados;
      procedure pAdicionaSelecao(strCodIte: String);
      procedure pCarregaProdutosParaBanner(strTabPre: String);

      function getCodEmp: String;
      function getTemCom: Boolean;

      function getQtdCom: Double;
      function getBrinde: String;
      function getIteAti: String;
      function getLotAti: String;
      function getQtdAti: Double;
      function getcdsBanner: TUniClientDataSet;
      function getEntRet: String;

      function fTemComboVigenteParaOProdutoAtivacao: Boolean;
      function fTemComboVigenteParaOProdutoComboOuSimilar: Boolean;
      function fTemComboVigente: Boolean;

      function fRetQtdParaAtivacao: Double; Overload;
      function fDeveAbrirTelaIndicacaoProdCombo : Boolean;
      class function fRetQtdParaAtivacao(strCodIte, strCodEmp, strCampo : String): Double; Overload;

      {$IFNDEF LINUX}
      function fAbreTelaSelecaoProdCombo: Boolean;
      function fAbreTelaIndicacaoProdCombo: Boolean;
      {$ENDIF}

      Constructor Create(Owner: TComponent); override;
      Destructor  Destroy; override;

  End;

implementation

{ TComVen }

uses
{$IFDEF LINUX}
{$ELSE}
  untFatMostraComboProdVenda, untFatMostraComboProdAtivacao, untFuncoesImagem,
{$ENDIF}
  Faturamento.Connections.Functions;

constructor TComVen.Create(Owner: TComponent);
begin
  inherited create(Owner);
  pCriaComponentes;
  setCodEmp(VS_strCodEmp);
  setFilAti(False);
  setFilCom(False);
  setTemCom(fTemComboVigente);
  setAbrTel(True);
  setSelPro(False);
  setIteAti('');
  setLotAti('');
  setQtdAti(0);
  setEntRet('');
  strDeveAbrirTelaIndicacaoProdCombo := EmptyStr;
end;

destructor TComVen.Destroy;
begin
  pDestroiComponentes;
  inherited Destroy;
end;

function fPermiteBrindeComValorZero: Boolean;
begin
  Result := (fCfgSis('ZERBRI', varString) = '1');
end;

function TComVen.fCalculaPrecoVendaCombo(pgbProgresso: TcxProgressBar): Boolean;
begin

  Result := False;

  Try

    pInfoStatusGravacao(pgbProgresso, 'Aguarde... Calculando Preço dos Produtos do Combo...');

    With cdsProCom Do
    Begin
      pgbProgresso.Properties.Max := RecordCount;
      First;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Calculando Preço do Produtos: ' + #13#10 +
                                          FieldByName('CODITE').AsString + '-' + Copy(FieldByName('DESITE').AsString, 1, 15));

        Edit;
        If (FieldByName('BRINDE').AsString = 'S') Then
        Begin
          If (fPermiteBrindeComValorZero) Then
            FieldByName('PREVEN').AsFloat := 0.00
          Else
          Begin
            case fCfgSis('SUG_BR', varInteger) of
              1:FieldByName('PREVEN').AsFloat := FieldByName('PRECUS').AsFloat;
              2:FieldByName('PREVEN').AsFloat := FieldByName('PREVE' + IIF(fEmptyStr(getTabPre), '1', getTabPre)).AsFloat;
              3:FieldByName('PREVEN').AsFloat := FieldByName('PREULT').AsFloat;
              4:FieldByName('PREVEN').AsFloat := FieldByName('IMPULT').AsFloat;
            else
              FieldByName('PREVEN').AsFloat := FieldByName('PRECUS').AsFloat;
            end;
          End;
        End
        Else
        Begin
          If (FieldByName('TABPRE').AsString = 'F') Then
            FieldByName('PREVEN').AsFloat := FieldByName('PREVE' + getTabPre).AsFloat
          Else
            FieldByName('PREVEN').AsFloat := FieldByName('PREVE' + FieldByName('TABPRE').AsString).AsFloat;

          If (FieldByName('TIPDES').AsString = '%') Then
          Begin
            If (FieldByName('OPERAD').AsString = '+') Then
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat * (1 + (FieldByName('VALDES').AsFloat / 100))
            Else
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat * (1 - (FieldByName('VALDES').AsFloat / 100));
          End
          Else
          Begin
            If (FieldByName('OPERAD').AsString = '+') Then
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat + FieldByName('VALDES').AsFloat
            Else
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat - FieldByName('VALDES').AsFloat;
          End;

        End;

        Post;
        Next;
        pStepStatusGravacao(pgbProgresso);
      End;

      First;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TComVen.fCalculaPrecoVendaCombo]');
  End;

end;

function TComVen.fCalculaPrecoVendaSimilar(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strFilter  : String;
  blnFiltered: Boolean;
begin
  Result := False;

  Try

    pInfoStatusGravacao(pgbProgresso, 'Aguarde... Calculando Preço dos Produtos Similares...');

    strFilter   := cdsProSim.Filter;
    blnFiltered := cdsProSim.Filtered;

    cdsProSim.Filtered := False;
    cdsProSim.Filter   := '';

    With cdsProSim Do
    Begin
      pgbProgresso.Properties.Max := RecordCount;
      First;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Calculando Preço do Produtos: ' + #13#10 +
                                          FieldByName('CODITE').AsString + '-' + Copy(FieldByName('DESITE').AsString, 1, 15));

        Edit;
        If (FieldByName('BRINDE').AsString = 'S') Then
        Begin
          If (fPermiteBrindeComValorZero) Then
            FieldByName('PREVEN').AsFloat := 0.00
          Else
          Begin
            case fCfgSis('SUG_BR', varInteger) of
              1:FieldByName('PREVEN').AsFloat := FieldByName('PRECUS').AsFloat;
              2:FieldByName('PREVEN').AsFloat := FieldByName('PREVE' + IIF(fEmptyStr(getTabPre), '1', getTabPre)).AsFloat;
              3:FieldByName('PREVEN').AsFloat := FieldByName('PREULT').AsFloat;
              4:FieldByName('PREVEN').AsFloat := FieldByName('IMPULT').AsFloat;
            else
              FieldByName('PREVEN').AsFloat := FieldByName('PRECUS').AsFloat;
            end;
          End;
        End
        Else
        Begin
          If (FieldByName('TABPRE').AsString = 'F') Then
            FieldByName('PREVEN').AsFloat := FieldByName('PREVE' + getTabPre).AsFloat
          Else
            FieldByName('PREVEN').AsFloat := FieldByName('PREVE' + FieldByName('TABPRE').AsString).AsFloat;

          If (FieldByName('TIPDES').AsString = '%') Then
          Begin
            If (FieldByName('OPERAD').AsString = '+') Then
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat * (1 + (FieldByName('VALDES').AsFloat / 100))
            Else
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat * (1 - (FieldByName('VALDES').AsFloat / 100));
          End
          Else
          Begin
            If (FieldByName('OPERAD').AsString = '+') Then
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat + FieldByName('VALDES').AsFloat
            Else
              FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat - FieldByName('VALDES').AsFloat;
          End;
        End;

        Post;
        Next;
        pStepStatusGravacao(pgbProgresso);
      End;

      cdsProSim.Filter   := strFilter;
      cdsProSim.Filtered := blnFiltered;

      First;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TComVen.fCalculaPrecoVendaSimilar]');
  End;
end;


function TComVen.fGetSQLCombo(AField: String = ''): String;
begin
  Result := '';
  Result := Result + 'SELECT                                                        ';

  If AField = '' Then
  Begin
    Result := Result + '  E.COM_CODEMP                                    AS CODEMP,  ';
    Result := Result + '  A.ATI_QTDITE                                    AS QTDATI,  ';
    Result := Result + '  P.AUTOINCREM                                    AS AUTINC,  ';
    Result := Result + '  P.COM_SEQGER                                    AS SEQGER,  ';
    Result := Result + '  CAST(IF(P.COM_BRINDE = "S", "S", "N") AS CHAR)  AS MARDES,  ';
    Result := Result + '  P.COM_CODITE                                    AS CODITE,  ';
    Result := Result + '  P.COM_QTDITE                                    AS QTDITE,  ';
    Result := Result + '  P.COM_BRINDE                                    AS BRINDE,  ';
    Result := Result + '  P.COM_TABPRE                                    AS TABPRE,  ';
    Result := Result + '  P.COM_OPERAD                                    AS OPERAD,  ';
    Result := Result + '  P.COM_TIPDES                                    AS TIPDES,  ';
    Result := Result + '  P.COM_VALDES                                    AS VALDES,  ';
    Result := Result + '  I.ITE_DESITE                                    AS DESITE,  ';
    Result := Result + '  I.ITE_REFERE                                    AS REFERE,  ';
    Result := Result + '  U.UNI_SIGUNI                                    AS SIGUNI,  ';
    Result := Result + ' (SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODITE = I.ITE_CODITE AND LOT_CODEMP = :CODEMP AND LOT_ARMPRI = "S") AS NUMLOT, ';
    Result := Result + '  CAST(IF(P.COM_BRINDE = "S", "BRINDE", "PROMOCIONAL") AS CHAR) AS SITUAC,  ';
    Result := Result + '  G.ITE_PREVE1                                    AS PREVEN,  ';
    Result := Result + '  G.ITE_PREVE1                                    AS PREVE1,  ';
    Result := Result + '  G.ITE_PREVE2                                    AS PREVE2,  ';
    Result := Result + '  G.ITE_PREVE3                                    AS PREVE3,  ';
    Result := Result + '  G.ITE_PREVE4                                    AS PREVE4,  ';
    Result := Result + '  G.ITE_PREVE5                                    AS PREVE5,  ';
    Result := Result + '  G.ITE_PREVE6                                    AS PREVE6,  ';
    Result := Result + '  G.ITE_PREVE7                                    AS PREVE7,  ';
    Result := Result + '  G.ITE_PRECUS                                    AS PRECUS,  ';
    Result := Result + '  G.ITE_PREULT                                    AS PREULT,  ';
    Result := Result + '  G.ITE_IMPULT                                    AS IMPULT   ';
  End
  Else
    Result := Result + ' ' + AField + ' ';

  Result := Result + 'FROM           ';
  Result := Result + '  COMVEN C     ';
  Result := Result + '  INNER JOIN COMEMP E ON E.COM_SEQGER = C.AUTOINCREM          ';
  Result := Result + '  INNER JOIN PROATI A ON A.ATI_SEQGER = C.AUTOINCREM          ';
  Result := Result + '  INNER JOIN PROCOM P ON P.COM_SEQGER = A.AUTOINCREM          ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = P.COM_CODITE          ';
  Result := Result + '  INNER JOIN ITEGER G ON G.ITE_CODITE = P.COM_CODITE AND      ';
  Result := Result + '                         G.ITE_CODEMP = E.COM_CODEMP          ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI          ';

  If (getFilCom) Then
    Result := Result + 'LEFT JOIN PROSIM S ON S.SIM_SEQGER = P.AUTOINCREM          ';

  Result := Result + 'WHERE                                                        ';
  Result := Result + '  :DTAATU BETWEEN C.COM_DTAINI AND C.COM_DTAFIN AND          ';
  Result := Result + '  E.COM_CODEMP = :CODEMP                                     ';

  If (getFilAti) Then
  Begin
    Result := Result + '  AND A.ATI_CODITE =  :CODITE                              ';
    Result := Result + '  AND A.ATI_QTDITE <= :QTDITE                              ';
    Result := Result + '  AND MID(C.COM_TABPRE, :TABPRE, 1) = "S"                  ';
  End;

  If (getFilCom) Then
    Result := Result + '  AND ((P.COM_CODITE = :ITECOM) OR (S.SIM_CODITE =  :ITECOM)) ';
end;

function TComVen.fGetSQLProdIndicacao: String;
  function fWhere: String;
  Begin
    Result := '';
    Result := Result + 'WHERE                                                ';
    Result := Result + '  I.ITE_CODITE = :CODITE                        AND  ';
    Result := Result + '  :DTAATU BETWEEN C.COM_DTAINI AND C.COM_DTAFIN AND  ';
    Result := Result + '  P.COM_CODEMP = :CODEMP                        AND  ';
    Result := Result + '  MID(C.COM_TABPRE, :TABPRE, 1) = "S"                ';
  End;

  function fColunas: String;
  Begin
    Result := '';
    Result := Result + '  CONCAT(C.COM_CODCOM, "-", C.COM_DESCOM)              AS COMVEN,   ';
    Result := Result + '  CONCAT(DATE_FORMAT(C.COM_DTAINI, "%d/%m/%Y"), " A ", DATE_FORMAT(C.COM_DTAFIN, "%d/%m/%Y")) AS VIGENC,   ';
    Result := Result + '  CONCAT(IF (MID(C.COM_TABPRE, 1, 1) = "S", "1-", ""),              ';
    Result := Result + '         IF (MID(C.COM_TABPRE, 2, 1) = "S", "2-", ""),              ';
    Result := Result + '         IF (MID(C.COM_TABPRE, 3, 1) = "S", "3-", ""),              ';
    Result := Result + '         IF (MID(C.COM_TABPRE, 4, 1) = "S", "4-", ""),              ';
    Result := Result + '         IF (MID(C.COM_TABPRE, 5, 1) = "S", "5-", ""),              ';
    Result := Result + '         IF (MID(C.COM_TABPRE, 6, 1) = "S", "6-", ""),              ';
    Result := Result + '         IF (MID(C.COM_TABPRE, 7, 1) = "S", "7-", "")) AS TABPRE,   ';
    Result := Result + '  T.ITE_CODITE                                         AS CODITE,   ';
    Result := Result + '  T.ITE_DESITE                                         AS DESITE,   ';
    Result := Result + '  T.ITE_REFERE                                         AS REFERE,   ';
    Result := Result + '  U.UNI_SIGUNI                                         AS SIGUNI,   ';
    Result := Result + ' (SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODITE = T.ITE_CODITE AND LOT_CODEMP = :CODEMP AND LOT_ARMPRI = "S") AS NUMLOT, ';
    Result := Result + '  A.ATI_QTDITE                                         AS QTDITE,   ';
    Result := Result + '  A.AUTOINCREM                                         AS AUTINC    ';
  End;

  function fAgrupaPorProdutoDeAtivacao(strSQL: String): String;
  Begin
    Result := '';
    Result := Result + 'SELECT          ';
    Result := Result + '  SUBSTR(TABPRE, 1, LENGTH(TABPRE) - 1) AS TABPRE, ';
    Result := Result + '  TAB.*         ';
    Result := Result + 'FROM(           ';
    Result := Result +       strSQL + ' ';
    Result := Result + '    ) AS TAB    ';
    Result := Result + 'GROUP BY        ';
    Result := Result + '  CODITE        ';
  End;

begin
  Result := '';
  Result := Result + 'SELECT          ';
  Result := Result +    fColunas;
  Result := Result + 'FROM            ';
  Result := Result + '  CADITE I      ';
  Result := Result + '  INNER JOIN CADITE T ON T.ITE_CODMAR = I.ITE_CODMAR ';
  Result := Result + '  INNER JOIN PROATI A ON A.ATI_CODITE = T.ITE_CODITE ';
  Result := Result + '  INNER JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER ';
  Result := Result + '  INNER JOIN COMEMP P ON P.COM_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN ELEMAR E ON E.ELE_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = T.ITE_CODUNI ';
  Result := Result +  fWhere;

  Result := Result + 'UNION ALL       ';

  Result := Result + 'SELECT          ';
  Result := Result +    fColunas;
  Result := Result + 'FROM            ';
  Result := Result + '  CADITE I      ';
  Result := Result + '  INNER JOIN CADITE T ON T.ITE_CODFOR = I.ITE_CODFOR ';
  Result := Result + '  INNER JOIN PROATI A ON A.ATI_CODITE = T.ITE_CODITE ';
  Result := Result + '  INNER JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER ';
  Result := Result + '  INNER JOIN COMEMP P ON P.COM_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN ELEFOR E ON E.ELE_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = T.ITE_CODUNI ';
  Result := Result +  fWhere;


  Result := Result + 'UNION ALL       ';

  Result := Result + 'SELECT          ';
  Result := Result +    fColunas;
  Result := Result + 'FROM            ';
  Result := Result + '  CADITE I      ';
  Result := Result + '  INNER JOIN CADITE T ON T.ITE_CODGRU = I.ITE_CODGRU ';
  Result := Result + '  INNER JOIN PROATI A ON A.ATI_CODITE = T.ITE_CODITE ';
  Result := Result + '  INNER JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER ';
  Result := Result + '  INNER JOIN COMEMP P ON P.COM_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN ELEGRU E ON E.ELE_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = T.ITE_CODUNI ';
  Result := Result +  fWhere;

  Result := Result + 'UNION ALL       ';

  Result := Result + 'SELECT          ';
  Result := Result +    fColunas;
  Result := Result + 'FROM            ';
  Result := Result + '  CADITE I      ';
  Result := Result + '  INNER JOIN CADITE T ON T.ITE_CODGPR = I.ITE_CODGPR ';
  Result := Result + '  INNER JOIN PROATI A ON A.ATI_CODITE = T.ITE_CODITE ';
  Result := Result + '  INNER JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER ';
  Result := Result + '  INNER JOIN COMEMP P ON P.COM_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN ELEGPR E ON E.ELE_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = T.ITE_CODUNI ';
  Result := Result +  fWhere;

  Result := Result + 'UNION ALL       ';

  Result := Result + 'SELECT          ';
  Result := Result +    fColunas;
  Result := Result + 'FROM            ';
  Result := Result + '  CADITE I      ';
  Result := Result + '  INNER JOIN CADITE T ON T.ITE_PRDGRU = I.ITE_PRDGRU ';
  Result := Result + '  INNER JOIN PROATI A ON A.ATI_CODITE = T.ITE_CODITE ';
  Result := Result + '  INNER JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER ';
  Result := Result + '  INNER JOIN COMEMP P ON P.COM_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN ELEGPD E ON E.ELE_SEQGER = C.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = T.ITE_CODUNI ';
  Result := Result +  fWhere;

  Result := fAgrupaPorProdutoDeAtivacao(Result);
end;

function TComVen.fGetSQLProdIndicacaoBanner(strTabPre: String): String;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT          ';
  strSQL := strSQL + '  A.ATI_CODITE AS CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS PREVEN, ';
  strSQL := strSQL + '  CONCAT(C.COM_CODCOM, "-", C.COM_DESCOM) AS DESCOM, ';
  strSQL := strSQL + '  CONCAT(DATE_FORMAT(C.COM_DTAINI, "%d/%m/%Y"), " A ", DATE_FORMAT(C.COM_DTAFIN, "%d/%m/%Y")) AS VIGENC,  ';
  strSQL := strSQL + '  CONCAT(IF (MID(C.COM_TABPRE, 1, 1) = "S", "1 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(C.COM_TABPRE, 2, 1) = "S", "2 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(C.COM_TABPRE, 3, 1) = "S", "3 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(C.COM_TABPRE, 4, 1) = "S", "4 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(C.COM_TABPRE, 5, 1) = "S", "5 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(C.COM_TABPRE, 6, 1) = "S", "6 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(C.COM_TABPRE, 7, 1) = "S", "7 / ", "")) AS TABPRE,   ';
  strSQL := strSQL + '  (SELECT REPLACE(GROUP_CONCAT(X.COM_CODEMP), ",", " / ") FROM COMEMP X WHERE X.COM_SEQGER = C.AUTOINCREM ORDER BY X.COM_CODEMP ) AS EMPRES ';
  strSQL := strSQL + 'FROM            ';
  strSQL := strSQL + '  PROATI A       ';
  strSQL := strSQL + '  INNER JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER ';
  strSQL := strSQL + '  INNER JOIN COMEMP P ON P.COM_SEQGER = C.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = A.ATI_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '                         G.ITE_CODEMP = P.COM_CODEMP     ';
  strSQL := strSQL + 'WHERE                                                    ';
  strSQL := strSQL + '  :DTAATU BETWEEN C.COM_DTAINI AND C.COM_DTAFIN AND      ';
  strSQL := strSQL + '  P.COM_CODEMP = :CODEMP                                 ';
  strSQL := strSQL + 'ORDER BY                                                 ';
  strSQL := strSQL + '  DESITE                                                 ';

  Result := Result + 'SELECT          ';
  Result := Result + '  SUBSTR(TABPRE, 1, LENGTH(TABPRE) - 2) AS TABPRE, ';
  Result := Result + '  TAB.*         ';
  Result := Result + 'FROM(           ';
  Result := Result +       strSQL + ' ';
  Result := Result + '    ) AS TAB    ';
end;

function TComVen.fGetSQLSimilares: String;
begin
  Result := '';
  Result := Result + 'SELECT                                                        ';
  Result := Result + '  S.SIM_CODITE                                    AS CODITE,  ';
  Result := Result + '  S.SIM_SEQGER                                    AS SEQGER,  ';
  Result := Result + '  I.ITE_DESITE                                    AS DESITE,  ';
  Result := Result + '  I.ITE_REFERE                                    AS REFERE,  ';
  Result := Result + '  U.UNI_SIGUNI                                    AS SIGUNI,  ';
  Result := Result + ' (SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODITE = I.ITE_CODITE AND LOT_CODEMP = :CODEMP AND LOT_ARMPRI = "S") AS NUMLOT, ';
  Result := Result + '  0.00                                            AS PREVEN,  ';
  Result := Result + '  P.COM_BRINDE                                    AS BRINDE,  ';
  Result := Result + '  P.COM_TABPRE                                    AS TABPRE,  ';
  Result := Result + '  P.COM_OPERAD                                    AS OPERAD,  ';
  Result := Result + '  P.COM_TIPDES                                    AS TIPDES,  ';
  Result := Result + '  P.COM_VALDES                                    AS VALDES,  ';
  Result := Result + '  G.ITE_PREVE1                                    AS PREVE1,  ';
  Result := Result + '  G.ITE_PREVE2                                    AS PREVE2,  ';
  Result := Result + '  G.ITE_PREVE3                                    AS PREVE3,  ';
  Result := Result + '  G.ITE_PREVE4                                    AS PREVE4,  ';
  Result := Result + '  G.ITE_PREVE5                                    AS PREVE5,  ';
  Result := Result + '  G.ITE_PREVE6                                    AS PREVE6,  ';
  Result := Result + '  G.ITE_PREVE7                                    AS PREVE7   ';
  Result := Result + 'FROM                                                          ';
  Result := Result + '  COMVEN C                                                    ';
  Result := Result + '  INNER JOIN COMEMP E ON E.COM_SEQGER = C.AUTOINCREM          ';
  Result := Result + '  INNER JOIN PROATI A ON A.ATI_SEQGER = C.AUTOINCREM          ';
  Result := Result + '  INNER JOIN PROCOM P ON P.COM_SEQGER = A.AUTOINCREM          ';
  Result := Result + '  INNER JOIN PROSIM S ON S.SIM_SEQGER = P.AUTOINCREM          ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = S.SIM_CODITE          ';
  Result := Result + '  INNER JOIN ITEGER G ON G.ITE_CODITE = S.SIM_CODITE AND      ';
  Result := Result + '                         G.ITE_CODEMP = E.COM_CODEMP          ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI          ';
  Result := Result + 'WHERE                                                         ';
  Result := Result + '  :DTAATU BETWEEN C.COM_DTAINI AND C.COM_DTAFIN AND           ';
  Result := Result + '  E.COM_CODEMP =  :CODEMP AND                                 ';
  Result := Result + '  A.ATI_CODITE =  :CODITE AND                                 ';
  Result := Result + '  A.ATI_QTDITE <= :QTDITE                                     ';
end;

class function TComVen.fRetQtdParaAtivacao(strCodIte, strCodEmp, strCampo : String): Double;
Var
  strSQL: String;
  qryAux: TUniQuery;
begin

  Result := 0;

  qryAux := fCriaQuery(Nil);

  Try

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE                                     ';
      strSQL := strSQL + '  A.ATI_QTDITE AS QTDATI,                               ';
      strSQL := strSQL + '  C.COM_QTDITE AS QTDCOM                                ';
      strSQL := strSQL + 'FROM                                                    ';
      strSQL := strSQL + '  PROCOM C                                              ';
      strSQL := strSQL + '  LEFT  JOIN PROSIM S ON S.SIM_SEQGER = C.AUTOINCREM    ';
      strSQL := strSQL + '  INNER JOIN PROATI A ON A.AUTOINCREM = C.COM_SEQGER    ';
      strSQL := strSQL + '  INNER JOIN COMVEN V ON V.AUTOINCREM = A.ATI_SEQGER    ';
      strSQL := strSQL + '  INNER JOIN COMEMP E ON E.COM_SEQGER = V.AUTOINCREM    ';
      strSQL := strSQL + 'WHERE                                                   ';
      strSQL := strSQL + '  CURRENT_DATE BETWEEN COM_DTAINI AND COM_DTAFIN AND    ';
      strSQL := strSQL + '  E.COM_CODEMP = :CODEMP                         AND    ';
      strSQL := strSQL + '  (C.COM_CODITE = :CODITE OR S.SIM_CODITE = :CODITE)    ';

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.Open;

      Result := qryAux.FieldByName(strCampo).AsInteger;

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TComVen.fRetQtdParaAtivacao]');
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TComVen.fRetQtdParaAtivacao: Double;
Var
  strSQL: String;
begin

  Result := 0;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE                                     ';
    strSQL := strSQL + '  A.ATI_QTDITE AS QTDATI                                ';
    strSQL := strSQL + 'FROM                                                    ';
    strSQL := strSQL + '  PROCOM C                                              ';
    strSQL := strSQL + '  LEFT  JOIN PROSIM S ON S.SIM_SEQGER = C.AUTOINCREM    ';
    strSQL := strSQL + '  INNER JOIN PROATI A ON A.AUTOINCREM = C.COM_SEQGER    ';
    strSQL := strSQL + '  INNER JOIN COMVEN V ON V.AUTOINCREM = A.ATI_SEQGER    ';
    strSQL := strSQL + '  INNER JOIN COMEMP E ON E.COM_SEQGER = V.AUTOINCREM    ';
    strSQL := strSQL + 'WHERE                                                   ';
    strSQL := strSQL + '  CURRENT_DATE BETWEEN COM_DTAINI AND COM_DTAFIN AND    ';
    strSQL := strSQL + '  E.COM_CODEMP = :CODEMP                         AND    ';
    strSQL := strSQL + '  (C.COM_CODITE = :CODITE OR S.SIM_CODITE = :CODITE)    ';

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := getCodEmp ;
      ParamByName('CODITE').AsString := getCodIte;
      Open;
      Result := FieldByName('QTDATI').AsInteger;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fRetQtdParaAtivacao]');
  End;

end;

function TComVen.fTemComboVigente: Boolean;
begin

  Result := False;

  Try

    setFilAti(False);
    setFilCom(False);

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCombo('COUNT(0) AS QTD'));
      pSetaParametrosCombo(qryGeneri);
      Result := ExecutarQueryEmCache(qryGeneri).FieldByName('QTD').AsInteger > 0;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fTemComboVigente]')
  End;

end;

function TComVen.fTemComboVigenteParaOProdutoAtivacao: Boolean;
begin

  Result := False;

  Try

    setFilAti(True);

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCombo('COUNT(0) AS QTD'));
      pSetaParametrosCombo(qryGeneri);
      Result := ExecutarQueryEmCache(qryGeneri).FieldByName('QTD').AsInteger > 0;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fTemComboVigenteParaOProdutoAtivacao]')
  End;

end;

function TComVen.fTemComboVigenteParaOProdutoComboOuSimilar: Boolean;
begin
  Result := False;

  Try

    setFilAti(True);
    setFilCom(True);

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCombo('COUNT(0) AS QTD'));
      pSetaParametrosCombo(qryGeneri);
      Result := ExecutarQueryEmCache(qryGeneri).FieldByName('QTD').AsInteger > 0;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fTemComboVigenteParaOProdutoComboOuSimilar]')
  End;
end;

function TComVen.fDeveAbrirTelaIndicacaoProdCombo: Boolean;
  Var
    qryProAti : TUniQuery;
begin
  If (Not fEmptyStr(strDeveAbrirTelaIndicacaoProdCombo)) Then
  Begin
    Result := (strDeveAbrirTelaIndicacaoProdCombo = 'S');
    Exit;
  End;
  qryProAti := fCriaQuery;
  Try
    qryProAti.Close;
    qryProAti.SQL.Clear;
    qryProAti.SQL.Add(' SELECT A.ATI_CODITE ');
    qryProAti.SQL.Add('   FROM PROATI A ');
    qryProAti.SQL.Add('   JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER ');
    qryProAti.SQL.Add('  WHERE CURRENT_DATE BETWEEN COM_DTAINI AND COM_DTAFIN ');
    qryProAti.SQL.Add('  LIMIT 1 ');
    qryProAti.Open;
    If (qryProAti.IsEmpty) Then
      strDeveAbrirTelaIndicacaoProdCombo := 'N'
    Else
      strDeveAbrirTelaIndicacaoProdCombo := 'S';
    Result := (strDeveAbrirTelaIndicacaoProdCombo = 'S');
  Finally
    FreeAndNil(qryProAti);
  End;
end;
function TComVen.getAbrTel: Boolean;
begin
  Result := blnAbrTel;
end;

function TComVen.getBrinde: String;
begin
  Result := strBrinde;
end;

function TComVen.getcdsBanner: TUniClientDataSet;
begin
  Result := cdsBanner;
end;

function TComVen.getCodEmp: String;
begin
  Result := strCodEmp;
end;

function TComVen.getCodIte: String;
begin
  Result := strCodIte;
end;

function TComVen.getEntRet: String;
begin
  Result := strEntRet;
end;

function TComVen.getIteAti: String;
begin
  Result := strIteAti;
end;

function TComVen.getLotAti: String;
begin
  Result := strLotAti;
end;

function TComVen.getIteCom: String;
begin
  Result := strIteCom;
end;

function TComVen.getFilAti: Boolean;
begin
  Result := blnFilAti;
end;

function TComVen.getFilCom: Boolean;
begin
  Result := blnFilCom;
end;

function TComVen.getQtdAti: Double;
begin
  Result := fltQtdAti;
end;

function TComVen.getQtdCom: Double;
begin
  Result := fltQtdCom;
end;

function TComVen.getQtdIte: Double;
begin
  Result := fltQtdIte;
end;

function TComVen.getSelPro: Boolean;
Begin
  Result := blnSelPro;
end;

function TComVen.getTabPre: String;
begin
  Result := strTabPre;
end;

function TComVen.getTemCom: Boolean;
begin
  Result := blnTemCom;
end;

{$IFNDEF LINUX}
function TComVen.fAbreTelaIndicacaoProdCombo: Boolean;
Begin
  Result := False;
  If (Not fDeveAbrirTelaIndicacaoProdCombo) Then
    Exit;
  Try
    pCarregaProdutosIndicacaoCombo;

    If fCfgSis('SUPRCB', varBoolean) Then
    Begin
      pCarregaProdutosComboGeral;
      If (Not cdsProCom.IsEmpty) Then
      Begin
        If (Not fChamaTelaGravando(fCalculaPrecoVendaCombo)) Then
          Exit;
      End;

      If (cdsProInd.RecordCount > 0) Then
      Begin
        pCriarFormularios(TfrmFatMostraComboProdAtivacao, frmFatMostraComboProdAtivacao);
        Try
          frmFatMostraComboProdAtivacao.dtsComVen.DataSet := cdsProInd;
          frmFatMostraComboProdAtivacao.dtsProCom.DataSet := cdsProCom;
          frmFatMostraComboProdAtivacao.ShowModal;

          If (frmFatMostraComboProdAtivacao.ModalResult = mrOk) Then
          Begin
            setIteAti(cdsProInd.FieldByName('CODITE').AsString);
            setLotAti(cdsProInd.FieldByName('NUMLOT').AsString);
            setQtdAti(cdsProInd.FieldByName('QTDITE').AsFloat);

            Result := True;
          End;
        Finally
          pFreeAndNil(frmFatMostraComboProdAtivacao);
        End;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fAbreTelaIndicacaoProdCombo]');
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TComVen.fAbreTelaSelecaoProdCombo: Boolean;
begin

  Result := False;

  Try
    pCarregaProdutosCombo;
    pCarregaProdutosSimilares;

    If (Not fChamaTelaGravando(fCalculaPrecoVendaCombo))   Or
       (Not fChamaTelaGravando(fCalculaPrecoVendaSimilar)) Then
      Exit;

    pCriarFormularios(TfrmFatMostraComboProdVenda, frmFatMostraComboProdVenda);
    frmFatMostraComboProdVenda.dtsProCom.DataSet := cdsProCom;
    frmFatMostraComboProdVenda.dtsProSim.DataSet := cdsProSim;

    If (getSelPro) Then
    Begin
      With cdsProCom Do
      Begin
        First;

        While Not Eof Do
        Begin
          Edit;
          FieldByName('MARDES').AsString := 'N';

          If (Pos(FieldByName('CODITE').AsString, stlProSel.CommaText) > 0) Then
          Begin
            FieldByName('MARDES').AsString := 'S';
            stlProSel.Delete(stlProSel.IndexOf(FieldByName('CODITE').AsString));
          End;

          Post;

          Next;
        End;
      End;

      If (stlProSel.Count > 0) Then
      Begin
        With cdsProSim Do
        Begin
          First;

          While Not Eof Do
          Begin
            If (Pos(FieldByName('CODITE').AsString, stlProSel.CommaText) > 0) Then
            Begin
              If (cdsProCom.Locate('AUTINC', FieldByName('SEQGER').AsString, [])) Then
                frmFatMostraComboProdVenda.btnTroCom.Click;
            End;

            Next;
          End;
        End;
      End;

    End;

    frmFatMostraComboProdVenda.setFilSim(True);
    frmFatMostraComboProdVenda.pFiltraProdSimilares;

    If (getAbrTel) Then
      frmFatMostraComboProdVenda.ShowModal
    Else
      frmFatMostraComboProdVenda.btnConfirma.Click;

    If (frmFatMostraComboProdVenda.ModalResult = mrOk) Then
    Begin
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pAbreTelaSelecaoProdCombo]');
  End;

  pFreeAndNil(frmFatMostraComboProdVenda);

end;
{$ENDIF}

procedure TComVen.pAdicionaSelecao(strCodIte: String);
begin
  stlProSel.Add(strCodIte);
end;

procedure TComVen.pCarregaProdutosCombo;
begin

  Try

    If (cdsProCom.Active) Then
    Begin
      cdsProCom.EmptyDataSet;
      cdsProCom.Close;
      cdsProCom.SetProvider(dspProCom);
    End;

    setFilAti(True);
    setFilCom(False);

    With qryProCom Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCombo);
      pSetaParametrosCombo(qryProCom);
      Open;
      pSetaClient(qryProCom);
      cdsProCom.Open;
      pSetaClient(cdsProCom);

      TFloatField(cdsProCom.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
      TFloatField(cdsProCom.FieldByName('PREVEN')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosCombo]')
  End;

end;

procedure TComVen.pCarregaProdutosComboGeral;
begin
  Try

    If (cdsProCom.Active) Then
    Begin
      cdsProCom.EmptyDataSet;
      cdsProCom.Close;
      cdsProCom.SetProvider(dspProCom);
    End;

    setFilAti(False);
    setFilCom(False);

    With qryProCom Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCombo);
      pSetaParametrosCombo(qryProCom);
      Open;
      pSetaClient(qryProCom);
      cdsProCom.Open;
      pSetaClient(cdsProCom);

      TFloatField(cdsProCom.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
      TFloatField(cdsProCom.FieldByName('PREVEN')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosComboGeral]')
  End;
end;

procedure TComVen.pCarregaProdutosIndicacaoCombo;
begin
  Try

    If (cdsProInd.Active) Then
    Begin
      cdsProInd.EmptyDataSet;
      cdsProInd.Close;
      cdsProInd.SetProvider(dspProInd);
    End;

    With qryProInd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLProdIndicacao);
      pSetaParametrosProdIndicacao(qryProInd);
      Open;
      pSetaClient(qryProInd);

      cdsProInd.Open;
      pSetaClient(cdsProInd);

      cdsProInd.Locate('CODITE', getCodIte, []);

      TFloatField(cdsProInd.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosIndicacaoCombo]')
  End;

end;

procedure TComVen.pCarregaProdutosParaBanner(strTabPre: String);
Var
  objOutputStream : TBytesStream;
  LArrRecNo: TArray<String>;
begin
  Try
    cdsBanner.EmptyDataSet;

    With qryProInd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLProdIndicacaoBanner(strTabPre));
      pSetaParametrosProdIndicacaoBanner(qryProInd);
      Open;

      SetLength(LArrRecNo, 0);
      If RecordCount > fCfgSis('BANQTD', VarInteger) Then
      Begin
        First;
        While Not Eof Do
        Begin
          If FItensJaExibidosBanner.IndexOf(FieldByName('CODITE').AsString) = -1 Then
          Begin
            SetLength(LArrRecNo, Length(LArrRecNo)+1);
            LArrRecNo[Length(LArrRecNo)-1] := RecNo.ToString;
            FItensJaExibidosBanner.Add(FieldByName('CODITE').AsString);
          End;

          If Length(LArrRecNo) >= fCfgSis('BANQTD', VarInteger) Then
            If (RecordCount - RecNo) >= fCfgSis('BANQTD', VarInteger) Then
              Break;

          Next;
        End;
      End;

      If FItensJaExibidosBanner.Count >= RecordCount Then
        FItensJaExibidosBanner.Clear;

      If Length(LArrRecNo) < fCfgSis('BANQTD', VarInteger) Then
        FItensJaExibidosBanner.Clear;

      First;
      While Not Eof Do
      Begin
        If Length(LArrRecNo) > 0 Then
        Begin
          If Not MatchStr(RecNo.ToString, LArrRecNo) Then
          Begin
            Next;
            Continue;
          End;
        End;

        If cdsBanner.RecordCount >= fCfgSis('BANQTD', VarInteger) Then
          Break;

        cdsBanner.Insert;
        cdsBanner.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
        cdsBanner.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
        cdsBanner.FieldByName('PREVEN').AsFloat  := FieldByName('PREVEN').AsFloat;
        cdsBanner.FieldByName('DESCOM').AsString := FieldByName('DESCOM').AsString;
        cdsBanner.FieldByName('TABPRE').AsString := FieldByName('TABPRE').AsString;
        cdsBanner.FieldByName('VIGENC').AsString := FieldByName('VIGENC').AsString;
        cdsBanner.FieldByName('EMPRES').AsString := FieldByName('EMPRES').AsString;

        {$IFNDEF LINUX}
        If fRetornaPathImagem(False) <> '' Then
        Begin
          objOutputStream := TBytesStream.Create;
          Try
            If fCarregaImagemPrincipalProdutoDB(FieldByName('CODITE').AsString, objOutputStream, False) Then
              TBlobField(cdsBanner.FieldByName('IMAGEM')).LoadFromStream(objOutputStream);
          Finally
            If Assigned(objOutputStream) Then objOutputStream.Free;
          End;
        End;
        {$ENDIF}

        cdsBanner.Post;

        Next;
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosParaBanner]')
  End;
end;

procedure TComVen.pCarregaProdutosSimilares;
begin

  Try

    If (cdsProSim.Active) Then
    Begin
      cdsProSim.EmptyDataSet;
      cdsProSim.Close;
      cdsProSim.SetProvider(dspProSim);
    End;

    With qryProSim Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLSimilares);
      pSetaParametrosSImilares(qryProSim);
      Open;
      pSetaClient(qryProSim);

      cdsProSim.Open;
      pSetaClient(cdsProSim);

      TFloatField(cdsProSim.FieldByName('PREVEN')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosSimilares]')
  End;

end;

procedure TComVen.pCriaClientProdIndicacaoBanner;
begin
  cdsBanner := TUniClientDataSet.Create(Owner);
  cdsBanner.AggregatesActive := True;

  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 100; Required := False; End;
  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'PREVEN'; DataType := ftFloat;               Required := False; End; //(12,02)
  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'IMAGEM'; DataType := ftBlob;                Required := False; End;

  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'DESCOM'; DataType := ftString; Size := 50;  Required := False; End;
  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'TABPRE'; DataType := ftString; Size := 100; Required := False; End;
  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'VIGENC'; DataType := ftString; Size := 30;  Required := False; End;
  With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'EMPRES'; DataType := ftString; Size := 200; Required := False; End;

  cdsBanner.CreateDataSet;

  cdsBanner.LogChanges := False;

  TBlobField.Create(cdsBanner.FieldByName('IMAGEM') as TBlobField);
end;

procedure TComVen.pCriaComponentes;
begin
  qryGeneri := fCriaQuery(Nil);

  qryProCom := fCriaQuery(Nil);
  qryProSim := fCriaQuery(Nil);
  qryProInd := fCriaQuery(Nil);

  dspProCom := TUniDataSetProvider.Create(Nil);
  dspProSim := TUniDataSetProvider.Create(Nil);
  dspProInd := TUniDataSetProvider.Create(Nil);

  cdsProCom := TUniClientDataSet.Create(Nil);
  cdsProSim := TUniClientDataSet.Create(Nil);
  cdsProInd := TUniClientDataSet.Create(Nil);

  dspProCom.DataSet := qryProCom;
  dspProSim.DataSet := qryProSim;
  dspProInd.DataSet := qryProInd;

  cdsProCom.SetProvider(dspProCom);
  cdsProSim.SetProvider(dspProSim);
  cdsProInd.SetProvider(dspProInd);

  stlProSel := TStringList.Create;
  pCriaClientProdIndicacaoBanner;
end;

procedure TComVen.pDestroiComponentes;
begin
  FreeAndNil(qryGeneri);

  FreeAndNil(cdsProCom);
  FreeAndNil(dspProCom);
  FreeAndNil(qryProCom);

  FreeAndNil(cdsProSim);
  FreeAndNil(dspProSim);
  FreeAndNil(qryProSim);

  FreeAndNil(cdsProInd);
  FreeAndNil(dspProInd);
  FreeAndNil(qryProInd);

  FreeAndNil(stlProSel);

  FreeAndNil(cdsBanner);
end;

procedure TComVen.pLimpaProdutosSelecionados;
begin
  stlProSel.Clear;
end;

procedure TComVen.pSetaParametrosCombo(qryCombo: TUniQuery);
begin
  With qryCombo Do
  Begin
    ParamByName('DTAATU').AsDateTime := VS_Date;
    ParamByName('CODEMP').AsString   := getCodEmp;

    If (getFilAti) Then
    Begin
      ParamByName('CODITE').AsString  := getCodIte;
      ParamByName('QTDITE').AsFloat   := getQtdIte;
      ParamByName('TABPRE').AsInteger := StrToIntDef(getTabPre, 0);
    End;

    If (getFilCom) Then
      ParamByName('ITECOM').AsString := getIteCom;

  End;
end;

procedure TComVen.pSetaParametrosProdIndicacao(qryIndicac: TUniQuery);
begin
  With qryIndicac Do
  Begin
    ParamByName('DTAATU').AsDateTime := VS_Date;
    ParamByName('CODEMP').AsString   := getCodEmp;
    ParamByName('CODITE').AsString   := getCodIte;
    ParamByName('TABPRE').AsString   := getTabPre;
  End;
end;

procedure TComVen.pSetaParametrosProdIndicacaoBanner(qryIndicac: TUniQuery);
begin
  With qryIndicac Do
  Begin
    ParamByName('DTAATU').AsDateTime := VS_Date;
    ParamByName('CODEMP').AsString   := getCodEmp;
  End;
end;

procedure TComVen.pSetaParametrosSimilares(qrySimilar: TUniQuery);
begin
  With qrySimilar Do
  Begin
    ParamByName('DTAATU').AsDateTime := VS_Date;
    ParamByName('CODEMP').AsString   := getCodEmp;
    ParamByName('CODITE').AsString   := getCodIte;
    ParamByName('QTDITE').AsFloat    := getQtdIte;
  End;
end;

procedure TComVen.setAbrTel(Value: Boolean);
begin
  blnAbrTel := Value;
end;

procedure TComVen.setCodEmp(Value: String);
begin
  strCodEmp := Value;
end;

procedure TComVen.setCodIte(Value: String);
begin
  strCodIte := Value;
end;

procedure TComVen.setEntRet(Value: String);
begin
  strEntRet := Value;
end;

procedure TComVen.setIteAti(Value: String);
begin
  strIteAti := Value;
end;

procedure TComVen.setLotAti(Value: String);
begin
  strLotAti := Value;
end;

procedure TComVen.setIteCom(Value: String);
begin
  strIteCom := Value;
end;

procedure TComVen.setFilAti(Value: Boolean);
begin
  blnFilAti := Value;
end;

procedure TComVen.setFilCom(Value: Boolean);
begin
  blnFilCom := Value;
end;

procedure TComVen.setQtdAti(Value: Double);
begin
  fltQtdAti := Value;
end;

procedure TComVen.setQtdIte(Value: Double);
begin
  fltQtdIte := Value;
end;

procedure TComVen.setSelPro(Value: Boolean);
begin
  blnSelPro := Value;
end;

procedure TComVen.setTabPre(Value: String);
begin
  strTabPre := Value;
end;

procedure TComVen.setTemCom(Value: Boolean);
begin
  blnTemCom := Value;
end;

initialization
  TComVen.FItensJaExibidosBanner := TStringList.Create;
finalization
  FreeAndNil(TComVen.FItensJaExibidosBanner);
end.
