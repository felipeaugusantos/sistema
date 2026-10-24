unit untBtnCarregaFormulasCadastradaOnClickMazaIndustrial;

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
    strSQL := strSQL + '    M.MZD_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    M.MZD_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    M.MZD_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    M.MZD_VARIAC,            '; pAddColuna('Variação');
    strSQL := strSQL + '    M.MZD_OBSERV,            '; pAddColuna('Observação');
    strSQL := strSQL + '    M.MZD_ANOCOR,            '; pAddColuna('Ano');
    strSQL := strSQL + '    M.MZD_PESCOR,            '; pAddColuna('Peso Cor');
    strSQL := strSQL + '    M.MZD_PESFOR,            '; pAddColuna('Peso Formula');
    strSQL := strSQL + '    M.MZD_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    MO.MON_DESCRI,           '; pAddColuna('Montadora');
    strSQL := strSQL + '    M.MZD_CODNFM,            '; pAddColuna('Código Nfm');
    strSQL := strSQL + '    M.MZD_UNIVER,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    M.MZD_CODMON,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    M.MZD_ACRMOB,            '; pAddColuna('Acréscimo Mão de Obra');



    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   M.MZD_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   M.MZD_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    M.MZD_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    M.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    MZD_CADMZD M             ';
    strSQL := strSQL + '  LEFT JOIN MZD_CADMON MO ON          ';
    strSQL := strSQL + '    MO.MON_CODMON = M.MZD_CODMON            ';
    strSQL := strSQL + '  LEFT JOIN MZD_CADLIN L ON           ';
    strSQL := strSQL + '    L.LIN_CODIGO = M.MZD_LINHA_             ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    M.MZD_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    M.MZD_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    M.MZD_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    M.MZD_VARIAC,            '; pAddColuna('Variação');
    strSQL := strSQL + '    M.MZD_OBSERV,            '; pAddColuna('Observação');
    strSQL := strSQL + '    M.MZD_ANOCOR,            '; pAddColuna('Ano');
    strSQL := strSQL + '    M.MZD_PESCOR,            '; pAddColuna('Peso Cor');
    strSQL := strSQL + '    M.MZD_PESFOR,            '; pAddColuna('Peso Formula');
    strSQL := strSQL + '    M.MZD_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    MO.MON_DESCRI,           '; pAddColuna('Montadora');
    strSQL := strSQL + '    M.MZD_CODNFM,            '; pAddColuna('Código Nfm');
    strSQL := strSQL + '    M.MZD_UNIVER,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    M.MZD_CODMON,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    M.MZD_ACRMOB,            '; pAddColuna('Acréscimo Mão de Obra');



    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   M.MZD_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   M.MZD_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    M.MZD_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    M.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    MZD_CADMZD M             ';
    strSQL := strSQL + '  LEFT JOIN MZD_CADMON MO ON          ';
    strSQL := strSQL + '    MO.MON_CODMON = M.MZD_CODMON            ';
    strSQL := strSQL + '  LEFT JOIN MZD_CADLIN L ON           ';
    strSQL := strSQL + '    L.LIN_CODIGO = M.MZD_LINHA_             ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(MZD_ATIVAD, "S")) = "S"         ';
    strSQL := strSQL + '    AND M.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    M.MZD_CODIGO,            '; pAddColuna('Código');
    strSQL := strSQL + '    M.MZD_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    M.MZD_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    M.MZD_VARIAC,            '; pAddColuna('Variação');
    strSQL := strSQL + '    M.MZD_OBSERV,            '; pAddColuna('Observação');
    strSQL := strSQL + '    M.MZD_ANOCOR,            '; pAddColuna('Ano');
    strSQL := strSQL + '    M.MZD_PESCOR,            '; pAddColuna('Peso Cor');
    strSQL := strSQL + '    M.MZD_PESFOR,            '; pAddColuna('Peso Formula');
    strSQL := strSQL + '    M.MZD_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    MO.MON_DESCRI,           '; pAddColuna('Montadora');
    strSQL := strSQL + '    M.MZD_CODNFM,            '; pAddColuna('Código Nfm');
    strSQL := strSQL + '    M.MZD_UNIVER,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    M.MZD_CODMON,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    M.MZD_ACRMOB,            '; pAddColuna('Acréscimo Mão de Obra');



    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   M.MZD_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   M.MZD_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    M.MZD_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    M.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    MZD_CADMZD M             ';
    strSQL := strSQL + '  LEFT JOIN MZD_CADMON MO ON          ';
    strSQL := strSQL + '    MO.MON_CODMON = M.MZD_CODMON            ';
    strSQL := strSQL + '  LEFT JOIN MZD_CADLIN L ON           ';
    strSQL := strSQL + '    L.LIN_CODIGO = M.MZD_LINHA_             ';
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
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(MZD_ATIVAD, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(MZD_ATIVAD, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND M.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
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
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "MZD" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['MZD_CODIGO'], 'AUTOINCREM',
      'MZD_CADMZD', 'untBtnCarregaFormulasCadastradaOnClickMazaIndustrial', 'Consulta Dinâmica - Maza Industrial', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('MZD_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('MZD_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('MZD', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
