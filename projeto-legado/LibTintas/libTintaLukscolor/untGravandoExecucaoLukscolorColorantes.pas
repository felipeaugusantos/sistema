{ ****************************************************************************** }
{ * Classe responsável pela geração do cadastro de colorantes da tinta Lukscolor * }
{ ***************************************************************************PH* }
unit untGravandoExecucaoLukscolorColorantes;

interface

uses
  untAbstractGravandoExecucaoLukscolor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils,
  untStrUtils;

type
  TGravandoExecucaoLukscolorColorantes = class
    (TAbstractGravandoExecucaoLukscolor)
  private
    function fRetUnidadeEmbalagem(fltQtd:Double):String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoLukscolorCores }

procedure TGravandoExecucaoLukscolorColorantes.Executar(const gravando
  : IGravando);
var
  qryAdoEmbalagens: TADOQuery; // Prisma

  strProKey   : String;  //Excel
  strPatPro   : String;  //Excel
  strPatSub   : String;  //Excel
  strSubKey   : String;  //Excel
  strFormula  : String;  //Excel
  intSubProd  : Integer;

  arrColLkd   : Array Of TColLkd; //Excel
  strQtdEmb   : String;  //Excel
  intPos      : Integer; //Excel

begin
  If conf.fGet('LKSPRI') = 'S' Then
  Begin
    Try
      Try
        gravando.Texto := 'Validando path de arquivo...';

        If Not fValidaPath Then
        Begin
          gravando.Texto := Format('O path de arquivo %s não existe!',
            [AnsiReplaceStr(GetPath, '"', '')]);
          Exit;
        End;

        gravando.Texto := 'Path validado com sucesso...';

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.Texto := 'Carregando dados do Cadastro de Embalagens...';
        qryAdoEmbalagens := TADOQuery.Create(Nil);
        qryAdoEmbalagens.Connection := GetAdoLuksColor(GetPath);

        qryAdoEmbalagens.Close;
        qryAdoEmbalagens.SQL.Clear;
        qryAdoEmbalagens.SQL.Add('    SELECT DISTINCT   ');
        qryAdoEmbalagens.SQL.Add('      * FROM TblEmbalagem   ');
        qryAdoEmbalagens.Open;

        gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKD_CADEMB');
        gravando.Texto := 'PROCOD verificado com sucesso...';

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.Texto := Format('Processando Cadastro de Embalagens [%s]',
          [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.RegistrarProgresso(0, 0, 0);


        While Not qryAdoEmbalagens.Eof Do
        Begin
          If Not qryLKD_CADEMB.Locate('EMB_CODEMB', qryAdoEmbalagens.FieldByName('cod_embalagem').AsString, []) Then
          Begin

            If (gravando.Status <> sgGravando) Then
              Break;

            qryLKD_CADEMB.Insert;
            qryLKD_CADEMB.FieldByName('AUTOINCREM').AsString :=
              TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADEMB',
              TAutcomTintaFactory.Get.GetCodEmp);
            qryLKD_CADEMB.FieldByName('EMB_CODEMP').AsString :=
              TAutcomTintaFactory.Get.GetCodEmp;
            qryLKD_CADEMB.FieldByName('EMB_CODEMB').AsString :=
              qryAdoEmbalagens.FieldByName('cod_embalagem').AsString;
            qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat :=
              qryAdoEmbalagens.FieldByName('tamanho_embalagem').AsFloat * 1000;
            qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString :=
              fRetUnidadeEmbalagem(qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat);
            qryLKD_CADEMB.Post;

          End;

          qryAdoEmbalagens.Next;
        End;

        gravando.RegistrarProgresso(0, qryAdoEmbalagens.RecNo,
          qryAdoEmbalagens.RecordCount);

      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          Exit;
        End;
      End;
    Finally
      Gravando.Texto := 'Cadastro de Embalagens processado com sucesso!';
    End;
  End
  Else
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando Diretorio do arquivo...';

        If Not fDiretorioValido Then
        Begin
          Gravando.Texto := Format('O diretorio configurado %s não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
          Gravando.Cancelar;
        End;

        Gravando.Texto := 'Diretorio validado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Carregando dados do Cadastro de Colorantes...';

        pCarregarProducts;
        pCarregarBase;
        pAtualizaTabelas;

        If Not fVerificaCadEmbalagem Then
        Begin
          If qryLKD_CADEMB.IsEmpty Then
          Begin
            If TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de Embalagens está inconsistente!' + #13#10 +
            'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
            Begin
              pImportaCadastroEmbalagem(Gravando);
            End
            Else
            Begin
              TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagens está inconsistente!', ['&OK']);
            End;
          End;
           Exit;
        End;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKD_CADCOL');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        While Not tblProducts.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatPro := GetPath + '\' + tblProducts.FieldByName('PATH').AsString;

          Gravando.Texto := Format('Abrindo arquivos do Diretorio [%s]', [AnsiReplaceStr(strPatPro, '"', '')]);

          strProKey := TStrUtils.fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);

          pCarregarSubProducts(strPatPro);

          For intSubProd := 1 To tblSubProds.RecordCount Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            strPatSub := strPatPro + '\' + tblSubProds.FieldByName('PATH').AsString;
            strSubKey := TStrUtils.fStrZero(Trim(tblSubProds.FieldByName('ID').AsString), 2);

            pCarregarFrm(strPatPro, strPatSub, Gravando);
            pCarregarMask(strPatSub);

            tblFrm.First;

            Gravando.Texto := Format('Processando Arquivos [%s]', [AnsiReplaceStr(strPatSub, '"', '')]);
            Gravando.RegistrarProgresso(0, 0, 0);

            While Not tblFrm.Eof Do
            Begin

              If (Gravando.Status <> sgGravando) Then
                Break;

              If TStrUtils.fEmptyStr(tblFrm.FieldByName('BASE_ID').AsString) Then
              Begin
                tblFrm.Next;
                Continue;
              End;

              While Not tblMask.Eof Do
              Begin

                If (Gravando.Status <> sgGravando) Then
                  Break;

                strFormula := tblFrm.FieldByName('FORMULA').AsString;
                SetLength(arrColLkd, 0);

                While Not (TStrUtils.fEmptyStr(strFormula)) Do
                Begin
                  SetLength(arrColLkd, Length(arrColLkd) + 1);
                  intPos := Pos(',', strFormula);

                  arrColLkd[Length(arrColLkd) - 1].strCodCol :=
                    TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);

                  strFormula := Copy(strFormula, intPos + 1, Length(strFormula));

                  intPos := Pos(',', strFormula);

                  If intPos <= 0 Then
                    intPos := Length(strFormula) + 1;

                  arrColLkd[Length(arrColLkd) - 1].fltQtdCol :=
                    TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));

                  strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                End;

                SetLength(arrColLkd, 20);

                If tblMask.FieldByName('TYPE').AsString = 'CA' Then
                Begin
                  tblBases.Close;
                  tblBases.SQL.Text := '    SELECT * FROM \BASES.DBF WHERE TRIM(ID) = :ID   ';
                  tblBases.ParamByName('ID').AsString := Trim(tblFrm.FieldByName('BASE_ID').AsString);
                  tblBases.Open;

                  qryLKD_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                  pGravaCadCol(arrColLkd);
                End;
                tblMask.Next;
              End;
              tblFrm.Next;
              Gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);
            End;
            tblSubProds.Next;
            Gravando.RegistrarProgresso(0, tblSubProds.RecNo, tblSubProds.RecordCount);
          End;
          tblProducts.Next;
          Gravando.RegistrarProgresso(0, tblProducts.RecNo, tblProducts.RecordCount);
        End;


      Except
        On E: Exception Do
        Begin
          Gravando.Cancelar;
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message])
        End;

      End;
    Finally
      Gravando.Texto := Format('Arquivos Processados [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
    End;
  End;
end;

function TGravandoExecucaoLukscolorColorantes.fGetNomeGravacao: string;
begin
  If conf.fGet('LKSPRI') = 'S' Then
    Result := 'Cadastro de Embalagens'
  Else
    Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoLukscolorColorantes.fRetUnidadeEmbalagem(
  fltQtd: Double): String;
begin
  Result := '';
  If fltQtd <= 1000 Then
    Result := 'LT'
  Else If fltQtd <= 4600 Then
    Result := 'GL'
  Else If fltQtd > 10000 Then
    Result := 'LA';
end;

end.
