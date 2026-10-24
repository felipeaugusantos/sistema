unit untBtnCarregaFormulasCadastradaOnClickStandox;

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
    strSQL := strSQL + '    D.DOX_CODNFM,            '; pAddColuna('Código Novas Fórmulas');
    strSQL := strSQL + '    D.DOX_MONTAD,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    D.DOX_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    D.DOX_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    D.DOX_ANOFIN,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    D.DOX_PAINEL,            '; pAddColuna('Painel');
    strSQL := strSQL + '    D.DOX_QUALID,            '; pAddColuna('Qualidade');
    strSQL := strSQL + '    D.DOX_CATEGO,            '; pAddColuna('Categoria');
    strSQL := strSQL + '    D.DOX_VARIAN,            '; pAddColuna('Variante');
    strSQL := strSQL + '    D.DOX_PAIS__,            '; pAddColuna('Pais');
    strSQL := strSQL + '    D.DOX_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    D.DOX_CODDOX,            '; pAddColuna('Código');
    strSQL := strSQL + '    D.DOX_ACRMOB,            '; pAddColuna('Acrésc. Mão de Obra');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   D.DOX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   D.DOX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    D.DOX_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    D.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    DOX_CADDOX D             ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    D.DOX_CODNFM,            '; pAddColuna('Código Novas Fórmulas');
    strSQL := strSQL + '    D.DOX_MONTAD,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    D.DOX_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    D.DOX_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    D.DOX_ANOFIN,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    D.DOX_PAINEL,            '; pAddColuna('Painel');
    strSQL := strSQL + '    D.DOX_QUALID,            '; pAddColuna('Qualidade');
    strSQL := strSQL + '    D.DOX_CATEGO,            '; pAddColuna('Categoria');
    strSQL := strSQL + '    D.DOX_VARIAN,            '; pAddColuna('Variante');
    strSQL := strSQL + '    D.DOX_PAIS__,            '; pAddColuna('Pais');
    strSQL := strSQL + '    D.DOX_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    D.DOX_CODDOX,            '; pAddColuna('Código');
    strSQL := strSQL + '    D.DOX_ACRMOB,            '; pAddColuna('Acrésc. Mão de Obra');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   D.DOX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   D.DOX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    D.DOX_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    D.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                         ';
    strSQL := strSQL + '    DOX_CADDOX D               ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(DOX_ATIVO_, "S")) = "S"         ';
    strSQL := strSQL + '    AND D.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    D.DOX_CODNFM,            ';
    strSQL := strSQL + '    D.DOX_MONTAD,            ';
    strSQL := strSQL + '    D.DOX_DESCRI,            ';
    strSQL := strSQL + '    D.DOX_ANOINI,            ';
    strSQL := strSQL + '    D.DOX_ANOFIN,            ';
    strSQL := strSQL + '    D.DOX_PAINEL,            ';
    strSQL := strSQL + '    D.DOX_QUALID,            ';
    strSQL := strSQL + '    D.DOX_CATEGO,            ';
    strSQL := strSQL + '    D.DOX_VARIAN,            ';
    strSQL := strSQL + '    D.DOX_PAIS__,            ';
    strSQL := strSQL + '    D.DOX_CODSEQ,            ';
    strSQL := strSQL + '    D.DOX_CODDOX,            ';
    strSQL := strSQL + '    D.DOX_ACRMOB,            ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   D.DOX_BASE' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   D.DOX_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    D.DOX_MD5KEY,            ';
    strSQL := strSQL + '    D.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                 ';
    strSQL := strSQL + '    DOX_CADDOX D       ';
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
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DOX_ATIVO_, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(DOX_ATIVO_, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND D.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
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
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "DOX" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['DOX_CODNFM'], 'AUTOINCREM',
      'DOX_CADDOX', 'untBtnCarregaFormulasCadastradaOnClickStandox', 'Consulta Dinâmica - Standox', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('DOX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtdB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('DOX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('DOX', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
