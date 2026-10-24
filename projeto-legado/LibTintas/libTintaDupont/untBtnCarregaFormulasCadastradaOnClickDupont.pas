unit untBtnCarregaFormulasCadastradaOnClickDupont;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    function fTemDiluente(strCodBas: String): Boolean;
    function fTemCatalisador(strCodBas: String): Boolean;
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
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

function TBtnCarregaBasesCadastrada.fTemCatalisador(strCodBas: String): Boolean;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                    ';
    qryGen.SQL := qryGen.SQL + '    *                       ';
    qryGen.SQL := qryGen.SQL + '  FROM                      ';
    qryGen.SQL := qryGen.SQL + '    DUP_CADBAS              ';
    qryGen.SQL := qryGen.SQL + '  WHERE                     ';
    qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS AND            ';
    qryGen.SQL := qryGen.SQL + '    BAS_DESBAS LIKE "%CATALISADOR%"        ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Except
    Raise;
  End;
end;

function TBtnCarregaBasesCadastrada.fTemDiluente(strCodBas: String): Boolean;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                    ';
    qryGen.SQL := qryGen.SQL + '    *                       ';
    qryGen.SQL := qryGen.SQL + '  FROM                      ';
    qryGen.SQL := qryGen.SQL + '    DUP_CADBAS              ';
    qryGen.SQL := qryGen.SQL + '  WHERE                     ';
    qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS AND            ';
    qryGen.SQL := qryGen.SQL + '    BAS_DESBAS LIKE "%DILUENTE%"        ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Except
    Raise;
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
    qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "DUP" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
    qryRegSelecionado.Open;

    If qryRegSelecionado.IsEmpty Then
    Begin
      strSQL := strSQL + '  SELECT                          ';
      strSQL := strSQL + '    D.DUP_CODDUP,                 '; pAddColuna('Código');
      strSQL := strSQL + '    D.DUP_ALTERN,                 '; pAddColuna('Alternativa');
      strSQL := strSQL + '    D.DUP_REGIAO,                 '; pAddColuna('Região');
      strSQL := strSQL + '    D.DUP_DESCRI,                 '; pAddColuna('Descrição');
      strSQL := strSQL + '    D.DUP_CODOEM,                 '; pAddColuna('Código Oem');
      strSQL := strSQL + '    D.DUP_MONTAD,                 ';
      strSQL := strSQL + '    D.DUP_ANOCOR,                 '; pAddColuna('Ano');
      strSQL := strSQL + '    D.DUP_LINHA_,                 '; pAddColuna('Linha');
      strSQL := strSQL + '    D.DUP_QUALID,                 '; pAddColuna('Qualidade');
      strSQL := strSQL + '    D.DUP_DTACAD,                 ';
      strSQL := strSQL + '    D.DUP_OBSERV,                 '; pAddColuna('Observação');
      strSQL := strSQL + '    D.DUP_MD5KEY,                 '; pAddColuna('Chave Md5');

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '    D.DUP_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM                  ';
      strSQL := strSQL + '  FROM                            ';
      strSQL := strSQL + '    DUP_CADDUP D                  ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE                    ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DUP_ATIVO_, "S")) = "S"      ';
    End
    Else
    Begin
      strSQL := strSQL + '  SELECT                          ';
      strSQL := strSQL + '    D.DUP_CODDUP,                 '; pAddColuna('Código');
      strSQL := strSQL + '    D.DUP_ALTERN,                 '; pAddColuna('Alternativa');
      strSQL := strSQL + '    D.DUP_REGIAO,                 '; pAddColuna('Região');
      strSQL := strSQL + '    D.DUP_DESCRI,                 '; pAddColuna('Descrição');
      strSQL := strSQL + '    D.DUP_CODOEM,                 '; pAddColuna('Código Oem');
      strSQL := strSQL + '    D.DUP_MONTAD,                 '; pAddColuna('Montadora');
      strSQL := strSQL + '    D.DUP_ANOCOR,                 '; pAddColuna('Ano');
      strSQL := strSQL + '    D.DUP_LINHA_,                 '; pAddColuna('Linha');
      strSQL := strSQL + '    D.DUP_QUALID,                 '; pAddColuna('Qualidade');
      strSQL := strSQL + '    D.DUP_DTACAD,                 ';
      strSQL := strSQL + '    D.DUP_OBSERV,                 '; pAddColuna('Observação');
      strSQL := strSQL + '    D.DUP_MD5KEY,                 '; pAddColuna('Chave Md5');

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '    D.DUP_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM                  ';
      strSQL := strSQL + '  FROM                            ';
      strSQL := strSQL + '    DUP_CADDUP D                  ';
      strSQL := strSQL + '  WHERE TRUE                    ';
      strSQL := strSQL + '    AND UPPER(IFNULL(DUP_ATIVO_, "S")) = "S"      ';
      strSQL := strSQL + '    AND D.AUTOINCREM = "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
      strSQL := strSQL + '  UNION ALL            ';
      strSQL := strSQL + '  SELECT               ';
      strSQL := strSQL + '    D.DUP_CODDUP,                 ';
      strSQL := strSQL + '    D.DUP_ALTERN,                 ';
      strSQL := strSQL + '    D.DUP_REGIAO,                 ';
      strSQL := strSQL + '    D.DUP_DESCRI,                 ';
      strSQL := strSQL + '    D.DUP_CODOEM,                 ';
      strSQL := strSQL + '    D.DUP_MONTAD,                 ';
      strSQL := strSQL + '    D.DUP_ANOCOR,                 ';
      strSQL := strSQL + '    D.DUP_LINHA_,                 ';
      strSQL := strSQL + '    D.DUP_QUALID,                 ';
      strSQL := strSQL + '    D.DUP_DTACAD,                 ';
      strSQL := strSQL + '    D.DUP_OBSERV,                 ';
      strSQL := strSQL + '    D.DUP_MD5KEY,                 ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '    D.DUP_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '    D.DUP_TIPB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      End;

      strSQL := strSQL + '    D.AUTOINCREM                  ';
      strSQL := strSQL + '  FROM                            ';
      strSQL := strSQL + '    DUP_CADDUP D                  ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE                    ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DUP_ATIVO_, "S")) = "S"      ';
      strSQLWhere := strSQLWhere + '    AND D.AUTOINCREM <> "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
    End;

    qryRegSelecionado.Close;

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['DUP_CODDUP'], 'AUTOINCREM',
      'DUP_CADDUP', 'untBtnCarregaFormulasCadastradaOnClickDupont', 'Consulta Dinâmica - Axalta', qryCadastro, [], []) Then
    Begin
      For intContador := 1 To 20 Do
      Begin
        If fTemDiluente(qryCadastro.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Begin
          GetFieldByControle('dbeCodDil').AsString := qryCadastro.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
          GetFieldByControle('dbeQtdDil').AsFloat := qryCadastro.FieldByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          Continue;
        End;

        If (fTemCatalisador(qryCadastro.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Begin
          GetFieldByControle('dbeCodCat').AsString := qryCadastro.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
          GetFieldByControle('dbeQtdCat').AsFloat := qryCadastro.FieldByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          Continue;
        End;

        If intContador <= 18 Then
        Begin
          GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
          GetFieldByControle('dbeQtdC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          GetFieldByControle('dbeQtdD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
        End
      End;
      Tela.SelectNext;
      DeletarRegistro('DUP', TAutcomTintaFactory.Get.GetUsuarioLogado);
    End;
  Except
    Raise;
  End;
end;

end.
