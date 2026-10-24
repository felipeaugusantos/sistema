unit untBtnCarregaFormulasCadastradaOnClickRoberlo;

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
    strSQL := strSQL + '    R.ROB_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    R.ROB_SERIE_,            '; pAddColuna('Série');
    strSQL := strSQL + '    R.ROB_MARCA_,            '; pAddColuna('Marca');
    strSQL := strSQL + '    R.ROB_NOMCOR,            '; pAddColuna('Nome Cor');
    strSQL := strSQL + '    R.ROB_GRUCOR,            '; pAddColuna('Grupo Cor');
    strSQL := strSQL + '    R.ROB_CAMADA,            '; pAddColuna('Camada');
    strSQL := strSQL + '    R.ROB_MODELO,            '; pAddColuna('Modelo');
    strSQL := strSQL + '    R.ROB_REGIAO,            '; pAddColuna('Região');
    strSQL := strSQL + '    R.ROB_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    R.ROB_VARIAN,            '; pAddColuna('Variante');
    strSQL := strSQL + '    R.ROB_CODCOR,            '; pAddColuna('Código Cor');
    strSQL := strSQL + '    R.ROB_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    R.ROB_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    R.ROB_ANOFIN,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    R.ROB_CATALO,            '; pAddColuna('Catálogo');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   R.ROB_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   R.ROB_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    R.ROB_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    R.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    ROB_CADROB R             ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                     ';
    strSQL := strSQL + '    R.ROB_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    R.ROB_SERIE_,            '; pAddColuna('Série');
    strSQL := strSQL + '    R.ROB_MARCA_,            '; pAddColuna('Marca');
    strSQL := strSQL + '    R.ROB_NOMCOR,            '; pAddColuna('Nome Cor');
    strSQL := strSQL + '    R.ROB_GRUCOR,            '; pAddColuna('Grupo Cor');
    strSQL := strSQL + '    R.ROB_CAMADA,            '; pAddColuna('Camada');
    strSQL := strSQL + '    R.ROB_MODELO,            '; pAddColuna('Modelo');
    strSQL := strSQL + '    R.ROB_REGIAO,            '; pAddColuna('Região');
    strSQL := strSQL + '    R.ROB_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    R.ROB_VARIAN,            '; pAddColuna('Variante');
    strSQL := strSQL + '    R.ROB_CODCOR,            '; pAddColuna('Código Cor');
    strSQL := strSQL + '    R.ROB_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    R.ROB_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    R.ROB_ANOFIN,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    R.ROB_CATALO,            '; pAddColuna('Catálogo');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   R.ROB_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   R.ROB_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    R.ROB_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    R.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                         ';
    strSQL := strSQL + '    ROB_CADROB R               ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(ROB_ATIVO_, "S")) = "S"         ';
    strSQL := strSQL + '    AND R.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  UNION ALL            ';
    strSQL := strSQL + '  SELECT                     ';
    strSQL := strSQL + '    R.ROB_CODIGO,            ';
    strSQL := strSQL + '    R.ROB_SERIE_,            ';
    strSQL := strSQL + '    R.ROB_MARCA_,            ';
    strSQL := strSQL + '    R.ROB_NOMCOR,            ';
    strSQL := strSQL + '    R.ROB_GRUCOR,            ';
    strSQL := strSQL + '    R.ROB_CAMADA,            ';
    strSQL := strSQL + '    R.ROB_MODELO,            ';
    strSQL := strSQL + '    R.ROB_REGIAO,            ';
    strSQL := strSQL + '    R.ROB_DTACAD,            ';
    strSQL := strSQL + '    R.ROB_VARIAN,            ';
    strSQL := strSQL + '    R.ROB_CODCOR,            ';
    strSQL := strSQL + '    R.ROB_ACRMOB,            ';
    strSQL := strSQL + '    R.ROB_ANOINI,            ';
    strSQL := strSQL + '    R.ROB_ANOFIN,            ';
    strSQL := strSQL + '    R.ROB_CATALO,            ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   R.ROB_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   R.ROB_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    R.ROB_MD5KEY,            ';
    strSQL := strSQL + '    R.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                 ';
    strSQL := strSQL + '    ROB_CADROB R       ';
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
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(ROB_ATIVO_, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(ROB_ATIVO_, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND R.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
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
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "ROB" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;

     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['ROB_CODIGO'], 'AUTOINCREM',
      'ROB_CADROB', 'untBtnCarregaFormulasCadastradaOnClickRoberlo', 'Consulta Dinâmica - Roberlo', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('ROB_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtdC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('ROB_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('ROB', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
