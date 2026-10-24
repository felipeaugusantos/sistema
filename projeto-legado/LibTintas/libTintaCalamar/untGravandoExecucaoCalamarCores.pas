{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Calamar *}
{**********************************************************************PH*}
unit untGravandoExecucaoCalamarCores;

interface

uses
  untAbstractGravandoExecucaoCalamar, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoCalamarCores = class(TAbstractGravandoExecucaoCalamar)
  private
   qryCadCal: IDataSet;
   qryEmbalagens, qryColorantes, qryBases: TADODataSet;
   qryAdoCores: TADOQuery;
   function GetBases(): TDataSet;
   function GetColorantes(): TDataSet;
   function GetEmbalagems(): TDataSet;
   procedure pDeletarCores();
   procedure CarregarDadosKey(strPath:String; gravando: IGravando; qryKey: TDataSet);
   procedure GravarCores(strPath:String; gravando: IGravando; qryFormula, qryKey: TDataSet);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils;

{ TGravandoExecucaoCalamarCores }

procedure TGravandoExecucaoCalamarCores.CarregarDadosKey(strPath:String; gravando: IGravando; qryKey: TDataSet);
var
  strNomeArquivo: String;
  qryFormulasCores: TADODataSet;
begin
  While Not (qryKey.Eof) And (Gravando.Status = sgGravando) Do
  Begin
    qryFormulasCores := Nil;
    Try
      Try
        strNomeArquivo := strPath + '\' + qryKey.FieldByName('PATH').AsString + '\Formulas.mdb';
        Gravando.texto := Format('Processando arquivo [%s]', [strNomeArquivo]);
        qryFormulasCores := GetDataSetCalamar(strNomeArquivo);
        qryFormulasCores.CommandType := cmdTable;
        qryFormulasCores.CommandText := 'Formulas';
        qryFormulasCores.Open;
        GravarCores(strPath + '\' + qryKey.FieldByName('PATH').AsString, gravando, qryFormulasCores, qryKey);

      Except
        On E: Exception Do
        Begin
          Gravando.Texto := Format('%s [%s]',
            [qryKey.FieldByName('DESCRIPTION').AsString,
            E.Message]);
        End;
      End;
    Finally
      If Assigned(qryFormulasCores) Then
        FreeAndNil(qryFormulasCores);
      qryKey.Next;
    End;
  End;
end;

procedure TGravandoExecucaoCalamarCores.pDeletarCores;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   DELETE FROM CAL_CADCAL    ';
    qryGen.ExecSQL;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoCalamarCores.Executar(const gravando: IGravando);
var
  strNomeArquivo: String;
  qryPath: TADODataSet;
begin
  Try
    Try
      Gravando.Texto := 'Validando path do arquivo...';

      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe',
          [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      Gravando.Texto := 'Path validado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados do Cadastro de Cores...';

      qryAdoCores := TADOQuery.Create(Nil);
      qryAdoCores.Connection := fConexaoCalamar(GetPath);
      qryAdoCores.SQL.Add('     SELECT * FROM SF      ');
      qryAdoCores.Open;

      Gravando.Texto := 'Deletando Cadastro de Cores...';
      qryCadCal := TAutcomTintaFactory.Get.fGetDataSet;
      pDeletarCores;
      Gravando.Texto := 'Cadastro de Cores deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CAL_CADCAL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Abrindo Cadastro de Cores...';
      qryCadCal.SQL := '    SELECT * FROM CAL_CADCAL    ';
      qryCadCal.Open;



      Try
        While Not qryAdoCores.Eof Do
        Begin
          qryPath := Nil;

          If TStrUtils.fEmptyStr(qryAdoCores.FieldByName('PATH').AsString) Then
            Break;

          strNomeArquivo := ExtractFilePath(GetPath) + qryAdoCores.FieldByName('PATH').AsString + '\Key.mdb';
          qryPath := GetDataSetCalamar(strNomeArquivo);
          qryPath.CommandType := cmdTable;
          qryPath.CommandText := 'SF';
          qryPath.Open;
          Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(strNomeArquivo, '"', '')]);
          CarregarDadosKey(ExtractFilePath(GetPath) +  qryAdoCores.FieldByName('PATH').AsString, gravando, qryPath);
          qryAdoCores.Next;
        End;
      Except
        Raise;
      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s',[E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryPath) Then
      FreeAndNil(qryPath);

  End;
end;

function TGravandoExecucaoCalamarCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoCalamarCores.GetBases: TDataSet;
begin
  If Not Assigned(qryBases) Then
  Begin
    qryBases := Nil;
    qryBases := GetDataSetCalamar(GetPath);
    TADODataSet(qryBases).CommandType := cmdTable;
    TADODataSet(qryBases).CommandText := 'BASES';
    qryBases.Open;
    TADODataSet(qryBases).IndexFieldNames := 'ID';
  End;

  Result := qryBases;
end;

function TGravandoExecucaoCalamarCores.GetColorantes: TDataSet;
begin
  If Not Assigned(qryColorantes) Then
  Begin
    qryColorantes := Nil;
    qryColorantes := GetDataSetCalamar(GetPath);
    TADODataSet(qryColorantes).CommandType := cmdTable;
    TADODataSet(qryColorantes).CommandText := 'COMPONENTS';
    qryColorantes.Open;
    TADODataSet(qryColorantes).IndexFieldNames := 'ID';
  End;

  Result := qryColorantes;
end;

function TGravandoExecucaoCalamarCores.GetEmbalagems: TDataSet;
begin
  If Not Assigned(qryEmbalagens) Then
  Begin
    qryEmbalagens := Nil;
    qryEmbalagens := GetDataSetCalamar(GetPath);
    TADODataSet(qryEmbalagens).CommandType := cmdTable;
    TADODataSet(qryEmbalagens).CommandText := 'CANS';
    qryEmbalagens.Open;
    TADODataSet(qryEmbalagens).IndexFieldNames := 'ID';
  End;

  Result := qryEmbalagens;
end;

procedure TGravandoExecucaoCalamarCores.GravarCores(strPath: String;
  gravando: IGravando; qryFormula, qryKey: TDataSet);
var
  stlFormula: TStringList;
  fltCapacidadeEmbalagemOriginal: Double;
  intContador : Integer;
begin

  Try
    Try
      stlFormula := TStringList.Create;
      While Not (qryFormula.Eof) And (Gravando.Status = sgGravando) Do
      Begin
        Try
          Try

            If Not GetBases.Locate('ID', qryFormula.FieldByName('BASE_ID').AsString, []) Then
              Continue;

        //    If Not GetEmbalagems.Locate('ID', qryFormula.FieldByName('CAN_ID').AsString, []) Then
          //    Continue;

            fltCapacidadeEmbalagemOriginal := GetEmbalagems.FieldByName('CAPACITY').AsFloat;

            GetEmbalagems.First;

            While Not GetEmbalagems.Eof Do
            Begin

              If (gravando.Status <> sgGravando) Then
                Break;

              qryCadCal.SQL := TAutcomTintaFactory.Get.GetInsert('CAL_CADCAL');
              qryCadCal.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CAL_CADCAL', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadCal.ParamByName('CAL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadCal.ParamByName('CAL_CODBAS').AsString := GetBases.FieldByName('CODE').AsString;
              qryCadCal.ParamByName('CAL_CODEMB').AsString := TStrUtils.fStrZero(GetEmbalagems.FieldByName('ID').AsString, 3);
              qryCadCal.ParamByName('CAL_KEY1__').AsString := qryFormula.FieldByName('KEY1').AsString;
              qryCadCal.ParamByName('CAL_KEY2__').AsString := qryFormula.FieldByName('KEY2').AsString;
              qryCadCal.ParamByName('CAL_KEY3__').AsString := qryFormula.FieldByName('KEY3').AsString;
              qryCadCal.ParamByName('CAL_PRODUT').AsString := qryAdoCores.FieldByName('DESCRIPTION').AsString;
              qryCadCal.ParamByName('CAL_COLECA').AsString := qryKey.FieldByName('DESCRIPTION').AsString;
              qryCadCal.ParamByName('CAL_ATIVAD').AsString := 'S';

              stlFormula.Clear;

              If ExtractStrings([';'], [], PWideChar(qryFormula.FieldByName('FORMULA').AsString), stlFormula) <= 0 Then
                Exit;

               For intContador := 1 To stlFormula.Count Div 2 Do
               Begin
                 GetColorantes.Locate('ID', stlFormula[(intContador * 2)- 2], []);
                 qryCadCal.ParamByName('CAL_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString := GetColorantes.FieldByName('CODE').AsString;
                 qryCadCal.ParamByName('CAL_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := (3.0729839993857053122643682646301) *
                   TAutcomTintaFactory.Get.fStrToFloat(StringReplace(stlFormula[(intContador * 2) -1], '.' , ',' , [rfReplaceAll])) *
                     GetEmbalagems.FieldByName('CAPACITY').AsFloat / fltCapacidadeEmbalagemOriginal;
               End;

              qryCadCal.ParamByName('CAL_MD5KEY').AsString := GetMd5(qryCadCal.ParamByName('CAL_CODBAS').AsString +
                                                                     qryCadCal.ParamByName('CAL_CODEMB').AsString +
                                                                     qryCadCal.ParamByName('CAL_KEY1__').AsString +
                                                                     qryCadCal.ParamByName('CAL_KEY2__').AsString +
                                                                     qryCadCal.ParamByName('CAL_KEY3__').AsString +
                                                                     qryCadCal.ParamByName('CAL_PRODUT').AsString +
                                                                     qryCadCal.ParamByName('CAL_COLECA').AsString);

              qryCadCal.ExecSQL;
              GetEmbalagems.Next;
            End;
          Except
            On E: Exception Do
            Begin
              gravando.Texto := Format('%s - %s - %s - %s - %s,[%s: %s]', [
              qryAdoCores.FieldByName('DESCRIPTION').AsString,
              qryKey.FieldByName('DESCRIPTION').AsString,
              qryFormula.FieldByName('Key1').AsString,
              qryFormula.FieldByName('Key2').AsString,
              qryFormula.FieldByName('Key3').AsString,
              E.ClassName, E.Message]);
            End;
          End;
        Finally
          gravando.RegistrarProgresso(0, qryFormula.RecNo, qryFormula.RecordCount);
          qryFormula.Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;

    End;
  Finally
    If Assigned(stlFormula) Then
      FreeAndNil(stlFormula);
  End;

end;

end.
