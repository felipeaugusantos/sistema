{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Advance *}
{**********************************************************************PH*}
unit untGravandoExecucaoAdvanceCores;

interface

uses
  untAbstractGravandoExecucaoAdvance, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB;

type
  TGravandoExecucaoAdvanceCores = class(TAbstractGravandoExecucaoAdvance)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoAdvanceCores }

procedure TGravandoExecucaoAdvanceCores.Executar(const gravando: IGravando);
Var
  intProducts : Integer;
  intSubProds : Integer;
  intFrm      : Integer;
  intMask     : Integer;
  intPos      : Integer;
  intColora   : Integer;
  intCodSeq   : Integer;

  strProKey   : String;
  strPatPro   : String;
  strPatSub   : String;
  strSubKey   : String;
  strBase__   : String;
  strEmbCom   : String;
  strFormula  : String;
  strCodEmb   : String;
  strDescri   : String;

  arrColAdv   : Array Of TColAdv;
begin
  Try
    Try
      Gravando.Texto := 'Verificando diretorio configurado...';

      If Not fValidaDiretorio Then
      Begin
        Gravando.Texto := Format('O diretorio %s configurado não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Diretorio validado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Fórmulas...';

      pCarregarProduts(Gravando);
      pCarregarBases(Gravando);
      intCodSeq := 1;
      pAtualizaTabelas;

      Gravando.Texto := 'Verificando Cadastro de Embalagem...';

      If Not fVerificaCadEmbalagem Then
      Begin
        If qryADV_CADEMB.IsEmpty Then
        Begin
          If TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
            fGravaCadEmbalagem(Gravando);
        End
        Else
          TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Para continuar você deve importa-lo.', ['&Ok']);
        Exit;
      End;

      Gravando.Texto := 'Cadastro de Embalagem verificado com sucesso...';

      Gravando.Texto := 'Verificando Cadastro de Bases e Colorantes...';

      If Not fVerificaCadBases Then
      Begin
        Gravando.Texto := 'O Cadastro de Bases está vazio! ' + #13#10 +
                          ' Para continuar você deve importa-lo.';
        Exit;
      End;

      If Not fVerificaCadColorantes Then
      Begin
        Gravando.Texto := 'O Cadastro de Colorantes está vazio! ' + #13#10 +
                          ' Para continuar você deve importa-lo.';
        Exit;
      End;

      Gravando.Texto := 'Deletando Cadastro...';
      qryADV_CADADV.Close;
      qryADV_CADADV.SQL.Empty;
      qryADV_CADADV.SQL := '    DELETE FROM ADVCOR_CADADV     ';
      qryADV_CADADV.ExecSQL;
      Gravando.Texto := 'Cadastro deletado...';
      qryADV_CADADV.SQL.Empty;
      qryADV_CADADV.SQL := '    SELECT * FROM ADVCOR_CADADV     ';
      qryADV_CADADV.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ADVCOR_CADADV');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Carregando Path: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);


      For intProducts := 1 To qryProduts.RecordCount Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strPatPro := GetPath + '\' + qryProduts.FieldByName('PATH').AsString;
        strProKey := TStrUtils.fStrZero(Trim(qryProduts.FieldByName('ID').AsString), 2);
        Gravando.Texto := Format('Carregando Produto: [%s]', [AnsiReplaceStr(strPatPro, '"', '')]);
        pCarregarSubProduts(strPatPro, Gravando);

        For intSubProds := 1 To qrySubProduts.RecordCount Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatSub := strPatPro + '\' + qrySubProduts.FieldByName('PATH').AsString;
          strSubKey := TStrUtils.fStrZero(Trim(qrySubProduts.FieldByName('ID').AsString), 2);
          pCarregarFrm(strPatPro, strPatSub, Gravando);
          pCarregarMask(strPatSub, Gravando);
          Gravando.Texto := Format('Processando Subproduto: [%s]', [AnsiReplaceStr(strPatSub, '"', '')]);

          For intFrm := 1 To qryADV_GERFRM.RecordCount Do
          Begin
            strBase__ := TStrUtils.fStrZero(Trim(qryADV_GERFRM.FieldByName('BASE_ID').AsString), 2);
            strEmbCom := TStrUtils.fStrZero(Trim(qryADV_GERFRM.FieldByName('CAN_ID').AsString), 2);


            If TStrUtils.fEmptyStr(qryADV_GERFRM.FieldByName('BASE_ID').AsString) Then
            Begin
             qryADV_GERFRM.Next;
             Continue;
            End;


            qryADV_CADEMB.First;
            For intMask := 1 To qryADV_CADEMB.RecordCount Do
            Begin
              strFormula := qryADV_GERFRM.FieldByName('FORMULA').AsString;
              SetLength(arrColAdv, 0);

              While Not (TStrUtils.fEmptyStr(strFormula)) Do
              Begin
                SetLength(arrColAdv, Length(arrColAdv) + 1);
                intPos := Pos(',', strFormula);
                arrColAdv[Length(arrColAdv) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                intPos := Pos(',', strFormula);

                If intPos <= 0 Then
                  intPos := Length(strFormula) + 1;
                arrColAdv[Length(arrColAdv) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1),
                  '.', ','));
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
              End;

              SetLength(arrColAdv, 20);
              strCodEmb := TStrUtils.fStrZero(Trim(qryADV_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

              If (qryADV_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
              Begin
                qryBases.Locate('ID', qryADV_GERFRM.FieldByName('BASE_ID').AsString, []);
                qryADV_CADEMB.Locate('EMB_CODEMB', strCodEmb, []);

                strDescri := AnsiUpperCase(
                  qryADV_GERFRM.FieldByName('KEY1').AsString + ' ' +
                  Trim(qrySubProduts.FieldByName('DESCR').AsString) + ' ' +
                  qryADV_GERFRM.FieldByName('KEY2').AsString);

                For intColora := Low(arrColAdv) To High(arrColAdv) Do
                Begin

                  If TStrUtils.fEmptyStr(arrColAdv[intColora].strCodCol) Then
                    Break;

                  arrColAdv[intColora].fltQtdCol := fCalQtdEmb(arrColAdv[intColora].fltQtdCol, strEmbCom, strCodEmb);
                End;

                If fGravarCadAdvance(intCodSeq, strBase__, strProKey, strSubKey, strDescri, arrColAdv) Then
                  Inc(IntCodSeq);
              End;
              qryADV_CADEMB.Next;
            End;
            qryADV_GERFRM.Next;
            Gravando.RegistrarProgresso(0, qryADV_GERFRM.RecNo, qryADV_GERFRM.RecordCount);
          End;
          qrySubProduts.Next;
          Gravando.RegistrarProgresso(0, qrySubProduts.RecNo, qrySubProduts.RecordCount);
        End;
        qryProduts.Next;
        Gravando.RegistrarProgresso(0, qryProduts.RecNo, qryProduts.RecordCount);
      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally

  End;
end;


function TGravandoExecucaoAdvanceCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

end.
