{*********************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta SherwinWilliams *}
{******************************************************************************AC*}
unit untGravandoExecucaoSherwinWilliamsCores;

interface

uses
  untAbstractGravandoExecucaoSherwinWilliams, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants;

type
  TGravandoExecucaoSherwinWilliamsCores = class(TAbstractGravandoExecucaoSherwinWilliams)
  private
    qryInsert: IDataSet;
    qryMD5Key: IDataSet;
    function fCriaQueryCores: IDataSet;
    function fCriaQueryMD5KeyComparacao: IDataSet;
    function fGravaCadShe(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColShe: Array of TColShe; strDesTin: String): Boolean;
    function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
    function fExisteMD5Key(strMd5Key: String): Boolean;
    procedure pLimparParametros;
    procedure pAdicionaMD5KeyComparacao(strMd5Key: String);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoSherwinWilliamsCores }

procedure TGravandoExecucaoSherwinWilliamsCores.Executar(const gravando: IGravando);
  Var
    intProducts : Integer;
    intSubProds : Integer;
    intFrm      : Integer;
    intMask     : Integer;
    intPos      : Integer;

    strProKey   : String;
    strPatPro   : String;
    strPatSub   : String;
    strSubKey   : String;
    strBaseSe   : String;
    strEmbCom   : String;
    strFormula  : String;

    arrColShe   : Array Of TColShe;
    strQtdEmb   : String;
    strDesTin   : String;
    intColora   : Integer;
    intCodSeq   : Integer;
    strTYPE     : String;

    qryTrunc    : IDataSet;

    strPatDbf   : String;
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

      If Not fVerificaCadEmb Then
      Begin
        If qrySHE_CADEMB.IsEmpty Then
        Begin
          If TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
            pImportarCadEmb(gravando);
        End
        Else
          gravando.Texto := 'O Cadastro de Embalagem está inconsistente!';

        gravando.Cancelar;
        Exit;
      End;

      If (Not fVerificaCadBas) Then
      Begin
        gravando.Texto := 'O cadastro de bases está inconsistente!';
        gravando.Cancelar;
        Exit;
      End;
{
      If (Not fVerificaCadCol) Then
      Begin
        gravando.Texto := 'O cadastro de colorantes está vazio!';
        gravando.Cancelar;
        Exit;
      End;
}
      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SHE_CADSHE');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
      begin
        pApagandoTemporarias;
        Exit;
      end;

      //Criando a tabela de insert
      qryInsert := fCriaQueryCores;

      //Criando a tabela para armazenar o md5key gerado para comparacao, para
      //nao deixar gravar dois iguais
      qryMD5Key := fCriaQueryMD5KeyComparacao;

      gravando.Texto := 'Limpando a Tabela de Cores ...';

      qryTrunc := TAutcomTintaFactory.Get.fGetDataSet;
      qryTrunc.SQL := 'TRUNCATE TABLE SHE_CADSHE';
      qryTrunc.ExecSQL;

      if gravando.Status <> sgGravando then
      begin
        pApagandoTemporarias;
        Exit;
      end;

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores ...';

      strPatDbf := GetPath;

      intCodSeq := 1;

      Try
        Try

          For intProducts := 1 To tblProducts.RecordCount Do
          Begin

            if gravando.Status <> sgGravando then
            begin
              pApagandoTemporarias;
              Exit;
            end;

            strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString;
            strProKey := TStrUtils.fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);
            pCarregarSubprods(strPatPro);

            If tblSubprods.Active Then
            Begin
              For intSubProds := 1 To tblSubprods.RecordCount Do
              Begin

                if gravando.Status <> sgGravando then
                begin
                  pApagandoTemporarias;
                  Exit;
                end;

                strPatSub := strPatPro + '\' + tblSubprods.FieldByName('PATH').AsString;
                strSubKey := TStrUtils.fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);
                pCarregarFrm(strPatPro, strPatSub, gravando);
                pCarregarMask(strPatSub);

                For intFrm := 1 To tblFrm.RecordCount Do
                Begin

                  if gravando.Status <> sgGravando then
                  begin
                    pApagandoTemporarias;
                    Exit;
                  end;

                  strBaseSe := TStrUtils.fStrZero(Trim(tblFrm.FieldbyName('BASE_ID').AsString), 2);
                  strEmbCom := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

                  strTYPE := fRetBasesMask;

                  tblMask.First;

                  For intMask := 1 To tblMask.RecordCount Do
                  Begin

                    if gravando.Status <> sgGravando then
                    begin
                      pApagandoTemporarias;
                      Exit;
                    end;

                    strFormula := tblFrm.FieldByName('FORMULA').AsString;
                    SetLength(arrColShe, 0);

                    While (Not TStrUtils.fEmptyStr(strFormula)) Do
                    Begin
                      SetLength(arrColShe, Length(arrColShe) + 1);
                      intPos := Pos(',', strFormula);
                      arrColShe[Length(arrColShe) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                      strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                      intPos := Pos(',', strFormula);
                      If intPos <= 0 Then
                        intPos := Length(strFormula)+1;
                      arrColShe[Length(arrColShe) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));

                      {*******************************************}
                      {* FORMULA GEL TEM QUE MULTIPLICAR POR 0.2 *}
                      {****************************************PH*}
                      If (tblProducts.FieldByName('PATH').AsString = 'PROD0005')
                        And (tblSubprods.FieldByName('PATH').AsString = 'SUBP0001') Then
                      Begin
                        arrColShe[Length(arrColShe) - 1].fltQtdCol := arrColShe[Length(arrColShe) - 1].fltQtdCol * 0.2;
                      End;

                      strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                    End;

                    if gravando.Status <> sgGravando then
                    begin
                      pApagandoTemporarias;
                      Exit;
                    end;

                    SetLength(arrColShe, 20);
                    strQtdEmb := TStrUtils.fStrZero(Trim(tblMask.FieldByName('PNT_ID').AsString), 2);

                    If (tblMask.FieldByName('TYPE').AsString = 'CA') Then
                    Begin
                      tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
                      qrySHE_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                      If (Pos(Trim(tblFrm.FieldbyName('BASE_ID').AsString), strTYPE) > 0) Then
                      Begin
                        strDesTin := AnsiUpperCase(
                                      tblFrm.FieldByName('KEY1').AsString + ' ' +
                                      Trim(tblProducts.FieldByName('DESCR').AsString) + ' ' +
                                      Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                                      tblFrm.FieldByName('KEY2').AsString
                                      );
                        For intColora := Low(arrColShe) To High(arrColShe) Do
                        Begin
                          If TStrUtils.fEmptyStr(arrColShe[intColora].strCodCol) Then
                            Break;

                          arrColShe[intColora].fltQtdCol := fCalQtdEmb(arrColShe[intColora].fltQtdCol, strEmbCom, strQtdEmb);
                        End;

                        If fGravaCadShe(intCodSeq, strBaseSe, strProKey, strSubKey, arrColShe, strDesTin) Then
                          Inc(intCodSeq);
                      End;
                    End;
                    tblMask.Next;
                  End;
                  gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);

                  tblFrm.Next;
                End;
                tblSubprods.Next;
              End;
            End;
            tblProducts.Next;
          End;
        Except
          on E: Exception do
          begin
            gravando.Cancelar;
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          End;
        End;
      Finally
        gravando.Texto := 'Finalizado o processo de gravação do arquivo...';
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    pApagandoTemporarias;
  End;
end;

function TGravandoExecucaoSherwinWilliamsCores.fCalQtdEmb(fltQtdCol: Double;
  strEmbCon, strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}
  qrySHE_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qrySHE_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

function TGravandoExecucaoSherwinWilliamsCores.fCriaQueryCores: IDataSet;
var
  intForm: Integer;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL :=             ' INSERT INTO SHE_CADSHE  ' +

                            '           (SHE_CODSEQ,  ' +
                            '            SHE_DESCRI,  ' +
                            '            SHE_CODIGO,  ' +
                            '            SHE_CODIG2,  ' +
                            '            SHE_UNIDAD,  ' +
                            '            SHE_CODEMP,  ' +
                            '            AUTOINCREM,  ';

  For intForm := 1 To 20 Do
  Begin
    Result.SQL := Result.SQL  + '        SHE_FORM' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        SHE_QTDB' + TStrUtils.fStrZero(intForm, 2) + ', ';
  End;

  Result.SQL := Result.SQL  + '          SHE_BASE__,  ' +
                              '          SHE_PROKEY,  ' +
                              '          SHE_SUBKEY,  ' +
                              '          SHE_COMMEN,  ' +
                              '          SHE_OBSERV,  ' +
                              '          SHE_MD5KEY)  ' +

                              ' VALUES (:SHE_CODSEQ,  ' +
                              '         :SHE_DESCRI,  ' +
                              '         :SHE_CODIGO,  ' +
                              '         :SHE_CODIG2,  ' +
                              '         :SHE_UNIDAD,  ' +
                              '         :SHE_CODEMP,  ' +
                              '         :AUTOINCREM,  ';

    For intForm := 1 To 20 Do
    Begin
      Result.SQL := Result.SQL  + '     :SHE_FORM' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :SHE_QTDB' + TStrUtils.fStrZero(intForm, 2) + ', ';
    End;

    Result.SQL := Result.SQL  + '       :SHE_BASE__,  ' +
                                '       :SHE_PROKEY,  ' +
                                '       :SHE_SUBKEY,  ' +
                                '       :SHE_COMMEN,  ' +
                                '       :SHE_OBSERV,  ' +
                                '       :SHE_MD5KEY); ';

end;

function TGravandoExecucaoSherwinWilliamsCores.fCriaQueryMD5KeyComparacao: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := ' CREATE TABLE TMP_MD5KEYSHE (MD5KEY VARCHAR(32),   ';
  Result.SQL := Result.SQL + '                PRIMARY KEY(MD5KEY) );';
  Result.ExecSql;

  Result.SQL := ' INSERT INTO TMP_MD5KEYSHE     ';
  Result.SQL := Result.SQL + '      ( MD5KEY )  ';
  Result.SQL := Result.SQL + '        VALUES    ';
  Result.SQL := Result.SQL + '     ( :MD5KEY ); ';
end;

function TGravandoExecucaoSherwinWilliamsCores.fExisteMD5Key(
  strMd5Key: String): Boolean;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT MD5KEY FROM TMP_MD5KEYSHE WHERE MD5KEY = :MD5KEY ';
  qryGen.ParamByName('MD5KEY').AsString := strMd5Key;
  qryGen.Open;

  Result := Not qryGen.IsEmpty;
end;

function TGravandoExecucaoSherwinWilliamsCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoSherwinWilliamsCores.fGravaCadShe(intCodSeq: Integer;
  strBasSe: String; strProKey: String; strSubKey: String; arrColShe: Array of TColShe;
  strDesTin: String): Boolean;
  Var
    intCont : Integer;
    strMd5  : String;
begin
  Result := False;

  strMd5 := '';

  If qrySHE_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) //and Not TStrUtils.fEmptyStr(qrySHE_CADBAS.FieldByName('BAS_CODITE').AsString)
                Then
  Begin
    {*************************************************************************}
    {* VERIFICA SE NAO É IGUAL AO ULTIMO GRAVADO PARA NAO GRAVAR DUCPLICADOS *}
    {**********************************************************************PH*}
    If (qryInsert.ParamByName('SHE_DESCRI').AsString <> strDesTin) or
       (qryInsert.ParamByName('SHE_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryInsert.ParamByName('SHE_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qryInsert.ParamByName('SHE_UNIDAD').AsString <> qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       (intCodSeq = 1) Then
    Begin
      pLimparParametros;

      qryInsert.ParamByName('SHE_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
      qryInsert.ParamByName('SHE_DESCRI').AsString := strDesTin;
      qryInsert.ParamByName('SHE_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryInsert.ParamByName('SHE_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qryInsert.ParamByName('SHE_UNIDAD').AsString := qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryInsert.ParamByName('SHE_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryInsert.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHE_CADSHE', TAutcomTintaFactory.Get.GetCodEmp);
      qryInsert.ParamByName('SHE_BASE__').AsString := qrySHE_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryInsert.ParamByName('SHE_PROKEY').AsString := qrySHE_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryInsert.ParamByName('SHE_SUBKEY').AsString := qrySHE_CADBAS.FieldByName('BAS_SUBKEY').AsString;
      qryInsert.ParamByName('SHE_COMMEN').AsString := AnsiUpperCase(tblFrm.FieldByName('COMMENT').AsString);
      qryInsert.ParamByName('SHE_OBSERV').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY3').AsString);

      For intCont := Low(arrColShe) To High(arrColShe) Do
      Begin
        If TStrUtils.fEmptyStr(arrColShe[intCont].strCodCol) Then
          Break;

        qryInsert.ParamByName('SHE_FORM' + TStrUtils.fStrZero(intCont + 1, 2)).AsString := arrColShe[intCont].strCodCol;
        qryInsert.ParamByName('SHE_QTDB' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloat  := arrColShe[intCont].fltQtdCol;

        strMd5 := strMd5 + qryInsert.ParamByName('SHE_FORM' + TStrUtils.fStrZero(intCont + 1, 2)).AsString +
        FloatToStr(qryInsert.ParamByName('SHE_QTDB' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloat);
      End;

      strMd5 := strMd5 + qryInsert.ParamByName('SHE_DESCRI').AsString + ' ' +
                         qryInsert.ParamByName('SHE_CODIGO').AsString + ' ' +
                         qryInsert.ParamByName('SHE_CODIG2').AsString + ' ' +
                         qryInsert.ParamByName('SHE_UNIDAD').AsString;

      qryInsert.ParamByName('SHE_MD5KEY').AsString := GetMD5(strMd5);

      If Not fExisteMD5Key(qryInsert.ParamByName('SHE_MD5KEY').AsString) Then
      Begin
        pAdicionaMD5KeyComparacao(qryInsert.ParamByName('SHE_MD5KEY').AsString);
        qryInsert.ExecSQL;
      End;
      Result := True;
    End;
  End;
end;

procedure TGravandoExecucaoSherwinWilliamsCores.pAdicionaMD5KeyComparacao(
  strMd5Key: String);
begin
  qryMD5Key.ParamByName('MD5KEY').Value := strMd5Key;
  qryMD5Key.ExecSql;
end;

procedure TGravandoExecucaoSherwinWilliamsCores.pLimparParametros;
var
  intParam: Integer;
begin
  With qryInsert Do
  Begin
    ParamByName('SHE_CODSEQ').Value := Null;
    ParamByName('SHE_DESCRI').Value := Null;
    ParamByName('SHE_CODIGO').Value := Null;
    ParamByName('SHE_CODIG2').Value := Null;
    ParamByName('SHE_UNIDAD').Value := Null;
    ParamByName('SHE_CODEMP').Value := Null;
    ParamByName('AUTOINCREM').Value := Null;
    ParamByName('SHE_BASE__').Value := Null;
    ParamByName('SHE_PROKEY').Value := Null;
    ParamByName('SHE_SUBKEY').Value := Null;
    ParamByName('SHE_COMMEN').Value := Null;
    ParamByName('SHE_OBSERV').Value := Null;
    ParamByName('SHE_MD5KEY').Value := Null;

    For intParam := 1 To 20 Do
    Begin
      ParamByName('SHE_FORM' + TStrUtils.fStrZero(intParam, 2)).Value := Null;
      ParamByName('SHE_QTDB' + TStrUtils.fStrZero(intParam, 2)).Value := Null;
    End;

  End;
end;

end.

