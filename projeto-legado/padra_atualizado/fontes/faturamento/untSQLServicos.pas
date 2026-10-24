unit untSQLServicos;

interface

uses Uni;

procedure pSQLServico(qry: TUniQuery; strNomeSQL: String; arrParams: Array Of Const; strNomeTabela: String);

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Classes, SysUtils, AnsiStrings;

procedure pSQLServico(qry: TUniQuery; strNomeSQL: String; arrParams: Array Of Const; strNomeTabela: String);
  Var
    strCampo,
    strTabela: String;
begin
  If strNomeSQL = 'PRISMAS_DATA_MINIMA' Then
  Begin
    // [0] = Código da Empresa
    // [1] = Data Mínima dos pedidos
    qry.SQL.Add('SELECT');
    qry.SQL.Add('       FGO_NUMDOC,');
    qry.SQL.Add('       FGO_ESPDOC,');
    qry.SQL.Add('       FGO_CODEMP,');
    qry.SQL.Add('       FGO_CODS01,');
    qry.SQL.Add('       FGO_CODS02,');
    qry.SQL.Add('       FGO_CODS03,');
    qry.SQL.Add('       FGO_CODS04,');
    qry.SQL.Add('       FGO_CODS05,');
    qry.SQL.Add('       FGO_CODS06,');
    qry.SQL.Add('       FGO_CODS07,');
    qry.SQL.Add('       FGO_CODS08,');
    qry.SQL.Add('       FGO_CODS09,');
    qry.SQL.Add('       FGO_CODS10,');
    qry.SQL.Add('       FGO_CODS11,');
    qry.SQL.Add('       FGO_CODS12,');
    qry.SQL.Add('       FGO_CODS13,');
    qry.SQL.Add('       FGO_CODS14,');
    qry.SQL.Add('       FGO_CODS15,');
    qry.SQL.Add('       FGO_CODS16,');
    qry.SQL.Add('       FGO_CODS17,');
    qry.SQL.Add('       FGO_CODS18,');
    qry.SQL.Add('       FGO_CODS19,');
    qry.SQL.Add('       FGO_CODS20,');
    qry.SQL.Add('       FGO_CODS21,');
    qry.SQL.Add('       FGO_CODS22,');
    qry.SQL.Add('       FGO_CODS23,');
    qry.SQL.Add('       FGO_CODS24,');
    qry.SQL.Add('       FGO_CODS25,');
    qry.SQL.Add('       FGO_CODS26,');
    qry.SQL.Add('       FGO_CODS27,');
    qry.SQL.Add('       FGO_CODS28,');
    qry.SQL.Add('       FGO_CODS29,');
    qry.SQL.Add('       FGO_CODS30,');
    qry.SQL.Add('       FGO_PRIS01,');
    qry.SQL.Add('       FGO_PRIS02,');
    qry.SQL.Add('       FGO_PRIS03,');
    qry.SQL.Add('       FGO_PRIS04,');
    qry.SQL.Add('       FGO_PRIS05,');
    qry.SQL.Add('       FGO_PRIS06,');
    qry.SQL.Add('       FGO_PRIS07,');
    qry.SQL.Add('       FGO_PRIS08,');
    qry.SQL.Add('       FGO_PRIS09,');
    qry.SQL.Add('       FGO_PRIS10,');
    qry.SQL.Add('       FGO_PRIS11,');
    qry.SQL.Add('       FGO_PRIS12,');
    qry.SQL.Add('       FGO_PRIS13,');
    qry.SQL.Add('       FGO_PRIS14,');
    qry.SQL.Add('       FGO_PRIS15,');
    qry.SQL.Add('       FGO_PRIS16,');
    qry.SQL.Add('       FGO_PRIS17,');
    qry.SQL.Add('       FGO_PRIS18,');
    qry.SQL.Add('       FGO_PRIS19,');
    qry.SQL.Add('       FGO_PRIS20,');
    qry.SQL.Add('       FGO_PRIS21,');
    qry.SQL.Add('       FGO_PRIS22,');
    qry.SQL.Add('       FGO_PRIS23,');
    qry.SQL.Add('       FGO_PRIS24,');
    qry.SQL.Add('       FGO_PRIS25,');
    qry.SQL.Add('       FGO_PRIS26,');
    qry.SQL.Add('       FGO_PRIS27,');
    qry.SQL.Add('       FGO_PRIS28,');
    qry.SQL.Add('       FGO_PRIS29,');
    qry.SQL.Add('       FGO_PRIS30,');
    qry.SQL.Add('       FGO_STAS01,');
    qry.SQL.Add('       FGO_STAS02,');
    qry.SQL.Add('       FGO_STAS03,');
    qry.SQL.Add('       FGO_STAS04,');
    qry.SQL.Add('       FGO_STAS05,');
    qry.SQL.Add('       FGO_STAS06,');
    qry.SQL.Add('       FGO_STAS07,');
    qry.SQL.Add('       FGO_STAS08,');
    qry.SQL.Add('       FGO_STAS09,');
    qry.SQL.Add('       FGO_STAS10,');
    qry.SQL.Add('       FGO_STAS11,');
    qry.SQL.Add('       FGO_STAS12,');
    qry.SQL.Add('       FGO_STAS13,');
    qry.SQL.Add('       FGO_STAS14,');
    qry.SQL.Add('       FGO_STAS15,');
    qry.SQL.Add('       FGO_STAS16,');
    qry.SQL.Add('       FGO_STAS17,');
    qry.SQL.Add('       FGO_STAS18,');
    qry.SQL.Add('       FGO_STAS19,');
    qry.SQL.Add('       FGO_STAS20,');
    qry.SQL.Add('       FGO_STAS21,');
    qry.SQL.Add('       FGO_STAS22,');
    qry.SQL.Add('       FGO_STAS23,');
    qry.SQL.Add('       FGO_STAS24,');
    qry.SQL.Add('       FGO_STAS25,');
    qry.SQL.Add('       FGO_STAS26,');
    qry.SQL.Add('       FGO_STAS27,');
    qry.SQL.Add('       FGO_STAS28,');
    qry.SQL.Add('       FGO_STAS29,');
    qry.SQL.Add('       FGO_STAS30');
    qry.SQL.Add('  FROM FATGOR');
    qry.SQL.Add('  JOIN SERGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM');
    qry.SQL.Add(' WHERE FGO_CODEMP = :CODEMP');
    qry.SQL.Add('   AND FGO_DTAENT >= :DTAINI');
    qry.SQL.Add('   AND FGO_JAFATU = 0');

    qry.ParamByName('CODEMP').AsString := String(arrParams[0].VString);
    qry.ParamByName('DTAINI').AsDateTime := arrParams[1].VExtended^;
  End

  Else If strNomeSQL = 'OBSERVACOES_DOS_SERVICOS' Then
  Begin
    // [0] = Auto Increment
    // [1] = Tabela (FATGOR|MOVGER|)
    
    If LeftStr(AnsiString(String(arrParams[1].VString)), 3) = 'FAT' Then
    Begin
      qry.SQL.Add('SELECT FGO_IDESER AS IDESER,');
      qry.SQL.Add('       FGO_OBSERV AS OBSERV');
      qry.SQL.Add('  FROM OBSGOR');
      qry.SQL.Add(' WHERE FGO_SEQFGO = :AUTINC');
    End
    Else
    Begin
      qry.SQL.Add('SELECT GER_IDESER AS IDESER,');
      qry.SQL.Add('       GER_OBSERV AS OBSERV');
      qry.SQL.Add('  FROM OBSGER ');
      qry.SQL.Add(' WHERE GER_SEQGER = :AUTINC');
    End;

    qry.ParamByName('AUTINC').AsString := String(arrParams[0].VString);
  End

  Else If strNomeSQL = 'TAB_CAMPOS_SERVICO' Then
  Begin
    // [0] = Auto Increment
    // [1] = Tabela (FATGOR|MOVGER)

    If LeftStr(AnsiString(String(arrParams[1].VString)), 3) = 'FAT' Then
    Begin
      qry.SQL.Add('SELECT FGO_QTDS01 AS QTDS01,');
      qry.SQL.Add('       FGO_QTDS02 AS QTDS02,');
      qry.SQL.Add('       FGO_QTDS03 AS QTDS03,');
      qry.SQL.Add('       FGO_QTDS04 AS QTDS04,');
      qry.SQL.Add('       FGO_QTDS05 AS QTDS05,');
      qry.SQL.Add('       FGO_QTDS06 AS QTDS06,');
      qry.SQL.Add('       FGO_QTDS07 AS QTDS07,');
      qry.SQL.Add('       FGO_QTDS08 AS QTDS08,');
      qry.SQL.Add('       FGO_QTDS09 AS QTDS09,');
      qry.SQL.Add('       FGO_QTDS10 AS QTDS10,');
      qry.SQL.Add('       FGO_QTDS11 AS QTDS11,');
      qry.SQL.Add('       FGO_QTDS12 AS QTDS12,');
      qry.SQL.Add('       FGO_QTDS13 AS QTDS13,');
      qry.SQL.Add('       FGO_QTDS14 AS QTDS14,');
      qry.SQL.Add('       FGO_QTDS15 AS QTDS15,');
      qry.SQL.Add('       FGO_QTDS16 AS QTDS16,');
      qry.SQL.Add('       FGO_QTDS17 AS QTDS17,');
      qry.SQL.Add('       FGO_QTDS18 AS QTDS18,');
      qry.SQL.Add('       FGO_QTDS19 AS QTDS19,');
      qry.SQL.Add('       FGO_QTDS20 AS QTDS20,');
      qry.SQL.Add('       FGO_QTDS21 AS QTDS21,');
      qry.SQL.Add('       FGO_QTDS22 AS QTDS22,');
      qry.SQL.Add('       FGO_QTDS23 AS QTDS23,');
      qry.SQL.Add('       FGO_QTDS24 AS QTDS24,');
      qry.SQL.Add('       FGO_QTDS25 AS QTDS25,');
      qry.SQL.Add('       FGO_QTDS26 AS QTDS26,');
      qry.SQL.Add('       FGO_QTDS27 AS QTDS27,');
      qry.SQL.Add('       FGO_QTDS28 AS QTDS28,');
      qry.SQL.Add('       FGO_QTDS29 AS QTDS29,');
      qry.SQL.Add('       FGO_QTDS30 AS QTDS30,');
      qry.SQL.Add('       FGO_UNIS01 AS UNIS01,');
      qry.SQL.Add('       FGO_UNIS02 AS UNIS02,');
      qry.SQL.Add('       FGO_UNIS03 AS UNIS03,');
      qry.SQL.Add('       FGO_UNIS04 AS UNIS04,');
      qry.SQL.Add('       FGO_UNIS05 AS UNIS05,');
      qry.SQL.Add('       FGO_UNIS06 AS UNIS06,');
      qry.SQL.Add('       FGO_UNIS07 AS UNIS07,');
      qry.SQL.Add('       FGO_UNIS08 AS UNIS08,');
      qry.SQL.Add('       FGO_UNIS09 AS UNIS09,');
      qry.SQL.Add('       FGO_UNIS10 AS UNIS10,');
      qry.SQL.Add('       FGO_UNIS11 AS UNIS11,');
      qry.SQL.Add('       FGO_UNIS12 AS UNIS12,');
      qry.SQL.Add('       FGO_UNIS13 AS UNIS13,');
      qry.SQL.Add('       FGO_UNIS14 AS UNIS14,');
      qry.SQL.Add('       FGO_UNIS15 AS UNIS15,');
      qry.SQL.Add('       FGO_UNIS16 AS UNIS16,');
      qry.SQL.Add('       FGO_UNIS17 AS UNIS17,');
      qry.SQL.Add('       FGO_UNIS18 AS UNIS18,');
      qry.SQL.Add('       FGO_UNIS19 AS UNIS19,');
      qry.SQL.Add('       FGO_UNIS20 AS UNIS20,');
      qry.SQL.Add('       FGO_UNIS21 AS UNIS21,');
      qry.SQL.Add('       FGO_UNIS22 AS UNIS22,');
      qry.SQL.Add('       FGO_UNIS23 AS UNIS23,');
      qry.SQL.Add('       FGO_UNIS24 AS UNIS24,');
      qry.SQL.Add('       FGO_UNIS25 AS UNIS25,');
      qry.SQL.Add('       FGO_UNIS26 AS UNIS26,');
      qry.SQL.Add('       FGO_UNIS27 AS UNIS27,');
      qry.SQL.Add('       FGO_UNIS28 AS UNIS28,');
      qry.SQL.Add('       FGO_UNIS29 AS UNIS29,');
      qry.SQL.Add('       FGO_UNIS30 AS UNIS30');
      qry.SQL.Add('  FROM SERGOR');
      qry.SQL.Add(' WHERE FGO_SEQFGO = :AUTINC');
    End
    Else
    Begin
      qry.SQL.Add('SELECT GER_QTDS01 AS QTDS01,');
      qry.SQL.Add('       GER_QTDS02 AS QTDS02,');
      qry.SQL.Add('       GER_QTDS03 AS QTDS03,');
      qry.SQL.Add('       GER_QTDS04 AS QTDS04,');
      qry.SQL.Add('       GER_QTDS05 AS QTDS05,');
      qry.SQL.Add('       GER_QTDS06 AS QTDS06,');
      qry.SQL.Add('       GER_QTDS07 AS QTDS07,');
      qry.SQL.Add('       GER_QTDS08 AS QTDS08,');
      qry.SQL.Add('       GER_QTDS09 AS QTDS09,');
      qry.SQL.Add('       GER_QTDS10 AS QTDS10,');
      qry.SQL.Add('       GER_QTDS11 AS QTDS11,');
      qry.SQL.Add('       GER_QTDS12 AS QTDS12,');
      qry.SQL.Add('       GER_QTDS13 AS QTDS13,');
      qry.SQL.Add('       GER_QTDS14 AS QTDS14,');
      qry.SQL.Add('       GER_QTDS15 AS QTDS15,');
      qry.SQL.Add('       GER_QTDS16 AS QTDS16,');
      qry.SQL.Add('       GER_QTDS17 AS QTDS17,');
      qry.SQL.Add('       GER_QTDS18 AS QTDS18,');
      qry.SQL.Add('       GER_QTDS19 AS QTDS19,');
      qry.SQL.Add('       GER_QTDS20 AS QTDS20,');
      qry.SQL.Add('       GER_QTDS21 AS QTDS21,');
      qry.SQL.Add('       GER_QTDS22 AS QTDS22,');
      qry.SQL.Add('       GER_QTDS23 AS QTDS23,');
      qry.SQL.Add('       GER_QTDS24 AS QTDS24,');
      qry.SQL.Add('       GER_QTDS25 AS QTDS25,');
      qry.SQL.Add('       GER_QTDS26 AS QTDS26,');
      qry.SQL.Add('       GER_QTDS27 AS QTDS27,');
      qry.SQL.Add('       GER_QTDS28 AS QTDS28,');
      qry.SQL.Add('       GER_QTDS29 AS QTDS29,');
      qry.SQL.Add('       GER_QTDS30 AS QTDS30,');
      qry.SQL.Add('       GER_UNIS01 AS UNIS01,');
      qry.SQL.Add('       GER_UNIS02 AS UNIS02,');
      qry.SQL.Add('       GER_UNIS03 AS UNIS03,');
      qry.SQL.Add('       GER_UNIS04 AS UNIS04,');
      qry.SQL.Add('       GER_UNIS05 AS UNIS05,');
      qry.SQL.Add('       GER_UNIS06 AS UNIS06,');
      qry.SQL.Add('       GER_UNIS07 AS UNIS07,');
      qry.SQL.Add('       GER_UNIS08 AS UNIS08,');
      qry.SQL.Add('       GER_UNIS09 AS UNIS09,');
      qry.SQL.Add('       GER_UNIS10 AS UNIS10,');
      qry.SQL.Add('       GER_UNIS11 AS UNIS11,');
      qry.SQL.Add('       GER_UNIS12 AS UNIS12,');
      qry.SQL.Add('       GER_UNIS13 AS UNIS13,');
      qry.SQL.Add('       GER_UNIS14 AS UNIS14,');
      qry.SQL.Add('       GER_UNIS15 AS UNIS15,');
      qry.SQL.Add('       GER_UNIS16 AS UNIS16,');
      qry.SQL.Add('       GER_UNIS17 AS UNIS17,');
      qry.SQL.Add('       GER_UNIS18 AS UNIS18,');
      qry.SQL.Add('       GER_UNIS19 AS UNIS19,');
      qry.SQL.Add('       GER_UNIS20 AS UNIS20,');
      qry.SQL.Add('       GER_UNIS21 AS UNIS21,');
      qry.SQL.Add('       GER_UNIS22 AS UNIS22,');
      qry.SQL.Add('       GER_UNIS23 AS UNIS23,');
      qry.SQL.Add('       GER_UNIS24 AS UNIS24,');
      qry.SQL.Add('       GER_UNIS25 AS UNIS25,');
      qry.SQL.Add('       GER_UNIS26 AS UNIS26,');
      qry.SQL.Add('       GER_UNIS27 AS UNIS27,');
      qry.SQL.Add('       GER_UNIS28 AS UNIS28,');
      qry.SQL.Add('       GER_UNIS29 AS UNIS29,');
      qry.SQL.Add('       GER_UNIS30 AS UNIS30');
      qry.SQL.Add('  FROM SER'+ String(LeftStr(AnsiString(arrParams[1].VString), 3)));
      qry.SQL.Add(' WHERE GER_SEQGER = :AUTINC');
    End;

    qry.ParamByName('AUTINC').AsString := String(arrParams[0].VString);
  End

  Else If strNomeSQL = 'GET_PRISMAS_TIPSER' Then
  Begin
    If Pos('MOVGER', strNomeTabela) > 0 Then
      strCampo := 'GER_'
    Else
      strCampo := 'FGO_';

    // [0] SEQFGO

    qry.SQL.Add('SELECT ' + strCampo + 'PRIS01 AS PRIS01,');
    qry.SQL.Add('       ' + strCampo + 'PRIS02 AS PRIS02,');
    qry.SQL.Add('       ' + strCampo + 'PRIS03 AS PRIS03,');
    qry.SQL.Add('       ' + strCampo + 'PRIS04 AS PRIS04,');
    qry.SQL.Add('       ' + strCampo + 'PRIS05 AS PRIS05,');
    qry.SQL.Add('       ' + strCampo + 'PRIS06 AS PRIS06,');
    qry.SQL.Add('       ' + strCampo + 'PRIS07 AS PRIS07,');
    qry.SQL.Add('       ' + strCampo + 'PRIS08 AS PRIS08,');
    qry.SQL.Add('       ' + strCampo + 'PRIS09 AS PRIS09,');
    qry.SQL.Add('       ' + strCampo + 'PRIS10 AS PRIS10,');
    qry.SQL.Add('       ' + strCampo + 'PRIS11 AS PRIS11,');
    qry.SQL.Add('       ' + strCampo + 'PRIS12 AS PRIS12,');
    qry.SQL.Add('       ' + strCampo + 'PRIS13 AS PRIS13,');
    qry.SQL.Add('       ' + strCampo + 'PRIS14 AS PRIS14,');
    qry.SQL.Add('       ' + strCampo + 'PRIS15 AS PRIS15,');
    qry.SQL.Add('       ' + strCampo + 'PRIS16 AS PRIS16,');
    qry.SQL.Add('       ' + strCampo + 'PRIS17 AS PRIS17,');
    qry.SQL.Add('       ' + strCampo + 'PRIS18 AS PRIS18,');
    qry.SQL.Add('       ' + strCampo + 'PRIS19 AS PRIS19,');
    qry.SQL.Add('       ' + strCampo + 'PRIS20 AS PRIS20,');
    qry.SQL.Add('       ' + strCampo + 'PRIS21 AS PRIS21,');
    qry.SQL.Add('       ' + strCampo + 'PRIS22 AS PRIS22,');
    qry.SQL.Add('       ' + strCampo + 'PRIS23 AS PRIS23,');
    qry.SQL.Add('       ' + strCampo + 'PRIS24 AS PRIS24,');
    qry.SQL.Add('       ' + strCampo + 'PRIS25 AS PRIS25,');
    qry.SQL.Add('       ' + strCampo + 'PRIS26 AS PRIS26,');
    qry.SQL.Add('       ' + strCampo + 'PRIS27 AS PRIS27,');
    qry.SQL.Add('       ' + strCampo + 'PRIS28 AS PRIS28,');
    qry.SQL.Add('       ' + strCampo + 'PRIS29 AS PRIS29,');
    qry.SQL.Add('       ' + strCampo + 'PRIS30 AS PRIS30,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS01) AS TIPS01,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS02) AS TIPS02,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS03) AS TIPS03,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS04) AS TIPS04,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS05) AS TIPS05,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS06) AS TIPS06,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS07) AS TIPS07,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS08) AS TIPS08,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS09) AS TIPS09,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS10) AS TIPS10,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS11) AS TIPS11,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS12) AS TIPS12,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS13) AS TIPS13,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS14) AS TIPS14,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS15) AS TIPS15,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS16) AS TIPS16,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS17) AS TIPS17,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS18) AS TIPS18,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS19) AS TIPS19,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS20) AS TIPS20,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS21) AS TIPS21,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS22) AS TIPS22,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS23) AS TIPS23,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS24) AS TIPS24,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS25) AS TIPS25,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS26) AS TIPS26,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS27) AS TIPS27,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS28) AS TIPS28,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS29) AS TIPS29,');
    qry.SQL.Add('       (SELECT TPS_DESCRI FROM CADSER C JOIN TIPSER T ON T.TPS_CODIGO = C.SER_TIPSER WHERE C.SER_CODSER = ' + strCampo + 'CODS30) AS TIPS30');

    If Pos('MOVGER', strNomeTabela) > 0 Then
    Begin
      If Pos('DEL_', strNomeTabela) > 0 Then
        strTabela := '  DEL_SERMOV '
      Else
        strTabela := '  SERMOV ';
    End
    Else
    Begin
      If Pos('DEL_', strNomeTabela) > 0 Then
        strTabela := '  DEL_SERGOR'
      Else
        strTabela := '  SERGOR ';
    End;

    qry.SQL.Add('  FROM ' + strTabela + ' S');
    qry.SQL.Add('  JOIN ' + strNomeTabela + ' F ON F.AUTOINCREM = S.' + strCampo + 'SEQ' + IIF(SameText('GER_', strCampo), 'GER', 'FGO'));
    qry.SQL.Add(' WHERE ' + strCampo + 'SEQ' + IIF(SameText('GER_', strCampo), 'GER', 'FGO') + ' = :SEQFGO');

    qry.ParamByName('SEQFGO').AsString := String(arrParams[0].VString);
  End

  Else If strNomeSQL = 'SERVICO_PENDENTE' Then
  Begin
    // [0] CODEMP
    // [1] NUMDOC
    qry.SQL.Add('SELECT COUNT(1)');
    qry.SQL.Add('  FROM FATGOR');
    qry.SQL.Add('  JOIN SERGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM');
    qry.SQL.Add('  JOIN STASER ON STS_CODIGO IN (FGO_STAS01, FGO_STAS02, FGO_STAS03, FGO_STAS04, FGO_STAS06, FGO_STAS07, FGO_STAS08, FGO_STAS09, FGO_STAS10, ');
    qry.SQL.Add('                                FGO_STAS11, FGO_STAS12, FGO_STAS13, FGO_STAS14, FGO_STAS16, FGO_STAS17, FGO_STAS18, FGO_STAS19, FGO_STAS20, ');
    qry.SQL.Add('                                FGO_STAS21, FGO_STAS22, FGO_STAS23, FGO_STAS24, FGO_STAS26, FGO_STAS27, FGO_STAS28, FGO_STAS29, FGO_STAS30) ');
    qry.SQL.Add(' WHERE FGO_CODEMP = :CODEMP');
    qry.SQL.Add('   AND FGO_NUMDOC = :NUMDOC');
    qry.SQL.Add('   AND FGO_ESPDOC = "PD"');
    qry.SQL.Add('   AND STS_FINALI = "N"');

    qry.ParamByName('CODEMP').AsString := String(arrParams[0].VString);
    qry.ParamByName('NUMDOC').AsString := String(arrParams[1].VString);
  End;
end;

End.
