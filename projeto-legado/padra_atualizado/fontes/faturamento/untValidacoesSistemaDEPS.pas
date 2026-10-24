unit untValidacoesSistemaDEPS;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, UniClientDataSet,
{$ENDIF}
  SysUtils, Classes, TypInfo, DB, Uni,Variants, StrUtils;

Type
  TValidacoesSistemaDEPS = class
  private

  public
    class function fRealizarValidacaoSistemaDEPS(strCodCnd: String): String;
    class procedure pGravaLogDeStatusDoSistemaDEPS(strAutoIncremFatGor,
                                                   strStatus: String);
    class function fRetornaStatusNaoLidosDoSistemaDEPSDoVendedor(strVendedorLogado: String): TUniClientDataSet;
    class function fVerificaStatusDoOrcamentoNoSistemaDEPS(strTipoDeVenda: String;
                                                           qryFatGor: TUniQuery;
                                                           strCondicaoPagamento: String): Boolean;
    class function fOrcamentoDeValidacaoSistemaDEPS(qryFatGor: TUniQuery;
                                                    strOpcDoc: String): Boolean;
    class function fRetornaStatusDoOrcamentoNoSistemaDEPS(strAutoIncremFatGor: String): String;
    class function fAtualizaStatusSistemaDEPS(strAutoIncremFatGor,
                                              strStatusDEPS: String): Boolean;
    class procedure pGravaLancamentoSistemaDEPS(strChaveDaDuplicata,
                                                strOperacao: String;
                                                strValorAnterior: String = '');
  end;

implementation

{$IFNDEF LINUX}
Uses untFuncoesSimples;
{$ENDIF}

class function TValidacoesSistemaDEPS.fRealizarValidacaoSistemaDEPS(strCodCnd: String): String;
  Var
    qryCondicao: TUniQuery;
Begin
  Result := 'N';

  If fCfgSis('USADEP') = 'N' Then
    Exit;

  Try
    qryCondicao := fCriarQuery('SELECT CND_USADEP ' +
                               'FROM CADCND       ' +
                               'WHERE CND_CODIGO= ' +
                               strCodCnd.QuotedString);

    qryCondicao.Open;

    If (Not qryCondicao.IsEmpty) Then
      Result := qryCondicao.FieldByName('CND_USADEP').AsString;
  Finally
    If Assigned(qryCondicao) Then
      FreeAndNil(qryCondicao);
  End;

End;

class procedure TValidacoesSistemaDEPS.pGravaLogDeStatusDoSistemaDEPS(strAutoIncremFatGor,
                                                                      strStatus: String);
  Var
    strCancelamento  : String;
Begin
  strCancelamento := 'N';
  If strStatus = 'CANCELAMENTO' Then
    strCancelamento := 'S';

  fExecutaSQL('INSERT INTO STSDEP (' +
              '   DEP_SEQFGO,      ' +
              '   DEP_DTAHRA,      ' +
              '   DEP_STATUS,      ' +
              '   DEP_EXECAN       ' +
              '  ) VALUES (        ' +
              strAutoIncremFatGor.QuotedString + ', ' +
              ' CURRENT_TIMESTAMP, ' +
              strStatus.QuotedString + ', ' +
              strCancelamento.QuotedString + ')');
End;

class function TValidacoesSistemaDEPS.fRetornaStatusNaoLidosDoSistemaDEPSDoVendedor(strVendedorLogado: String): TUniClientDataSet;
  Var
    qryStatusDEPS: TUniQuery;
Begin
  Try
    qryStatusDEPS := fCriarQuery('SELECT F.FGO_NUMDOC, F.FGO_CODCLI, C.CLI_NOMCLI,   ' +
                                 '       D.DEP_STATUS, D.DEP_MOTIVO, D.DEP_USUDEP,   ' +
                                 '       D.DEP_DTASIT, D.DEP_INFCOM, F.FGO_CODEMP,   ' +
                                 '       "D" AS DEP_MARDES, D.DEP_SEQFGO,            ' +
                                 '       D.DEP_CODSTS, D.DEP_DESSTS                  ' +
                                 'FROM STSDEP D                                      ' +
                                 'LEFT JOIN FATGOR F ON F.AUTOINCREM=D.DEP_SEQFGO    ' +
                                 '                  AND F.FGO_CODVEN=' + strVendedorLogado.QuotedString +
                                 'LEFT JOIN CADCLI C ON C.CLI_CODCLI= F.FGO_CODCLI   ' +
                                 'WHERE D.DEP_DTASIT IS NOT NULL                     ' +
                                 '  AND D.DEP_STSLID="N"                             ' +
                                 '  AND F.AUTOINCREM IS NOT NULL                     ' +
                                 'UNION                                              ' +
                                 'SELECT F.FGO_NUMDOC, F.FGO_CODCLI, C.CLI_NOMCLI,   ' +
                                 '       D.DEP_STATUS, D.DEP_MOTIVO, D.DEP_USUDEP,   ' +
                                 '       D.DEP_DTASIT, D.DEP_INFCOM, F.FGO_CODEMP,   ' +
                                 '       "D" AS DEP_MARDES, D.DEP_SEQFGO,            ' +
                                 '       D.DEP_CODSTS, D.DEP_DESSTS                  ' +
                                 'FROM DEL_STSDEP D                                  ' +
                                 'LEFT JOIN FATGOR F ON F.AUTOINCREM=D.DEP_SEQFGO    ' +
                                 '                  AND F.FGO_CODVEN=' + strVendedorLogado.QuotedString +
                                 'LEFT JOIN CADCLI C ON C.CLI_CODCLI= F.FGO_CODCLI   ' +
                                 'WHERE D.DEP_DTASIT IS NOT NULL                     ' +
                                 '  AND D.DEP_STSLID="N"                             ' +
                                 '  AND F.AUTOINCREM IS NOT NULL                     ' +
                                 ' ORDER BY DEP_DTASIT DESC                          ');

    qryStatusDEPS.Open;

    Result := fCriaClientDatset(qryStatusDEPS);
    Result.Open;
  Finally
    FreeAndNil(qryStatusDEPS);
  End;


End;

class function TValidacoesSistemaDEPS.fVerificaStatusDoOrcamentoNoSistemaDEPS(strTipoDeVenda: String;
                                                                              qryFatGor: TUniQuery;
                                                                              strCondicaoPagamento: String): Boolean;
begin
  Result := True;

  If (Not Assigned(qryFatGor)) Or
     (qryFatGor.FindField('FGO_USADEP') = Nil) Or
     (qryFatGor.FieldByName('FGO_USADEP').AsString = 'N') Then
    Exit;

  Result := ((qryFatGor.FieldByName('FGO_USADEP').AsString = 'S') And
             (qryFatGor.FieldByName('FGO_STSDEP').AsString = 'APROVADO')) Or
            (strTipoDeVenda = 'OR');

  If Result Then
    Exit;

  Result := fRealizarValidacaoSistemaDEPS(strCondicaoPagamento) = 'N';
end;

class function TValidacoesSistemaDEPS.fOrcamentoDeValidacaoSistemaDEPS(qryFatGor: TUniQuery;
                                                                       strOpcDoc: String): Boolean;
  Var
    blnPedidoComOrcamentoAprovado: Boolean;
Begin
  If Not Assigned(qryFatGor) Then
    Exit(False);

  blnPedidoComOrcamentoAprovado := (qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                                   (fRetornaStatusDoOrcamentoNoSistemaDEPS(
                                        fCampoTabela('AUTOINCREM', 'FATGOR',
                                                     ['FGO_NUMFAT', 'FGO_CODEMP'],
                                                     [qryFatGor.FieldByName('FGO_NUMDOC').AsString, qryFatGor.FieldByName('FGO_CODEMP').AsString]
                                                    )) = 'APROVADO');

  Result := (MatchStr(strOpcDoc,['VN','PD'])) And
            (((qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'OR') And
              (qryFatGor.FieldByName('FGO_USADEP').AsString = 'S'))  Or
             (blnPedidoComOrcamentoAprovado));
End;

class function TValidacoesSistemaDEPS.fRetornaStatusDoOrcamentoNoSistemaDEPS(strAutoIncremFatGor: String): String;
  Var
    qryExtGor: TUniQuery;
Begin
  Try
    qryExtGor := fCriarQuery('SELECT FGO_STSDEP FROM EXTGOR WHERE FGO_SEQFGO=' + strAutoIncremFatGor.QuotedString);
    qryExtGor.Open;

    Result := qryExtGor.FieldByName('FGO_STSDEP').AsString;
  Finally
    If Assigned(qryExtGor) Then
      FreeAndNil(qryExtGor);
  End;
End;

class function TValidacoesSistemaDEPS.fAtualizaStatusSistemaDEPS(strAutoIncremFatGor,
                                                                 strStatusDEPS: String): Boolean;
Begin
  Try
   {$IFNDEF LINUX}untFuncoesSimples.{$ENDIF}fExecutaSQL('UPDATE EXTGOR SET FGO_STSDEP=' + strStatusDEPS.QuotedString + ' ' +
                                                        'WHERE FGO_SEQFGO=' + strAutoIncremFatGor.QuotedString);

    pGravaLogDeStatusDoSistemaDEPS(strAutoIncremFatGor,
                                   strStatusDEPS);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao alterar o status do Sistema DEPS do Orçamento.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
End;

class procedure TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(strChaveDaDuplicata,
                                                                   strOperacao: String;
                                                                   strValorAnterior: String = '');
  Var
    stlChaveDuplicata: TStringList;
Begin
  stlChaveDuplicata := TStringList.Create;

  stlChaveDuplicata.Delimiter     := '-';
  stlChaveDuplicata.DelimitedText := strChaveDaDuplicata;

  {$IFNDEF LINUX}untFuncoesSimples.{$ENDIF}
                    fExecutaSQL('INSERT INTO REGDEP (    ' +
                                '   DEP_NUMDUP,          ' +
                                '   DEP_PARCEL,          ' +
                                '   DEP_ESPDOC,          ' +
                                '   DEP_CODEMP,          ' +
                                '   DEP_CODCLI,          ' +
                                '   DEP_SEQBAI,          ' +
                                '   DEP_DTAHRA,          ' +
                                '   DEP_OPERAC,          ' +
                                '   DEP_VALANT,          ' +
                                '   AUTOINCREM           ' +
                                '   ) VALUES (           ' +
                                stlChaveDuplicata[0].QuotedString + ',' +
                                stlChaveDuplicata[1].QuotedString + ',' +
                                stlChaveDuplicata[2].QuotedString + ',' +
                                stlChaveDuplicata[3].QuotedString + ',' +
                                stlChaveDuplicata[4].QuotedString + ',' +
                                stlChaveDuplicata[5] + ',' +
                                '   CURRENT_TIMESTAMP,   ' +
                                '"' + strOperacao +   '",' +
                                IIF(strValorAnterior.IsEmpty,
                                    ' NULL, ',
                                    '"' + strValorAnterior + '",') +
                                '"' + fRetAutoIncrem('REGDEP', VS_strCodEmp) + '")    ');

  FreeAndNil(stlChaveDuplicata);
End;

end.
