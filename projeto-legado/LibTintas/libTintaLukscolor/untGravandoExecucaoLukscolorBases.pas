{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de bases da tinta Lukscolor * }
{ *******************************************************************************AC* }
unit untGravandoExecucaoLukscolorBases;

interface

uses
  untAbstractGravandoExecucaoLukscolor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils;

type
  TGravandoExecucaoLukscolorBases = class(TAbstractGravandoExecucaoLukscolor)
  private
    function fRetUnidadeEmbalagem(strCodEmb: String): String;
    function fRetQuantidadeEmbUnidade(strCodEmb, strCodUni: String): Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoLukscolorBases }

uses
  untStrUtils;

procedure TGravandoExecucaoLukscolorBases.Executar(const gravando: IGravando);
var
  qryAdoBases: TADOQuery; // Prisma
  qryAdoColorantes: TADOQuery; // Prisma

  intPos: Integer; // Excel
  intSubProd:Integer;

  strProKey: String; // Excel
  strPatPro: String; // Excel
  strPatSub: String; // Excel
  strSubKey: String; // Excel
  strBaseSe: String; // Excel
  strEmbCom: String; // Excel
  strFormula: String; // Excel

  arrColLkd: Array Of TColLkd; // Excel
  strQtdEmb: String; // Excel
  strDesTin: String; // Excel

begin
  If Conf.fGet('LKSPRI') = 'S' Then
  Begin
    Try
      // Bases
      Try
        gravando.Texto := 'Validando path do arquivo de Bases...';

        If Not fValidaPath Then
        Begin
          gravando.Texto := Format('O arquivo %s não existe',
            [AnsiReplaceStr(GetPath, '"', '')]);
          gravando.Cancelar;
        End;

        gravando.Texto := 'Path validado com sucesso...';

        gravando.Texto := 'Verificando Cadastro de Embalagens...';

        If fVerificaCadEmb Then
        Begin
          gravando.Texto := 'As Embalagens não estão configuradas!';
          Exit;
        End;

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.Texto := 'Carregando dados do Cadastro de Bases...';
        qryAdoBases := TADOQuery.Create(Nil);
        qryAdoBases.Connection := GetAdoLuksColor(GetPath);
        qryAdoBases.Close;
        qryAdoBases.SQL.Clear;
        qryAdoBases.SQL.Add('   SELECT DISTINCT   ');
        qryAdoBases.SQL.Add('     TBLCOLECAO.COD_COLECAO,    ');
        qryAdoBases.SQL.Add('     TBLCOLECAO.NOME_COLECAO,    ');
        qryAdoBases.SQL.Add('     TBLPRODUTO.COD_PRODUTO,    ');
        qryAdoBases.SQL.Add
          ('     UCASE(TBLPRODUTO.NOME_PRODUTO) AS NOME_PRODUTO,    ');
        qryAdoBases.SQL.Add('     TBLBASE.COD_BASE,   ');
        qryAdoBases.SQL.Add('     UCASE(TBLBASE.NOME_BASE) AS NOME_BASE,    ');
        qryAdoBases.SQL.Add('     TBLEMBALAGEM.COD_EMBALAGEM,   ');
        qryAdoBases.SQL.Add
          ('     UCASE(TBLEMBALAGEM.NOME_EMBALAGEM) AS NOME_EMBALAGEM,   ');
        qryAdoBases.SQL.Add('     TBLEMBALAGEM.TAMANHO_EMBALAGEM    ');
        qryAdoBases.SQL.Add('   FROM (  (   ');
        qryAdoBases.SQL.Add('     TBLPRODUTO    ');
        qryAdoBases.SQL.Add('     INNER JOIN (  TBLCOLECAO    ');
        qryAdoBases.SQL.Add
          ('     INNER JOIN TBLRELCOLECAOPRODUTO ON TBLCOLECAO.COD_COLECAO = TBLRELCOLECAOPRODUTO.COD_COLECAO  )   ');
        qryAdoBases.SQL.Add
          ('       ON TBLPRODUTO.COD_PRODUTO = TBLRELCOLECAOPRODUTO.COD_PRODUTO  )   ');
        qryAdoBases.SQL.Add('     INNER JOIN (  TBLBASE   ');
        qryAdoBases.SQL.Add
          ('     INNER JOIN TBLRELPRODUTOBASE ON TBLBASE.COD_BASE = TBLRELPRODUTOBASE.COD_BASE  )    ');
        qryAdoBases.SQL.Add
          ('       ON TBLPRODUTO.COD_PRODUTO = TBLRELPRODUTOBASE.COD_PRODUTO  )     ');
        qryAdoBases.SQL.Add('     INNER JOIN (  TBLEMBALAGEM    ');
        qryAdoBases.SQL.Add
          ('     INNER JOIN TBLRELPRODUTOEMBALAGEM ON TBLEMBALAGEM.COD_EMBALAGEM = TBLRELPRODUTOEMBALAGEM.COD_EMBALAGEM )    ');
        qryAdoBases.SQL.Add
          ('       ON TBLPRODUTO.COD_PRODUTO = TBLRELPRODUTOEMBALAGEM.COD_PRODUTO    ');
        qryAdoBases.SQL.Add('   ORDER BY    ');
        qryAdoBases.SQL.Add
          ('     TBLCOLECAO.COD_COLECAO, TBLPRODUTO.COD_PRODUTO, TBLBASE.COD_BASE    ');
        qryAdoBases.Open;

        gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKD_CADBAS');
        gravando.Texto := 'PROCOD verificado com sucesso...';

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.Texto := Format('Processando Arquivo [%s]',
          [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.RegistrarProgresso(0, 0, 0);

        While Not qryAdoBases.Eof Do
        Begin
          If Not qryLKD_CADBAS.Locate
            ('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
            VarArrayOf([TStrUtils.fStrZero(qryAdoBases.FieldByName('COD_BASE')
            .AsString, 2), TStrUtils.fStrZero(qryAdoBases.FieldByName
            ('COD_PRODUTO').AsString, 2),
            TStrUtils.fStrZero(qryAdoBases.FieldByName('COD_EMBALAGEM')
            .AsString, 2), fRetUnidadeEmbalagem(qryAdoBases.FieldByName
            ('COD_EMBALAGEM').AsString)]), []) Then
          Begin

            If (gravando.Status <> sgGravando) Then
              Break;

            qryLKD_CADBAS.Insert;
            qryLKD_CADBAS.FieldByName('BAS_BASE__').AsString :=
              TStrUtils.fStrZero(qryAdoBases.FieldByName('COD_BASE')
              .AsString, 2);
            qryLKD_CADBAS.FieldByName('BAS_PROKEY').AsString :=
              TStrUtils.fStrZero(qryAdoBases.FieldByName('COD_PRODUTO')
              .AsString, 2);
            qryLKD_CADBAS.FieldByName('BAS_SUBKEY').AsString :=
              TStrUtils.fStrZero(qryAdoBases.FieldByName('COD_EMBALAGEM')
              .AsString, 2);
            qryLKD_CADBAS.FieldByName('BAS_UNIDAD').AsString :=
              fRetUnidadeEmbalagem(qryAdoBases.FieldByName('COD_EMBALAGEM')
              .AsString);
            qryLKD_CADBAS.FieldByName('BAS_QTDEMB').AsFloat :=
              fRetQuantidadeEmbUnidade(qryAdoBases.FieldByName('COD_EMBALAGEM')
              .AsString, qryLKD_CADBAS.FieldByName('BAS_UNIDAD').AsString);
            qryLKD_CADBAS.FieldByName('BAS_DESCRI').AsString :=
              qryAdoBases.FieldByName('NOME_PRODUTO').AsString + ' ' +
              qryAdoBases.FieldByName('NOME_BASE').AsString + ' ' +
              qryAdoBases.FieldByName('NOME_EMBALAGEM').AsString;
            qryLKD_CADBAS.FieldByName('BAS_CODEMP').AsString :=
              TAutcomTintaFactory.Get.GetCodEmp;
            qryLKD_CADBAS.FieldByName('AUTOINCREM').AsString :=
              TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADBAS',
              TAutcomTintaFactory.Get.GetCodEmp);
            qryLKD_CADBAS.Post;
          End;
          qryAdoBases.Next;
          gravando.RegistrarProgresso(0, qryAdoBases.RecNo,
            qryAdoBases.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          Exit;
        End;

      End;
    Finally
      Gravando.Texto := 'Cadastro de Bases processado com sucesso...';
    End;

    Try
      // Colorantes
      Try
        gravando.Texto := 'Valindando path do arquivo do Colorante...';

        If Not fValidaPath Then
        Begin
          gravando.Texto := Format('O arquivo %s não existe',
            [AnsiReplaceStr(GetPath, '"', '')]);
          gravando.Cancelar;
        End;

        gravando.Texto := 'Path validado com sucesso...';

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.Texto := 'Verificando Cadastro de Embalagens...';

        If fVerificaCadEmb Then
        Begin
          gravando.Texto := 'As Embalagens não estão configuradas!';
          gravando.Cancelar;
        End;

        gravando.Texto := 'Carregando dados do Cadastro do Colorante...';
        qryAdoColorantes := TADOQuery.Create(Nil);
        qryAdoColorantes.Connection := GetAdoLuksColor(GetPath);
        qryAdoColorantes.Close;
        qryAdoColorantes.SQL.Clear;
        qryAdoColorantes.SQL.Add('    SELECT DISTINCT   ');
        qryAdoColorantes.SQL.Add('      COD_CORANTE,    ');
        qryAdoColorantes.SQL.Add('      SNOME_CORANTE    ');
        qryAdoColorantes.SQL.Add('    FROM    ');
        qryAdoColorantes.SQL.Add('      TblCorante      ');
        qryAdoColorantes.Open;

        gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKD_CADCOL');
        gravando.Texto := 'PROCOD verificado com sucesso...';

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.Texto := Format('Processando Arquivo [%s]',
          [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.RegistrarProgresso(0, 0, 0);

        While Not qryAdoColorantes.Eof Do
        Begin
          If Not qryLKD_CADCOL.Locate('COL_CODCOL',
            qryAdoColorantes.FieldByName('COD_CORANTE').AsString, []) Then
          Begin

            If (gravando.Status <> sgGravando) Then
              Break;

            qryLKD_CADCOL.Insert;
            qryLKD_CADCOL.FieldByName('COL_CODCOL').AsString :=
              qryAdoColorantes.FieldByName('COD_CORANTE').AsString;
            qryLKD_CADCOL.FieldByName('COL_DESCRI').AsString :=
              qryAdoColorantes.FieldByName('SNOME_CORANTE').AsString;
            qryLKD_CADCOL.FieldByName('AUTOINCREM').AsString :=
              TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADCOL',
              TAutcomTintaFactory.Get.GetCodEmp);
            qryLKD_CADCOL.FieldByName('COL_CODEMP').AsString :=
              TAutcomTintaFactory.Get.GetCodEmp;
            qryLKD_CADCOL.Post;
          End;
          qryAdoColorantes.Next;
          gravando.RegistrarProgresso(0, qryAdoColorantes.RecNo,
            qryAdoColorantes.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          Exit;
        End;
      End;
    Finally
      Gravando.Texto := 'Cadastro de Colorantes processado com sucesso...';
    End;
  End
  Else
  Begin
    Try
      Try
        gravando.Texto := 'Verificando diretorio configurado...';

        If Not fDiretorioValido Then
        Begin
          gravando.Texto := Format('O diretorio configurado %s não é valido',
            [AnsiReplaceStr(GetPath, '"', '')]);
          gravando.Cancelar;
        End;

        gravando.Texto := 'Diretorio verificado com sucesso...';

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.Texto := 'Carregando dados do Cadastro de Bases...';

        pCarregarProducts;
        pCarregarBase;
        pAtualizaTabelas;

        If Not fVerificaCadEmbalagem Then
        Begin
          If qryLKD_CADEMB.IsEmpty Then
          Begin
            If TAutcomTintaFactory.Get.fMensagem('',
              'O Cadastro de Embalagens está inconsistente!' + #13#10 +
              'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
              pImportaCadastroEmbalagem(gravando)
          End
          Else
            TAutcomTintaFactory.Get.fMensagem('',
              'O cadastro de Embalagens está inconsistente!', ['&OK']);

          Exit;
        End;

        gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKD_CADBAS');
        gravando.Texto := 'PROCOD verificado com sucesso...';

        If (gravando.Status <> sgGravando) Then
          Exit;

        While Not tblProducts.Eof Do
        Begin

          If (gravando.Status <> sgGravando) Then
            Break;

          strPatPro := GetPath + '\' + tblProducts.FieldByName('PATH').AsString;

          gravando.Texto := Format('Abrindo arquivos do Diretorio [%s]',
            [AnsiReplaceStr(strPatPro, '"', '')]);


          strProKey := TStrUtils.fStrZero
            (Trim(tblProducts.FieldByName('ID').AsString), 2);

          pCarregarSubProducts(strPatPro);

          For intSubProd := 1 To tblSubProds.RecordCount Do
          Begin
            strPatSub := strPatPro + '\' + tblSubProds.FieldByName
              ('PATH').AsString;
            strSubKey := TStrUtils.fStrZero
              (Trim(tblSubProds.FieldByName('ID').AsString), 2);

            pCarregarFrm(strPatPro, strPatSub, Gravando);
            pCarregarMask(strPatSub);

            tblFrm.First;

            gravando.Texto := Format('Processando Arquivos [%s]',
              [AnsiReplaceStr(strPatSub, '"', '')]);

            gravando.RegistrarProgresso(0, 0, 0);

            While Not tblFrm.Eof Do
            Begin

              If TStrUtils.fEmptyStr(tblFrm.FieldByName('BASE_ID')
                .AsString) Then
              Begin
                tblFrm.Next;
                Continue;
              End;

              strBaseSe := TStrUtils.fStrZero
                (Trim(tblFrm.FieldByName('BASE_ID').AsString), 2);
              strEmbCom := TStrUtils.fStrZero
                (Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

              tblMask.First;

              While Not tblMask.Eof Do
              Begin
                strFormula := tblFrm.FieldByName('FORMULA').AsString;
                SetLength(arrColLkd, 0);

                While Not(TStrUtils.fEmptyStr(strFormula)) Do
                Begin
                  SetLength(arrColLkd, Length(arrColLkd) + 1);
                  intPos := Pos(',', strFormula);

                  arrColLkd[Length(arrColLkd) - 1].strCodCol :=
                    TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);

                  strFormula := Copy(strFormula, intPos + 1,
                    Length(strFormula));
                  intPos := Pos(',', strFormula);

                  If intPos <= 0 Then
                    intPos := Length(strFormula) + 1;

                  arrColLkd[Length(arrColLkd) - 1].fltQtdCol :=
                    TAutcomTintaFactory.Get.fStrToFloat
                    (AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));

                  strFormula := Copy(strFormula, intPos + 1,
                    Length(strFormula));
                End;

                SetLength(arrColLkd, 20);
                strQtdEmb := TStrUtils.fStrZero
                  (Trim(tblMask.FieldByName('PNT_ID').AsString), 2);

                If tblMask.FieldByName('TYPE').AsString = 'CA' Then
                Begin

                  tblBases.Close;
                  tblBases.SQL.Text :=
                    '  SELECT * FROM \BASES.DBF WHERE TRIM(ID) = :ID   ';
                  tblBases.ParamByName('ID').AsString :=
                    Trim(tblFrm.FieldByName('BASE_ID').AsString);
                  tblBases.Open;

                  qryLKD_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                  strDesTin :=
                    AnsiUpperCase
                    (Trim(tblSubProds.FieldByName('DESCR').AsString) + ' ' +
                    Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                    FormatFloat('0.00', qryLKD_CADEMB.FieldByName('EMB_QTDEMB')
                    .AsFloat / 1000) + 'L');

                  pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin, strQtdEmb);
                  pGravaCadCol(arrColLkd);
                End;

                tblMask.Next;

              End;

              tblFrm.Next;
              gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);
            End;

            tblSubProds.Next;
            gravando.RegistrarProgresso(0, tblSubProds.RecNo,
              tblSubProds.RecordCount);
          End;
          tblProducts.Next;
          gravando.RegistrarProgresso(0, tblProducts.RecNo,
            tblProducts.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Cancelar;
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Finally
      gravando.Texto := 'Cadastro de Bases/Colorantes realizado com sucesso...';
    End;
  End;
end;

function TGravandoExecucaoLukscolorBases.fGetNomeGravacao: string;
begin
  If Conf.fGet('LKSPRI') = 'S' Then
    Result := 'Cadastro de Bases/Colorantes'
  Else
    Result := 'Cadastro de Bases/Colorantes';
end;

function TGravandoExecucaoLukscolorBases.fRetQuantidadeEmbUnidade(strCodEmb,
  strCodUni: String): Double;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL :=
      ' SELECT EMB_QTDEMB FROM LKD_CADEMB WHERE EMB_CODEMB = :CODEMB AND EMB_UNIDAD = :UNIDADE ';
    qryGen.ParamByName('CODEMB').AsString := strCodEmb;
    qryGen.ParamByName('UNIDADE').AsString := strCodUni;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := 0.00
    Else
      Result := qryGen.FieldByName('EMB_QTDEMB').AsFloat;
  Except
    Raise;
  End;
end;

function TGravandoExecucaoLukscolorBases.fRetUnidadeEmbalagem
  (strCodEmb: String): String;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL :=
      'SELECT EMB_UNIDAD FROM LKD_CADEMB WHERE EMB_CODEMB = :CODEMB   ';
    qryGen.ParamByName('CODEMB').AsString := strCodEmb;
    qryGen.Open;

    Result := qryGen.FieldByName('EMB_UNIDAD').AsString;
  Except
    Raise;
  End;
end;

end.
