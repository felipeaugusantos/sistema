{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Weg *}
{**********************************************************************PH*}
unit untGravandoExecucaoWegCores;

interface

uses
  untAbstractGravandoExecucaoWeg, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB;

type
  TGravandoExecucaoWegCores = class(TAbstractGravandoExecucaoWeg)
  Private
    procedure pDeletarMD5DuplicadoWeg(Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoWegCores }

procedure TGravandoExecucaoWegCores.Executar(const gravando: IGravando);
Var
  intProducts:Integer;
  intSubProds:Integer;
  intFrm:Integer;
  intMask:Integer;
  intPos:Integer;
  intColora:Integer;
  intCodSeq:Integer;
  intPatWeg:Integer;

  strPatPro:String;
  strPatSub:String;
  strProKey:String;
  strSubKey:String;
  strBase:String;
  strQtdEmb:String;
  strDescri:String;
  strFormula:String;
  strEmbCom:String;

  arrColWeg: Array Of TColWeg;
begin
  Gravando.Texto := 'Validando diretorio configurado...';

  If Not fValidaDiretorio Then
  Begin
    Gravando.Texto := Format('O diretorio %s configurado não é valido', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Diretorio validado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  pCarregarProdutos(Gravando);
  pCarregarBases(Gravando);
  pCarregarCnts(Gravando);
  Gravando.Texto := 'Carregando dados do Cadastro de Fórmulas...';

  Gravando.RegistrarProgresso(0, 0, 0);
  intCodSeq := 1;

  Gravando.Texto := 'Verificando Cadastro de Embalagem...';

  If Not fValidaCadEmbalagem() Then
  Begin
    If qryWEG_CADEMB.IsEmpty Then
    Begin
       If TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?',
         ['&Sim', '&Não']) = 1 Then
         fGravarCadEmb(Gravando)
       Else
        Exit;
    End
    Else
    Begin
      TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de embalagem está inconsistente!' + #13#10 +
      'Para continuar você deve importa-lo.', ['&Ok']);
      Exit;
    End;
  End;

  Gravando.Texto := 'Verificando Inconsistencias dos Cadastros de Bases e Colorantes...';

  If Not fValidaCadBases() Then
  Begin
    Gravando.Texto := 'O Cadastro de Bases está vazio. Para continuar você deve importa-lo.';
    Exit;
  End;

  If Not fValidaCadColorantes() Then
  Begin
    Gravando.Texto := 'O Cadastro de Colorantes está vazio. Para continuar você deve importa-lo.';
    Exit;
  End;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('WEG_CADWEG');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Deletando Fórmulas...';
  qryWEG_CADWEG.Close;
  qryWEG_CADWEG.SQL.Empty;
  qryWEG_CADWEG.SQL := '    DELETE FROM WEG_CADWEG    ';
  qryWEG_CADWEG.ExecSQL;
  qryWEG_CADWEG.SQL.Empty;
  Gravando.Texto := 'Fórmulas deletada...';

  qryWEG_CADWEG.SQL := '    SELECT * FROM WEG_CADWEG    ';
  qryWEG_CADWEG.Open;

  Gravando.Texto := Format('Abrindo arquivo: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try
      For intProducts := 1 To tblProdutos.RecordCount Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strPatPro := GetPath + '\' + tblProdutos.FieldByName('PATH').AsString;
        strProKey := TStrUtils.fStrZero(Trim(tblProdutos.FieldByName('ID').AsString), 2);
        pCarregarSubProdutos(strPatPro, Gravando);

        Gravando.Texto := Format('Carregando Produto: [%s]', [AnsiReplaceStr(strPatPro, '"', '')]);

        For intSubProds := 1 To tblSubprods.RecordCount Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatSub := strPatPro + '\' + tblSubprods.FieldByName('PATH').AsString;
          strSubKey := TStrUtils.fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);
          pCarregarFrm(strPatPro, strPatSub, Gravando);
          pCarregarMask(strPatSub, Gravando);

          Gravando.Texto := Format('Processando Subproduto: [%s]', [AnsiReplaceStr(strPatSub, '"', '')]);

          For intFrm := 1 To tblFrm.RecordCount Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            strBase := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('BASE_ID').AsString), 2);
            strEmbCom := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

            qryWEG_CADEMB.First;

            For intMask := 1 To qryWEG_CADEMB.RecordCount Do
            Begin
              strFormula := tblFrm.FieldByName('FORMULA').AsString;
              SetLength(arrColWeg, 0);

              While Not (TStrUtils.fEmptyStr(strFormula)) Do
              Begin
                SetLength(arrColWeg, Length(arrColWeg) + 1);
                intPos := Pos(',', strFormula);
                arrColWeg[Length(arrColWeg) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                intPos := Pos(',', strFormula);

                If intPos <= 0 Then
                  intPos := Length(strFormula) + 1;

                arrColWeg[Length(arrColWeg) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
              End;

              SetLength(arrColWeg, 20);
              strQtdEmb := TStrUtils.fStrZero(Trim(qryWEG_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

              If (qryWEG_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
              Begin
                tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
                qryWEG_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                strDescri := AnsiUpperCase(
                  tblFrm.FieldByName('KEY1').AsString + ' ' +
                  tblFrm.FieldByName('KEY2').AsString + ' ' +
                  tblFrm.FieldByName('KEY3').AsString);

                For intColora := Low(arrColWeg) To High(arrColWeg) Do
                Begin

                  If TStrUtils.fEmptyStr(arrColWeg[intColora].strCodCol) Then
                    Break;

                  arrColWeg[intColora].fltQtdCol := fCalQtdEmb(arrColWeg[intColora].fltQtdCol, strEmbCom, strQtdEmb);

                  If fGravarCadWeg(intCodSeq, strBase, strProKey, strSubKey, strDescri, arrColWeg, Gravando) Then
                    Inc(intCodSeq);
                End;
              End;

              qryWEG_CADEMB.Next;
            End;
            tblFrm.Next;
            Gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);
          End;
          tblSubprods.Next;
          Gravando.RegistrarProgresso(0, tblSubprods.RecNo, tblSubprods.RecordCount);
        End;
        tblProdutos.Next;
        Gravando.RegistrarProgresso(0, tblProdutos.RecNo, tblProdutos.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Fórmulas processado com sucesso!';
  End;

  Gravando.Texto := 'Verificando MD5KEY Duplicado (WEG_CADWEG)...';
  pDeletarMD5DuplicadoWeg(Gravando);

  Gravando.RegistrarProgresso(0, 0, 0);

  Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

  While Not qryWEG_CADNFM.Eof Do
  Begin
    fGravarCadNfm(qryWEG_CADNFM, Gravando);
    qryWEG_CADNFM.Next;
    gravando.RegistrarProgresso(0, qryWEG_CADNFM.RecNo, qryWEG_CADNFM.RecordCount);
  End;

  Gravando.Texto := 'Cadastro de Novas Fórmulas processado com sucesso!';



end;


function TGravandoExecucaoWegCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


procedure TGravandoExecucaoWegCores.pDeletarMD5DuplicadoWeg(
  Gravando: IGravando);
Var
  qryGen,
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT COUNT(*) AS QTD, WEG_MD5KEY AS MD5KEY      ' +
                '     FROM WEG_CADWEG                                 ' +
                '   GROUP BY WEG_MD5KEY                               ' +
                '     HAVING COUNT(*) > 1                             ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo cadastros duplicados...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.First;

    While Not qryGen.Eof Do
    Begin

      qryMD5.SQL := '   DELETE FROM WEG_CADWEG        ' +
                    '     WHERE WEG_MD5KEY = :MD5     ' +
                    '   LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('MD5KEY').AsString;
      qryMD5.ExecSQL;

      Gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;

  End;
end;

end.
