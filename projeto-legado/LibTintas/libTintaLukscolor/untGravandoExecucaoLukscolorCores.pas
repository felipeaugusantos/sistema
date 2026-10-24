{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Lukscolor *}
{**********************************************************************PH*}
unit untGravandoExecucaoLukscolorCores;

interface

uses
  untAbstractGravandoExecucaoLukscolor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB;

type
  TGravandoExecucaoLukscolorCores = class(TAbstractGravandoExecucaoLukscolor)
  private
    function fRetUnidadeEmbalagem(strCodEmb:String):String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoLukscolorCores }

procedure TGravandoExecucaoLukscolorCores.Executar(const gravando: IGravando);
var
  qryAdoTintas: TADOQuery; //Prisma
  intCodSeq: Integer;  //Prisma e Excel
  intCodForm: Integer; //Prisma
  intCodBas: Integer;  //Prisma
  intCodEmb: Integer;  //Prisma
  intCodCol: Integer;  //Prisma

  intPos      : Integer;  //Excel
  strProKey   : String;   //Excel
  strPatPro   : String;   //Excel
  strPatSub   : String;   //Excel
  strSubKey   : String;   //Excel
  strBaseSe   : String;   //Excel
  strEmbCom   : String;   //Excel
  strFormula  : String;   //Excel
  arrColLkd   : Array Of TColLkd; //Excel
  strQtdEmb   : String;   //Excel
  strDesTin   : String;   //Excel
  intColora   : Integer;  //Excel
begin







  If conf.fGet('LKSPRI') = 'S' Then
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando path do arquivo...';

        If Not fValidaPath Then
        Begin
          Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
          Exit;
        End;

        Gravando.Texto := 'Path verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        intCodSeq := 0;

        Gravando.Texto := 'Carregando dados do Cadastro de Tintas(Prisma)...';
        qryAdoTintas := TADOQuery.Create(Nil);
        qryAdoTintas.Connection := GetAdoLuksColor(GetPath);
        qryAdoTintas.Close;
        qryAdoTintas.SQL.Clear;
        qryAdoTintas.SQL.Add('    SELECT DISTINCT   ');
        qryAdoTintas.SQL.Add('      FORMULA.COD_COLECAO,      ');
        qryAdoTintas.SQL.Add('      FORMULA.COD_FORMULA,      ');
        qryAdoTintas.SQL.Add('      FORMULA.COD_COR,      ');
        qryAdoTintas.SQL.Add('      UCASE(FORMULA.NOME_COR) AS NOME_COR,      ');
        qryAdoTintas.SQL.Add('      PRODUTOS.COD_PRODUTO,     ');
        qryAdoTintas.SQL.Add('      UCASE(PRODUTOS.NOME_PRODUTO) AS NOME_PRODUTO,     ');
        qryAdoTintas.SQL.Add('      BASES.COD_BASE,     ');
        qryAdoTintas.SQL.Add('      BASES.NOME_BASE,      ');
        qryAdoTintas.SQL.Add('      EMBBASES.COD_EMBALAGEM,     ');
        qryAdoTintas.SQL.Add('      EMBBASES.NOME_EMBALAGEM,      ');
        qryAdoTintas.SQL.Add('      EMBBASES.TAMANHO_EMBALAGEM,     ');
        qryAdoTintas.SQL.Add('      COLORANTES.COD_CORANTE,     ');
        qryAdoTintas.SQL.Add('      COLORANTES.QTD_CORANTE,     ');
        qryAdoTintas.SQL.Add('      EMBORI.TAMANHO_EMBALAGEM AS TAMORI      ');
        qryAdoTintas.SQL.Add('    FROM (   ');
        qryAdoTintas.SQL.Add('      TBLEMBALAGEM AS EMBORI      ');
        qryAdoTintas.SQL.Add('      INNER JOIN (    (      ');
        qryAdoTintas.SQL.Add('      TBLPRODUTO AS PRODUTOS      ');
        qryAdoTintas.SQL.Add('      INNER JOIN TBLFORMULA AS FORMULA      ');
        qryAdoTintas.SQL.Add('        ON PRODUTOS.COD_PRODUTO = FORMULA.COD_PRODUTO )     ');
        qryAdoTintas.SQL.Add('      INNER JOIN TBLRELFORMULACORANTE AS COLORANTES     ');
        qryAdoTintas.SQL.Add('        ON  FORMULA.COD_FORMULA = COLORANTES.COD_FORMULA  )     ');
        qryAdoTintas.SQL.Add('        ON  EMBORI.COD_EMBALAGEM = FORMULA.COD_EMBALAGEM    )     ');
        qryAdoTintas.SQL.Add('      INNER JOIN    (     ');
        qryAdoTintas.SQL.Add('      TBLBASE AS BASES      ');
        qryAdoTintas.SQL.Add('      INNER JOIN    (     ');
        qryAdoTintas.SQL.Add('      TBLEMBALAGEM AS EMBBASES      ');
        qryAdoTintas.SQL.Add('      INNER JOIN    (     ');
        qryAdoTintas.SQL.Add('      TBLRELPRODUTOEMBALAGEM AS PRODEMB     ');
        qryAdoTintas.SQL.Add('      INNER JOIN TBLRELPRODUTOBASE AS PRODBASES     ');
        qryAdoTintas.SQL.Add('        ON PRODEMB.COD_PRODUTO = PRODBASES.COD_PRODUTO  )     ');
        qryAdoTintas.SQL.Add('        ON EMBBASES.COD_EMBALAGEM = PRODEMB.COD_EMBALAGEM  )     ');
        qryAdoTintas.SQL.Add('        ON BASES.COD_BASE = PRODBASES.COD_BASE   )      ');
        qryAdoTintas.SQL.Add('        ON (PRODUTOS.COD_PRODUTO = PRODEMB.COD_PRODUTO)    AND     ');
        qryAdoTintas.SQL.Add('           (PRODUTOS.COD_PRODUTO = PRODBASES.COD_PRODUTO)  AND     ');
        qryAdoTintas.SQL.Add('           (FORMULA.COD_BASE = PRODBASES.COD_BASE)                 ');
        qryAdoTintas.SQL.Add('      ORDER BY      ');
        qryAdoTintas.SQL.Add('        FORMULA.COD_FORMULA, BASES.COD_BASE                         ');
        qryAdoTintas.Open;

        Gravando.Texto := 'Deletando Cadastro de Tintas...';
        qryLKD_CADLKD.Close;
        qryLKD_CADLKD.SQL.Empty;
        qryLKD_CADLKD.SQL := '    DELETE FROM LKD_CADLKD      ';
        qryLKD_CADLKD.ExecSQL;
        Gravando.Texto := 'Cadastro de Tintas deletado...';

        qryLKD_CADLKD.SQL.Empty;
        qryLKD_CADLKD.SQL := '    SELECT * FROM LKD_CADLKD WHERE FALSE    ';
        qryLKD_CADLKD.Open;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKD_CADLKD');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := Format('Processando Arquivos [%s]' , [AnsiReplaceStr(GetPath, '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        While Not qryAdoTintas.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          intCodForm := qryAdoTintas.FieldByName('COD_FORMULA').AsInteger;
          intCodBas  := qryAdoTintas.FieldByName('COD_BASE').AsInteger;
          intCodEmb  := qryAdoTintas.FieldByName('COD_EMBALAGEM').AsInteger;

          qryLKD_CADLKD.Insert;
          qryLKD_CADLKD.FieldByName('LKD_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
          qryLKD_CADLKD.FieldByName('LKD_DESCRI').AsString := qryAdoTintas.FieldByName('COD_COR').AsString + ' ' +
                                                              qryAdoTintas.FieldByName('NOME_PRODUTO').AsString + ' ' +
                                                              qryAdoTintas.FieldByName('NOME_COR').AsString;
          qryLKD_CADLKD.FieldByName('LKD_CODIGO').AsString := qryAdoTintas.FieldByName('COD_COR').AsString;
          qryLKD_CADLKD.FieldByName('LKD_CODIG2').AsString := qryAdoTintas.FieldByName('NOME_COR').AsString;
          qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString := fRetUnidadeEmbalagem(qryAdoTintas.FieldByName('COD_EMBALAGEM').AsString);

          If TStrUtils.fEmptyStr(qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString) Then
          Begin
            Gravando.Texto := 'Cadastro de Embalagens não configurado corretamente!';
            Exit;
          End;

          qryLKD_CADLKD.FieldByName('LKD_PROKEY').AsString := TStrUtils.fStrZero(qryAdoTintas.FieldByName('COD_PRODUTO').AsString, 2);
          qryLKD_CADLKD.FieldByName('LKD_SUBKEY').AsString := TStrUtils.fStrZero(qryAdoTintas.FieldByName('COD_EMBALAGEM').AsString, 2);
          qryLKD_CADLKD.FieldByName('LKD_BASE__').AsString := TStrUtils.fStrZero(qryAdoTintas.FieldByName('COD_BASE').AsString, 2);

          qryLKD_CADLKD.FieldByName('LKD_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryLKD_CADLKD.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADLKD', TAutcomTintaFactory.Get.GetCodEmp);
          qryLKD_CADLKD.FieldByName('LKD_MD5KEY').AsString := GetMD5(qryLKD_CADLKD.FieldByName('LKD_DESCRI').AsString +
                                                                     qryLKD_CADLKD.FieldByName('LKD_BASE__').AsString +
                                                                     qryLKD_CADLKD.FieldByName('LKD_CODIGO').AsString +
                                                                     qryLKD_CADLKD.FieldByName('LKD_CODIG2').AsString +
                                                                     qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString +
                                                                     qryLKD_CADLKD.FieldByName('LKD_PROKEY').AsString +
                                                                     qryLKD_CADLKD.FieldByName('LKD_SUBKEY').AsString);
          intCodCol := 1;

          While ((Not qryAdoTintas.Eof) And (intCodform = qryAdoTintas.FieldByName('COD_FORMULA').AsInteger)
            And (intCodBas = qryAdoTintas.FieldByName('COD_BASE').AsInteger) And (intCodEmb = qryAdoTintas.FieldByName('COD_EMBALAGEM').AsInteger)) Do
          Begin

            If TStrUtils.fEmptyStr(qryAdoTintas.FieldByName('COD_CORANTE').AsString) Then
              Break;

            qryLKD_CADLKD.FieldByName('LKD_FORM' + TStrUtils.fStrZero(intCodCol, 2)).AsString :=
              qryAdoTintas.FieldByName('COD_CORANTE').AsString;

            qryLKD_CADLKD.FieldByName('LKD_QTDB' + TStrUtils.fStrZero(intCodCol, 2)).AsFloat  :=
              TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(qryAdoTintas.FieldByName('QTD_CORANTE').AsString, '.', ',')) *
                qryAdoTintas.FieldByName('TAMANHO_EMBALAGEM').AsFloat / qryAdoTintas.FieldByName('TAMORI').AsFloat;

            qryAdoTintas.Next;
            intCodCol := intCodCol + 1;

          End;
          intCodSeq := intCodSeq + 1;
          qryLKD_CADLKD.Post;
          Gravando.RegistrarProgresso(0, qryAdoTintas.RecNo, qryAdoTintas.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          Exit;
        End;
      End;
    Finally
      Gravando.Texto := 'Cadastro de Tintas processado com sucesso...';
    End;
  End
  Else
  Begin
    Try
      Try
        Gravando.Texto := 'Validando diretorio do arquivo...';

        If Not fDiretorioValido Then
        Begin
          Gravando.Texto := Format('Diretorio [%s] não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
          Exit;
        End;

        Gravando.Texto := 'Diretorio validado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Carregando dados do Cadastro de Tintas...';
        pCarregarProducts;
        pCarregarBase;
        pAtualizaTabelas;
        intCodSeq := 1;

        Gravando.Texto := 'Deletando Cadastro de Tintas...';
        qryLKD_CADLKD.Close;
        qryLKD_CADLKD.SQL.Empty;
        qryLKD_CADLKD.SQL := '    DELETE FROM LKD_CADLKD    ' ;
        qryLKD_CADLKD.ExecSQL;
        Gravando.Texto := 'Cadastro de Tintas deletado...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKD_CADLKD');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Verificando Cadastro de Embalagens...';

        If Not fVerificaCadEmbalagem Then
        Begin
          If qryLKD_CADEMB.IsEmpty Then
          Begin
            If TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagens está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
              pImportaCadastroEmbalagem(Gravando);
              Gravando.Texto := 'Cadastro de Embalagens importado...';
              Gravando.RegistrarProgresso(0, 0, 0);
          End
          Else
          Begin
            Gravando.Texto := 'O cadastro de Embalagens está inconsistente';
            Exit;
          End;
        End;

        If (Not fVerificaCadBases) Then
        Begin
          Gravando.Texto := 'O cadastro de Bases está vazio!';
          Exit;
        End;

        If (Not fVerificaCadColorantes) Then
        Begin
          Gravando.Texto := 'O cadastro de Colorantes está vazio!';
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        tblProducts.First;

        Gravando.Texto := 'Abrindo Cadastro de Tintas...';
        qryLKD_CADLKD.SQL.Empty;
        qryLKD_CADLKD.SQL := '    SELECT * FROM LKD_CADLKD WHERE FALSE    ';
        qryLKD_CADLKD.Open;

        While Not tblProducts.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatPro := GetPath + '\' + tblProducts.FieldByName('PATH').AsString;
          strProKey := TStrUtils.fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);

          Gravando.Texto := Format('Carregando Produto [%s]', [AnsiReplaceStr(strPatPro, '"', '')]);


          pCarregarSubProducts(strPatPro);

          While Not tblSubProds.Eof Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            strPatSub := strPatPro + '\' + tblSubProds.FieldByName('PATH').AsString;
            strSubKey := TStrUtils.fStrZero(Trim(tblSubProds.FieldByName('ID').AsString), 2);



            pCarregarFrm(strPatPro, strPatSub, Gravando);
            pCarregarMask(strPatSub);

            Gravando.Texto := Format('Processando Arquivos [%s]', [AnsiReplaceStr(strPatSub, '"', '')]);

            tblFrm.First;

            While Not tblFrm.Eof Do
            Begin

              If (Gravando.Status <> sgGravando) Then
                Break;

              If TStrUtils.fEmptyStr(tblFrm.FieldByName('BASE_ID').AsString) Then
              Begin
                tblFrm.Next;
                Continue;
              End;

              strBaseSe := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('BASE_ID').AsString), 2);
              strEmbCom := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

              tblMask.First;

              While Not tblMask.Eof Do
              Begin

                If (Gravando.Status <> sgGravando) Then
                  Break;

                strFormula := tblFrm.FieldByName('FORMULA').AsString;
                SetLength(arrColLkd, 0);

                While Not TStrUtils.fEmptyStr(strFormula) Do
                Begin
                  SetLength(arrColLkd, Length(arrColLkd) + 1);
                  intPos := Pos(',', strFormula);
                  arrColLkd[Length(arrColLkd) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                  strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                  intPos := Pos(',', strFormula);

                  If intPos <= 0 tHEN
                    intPos := Length(strFormula) + 1;

                  arrColLkd[Length(arrColLkd) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
                  strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                End;

                SetLength(arrColLkd, 20);
                strQtdEmb := TStrUtils.fStrZero(Trim(tblMask.FieldByName('PNT_ID').AsString), 2);

                If tblMask.FieldByName('TYPE').AsString = 'CA' Then
                Begin

                  tblBases.Close;
                  tblBases.SQL.Text := 'SELECT * FROM \BASES.DBF WHERE TRIM(ID) = :ID   ';
                  tblBases.ParamByName('ID').AsString := Trim(tblFrm.FieldByName('BASE_ID').AsString);
                  tblBases.Open;

                  qryLKD_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                  strDesTin := AnsiUpperCase(tblFrm.FieldByName('KEY1').AsString + ' ' +
                  Trim(tblSubProds.FieldByName('DESCR').AsString) + ' ' +
                  tblFrm.FieldByName('KEY2').AsString);

                  For intColora := Low(arrColLkd) To High(arrColLkd) Do
                  Begin

                    If TStrUtils.fEmptyStr(arrColLkd[intColora].strCodCol) Then
                      Break;

                    arrColLkd[intColora].fltQtdCol := fCalcQtdEmb(arrColLkd[intColora].fltQtdCol, strEmbCom, strQtdEmb);
                  End;

                  If fGravaCadLkd(intCodSeq, strBaseSe, strProKey, strSubKey, arrColLkd, strDesTin) Then
                    Inc(intCodSeq);

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
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Finally
      Gravando.Texto := 'Cadastro de Tintas processado com sucesso!';
    End;
  End;

  If qryLKD_CADNFM.IsEmpty Then
    Exit;

  Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

  While Not qryLKD_CADNFM.Eof Do
  Begin
    fGravaCadNfm(qryLKD_CADNFM, Gravando);
    qryLKD_CADNFM.Next;
    Gravando.RegistrarProgresso(0, qryLKD_CADNFM.RecNo, qryLKD_CADNFM.RecordCount);
  End;

  If qryLKD_CADLKD.Eof Then
    Gravando.Texto := 'Cadastro de Novas Fórmulas processado...';
end;


function TGravandoExecucaoLukscolorCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Tintas';
end;

function TGravandoExecucaoLukscolorCores.fRetUnidadeEmbalagem(
  strCodEmb: String): String;
var
  qryGen: IDataSet;
begin
  Try
    Result := '';
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_UNIDAD FROM LKD_CADEMB WHERE EMB_CODEMB = :CODEMB   ';
    qryGen.ParamByName('CODEMB').AsString := strCodEmb;
    qryGen.Open;

    Result := qryGen.FieldByName('EMB_UNIDAD').AsString;
  Except
    Raise;
  End;
end;

end.
