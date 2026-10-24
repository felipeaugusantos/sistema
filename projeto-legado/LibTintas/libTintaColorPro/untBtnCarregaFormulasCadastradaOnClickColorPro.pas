unit untBtnCarregaFormulasCadastradaOnClickColorPro;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs, TlHelp32, Winapi.Windows, System.StrUtils;

Type
  TBtnCarregaBasesCadastrada = Class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrColuna: Array Of String;
    arrOpcoes: Array Of String;
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
    procedure pAddColuna(Coluna: String);
    function fSelectSQL(arrColuna: Array Of String; qrySelecionado: IDataSet): String;
    function fSelectSQLWhere(arrColuna: Array Of String; qrySelecionado: IDataSet): String;
    function GetLinhaWandaPro: String;

    procedure GetLinhaWcp1a6(strLinWan: String);
    procedure GetLinhaWcp7a12(strLinWan: String);
    procedure GetLinhaWcp13a18(strLinWan: String);
    procedure GetLinhaWcp19a21(strLinWan: String);
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
    strSQL := strSQL + '    C.WAN_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    C.WAN_NOMLIN,            '; pAddColuna('Descrição da Linha');
    strSQL := strSQL + '    C.WAN_CODAKZ,            '; pAddColuna('Código');
    strSQL := strSQL + '    C.WAN_DESCRI,            '; pAddColuna('Descricao');
    strSQL := strSQL + '    C.WAN_ALTERN,            '; pAddColuna('Variação');
    strSQL := strSQL + '    C.WAN_MONTAD,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    C.WAN_CAMADA,            '; pAddColuna('Camada');
    strSQL := strSQL + '    C.WAN_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    C.WAN_ANOFIN,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    C.WAN_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    C.WAN_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    C.WAN_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    C.WAN_VERCOR,            '; pAddColuna('Versão');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   C.WAN_LINC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_CODC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QCON' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD21' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD41' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD92' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_PORC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    C.WAN_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    C.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    WANPRO_CADWAN C             ';
    strSQL := strSQL + '  LEFT JOIN WANPRO_CODUNI ON          ';
    strSQL := strSQL + '    WANPRO_CODAKZ = WAN_CODAKZ AND          ';
    strSQL := strSQL + '    WANPRO_ALTERN = WAN_ALTERN AND          ';
    strSQL := strSQL + '    WANPRO_VERCOR = WAN_VERCOR              ';
  End
  Else
  Begin
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    C.WAN_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    C.WAN_NOMLIN,            '; pAddColuna('Descrição da Linha');
    strSQL := strSQL + '    C.WAN_CODAKZ,            '; pAddColuna('Código');
    strSQL := strSQL + '    C.WAN_DESCRI,            '; pAddColuna('Descricao');
    strSQL := strSQL + '    C.WAN_ALTERN,            '; pAddColuna('Variação');
    strSQL := strSQL + '    C.WAN_MONTAD,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    C.WAN_CAMADA,            '; pAddColuna('Camada');
    strSQL := strSQL + '    C.WAN_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    C.WAN_ANOFIN,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    C.WAN_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    C.WAN_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    C.WAN_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    C.WAN_VERCOR,            '; pAddColuna('Versão');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   C.WAN_LINC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_CODC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QCON' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD21' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD41' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD92' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_PORC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    C.WAN_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    C.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    WANPRO_CADWAN C             ';
    strSQL := strSQL + '  LEFT JOIN WANPRO_CODUNI ON          ';
    strSQL := strSQL + '    WANPRO_CODAKZ = WAN_CODAKZ AND          ';
    strSQL := strSQL + '    WANPRO_ALTERN = WAN_ALTERN AND          ';
    strSQL := strSQL + '    WANPRO_VERCOR = WAN_VERCOR              ';
    strSQL := strSQL + '  WHERE TRUE                   ';
    strSQL := strSQL + '    AND UPPER(IFNULL(WAN_ATIVO_, "S")) = "S"         ';
    strSQL := strSQL + '    AND C.AUTOINCREM = "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"    ';
    strSQL := strSQL + '  GROUP BY WAN_CODAKZ, WAN_ALTERN, WAN_CAMADA, WAN_VERCOR, WAN_DESCRI         ';
    strSQL := strSQL + '  UNION ALL                  ';
    strSQL := strSQL + '  SELECT                   ';
    strSQL := strSQL + '    C.WAN_LINHA_,            '; pAddColuna('Linha');
    strSQL := strSQL + '    C.WAN_NOMLIN,            '; pAddColuna('Descrição da Linha');
    strSQL := strSQL + '    C.WAN_CODAKZ,            '; pAddColuna('Código');
    strSQL := strSQL + '    C.WAN_DESCRI,            '; pAddColuna('Descricao');
    strSQL := strSQL + '    C.WAN_ALTERN,            '; pAddColuna('Variação');
    strSQL := strSQL + '    C.WAN_MONTAD,            '; pAddColuna('Montadora');
    strSQL := strSQL + '    C.WAN_CAMADA,            '; pAddColuna('Camada');
    strSQL := strSQL + '    C.WAN_ANOINI,            '; pAddColuna('Ano Inicial');
    strSQL := strSQL + '    C.WAN_ANOFIN,            '; pAddColuna('Ano Final');
    strSQL := strSQL + '    C.WAN_DTACAD,            '; pAddColuna('Data Cadastro');
    strSQL := strSQL + '    C.WAN_CODSEQ,            '; pAddColuna('Código Sequencial');
    strSQL := strSQL + '    C.WAN_ACRMOB,            '; pAddColuna('Acréscimo de mão de obra');
    strSQL := strSQL + '    C.WAN_VERCOR,            '; pAddColuna('Versão');

    For intContador := 1 To 20 Do
    Begin
      strSQL := strSQL + '   C.WAN_LINC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_CODC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QCON' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD21' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD41' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_QD92' + TStrUtils.fStrZero(intContador, 2) + ',   ';
      strSQL := strSQL + '   C.WAN_PORC' + TStrUtils.fStrZero(intContador, 2) + ',   ';
    End;

    strSQL := strSQL + '    C.WAN_MD5KEY,            '; pAddColuna('Chave Md5');
    strSQL := strSQL + '    C.AUTOINCREM             ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    WANPRO_CADWAN C             ';
    strSQL := strSQL + '  LEFT JOIN WANPRO_CODUNI ON          ';
    strSQL := strSQL + '    WANPRO_CODAKZ = WAN_CODAKZ AND          ';
    strSQL := strSQL + '    WANPRO_ALTERN = WAN_ALTERN AND          ';
    strSQL := strSQL + '    WANPRO_VERCOR = WAN_VERCOR              ';
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
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(WAN_ATIVO_, "S")) = "S"   ' ;
    strSQLWhere := strSQLWhere + '    AND WAN_LINHA_ = ' + QuotedStr(AnsiReplaceStr(Trim(LeftStr(GetLinhaWandaPro, 3)), '0', '')) + ' ';
  End
  Else
  Begin
    strSQLWhere := strSQLWhere + '  WHERE TRUE           ';
    strSQLWhere := strSQLWhere + '    AND UPPER(IFNULL(WAN_ATIVO_, "S")) = "S"       ';
    strSQLWhere := strSQLWhere + '    AND C.AUTOINCREM <> "' + qrySelecionado.FieldByName('AUTOINCREM').AsString + '"     ';
  End;

  Result := strSQLWhere;
end;

function TBtnCarregaBasesCadastrada.GetLinhaWandaPro: String;
Var
  intOpcao: Integer;
  strLinWan: String;
begin
  Result := '';

  strLinWan := TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGet('LINWAN');

  GetLinhaWcp1a6(strLinWan);
  GetLinhaWcp7a12(strLinWan);
  GetLinhaWcp13a18(strLinWan);
  GetLinhaWcp19a21(strLinWan);

  If Length(arrOpcoes) >= 2 Then
  Begin
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Linha', arrOpcoes, 1);
    Result := Trim(LeftStr(arrOpcoes[intOpcao - 1], 2));
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result := Trim(LeftStr(arrOpcoes[intOpcao - 1], 2));
  End;
end;

procedure TBtnCarregaBasesCadastrada.GetLinhaWcp13a18(strLinWan: String);
begin
  If Pos('013', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '13 Autocoat BT100';
  End;

  If Pos('15', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '15 Autocoat BT110';
  End;

  If Pos('17', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '17 Autocoat BT130';
  End;

  If Pos('27', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '27 Autowave MM';
  End;

  If Pos('67', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '67 Autowave MM 2.0';
  End;

  If Pos('72', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '72 Tech Fleet PU';
  End;

  If Pos('74', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '74 Tech Fleet Epoxy';
  End;
end;

procedure TBtnCarregaBasesCadastrada.GetLinhaWcp19a21(strLinWan: String);
begin
  If Pos('75', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '75 Tech Fleet Sintetico';
  End;

  If Pos('76', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '76 Tech Fleet Laca';
  End;
end;

procedure TBtnCarregaBasesCadastrada.GetLinhaWcp1a6(strLinWan: String);
begin
  If Pos('001', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := ' 1 Autobase Plus 100:50';
  End;

  If Pos('004', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := ' 4 Wandabase HS';
  End;

  If Pos('006', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := ' 6 Wandalac';
  End;

  If Pos('008', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := ' 8 Wanda PU HS';
  End;

  If Pos('009', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := ' 9 Wandacar';
  End;

  If Pos('011', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '11 Single Stage Converter';
  End;
end;

procedure TBtnCarregaBasesCadastrada.GetLinhaWcp7a12(strLinWan: String);
begin
  If Pos('012', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '12 Autobase Plus Baseline 100:80';
  End;

  If Pos('014', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '14 Autobase Plus 100:80';
  End;

  If Pos('016', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '16 Autocoat BT120';
  End;

  If Pos('019', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '19 Autobase Plus Baseline 100:50';
  End;

  If Pos('058', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '58 Wanda PU MS';
  End;

  If Pos('059', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes) - 1] := '59 Autocoat BT90';
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


     qryRegSelecionado := TAutcomTintaFactory.Get.fGetDataSet;
     qryRegSelecionado.Close;
     qryRegSelecionado.SQL := '   SELECT * FROM AUXBAS WHERE BAS_IDEPRO = "WCP" AND BAS_CODOPE = "' + TAutcomTintaFactory.Get.GetUsuarioLogado + '"   ';
     qryRegSelecionado.Open;

     strSQL := fSelectSQL(arrColuna, qryRegSelecionado);
     strSQLWhere := fSelectSQLWhere(arrColuna, qryRegSelecionado);
     strSQLGroup := ' GROUP BY WAN_CODAKZ, WAN_ALTERN, WAN_CAMADA, WAN_VERCOR, WAN_DESCRI';
     qryRegSelecionado.Close;


     If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrColuna, ['WAN_CODAKZ'], 'AUTOINCREM',
      'WANPRO_CADWAN', 'untBtnCarregaFormulasCadastradaOnClickColorPro', 'Consulta Dinâmica - Color Pro', qryCadastro, [], []) Then
     Begin
       For intContador := 1 To 20 Do
       Begin
         If TStrUtils.fEmptyStr( qryCadastro.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
           Break;

         GetFieldByControle('dbeForm' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadastro.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString;
         GetFieldByControle('dbeQtdC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
         GetFieldByControle('dbeQtdD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
         GetFieldByControle('dbeQt41' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

         If qryCadastro.FieldByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsString = '72' Then
           GetFieldByControle('dbeQtdD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadastro.FieldByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
       End;
       Tela.SelectNext;
       DeletarRegistro('WCP', TAutcomTintaFactory.Get.GetUsuarioLogado);
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
