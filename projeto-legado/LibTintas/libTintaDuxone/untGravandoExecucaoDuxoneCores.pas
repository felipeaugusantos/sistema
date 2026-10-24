{* Classe responsável pela geração do cadastro de cores da tinta Duxone  *}
{**********************************************************************AC*}
unit untGravandoExecucaoDuxoneCores;

interface

uses
  untAbstractGravandoExecucaoDuxone, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, XMLDoc, XMLIntf, Variants,
  UniClientDataSet;


type
  TGravandoExecucaoDuxoneCores = class(TAbstractGravandoExecucaoDuxone)
  private
    procedure DeleteRegistroCamadas(stlCodigos: TStringList; Const Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    procedure pExcluindoMDDuplicados(const gravando: IGravando);

  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoDuxoneCores }


procedure TGravandoExecucaoDuxoneCores.DeleteRegistroCamadas(
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
      qryGen.SQL := '   DELETE FROM DUX_CADDUX WHERE DUX_CODDUX = "' + stlCodigos[intCont] + '"   ';
      qryGen.ExecSQL;

      Gravando.RegistrarProgresso(0, intCont + 1, stlCodigos.Count);
    End;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoDuxoneCores.Executar(const gravando: IGravando);
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
  intAux     : Integer;
  intPosIni  : Integer;
  intPosFim  : Integer;
  strMd5Formulacao : String;
  stlCodigos : TStringList;
begin

  Try

    Try
      if gravando.Status <> sgGravando then
        Exit;

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
      qryCadDel.SQL  := 'DELETE FROM DUX_CADDUX';
      qryCadDel.ExecSql;


      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DUX_CADDUX');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      stlFormulas := TStringList.Create;
      stlCodigos := TStringList.Create();
      AssignFile(txtArq, strPatDux);
      Reset(txtArq);

      if gravando.Status <> sgGravando then
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
      qryCadCor.SQL  := 'SELECT * '+
                        '  FROM DUX_CADDUX'+
                        ' WHERE FALSE; ';
      qryCadCor.Open;


      qryAux := TAutcomTintaFactory.Get.fGetDataSet;

      intCodSeq := 0;

      While (intLinha < stlFormulas.Count) Do
      Begin
        Try
          if gravando.Status <> sgGravando then
            Exit;

          intAux := 0;

          strLinha := stlFormulas[intLinha];

          Inc(intLinha);

          While intAux <= 1 Do
          begin

            if gravando.Status <> sgGravando then
              Exit;

            strCodigo := Trim(fRetCampoBas('CODIGO',intLinha,strLinha));

            if TStrUtils.fEmptyStr(strCodigo) Then
              Continue;

            Inc(intCodSeq);

            strDtaCad := Trim(Copy(strLinha, 211, 15));

            qryCadCor.Insert;
            qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DUX_CADDUX', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCor.FieldByName('DUX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCor.FieldByName('DUX_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
            qryCadCor.FieldByName('DUX_DTACAD').AsString := fRetDataCadastro(strDtaCad);
            qryCadCor.FieldByName('DUX_CODDUX').AsString := strCodigo;
            qryCadCor.FieldByName('DUX_CODOEM').AsString := Trim(fRetCampoBas('CODOEM',intLinha,strLinha));
            qryCadCor.FieldByName('DUX_DESCRI').AsString := Trim(fRetCampoBas('DESCRI',intLinha,strLinha)) + ' '+ TAutcomTintaFactory.Get.IIF(intAux = 0, 'CONCENTRADO', 'DILUÍDO') ;
            qryCadCor.FieldByName('DUX_LINHA_').AsString := UpperCase(fRetCampoBas('LINHA_', 1,strLinha));
            qryCadCor.FieldByName('DUX_QUALID').AsString := Trim(fRetCampoBas('QUALID',intLinha,strLinha));
            qryCadCor.FieldByName('DUX_ALTERN').AsString := fRetCampoBas('ALTERN',intLinha,strLinha);
            qryCadCor.FieldByName('DUX_REGIAO').AsString := Trim(fRetCampoBas('PAIS',intLinha,strLinha));
            qryCadCor.FieldByName('DUX_MONTAD').AsString := Trim(fRetCampoBas('MONTAD',intLinha,strLinha));
            qryCadCor.FieldByName('DUX_ANOCOR').AsString := Trim(fRetCampoBas('ANOINI',intLinha,strLinha));

            If Conf.fGet('GERDIL') = '2' Then
              qryCadCor.FieldByName('DUX_LITRAG').AsFloat := TAutcomTintaFactory.Get.IIF(intAux = 0, 1000, 2000)
            Else
              qryCadCor.FieldByName('DUX_LITRAG').AsFloat  := TAutcomTintaFactory.Get.IIF(intAux = 0, 1000, 1800);

            strMd5Formulacao := '';

            For intContador := 1 To 20 Do
            Begin
              strCodBas := fRetCampoBas('CODBAS',intContador,strLinha);
              strQtdBas := fRetCampoBas('DESBAS',intContador ,strLinha);

              intPosIni := fRetornarStringPosition(fRetCampoBas('DESBAS',intContador,strLinha));
              intPosFim := Length(strQtdBas);

              strAuxQtd := Copy(strQtdBas,intPosIni-1, 1);

              If Pos( '.', strAuxQtd) > 0 Then
                strQtdBas := '0,' + Copy(strQtdBas,intPosIni, intPosFim)
              else
                strQtdBas := Copy(strQtdBas,intPosIni, intPosFim);

              If fIgnorarBase(strCodBas) Then
              Begin
                stlCodigos.Add(strCodigo);
                Break;
              End;

              if Not TStrUtils.fEmptyStr(strCodBas) Then
              begin
                qryCadCor.FieldByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := strCodBas;

                strMd5Formulacao := strMd5Formulacao + strCodBas;

                If intAux = 0 Then
                  qryCadCor.FieldByName('DUX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(strQtdBas,'.',','))
                else
                  qryCadCor.FieldByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(strQtdBas,'.',','));

                strMd5Formulacao := strMd5Formulacao + strQtdBas;

                qryCadCor.FieldByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'B';
              end
              else
              If intAux > 0 Then
              begin

                qryCadCor.FieldByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := 'DX32';
                qryCadCor.FieldByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'D';

                If Conf.fGet('GERDIL') = '2' Then
                  qryCadCor.FieldByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 880.00
                Else
                  qryCadCor.FieldByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 704.00;

                Break;
              end
              else
                Break;
            End;

            If fIgnorarBase(strCodBas) Then
            begin
              Inc(intAux);
              Continue;
            end;


            qryCadCor.FieldByName('DUX_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('DUX_CODDUX').AsString + qryCadCor.FieldByName('DUX_ALTERN').AsString +
                                                                   qryCadCor.FieldByName('DUX_CODOEM').AsString + qryCadCor.FieldByName('DUX_DESCRI').AsString +
                                                                   qryCadCor.FieldByName('DUX_REGIAO').AsString + qryCadCor.FieldByName('DUX_LITRAG').AsString +
                                                                   qryCadCor.FieldByName('DUX_LINHA_').AsString + strMd5Formulacao);
            qryCadCor.Post;

            Inc(intAux);
          End;

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
    If Assigned(stlFormulas) Then
      FreeAndNil(stlFormulas);

    If Assigned(stlCodigos) Then
      FreeAndNil(stlCodigos);
  End;

end;


function TGravandoExecucaoDuxoneCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

procedure TGravandoExecucaoDuxoneCores.pExcluindoMDDuplicados(
  const gravando: IGravando);
var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        DUX_MD5KEY       ' +
                '   FROM DUX_CADDUX       ' +
                '  GROUP BY DUX_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';
  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    gravando.Texto := 'Excluindo arquivos duplicados DUX_CADDUX...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM DUX_CADDUX ' +
                    '  WHERE DUX_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('DUX_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;

  End;

end;

end.
