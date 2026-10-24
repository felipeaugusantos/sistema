{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Advance *}
{*******************************************************************************AC*}
unit untGravandoExecucaoAdvanceBases;

interface

uses
  untAbstractGravandoExecucaoAdvance, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils;

type
  TGravandoExecucaoAdvanceBases = class(TAbstractGravandoExecucaoAdvance)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoAdvanceBases }

procedure TGravandoExecucaoAdvanceBases.Executar(const gravando: IGravando);
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
  strBase__   : String;
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
        Gravando.Texto := Format('O diretorio configurado %s não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Diretorio validado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados dos Cadastros de Bases e Colorantes...';

      pCarregarProduts(Gravando);
      pCarregarBases(Gravando);
      pAtualizaTabelas;

      Gravando.Texto := 'Verificando Cadastro de Embalagem...';

      If Not fVerificaCadEmbalagem Then
      Begin
        If qryADV_CADEMB.IsEmpty Then
        Begin
          If TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o Cadastro?', ['&Sim', '&Não']) = 1 Then
            fGravaCadEmbalagem(Gravando);
        End
        Else
          TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de Embalagem está inconsistente!' + #13#10 + 'Para continuar você deve importa-lo!', ['&OK']);

        Exit;
      End;

      Gravando.Texto := 'Cadastro de Embalagem verificado com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ADVCOR_CADBAS');
      TAutcomTintaFactory.Get.fInsereProCod('ADVCOR_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Carregando Path do arquivo: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);

      For intProducts := 1 To qryProduts.RecordCount Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strPatPro := GetPath + '\' + qryProduts.FieldByName('PATH').AsString;
        strProKey := TStrUtils.fStrZero(Trim(qryProduts.FieldByName('ID').AsString), 2);
        pCarregarSubProduts(strPatPro, Gravando);
        Gravando.Texto := Format('Carregando Produto: [%s]', [AnsiReplaceStr(strPatPro, '"', '')]);

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

            If (Gravando.Status <> sgGravando) Then
              Break;

            strBase__ := TStrUtils.fStrZero(Trim(qryADV_GERFRM.FieldByName('BASE_ID').AsString), 2);

            If TStrUtils.fEmptyStr(qryADV_GERFRM.FieldByName('BASE_ID').AsString) Then
            Begin
              qryADV_GERFRM.Next;
              Continue;
            End;

            qryADV_CADEMB.First;
            For intMask := 1 To qryADV_CADEMB.RecordCount Do
            Begin

              If (Gravando.Status <> sgGravando) Then
                Break;

              strFormula := qryADV_GERFRM.FieldByName('FORMULA').AsString;
              SetLength(arrColAdv, 0);

              While Not (TStrUtils.fEmptyStr(strFormula)) Do
              Begin
                SetLength(arrColAdv, Length(arrColAdv) + 1);
                intPos := Pos(',' , strFormula);
                arrColAdv[Length(arrColAdv) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                intPos := Pos(',' , strFormula);
                If intPos <= 0 Then
                  intPos := Length(strFormula)+1;
                arrColAdv[Length(arrColAdv) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1),
                  '.', ','));
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
              End;

              SetLength(arrColAdv, 20);
              strCodEmb := TStrUtils.fStrZero(Trim(qryADV_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

              If qryADV_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S' Then
              Begin
                qryBases.Locate('ID', qryADV_GERFRM.FieldByName('BASE_ID').AsString, []);
                qryADV_CADEMB.Locate('EMB_CODEMB', strCodEmb, []);

                strDescri := AnsiUpperCase(
                  Trim(qrySubProduts.FieldByName('DESCR').AsString) + ' ' +
                  Trim(qryBases.FieldByName('DESCR').AsString) + ' ' +
                  FormatFloat('0.00', qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

                fGravaCadColorantes(arrColAdv, Gravando);
                fGravaCadBases(strBase__, strProKey, strSubKey, strDescri);
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
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := Format('Cadastro de %s e %s processado com sucesso!', ['Bases', 'Colorantes']);
  End;

end;

function TGravandoExecucaoAdvanceBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases e Colorantes';
end;


end.
