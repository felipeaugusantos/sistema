{* Classe responsável pela geração do cadastro de cores da tinta Duxone2  *}
{**********************************************************************AC*}
unit untGravandoExecucaoDuxone2Cores;

interface

uses
  untAbstractGravandoExecucaoDuxone2, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, XMLDoc, XMLIntf, Variants,
  UniClientDataSet;


type
  TGravandoExecucaoDuxone2Cores = class(TAbstractGravandoExecucaoDuxone2)
  private
    procedure DeleteRegistroCamadas(stlCodigos: TStringList; Const Gravando: IGravando);
    function fQuantidadeBase(strQtdBas: String; strAuxQtd: String; intPosIni, intPosFim: Integer): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    procedure pExcluindoMDDuplicados(const gravando: IGravando);

  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoDuxone2Cores }


procedure TGravandoExecucaoDuxone2Cores.DeleteRegistroCamadas(
  stlCodigos: TStringList; Const Gravando: IGravando);
Var
  qryGen: IDataSet;
  intCont: Integer;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    Gravando.Texto := 'Excluindo registros com códigos semelhantes as bases não geradas...';

    For intCont := 0 TO stlCodigos.Count - 1 Do
    Begin
      qryGen.Close;
      qryGen.SQL := '   DELETE FROM DU2_CADDU2 WHERE DU2_CODDU2 = "' + stlCodigos[intCont] + '"   ';
      qryGen.ExecSQL;

      Gravando.RegistrarProgresso(0, intCont + 1, stlCodigos.Count);
    End;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoDuxone2Cores.Executar(const gravando: IGravando);
Var
  stlFormulas: TStringList;
  txtArq     : TextFile;

  qryAux     : IDataSet;
  qryCadCor  : IDataSet;
  qryCadDel  : IDataSet;

  strCodigo  : String;
  strPatDux  : String;
  strLinha   : String;
  strLin     : String;
  strCodBas  : String;
  strQtdBas  : String;
  strDtaCad  : String;

  strAuxQtd  : String;

  intCodSeq  : Integer;
  intLinha   : Integer;
  intContador: Integer;
  intPosIni  : Integer;
  intPosFim  : Integer;
  strMd5Formulacao : String;
  stlCodigos : TStringList;
begin

  Try
    Try
      gravando.RegistrarProgresso(0, 0, 0);

      gravando.Texto := 'Validando Path de Arquivos ...';

      strPatDux := GetPath;

      If (Not FileExists(strPatDux)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de cores não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';


      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Excluindo os registros...';

      qryCadDel := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadDel.Close;
      qryCadDel.SQL  := 'DELETE FROM DU2_CADDU2';
      qryCadDel.ExecSql;


      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DU2_CADDU2');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      stlFormulas := TStringList.Create;
      stlCodigos := TStringList.Create();
      AssignFile(txtArq, strPatDux);
      Reset(txtArq);

      If gravando.Status <> sgGravando Then
        Exit;

      While not Eof (txtArq) do
      begin
        ReadLn(txtArq, strLin);
        stlFormulas.Add(strLin);
      end;

      CloseFile (txtArq);

      intLinha := 0;

      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCor.Close;


      qryAux := TAutcomTintaFactory.Get.fGetDataSet;

      intCodSeq := 0;

      While (intLinha < stlFormulas.Count) Do
      Begin
        Try
          If gravando.Status <> sgGravando Then
            Exit;

          strLinha := stlFormulas[intLinha];

          Inc(intLinha);


          strCodigo := Trim(fRetCampoBas('CODIGO',intLinha,strLinha));

          If TStrUtils.fEmptyStr(strCodigo) Then
            Continue;

          Inc(intCodSeq);

          strDtaCad := Trim(Copy(strLinha, 211, 15));

          qryCadCor.SQL := TAutcomTintaFactory.Get.GetInsert('DU2_CADDU2');
          qryCadCor.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DU2_CADDU2', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCor.ParamByName('DU2_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCor.ParamByName('DU2_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
          qryCadCor.ParamByName('DU2_DTACAD').AsString := fRetDataCadastro(strDtaCad);
          qryCadCor.ParamByName('DU2_CODDU2').AsString := strCodigo;
          qryCadCor.ParamByName('DU2_CODOEM').AsString := Trim(fRetCampoBas('CODOEM',intLinha,strLinha));
          qryCadCor.ParamByName('DU2_DESCRI').AsString := Trim(fRetCampoBas('DESCRI',intLinha,strLinha));
          qryCadCor.ParamByName('DU2_LINHA_').AsString := UpperCase(fRetCampoBas('LINHA_', 1,strLinha));
          qryCadCor.ParamByName('DU2_QUALID').AsString := Trim(fRetCampoBas('QUALID',intLinha,strLinha));
          qryCadCor.ParamByName('DU2_ALTERN').AsString := fRetCampoBas('ALTERN',intLinha,strLinha);
          qryCadCor.ParamByName('DU2_REGIAO').AsString := Trim(fRetCampoBas('PAIS',intLinha,strLinha));
          qryCadCor.ParamByName('DU2_MONTAD').AsString := Trim(fRetCampoBas('MONTAD',intLinha,strLinha));
          qryCadCor.ParamByName('DU2_ANOCOR').AsString := Trim(fRetCampoBas('ANOINI',intLinha,strLinha));
          qryCadCor.ParamByName('DU2_LITRAG').AsFloat := 1000;


          strMd5Formulacao := '';

          For intContador := 1 To 20 Do
          Begin
            strCodBas := fRetCampoBas('CODBAS',intContador,strLinha);
            strQtdBas := fRetCampoBas('DESBAS',intContador ,strLinha);

            intPosIni := fRetornarStringPosition(fRetCampoBas('DESBAS',intContador,strLinha));
            intPosFim := Length(strQtdBas);

            strAuxQtd := Copy(strQtdBas,intPosIni-1, 1);

            strQtdBas := fQuantidadeBase(strQtdBas, strAuxQtd, intPosIni, intPosFim);

            intPosIni := fRetornarStringPosition(strQtdBas);
            intPosFim := Length(strQtdBas);

            strQtdBas := fQuantidadeBase(strQtdBas, strAuxQtd, intPosIni, intPosFim);


            If fIgnorarBase(strCodBas) Then
            Begin
              stlCodigos.Add(strCodigo);
              Break;
            End;

            If TStrUtils.fEmptyStr(strCodBas) Then
              Break;

            qryCadCor.ParamByName('DU2_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := strCodBas;

            strMd5Formulacao := strMd5Formulacao + strCodBas;

            qryCadCor.ParamByName('DU2_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(strQtdBas,'.',','));

            strMd5Formulacao := strMd5Formulacao + strQtdBas;

            qryCadCor.ParamByName('DU2_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'B';
          End;

          qryCadCor.ParamByName('DU2_MD5KEY').AsString := GetMD5(qryCadCor.ParamByName('DU2_CODDU2').AsString + qryCadCor.ParamByName('DU2_ALTERN').AsString +
                                                                 qryCadCor.ParamByName('DU2_CODOEM').AsString + qryCadCor.ParamByName('DU2_DESCRI').AsString +
                                                                 qryCadCor.ParamByName('DU2_REGIAO').AsString + qryCadCor.ParamByName('DU2_LITRAG').AsString +
                                                                 qryCadCor.ParamByName('DU2_LINHA_').AsString + strMd5Formulacao);
          qryCadCor.ExecSQL;

          gravando.RegistrarProgresso(0, intLinha, stlFormulas.Count);
        Except
          Continue;
        End;
      End;

      DeleteRegistroCamadas(stlCodigos, Gravando);

      gravando.Texto := 'Excluindo as fórmulas duplicadas...';
      pExcluindoMDDuplicados(gravando);

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;

  Finally
    FreeAndNil(stlFormulas);
    FreeAndNil(stlCodigos);
  End;

end;


function TGravandoExecucaoDuxone2Cores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoDuxone2Cores.fQuantidadeBase(strQtdBas: String; strAuxQtd: String;
  intPosIni, intPosFim: Integer): String;
begin
  If Pos('.', strAuxQtd) > 0 Then
  Begin
    If Pos(',', strQtdBas) > 0 Then
      Result := strQtdBas
    Else
      Result := '0,' + Copy(strQtdBas,intPosIni, intPosFim);
  End
  Else If Pos('2K', strQtdBas) > 0 Then
    Result := Copy(strQtdBas, intPosIni + 1, intPosFim)
  Else
    Result := Copy(strQtdBas,intPosIni, intPosFim);
end;

procedure TGravandoExecucaoDuxone2Cores.pExcluindoMDDuplicados(
  const gravando: IGravando);
var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        DU2_MD5KEY       ' +
                '   FROM DU2_CADDU2       ' +
                '  GROUP BY DU2_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';
  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    gravando.Texto := 'Excluindo arquivos duplicados DU2_CADDU2...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM DU2_CADDU2 ' +
                    '  WHERE DU2_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('DU2_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;

  End;

end;

end.
