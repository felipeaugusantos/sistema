unit untBtnCarregaFormulasCadastradaOnClickSkyMixAutomotiva;

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
    strSQL := strSQL + '    S.SKY_CODUNI,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    S.SKY_ANUANC,            '; pAddColuna('Variante');
    strSQL := strSQL + '    S.SKY_CORPAI,            '; pAddColuna('Cor Pai');
    strSQL := strSQL + '    S.SKY_NACIMP,            '; pAddColuna('Nacionalidade');
    strSQL := strSQL + '    S.SKY_CONDIL,            '; pAddColuna('Concentrado');
    strSQL := strSQL + '    MON_DESMON,              '; pAddColuna('Montadora');
    strSQL := strSQL + '    GRU_LINHA_,              '; pAddColuna('Linha');
    strSQL := strSQL + '    SGR_ASPECT,              '; pAddColuna('Sub Grupo');
    strSQL := strSQL + '    S.SKY_VARIAN,            '; pAddColuna('Variante Cores');
    strSQL := strSQL + '    S.SKY_CODSGR,            '; pAddColuna('Cód. SGR');
    strSQL := strSQL + '    S.SKY_CODGRU,            '; pAddColuna('Grupo');
    strSQL := strSQL + '    S.SKY_CODMON,            '; pAddColuna('Cód. Montadora');
    strSQL := strSQL + '    S.SKY_VERSAO,            '; pAddColuna('Versão');
    strSQL := strSQL + '    S.SKY_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    S.SKY_CODPRO,            '; pAddColuna('Cód. Prods');
    strSQL := strSQL + '    S.SKY_ANOFAB,            '; pAddColuna('Ano Fabricação');
    strSQL := strSQL + '    S.SKY_ACRMOB,            '; pAddColuna('Acréscimo Mão de Obra');
    strSQL := strSQL + '    S.SKY_OBS001,            '; pAddColuna('Observação');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   S.SKY_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.SKY_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.SKY_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    S.SKY_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    S.AUTOINCREM             ';

    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    SKY_CADSKY S             ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADMON ON S.SKY_CODMON = MON_CODMON    ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADGRU ON S.SKY_CODGRU = GRU_CODGRU    ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADSGR ON S.SKY_CODSGR = SGR_CODSGR';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    S.SKY_CODUNI,            '; pAddColuna('Código Universal');
    strSQL := strSQL + '    S.SKY_ANUANC,            '; pAddColuna('Variante');
    strSQL := strSQL + '    S.SKY_CORPAI,            '; pAddColuna('Cor Pai');
    strSQL := strSQL + '    S.SKY_NACIMP,            '; pAddColuna('Nacionalidade');
    strSQL := strSQL + '    S.SKY_CONDIL,            '; pAddColuna('Concentrado');
    strSQL := strSQL + '    MON_DESMON,              '; pAddColuna('Montadora');
    strSQL := strSQL + '    GRU_LINHA_,              '; pAddColuna('Linha');
    strSQL := strSQL + '    SGR_ASPECT,              '; pAddColuna('Sub Grupo');
    strSQL := strSQL + '    S.SKY_VARIAN,            '; pAddColuna('Variante Cores');
    strSQL := strSQL + '    S.SKY_CODSGR,            '; pAddColuna('Cód. SGR');
    strSQL := strSQL + '    S.SKY_CODGRU,            '; pAddColuna('Grupo');
    strSQL := strSQL + '    S.SKY_CODMON,            '; pAddColuna('Cód. Montadora');
    strSQL := strSQL + '    S.SKY_VERSAO,            '; pAddColuna('Versão');
    strSQL := strSQL + '    S.SKY_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    S.SKY_CODPRO,            '; pAddColuna('Cód. Prods');
    strSQL := strSQL + '    S.SKY_ANOFAB,            '; pAddColuna('Ano Fabricação');
    strSQL := strSQL + '    S.SKY_ACRMOB,            '; pAddColuna('Acréscimo Mão de Obra');
    strSQL := strSQL + '    S.SKY_OBS001,            '; pAddColuna('Observação');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   S.SKY_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.SKY_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.SKY_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    S.SKY_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    S.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                         ';
    strSQL := strSQL + '    SKY_CADSKY S             ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADMON ON S.SKY_CODMON = MON_CODMON    ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADGRU ON S.SKY_CODGRU = GRU_CODGRU    ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADSGR ON S.SKY_CODSGR = SGR_CODSGR';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(SKY_ATIVAD, "S")) = "S"         ';
    strSQL := strSQL + '    AND S.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                     ';
    strSQL := strSQL + '    S.SKY_CODUNI,            ';
    strSQL := strSQL + '    S.SKY_ANUANC,            ';
    strSQL := strSQL + '    S.SKY_CORPAI,            ';
    strSQL := strSQL + '    S.SKY_NACIMP,            ';
    strSQL := strSQL + '    S.SKY_CONDIL,            ';
    strSQL := strSQL + '    MON_DESMON,              ';
    strSQL := strSQL + '    GRU_LINHA_,              ';
    strSQL := strSQL + '    SGR_ASPECT,              ';
    strSQL := strSQL + '    S.SKY_VARIAN,            ';
    strSQL := strSQL + '    S.SKY_CODSGR,            ';
    strSQL := strSQL + '    S.SKY_CODGRU,            ';
    strSQL := strSQL + '    S.SKY_CODMON,            ';
    strSQL := strSQL + '    S.SKY_VERSAO,            ';
    strSQL := strSQL + '    S.SKY_DESCRI,            ';
    strSQL := strSQL + '    S.SKY_CODPRO,            ';
    strSQL := strSQL + '    S.SKY_ANOFAB,            ';
    strSQL := strSQL + '    S.SKY_ACRMOB,            ';
    strSQL := strSQL + '    S.SKY_OBS001,            ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   S.SKY_FORM' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.SKY_QTDB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   S.SKY_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    S.SKY_MD5KEY,            ';
    strSQL := strSQL + '    S.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                 ';
    strSQL := strSQL + '    SKY_CADSKY S             ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADMON ON S.SKY_CODMON = MON_CODMON    ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADGRU ON S.SKY_CODGRU = GRU_CODGRU    ';
    strSQL := strSQL + '  LEFT JOIN SKY_CADSGR ON S.SKY_CODSGR = SGR_CODSGR';
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
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(SKY_ATIVAD, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(SKY_ATIVAD, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND S.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
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
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "SKY" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['SKY_CODUNI'], 'AUTOINCREM',
      'SKY_CADSKY', 'untBtnCarregaFormulasCadastradaOnClickSkyMixAutomotiva', 'Consulta Dinâmica - SkyMixAutomotiva', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         If TStrUtils.fEmptyStr(qryCadastro.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
           Break;

         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;

         If qryCadastro.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat > 0 Then
           GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat
         Else
           GetFieldByControle('dbeQtd' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat
       End;
       Tela.SelectNext;
       DeletarRegistro('SKY', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
