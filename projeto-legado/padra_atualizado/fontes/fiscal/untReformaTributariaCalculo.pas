unit untReformaTributariaCalculo;

interface

uses
  untReformaTributariaTipos;

type
  TRefTribCalculo = class
  private
    class procedure pLog(const AInputAutcom, AInputTrigger, AOutputTrigger: String);
    class function fSintetizarCfops(const arrItens : TArrRefTribItem): String;
  public
    class function fCalcular(const recCabecalho : TRefTribCabecalho; const arrItens : TArrRefTribItem;
                             const blnIgnorarCfgContabil : Boolean = False) : TArrRefTribRetorno;
    class function fRecalcularRefDoItemGravado(const strSeqGer, strReferenciaDevolucao : String) : Boolean;
  end;

implementation

uses
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
  {$ELSE}
    untFuncoesSimples,
  {$ENDIF}
  untFuncoesGenerica,
  Uni, System.JSON, System.SysUtils, System.Classes;

Const
  SQL_REFTRIB_CALCULA = 'CALL pRefTribCalculaImpostosItens( CAST( :CABECALHO AS JSON ), CAST( :ITENS AS JSON ) )';

class function TRefTribCalculo.fCalcular(const recCabecalho : TRefTribCabecalho; const arrItens : TArrRefTribItem;
                                         const blnIgnorarCfgContabil : Boolean = False) : TArrRefTribRetorno;
  Var
    qryCalculo   : TUniQuery;
    jsnCabecalho : TJSONObject;
    jsnItens     : TJSONArray;
    strCfopsDocumento : String;
    strJsonEntrada : String;
    strJsonSaida : String;
    strChaveCabecalho : String;
    arrChaves : TArray<String>;
    arrPreenchido : TArray<Boolean>;
    arrPendentes : TArrRefTribItem;
    arrIdxPendentes : TArray<Integer>;
    arrRetornoBanco : TArrRefTribRetorno;
    recRetorno : TRefTribRetorno;
    intItem : Integer;
    intIdx : Integer;
    intDestino : Integer;
begin
  SetLength(Result, 0);

  If (Not blnIgnorarCfgContabil) And (Not fSomarNovosImpostosDaReformaAoValorContabil) Then
    Exit;

  If (Length(arrItens) = 0) Then
    Exit;

  Try
    strJsonEntrada := '';
    strJsonSaida := '';
    strCfopsDocumento := recCabecalho.strCfopsDocumento;{ -> Sempre a partir do array completo: a regra de brinde olha o documento inteiro,
                                                             e a chamada abaixo pode levar so os itens fora do cache.}
    If fEmptyStr(strCfopsDocumento) Then
      strCfopsDocumento := fSintetizarCfops(arrItens);

    jsnCabecalho := fRefTribJsonCabecalho(recCabecalho, strCfopsDocumento);
    Try
      strChaveCabecalho := VS_strCodEmp + '|' + jsnCabecalho.ToJSON;

      SetLength(Result, Length(arrItens));
      SetLength(arrChaves, Length(arrItens));
      SetLength(arrPreenchido, Length(arrItens));
      SetLength(arrPendentes, 0);
      SetLength(arrIdxPendentes, 0);

      For intItem := Low(arrItens) To High(arrItens) Do
      Begin
        arrChaves[intItem] := TRefTribCache.fChaveItem(strChaveCabecalho, arrItens[intItem]);
        arrPreenchido[intItem] := TRefTribCache.fObter(arrChaves[intItem], recRetorno);
        If arrPreenchido[intItem] Then
        Begin
          Result[intItem] := recRetorno;
          Continue;
        End;
        SetLength(arrPendentes, Length(arrPendentes) + 1);
        arrPendentes[High(arrPendentes)] := arrItens[intItem];
        SetLength(arrIdxPendentes, Length(arrIdxPendentes) + 1);
        arrIdxPendentes[High(arrIdxPendentes)] := intItem;
      End;

      If (Length(arrPendentes) > 0) Then
      Begin
        jsnItens := fRefTribJsonItens(arrPendentes);
        Try
          qryCalculo := fCriaQuery;
          Try
            qryCalculo.SQL.Text := SQL_REFTRIB_CALCULA;
            qryCalculo.ParamByName('CABECALHO').AsString := jsnCabecalho.ToJSON;
            qryCalculo.ParamByName('ITENS').AsString := jsnItens.ToJSON;
            qryCalculo.Open;
            arrRetornoBanco := fRefTribMapearRetorno(qryCalculo);

            If Assigned(qryCalculo.FindField('RET_JSON_ENTRADA')) Then
              strJsonEntrada := qryCalculo.FieldByName('RET_JSON_ENTRADA').AsString;
            If Assigned(qryCalculo.FindField('RET_JSON_SAIDA')) Then
              strJsonSaida := qryCalculo.FieldByName('RET_JSON_SAIDA').AsString;

            TRefTribCalculo.pLog(qryCalculo.ParamByName('CABECALHO').AsString + sLineBreak + qryCalculo.ParamByName('ITENS').AsString, strJsonEntrada, strJsonSaida);
            qryCalculo.Close;
          Finally
            FreeAndNil(qryCalculo);
          End;
        Finally
          FreeAndNil(jsnItens);
        End;

        { RET_POSICAO e 1-based sobre o array enviado, que aqui e o dos pendentes. }
        For recRetorno In arrRetornoBanco Do
        Begin
          intIdx := recRetorno.intPosicao - 1;
          If (intIdx < 0) Or (intIdx > High(arrIdxPendentes)) Then
            Continue;
          intIdx := arrIdxPendentes[intIdx];
          TRefTribCache.pGuardar(arrChaves[intIdx], recRetorno);
          Result[intIdx] := recRetorno;
          arrPreenchido[intIdx] := True;
        End;
      End;
    Finally
      FreeAndNil(jsnCabecalho);
    End;

    { Posicao e id voltam a ser os do chamador; item sem retorno sai da lista,
      como acontecia quando a procedure devolvia menos linhas. }
    intDestino := 0;
    For intItem := Low(arrItens) To High(arrItens) Do
    Begin
      If Not arrPreenchido[intItem] Then
        Continue;
      Result[intDestino] := Result[intItem];
      Result[intDestino].intPosicao := intItem + 1;
      Result[intDestino].strIdItem := arrItens[intItem].strIdItem;
      Inc(intDestino);
    End;
    SetLength(Result, intDestino);
  Except
    On E: Exception Do
    Begin
      TRefTribCalculo.pLog(E.Message, strJsonEntrada, strJsonSaida);
      Raise;
    End;
  End;
end;

{ Grava a MOVREF de um item ja gravado com o mesmo contrato da T_MOVTRI_AI_MOVREF seguida da
  T_MOVICD_AI_MOVREF: le MOVDET/MOVTRI/MOVICD e chama a funcao do banco. Para os casos em que a
  trigger nao calcula (UPDATE do item, retorno de consignacao). Sem referencia informada, a origem
  e resolvida pelo DET_INCDEV, como na trigger. }
class function TRefTribCalculo.fRecalcularRefDoItemGravado(const strSeqGer, strReferenciaDevolucao : String) : Boolean;
  Var
    qryRef : TUniQuery;
    strOrigem : String;
    strReferencia : String;

  function fTexto(const strCampo : String) : String;
  begin
    Result := 'JSON_UNQUOTE(JSON_EXTRACT(X.R, ''$.' + strCampo + '''))';
  end;

  function fNumero(const strCampo, strTipo : String) : String;
  begin
    Result := 'CAST(' + fTexto(strCampo) + ' AS ' + strTipo + ')';
  end;

begin
  If fEmptyStr(strReferenciaDevolucao) Then
  Begin
    strOrigem := 'fRefTrib_ResolveOrigemReferencia(T.DET_INCDEV, D.DET_DOCDEV, D.DET_ESPDEV, D.DET_EMPDEV)';
    strReferencia := 'IF(' + strOrigem + ' IS NULL, NULL, T.DET_INCDEV)';
  End
  Else
  Begin
    strOrigem := '''MOVREF''';
    strReferencia := ':REFDEV';
  End;

  qryRef := fCriaQuery;
  Try
    qryRef.SQL.Text := 'DELETE FROM MOVREF WHERE REF_SEQGER = :SEQGER';
    qryRef.ParamByName('SEQGER').AsString := strSeqGer;
    qryRef.ExecSQL;

    qryRef.SQL.Text :=
      'INSERT INTO MOVREF ( ' +
      '  REF_SEQGER, REF_CODCST, REF_CLATRI, REF_VALOPE, REF_BASCAL, ' +
      '  REF_CBSALR, REF_CBSALQ, REF_CBSVAL, REF_CBSALD, REF_CBSVLD, REF_CBSVLT, REF_CBSALE, ' +
      '  REF_IBSUFR, REF_IBSUFA, REF_IBSUFV, REF_IBSUFD, REF_IBSUVD, REF_IBSUFT, REF_IBSUFE, ' +
      '  REF_IBSMNR, REF_IBSMNA, REF_IBSMNV, REF_IBSMND, REF_IBSMVD, REF_IBSMNT, REF_IBSMNE, ' +
      '  REF_VALIBS, REF_SELCST, REF_SELCLA, REF_SELBAS, REF_SELALQ, REF_SELVAL, ' +
      '  REF_TRIREG, REF_CREPRE, REF_MONOFA, REF_VERTRI ) ' +
      'SELECT X.SEQGER, ' + fTexto('REF_CODCST') + ', ' + fTexto('REF_CLATRI') + ', ' +
      '       CASE WHEN JSON_TYPE(JSON_EXTRACT(X.R, ''$.REF_VALOPE'')) = ''NULL'' THEN NULL ' +
      '            ELSE ' + fNumero('REF_VALOPE', 'DECIMAL(12,2)') + ' END, ' +
      '       ' + fNumero('REF_BASCAL', 'DECIMAL(12,2)') + ', ' +
      '       ' + fNumero('REF_CBSALR', 'DECIMAL(12,4)') + ', ' + fNumero('REF_CBSALQ', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_CBSVAL', 'DECIMAL(12,2)') + ', ' + fNumero('REF_CBSALD', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_CBSVLD', 'DECIMAL(12,2)') + ', ' + fNumero('REF_CBSVLT', 'DECIMAL(12,2)') + ', ' +
      '       ' + fNumero('REF_CBSALE', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_IBSUFR', 'DECIMAL(12,4)') + ', ' + fNumero('REF_IBSUFA', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_IBSUFV', 'DECIMAL(12,2)') + ', ' + fNumero('REF_IBSUFD', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_IBSUVD', 'DECIMAL(12,2)') + ', ' + fNumero('REF_IBSUFT', 'DECIMAL(12,2)') + ', ' +
      '       ' + fNumero('REF_IBSUFE', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_IBSMNR', 'DECIMAL(12,4)') + ', ' + fNumero('REF_IBSMNA', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_IBSMNV', 'DECIMAL(12,2)') + ', ' + fNumero('REF_IBSMND', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_IBSMVD', 'DECIMAL(12,2)') + ', ' + fNumero('REF_IBSMNT', 'DECIMAL(12,2)') + ', ' +
      '       ' + fNumero('REF_IBSMNE', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_VALIBS', 'DECIMAL(12,2)') + ', ' +
      '       ' + fTexto('REF_SELCST') + ', ' + fTexto('REF_SELCLA') + ', ' +
      '       ' + fNumero('REF_SELBAS', 'DECIMAL(12,2)') + ', ' + fNumero('REF_SELALQ', 'DECIMAL(12,4)') + ', ' +
      '       ' + fNumero('REF_SELVAL', 'DECIMAL(12,2)') + ', ' +
      '       ' + fTexto('REF_TRIREG') + ', ' + fTexto('REF_CREPRE') + ', ' +
      '       ' + fTexto('REF_MONOFA') + ', ' + fTexto('REF_VERTRI') + ' ' +
      '  FROM ( SELECT D.AUTOINCREM AS SEQGER, ' +
      '                fRefTrib_CalculaImpostosItem( ' +
      '                  JSON_OBJECT(''tipo_operacao'', D.DET_ORIDOC, ' +
      '                              ''especie_documento'', D.DET_ESPDOC, ' +
      '                              ''tipo_pessoa'', D.DET_TIP_FC, ' +
      '                              ''codigo_pessoa'', CASE WHEN D.DET_TIP_FC = ''F'' THEN D.DET_CODFOR ELSE D.DET_CODCLI END, ' +
      '                              ''venda_presencial'', IFNULL(A.AUX_VENPRE, ''N''), ' +
      '                              ''cidade_entrega'', E.ETC_CIDENT, ' +
      '                              ''cfops_documento'', ( SELECT GROUP_CONCAT(DISTINCT C.DET_CLAFIS ORDER BY C.DET_CLAFIS SEPARATOR ''_'') ' +
      '                                                       FROM MOVDET C WHERE C.DET_SEQGER = D.DET_SEQGER ) ), ' +
      '                  JSON_OBJECT(''id_item'', D.AUTOINCREM, ' +
      '                              ''empresa'', D.DET_CODEMP, ' +
      '                              ''entrega_retira'', G.GER_ENTFAT, ' +
      '                              ''codigo_item'', D.DET_CODITE, ' +
      '                              ''cfop'', D.DET_CLAFIS, ' +
      '                              ''valor_item'', D.DET_TOTITE, ' +
      '                              ''valor_contabil'', D.DET_VLRCON, ' +
      '                              ''desconto'', D.DET_DESESP, ' +
      '                              ''frete'', D.DET_TOTFRE, ' +
      '                              ''despesa_acessoria'', D.DET_DESACE, ' +
      '                              ''valor_icms'', D.DET_VALICM, ' +
      '                              ''valor_pis'', T.DET_VALPIS, ' +
      '                              ''valor_cofins'', T.DET_VALCOF, ' +
      '                              ''valor_fcp'', IFNULL(I.VALFCP, 0), ' +
      '                              ''valor_difal'', IFNULL(I.VALDES, 0), ' +
      '                              ''referencia_devolucao'', ' + strReferencia + ', ' +
      '                              ''origem_referencia'', ' + strOrigem + ' ) ) AS R ' +
      '           FROM MOVDET D ' +
      '          INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ' +
      '          INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ' +
      '           LEFT JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM ' +
      '           LEFT JOIN ENTCLI E ON E.AUTOINCREM = A.AUX_ENTGER ' +
      '           LEFT JOIN ( SELECT ICD_SEQGER, SUM(ICD_VALFCP) AS VALFCP, SUM(ICD_VALDES) AS VALDES ' +
      '                         FROM MOVICD WHERE ICD_SEQGER = :SEQGER GROUP BY ICD_SEQGER ) I ON I.ICD_SEQGER = D.AUTOINCREM ' +
      '          WHERE D.AUTOINCREM = :SEQGER ) X ' +
      ' WHERE ' + fTexto('RET_STATUS') + ' = ''CALCULADO''';
    qryRef.ParamByName('SEQGER').AsString := strSeqGer;
    If Not fEmptyStr(strReferenciaDevolucao) Then
      qryRef.ParamByName('REFDEV').AsString := strReferenciaDevolucao;
    qryRef.ExecSQL;

    Result := (qryRef.RowsAffected > 0);
  Finally
    FreeAndNil(qryRef);
  End;
end;

class procedure TRefTribCalculo.pLog(const AInputAutcom, AInputTrigger, AOutputTrigger: String);
  Var
    qryLog : TUniQuery;
begin
  If (fCfgSis('LOGREF', varString) = 'N') Then
    Exit;
  try
    qryLog := fCriaQuery;
    Try
      qryLog.SQL.Text := ' INSERT INTO LOGREF ( ' +
                         '    REF_DTAHRA, ' +
                         '    REF_CODEMP, ' +
                         '    REF_CODOPE, ' +
                         '    REF_INPUT_AUTCOM, ' +
                         '    REF_INPUT_TRIGGER, ' +
                         '    REF_OUTPUT_TRIGGER  ' +
                         '  ) ' +
                         ' VALUES ( ' +
                         '    :DTAHRA, ' +
                         '    :CODEMP, ' +
                         '    :CODOPE, ' +
                         '    :INPUT_AUTCOM, ' +
                         '    :INPUT_TRIGGER, ' +
                         '    :OUTPUT_TRIGGER ' +
                         ' ) ';
      qryLog.ParamByName('DTAHRA').AsDateTime := fNow();
      qryLog.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryLog.ParamByName('INPUT_AUTCOM').AsString := AInputAutcom;
      qryLog.ParamByName('INPUT_TRIGGER').AsString := AInputTrigger;
      qryLog.ParamByName('OUTPUT_TRIGGER').AsString := AOutputTrigger;
      qryLog.ExecSQL;
    Finally
      FreeAndNil(qryLog);
    End;
  except
    // log é algo secundário, um erro aqui não deve afetar o fluxo da rotina
  end;
end;

class function TRefTribCalculo.fSintetizarCfops(const arrItens: TArrRefTribItem): String;
  Var
    LCfops : TStringList;
    LCount : Integer;
begin
  LCfops := TStringList.Create;
  Try
    Result := '';
    For LCount := Low(arrItens) To High(arrItens) Do
    Begin
      If arrItens[LCount].strCfop.IsEmpty Then
        Continue;
      If LCfops.IndexOf(arrItens[LCount].strCfop) >= 0 Then
        Continue;
      If Result.IsEmpty Then
        Result := arrItens[LCount].strCfop
      Else
        Result := Result + '_' + arrItens[LCount].strCfop;
      LCfops.Add(arrItens[LCount].strCfop);
    End;
  Finally
    FreeAndNil(LCfops);
  End;
end;

end.
