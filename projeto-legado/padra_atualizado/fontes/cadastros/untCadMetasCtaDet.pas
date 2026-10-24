unit untCadMetasCtaDet;

interface

Uses
  Classes, SysUtils, Controls, DB, MaskUtils,
  untFuncoesSimples, untZClient, Uni, Forms, System.Variants;

Type
  TCadMetasCtaDet = Class(TZClient)
  Private

    Function fSQLMetas: String;

  Public

    constructor Create(Owner: TComponent); Reintroduce; Overload;
    Destructor Destroy; override;

    Function fCarregaMetas(strAutInc: String): Boolean;
    Function fIncluiMeta(strCodCta, strCodOpe: String; fltValor: Double; strCodEve: String): Boolean;
    Function fExcluiMeta: Boolean;
    Function fSalvaMetas(strAutInc: String): Boolean;
    Function fTemMeta(strCodCta: String; strCodEve: String): Boolean;

    Function fHeranca(frmForm: TForm; Var strCodEmp: String): Boolean;
    Function fValidaConta(strCodEmp, strCodCta, strAutInc: String; dtaDtaIni, dtaDtaFin: TDatetime; blnTodasEmpresas: boolean; strCodEve: String): Boolean;
    Function fValidaContaPeriodo(strCodEmp, strCodCta, strAutInc: String; dtaDtaIni, dtaDtaFin: TDatetime; blnTodasEmpresas: Boolean; strCodEve: String): Boolean;

    Function fValidaContasPeriodo(strCodEmp, strAutInc: String; dtaDtaIni, dtaDtaFin: TDatetime; blnTodasEmpresas: boolean): Boolean;
  End;

implementation

Uses
  StrUtils,
  untConsultas, untTypesSistema;

constructor TCadMetasCtaDet.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLMetas);
End;

Function TCadMetasCtaDet.fSQLMetas: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   M.*, ';
  Result := Result + '  (SELECT C.CTA_DESCTA FROM CADCTA C WHERE C.CTA_CODCTA = M.MCP_CODCTA) AS MCP_DESCTA, ';
  Result := Result + '  (SELECT E.EVE_DESEVE FROM CADEVE E WHERE E.EVE_CODEVE = M.MCP_CODEVE) AS MCP_DESEVE  ';
  Result := Result + ' FROM MCPDET M         ';
  Result := Result + ' WHERE ';
  Result := Result + '   M.MCP_SEQGER = :AUTINC ';
End;

Function TCadMetasCtaDet.fCarregaMetas(strAutInc: String): Boolean;
Begin
  Try
    With qryQuery Do
    Begin
      ParamByName('AUTINC').AsString := strAutInc;

      Result := fAbreClient(True, 'TCadMetasCtaDet.fCarregaMetas');

    End;

    FieldByName('MCP_DESCTA').ProviderFlags := [];
    TStringField(FieldByName('MCP_CODCTA')).EditMask := '99.99.999;0;_';

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadMetasCtaDet.fCarregaMetas]');
    End;
  End;
End;

Function TCadMetasCtaDet.fIncluiMeta(strCodCta, strCodOpe: String;
  fltValor: Double; strCodEve: String): Boolean;
Begin
  Try
    If fEmptyStr(strCodCta) Then
    Begin
      Result := False;
      pMensagemOk('Código do Plano de Contas em branco!');
    End
    Else
    Begin
      If fTemMeta(strCodCta, strCodEve) Then
        Edit
      Else
        Append;

      FieldByName('MCP_CODCTA').AsString := strCodCta;
      FieldByName('MCP_CODOPE').AsString := strCodOpe;
      FieldByName('MCP_DESCTA').AsString := fRetNomeConta(strCodCta);
      FieldByName('MCP_VALMET').AsFloat  := fltValor;
      If fEmptyStr(strCodEve) Then
        FieldByName('MCP_DESEVE').Value := Null
      Else
      Begin
        FieldByName('MCP_DESEVE').AsString := fRetNomEvento(strCodCta);
        FieldByName('MCP_CODEVE').AsString := strCodEve;
      End;


      Post;

      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadMetasCtaDet.fIncluiMeta]');
    End;
  End;
End;

Function TCadMetasCtaDet.fExcluiMeta: Boolean;
Begin
  Try

    If Not IsEmpty then
      Delete;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadMetasCtaDet.fExcluiMeta]');
    End;
  End;
End;

Function TCadMetasCtaDet.fSalvaMetas(strAutInc: String): Boolean;
Begin
  Try
    DisableControls;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('MCP_SEQGER').AsString := strAutInc;
      Post;

      Next;
    End;

    Result := fSalva;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadMetasCtaDet.fSalvaMetas]');
    End;
  End;

  EnableControls;
End;

Destructor TCadMetasCtaDet.Destroy;
Begin
  Inherited;

End;

Function TCadMetasCtaDet.fTemMeta(strCodCta: String; strCodEve: String): Boolean;
Begin
  If (fCfgSis('METPED', varString) = '5') Or (fCfgSis('METPED', varString) = '6') Then
    Result:= Locate('MCP_CODEVE;MCP_CODCTA', VarArrayOf([strCodEve, strCodCta]), [])
  Else
    Result := Locate('MCP_CODCTA', strCodCta, []);
End;

Function TCadMetasCtaDet.fHeranca(frmForm: TForm; Var strCodEmp: String): Boolean;
Var
  qryCtpdet: TUniQuery;
  qryTabela: TUniQuery;
  arrMetas: TConsultasArray;
  chrKey: Char;
Begin
  chrKey := '/';
  qryTabela := fCriaQuery;

  Result := False;

  If fPesqMetasCentroCustoPedidoCompra(frmForm, qryTabela, chrKey, arrMetas) then
  Begin
    strCodEmp := qryTabela.FieldByName('MCP_CODEMP').AsString;

    Result := fCarregaMetas('');

    If Result Then
    Begin
      qryCtpdet := fCriaQuery;
      qryCtpdet.SQL.Text := fSQLMetas;
      qryCtpdet.ParamByName('AUTINC').AsString :=
        qryTabela.FieldByName('AUTOINCREM').AsString;
      qryCtpdet.Open;

      While Not qryCtpdet.Eof Do
      Begin
        Result := fIncluiMeta(qryCtpdet.FieldByName('MCP_CODCTA').AsString,
                              qryCtpdet.FieldByName('MCP_CODOPE').AsString,
                              qryCtpdet.FieldByName('MCP_VALMET').AsFloat,
                              qryCtpdet.FieldByName('MCP_CODEVE').AsString);

        If Not Result Then
          Break;

        qryCtpdet.Next;
      End;

      FreeAndNil(qryCtpdet);
    End;
  End;

  FreeAndNil(qryTabela);
End;

Function TCadMetasCtaDet.fValidaContaPeriodo(strCodEmp, strCodCta, strAutInc: String; dtaDtaIni, dtaDtaFin: TDatetime; blnTodasEmpresas: Boolean; strCodEve: String): Boolean;
  Var
    qryMetas: TUniQuery;
    strSQL: String;
Begin
  qryMetas := fCriaQuery;

  With qryMetas Do
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT COUNT(*) AS QTD FROM MCPGER G                           ';
    strSQL := strSQL + ' INNER JOIN MCPDET ON G.AUTOINCREM = MCP_SEQGER AND             ';
    strSQL := strSQL + '                      ((MCP_CODCTA = :CODCTA) OR                ';

    strSQL := strSQL + '                       ((RIGHT(:CODCTA, 5)  = "00000") AND (LEFT(:CODCTA, 2) = LEFT(MCP_CODCTA, 2))) OR  ';

    strSQL := strSQL + '                       ((RIGHT(:CODCTA, 3)  = "000")   AND (LEFT(:CODCTA, 4) = LEFT(MCP_CODCTA, 4))) OR  ';

    strSQL := strSQL + '                       ((RIGHT(:CODCTA, 3) <> "000")   AND (LEFT(:CODCTA, 2) = LEFT(MCP_CODCTA, 2)) AND (RIGHT(MCP_CODCTA, 5) = "00000")) OR  ';

    strSQL := strSQL + '                       ((RIGHT(:CODCTA, 3) <> "000")   AND (LEFT(:CODCTA, 4) = LEFT(MCP_CODCTA, 4)) AND (RIGHT(MCP_CODCTA, 3) = "000")) ';

    strSQL := strSQL + '                       )                                                    ';
    strSQL := strSQL + ' WHERE G.AUTOINCREM <> :AUTINC AND                 ';

    if not blnTodasEmpresas then
      strSQL := strSQL + '       G.MCP_CODEMP = :CODEMP  AND                 ';

    If (fCfgSis('METPED', varString) = '5') Or (fCfgSis('METPED', varString) = '6')And Not(fEmptyStr(strCodCta))Then
      strSQL := strSQL + '       MCP_CODEVE = :CODEVE  AND                 ';

    strSQL := strSQL + ' ((:DTAINI BETWEEN MCP_DTAINI AND MCP_DTAFIN) OR   ';
    strSQL := strSQL + '  (:DTAFIN BETWEEN MCP_DTAINI AND MCP_DTAFIN))     ';

    SQL.Text := strSQL;

    if not blnTodasEmpresas then
      ParamByName('CODEMP').AsString   := strCodEmp;

    if (fCfgSis('METPED', varString) = '5') Or
       (fCfgSis('METPED', varString) = '6') And
       Not(fEmptyStr(strCodCta)) Then
         ParamByName('CODEVE').AsString   := strCodEve;

    ParamByName('CODCTA').AsString   := strCodCta;
    ParamByName('AUTINC').AsString   := strAutInc;
    ParamByName('DTAINI').AsDateTime := dtaDtaIni;
    ParamByName('DTAFIN').AsDateTime := dtaDtaFin;

    Open;

    Result := FieldByName('QTD').AsInteger = 0;

    If Not Result Then
      pMensagemOk('Existe uma meta para o Plano de Contas ' + FormatMaskText('99.99.999;0;_', strCodCta) + ' conflitando com o período informado!');

  End;

  FreeAndNil(qryMetas);
End;

Function TCadMetasCtaDet.fValidaContasPeriodo(strCodEmp, strAutInc: String; dtaDtaIni, dtaDtaFin: TDatetime; blnTodasEmpresas: boolean): Boolean;
Begin
  DisableControls;
  First;

  Result := True;

  while Not Eof do
  Begin
    Result := fValidaContaPeriodo(strCodEmp, FieldByName('MCP_CODCTA').AsString,
                                  strAutInc, dtaDtaIni, dtaDtaFin, blnTodasEmpresas, FieldByName('MCP_CODEVE').AsString);

    If Not Result Then
      Break;

    Next;
  End;

  EnableControls;
End;

Function TCadMetasCtaDet.fValidaConta(strCodEmp, strCodCta, strAutInc: String; dtaDtaIni, dtaDtaFin: TDatetime; blnTodasEmpresas: boolean; strCodEve: String): Boolean;
Begin
  DisableControls;
  First;

  Result := True;

  while Not Eof do
  Begin
    If strCodCta <> FieldByName('MCP_CODCTA').AsString Then
    Begin

      // Cadastrando uma Linha
      If (RightStr(strCodCta, 5) = '00000') And
         (LeftStr(strCodCta, 2) = LeftStr(FieldByName('MCP_CODCTA').AsString, 2)) Then
      Begin
        Result := False;
        pMensagemOk('Já existem Planos de Contas cadastrados para essa Linha!');
        Break;
      End;

      // Cadastrando uma Grupo
      If (RightStr(strCodCta, 3) = '000') And
         (LeftStr(strCodCta, 4) = LeftStr(FieldByName('MCP_CODCTA').AsString, 4)) Then
      Begin
        Result := False;
        pMensagemOk('Já existem Planos de Contas cadastrados para esse Grupo!');
        Break;
      End;

      // Cadastrando um Plano de Conta, verifica se já existe a linha dessa conta
      If (RightStr(strCodCta, 3) <> '000') And
         (LeftStr(strCodCta, 2) = LeftStr(FieldByName('MCP_CODCTA').AsString, 2)) And
         (RightStr(FieldByName('MCP_CODCTA').AsString, 5) = '00000') Then
      Begin
        Result := False;
        pMensagemOk('A Linha desse Plano de Contas já está cadastrado!');
        Break;
      End;

      // Cadastrando um Plano de Conta, verifica se já existe o grupo dessa conta
      If (RightStr(strCodCta, 3) <> '000') And
         (LeftStr(strCodCta, 4) = LeftStr(FieldByName('MCP_CODCTA').AsString, 4)) And
         (RightStr(FieldByName('MCP_CODCTA').AsString, 3) = '000') Then
      Begin
        Result := False;
        pMensagemOk('O Grupo desse Plano de Contas já está cadastrado!');
        Break;
      End;

    End;

    Next;
  End;

  If Result Then
    Result := fValidaContaPeriodo(strCodEmp, strCodCta, strAutInc, dtaDtaIni, dtaDtaFin, blnTodasEmpresas, strCodEve);

  EnableControls;
End;

end.
