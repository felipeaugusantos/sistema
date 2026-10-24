unit untFuncoesComodatoCilindroVasilhame;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Uni, untFuncoesSimples,
  untLiberacao, untFuncoes;

function fExisteCilindroVasilhameFaturamento(const strAutInc: String): Boolean; overload;
function fExisteCilindroVasilhameFaturamento(const lstPedidos: TStrings): Boolean; overload;
function fTodosOsFaturamentosIguais(const lstPedidos: TStrings): Boolean;
function fExistePedidoNormalComCilindroVasilhameNaoFaturado(
  const lstPedidos: TStrings): Boolean; overload;
function fExistePedidoNormalComCilindroVasilhameNaoFaturado(
  const strAutInc: String): Boolean; overload;
function fExistePedidoNormalComCilindroVasilhameNaoFaturado(
  const strNumDoc, strEspDoc: String): Boolean; overload;
function fPermiteCancelarDocumentoVinculadoComodatoCilindroVasilhame(
  const strNumDoc, strEspDoc, strCodCli: String): Boolean;
function fRetornaClasssificacaoFiscalComodatoCilindroVasilhame(
  const strNumDoc, strEspDoc: String): String;
function fEhComodatoCilindroVasilhame(const strNumDoc,
  strEspDoc: String): Boolean;


implementation

function fExisteCilindroVasilhameFaturamento(const strAutInc: String): Boolean;
var
  sltPedido : TStrings;
begin
  sltPedido := TStringList.Create;
  Try
    sltPedido.Add(strAutInc);

    Result := fExisteCilindroVasilhameFaturamento(sltPedido);
  Finally
    FreeAndNil(sltPedido);
  End;
end;

function fExisteCilindroVasilhameFaturamento(const lstPedidos: TStrings): Boolean;
var
  qryFaturamento : TUniQuery;
  strPedidos     : String;
  intContador    : Integer;
begin
  If Not fCfgSis('CDTCLV', varBoolean) Then
    Exit(False);

  qryFaturamento := fCriaQuery();
  Try
    strPedidos := EmptyStr;
    For intContador := 0 To Pred(lstPedidos.Count) Do
    Begin
      If Not fEmptyStr(strPedidos) Then
        strPedidos := strPedidos
                    + ',';

      strPedidos := strPedidos
                  + fColocaAspas(lstPedidos.Strings[intContador]);
    End;

    qryFaturamento.SQL.Text := 'SELECT '
                             + '       E.FGO_CILVAS '
                             + '  FROM FATGOR G '
                             + ' INNER JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM '
                             + ' WHERE G.AUTOINCREM IN ('+strPedidos+') ';
    qryFaturamento.Open;

    qryFaturamento.First;
    Result := qryFaturamento.Locate('FGO_CILVAS','S',[]);
  Finally
    FreeAndNil(qryFaturamento);
  End;
end;

function fTodosOsFaturamentosIguais(const lstPedidos: TStrings): Boolean;
var
  qryFaturamento        : TUniQuery;
  strPedidos            : String;
  intContador           : Integer;
  strPedidosComodato    : String;
  strPedidosSemComodato : String;
  strMensagem           : String;
begin
  If Not fCfgSis('CDTCLV', varBoolean) Then
    Exit(True);

  qryFaturamento := fCriaQuery();
  Try
    Result := True;

    strMensagem           := EmptyStr;
    strPedidos            := EmptyStr;
    strPedidosComodato    := EmptyStr;
    strPedidosSemComodato := EmptyStr;

    For intContador := 0 To Pred(lstPedidos.Count) Do
    Begin
      If Not fEmptyStr(strPedidos) Then
        strPedidos := strPedidos
                    + ',';

      strPedidos := strPedidos
                  + fColocaAspas(lstPedidos.Strings[intContador]);
    End;

    qryFaturamento.SQL.Text := 'SELECT '
                             + '       G.FGO_NUMDOC '
                             + '     , G.FGO_ESPDOC '
                             + '     , G.FGO_CODEMP '
                             + '     , E.FGO_CILVAS '
                             + '  FROM FATGOR G '
                             + ' INNER JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM '
                             + ' WHERE G.AUTOINCREM IN ('+strPedidos+') ';
    qryFaturamento.Open;

    qryFaturamento.First;
    While Not qryFaturamento.Eof Do
    Begin
      If (qryFaturamento.FieldByName('FGO_CILVAS').AsString = 'S') Then
      Begin
        If Not fEmptyStr(strPedidosComodato) Then
          strPedidosComodato := strPedidosComodato
                                 + ', ';

        strPedidosComodato := strPedidosComodato
                               + qryFaturamento.FieldByName('FGO_NUMDOC').AsString
                               + '-'
                               + qryFaturamento.FieldByName('FGO_ESPDOC').AsString
                               + '-'
                               + qryFaturamento.FieldByName('FGO_CODEMP').AsString;
      End
      Else
      Begin
        If Not fEmptyStr(strPedidosSemComodato) Then
          strPedidosSemComodato := strPedidosSemComodato
                                 + ', ';

        strPedidosSemComodato := strPedidosSemComodato
                               + qryFaturamento.FieldByName('FGO_NUMDOC').AsString
                               + '-'
                               + qryFaturamento.FieldByName('FGO_ESPDOC').AsString
                               + '-'
                               + qryFaturamento.FieldByName('FGO_CODEMP').AsString;
      End;

      qryFaturamento.Next;
    End;

    qryFaturamento.First;
    Result := Not (qryFaturamento.Locate('FGO_CILVAS','S', []) And
                   qryFaturamento.Locate('FGO_CILVAS','N', []));

    If Not Result Then
    Begin
      strMensagem := strMensagem
                   + #13#10
                   + '  Pedido(s) comodato: '+strPedidosComodato
                   + #13#10
                   + '  Pedido(s) que não é(são) comodato: '+strPedidosSemComodato;

      fMensagem('ATENÇÃO!', 'Atenção! Não é permitido faturar um pedido de comodato de cilidro e vasilhame com um que não é.'+#13#10+
                            strMensagem, ['&Ok']);
    End;
  Finally
    FreeAndNil(qryFaturamento);
  End;
end;

function fExistePedidoNormalComCilindroVasilhameNaoFaturado(
  const lstPedidos: TStrings): Boolean;
var
  qryFaturamento : TUniQuery;
  strPedidos     : String;
  intContador    : Integer;
  strMensagem    : String;
  sltMensagem    : TStrings;
  objLiberacao   : TLiberacao;
begin
  If Not fCfgSis('CDTCLV', varBoolean) Then
    Exit(False);

  sltMensagem := TStringList.Create;
  qryFaturamento := fCriaQuery();
  Try
    Result     := False;
    strPedidos := EmptyStr;

    For intContador := 0 To Pred(lstPedidos.Count) Do
    Begin
      If Not fEmptyStr(strPedidos) Then
        strPedidos := strPedidos
                    + ',';

      strPedidos := strPedidos
                  + fColocaAspas(lstPedidos.Strings[intContador]);
    End;

    qryFaturamento.SQL.Text := 'SELECT '
                             + '       G.FGO_NUMDOC AS NUMDOC '
                             + '     , G.FGO_ESPDOC AS ESPDOC '
                             + '     , G.FGO_CODEMP AS CODEMP '
                             + '     , E.FGO_CILVAS AS CILVAS '
                             + '     , F.FGO_NUMDOC AS NUMCDT '
                             + '     , F.FGO_ESPDOC AS ESPCDT '
                             + '     , F.FGO_CODEMP AS EMPCDT '
                             + '     , F.FGO_JAFATU AS JAFCDT '
                             + '  FROM FATGOR G '
                             + '  LEFT JOIN EXTGOR E ON E.FGO_AUTICV = G.AUTOINCREM '
                             + '  LEFT JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO '
                             + ' WHERE G.AUTOINCREM IN ('+strPedidos+') ';
    qryFaturamento.Open;

    qryFaturamento.First;
    While Not qryFaturamento.Eof Do
    Begin
      If (qryFaturamento.FieldByName('CILVAS').AsString = 'S') And
         (qryFaturamento.FieldByName('JAFCDT').AsInteger = 0) Then
      Begin
        sltMensagem.Add(EmptyStr);

        sltMensagem.Add('Pedido(s) comodato: '
                       + qryFaturamento.FieldByName('NUMCDT').AsString
                       + '-'
                       + qryFaturamento.FieldByName('ESPCDT').AsString
                       + '-'
                       + qryFaturamento.FieldByName('EMPCDT').AsString);

        sltMensagem.Add('Pedido(s) que não é(são) comodato: '
                       + qryFaturamento.FieldByName('NUMDOC').AsString
                       + '-'
                       + qryFaturamento.FieldByName('ESPDOC').AsString
                       + '-'
                       + qryFaturamento.FieldByName('CODEMP').AsString);
      End;

      qryFaturamento.Next;
    End;

    Result := sltMensagem.Count > 0;

    If Result Then
    Begin
      Try
        objLiberacao := TLiberacao.Create;
        objLiberacao.objMsgLibera.pAddTexto('Permitir faturar pedido que tem vínculo com pedido comodato de cilindros e vasilhames sem que este esteja faturado.');
        objLiberacao.objMsgLibera.pAddTexto('Antes de prosseguir ou solicitar a liberação, verifique se o pedido de comodato não deve ser faturado primeiro.');

        For strMensagem in sltMensagem Do
          objLiberacao.objMsgLibera.pAddTexto(strMensagem);

        objLiberacao.strDirAce := 'FATCDTCILVAS';
        objLiberacao.strMsgSen := 'Expedição de pedido com vinculação a comodato de cilindros e vasilhames';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        Result := (Not objLiberacao.fLibera);
      Finally
        FreeAndNil(objLiberacao);
      End;
    End;
  Finally
    FreeAndNil(sltMensagem);
    FreeAndNil(qryFaturamento);
  End;
End;

function fExistePedidoNormalComCilindroVasilhameNaoFaturado(
  const strAutInc: String): Boolean;
var
  sltPedido : TStrings;
begin
  Try
    sltPedido := TStringList.Create;
    sltPedido.Add(strAutInc);

    Result := fExistePedidoNormalComCilindroVasilhameNaoFaturado(sltPedido);
  Finally
    FreeAndNil(sltPedido);
  End;
end;

function fPermiteCancelarDocumentoVinculadoComodatoCilindroVasilhame(
  const strNumDoc, strEspDoc, strCodCli: String): Boolean;
var
  strSql       : String;
  qryConsulta  : TUniQuery;
  strMensagem  : String;
  strDocumento : String;
begin
  If Not fCfgSis('CDTCLV', varBoolean) Then
    Exit(True);

  strDocumento := EmptyStr;
  If (Pos(strEspDoc, 'FF_NF_IF_') > 0) Then
  Begin
    If (Pos(strEspDoc, 'FF_') > 0) Then
      strMensagem := ' faturamento futuro '
    Else
      strMensagem := ' nota ';

    strSql := 'SELECT '
            + '       A.AUX_CILVAS AS GER_CILVAS '
            + '     , V.GER_NUMDOC '
            + '     , V.GER_ESPDOC '
            + '     , V.GER_CODEMP '
            + '     , X.AUX_CILVAS AS CDT_CILVAS '
            + '     , R.GER_NUMDOC AS MOV_NUMDOC '
            + '     , R.GER_ESPDOC AS MOV_ESPDOC '
            + '     , R.GER_CODEMP AS MOV_CODEMP '
            + '     , U.AUX_CILVAS AS MOV_CILVAS '
            + '  FROM MOVGER G '
            + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '
            + '  LEFT JOIN AUXMOV X ON X.AUX_AUTICV = G.AUTOINCREM '
            + '  LEFT JOIN MOVGER V ON V.AUTOINCREM = X.AUX_SEQGER '
            + '  LEFT JOIN MOVGER R ON R.AUTOINCREM = A.AUX_AUTICV '
            + '  LEFT JOIN AUXMOV U ON U.AUX_SEQGER = R.AUTOINCREM '
            + ' WHERE G.GER_NUMDOC = :NUMDOC '
            + '   AND G.GER_ESPDOC = :ESPDOC '
            + '   AND G.GER_CODEMP = :CODEMP '
            + '   AND G.GER_CODCLI = :CODCLI ';
  End
  Else
  If strEspDoc= 'PD' Then
  Begin
    strMensagem := ' pedido ';

    strSql := 'SELECT '
            + '       A.FGO_CILVAS AS GER_CILVAS '
            + '     , V.FGO_NUMDOC AS GER_NUMDOC '
            + '     , V.FGO_ESPDOC AS GER_ESPDOC '
            + '     , V.FGO_CODEMP AS GER_CODEMP '
            + '     , X.FGO_CILVAS AS CDT_CILVAS '
            + '     , R.FGO_NUMDOC AS MOV_NUMDOC '
            + '     , R.FGO_ESPDOC AS MOV_ESPDOC '
            + '     , R.FGO_CODEMP AS MOV_CODEMP '
            + '     , U.FGO_CILVAS AS MOV_CILVAS '
            + '  FROM FATGOR G '
            + ' INNER JOIN EXTGOR A ON A.FGO_SEQFGO = G.AUTOINCREM '
            + '  LEFT JOIN EXTGOR X ON X.FGO_AUTICV = G.AUTOINCREM '
            + '  LEFT JOIN FATGOR V ON V.AUTOINCREM = X.FGO_SEQFGO '
            + '  LEFT JOIN FATGOR R ON R.AUTOINCREM = A.FGO_AUTICV '
            + '  LEFT JOIN EXTGOR U ON U.FGO_SEQFGO = R.AUTOINCREM '
            + ' WHERE G.FGO_NUMDOC = :NUMDOC '
            + '   AND G.FGO_ESPDOC = :ESPDOC '
            + '   AND G.FGO_CODEMP = :CODEMP '
            + '   AND G.FGO_CODCLI = :CODCLI ';
  End
  Else
    Exit(True);

  qryConsulta := fCriaQuery();
  Try
    Result := True;

    qryConsulta.SQL.Text := strSql;
    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
    qryConsulta.Open;

    If qryConsulta.RecordCount > 0 Then
    Begin
      If qryConsulta.FieldByName('GER_CILVAS').AsString = 'S' Then
      Begin
        strDocumento := qryConsulta.FieldByName('MOV_NUMDOC').AsString
                      + qryConsulta.FieldByName('MOV_ESPDOC').AsString
                      + qryConsulta.FieldByName('MOV_CODEMP').AsString;
      End
      Else
      If (qryConsulta.FieldByName('GER_CILVAS').AsString <> 'S') And
         (qryConsulta.FieldByName('CDT_CILVAS').AsString = 'S') Then
      Begin
        strDocumento := qryConsulta.FieldByName('GER_NUMDOC').AsString
                      + qryConsulta.FieldByName('GER_ESPDOC').AsString
                      + qryConsulta.FieldByName('GER_CODEMP').AsString;
      End;

      If Not fEmptyStr(strDocumento) Then
      Begin
        Insert('-', strDocumento, 13);
        Insert('-', strDocumento, 16);

        Result := fMensagem('Atenção', 'Este documento possui um(a) outro(a)'+ strMensagem +
                                       'de cilindro/vasilhame vinculado a ele. '+
                                       Copy(Trim(strMensagem),1,1).toUpper + Copy(Trim(strMensagem), 2, strMensagem.Length)+
                                       ': '+ strDocumento +'. Verifique com o responsável se ele também deve ser cancelado.'+#13#10+
                                       'Continuar com o cancelamento do documento?',
                            ['&Sim', '&Não']) = 1;
      End;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function fRetornaClasssificacaoFiscalComodatoCilindroVasilhame(
  const strNumDoc, strEspDoc: String): String;
var
  strSql      : String;
  qryConsulta : TUniQuery;
begin
  If Not fCfgSis('CDTCLV', varBoolean) Then
    Exit(EmptyStr);

  If (Pos(strEspDoc, 'FF_NF_IF_') > 0) Then
  Begin
    strSql := 'SELECT '
            + '       D.DET_CLAFIS AS CLAFIS '
            + '  FROM MOVGER G '
            + ' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM '
            + ' INNER JOIN AUXMOV X ON X.AUX_SEQGER = G.AUTOINCREM '
            + ' WHERE G.GER_NUMDOC = :NUMDOC '
            + '   AND G.GER_ESPDOC = :ESPDOC '
            + '   AND G.GER_CODEMP = :CODEMP '
            + '   AND X.AUX_CILVAS = "S" ';
  End
  Else
  If strEspDoc= 'PD' Then
  Begin
    strSql := 'SELECT '
            + '       D.FDO_CLAFIS AS CLAFIS '
            + '  FROM FATGOR G '
            + ' INNER JOIN FATDOR D ON D.FDO_SEQGER = G.AUTOINCREM '
            + ' INNER JOIN EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM '
            + ' WHERE G.FGO_NUMDOC = :NUMDOC '
            + '   AND G.FGO_ESPDOC = :ESPDOC '
            + '   AND G.FGO_CODEMP = :CODEMP '
            + '   AND X.FGO_CILVAS = "S" ';
  End
  Else
    Exit(EmptyStr);

  qryConsulta := fCriaQuery();
  Try
    qryConsulta.SQL.Text := strSql;
    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.Open;

    If qryConsulta.RecordCount > 0 Then
      Result := qryConsulta.FieldByName('CLAFIS').AsString
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function fEhComodatoCilindroVasilhame(const strNumDoc,
  strEspDoc: String): Boolean;
begin
  Result := Not fEmptyStr(fRetornaClasssificacaoFiscalComodatoCilindroVasilhame(strNumDoc, strEspDoc));
end;

function fExistePedidoNormalComCilindroVasilhameNaoFaturado(
  const strNumDoc, strEspDoc: String): Boolean; overload;
var
  qryConsulta : TUniQuery;
begin
  If Not fCfgSis('CDTCLV', varBoolean) Then
    Exit(False);

  qryConsulta := fCriaQuery();
  Try
    qryConsulta.SQL.Text := 'SELECT '
                          + '       AUTOINCREM '
                          + '  FROM FATGOR '
                          + ' WHERE FGO_NUMDOC = :NUMDOC '
                          + '   AND FGO_ESPDOC = :ESPDOC '
                          + '   AND FGO_CODEMP = :CODEMP ';

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.Open;

    Result := fExistePedidoNormalComCilindroVasilhameNaoFaturado(qryConsulta.FieldByName('AUTOINCREM').AsString);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

end.
