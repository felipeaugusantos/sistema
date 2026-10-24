{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Ciacollor *}
{**********************************************************************PH*}
unit untGravandoExecucaoCiacollorCores;

interface

uses
  untAbstractGravandoExecucaoCiacollor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, untFloatUtils, Uni,SQLiteUniProvider,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms;
type
  TGravandoExecucaoCiacollorCores = class(TAbstractGravandoExecucaoCiacollor)
  Private
    qryEmbalagem: TUniQuery;
    function fAutoincrem(qryConfig: TUniQuery): String;
    function fVerificaSeMd5KeyExiste(strMd5Key: String): Boolean;
    function fInsertUpdate(intQuantidade: Integer; strMd5Antigo, strMd5: String): String;
    function fUpdateBasQtd(intQuantidade: Integer; strColorante: String; fltQuantidade: Double; strMd5: String): String;
    function fFatorUnidade(intIdEmbNv, intIdEmbPadrao: Integer): Double;
    function fQuantidadeMl(fltQtdPulso: Double; fltPulsoMl: Double): Double;
    function fRetTotalRegistros(): Integer;
    function fRetUnidade(fltEmbalagem: Double): String;
    function fRetEmbalagem(fltEmbalagem: Double): Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils;

{ TGravandoExecucaoCiacollorCores }


procedure TGravandoExecucaoCiacollorCores.Executar(const gravando: IGravando);
Var
  qryCores: TUniQuery;
  qryDestino: IDataSet;
  strSQL: String;
  intQuantidade: Integer;
  intRegistros: Integer;
  fltFatorUnidade: Double;
  strMd5: String;
  qryLoja: TUniQuery;
  fltPulsoMl: Double;
  strValorPulso: String;

  //FIREDAC - CIACOLLOR
  qryConf: TUniQuery;
  qryInsert   : TFDQuery;
  FDDatabase  : TFDConnection;
  FDDriverLink: TFDPhysMySQLDriverLink;
  FDCursor    : TFDGUIxWaitCursor;
  FDatabase : String;
  FUser_Name: String;
  FPassword : String;
  FPort     : String;
  FServer   : String;
  FDriverID : String;
  intQtd: Integer;
  intContador: Integer;
  strMd5Antigo: String;
  strUpdate: String;
begin
  Try
    intQuantidade := 1;
    qryCores := TUniQuery.Create(Nil);
    qryCores.Connection := fConexaoSQLiteStudio();

    strSQL := 'SELECT ';
    strSQL := strSQL + '  FOR.COR_ID AS IDFORMULA,  ';
    strSQL := strSQL + '  C.NOME AS COLORANTE,  ';
    strSQL := strSQL + '  FOR.QUANTIDADE_PIGMENTO AS QTD, ';
    strSQL := strSQL + '  E.CAPACIDADE AS EMBALAGEM,  ';
    strSQL := strSQL + '  COR.EMBALAGEM_PADRAO_ID AS PRIMEIRA_EMB,  ';
    strSQL := strSQL + '  E.ID AS PROXIMA_EMB,  ';
    strSQL := strSQL + '  COL.NOME AS COLECAO,  ';
    strSQL := strSQL + '  BS.NOME AS BASE,  ';
    strSQL := strSQL + '  COR.CODIGO AS NOMCOR, ';
    strSQL := strSQL + '  COR.NOME AS DESCOR, ';
    strSQL := strSQL + '  P.NOME AS PRODUTO ';
    strSQL := strSQL + 'FROM COR_FORMULA AS FOR ';
    strSQL := strSQL + 'INNER JOIN CANISTER AS C ON ';
    strSQL := strSQL + '  FOR.CANISTER_ID = C.ID  ';
    strSQL := strSQL + 'INNER JOIN COR ON ';
    strSQL := strSQL + '  FOR.COR_ID = COR.ID ';
    strSQL := strSQL + 'INNER JOIN PRODUTO_EMBALAGEM AS PE ON ';
    strSQL := strSQL + '  PE.PRODUTO_ID = COR.PRODUTO_ID  ';
    strSQL := strSQL + 'INNER JOIN EMBALAGEM AS E ON  ';
    strSQL := strSQL + '  PE.EMBALAGEM_ID = E.ID  ';
    strSQL := strSQL + 'INNER JOIN COLECAO AS COL ON  ';
    strSQL := strSQL + '  COR.COLECAO_ID = COL.ID ';
    strSQL := strSQL + 'INNER JOIN BASE AS BS ON  ';
    strSQL := strSQL + '  COR.BASE_ID = BS.ID ';
    strSQL := strSQL + 'INNER JOIN PRODUTO AS P ON  ';
    strSQL := strSQL + '  COR.PRODUTO_ID = P.ID   ';
    strSQL := strSQL + 'INNER JOIN PRODUTO_COLECAO AS PC ON   ';
    strSQL := strSQL + '  COR.PRODUTO_ID = PC.PRODUTO_ID AND      ';
    strSQL := strSQL + '  COR.COLECAO_ID = PC.COLECAO_ID          ';
    strSQL := strSQL + 'WHERE COR.ATIVO <> "N" AND  ';
    strSQL := strSQL + '      P.ATIVO <> "N"   AND  ';
    strSQL := strSQL + '      PC.ATIVO <> "N"       ';
    strSQL := strSQL + 'ORDER BY IDFORMULA, PROXIMA_EMB ' ;

    qryCores.Close;
    qryCores.SQL.Clear;
    qryCores.SQL.Add(strSQL);
    qryCores.Open;

    If qryCores.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de cores está vazio! Verificar.';
      Exit;
    End;

    qryLoja := TUniQuery.Create(Nil);
    qryLoja.Connection := fConexaoSQLiteStudio();
    qryLoja.Close;
    qryLoja.SQL.Clear;
    qryLoja.SQL.Add('SELECT VALOR_PULSO FROM LOJA');
    qryLoja.Open;


    strValorPulso := AnsiReplaceStr(qryLoja.FieldByName('VALOR_PULSO').AsString, '.', ',');
    fltPulsoMl := StrToFloat(strValorPulso);

    intRegistros := fRetTotalRegistros();

    qryEmbalagem := TUniQuery.Create(Nil);
    qryEmbalagem.Connection := fConexaoSQLiteStudio();

    strSQL := ' SELECT * FROM EMBALAGEM ';
    qryEmbalagem.Close;
    qryEmbalagem.SQL.Clear;
    qryEmbalagem.SQL.Add(strSQL);
    qryEmbalagem.Open;

    Gravando.Texto := 'Deletando registros da tabela CIA_CADCIA...';
    qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
    qryDestino.Close;
    qryDestino.SQL := ' DELETE FROM CIA_CADCIA  ';
    qryDestino.ExecSQL;
    Gravando.Texto := 'Registros deletados com sucesso...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('CIA_CADCIA');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    qryConf := TAutcomTintaFactory.Get.fCriaQuery();

    FDriverID  := 'DriverID=MySQL';
    FDatabase  := 'Database=' + qryConf.Connection.Database;
    FUser_Name := 'User_Name=' + qryConf.Connection.Username;
    FPassword  := 'Password=' + qryConf.Connection.Password;
    FPort      := 'Port=' + IntToStr(qryConf.Connection.Port);
    FServer    := 'Server=' + qryConf.Connection.Server;

    FDDatabase   := TFDConnection.Create(Nil);
    FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
    FDCursor     := TFDGUIxWaitCursor.Create(Nil);
    qryInsert    := TFDQuery.Create(Nil);

    FDDatabase.Params.Add(FDatabase);
    FDDatabase.Params.Add(FUser_Name);
    FDDatabase.Params.Add(FPassword);
    FDDatabase.Params.Add(FPort);
    FDDatabase.Params.Add(FServer);
    FDDatabase.Params.Add(FDriverID);

    if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
    else
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

    FDDatabase.Connected := True;

    qryInsert.Connection := FDDatabase;
    qryInsert.SQL.Text := fInsertUpdate(intQuantidade, strMd5Antigo, strMd5);

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);

    Try
      While Not qryCores.Eof Do
      Begin
        qryInsert.Params.ClearValues();
        qryInsert.Params.ArraySize := 1;
        intQtd := 0;

        For intContador := 0 To Pred(20) Do
        Begin
          strMd5 := '';
          strMd5 := strMD5 + qryCores.FieldByName('BASE').AsString;
          strMd5 := strMD5 + qryCores.FieldByName('NOMCOR').AsString;
          strMd5 := strMD5 + qryCores.FieldByName('DESCOR').AsString;
          strMd5 := strMD5 + fRetUnidade(qryCores.FieldByName('EMBALAGEM').AsFloat);
          strMd5 := strMD5 + qryCores.FieldByName('PRODUTO').AsString;
          strMd5 := strMD5 + qryCores.FieldByName('COLECAO').AsString;
          strMd5 := strMd5 + FloatToStr(fRetEmbalagem(qryCores.FieldByName('EMBALAGEM').AsFloat));
          strMd5 := GetMD5(strMd5);

          If (strMd5 <> strMd5Antigo) And (fVerificaSeMd5KeyExiste(strMd5)) Then
          Begin
            qryInsert.ParamByName('AUTOINCREM').AsStrings[intQtd] := fAutoincrem(qryConf);
            qryInsert.ParamByName('CIA_CODEMP').AsStrings[intQtd] := TAutcomTintaFactory.Get.GetCodEmp;
            qryInsert.ParamByName('CIA_UNIDAD').AsStrings[intQtd] := fRetUnidade(qryCores.FieldByName('EMBALAGEM').AsFloat);
            qryInsert.ParamByName('CIA_CODUNI').AsStrings[intQtd] := fRetUnidade(qryCores.FieldByName('EMBALAGEM').AsFloat);
            qryInsert.ParamByName('CIA_DESCRI').AsStrings[intQtd] := qryCores.FieldByName('DESCOR').AsString;
            qryInsert.ParamByName('CIA_NOMCOR').AsStrings[intQtd] := qryCores.FieldByName('NOMCOR').AsString;
            qryInsert.ParamByName('CIA_PRODUT').AsStrings[intQtd] := qryCores.FieldByName('PRODUTO').AsString;
            qryInsert.ParamByName('CIA_COLECA').AsStrings[intQtd] := qryCores.FieldByName('COLECAO').AsString;
            qryInsert.ParamByName('CIA_CODBAS').AsStrings[intQtd] := qryCores.FieldByName('BASE').AsString;
            qryInsert.ParamByName('CIA_VOLUME').AsFloats[intQtd]  := fRetEmbalagem(qryCores.FieldByName('EMBALAGEM').AsFloat);
            qryInsert.ParamByName('CIA_DTACAD').AsDates[intQtd]   := Date;
            qryInsert.ParamByName('CIA_MD5KEY').AsStrings[intQtd] := strMd5;

            strMd5Antigo := strMd5;
            Inc(intQtd, 1);
          End;

          If Not qryCores.Eof Then
            qryCores.Next
          Else
            Break;

          Gravando.RegistrarProgresso(0, qryCores.RecNo, intRegistros);

          If intQtd = 1 Then
              Break;
        End;


        If intQtd = 1 Then
          qryInsert.Execute(intQtd, 0);
      End;

      qryCores.First;
      TAutcomTintaFactory.Get.pTrimAppMemorySize;
      Gravando.Texto := 'Gravando Colorantes e quantidades...';

      While Not qryCores.Eof Do
      Begin
        strUpdate := '';

        For intContador := 0 To Pred(500) Do
        Begin
          strMd5 := '';
          strMd5 := strMD5 + qryCores.FieldByName('BASE').AsString;
          strMd5 := strMD5 + qryCores.FieldByName('NOMCOR').AsString;
          strMd5 := strMD5 + qryCores.FieldByName('DESCOR').AsString;
          strMd5 := strMD5 + fRetUnidade(qryCores.FieldByName('EMBALAGEM').AsFloat);
          strMd5 := strMD5 + qryCores.FieldByName('PRODUTO').AsString;
          strMd5 := strMD5 + qryCores.FieldByName('COLECAO').AsString;
          strMd5 := strMd5 + FloatToStr(fRetEmbalagem(qryCores.FieldByName('EMBALAGEM').AsFloat));
          strMd5 := GetMD5(strMd5);

          fltFatorUnidade := fFatorUnidade(qryCores.FieldByName('PROXIMA_EMB').AsInteger,
                                           qryCores.FieldByName('PRIMEIRA_EMB').AsInteger);

          If strMd5 <> strMd5Antigo Then
            intQuantidade := 1;


          strUpdate := strUpdate + fUpdateBasQtd(intQuantidade, qryCores.FieldByName('COLORANTE').AsString, fQuantidadeMl(qryCores.FieldByName('QTD').AsFloat * fltFatorUnidade, fltPulsoMl), strMd5);


          If Not qryCores.Eof Then
            qryCores.Next
          Else
            Break;

          strMd5Antigo := strMd5;
          Gravando.RegistrarProgresso(0, qryCores.RecNo, intRegistros);
          Inc(intQuantidade);
        End;

        qryInsert.Close;
        qryInsert.SQL.Clear;
        qryInsert.SQL.Add(strUpdate);
        qryInsert.ExecSQL;
      End;


    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    FreeAndNil(qryCores);
    FreeAndNil(qryEmbalagem);
    FreeAndNil(FDDatabase);
    FreeAndNil(FDCursor);
    FreeAndNil(qryInsert);
    FreeAndNil(FDDriverLink);
    FreeAndNil(qryConf);
    FreeAndNil(qryLoja);
  End;
end;

function TGravandoExecucaoCiacollorCores.fAutoincrem(
  qryConfig: TUniQuery): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT TABLE_ROWS FROM information_schema.tables ' +
                ' WHERE TABLE_NAME = "CIA_CADCIA" AND TABLE_SCHEMA = "' + qryConfig.Connection.Database + '"  ';
  qryGen.Open;

  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(qryGen.FieldByName('TABLE_ROWS').AsInteger + 1) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TGravandoExecucaoCiacollorCores.fFatorUnidade(intIdEmbNv,
  intIdEmbPadrao: Integer): Double;
Var
  fltEmbNova,
  fltEmbPadrao: Double;
begin
  Result := 1;

  If Not qryEmbalagem.Locate('ID', intIdEmbPadrao, []) Then
    Exit;

  fltEmbPadrao := qryEmbalagem.FieldByName('CAPACIDADE').AsFloat * 1000;

  If Not qryEmbalagem.Locate('ID', intIdEmbNv, []) Then
    Exit;

  fltEmbNova := qryEmbalagem.FieldByName('CAPACIDADE').AsFloat * 1000;

  Result := fltEmbNova / fltEmbPadrao;
end;

function TGravandoExecucaoCiacollorCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoCiacollorCores.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATCIA');
end;

function TGravandoExecucaoCiacollorCores.fInsertUpdate(intQuantidade: Integer; strMd5Antigo, strMd5: String): String;
begin
  Result := ' INSERT INTO CIA_CADCIA(   ' +
            '   AUTOINCREM, ' +
            '   CIA_CODEMP, ' +
            '   CIA_UNIDAD, ' +
            '   CIA_CODUNI, ' +
            '   CIA_DESCRI, ' +
            '   CIA_NOMCOR, ' +
            '   CIA_PRODUT, ' +
            '   CIA_COLECA, ' +
            '   CIA_CODBAS, ' +
            '   CIA_VOLUME, ' +
            '   CIA_DTACAD, ' +
            '   CIA_MD5KEY) ' +
            ' VALUES(                   ' +
            '   :AUTOINCREM, ' +
            '   :CIA_CODEMP, ' +
            '   :CIA_UNIDAD, ' +
            '   :CIA_CODUNI, ' +
            '   :CIA_DESCRI, ' +
            '   :CIA_NOMCOR, ' +
            '   :CIA_PRODUT, ' +
            '   :CIA_COLECA, ' +
            '   :CIA_CODBAS, ' +
            '   :CIA_VOLUME, ' +
            '   :CIA_DTACAD, ' +
            '   :CIA_MD5KEY);';
end;

function TGravandoExecucaoCiacollorCores.fQuantidadeMl(
  fltQtdPulso: Double; fltPulsoMl: Double): Double;
begin
  Result := fltQtdPulso * fltPulsoMl;
  Result := TFloatUtils.fFormataFloat(Result, 4);
end;

function TGravandoExecucaoCiacollorCores.fRetEmbalagem(
  fltEmbalagem: Double): Double;
begin
  Result := fltEmbalagem * 1000;
end;

function TGravandoExecucaoCiacollorCores.fRetTotalRegistros: Integer;
Var
  qryTotalRegistro: TUniQuery;
  strSQL: String;
begin
  Try
    qryTotalRegistro := TUniQuery.Create(Nil);
    qryTotalRegistro.Connection := fConexaoSQLiteStudio();

    strSQL := 'SELECT COUNT(*) AS QTD_REGISTROS ';
    strSQL := strSQL + 'FROM COR_FORMULA AS FOR ';
    strSQL := strSQL + 'INNER JOIN CANISTER AS C ON ';
    strSQL := strSQL + '  FOR.CANISTER_ID = C.ID  ';
    strSQL := strSQL + 'INNER JOIN COR ON ';
    strSQL := strSQL + '  FOR.COR_ID = COR.ID ';
    strSQL := strSQL + 'INNER JOIN PRODUTO_EMBALAGEM AS PE ON ';
    strSQL := strSQL + '  PE.PRODUTO_ID = COR.PRODUTO_ID ';
    strSQL := strSQL + 'INNER JOIN EMBALAGEM AS E ON  ';
    strSQL := strSQL + '  PE.EMBALAGEM_ID = E.ID  ';
    strSQL := strSQL + 'INNER JOIN COLECAO AS COL ON  ';
    strSQL := strSQL + '  COR.COLECAO_ID = COL.ID ';
    strSQL := strSQL + 'INNER JOIN BASE AS BS ON  ';
    strSQL := strSQL + '  COR.BASE_ID = BS.ID ';
    strSQL := strSQL + 'INNER JOIN PRODUTO AS P ON  ';
    strSQL := strSQL + '  COR.PRODUTO_ID = P.ID  ';
    strSQL := strSQL + 'INNER JOIN PRODUTO_COLECAO AS PC ON   ';
    strSQL := strSQL + '  COR.PRODUTO_ID = PC.PRODUTO_ID AND      ';
    strSQL := strSQL + '  COR.COLECAO_ID = PC.COLECAO_ID          ';
    strSQL := strSQL + 'WHERE COR.ATIVO <> "N" AND  ';
    strSQL := strSQL + '      P.ATIVO <> "N"   AND  ';
    strSQL := strSQL + '      PC.ATIVO <> "N"       ';

    qryTotalRegistro.Close;
    qryTotalRegistro.SQL.Clear;
    qryTotalRegistro.SQL.Add(strSQL);
    qryTotalRegistro.Open;

    Result := qryTotalRegistro.FieldByName('QTD_REGISTROS').AsInteger;
  Finally
    FreeAndNil(qryTotalRegistro);
  End;
end;

function TGravandoExecucaoCiacollorCores.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 2 Then
    Result := 'LT'
  Else If fltEmbalagem < 8 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoCiacollorCores.fUpdateBasQtd(intQuantidade: Integer; strColorante: String;
  fltQuantidade: Double; strMd5: String): String;
begin
  Result := ' UPDATE CIA_CADCIA   ' +
            ' SET       ' +
            '   CIA_FORM' + TStrUtils.fStrZero(intQuantidade, 2) + ' = "' + strColorante + '", ' +
            '   CIA_QTDB' + TStrUtils.fStrZero(intQuantidade, 2) + ' = ' + AnsiReplaceStr(FloatToStr(fltQuantidade), ',', '.') + '  ' +
            ' WHERE     ' +
            '   CIA_MD5KEY = "' + strMd5 + '" ;';
end;

function TGravandoExecucaoCiacollorCores.fVerificaSeMd5KeyExiste(strMd5Key: String): Boolean;
Var
  qryCores: IDataSet;
begin
  qryCores := TAutcomTintaFactory.Get.fGetDataSet;
  qryCores.SQL := ' SELECT * FROM CIA_CADCIA WHERE CIA_MD5KEY = :MD5KEY ';
  qryCores.ParamByName('MD5KEY').AsString := strMd5Key;
  qryCores.Open;

  Result := qryCores.IsEmpty;
end;

end.
