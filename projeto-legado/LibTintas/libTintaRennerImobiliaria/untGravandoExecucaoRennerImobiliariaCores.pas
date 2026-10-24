{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta RennerImobiliaria *}
{**********************************************************************PH*}
unit untGravandoExecucaoRennerImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoRennerImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, ComObj,
  Variants, StrUtils, Math;

type
  TGravandoExecucaoRennerImobiliariaCores = class(TAbstractGravandoExecucaoRennerImobiliaria)
  private
    qryInsert: IDataSet;
    function fCriaQueryCores: IDataSet;
    procedure pLimparParametros;

    function fConverteDataRenner(strDataRenner: String): TDateTime;
//    function fConverteOncaRenner(strQtd1, strQtd2, strQtd3: String): Double;

    procedure pExcluindoMDDuplicados(const gravando: IGravando);
    procedure pCarregaIdentificadores(const gravando: IGravando);
    function fRetornaReferencia(strIdentificador: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoRennerImobiliariaCores }

procedure TGravandoExecucaoRennerImobiliariaCores.Executar(const gravando: IGravando);
var
  intCont   : Integer;
  strNomArq : String;
  qryTrunc  : IDataSet;
  qryCadBas : IDataSet;

  intLinha,
  intLinhas,
  intForm,
  intConSeq : Integer;

  strLinha,
  strMd5    : String;

  blnPular  : Boolean;

  Const
    arrUnidades: Array[1..3] of String = ('QT', 'GL', 'LA');
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de Cores não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      If stlArquivos.Count <= 0 Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de Cores está vazio...';
        gravando.Cancelar;
        Exit;
      End;

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REI_CADREI');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.SQL := 'SELECT * FROM REI_CADBAS';
      qryCadBas.Open;

      //Criando a tabela de insert
      qryInsert := fCriaQueryCores;

      gravando.Texto := 'Limpando a Tabela de Cores ...';

      qryTrunc := TAutcomTintaFactory.Get.fGetDataSet;
      qryTrunc.SQL := 'TRUNCATE TABLE REI_CADREI';
      qryTrunc.ExecSQL;

      if gravando.Status <> sgGravando then
        Exit;

      pCarregaIdentificadores(gravando);

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores ...';

      intConSeq := 1;

      Try
        Try
          For intCont := 0 To stlArquivos.Count - 1 Do
          Begin
            if gravando.Status <> sgGravando then
              Exit;

            If (Pos('Tabela', stlArquivos.Strings[intCont]) > 0) Then
              Continue;

            strNomArq := stlArquivos.Strings[intCont];

            intLinhas := fContaLinhas(strNomArq);

            AssignFile(arqRenner, strNomArq);
            Reset(arqRenner);

            intLinha := 1;

            gravando.Texto := 'Iniciando processo de gravação do arquivo...' + strNomArq;

            While Not Eof(arqRenner) Do
            Begin
              blnPular := False;
              strMd5   := '';

              Readln(arqRenner, strLinha);
              registroRenner := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

              If Trim(registroRenner.IdSeq) = 'IdSeq' Then
                Continue;

              if gravando.Status <> sgGravando then
                Exit;

              pLimparParametros;

              qryInsert.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REI_CADREI', TAutcomTintaFactory.Get.GetCodEmp);
              qryInsert.ParamByName('REI_CODSEQ').AsString := TStrUtils.fStrZero(intConSeq, 6);
              qryInsert.ParamByName('REI_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryInsert.ParamByName('REI_DESCOR').AsString := Trim(fGetString(registroRenner.NomeCorPT)); // + ' ' + fGetString(registroRenner.Produto) + ' ' + fGetString(registroRenner.Base));
              qryInsert.ParamByName('REI_INGLES').AsString := Trim(fGetString(registroRenner.NomeCor));
              qryInsert.ParamByName('REI_ESPANH').AsString := Trim(fGetString(registroRenner.NomeCorES));
              qryInsert.ParamByName('REI_CODPRO').AsString := fGetString(registroRenner.CorId);
              qryInsert.ParamByName('REI_DESCRI').AsString := fGetString(registroRenner.Produto) + ' ' + fGetString(registroRenner.Base);
              qryInsert.ParamByName('REI_CODBAS').AsString := fGetString(registroRenner.IdBase);
              qryInsert.ParamByName('REI_DTACAD').AsDateTime := fConverteDataRenner(fGetString(registroRenner.Data));
              qryInsert.ParamByName('REI_REFERE').AsString := fRetornaReferencia(fGetString(registroRenner.Identificador));

              For intForm := 1 To 6 Do
              Begin
                If (intForm = 1) And (TAutcomTintaFactory.Get.fStrToFloat(fGetString(registroRenner.Qtd[intForm])) <= 0) Then
                Begin
                  blnPular := True;
                  Break;
                End;

                If TStrUtils.fEmptyStr(fGetString(registroRenner.Corante[intForm])) Then
                  Break;

                qryInsert.ParamByName('REI_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString := fGetString(registroRenner.Corante[intForm]);
                qryInsert.ParamByName('REI_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(fGetString(registroRenner.Qtd[intForm]));

                strMd5 := strMd5 + qryInsert.ParamByName('REI_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString +
                  FloatToStr(qryInsert.ParamByName('REI_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat);
              End;

              If blnPular Then
                Continue;

              strMd5 :=  qryInsert.ParamByName('REI_DESCRI').AsString +
                         qryInsert.ParamByName('REI_REFERE').AsString +
                         qryInsert.ParamByName('REI_UNIDAD').AsString +
                         qryInsert.ParamByName('REI_DESCOR').AsString +
                         qryInsert.ParamByName('REI_CODPRO').AsString +
                         qryInsert.ParamByName('REI_CODBAS').AsString +
                         strMd5;

              qryInsert.ParamByName('REI_UNIDAD').AsString := fGetUnidade(fGetString(registroRenner.Embalagem));
              qryInsert.ParamByName('REI_MD5KEY').AsString := GetMD5(strMd5);

              qryInsert.ExecSQL;

              gravando.RegistrarProgresso(0, intLinha, intLinhas);
              intLinha  := intLinha + 1;
              intConSeq := intConSeq + 1;
            End;
          End;

          //Excluindo MD5 Duplicados
          pExcluindoMDDuplicados(gravando);

        Except
          on E: Exception do
          begin
            gravando.Cancelar;
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          End;
        End;
      Finally
        gravando.Texto := 'Finalizado o processo de gravação do arquivo...' + strNomArq;
      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoRennerImobiliariaCores.fConverteDataRenner(
  strDataRenner: String): TDateTime;
begin
  // 14/10/1999
//  Insert('/', strDataRenner, 3);
//  Insert('/', strDataRenner, 6);
  If strDataRenner = '' Then
    Result := fNow()
  Else
    Result := StrToDate(strDataRenner);
end;

{function TGravandoExecucaoRennerImobiliariaCores.fConverteOncaRenner(strQtd1,
  strQtd2, strQtd3: String): Double;
begin
  Result := 0;

  if TStrUtils.fEmptyStr(strQtd1) then
    strQtd1 := '0';

  if TStrUtils.fEmptyStr(strQtd2) then
    strQtd2 := '0';

  if TStrUtils.fEmptyStr(strQtd3) then
    strQtd3 := '0';

  Result := Result + TAutcomTintaFactory.Get.fStrToFloat(strQtd1) * 29.57353;

  Result := Result + (TAutcomTintaFactory.Get.fStrToFloat(strQtd2) + IfThen(TAutcomTintaFactory.Get.fStrToFloat(strQtd3) = 1, 0.5)) * 29.57353 / 48;
end;}

function TGravandoExecucaoRennerImobiliariaCores.fCriaQueryCores: IDataSet;
var
  intForm: Integer;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;

  Result.SQL := ' INSERT INTO REI_CADREI ' +

                            '           (REI_CODPRO, ' +
                            '            REI_CODEMP, ' +
                            '            REI_DESCOR, ' +
                            '            REI_INGLES, ' +
                            '            REI_ESPANH, ' +
                            '            REI_REFERE, ' +
                            '            REI_DESCRI, ' +
                            '            REI_DTACAD, ' +
                            '            REI_CODBAS, ' +
                            '            REI_UNIDAD, ';

  For intForm := 1 To 20 Do
  Begin
    Result.SQL := Result.SQL  + '        REI_FORM' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        REI_QTDC' + TStrUtils.fStrZero(intForm, 2) + ', ';
  End;

  Result.SQL := Result.SQL  + '          REI_CODSEQ, ' +
                              '          AUTOINCREM, ' +
                              '          REI_MD5KEY) ' +

                              ' VALUES (:REI_CODPRO, ' +
                              '         :REI_CODEMP, ' +
                              '         :REI_DESCOR, ' +
                            '           :REI_INGLES, ' +
                            '           :REI_ESPANH, ' +
                              '         :REI_REFERE, ' +
                              '         :REI_DESCRI, ' +
                              '         :REI_DTACAD, ' +
                              '         :REI_CODBAS, ' +
                              '         :REI_UNIDAD, ';

    For intForm := 1 To 20 Do
    Begin
      Result.SQL := Result.SQL  + '     :REI_FORM' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :REI_QTDC' + TStrUtils.fStrZero(intForm, 2) + ', ';
    End;

    Result.SQL := Result.SQL  + '       :REI_CODSEQ,  ' +
                                '       :AUTOINCREM,  ' +
                                '       :REI_MD5KEY); ';

end;

function TGravandoExecucaoRennerImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoRennerImobiliariaCores.fRetornaReferencia(
  strIdentificador: String): String;
var
  intCont: Integer;
begin
  Result := strIdentificador;
  For intCont := 0 To Length(arrArqIdent) - 1 Do
  Begin
    If arrArqIdent[intCont].Id = strIdentificador Then
      Result := arrArqIdent[intCont].Nome;
  End;
end;

procedure TGravandoExecucaoRennerImobiliariaCores.pCarregaIdentificadores(
  const gravando: IGravando);
var
  intCont: Integer;
  intArq: Integer;
  arqTabelaIdent: TextFile;
  strLinha: String;
begin
  For intCont := 0 To stlArquivos.Count - 1 Do
  Begin
    If (Pos('Tabela', stlArquivos.Strings[intCont]) > 0) Then
    Begin
      AssignFile(arqTabelaIdent, stlArquivos.Strings[intCont]);
      Reset(arqTabelaIdent);

      intArq := 0;

      While Not Eof(arqTabelaIdent) Do
      Begin
        Readln(arqTabelaIdent, strLinha);

        intArq := intArq + 1;

        SetLength(arrArqIdent, intArq);
        arrArqIdent[intArq - 1].Id   := Trim(Copy(strLinha,1,6));
        arrArqIdent[intArq - 1].Nome := Trim(Copy(strLinha,7,20));
      End;

      Exit;
    End;
  End;
end;

procedure TGravandoExecucaoRennerImobiliariaCores.pExcluindoMDDuplicados(
  const gravando: IGravando);
var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        REI_MD5KEY       ' +
                '   FROM REI_CADREI       ' +
                '  GROUP BY REI_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';
  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    gravando.Texto := 'Excluindo arquivos duplicados REI_CADREI...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE FROM REI_CADREI   ' +
                    '  WHERE REI_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('REI_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;
  End;
end;

procedure TGravandoExecucaoRennerImobiliariaCores.pLimparParametros;
var
  intParam: Integer;
begin
  With qryInsert Do
  Begin
    ParamByName('REI_CODPRO').Value := Null;
    ParamByName('REI_CODEMP').Value := Null;
    ParamByName('REI_DESCOR').Value := Null;
    ParamByName('REI_INGLES').Value := Null;
    ParamByName('REI_ESPANH').Value := Null;
    ParamByName('REI_REFERE').Value := Null;
    ParamByName('REI_DESCRI').Value := Null;
    ParamByName('REI_DTACAD').Value := Null;
    ParamByName('REI_CODBAS').Value := Null;
    ParamByName('REI_UNIDAD').Value := Null;
    ParamByName('REI_CODSEQ').Value := Null;
    ParamByName('AUTOINCREM').Value := Null;
    ParamByName('REI_MD5KEY').Value := Null;

    For intParam := 1 To 20 Do
    Begin
      ParamByName('REI_FORM' + TStrUtils.fStrZero(intParam, 2)).Value := Null;
      ParamByName('REI_QTDC' + TStrUtils.fStrZero(intParam, 2)).Value := Null;
    End;
  End;
end;

end.
