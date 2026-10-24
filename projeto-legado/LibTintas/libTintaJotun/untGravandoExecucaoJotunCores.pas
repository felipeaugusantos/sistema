{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Jotun *}
{**********************************************************************PH*}
unit untGravandoExecucaoJotunCores;

interface

uses
  untAbstractGravandoExecucaoJotun, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  ADODB, Dialogs, Classes, untFloatUtils, Variants;



type
  TGravandoExecucaoJotunCores = class(TAbstractGravandoExecucaoJotun)
  public
    function fRetFatorQuantidade(fltVolume: Double): Double;
    function fRetUnidade(fltVolume: Double): String;
  public
    function fGetNomeGravacao: string; override;

    procedure Executar(const gravando: IGravando); override;

    procedure pGerarColorantes(strFormula : String);
    procedure pLimparVetores;
      Var arrCodColorantes: Array [0..5] Of String;
      Var arrQtdColorantes: Array [0..5] Of Double;
    procedure pAcertarMd5Key(const Gravando: IGravando);

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoJotunCores }

procedure TGravandoExecucaoJotunCores.pAcertarMd5Key(const Gravando: IGravando);
Var
  qryDelete : IDataSet;
  qryCadJot : IDataSet;
  intLimit  : Integer;
begin

  qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadJot := TAutcomTintaFactory.Get.fGetDataSet;

  qryCadJot.SQl := 'SELECT COUNT(*) QTD  '+
                   '     , JOT_MD5KEY    '+
                   '  FROM JOT_CADJOT    '+
                   ' GROUP BY JOT_MD5KEY '+
                   'HAVING COUNT(*) > 1  ';
  qryCadJot.Open;

  qryCadJot.First;

  Gravando.Texto := 'Deletando formulas duplicadas...';

  While Not qryCadJot.Eof Do
  Begin
    intLimit := (qryCadJot.FieldByName('QTD').AsInteger - 1);

    qryDelete.SQL := 'DELETE                      '+
                     '  FROM JOT_CADJOT           '+
                     ' WHERE JOT_MD5KEY = :MD5KEY '+
                     '   LIMIT '+IntToStr(IntLimit)+' ';
    qryDelete.ParamByName('MD5KEY').AsString := qryCadJot.FieldByName('JOT_MD5KEY').AsString;

    qryDelete.ExecSQL;

    Gravando.RegistrarProgresso(0, qryCadJot.RecNo, qryCadJot.RecordCount);

    qryCadJot.Next;
  End;

  qryDelete.SQL := ' DELETE FROM JOT_CADJOT '+
                   '  WHERE ((JOT_DESCRI LIKE ''%200%'') '+
                   '     OR (JOT_QTDB01 = "0"))';
  qryDelete.ExecSQL;
end;


procedure TGravandoExecucaoJotunCores.pGerarColorantes(strFormula: String);
var
  strList: TStringList;
  intCont: integer;
  strAux : String;
begin
  pLimparVetores;

  strList := TStringList.Create;

  try
    strList.Delimiter := ',';

    strList.StrictDelimiter := True;
    strList.DelimitedText   := strFormula;

    intCont := 0;

    While (intCont < strList.Count) Do
    Begin
      If TStrUtils.fEmptyStr(strList[intCont]) Or (strFormula = 'Formula') Then
        Exit;

      strAux := Copy(Trim(strList[intCont]),1,2);
      arrCodColorantes[intCont] := strAux;

      strAux := Copy(Trim(strList[intCont]),3,length(strList[intCont]));
      arrQtdColorantes[intCont] := strToFloat(StringReplace(strAux,'.',',',[rfReplaceAll]));

      Inc(intCont);
    End;

  Finally
    FreeAndNil(strList);
  End;
end;

procedure TGravandoExecucaoJotunCores.pLimparVetores;
Var
  intCont : Integer;
begin
  For intCont := 0 To 5 Do
  Begin
    arrCodColorantes[intCont] := '';
    arrQtdColorantes[intCont] := 0;
  End;
end;

procedure TGravandoExecucaoJotunCores.Executar(const gravando: IGravando);
Var
  qryDestino   : IDataSet;
  qryBases     : IDataSet;
  Planilha     : OleVariant;
  Sheet        : OleVariant;
  iRecordCount : Integer;
  iContador    : Integer;
  iRegistro    : Integer;
  iArquivo     : Integer;
  iQuantidades : Integer;
  strPath      : String;
  fltFator     : Double;
  strMd5       : String;
begin
  Try
    Try
      Gravando.Texto := 'Validando Path de Arquivos ...';

      iArquivo := fRetIntArquivo('Formulations');

      strPath := GetPath + '\' + slArquivos[iArquivo];

      If (Not FileExists(strPath)) Then
      Begin
        Gravando.Texto := 'Path para o geração do arquivo de cores não é válido ...';
        Gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Path validado com sucesso ...';
      Gravando.Texto := 'Excluído os registros da tabela JOT_CADJOT ...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'DELETE FROM JOT_CADJOT';
      qryDestino.ExecSQL;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('JOT_CADJOT', false);
      Gravando.Texto := 'PROCOD verificado com sucesso!';

      qryBases := TAutcomTintaFactory.Get.fGetDataSet;
      qryBases.Close;
      qryBases.SQL := ' SELECT * FROM JOT_CADBAS  ';
      qryBases.Open;

      If qryBases.IsEmpty Then
      Begin
        Gravando.Texto := 'Deve gerar o cadastro de bases antes de continuar com o cadastro de cores...';
        Exit;
      End;

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(strPath);

      For iContador := 1 To Planilha.WorkBooks[1].WorkSheets.Count Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Carregando Arquivo: ' + Planilha.WorkBooks[1].WorkSheets[iContador].Name;
        Sheet := Planilha.WorkBooks[1].WorkSheets[iContador];
        Gravando.Texto := 'Iniciando Arquivo: ' + Planilha.WorkBooks[1].WorkSheets[iContador].Name;

        iRecordCount := Sheet.Cells.SpecialCells(11).Row;
        iRegistro := 2;

        Gravando.RegistrarProgresso(0, 0, 0); //Zerando Progresso

        Try
          Try
            While (iRegistro <= iRecordCount) Do
            Begin
              If (Gravando.Status <> sgGravando) Then
                Break;

              qryBases.Close;
              qryBases.SQL := ' SELECT * '+
                              '   FROM JOT_CADBAS '+
                              '  WHERE BAS_CODBAS = :CODBAS '+
                              '    AND BAS_TIPO__ = :TIPO__ ';
              qryBases.ParamByName('CODBAS').AsString := UpperCase(Sheet.cells[iRegistro, 5].Text);
              qryBases.ParamByName('TIPO__').AsString := Trim(UpperCase(Copy(Planilha.WorkBooks[1].WorkSheets[iContador].Name, 1, Pos('-', Planilha.WorkBooks[1].WorkSheets[iContador].Name) - 1)));
              qryBases.Open;
              qryBases.First;

              While Not qryBases.Eof Do
              Begin
                qryDestino.SQL := 'SELECT * '+
                                  '  FROM JOT_CADJOT '+
                                  ' WHERE JOT_BASE__ = :BASE__ '+
                                  '   AND JOT_TIPO__ = :TIPO__ '+
                                  '   AND JOT_DESCRI = :DESCRI '+
                                  '   AND JOT_NOMCOR = :NOMCOR '+
                                  '   AND JOT_EMBALA = :EMBALA '+
                                  '   AND JOT_REFERE = :REFERE ';

                qryDestino.ParamByName('BASE__').AsString := qryBases.FieldByName('BAS_CODBAS').AsString;
                qryDestino.ParamByName('TIPO__').AsString := qryBases.FieldByName('BAS_TIPO__').AsString;
                qryDestino.ParamByName('EMBALA').AsString := qryBases.FieldByName('BAS_EMBALA').AsString;
                qryDestino.ParamByName('DESCRI').AsString := UpperCase(Planilha.WorkBooks[1].WorkSheets[iContador].Name + ' - ' + qryBases.FieldByName('BAS_DESCRI').AsString);
                qryDestino.ParamByName('NOMCOR').AsString := UpperCase(Sheet.cells[iRegistro, 3].Text);
                qryDestino.ParamByName('REFERE').AsString := UpperCase(Sheet.cells[iRegistro, 2].Text);
                qryDestino.Open;

                If (qryDestino.IsEmpty) And (Not TStrUtils.fEmptyStr(Sheet.cells[iRegistro, 1].Text)) Then
                Begin
                  qryDestino.Insert;
                  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('JOT_CADJOT', TAutcomTintaFactory.Get.GetCodEmp);
                  qryDestino.FieldByName('JOT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                  qryDestino.FieldByName('JOT_BASE__').AsString := qryBases.FieldByName('BAS_CODBAS').AsString;
                  qryDestino.FieldByName('JOT_TIPO__').AsString := qryBases.FieldByName('BAS_TIPO__').AsString;
                  qryDestino.FieldByName('JOT_DESCRI').AsString := UpperCase(Planilha.WorkBooks[1].WorkSheets[iContador].Name + ' - ' + qryBases.FieldByName('BAS_DESCRI').AsString);
                  qryDestino.FieldByName('JOT_NOMCOR').AsString := UpperCase(Sheet.cells[iRegistro, 3].Text);
                  qryDestino.FieldByName('JOT_REFERE').AsString := UpperCase(Sheet.cells[iRegistro, 2].Text);
                  qryDestino.FieldByName('JOT_DTACAD').AsDate   := Date;
                  qryDestino.FieldByName('JOT_EMBALA').AsFloat := qryBases.FieldByName('BAS_EMBALA').AsFloat;

                  strMd5 := '';

                  strMd5 := strMd5 + qryDestino.FieldByName('JOT_DESCRI').AsString;
                  strMd5 := strMd5 + qryDestino.FieldByName('JOT_REFERE').AsString;
                  strMd5 := strMd5 + qryDestino.FieldByName('JOT_NOMCOR').AsString;
                  strMd5 := strMd5 + qryDestino.FieldByName('JOT_TIPO__').AsString;
                  strMd5 := strMd5 + qryDestino.FieldByName('JOT_BASE__').AsString;
                  strMd5 := strMd5 + qryDestino.FieldByName('JOT_CODUNI').AsString;

                  fltFator := fRetFatorQuantidade(qryDestino.FieldByName('JOT_EMBALA').AsFloat);

                  qryDestino.FieldByName('JOT_CODUNI').AsString := fRetUnidade(fltFator);
                  pGerarColorantes(Sheet.cells[iRegistro, 1].Text);

                  For iQuantidades := 1 To 6 Do
                  Begin
                    qryDestino.FieldByName('JOT_FORM' + TStrUtils.fStrZero(iQuantidades, 2)).AsString := arrCodColorantes[iQuantidades - 1];
                    qryDestino.FieldByName('JOT_QTDB' + TStrUtils.fStrZero(iQuantidades, 2)).AsFloat  := TAutcomTintaFactory.Get.fFormataFloat(arrQtdColorantes[iQuantidades -1] * fltFator, 1);

                    strMd5 := strMd5 + qryDestino.FieldByName('JOT_FORM' + TStrUtils.fStrZero(IntToStr(iQuantidades), 2)).AsString;
                    strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', TAutcomTintaFactory.Get.fFormataFloat(qryDestino.FieldByName('JOT_QTDB' + TStrUtils.fStrZero(IntToStr(iQuantidades), 2)).AsFloat, 1)),
                      ',', '.', [rfReplaceAll]);
                  End;

                  qryDestino.FieldByName('JOT_MD5KEY').AsString := GetMD5(strMd5);

                  qryDestino.Post;
                End;
                qryBases.Next;
              End;
              Inc(iRegistro);
              Gravando.RegistrarProgresso(0, iRegistro, iRecordCount);
            End;
          Except
            On E: Exception Do
            Begin
              Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              Gravando.Cancelar;
            End;
          End;
        Finally
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
    pAcertarMd5Key(Gravando);
    Planilha.Quit;
    Planilha := Unassigned;
    Sheet := Unassigned;
  End;
end;

function TGravandoExecucaoJotunCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoJotunCores.fRetFatorQuantidade(
  fltVolume: Double): Double;
begin
  If fltVolume <= 3.6 Then
    Result := 3.6
  Else If (fltVolume > 3.6) And (fltVolume <= 5) Then
    Result := 5
  Else
    Result := 20;
end;

function TGravandoExecucaoJotunCores.fRetUnidade(fltVolume: Double): String;
begin
  If fltVolume < 13 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

end.
