unit untBtnCarregaFormulasCadastradaOnClickPpgNexa;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
    function GetLinhaAutomotiva(): String;
    function GetEscolherSistemaAutomotivo(strTipo: String): String;
  Published
    Constructor Create(Const Cadastro: TAbstractCadastro); reintroduce;
  Published
    Procedure OnClick(Sender: Pointer);
  End;

implementation

uses untLibTintaFactory, untStrUtils;

{ TBtnCarregaBasesCadastrada }

constructor TBtnCarregaBasesCadastrada.Create(
  const Cadastro: TAbstractCadastro);
begin
  inherited Create('OnClick', Cadastro);
end;

procedure TBtnCarregaBasesCadastrada.DeletarRegistro(strIdePro,
  strCodOpe: String);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   DELETE FROM AUXBAS WHERE BAS_IDEPRO = :IDEPRO AND BAS_CODOPE = :CODOPE    ';
  qryGen.ParamByName('IDEPRO').AsString := strIdePro;
  qryGen.ParamByName('CODOPE').AsString := strCodOpe;
  qryGen.ExecSQL;
end;

function TBtnCarregaBasesCadastrada.GetEscolherSistemaAutomotivo(
  strTipo: String): String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT          ' +
                '   PPX_SISTEM             ' +
                ' FROM                     ' +
                '   PPX_CADPPX             ' +
                ' WHERE PPX_TIPO__ = :TIPO ';
  qryGen.ParamByName('TIPO').AsString := strTipo;
  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('PPX_SISTEM').AsString;

    qryGen.Next;
  end;


  If Length(arrOpcoes) >= 2 Then
  Begin
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Sistema', arrOpcoes, 1, True);
    If intOpcao > 0 Then
      Result   := arrOpcoes[intOpcao-1]
    Else
      Result   := '';
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := arrOpcoes[intOpcao-1];
  End;
end;

function TBtnCarregaBasesCadastrada.GetLinhaAutomotiva: String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT BAS_TIPO__ '+
                '   FROM PPX_CADBAS          '+
                '  ORDER BY BAS_TIPO__       ';

  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('BAS_TIPO__').AsString;

    qryGen.Next;
  end;


  If Length(arrOpcoes) >= 2 Then
  Begin
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Tipo', arrOpcoes, 1, True);
    If intOpcao > 0 Then
      Result   := arrOpcoes[intOpcao-1]
    Else
      Result := '';
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := arrOpcoes[intOpcao-1];
  End;
end;

procedure TBtnCarregaBasesCadastrada.OnClick(Sender: Pointer);
Var
  qryCadastro: IDataSet;
  qryRegSelecionado: IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup,
  strTipo,
  strSistema: String;
  intContador: Integer;

  arrColuna: Array Of String;

  procedure pAddColuna(Coluna: String);
  Begin
    SetLength(arrColuna, Succ(Length(arrColuna)));
    arrColuna[High(arrColuna)] := Coluna;
  End;
begin
  Try
    qryCadastro := TAutcomTintaFactory.Get.fGetDataSet;
    strSQL := '';
    strSQLWhere := '';
    strSQLGroup := '';

    qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
    qryRegSelecionado.Close;
    qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "PPX" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
    qryRegSelecionado.Open;

    If qryRegSelecionado.IsEmpty Then
    Begin
      strSQL := strSQL + '  SELECT                          ';
      strSQL := strSQL + '    P.PPX_DESCOR,                   '; pAddColuna('Descrição');
      strSQL := strSQL + '    P.PPX_TIPO__,                   '; pAddColuna('Tipo');
      strSQL := strSQL + '    B.BAS_TIPO__,                   '; pAddColuna('Produto');
      strSQL := strSQL + '    M.MON_DESCRI,                   '; pAddColuna('Descrição Montadora');
      strSQL := strSQL + '    P.PPX_VEICUL,                   '; pAddColuna('Modelos');
      strSQL := strSQL + '    P.PPX_CODCOR,                   '; pAddColuna('Código');
      strSQL := strSQL + '    P.PPX_CODATC,                   '; pAddColuna('Código PPX');
      strSQL := strSQL + '    P.PPX_MONTAD,                   '; pAddColuna('Montadora');
      strSQL := strSQL + '    P.PPX_A_N_O_,                   '; pAddColuna('Ano');
      strSQL := strSQL + '    P.PPX_MD5KEY,                   '; pAddColuna('Chave MD5');
      strSQL := strSQL + '    P.PPX_VARIAN,                   '; pAddColuna('Variante Cor');
      strSQL := strSQL + '    P.PPX_REFERE,                   '; pAddColuna('Referência');
      strSQL := strSQL + '    P.PPX_SISTEM,                   '; pAddColuna('Sistema');
      strSQL := strSQL + '    P.PPX_PAISES,                   '; pAddColuna('País');
      strSQL := strSQL + '    P.PPX_ORIGEM,                   '; pAddColuna('Origem');
      strSQL := strSQL + '    P.PPX_UTILIZ,                   ';
      strSQL := strSQL + '    P.PPX_EFEFIN,                   ';
      strSQL := strSQL + '    P.PPX_ACRMOB,                   ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '    P.PPX_CODB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
        strSQL := strSQL + '    P.PPX_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
      End;

      strSQL := strSQL + '    P.AUTOINCREM                    ';
      strSQL := strSQL + '  FROM                              ';
      strSQL := strSQL + '    PPX_CADPPX P                    ';
      strSQL := strSQL + '  LEFT JOIN PPX_CADMON M ON             ';
      strSQL := strSQL + '    P.PPX_MONTAD = M.MON_CODMON             ';
      strSQL := strSQL + '  INNER JOIN PPX_CADBAS B ON            ';
      strSQL := strSQL + '    P.PPX_CODB01 = BAS_CODBAS               ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(PPX_ATIVO_, "S")) = "S"      ';

      strTipo := GetLinhaAutomotiva;

      If Not TStrUtils.fEmptyStr(strTipo) Then
      Begin
        strSQLWhere := strSQLWhere + ' AND PPX_TIPO__ = ' + QuotedStr(strTipo) + '  ';

        strSistema := GetEscolherSistemaAutomotivo(strTipo);

        If Not TStrUtils.fEmptyStr(strSistema) Then
          strSQLWhere := strSQLWhere + '  AND PPX_SISTEM = ' + QuotedStr(strSistema);
      End;
    End
    Else
    Begin
      strSQL := strSQL + '  SELECT                          ';
      strSQL := strSQL + '    P.PPX_DESCOR,                   '; pAddColuna('Descrição');
      strSQL := strSQL + '    P.PPX_TIPO__,                   '; pAddColuna('Tipo');
      strSQL := strSQL + '    B.BAS_TIPO__,                   '; pAddColuna('Produto');
      strSQL := strSQL + '    M.MON_DESCRI,                   '; pAddColuna('Descrição Montadora');
      strSQL := strSQL + '    P.PPX_VEICUL,                   '; pAddColuna('Modelos');
      strSQL := strSQL + '    P.PPX_CODCOR,                   '; pAddColuna('Código');
      strSQL := strSQL + '    P.PPX_CODATC,                   '; pAddColuna('Código PPX');
      strSQL := strSQL + '    P.PPX_MONTAD,                   '; pAddColuna('Montadora');
      strSQL := strSQL + '    P.PPX_A_N_O_,                   '; pAddColuna('Ano');
      strSQL := strSQL + '    P.PPX_MD5KEY,                   '; pAddColuna('Chave MD5');
      strSQL := strSQL + '    P.PPX_VARIAN,                   '; pAddColuna('Variante Cor');
      strSQL := strSQL + '    P.PPX_REFERE,                   '; pAddColuna('Referência');
      strSQL := strSQL + '    P.PPX_SISTEM,                   '; pAddColuna('Sistema');
      strSQL := strSQL + '    P.PPX_PAISES,                   '; pAddColuna('País');
      strSQL := strSQL + '    P.PPX_ORIGEM,                   '; pAddColuna('Origem');
      strSQL := strSQL + '    P.PPX_UTILIZ,                   ';
      strSQL := strSQL + '    P.PPX_EFEFIN,                   ';
      strSQL := strSQL + '    P.PPX_ACRMOB,                   ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '    P.PPX_CODB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
        strSQL := strSQL + '    P.PPX_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
      End;

      strSQL := strSQL + '    P.AUTOINCREM                    ';
      strSQL := strSQL + '  FROM                              ';
      strSQL := strSQL + '    PPX_CADPPX P                    ';
      strSQL := strSQL + '  LEFT JOIN PPX_CADMON M ON             ';
      strSQL := strSQL + '    P.PPX_MONTAD = M.MON_CODMON             ';
      strSQL := strSQL + '  INNER JOIN PPX_CADBAS B ON            ';
      strSQL := strSQL + '    P.PPX_CODB01 = BAS_CODBAS               ';
      strSQL := strSQL + '  WHERE TRUE              ';
      strSQL := strSQL + '    AND UPPER(IFNULL(PPX_ATIVO_, "S")) = "S"      ';
      strSQL := strSQL + '    AND P.AUTOINCREM = "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
      strSQL := strSQL + '  UNION ALL            ';
      strSQL := strSQL + '  SELECT                          ';
      strSQL := strSQL + '    P.PPX_DESCOR,                   ';
      strSQL := strSQL + '    P.PPX_TIPO__,                   ';
      strSQL := strSQL + '    B.BAS_TIPO__,                   ';
      strSQL := strSQL + '    M.MON_DESCRI,                   ';
      strSQL := strSQL + '    P.PPX_VEICUL,                   ';
      strSQL := strSQL + '    P.PPX_CODCOR,                   ';
      strSQL := strSQL + '    P.PPX_CODATC,                   ';
      strSQL := strSQL + '    P.PPX_MONTAD,                   ';
      strSQL := strSQL + '    P.PPX_A_N_O_,                   ';
      strSQL := strSQL + '    P.PPX_MD5KEY,                   ';
      strSQL := strSQL + '    P.PPX_VARIAN,                   ';
      strSQL := strSQL + '    P.PPX_REFERE,                   ';
      strSQL := strSQL + '    P.PPX_SISTEM,                   ';
      strSQL := strSQL + '    P.PPX_PAISES,                   ';
      strSQL := strSQL + '    P.PPX_ORIGEM,                   ';
      strSQL := strSQL + '    P.PPX_UTILIZ,                   ';
      strSQL := strSQL + '    P.PPX_EFEFIN,                   ';
      strSQL := strSQL + '    P.PPX_ACRMOB,                   ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '    P.PPX_CODB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
        strSQL := strSQL + '    P.PPX_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
      End;

      strSQL := strSQL + '    P.AUTOINCREM                    ';
      strSQL := strSQL + '  FROM                              ';
      strSQL := strSQL + '    PPX_CADPPX P                    ';
      strSQL := strSQL + '  LEFT JOIN PPX_CADMON M ON             ';
      strSQL := strSQL + '    P.PPX_MONTAD = M.MON_CODMON             ';
      strSQL := strSQL + '  INNER JOIN PPX_CADBAS B ON            ';
      strSQL := strSQL + '    P.PPX_CODB01 = BAS_CODBAS               ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(PPX_ATIVO_, "S")) = "S"      ';
      strSQLWhere := strSQLWhere + '    AND P.AUTOINCREM <> "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
    End;

    qryRegSelecionado.Close;

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['PPX_CODCOR'], 'AUTOINCREM',
      'PPX_CADPPX', 'untBtnCarregaFormulasCadastradaOnClickPpgNexa', 'Consulta Dinâmica - PPG/NEXA', qryCadastro, [], []) Then
    Begin
      For intContador := 1 To 20 Do
      Begin
        GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('PPX_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
        GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('PPX_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      End;
      Tela.SelectNext;
      DeletarRegistro('PPX', TAutcomTintaFactory.Get.GetUsuarioLogado);
    End;
  Except
    Raise;
  End;
end;

end.
