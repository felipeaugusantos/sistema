unit untDefineBaixaPedido;

interface

uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, StrUtils, Math, Variants, untConsultas, cxProgressBar,
  untFuncoesSimples, untFuncoesGenerica, untTypesSistema, untCadLote,
  UniDataSetProvider, untPreparaGeracaoTE, untTSituacaoPedidoVenda;

Type
  TDefineBaixaPedido = Class(TZClient)
  Private

    objPreTE: TPreparaGeracaoTE;

    objCadLot: TCadLot;

    cdsSaldoRequisicao: TZClient;

    cdsBaiReq: TZClient;


    Function fSQLDefineBaixa: String;

    Function fPreparaTERequisicao: Boolean;

    Function fSQLSaldoRequisicao: String;

    Function fCarregaDefinicaoBaixa(strSeqGer: String; stlProdutos: String = ''): Boolean;

    Function fSQLDefinicaoBaixa(stlProdutos: String): String;

  Public
    blnx922: Boolean;

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor Destroy; override;

    Function fIniciaDados: Boolean;
    Function fBaixaEntregaFuturaPedido(TipoCfop: TTipoCfop): Boolean;

    Procedure pAtualizaAutoincrem(strAutTemp, strAutInc: String);

    Procedure pInsereBaixa(strAutDet, strAutPcd: String; fltQtdIte: Double);

    Function fSalva: Boolean; Reintroduce;

    Class function fEstornaPedidoPorDefinicaoDeBaixa(strAutInc: String; blnUsaConferenciaParcial: Boolean; var AstlPedComAux: TStringList): Boolean;

    Class Function fLiberaPreparacaoTECancelamento(strNumDoc, strSerie, strCodEmp, strCodFor, strEspDoc: String): Boolean;

    Class Procedure pGravaDeletadosRequisicao(strNumDoc, strSerie, strCodEmp, strCodFor, strEspDoc, frmName: String);

    Function fGeraTERequisicao(strSeqGer: String; stlProdutos: String = ''): Boolean;
    class procedure ProcessaStatusPedidoRequisicao(strSeqGer: String);
    class procedure ProcessaStatusPedidoPendenteEnderecamento(strSeqGer: String);

    class procedure ProcessaStatusPedidoRequisicaoConferencia(strSeqGer: String);


  End;

implementation

Uses
  untFuncFat, untLiberacao, untMsgLiberacao, untSaldoPedidoCompra;

constructor TDefineBaixaPedido.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

  objPreTE := TPreparaGeracaoTE.Create;

  objCadLot := TCadLot.Create(Self);
  blnx922 := False;

  cdsSaldoRequisicao := TZClient.Create(Self, fSQLSaldoRequisicao);
  cdsSaldoRequisicao.fLeDados('TDefineBaixaPedido.Create');
  cdsSaldoRequisicao.IndexFieldNames := 'AUTINC';

  cdsBaiReq := TZClient.Create(Self, 'SELECT * FROM BAIREQ WHERE FALSE');
  cdsBaiReq.fLeDados('TDefineBaixaPedido.Create');

End;

Destructor TDefineBaixaPedido.Destroy;
Begin
  If Assigned(objPreTE) Then
    FreeAndNil(objPreTE);
  If Assigned(objCadLot) Then
    FreeAndNil(objCadLot);
  If Assigned(cdsSaldoRequisicao) Then
    FreeAndNil(cdsSaldoRequisicao);
  If Assigned(cdsBaiReq) Then
    FreeAndNil(cdsBaiReq);

  Inherited;
End;

Function TDefineBaixaPedido.fSQLSaldoRequisicao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '   RCD_QTDITE AS QTDTOT, ';
  strSQL := strSQL + '   RCD_QTDITE AS QTDRES  ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   MOVRCD ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   FALSE  ';

  Result := strSQL;
End;

Function TDefineBaixaPedido.fSQLDefinicaoBaixa(stlProdutos: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM BAIPED ';
  strSQL := strSQL + ' INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET ';
  strSQL := strSQL + ' WHERE D.DET_SEQGER = :SEQGER ';

  If Not stlProdutos.IsEmpty Then
    strSQL := strSQL + ' AND D.DET_CODITE IN (' +  stlProdutos + ') ';

  Result := strSQL;
End;

function TDefineBaixaPedido.fBaixaEntregaFuturaPedido(TipoCfop: TTipoCfop): Boolean;
var qryConsulta: TUniquery;
    strField: String;
begin
  qryConsulta := fCriaQuery;
  Try
    strField := IIf(TipoCfop = tcCFOP117, 'PCD_QTDENT', 'PCD_QTDFUT');
    Self.First;
    qryConsulta.SQL.Text := 'UPDATE PCMDET SET ' + strField+ ' = IFNULL(' + strField + ', 0) + :QTDFUT WHERE AUTOINCREM = :AUTINC';
    While not Self.Eof Do
    Begin
      qryConsulta.ParamByName('QTDFUT').AsFloat  := Self.FieldByName('BAI_QTDPED').AsFloat;
      qryConsulta.ParamByName('AUTINC').AsString := Self.FieldByName('BAI_AUTPED').AsString;


      qryConsulta.ExecSQL;
      Self.Next;
    End;
    Result := True;
  Finally

    FreeAndNil(qryConsulta)
  End;
end;

Function TDefineBaixaPedido.fCarregaDefinicaoBaixa(strSeqGer: String; stlProdutos: String = ''): Boolean;
Begin
  Self.qryQuery.SQL.Text := fSQLDefinicaoBaixa(stlProdutos);
  Self.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;

  Result := Self.fLeDados('TDefineBaixaPedido.fCarregaDefinicaoBaixa');
End;

Function TDefineBaixaPedido.fGeraTERequisicao(strSeqGer: String; stlProdutos: String = ''): Boolean;
Begin
  Result := fCarregaDefinicaoBaixa(strSeqGer, stlProdutos) And fPreparaTERequisicao;
End;

class procedure TDefineBaixaPedido.ProcessaStatusPedidoPendenteEnderecamento(strSeqGer: String);
var
  qryRequis: TUniQuery;
begin
  If Not fCfgSis('EXISTA', varBoolean) Then
    Exit;
  qryRequis := fCriaQuery;
  Try
    qryRequis.SQL.Clear;
    qryRequis.SQL.Add('SELECT DISTINCT FATGOR.FGO_NUMDOC, FATGOR.FGO_ESPDOC, FATGOR.FGO_CODEMP, FATGOR.FGO_CODCLI FROM MOVGER');
    qryRequis.SQL.Add(' INNER JOIN GERELE ON GERELE.GER_DOCENT = MOVGER.GER_NUMDOC');
    qryRequis.SQL.Add('                  AND GERELE.GER_ESPENT = MOVGER.GER_ESPDOC');
    qryRequis.SQL.Add('                  AND GERELE.GER_EMPENT = MOVGER.GER_CODEMP');
    qryRequis.SQL.Add('                  AND GERELE.GER_CODFOR = MOVGER.GER_CODFOR');
    qryRequis.SQL.Add(' INNER JOIN DEFBAI ON  DEF_GERELE = GERELE.AUTOINCREM');
    qryRequis.SQL.Add(' INNER JOIN PCMDET ON PCMDET.AUTOINCREM = DEF_AUTPCD');
    qryRequis.SQL.Add(' INNER JOIN MOVRCD ON MOVRCD.RCD_SEQPCD = PCMDET.AUTOINCREM');
    qryRequis.SQL.Add(' INNER JOIN FATGOR ON FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP =  RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV');
    qryRequis.SQL.Add(' WHERE MOVGER.AUTOINCREM = "' + strSeqGer + '"');

    qryRequis.Open;

    while not qryRequis.Eof do
    Begin
      TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(qryRequis.FieldByName('FGO_NUMDOC').AsString)
                              .EspDoc(qryRequis.FieldByName('FGO_ESPDOC').AsString)
                              .CodEmp(qryRequis.FieldByName('FGO_CODEMP').AsString)
                              .CodCli(qryRequis.FieldByName('FGO_CODCLI').AsString)).pExecute();
      qryRequis.Next;
    End;
  Finally
    FreeAndNil(qryRequis);
  End;

End;

class procedure TDefineBaixaPedido.ProcessaStatusPedidoRequisicao(strSeqGer: String);
var
  qryRequis: TUniQuery;
begin
  If Not fCfgSis('EXISTA', varBoolean) Then
    Exit;
  qryRequis := fCriaQuery;
  Try
    qryRequis.SQL.Clear;
    qryRequis.SQL.Add('SELECT DISTINCT FATGOR.FGO_NUMDOC, FATGOR.FGO_ESPDOC, FATGOR.FGO_CODEMP, FATGOR.FGO_CODCLI FROM MOVDET');

    qryRequis.SQL.Add('  INNER JOIN BAIPED ON BAI_AUTDET = MOVDET.AUTOINCREM ');
    qryRequis.SQL.Add('  INNER JOIN PCMDET PD ON PD.AUTOINCREM = BAI_AUTPED ');
    qryRequis.SQL.Add('  INNER JOIN MOVRCD ON MOVRCD.RCD_SEQPCD = BAI_AUTPED ');

    qryRequis.SQL.Add('INNER JOIN FATGOR ON FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP =  RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV');
    qryRequis.SQL.Add('WHERE MOVDET.DET_SEQGER = "' + strSeqGer + '"');

    qryRequis.Open;

    while not qryRequis.Eof do
    Begin
      TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(qryRequis.FieldByName('FGO_NUMDOC').AsString)
                              .EspDoc(qryRequis.FieldByName('FGO_ESPDOC').AsString)
                              .CodEmp(qryRequis.FieldByName('FGO_CODEMP').AsString)
                              .CodCli(qryRequis.FieldByName('FGO_CODCLI').AsString)).pExecute();
      qryRequis.Next;
    End;
  Finally
    FreeAndNil(qryRequis);
  End;
End;


class procedure TDefineBaixaPedido.ProcessaStatusPedidoRequisicaoConferencia(
  strSeqGer: String);
var
  qryRequis: TUniQuery;
begin
  If Not fCfgSis('EXISTA', varBoolean) Then
    Exit;
  qryRequis := fCriaQuery;
  Try
    qryRequis.SQL.Clear;

    qryRequis.SQL.Add('SELECT DISTINCT FATGOR.FGO_NUMDOC, FATGOR.FGO_ESPDOC, FATGOR.FGO_CODEMP, FATGOR.FGO_CODCLI');
    qryRequis.SQL.Add(' FROM GERELE');
    qryRequis.SQL.Add('INNER JOIN DEFBAI ON  DEF_GERELE = GERELE.AUTOINCREM');
    qryRequis.SQL.Add('INNER JOIN PCMDET ON PCMDET.AUTOINCREM = DEF_AUTPCD');
    qryRequis.SQL.Add('INNER JOIN MOVRCD ON MOVRCD.RCD_SEQPCD = PCMDET.AUTOINCREM');
    qryRequis.SQL.Add('INNER JOIN FATGOR ON FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP =  RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV');
    qryRequis.SQL.Add('WHERE GERELE.AUTOINCREM = "' + strSeqGer + '";');

    qryRequis.Open;

    while not qryRequis.Eof do
    Begin
      TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(qryRequis.FieldByName('FGO_NUMDOC').AsString)
                              .EspDoc(qryRequis.FieldByName('FGO_ESPDOC').AsString)
                              .CodEmp(qryRequis.FieldByName('FGO_CODEMP').AsString)
                              .CodCli(qryRequis.FieldByName('FGO_CODCLI').AsString)).pExecute();
      qryRequis.Next;
    End;
  Finally
    FreeAndNil(qryRequis);
  End;

end;

Function TDefineBaixaPedido.fPreparaTERequisicao: Boolean;
  Var
    qryRequis: TUniQuery;
    strNumLot,
    strSQL: String;
    fltQtdPed: Double;
    stlListaReq: TStringList;
Begin
  stlListaReq := TStringList.Create;

  cdsSaldoRequisicao.EmptyDataSet;

  strSQL := '';
  strSQL := strSQL + ' SELECT        ';
  strSQL := strSQL + '   M.*,        ';

  strSQL := strSQL + '   IFNULL(FGO_ENT_CD, "N") AS FGO_ENT_CD, ';

  strSQL := strSQL + '   (SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM) AS BAIREQ ';

  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   MOVRCD M    ';

  strSQL := strSQL + ' INNER JOIN MOVRCG   ON   RCG_CODEMP = RCD_CODEMP AND RCG_CODIGO = RCD_CODIGO ';

  strSQL := strSQL + ' LEFT  JOIN FATGOR   ON FGO_NUMDOC = RCD_DOCPDV AND FGO_ESPDOC = RCD_ESPPDV AND FGO_CODEMP = RCD_EMPPDV ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   RCD_SEQPCD = :AUTPCD ';

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   RCG_DTACAD ';

  qryRequis := fCriaQuery;
  qryRequis.SQL.Text := strSQL;

  First;

  While Not Eof Do
  Begin
    // BUSCA AS REQUISIÇÕES LIGADAS COM O ITEM DO PEDIDO
    qryRequis.Close;
    qryRequis.ParamByName('AUTPCD').AsString := FieldByName('BAI_AUTPED').AsString;
    qryRequis.Open;

    fltQtdPed := FieldByName('BAI_QTDPED').AsFloat;

    While (Not qryRequis.Eof) And (fltQtdPed > 0) Do
    Begin

      If Not cdsSaldoRequisicao.FindKey([qryRequis.FieldByName('AUTOINCREM').AsString]) Then
      Begin
        cdsSaldoRequisicao.Insert;
        cdsSaldoRequisicao.FieldByName('AUTINC').AsString := qryRequis.FieldByName('AUTOINCREM').AsString;
        cdsSaldoRequisicao.FieldByName('QTDTOT').AsFloat  := qryRequis.FieldByName('RCD_QTDITE').AsFloat;
        cdsSaldoRequisicao.FieldByName('QTDRES').AsFloat  := qryRequis.FieldByName('RCD_QTDITE').AsFloat - qryRequis.FieldByName('BAIREQ').AsFloat;
        cdsSaldoRequisicao.Post;
      End;

      If (cdsSaldoRequisicao.FieldByName('QTDRES').AsFloat > 0) And (fltQtdPed > 0) Then
      Begin
        stlListaReq.Clear;

        cdsBaiReq.Insert;

        cdsBaiReq.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BAIREQ', VS_strCodEmp);
        cdsBaiReq.FieldByName('BAI_AUTDET').AsString := FieldByName('BAI_AUTDET').AsString;
        cdsBaiReq.FieldByName('BAI_AUTPED').AsString := FieldByName('BAI_AUTPED').AsString;
        cdsBaiReq.FieldByName('BAI_AUTREQ').AsString := cdsSaldoRequisicao.FieldByName('AUTINC').AsString;

        If fltQtdPed >= cdsSaldoRequisicao.FieldByName('QTDRES').AsFloat Then
        Begin
          cdsBaiReq.FieldByName('BAI_QTDREQ').AsFloat := cdsSaldoRequisicao.FieldByName('QTDRES').AsFloat;

          fltQtdPed := fltQtdPed - cdsSaldoRequisicao.FieldByName('QTDRES').AsFloat;
        End Else
        Begin
          cdsBaiReq.FieldByName('BAI_QTDREQ').AsFloat := fltQtdPed;

          fltQtdPed := 0;
        End;

        If (qryRequis.FieldByName('RCD_CODEMP').AsString <> VS_strCodEmp) And
           (qryRequis.FieldByName('FGO_ENT_CD').AsString <> 'S') Then
        Begin
          If objCadLot.fExisteLote(qryRequis.FieldByName('RCD_CODITE').AsString,
                                   qryRequis.FieldByName('RCD_CODEMP').AsString, '', False) Then
            strNumLot := 'A DEFINIR'
          Else
            strNumLot := '';

          stlListaReq.Add(cdsSaldoRequisicao.FieldByName('AUTINC').AsString);

          objPreTE.fSalvaPreparacao(qryRequis.FieldByName('RCD_CODITE').AsString,
                                    strNumLot,
                                    VS_strCodEmp,
                                    qryRequis.FieldByName('RCD_CODEMP').AsString,
                                    cdsBaiReq.FieldByName('BAI_QTDREQ').AsFloat,
                                    False,       {blnAbrirTransacao}
                                    stlListaReq, {stlListaReq}
                                    False        {blnApagarPendentes});

          cdsBaiReq.FieldByName('BAI_AUTPTE').AsString := objPreTE.strAutPreTE;
        End;

        cdsBaiReq.Post;

        cdsSaldoRequisicao.Edit;
        cdsSaldoRequisicao.FieldByName('QTDRES').AsFloat := cdsSaldoRequisicao.FieldByName('QTDRES').AsFloat - cdsBaiReq.FieldByName('BAI_QTDREQ').AsFloat;
        cdsSaldoRequisicao.Post;
      End;

      ReprocessarItem(qryRequis.FieldByName('RCD_CODITE').AsString, '');

      qryRequis.Next;
    End;

    Next;
  End;

  FreeAndNil(qryRequis);
  FreeAndNil(stlListaReq);

  Result := cdsBaiReq.fSalva;
End;

Function TDefineBaixaPedido.fSalva: Boolean;
Begin
  Result := True;

  If (Not fConferenciaDepoisDaEntrada) And (Not blnx922) Then
    Result := fPreparaTERequisicao;

  If Result Then
    Result := Inherited fSalva;
End;

Function TDefineBaixaPedido.fSQLDefineBaixa: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   B.*, ';
  strSQL := strSQL + ' CAST("" AS CHAR(20)) AS AUTDET_ORI ';
  strSQL := strSQL + ' FROM   ';
  strSQL := strSQL + '   BAIPED B ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   FALSE  ';

  Result := strSQL;
End;

Function TDefineBaixaPedido.fIniciaDados: Boolean;
Begin
  qryQuery.SQL.Text := fSQLDefineBaixa;

  Result := fLeDados('TDefineBaixaPedido.fIniciaDados');

  IndexFieldNames := 'BAI_AUTDET';
End;

Procedure TDefineBaixaPedido.pInsereBaixa(strAutDet, strAutPcd: String; fltQtdIte: Double);
Begin
  If fEmptyStr(strAutDet) Then
    Exit;

  If fEmptyStr(strAutPcd) Then
    Exit;

  Insert;
  FieldByName('BAI_AUTDET').AsString := strAutDet;
  FieldByName('AUTDET_ORI').AsString := strAutDet;

  FieldByName('BAI_AUTPED').AsString := strAutPcd;
  FieldByName('BAI_QTDPED').AsFloat  := fltQtdIte;
  Post;
End;

Procedure TDefineBaixaPedido.pAtualizaAutoincrem(strAutTemp, strAutInc: String);
  var strIndexFieldNames: String;
Begin

  Try
    strIndexFieldNames := IndexFieldNames;
    IndexFieldNames := '';

    Filter   := 'AUTDET_ORI = ' + QuotedStr(strAutTemp);
    Filtered := True;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('BAI_AUTDET').AsString := strAutInc;
      Post;
      Next;
    End;

  Finally
    IndexFieldNames := strIndexFieldNames;
    Filtered := False;
  End;

End;

Class function TDefineBaixaPedido.fEstornaPedidoPorDefinicaoDeBaixa(strAutInc: String; blnUsaConferenciaParcial: Boolean; var AstlPedComAux: TStringList): Boolean;
  Var
    qryAutPcg,
    qryDefBai,
    qryPcmdet,
    qryPcmger,
    qryPcmgerAux: TUniQuery;
    blnLibPcm: Boolean;
    strAutPcg,
    strCampoSaldo,
    strForFil: String;
    intDecTpc: Integer;

    Function fSQLUpdatePedido: String;
    Const
      STR_QTDBAI = ' (:QTDBAI / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) ';

      var
        strSQL: String;
    Begin
      strSQL := '';

      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PCMDET P ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PCD_BAIXAD = 0, ';

      strSQL := strSQL + '  PCD_VALFRE = PCD_VALFRE + (@FREUNI:=(PCD_FREBAI / PCD_QTDBAI))* 0, ';
      strSQL := strSQL + '  PCD_DESACE = PCD_DESACE + (@ACEUNI:=(PCD_ACEBAI / PCD_QTDBAI))* 0, ';
      strSQL := strSQL + '  PCD_TOTDAR = PCD_TOTDAR + (@DARUNI:=(PCD_TOTDAR / PCD_QTDBAI))* 0, ';

      If fCfgSis('CNVEMB') <> 'N' Then
        strSQL := strSQL + '  PCD_QTDBAI = IF(PCD_QTDBAI - ' + STR_QTDBAI + ' < 0, 0, PCD_QTDBAI - ' + STR_QTDBAI + '), '
      Else
        strSQL := strSQL + '  PCD_QTDBAI = IF(PCD_QTDBAI - :QTDBAI < 0, 0, PCD_QTDBAI - :QTDBAI), ';

      strSQL := strSQL + '  PCD_QTDENT = PCD_QTDENT - IFNULL(:QTD117, 0), ';
      strSQL := strSQL + '  PCD_QTDFUT = PCD_QTDFUT - IFNULL(:QTD922, 0), ';


      strSQL := strSQL + '  PCD_TOTBAI = (PCD_QTDBAI * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
      strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
      strSQL := strSQL + '                                         )), ';

      strSQL := strSQL + '  PCD_FREBAI = ROUND(@FREUNI * PCD_QTDBAI, 2), ';
      strSQL := strSQL + '  PCD_ACEBAI = ROUND(@ACEUNI * PCD_QTDBAI, 2), ';

      strSQL := strSQL + '  PCD_VALFRE = ROUND(@FREUNI * (PCD_QTDITE - PCD_QTDBAI), 2), ';
      strSQL := strSQL + '  PCD_DESACE = ROUND(@ACEUNI * (PCD_QTDITE - PCD_QTDBAI), 2), ';

      strSQL := strSQL + '  PCD_IPIBAI = PCD_TOTBAI * (PCD_PERIPI / 100), ';
      strSQL := strSQL + '  PCD_SUBBAI = PCD_TOTBAI * (PCD_PERSUB / 100), ';

      strSQL := strSQL + '  PCD_DARBAI = ROUND(@DARUNI * PCD_QTDBAI) ';

      If blnUsaConferenciaParcial Then
      Begin
        If fCfgSis('CNVEMB') <> 'N' Then
          strSQL := strSQL + '  , PCD_QTDCON = IF(PCD_QTDCON + ' + STR_QTDBAI + ' >= PCD_QTDITE, PCD_QTDITE, PCD_QTDCON + ' + STR_QTDBAI + ') '
        Else
          strSQL := strSQL + '  , PCD_QTDCON = IF(PCD_QTDCON + :QTDBAI >= PCD_QTDITE, PCD_QTDITE, PCD_QTDCON + :QTDBAI) ';
      End;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  P.AUTOINCREM = :AUTPCD ';

      Result := strSQL;
    End;

    Function fSQLUpdatePcmger: String;
      var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' UPDATE PCMGER G  ';

      strSQL := strSQL + '   SET ';
      strSQL := strSQL + '     G.PCG_BAIXAD = 0,  ';

      strSQL := strSQL + '     PCG_VALFRE = (SELECT SUM(PCD_VALFRE) FROM PCMDET WHERE PCD_ESPDOC = "PD"         ';
      strSQL := strSQL + '                                                        AND PCD_NUMCTN = 0            ';
      strSQL := strSQL + '                                                        AND PCD_NUMPED = PCG_NUMPED   ';
      strSQL := strSQL + '                                                        AND PCD_CODEMP = PCG_CODEMP), ';

      strSQL := strSQL + '     PCG_DESACE = (SELECT SUM(PCD_DESACE) FROM PCMDET WHERE PCD_ESPDOC = "PD"         ';
      strSQL := strSQL + '                                                        AND PCD_NUMCTN = 0            ';
      strSQL := strSQL + '                                                        AND PCD_NUMPED = PCG_NUMPED   ';
      strSQL := strSQL + '                                                        AND PCD_CODEMP = PCG_CODEMP)  ';

      strSQL := strSQL + '   WHERE ';
      strSQL := strSQL + '     G.AUTOINCREM = :AUTPCG   ';

      Result := strSQL;
    End;

    Function fSQLPcmgerAux: String;
      var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT  ';
      strSQL := strSQL + '  PCG_NUMPED, PCG_CODEMP  ';
      strSQL := strSQL + '   FROM PCMGER ';
      strSQL := strSQL + '  WHERE ';
      strSQL := strSQL + '    AUTOINCREM = :AUTPCG   ';

      Result := strSQL;
    End;

    Function fSQLDefBai: String;
      var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   BAIPED.*, RIGHT(DET_CLAFIS, 3) AS DET_CLAFIS, ';
      strSQL := strSQL + '   CAST(IF((DET_DTAENT IS NULL) AND (DET_FILKAR = 1), "N", "S") AS CHAR(1)) AS ENT_EFETIVADA,   ';
      strSQL := strSQL + '   (SELECT COUNT(1) FROM CADEMP WHERE EMP_FORFIL = DET_CODFOR) AS ENT_FORNECEDOR_FILIAL  ';
      strSQL := strSQL + ' FROM          ';
      strSQL := strSQL + '   BAIPED      ';
      strSQL := strSQL + '   LEFT JOIN MOVDET ON AUTOINCREM = BAI_AUTDET ';
      strSQL := strSQL + ' WHERE BAI_AUTDET = :AUTINC  ';

      Result := strSQL;
    End;

    Function fGetAutGer(strAutPcd: String): String;
    Begin
      With qryAutPcg Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT G.AUTOINCREM FROM PCMGER G');
        SQL.Add('INNER JOIN PCMDET D ON PCD_ESPDOC = PCG_ESPDOC ');
        SQL.Add('                   AND PCD_CODEMP = PCG_CODEMP ');
        SQL.Add('                   AND PCD_NUMPED = PCG_NUMPED ');
        SQL.Add('                   AND PCD_NUMCTN = PCG_NUMCTN ');
        SQL.Add('WHERE D.AUTOINCREM = :AUTPCD');

        ParamByName('AUTPCD').AsString := strAutPcd;

        Open;

        Result := FieldByName('AUTOINCREM').AsString;
      End;
    End;

Begin
  strForFil := fRetForFilialTodos;
  blnLibPcm := fCfgSis('LIBPCM', varBoolean);
  intDecTpc := fCfgSis('DEQTPC', varInteger);

  qryAutPcg := fCriaQuery;

  qryPcmdet := fCriaQuery;
  qryPcmdet.SQL.Text := fSQLUpdatePedido;

  qryPcmGer := fCriaQuery;
  qryPcmGer.SQL.Text := fSQLUpdatePcmGer;

  qryDefBai := fCriaQuery;
  qryDefBai.SQL.Text := fSQLDefBai;

  qryPcmGerAux := fCriaQuery;
  qryPcmGerAux.SQL.Text := fSQLPcmgerAux;

  With qryDefBai Do
  Begin
    ParamByName('AUTINC').AsString := strAutInc;

    Open;

    While Not Eof Do
    Begin
      {Se o documento não estiver efetivado, não deve fazer o estorno.}
      {Na transferência a baixa do pedido de compra é feito no ato da entrada simplifica, necessário relaizar o estorno.}
      If fConferenciaDepoisDaEntrada Then
      Begin
        If (qryDefBai.FieldByName('ENT_EFETIVADA').AsString = 'N') And (qryDefBai.FieldByName('ENT_FORNECEDOR_FILIAL').AsInteger = 0) Then
        Begin
          Next;
          Continue;
        End;
      End;

      qryPcmdet.Close;
      qryPcmdet.ParamByName('AUTPCD').AsString := FieldByName('BAI_AUTPED').AsString;
      qryPcmdet.ParamByName('QTDBAI').AsFloat  := FieldByName('BAI_QTDPED').AsFloat;

      qryPcmdet.ParamByName('QTD117').AsFloat := 0;
      qryPcmdet.ParamByName('QTD922').AsFloat := 0;

      If (qryDefBai.FieldByName('DET_CLAFIS').AsString = '117') Or
         (qryDefBai.FieldByName('DET_CLAFIS').AsString = '116') And (qryDefBai.FieldByName('BAI_QTDPED').AsFloat > 0) Then
        qryPcmdet.ParamByName('QTD117').AsFloat  := qryDefBai.FieldByName('BAI_QTDPED').AsFloat;

      If (qryDefBai.FieldByName('DET_CLAFIS').AsString = '922') And (qryDefBai.FieldByName('BAI_QTDPED').AsFloat > 0) Then
        qryPcmdet.ParamByName('QTD922').AsFloat  := qryDefBai.FieldByName('BAI_QTDPED').AsFloat;

      strAutPcg := fGetAutGer(FieldByName('BAI_AUTPED').AsString);

      strCampoSaldo := fRetCampoAtualizaSaldoPedidoCompra(strAutPcg,
                                                          '',
                                                          '',
                                                          blnLibPcm,
                                                          strForFil);

      pEstornaSaldoItemPedidoCompra(FieldByName('BAI_AUTPED').AsString, strCampoSaldo, intDecTpc);

      qryPcmdet.ExecSQL;

      pAtualizaSaldoItemPedidoCompra(FieldByName('BAI_AUTPED').AsString, strCampoSaldo, intDecTpc);

      qryPcmgerAux.Close;
      qryPcmgerAux.ParamByName('AUTPCG').AsString := strAutPcg;
      qryPcmgerAux.Open;
      If Not qryPcmgerAux.isEmpty Then
      Begin
        AstlPedComAux.Add(qryPcmgerAux.FieldByName('PCG_NUMPED').AsString +
                                  '-' + qryPcmgerAux.FieldByName('PCG_CODEMP').AsString);
      End;

      qryPcmger.Close;
      qryPcmger.ParamByName('AUTPCG').AsString := strAutPcg;
      qryPcmger.ExecSQL;

      Next;
    End;

    Result := Not IsEmpty;
  End;

  FreeAndNil(qryDefBai);
  FreeAndNil(qryPcmdet);
  FreeAndNil(qryPcmger);
End;

Class Function TDefineBaixaPedido.fLiberaPreparacaoTECancelamento(strNumDoc, strSerie, strCodEmp, strCodFor, strEspDoc: String): Boolean;
  Var
    strSQL: String;
    qryPrepTe: TUniQuery;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    objLiberacao : TLiberacao;
Begin
  Result := True;

  Try
    qryPrepTe := fCriaQuery;

    // PROCURA OS ITENS QUE GERARAM PREPARACÃO PARA TE
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   P.*, ';
    strSQL := strSQL + '   RCD_CODIGO, ';
    strSQL := strSQL + '   RCD_CODEMP, ';

    strSQL := strSQL + '   ITE_DESITE ';
    strSQL := strSQL + ' FROM   ';

    strSQL := strSQL + ' MOVDET D ';

    strSQL := strSQL + ' INNER JOIN BAIREQ ON BAI_AUTDET = D.AUTOINCREM ';

    strSQL := strSQL + ' INNER JOIN PREPTE P ON P.AUTOINCREM = BAI_AUTPTE  ';

    strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = PRE_CODITE ';

    strSQL := strSQL + ' LEFT  JOIN MOVRCD R ON R.AUTOINCREM = BAI_AUTREQ ';


    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '       DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND DET_CODFOR = :CODFOR ';
    strSQL := strSQL + '   AND DET_SERIE_ = :SERIE_ ';

    With qryPrepTe Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('SERIE_').AsString := strSerie;

      Open;

      If Not IsEmpty Then
      Begin

        objLiberacao := TLiberacao.Create;
        try
          objLiberacao.objMsgLibera.pAddTexto('Cancelamento de Entrada com Pedido de Transferência por Requisição de Compra', alCentro, teAmbos, '', 107);
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTextoCaption('NOTA DE ENTRADA', strNumDoc + '-' + strEspDoc + '-' + strCodEmp);
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTexto('As preparações para geração de transferência e os pedidos de venda gerados');
          objLiberacao.objMsgLibera.pAddTexto('não serão cancelados.');
          objLiberacao.objMsgLibera.pAddTexto('Novas transferências poderão ser gerados com uma nova entrada.');
          objLiberacao.objMsgLibera.pAddQuebra;

          objTabela := TRegistroMsgLiberaTabela.Create;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'PRODUTO'            , 40 , alEsquerda  , teAutcom);
          objLinha.pAddColuna(''  , 'QUANTIDADE'         , 12 , alDireita   , teAutcom);
          objLinha.pAddColuna(''  , 'EMP.DEST.'          , 10 , alCentro    , teAutcom);
          objLinha.pAddColuna(''  , 'REQUISIÇÃO'         , 10 , alCentro    , teAutcom);
          objLinha.pAddColuna(''  , 'PEDIDO VENDA GERAD' , 22 , alEsquerda  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          While Not Eof Do
          Begin

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('PRODUTO'            , FieldByName('PRE_CODITE').AsString + '-' + FieldByName('ITE_DESITE').AsString                   , 40 , alEsquerda );
            objLinha.pAddColuna('QUANTIDADE'         , FormatFloat('#,##0.00', FieldByName('PRE_QTDITE').AsFloat)                                      , 12 , alDireita  );
            objLinha.pAddColuna('EMP.DEST.'          , FieldByName('PRE_EMPDES').AsString                                                              , 10 , alCentro   );
            objLinha.pAddColuna('REQUISIÇÃO'         , FieldByName('RCD_CODIGO').AsString + '-' + FieldByName('RCD_CODEMP').AsString                   , 10 , alCentro   );
            objLinha.pAddColuna('PEDIDO VENDA GERAD' , fPadR(FieldByName('PRE_NUMDOC').AsString, 12) + '-' + FieldByName('PRE_ESPDOC').AsString + '-'
                                                       + FieldByName('PRE_EMPDOC').AsString                                                            , 22 , alEsquerda );
            objTabela.lstLinhas.Add(objLinha);
            Next;
          End;

          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

          objLiberacao.strDirAce := 'CANNET';
          objLiberacao.strMsgSen := 'Cancelamento de Entrada com Pedido de Transferência por Requisição de Compra';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          Result := objLiberacao.fLibera;
        finally
          FreeAndNil(objLiberacao);
        end;


      End;

    End;

    FreeAndNil(qryPrepTe);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TDefineBaixaPedido.fLiberaPreparacaoTECancelamento');
      Result := False;
    End;
  End;
End;

Class Procedure TDefineBaixaPedido.pGravaDeletadosRequisicao(strNumDoc, strSerie, strCodEmp, strCodFor, strEspDoc, frmName: String);

  Function fSQLBaiReq: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';

    strSQL := strSQL + '   B.* ';

    strSQL := strSQL + ' FROM   ';

    strSQL := strSQL + '   MOVDET D ';

    strSQL := strSQL + ' INNER JOIN BAIREQ B ON BAI_AUTDET = D.AUTOINCREM ';

    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '       DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND DET_CODFOR = :CODFOR ';
    strSQL := strSQL + '   AND DET_SERIE_ = :SERIE_ ';

    Result := strSQL;
  End;

  Function fSQLBaiPed: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';

    strSQL := strSQL + '   B.* ';

    strSQL := strSQL + ' FROM   ';

    strSQL := strSQL + '   MOVDET D ';

    strSQL := strSQL + ' INNER JOIN BAIPED B ON BAI_AUTDET = D.AUTOINCREM ';

    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '       DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND DET_CODFOR = :CODFOR ';
    strSQL := strSQL + '   AND DET_SERIE_ = :SERIE_ ';

    Result := strSQL;
  End;

  Var
    qryBaiReq: TUniQuery;
Begin

  qryBaiReq := fCriaQuery;

  With qryBaiReq Do
  Begin
    SQL.Text := fSQLBaiReq;

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('SERIE_').AsString := strSerie;

    Open;

    While Not Eof Do
    Begin
      fVerificaIntegridade(frmName, 'BAIREQ', qryBaiReq);
      Next;
    End;

    Close;

    SQL.Text := fSQLBaiPed;

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('SERIE_').AsString := strSerie;

    Open;

    While Not Eof Do
    Begin
      fVerificaIntegridade(frmName, 'BAIPED', qryBaiReq);
      Next;
    End;
  End;

  FreeAndNil(qryBaiReq);
End;

end.
