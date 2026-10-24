unit untBtnCarregaFormulasCadastradaOnClickFarbenAutomotiva;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrColuna: Array Of String;
    function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fRetornaFatorDensidade(strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fRetornarDensidade(strCodBas : String) : Double;
    function fCasasDecimaisQtd(strTipPrg: String): Integer;
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

function TBtnCarregaBasesCadastrada.fArredondaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.' + TStrUtils.fStrZero(0, intCasas), fltValor));
end;

function TBtnCarregaBasesCadastrada.fCasasDecimaisQtd(
  strTipPrg: String): Integer;
begin
  Result := 5;
end;

function TBtnCarregaBasesCadastrada.fRetornaFatorDensidade(strTipPrg: String;
  fltQtdCon, fltPesEsp: Double): Double;
begin
  Result := fltQtdCon / fltPesEsp;

 { If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltQtdCon / fltPesEsp, 2);}
end;

function TBtnCarregaBasesCadastrada.fRetornarDensidade(
  strCodBas: String): Double;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := 0;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DENSID '+
                    '  FROM FAR_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.Open;

      Result := qryGen.FieldByName('BAS_DENSID').AsFloat;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TBtnCarregaBasesCadastrada.fRetornaTotalDensidade(strTipPrg: String;
  fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;

  {If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltPorcen / fltDensid, 2);  }
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
    strSQL := strSQL + '    F.FAR_CODNFM,            '; pAddColuna('Código');
    strSQL := strSQL + '    F.FAR_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    M.FAR_DESMON,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    F.FAR_O_E_M_,            '; pAddColuna('Oem');
    strSQL := strSQL + '    F.FAR_A_N_O_,            '; pAddColuna('Ano');
    strSQL := strSQL + '    F.FAR_SETOR_,            '; pAddColuna('Setor');
    strSQL := strSQL + '    F.FAR_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    F.FAR_CODEMP,            '; pAddColuna('Código Empresa');
    strSQL := strSQL + '    F.FAR_MONTAD,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    F.FAR_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    F.FAR_TIPPRG,            '; pAddColuna('Programa');
    strSQL := strSQL + '    F.FAR_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    F.FAR_OBSERV,            '; pAddColuna('Observação');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   F.FAR_CODB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   F.FAR_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   F.FAR_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    F.FAR_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    F.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    FAR_CADFAR F             ';
    strSQL := strSQL + '  LEFT JOIN FAR_CADMON M  ON            ';
    strSQL := strSQL + '    (F.FAR_MONTAD = M.FAR_CODMON)             ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    F.FAR_CODNFM,            '; pAddColuna('Código');
    strSQL := strSQL + '    F.FAR_DESCRI,            '; pAddColuna('Descrição');
    strSQL := strSQL + '    M.FAR_DESMON,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    F.FAR_O_E_M_,            '; pAddColuna('Oem');
    strSQL := strSQL + '    F.FAR_A_N_O_,            '; pAddColuna('Ano');
    strSQL := strSQL + '    F.FAR_SETOR_,            '; pAddColuna('Setor');
    strSQL := strSQL + '    F.FAR_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    F.FAR_CODEMP,            '; pAddColuna('Código Empresa');
    strSQL := strSQL + '    F.FAR_MONTAD,            '; pAddColuna('Código Montadora');
    strSQL := strSQL + '    F.FAR_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    F.FAR_TIPPRG,            '; pAddColuna('Programa');
    strSQL := strSQL + '    F.FAR_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    F.FAR_OBSERV,            '; pAddColuna('Observação');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   F.FAR_CODB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   F.FAR_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   F.FAR_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    F.FAR_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    F.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    FAR_CADFAR F             ';
    strSQL := strSQL + '  LEFT JOIN FAR_CADMON M  ON            ';
    strSQL := strSQL + '    (F.FAR_MONTAD = M.FAR_CODMON)             ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(FAR_ATIVAD, "S")) = "S"         ';
    strSQL := strSQL + '    AND F.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    F.FAR_CODNFM,            ';
    strSQL := strSQL + '    F.FAR_DESCRI,            ';
    strSQL := strSQL + '    M.FAR_DESMON,            ';
    strSQL := strSQL + '    F.FAR_O_E_M_,            ';
    strSQL := strSQL + '    F.FAR_A_N_O_,            ';
    strSQL := strSQL + '    F.FAR_SETOR_,            ';
    strSQL := strSQL + '    F.FAR_LINHA_,            ';
    strSQL := strSQL + '    F.FAR_CODEMP,            ';
    strSQL := strSQL + '    F.FAR_MONTAD,            ';
    strSQL := strSQL + '    F.FAR_CODSEQ,            ';
    strSQL := strSQL + '    F.FAR_TIPPRG,            ';
    strSQL := strSQL + '    F.FAR_ACRMOB,            ';
    strSQL := strSQL + '    F.FAR_OBSERV,            ';

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   F.FAR_CODB' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   F.FAR_QTDC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   F.FAR_QTDD' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    F.FAR_MD5KEY,            ';
    strSQL := strSQL + '    F.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    FAR_CADFAR F             ';
    strSQL := strSQL + '  LEFT JOIN FAR_CADMON M  ON            ';
    strSQL := strSQL + '    (F.FAR_MONTAD = M.FAR_CODMON)             ';
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
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(FAR_ATIVAD, "S")) = "S"   ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(FAR_ATIVAD, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND F.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
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

  //Calculo Gramas
  fltTotalPorcentagem,
  fltTotalDensidade,
  fltFatorDensidade: Double;
begin
  Try
    qryCadastro := TAutcomTintaFactory.Get.fGetDataSet;
    strSQLGroup := '';

     qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
     qryRegSelecionado.Close;
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "FAR" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['FAR_CODSEQ'], 'AUTOINCREM',
      'FAR_CADFAR', 'untBtnCarregaFormulasCadastradaOnClickFarbenAutomotiva', 'Consulta Dinâmica - Farben Automotiva', qryCadastro, [], []) Then
     Begin

       fltTotalPorcentagem := 0;
       fltTotalDensidade   := 0;

       For intContador := 1 To 20 Do
       Begin
         If TStrUtils.fEmptyStr(qryCadastro.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
           Break;

         {FATOR DA DENSIDADE}
          Try
            fltFatorDensidade :=  fRetornaFatorDensidade(qryCadastro.FieldByName('FAR_TIPPRG').AsString
                                                        , qryCadastro.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat
                                                        , fRetornarDensidade(qryCadastro.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString));
          Except
            fltFatorDensidade :=  1;
          End;

         {SOMATORIO DA PORCENTAGEM}
         fltTotalPorcentagem := fltTotalPorcentagem + qryCadastro.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

         {SOMATORIO DA DENSIDADE}
         fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
       End;

       Try
          fltTotalDensidade := fRetornaTotalDensidade(qryCadastro.FieldByName('FAR_TIPPRG').AsString
                                                    , fltTotalPorcentagem
                                                    , fltTotalDensidade);
       Except
          fltTotalDensidade := 1;
       End;

       For intContador := 1 To 20 Do
       Begin
         If TStrUtils.fEmptyStr(qryCadastro.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
           Break;

         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtdB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := fArredondaValor(0.900 * fltTotalDensidade *
                                                                                       (qryCadastro.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / 100) * 1000,
                                                                                       fCasasDecimaisQtd(qryCadastro.FieldByName('FAR_TIPPRG').AsString));
       End;

       fltTotalPorcentagem := 0;
       fltTotalDensidade   := 0;

       For intContador := 1 To 20 Do
       Begin
         If TStrUtils.fEmptyStr(qryCadastro.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
           Break;

         {FATOR DA DENSIDADE}
         fltFatorDensidade := qryCadastro.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fRetornarDensidade(qryCadastro.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);

         {SOMATORIO DA PORCENTAGEM}
         fltTotalPorcentagem := fltTotalPorcentagem + qryCadastro.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

         {SOMATORIO DA DENSIDADE}
         fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
       End;

       Try
         fltTotalDensidade := fltTotalPorcentagem / fltTotalDensidade;
       Except
         fltTotalDensidade := 1;
       End;


       For intContador := 1 To 20 Do
       Begin
         If TStrUtils.fEmptyStr(qryCadastro.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
           Break;

         GetFieldByControle('dbeQtdD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := fArredondaValor(0.900 * fltTotalDensidade *
                                                                                       (qryCadastro.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat / 100)
                                                                                        * 1000, 5);
       End;
       Tela.SelectNext;
       DeletarRegistro('FAR', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
