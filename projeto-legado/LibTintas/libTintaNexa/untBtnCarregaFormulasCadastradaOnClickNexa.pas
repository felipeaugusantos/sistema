unit untBtnCarregaFormulasCadastradaOnClickNexa;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrColuna: Array Of String;
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
    function GetLinhaAutomotiva(): String;
    function GetEscolherSistemaAutomotivo(strTipo: String): String;
    procedure pAddColuna(Coluna: String);
    function fSelectSQL(arrColuna: Array Of String; qrySelecionado: IDataSet): String;
    function fSelectSQLWhere(arrColuna: Array Of String; qrySelecionado: IDataSet): String;
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

function TBtnCarregaBasesCadastrada.fSelectSQL(arrColuna: array of String;
  qrySelecionado: IDataSet): String;
Var
  strSQL: String;
  intContador: Integer;
begin
  strSQL := '';

  If qrySelecionado.IsEmpty Then
  Begin
    strSQL := strSQL + '  SELECT                          ';
    strSQL := strSQL + '    N.NEX_DESCOR,                   '; pAddColuna('Descrição');
    strSQL := strSQL + '    N.NEX_TIPO__,                   '; pAddColuna('Tipo');
    strSQL := strSQL + '    B.BAS_TIPO__,                   '; pAddColuna('Produto');
    strSQL := strSQL + '    M.MON_DESCRI,                   '; pAddColuna('Descrição Montadora');
    strSQL := strSQL + '    N.NEX_VEICUL,                   '; pAddColuna('Modelos');
    strSQL := strSQL + '    N.NEX_CODCOR,                   '; pAddColuna('Código');
    strSQL := strSQL + '    N.NEX_CODATC,                   '; pAddColuna('Código Nex');
    strSQL := strSQL + '    N.NEX_MONTAD,                   '; pAddColuna('Montadora');
    strSQL := strSQL + '    N.NEX_A_N_O_,                   '; pAddColuna('Ano');
    strSQL := strSQL + '    N.NEX_MD5KEY,                   '; pAddColuna('Chave MD5');
    strSQL := strSQL + '    N.NEX_VARIAN,                   '; pAddColuna('Variante Cor');
    strSQL := strSQL + '    N.NEX_REFERE,                   '; pAddColuna('Referência');
    strSQL := strSQL + '    N.NEX_SISTEM,                   '; pAddColuna('Sistema');
    strSQL := strSQL + '    N.NEX_PAISES,                   '; pAddColuna('País');
    strSQL := strSQL + '    N.NEX_ORIGEM,                   '; pAddColuna('Origem');
    strSQL := strSQL + '    N.NEX_UTILIZ,                   ';
    strSQL := strSQL + '    N.NEX_EFEFIN,                   ';
    strSQL := strSQL + '    N.NEX_ACRMOB,                   ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '    N.NEX_CODB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
      strSQL := strSQL + '    N.NEX_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
    End;

    strSQL := strSQL + '    N.AUTOINCREM                    ';
    strSQL := strSQL + '  FROM                              ';
    strSQL := strSQL + '    NEX_CADNEX N                    ';
    strSQL := strSQL + '  LEFT JOIN NEX_CADMON M ON             ';
    strSQL := strSQL + '    N.NEX_MONTAD = M.MON_CODMON             ';
    strSQL := strSQL + '  INNER JOIN NEX_CADBAS B ON            ';
    strSQL := strSQL + '    N.NEX_CODB01 = BAS_CODBAS               ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                          ';
    strSQL := strSQL + '    N.NEX_DESCOR,                   '; pAddColuna('Descrição');
    strSQL := strSQL + '    N.NEX_TIPO__,                   '; pAddColuna('Tipo');
    strSQL := strSQL + '    B.BAS_TIPO__,                   '; pAddColuna('Produto');
    strSQL := strSQL + '    M.MON_DESCRI,                   '; pAddColuna('Descrição Montadora');
    strSQL := strSQL + '    N.NEX_VEICUL,                   '; pAddColuna('Modelos');
    strSQL := strSQL + '    N.NEX_CODCOR,                   '; pAddColuna('Código');
    strSQL := strSQL + '    N.NEX_CODATC,                   '; pAddColuna('Código Nex');
    strSQL := strSQL + '    N.NEX_MONTAD,                   '; pAddColuna('Montadora');
    strSQL := strSQL + '    N.NEX_A_N_O_,                   '; pAddColuna('Ano');
    strSQL := strSQL + '    N.NEX_MD5KEY,                   '; pAddColuna('Chave MD5');
    strSQL := strSQL + '    N.NEX_VARIAN,                   '; pAddColuna('Variante Cor');
    strSQL := strSQL + '    N.NEX_REFERE,                   '; pAddColuna('Referência');
    strSQL := strSQL + '    N.NEX_SISTEM,                   '; pAddColuna('Sistema');
    strSQL := strSQL + '    N.NEX_PAISES,                   '; pAddColuna('País');
    strSQL := strSQL + '    N.NEX_ORIGEM,                   '; pAddColuna('Origem');
    strSQL := strSQL + '    N.NEX_UTILIZ,                   ';
    strSQL := strSQL + '    N.NEX_EFEFIN,                   ';
    strSQL := strSQL + '    N.NEX_ACRMOB,                   ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '    N.NEX_CODB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
      strSQL := strSQL + '    N.NEX_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
    End;

    strSQL := strSQL + '    N.AUTOINCREM                    ';
    strSQL := strSQL + '  FROM                              ';
    strSQL := strSQL + '    NEX_CADNEX N                    ';
    strSQL := strSQL + '  LEFT JOIN NEX_CADMON M ON             ';
    strSQL := strSQL + '    N.NEX_MONTAD = M.MON_CODMON             ';
    strSQL := strSQL + '  INNER JOIN NEX_CADBAS B ON            ';
    strSQL := strSQL + '    N.NEX_CODB01 = BAS_CODBAS               ';
    strSQL := strSQL + '  WHERE TRUE              ';
    strSQL := strSQL + '    AND UPPER(IFNULL(NEX_ATIVO_, "S")) = "S"      ';
    strSQL := strSQL + '    AND N.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
    strSQL := strSQL + '  UNION ALL            ';
    strSQL := strSQL + '  SELECT                          ';
    strSQL := strSQL + '    N.NEX_DESCOR,                   ';
    strSQL := strSQL + '    N.NEX_TIPO__,                   ';
    strSQL := strSQL + '    B.BAS_TIPO__,                   ';
    strSQL := strSQL + '    M.MON_DESCRI,                   ';
    strSQL := strSQL + '    N.NEX_VEICUL,                   ';
    strSQL := strSQL + '    N.NEX_CODCOR,                   ';
    strSQL := strSQL + '    N.NEX_CODATC,                   ';
    strSQL := strSQL + '    N.NEX_MONTAD,                   ';
    strSQL := strSQL + '    N.NEX_A_N_O_,                   ';
    strSQL := strSQL + '    N.NEX_MD5KEY,                   ';
    strSQL := strSQL + '    N.NEX_VARIAN,                   ';
    strSQL := strSQL + '    N.NEX_REFERE,                   ';
    strSQL := strSQL + '    N.NEX_SISTEM,                   ';
    strSQL := strSQL + '    N.NEX_PAISES,                   ';
    strSQL := strSQL + '    N.NEX_ORIGEM,                   ';
    strSQL := strSQL + '    N.NEX_UTILIZ,                   ';
    strSQL := strSQL + '    N.NEX_EFEFIN,                   ';
    strSQL := strSQL + '    N.NEX_ACRMOB,                   ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '    N.NEX_CODB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
      strSQL := strSQL + '    N.NEX_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',     ';
    End;

    strSQL := strSQL + '    N.AUTOINCREM                    ';
    strSQL := strSQL + '  FROM                              ';
    strSQL := strSQL + '    NEX_CADNEX N                    ';
    strSQL := strSQL + '  LEFT JOIN NEX_CADMON M ON             ';
    strSQL := strSQL + '    N.NEX_MONTAD = M.MON_CODMON             ';
    strSQL := strSQL + '  INNER JOIN NEX_CADBAS B ON            ';
    strSQL := strSQL + '    N.NEX_CODB01 = BAS_CODBAS               ';
  End;

  Result := strSQL;
end;

function TBtnCarregaBasesCadastrada.fSelectSQLWhere(arrColuna: array of String;
  qrySelecionado: IDataSet): String;
Var
  strSQLWhere,
  strTipo,
  strSistema: String;
begin
  strSQLWhere := '';

  If qrySelecionado.IsEmpty Then
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(NEX_ATIVO_, "S")) = "S"      ';

    strTipo := GetLinhaAutomotiva;

    If Not TStrUtils.fEmptyStr(strTipo) Then
    Begin
      strSQLWhere := strSQLWhere + ' AND NEX_TIPO__ = ' + QuotedStr(strTipo) + '  ';
      strSistema := GetEscolherSistemaAutomotivo(strTipo);

      If Not TStrUtils.fEmptyStr(strSistema) Then
        strSQLWhere := strSQLWhere + '  AND NEX_SISTEM = ' + QuotedStr(strSistema);
    End;
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE              ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(NEX_ATIVO_, "S")) = "S"      ';
    strSQLWhere := strSQLWhere + '    AND N.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
  End;

  Result := strSQLWhere;
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
                '   NEX_SISTEM             ' +
                ' FROM                     ' +
                '   NEX_CADNEX             ' +
                ' WHERE NEX_TIPO__ = :TIPO ';
  qryGen.ParamByName('TIPO').AsString := strTipo;
  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('NEX_SISTEM').AsString;

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
  qryGen.SQL := ' SELECT DISTINCT NEX_TIPO__ '+
                '   FROM NEX_CADNEX          '+
                '  ORDER BY NEX_TIPO__       ';

  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('NEX_TIPO__').AsString;

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
  strSQLGroup: String;
  intContador: Integer;
begin
  Try
    qryCadastro := TAutcomTintaFactory.Get.fGetDataSet;
    strSQL := '';
    strSQLWhere := '';
    strSQLGroup := '';

    qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
    qryRegSelecionado.Close;
    qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "NEX" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
    qryRegSelecionado.Open;

    strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
    strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
    qryRegSelecionado.Close;

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['NEX_CODCOR'], 'AUTOINCREM',
      'NEX_CADNEX', 'untBtnCarregaFormulasCadastradaOnClickNexa', 'Consulta Dinâmica - Nexa', qryCadastro, [], []) Then
    Begin
      For intContador := 1 To 20 Do
      Begin
        GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('NEX_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
        GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('NEX_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      End;
      Tela.SelectNext;
      DeletarRegistro('NEX', TAutcomTintaFactory.Get.GetUsuarioLogado);
    End;
  Except
    Raise;
  End;
end;

procedure TBtnCarregaBasesCadastrada.pAddColuna(Coluna: String);
begin
  SetLength(arrColuna, Succ(Length(arrColuna)));
  arrColuna[High(arrColuna)] := Coluna;
end;

end.
