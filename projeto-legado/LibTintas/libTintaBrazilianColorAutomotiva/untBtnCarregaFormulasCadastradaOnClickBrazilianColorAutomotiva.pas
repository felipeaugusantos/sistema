unit untBtnCarregaFormulasCadastradaOnClickBrazilianColorAutomotiva;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrColuna: Array Of String;
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
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
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    B.BZC_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    B.BZC_CODNFM,            '; pAddColuna('Código Novas Fórmulas');
    strSQL := strSQL + '    B.BZC_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    B.BZC_CODUNI,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    B.BZC_A_N_O_,            '; pAddColuna('Ano');
    strSQL := strSQL + '    B.BZC_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    M.MON_DESCRI,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    B.BZC_TIPO__,            '; pAddColuna('Tipo');
    strSQL := strSQL + '    B.BZC_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    B.BZC_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   B.BZC_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   B.BZC_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   B.BZC_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    B.BZC_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    B.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    BZC_CADBZC B             ';
    strSQL := strSQL + '  LEFT JOIN BZC_CADMON M            ';
    strSQL := strSQL + '    ON BZC_CODMON = MON_CODMON            ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    B.BZC_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    B.BZC_CODNFM,            '; pAddColuna('Código Novas Fórmulas');
    strSQL := strSQL + '    B.BZC_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    B.BZC_CODUNI,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    B.BZC_A_N_O_,            '; pAddColuna('Ano');
    strSQL := strSQL + '    B.BZC_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    M.MON_DESCRI,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    B.BZC_TIPO__,            '; pAddColuna('Tipo');
    strSQL := strSQL + '    B.BZC_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    B.BZC_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   B.BZC_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   B.BZC_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   B.BZC_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    B.BZC_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    B.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    BZC_CADBZC B             ';
    strSQL := strSQL + '  LEFT JOIN BZC_CADMON M            ';
    strSQL := strSQL + '    ON BZC_CODMON = MON_CODMON            ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(BZC_ATIVAD, "S")) = "S"         ';
    strSQL := strSQL + '    AND B.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    B.BZC_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    B.BZC_CODNFM,            '; pAddColuna('Código Novas Fórmulas');
    strSQL := strSQL + '    B.BZC_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    B.BZC_CODUNI,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    B.BZC_A_N_O_,            '; pAddColuna('Ano');
    strSQL := strSQL + '    B.BZC_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    M.MON_DESCRI,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    B.BZC_TIPO__,            '; pAddColuna('Tipo');
    strSQL := strSQL + '    B.BZC_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    B.BZC_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   B.BZC_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   B.BZC_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   B.BZC_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    B.BZC_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    B.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    BZC_CADBZC B             ';
    strSQL := strSQL + '  LEFT JOIN BZC_CADMON M            ';
    strSQL := strSQL + '    ON BZC_CODMON = MON_CODMON            ';
  End;

  Result := strSQL;
end;

function TBtnCarregaBasesCadastrada.fSelectSQLWhere(arrColuna: array of String;
  qrySelecionado: IDataSet): String;
Var
  strSQLWhere: String;
begin
  strSQLWhere := '';

  If qrySelecionado.IsEmpty Then
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE       ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(BZC_ATIVAD, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(BZC_ATIVAD, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND B.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
  End;

  Result := strSQLWhere;
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
    strSQLGroup := '';

     qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
     qryRegSelecionado.Close;
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "BZC" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['BZC_CODIGO'], 'AUTOINCREM',
      'BZC_CADBZC', 'untBtnCarregaFormulasCadastradaOnClickBrazilianColorAutomotiva', 'Consulta Dinâmica - BrazilianColor Automotiva', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('BZC_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtdB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('BZC_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
         GetFieldByControle('dbeQtdD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('BZC_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('BZC', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
