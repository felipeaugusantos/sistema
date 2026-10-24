unit untVelutexDinamica;

interface

uses
  SysUtils, Classes, UniClientDataSet, Uni ,Forms, DB, ADODB, DBClient, Variants,
  untTintadeMaquina, untIConfTinta, ComObj, untDDLFactory;

Type
  TVelutexOpcao = (TVelutexGeraBases, TVelutexGeraColorantes, TVelutexGeraTintas);
  TVelutexOpcoes = set of TVelutexOpcao;

  TVelutexDinamica = class(TTintadeMaquina)
  private
    strPath   : String;
    FOpcoes   : TVelutexOpcoes;
    conf      : IConfTinta;

    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadVel: Boolean;

    function fRetornarFator(strUnidade, strProduto: String ) : Double;

    procedure SetOpcoes(const Value: TVelutexOpcoes);
    procedure pAcertarMd5Key;

    function fRetAutoIncremGeracao(Var intAutInc: Integer; strTabela,
      strCodEmp: String): String;

    procedure pAtualizaAutoIncremGeracao(intAutInc: Integer; strTabela: String);


  public
    constructor Create(AOwner: TComponent); override;
    function fProcessaArquivos: Boolean;
    function fGravarNovasFormulas: Boolean; override;
  published
    property Opcoes: TVelutexOpcoes read FOpcoes write SetOpcoes;

  End;

implementation

uses untFuncoesSimples, untFuncTinta, StrUtils;

{ TVelutexDinamica }

function TVelutexDinamica.fRetAutoIncremGeracao(Var intAutInc: Integer; strTabela,
  strCodEmp: String): String;
  Var
    qryGen: TUniQuery;
begin
  If intAutInc = 0 Then
  Begin

    qryGen := fCriaQuery;
    qryGen.SQL.Text := ' SELECT SQL_NO_CACHE    ' +
                       '   PRO_AUTINC AS AUTINC ' +
                       ' FROM                   ' +
                       '   PROINC               ' +
                       ' WHERE                  ' +
                       '   PRO_NOMARQ = :NOMARQ ';

    qryGen.ParamByName('NOMARQ').AsString := strTabela;
    qryGen.Open;

    intAutInc := qryGen.FieldByName('AUTINC').AsInteger;
  End
  Else
    intAutInc := intAutInc + 1;

  Result := strCodEmp + fStrZero(IntToStr(intAutInc) + strCodEmp, 17);
end;

procedure TVelutexDinamica.pAtualizaAutoIncremGeracao(intAutInc: Integer; strTabela: String);
  Var
    qryGen: TUniQuery;
begin
  If intAutInc > 0 Then
  Begin
    intAutInc := intAutInc + 1;

    qryGen := fCriaQuery;
    qryGen.SQL.Text :=  ' UPDATE   ' +
                        '   PROINC ' +
                        ' SET      ' +
                        '   PRO_AUTINC = :AUTINC ' +
                        ' WHERE    ' +
                        '   PRO_NOMARQ = :NOMARQ ';

    qryGen.ParamByName('AUTINC').AsInteger := intAutInc;
    qryGen.ParamByName('NOMARQ').AsString  := strTabela;
    qryGen.ExecSQL;
  End;
end;


constructor TVelutexDinamica.Create(AOwner: TComponent);
begin
  conf    := fGetConfTinta('VEL');
  strPath := conf.fGet('VELPAT');
end;

function TVelutexDinamica.fGravarNovasFormulas: Boolean;
begin
  Result := True;
end;

function TVelutexDinamica.fProcessaArquivos: Boolean;
begin
  Result := True;

  If TVelutexGeraBases in Opcoes Then
    Result := Result And fProcessaCadBas;

  If TVelutexGeraColorantes in Opcoes Then
    Result := Result And fProcessaCadCol;

  If TVelutexGeraTintas in Opcoes Then
    Result := Result And fProcessaCadVel;
end;

function TVelutexDinamica.fProcessaCadBas: Boolean;
Const
  arrUnidades: Array[1..3] Of String = ('LT', 'GL', 'LA');
  Var
    Excel     : TADODataSet;
    Conexao   : TADOConnection;
    Planilhas : TStringList;
    qryCadBas : TUniQuery;
    conf      : IConfTinta;
    intCont   : Integer;
Begin
  conf      := fGetConfTinta('VEL');

  If (Not FileExists(strPath)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPath, ['&Ok']);
    Result := False;
    Exit;
  End;

  Try
    Try
      Conexao := TADOConnection.Create(nil);
      Conexao.LoginPrompt := False;
      Conexao.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0; Data Source=' + strPath + ';' +
                                  'Mode=Read; Extended Properties=Excel 12.0; Persist Security Info=False';
      Conexao.Open;

      Excel := TADODataSet.Create(nil);
      Excel.Connection := Conexao;

      Planilhas := TStringList.Create;
      Conexao.GetTableNames(Planilhas);

      Excel.CommandText := ' SELECT DISTINCT [PRODUTO], [BASE] '+
                           '   FROM [' + Planilhas.Strings[0] + '] ';


      qryCadBas := fCriaQuery;

      Excel.Open;
      Excel.First;

      pRegistraAcao('Processando o cadastrando de colorante...');

      While Not (Excel.Eof) Do
      Begin
        For intCont := 1 To 3 Do
        Begin
          qryCadBas.SQL.Clear;
          qryCadBas.Close;
          qryCadBas.SQL.Text := ' SELECT * '+
                                '   FROM VEL_CADBAS '+
                                '  WHERE BAS_CODBAS = "'+ Excel.FieldByName('BASE').AsString + '"'+
                                '    AND BAS_PRODUT = "'+ Excel.FieldByName('PRODUTO').AsString + '"'+
                                '    AND BAS_CODUNI = "'+ arrUnidades[intCont] + '"';
          qryCadBas.Open;


          If qryCadBas.IsEmpty  Then
          Begin
            qryCadBas.Insert;
            qryCadBas.FieldByName('BAS_CODBAS').AsString := Excel.FieldByName('BASE').AsString;
            qryCadBas.FieldByName('BAS_PRODUT').AsString := UpperCase(Excel.FieldByName('PRODUTO').AsString);
            qryCadBas.FieldByName('BAS_CODUNI').AsString := arrUnidades[intCont];
            qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
            qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VEL_CADBAS', VS_strCodEmp);
            qryCadBas.Post;
          End;

        End;
        pRegistraProgresso(0, Excel.RecNo, Excel.RecordCount);
        Excel.Next;

      End;

     Except On e : Exception Do
       Begin
         pRegistraAcao('Ocorreu erro ao processar o cadastro de colorantes!' +#13+ E.Message);
       End;
     End;
  Finally
    Result := true;
    pRegistraAcao('Processo finalizado com sucesso!');

    If Assigned(Excel) then FreeAndNil(Excel);
//    If Assigned(Conexao) then FreeAndNil(Conexao);
    If Assigned(Planilhas) then FreeAndNil(Planilhas);
    If Assigned(qryCadBas) then FreeAndNil(qryCadBas);
  End;
End;

function TVelutexDinamica.fProcessaCadCol: Boolean;
  Var
    Excel     : TADODataSet;
    Conexao   : TADOConnection;
    Planilhas : TStringList;
    qryCadCol : TUniQuery;

    conf      : IConfTinta;
    strCodCol : String;
    strDescri : String;
Begin
  conf      := fGetConfTinta('VEL');

  If (Not FileExists(strPath)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPath, ['&Ok']);
    Result := False;
    Exit;
  End;

  Try
    Try
      Conexao := TADOConnection.Create(nil);
      Conexao.LoginPrompt := False;
      Conexao.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0; Data Source=' + strPath + ';' +
                                  'Mode=Read; Extended Properties=Excel 12.0; Persist Security Info=False';
      Conexao.Open;

      Excel := TADODataSet.Create(nil);
      Excel.Connection := Conexao;

      Planilhas := TStringList.Create;
      Conexao.GetTableNames(Planilhas);

      Excel.CommandText := ' SELECT DISTINCT [Ingredient1] '+
                           '   FROM [' + Planilhas.Strings[0] + '] ';

      Excel.CommandText := Excel.CommandText + ' UNION ' +
                           ' SELECT DISTINCT [Ingredient2] '+
                           '   FROM [' + Planilhas.Strings[0] + '] ';

      Excel.CommandText := Excel.CommandText + ' UNION ' +
                           ' SELECT DISTINCT [Ingredient3] '+
                           '   FROM [' + Planilhas.Strings[0] + '] ';


      qryCadCol := fCriaQuery;
      qryCadCol.Close;
      qryCadCol.SQL.Text := 'SELECT * '+
                            '  FROM VEL_CADCOL ';
      qryCadCol.Open;

       Excel.Open;
       Excel.First;

       pRegistraAcao('Processando o cadastrando de colorante...');

       While Not (Excel.Eof) Do
       Begin
         strCodCol := Trim(Copy(Excel.FieldByName('Ingredient1').AsString,1,4));
         strDescri := Trim(Copy(Excel.FieldByName('Ingredient1').AsString, 5, length(Excel.FieldByName('Ingredient1').AsString)));

         If (Not qryCadCol.Locate('COL_CODCOL',strCodCol,[]))
           And (strCodCol <> '')Then
         Begin
          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VEL_CADCOL', VS_strCodEmp);;
          qryCadCol.FieldByName('COL_CODCOL').AsString := strCodCol;
          qryCadCol.FieldByName('COL_DESCRI').AsString := strDescri;
          qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
          qryCadCol.Post;
         End;

         pRegistraProgresso(0, Excel.RecNo, Excel.RecordCount);
         Excel.Next;
       End;
     Except On e : Exception Do
       Begin
         pRegistraAcao('Ocorreu erro ao processar o cadastro de colorantes!' +#13+ E.Message);
       End;
     End;
  Finally
    Result := true;
    pRegistraAcao('Processo finalizado com sucesso!');

    If Assigned(Excel) then FreeAndNil(Excel);
 //   If Assigned(Conexao) then FreeAndNil(Conexao);
    If Assigned(Planilhas) then FreeAndNil(Planilhas);
    If Assigned(qryCadCol) then FreeAndNil(qryCadCol);
  End;
End;

function TVelutexDinamica.fProcessaCadVel: Boolean;
Const
  arrUnidades: Array[1..3] Of String = ('LT', 'GL', 'LA');
  Var
    intAutoincrem : Integer;

    Excel     : TADODataSet;
    Conexao   : TADOConnection;
    Planilhas : TStringList;
    qryCadVel : TUniQuery;
    conf      : IConfTinta;
    intCont   : Integer;
    fltFator  : Double;
Begin
  conf      := fGetConfTinta('VEL');

  If (Not FileExists(strPath)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPath, ['&Ok']);
    Result := False;
    Exit;
  End;

  Try

    Try
      Conexao := TADOConnection.Create(nil);
      Conexao.LoginPrompt := False;
      Conexao.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0; Data Source=' + strPath + ';' +
                                  'Mode=Read; Extended Properties=Excel 12.0; Persist Security Info=False';
      Conexao.Open;

      Excel := TADODataSet.Create(nil);
      Excel.Connection := Conexao;

      Planilhas := TStringList.Create;
      Conexao.GetTableNames(Planilhas);

      Excel.CommandText := ' SELECT [COLEÇÃO] '+
                           '      , [PRODUTO] '+
                           '      , [CODIGO] '+
                           '      , [BASE] '+
                           '      , [CODIGO NOME] '+
                           '      , [Ingredient1] '+
                           '      , [Qtde1] '+
                           '      , [Ingredient2] '+
                           '      , [Qtde2] '+
                           '      , [Ingredient3] '+
                           '      , [Qtde3] '+
                           '      , [Ingredient4] '+
                           '      , [Qtde4] '+
                           '      , [Ingredient5] '+
                           '      , [Qtde5] '+
                           '      , [Ingredient6] '+
                           '      , [Qtde6] '+
                           '   FROM [' + Planilhas.Strings[0] + '] ';

      Excel.Open;
      Excel.First;

      qryCadVel := fCriaQuery;

      pRegistraAcao('Processando o cadastrando de cores...');

      While Not (Excel.Eof) Do
      Begin

        For intCont := 1 To 3 Do
        Begin

          qryCadVel.SQL.Text := TDDLFactory.GetInsertDelayed('VEL_CADVEL');;
          qryCadVel.ParamByName('VEL_CODEMP').AsString := VS_strCodEmp;
          qryCadVel.ParamByName('AUTOINCREM').AsString := fRetAutoIncremGeracao(intAutoIncrem, 'VEL_CADVEL',VS_strCodEmp);
          qryCadVel.ParamByName('VEL_CORCOD').AsString := UpperCase(Excel.FieldByName('PRODUTO').AsString);
          qryCadVel.ParamByName('VEL_CODNOM').AsString := UpperCase(Excel.FieldByName('CODIGO NOME').AsString);
          qryCadVel.ParamByName('VEL_CODBAS').AsString := Excel.FieldByName('BASE').AsString;
          qryCadVel.ParamByName('VEL_COLECA').AsString := UpperCase(Excel.FieldByName('COLEÇÃO').AsString);
          qryCadVel.ParamByName('VEL_PRODUT').AsString := UpperCase(Excel.FieldByName('PRODUTO').AsString);
          qryCadVel.ParamByName('VEL_CODNFM').AsString := '';
          qryCadVel.ParamByName('VEL_CODUNI').AsString := arrUnidades[intCont];

          fltFator := fRetornarFator(arrUnidades[intCont] , qryCadVel.ParamByName('VEL_PRODUT').AsString);

          qryCadVel.ParamByName('VEL_CODC01').AsString := Copy(Excel.FieldByName('Ingredient1').AsString,1,4);
          qryCadVel.ParamByName('VEL_QTDC01').AsFloat := fStrToFloat(Excel.FieldByName('Qtde1').AsString) * fltFator;

          qryCadVel.ParamByName('VEL_CODC02').AsString := Copy(Excel.FieldByName('Ingredient2').AsString,1,4);
          qryCadVel.ParamByName('VEL_QTDC02').AsFloat := fStrToFloat(Excel.FieldByName('Qtde2').AsString)* fltFator;

          qryCadVel.ParamByName('VEL_CODC03').AsString := Copy(Excel.FieldByName('Ingredient3').AsString,1,4);
          qryCadVel.ParamByName('VEL_QTDC03').AsFloat := fStrToFloat(Excel.FieldByName('Qtde3').AsString)* fltFator;

          qryCadVel.ParamByName('VEL_CODC04').AsString := Copy(Excel.FieldByName('Ingredient4').AsString,1,4);
          qryCadVel.ParamByName('VEL_QTDC04').AsFloat := fStrToFloat(Excel.FieldByName('Qtde4').AsString)* fltFator;

          qryCadVel.ParamByName('VEL_CODC05').AsString := Copy(Excel.FieldByName('Ingredient5').AsString,1,4);
          qryCadVel.ParamByName('VEL_QTDC05').AsFloat := fStrToFloat(Excel.FieldByName('Qtde5').AsString)* fltFator;

          qryCadVel.ParamByName('VEL_CODC06').AsString := Copy(Excel.FieldByName('Ingredient6').AsString,1,4);
          qryCadVel.ParamByName('VEL_QTDC06').AsFloat := fStrToFloat(Excel.FieldByName('Qtde6').AsString)* fltFator;

          qryCadVel.ParamByName('VEL_MD5KEY').AsString :=
            GetMD5(qryCadVel.ParamByName('VEL_CORCOD').AsString + qryCadVel.ParamByName('VEL_CODBAS').AsString +
                   qryCadVel.ParamByName('VEL_COLECA').AsString + qryCadVel.ParamByName('VEL_PRODUT').AsString +
                   qryCadVel.ParamByName('VEL_CODUNI').AsString + qryCadVel.ParamByName('VEL_CODNOM').AsString);

          qryCadVel.ExecSQL;

        End;

        pRegistraProgresso(0, Excel.RecNo, Excel.RecordCount);
        Excel.Next;
      End;

      pAcertarMd5Key;
    Except On E : Exception Do
      Begin
        pRegistraAcao('Ocorreu erro ao processar o cadastro de cores!' +#13+ E.Message);
      End;
    End;
  Finally
    Result := true;
    pAtualizaAutoIncremGeracao(intAutoIncrem, 'VEL_CADVEL');
    pRegistraAcao('Processo finalizado com sucesso!');

    If Assigned(Excel) then FreeAndNil(Excel);
//    If Assigned(Conexao) then FreeAndNil(Conexao);
    If Assigned(Planilhas) then FreeAndNil(Planilhas);
    If Assigned(qryCadVel) then FreeAndNil(qryCadVel);
  End;
End;



function TVelutexDinamica.fRetornarFator(strUnidade,
  strProduto: String): Double;
begin
  If Pos(strProduto, 'GRAFIATO RUSTICO_TEXTURATTO RUSTICO_CRISTAL MEDIO_GRALITE MEDIO') > 0 Then
  Begin
    If(strUnidade =  'LT')Then
      Result := 1
    Else
    If(strUnidade =  'GL')Then
      Result := 4
    Else
      Result := 28.39;
  End
  Else
  Begin
    If(strUnidade =  'LT')Then
      Result := 1
    Else
    If(strUnidade =  'GL')Then
      Result := 4
    Else
      Result := 20;
  End;

end;

procedure TVelutexDinamica.pAcertarMd5Key;
Var
  qryDelete : TUniQuery;
  qryCadVel : TUniQuery;
  intLimit  : Integer;
begin
  Try
    qryDelete := fCriaQuery;
    qryCadVel := fCriaQuery;

    qryCadVel.Close;
    qryCadVel.SQl.Clear;
    qryCadVel.SQl.Text := 'SELECT COUNT(*) QTD '+
                          '     , VEL_MD5KEY '+
                          '  FROM VEL_CADVEL '+
                          ' GROUP BY VEL_MD5KEY '+
                          'HAVING COUNT(*)  > 1 ';
    qryCadVel.Open;

    qryCadVel.First;

    While Not qryCadVel.Eof Do
    Begin
      intLimit := (qryCadVel.FieldByName('QTD').AsInteger - 1);
      qryDelete.SQL.Text := 'DELETE                      '+
                            '  FROM VEL_CADVEL           '+
                            ' WHERE VEL_MD5KEY = :MD5KEY '+
                            '   LIMIT '+IntToStr(IntLimit)+' ';
      qryDelete.ParamByName('MD5KEY').AsString := qryCadVel.FieldByName('VEL_MD5KEY').AsString;

      qryDelete.ExecSQL;

      qryCadVel.Next;
    End;
  Finally
    FreeAndNil(qryDelete);
    FreeAndNil(qryCadVel);
  End;
end;

procedure TVelutexDinamica.SetOpcoes(const Value: TVelutexOpcoes);
begin
  FOpcoes := Value;
end;

end.
