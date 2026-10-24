unit untBtnCarregaFormulasCadastradaOnClickLazzumix;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
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
    qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "LAZ" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
    qryRegSelecionado.Open;

    If qryRegSelecionado.IsEmpty Then
    Begin
      strSQL := strSQL + '  SELECT                      ';
      strSQL := strSQL + '    L.MIX_CODIGO,             '; pAddColuna('Código');
      strSQL := strSQL + '    L.MIX_DESCRI,             '; pAddColuna('Descrição');
      strSQL := strSQL + '    L.MIX_REFERE,             '; pAddColuna('Referência');
      strSQL := strSQL + '    L.MIX_MONTAD,             '; pAddColuna('Montadora');
      strSQL := strSQL + '    L.MIX_DTACAD,             '; pAddColuna('Data Cadastro');
      strSQL := strSQL + '    L.MIX_A_N_O_,             '; pAddColuna('Ano');
      strSQL := strSQL + '    L.MIX_UNIVER,             '; pAddColuna('Código Universal');
      strSQL := strSQL + '    L.MIX_VOLCON,             ';
      strSQL := strSQL + '    L.MIX_VOLDIL,             ';
      strSQL := strSQL + '    L.MIX_VOLMID,             ';
      strSQL := strSQL + '    L.MIX_VOLMIC,             ';
      strSQL := strSQL + '    L.MIX_ACRMOB,             ';

      For intContador := 1 To 20 Do
      Begin
         strSQL := strSQL + '  L.MIX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '  L.MIX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '  L.MIX_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',    ';
      End;

      strSQL := strSQL + '    L.AUTOINCREM                ';
      strSQL := strSQL + '  FROM                          ';
      strSQL := strSQL + '    LAZ_CADMIX L                ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE                ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(MIX_ATIVAD, "S")) = "S"    ';
    End
    Else
    Begin
      strSQL := strSQL + '  SELECT                      ';
      strSQL := strSQL + '    L.MIX_CODIGO,             '; pAddColuna('Código');
      strSQL := strSQL + '    L.MIX_DESCRI,             '; pAddColuna('Descrição');
      strSQL := strSQL + '    L.MIX_REFERE,             '; pAddColuna('Referência');
      strSQL := strSQL + '    L.MIX_MONTAD,             '; pAddColuna('Montadora');
      strSQL := strSQL + '    L.MIX_DTACAD,             '; pAddColuna('Data Cadastro');
      strSQL := strSQL + '    L.MIX_A_N_O_,             '; pAddColuna('Ano');
      strSQL := strSQL + '    L.MIX_UNIVER,             '; pAddColuna('Código Universal');
      strSQL := strSQL + '    L.MIX_VOLCON,             ';
      strSQL := strSQL + '    L.MIX_VOLDIL,             ';
      strSQL := strSQL + '    L.MIX_VOLMID,             ';
      strSQL := strSQL + '    L.MIX_VOLMIC,             ';
      strSQL := strSQL + '    L.MIX_ACRMOB,             ';

      For intContador := 1 To 20 Do
      Begin
         strSQL := strSQL + '  L.MIX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '  L.MIX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '  L.MIX_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',    ';
      End;

      strSQL := strSQL + '    L.AUTOINCREM                ';
      strSQL := strSQL + '  FROM                          ';
      strSQL := strSQL + '    LAZ_CADMIX L                ';
      strSQL := strSQL + '  WHERE TRUE                ';
      strSQL := strSQL + '    AND UPPER(IFNULL(L.MIX_ATIVAD, "S")) = "S"    ';
      strSQL := strSQL + '    AND L.AUTOINCREM = "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
      strSQL := strSQL + '  UNION ALL            ';
      strSQL := strSQL + '  SELECT               ';
      strSQL := strSQL + '    L.MIX_CODIGO,             ';
      strSQL := strSQL + '    L.MIX_DESCRI,             ';
      strSQL := strSQL + '    L.MIX_REFERE,             ';
      strSQL := strSQL + '    L.MIX_MONTAD,             ';
      strSQL := strSQL + '    L.MIX_DTACAD,             ';
      strSQL := strSQL + '    L.MIX_A_N_O_,             ';
      strSQL := strSQL + '    L.MIX_UNIVER,             ';
      strSQL := strSQL + '    L.MIX_VOLCON,             ';
      strSQL := strSQL + '    L.MIX_VOLDIL,             ';
      strSQL := strSQL + '    L.MIX_VOLMID,             ';
      strSQL := strSQL + '    L.MIX_VOLMIC,             ';
      strSQL := strSQL + '    L.MIX_ACRMOB,             ';

      For intContador := 1 To 20 Do
      Begin
         strSQL := strSQL + '  L.MIX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '  L.MIX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',    ';
         strSQL := strSQL + '  L.MIX_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',    ';
      End;

      strSQL := strSQL + '    L.AUTOINCREM                ';
      strSQL := strSQL + '  FROM                          ';
      strSQL := strSQL + '    LAZ_CADMIX L                ';
      strSQLWhere := strSQLWhere + '  WHERE TRUE                ';
      strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(MIX_ATIVAD, "S")) = "S"    ';
      strSQLWhere := strSQLWhere + '    AND L.AUTOINCREM <> "' + qryRegSelecionado.FieldByName('AUTOINCREM').AsString + '"   ';
    End;

    qryRegSelecionado.Close;

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['MIX_CODIGO'], 'AUTOINCREM',
      'LAZ_CADMIX', 'untBtnCarregaFormulasCadastradaOnClickLazzumix', 'Consulta Dinâmica - Lazzumix', qryCadastro, [], []) Then
    Begin
      For intContador := 1 To 20 Do
      Begin
        GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('MIX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
        GetFieldByControle('dbeQtdB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('MIX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
        GetFieldByControle('dbeQtdD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('MIX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      End;
      Tela.SelectNext;
      DeletarRegistro('LAZ', TAutcomTintaFactory.Get.GetUsuarioLogado);
    End;
  Except
    Raise;
  End;
end;

end.
