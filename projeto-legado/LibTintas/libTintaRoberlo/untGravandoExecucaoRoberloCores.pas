unit untGravandoExecucaoRoberloCores;

interface

uses
  untAbstractGravandoExecucaoRoberlo, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, Classes, Math, Variants, System.Win.ComObj;

type
  TGravandoExecucaoRoberloCores = class(TAbstractGravandoExecucaoRoberlo)
  private
   procedure DeletarRegistros(const Gravando: IGravando);
   procedure DeletarFormulasMd5KeyDuplicado(const Gravando: IGravando);

  Protected
    function GetSqlDestino(): String; Override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): String; Override;
    function IsRegistroExistente(qryDestino: IDataSet; Excel: Variant; Linha: Integer): Boolean; Reintroduce;
    procedure GravarRegistro(qryDestino: IDataSet; Excel: Variant; Linha: Integer); Reintroduce;

  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;


implementation

uses
  untCriadorTabelas, untFuncoesGenerica;
{ TGravandoExecucaoRoberloBases }

procedure TGravandoExecucaoRoberloCores.DeletarFormulasMd5KeyDuplicado(
  const Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMd5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        ROB_MD5KEY       ' +
                '   FROM ROB_CADROB       ' +
                '  GROUP BY ROB_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados ROB_CADROB...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM ROB_CADROB ' +
                    '  WHERE ROB_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('ROB_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;
  End;
end;

procedure TGravandoExecucaoRoberloCores.DeletarRegistros(
  const Gravando: IGravando);
Var
  qryGen: IDataSet;
begin
  Gravando.Texto := 'Deletando registros da tabela ROB_CADROB...';
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := ' DELETE FROM ROB_CADROB    ';
  qryGen.ExecSQL;
  Gravando.Texto := 'Registros deletados...';
end;

procedure TGravandoExecucaoRoberloCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  qryFormul: IDataSet;
  OleExcel, OleSheet: OleVariant;
  intQtd, intTamExcel, intCont: Integer;
  strCodigo: String;
  strBase: String;
  strQtde: String;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path...';

      If Not VerificaPath() Then
      Begin
        Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever configurações da tinta.', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      DeletarRegistros(Gravando);

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ROB_CADROB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados...';
      OleExcel := CreateOleObject('Excel.Application');
      OleExcel.Visible := False;
      OleExcel.WorkBooks.Open(GetPath);
      OleSheet := OleExcel.WorkBooks[1].WorkSheets['Hoja nº2 tot'];
      intTamExcel := OleSheet.Cells.SpecialCells(11).Row;
      qryDestino := GetDataSetDestino;

      Gravando.Texto := 'Processando Dados...';
      Gravando.RegistrarProgresso(0, 0, 0);
      Try
        Try
          For intCont := 2 To intTamExcel Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            If Not IsRegistroExistente(qryDestino, OleSheet, intCont) Then
              GravarRegistro(qryDestino, OleSheet, intCont);

            Gravando.RegistrarProgresso(0, intCont, intTamExcel);
          End;

         Except
          On E: Exception Do
          Begin
            Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            Gravando.Cancelar;
          End;
        End;
      Finally
        If Not VarIsEmpty(OleExcel) Then
        Begin
          OleExcel.Quit;
          OleExcel := Unassigned;
          OleSheet := Unassigned;
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
  End;

  Gravando.Texto := 'Formulas Finalizadas...';
  DeletarFormulasMd5KeyDuplicado(Gravando);
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try
      intQtd := 0;
      Gravando.Texto := 'Gravando Bases e Quantidades nas fórmulas...';
      qryFormul := TAutcomTintaFactory.Get.fGetDataSet;

      OleExcel := CreateOleObject('Excel.Application');
      OleExcel.Visible := False;
      OleExcel.WorkBooks.Open(GetPath);
      OleSheet := OleExcel.WorkBooks[1].WorkSheets['Hoja nº3 tot'];
      intTamExcel := OleSheet.Cells.SpecialCells(11).Row;

      For intCont := 1 To intTamExcel Do
      Begin
        strCodigo := OleSheet.Cells[intCont, 1].Text;
        strBase   := OleSheet.Cells[intCont, 3].Text;
        strQtde   := OleSheet.Cells[intCont, 4].Text;

        If Not TStrUtils.fEmptyStr(strCodigo) Then
        Begin
          intQtd := 1;
          qryFormul.Close;
          qryFormul.SQL := '';
          qryFormul.SQL := qryFormul.SQL + '  SELECT            ';
          qryFormul.SQL := qryFormul.SQL + '    *               ';
          qryFormul.SQL := qryFormul.SQL + '  FROM              ';
          qryFormul.SQL := qryFormul.SQL + '    ROB_CADROB      ';
          qryFormul.SQL := qryFormul.SQL + '  WHERE             ';
          qryFormul.SQL := qryFormul.SQL + '    ROB_CODIGO = "' + strCodigo + '"      ';
          qryFormul.Open;
        End;

        If (TStrUtils.fEmptyStr(strBase)) Or (TStrUtils.fEmptyStr(strQtde)) Then
          Continue;

        qryFormul.First;

        While Not qryFormul.Eof Do
        Begin
          qryFormul.Edit;
          qryFormul.FieldByName('ROB_BASE' + TStrUtils.fStrZero(intQtd, 2)).AsString := strBase;
          qryFormul.FieldByName('ROB_QTDB' + TStrUtils.fStrZero(intQtd, 2)).AsFloat  := StrToFloat(strQtde);
          qryFormul.Post;
          qryFormul.Next;
        End;
        Inc(intQtd);
        Gravando.RegistrarProgresso(0, intCont, intTamExcel);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
    If Not VarIsEmpty(OleExcel) Then
    Begin
      OleExcel.Quit;
      OleExcel := Unassigned;
      OleSheet := Unassigned;
    End;
  End;
end;

function TGravandoExecucaoRoberloCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoRoberloCores.GetSqlDestino: String;
begin
  Result := '   SELECT * FROM ROB_CADROB    ';
end;

function TGravandoExecucaoRoberloCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): String;
begin
  Result := '';
  Result := Result + '  SELECT                            ';
  Result := Result + '    [NUM_FORMULA] AS [FORMULA],     ';
  Result := Result + '    [SERIE],                        ';
  Result := Result + '    [MARCA],                        ';
  Result := Result + '    [NOM] AS [NOMCOR],              ';
  Result := Result + '    [CODI COLOR] AS [CODCOR],       ';
  Result := Result + '    [CODI VARIANT] AS [VARIANT],    ';
  Result := Result + '    [MODEL] AS [MODELO],            ';
  Result := Result + '    [GRUP COLOR] AS [GRUCOR],       ';
  Result := Result + '    [ANY INICI] AS [ANOINI],        ';
  Result := Result + '    [ANY FI] AS [ANOFIN],           ';
  Result := Result + '    [CAPA] AS [CAMADA],             ';
  Result := Result + '    [CROMBOX] AS [CATALOGO],        ';
  Result := Result + '    [REGIAO]                        ';
  Result := Result + '  FROM                              ';
  Result := Result + '    [Hoja nº2 tot$]                 ';
  Result := Result + '  WHERE                             ';
  Result := Result + '    [NUM_FORMULA] <> ""                 ';
end;

procedure TGravandoExecucaoRoberloCores.GravarRegistro(qryDestino: IDataSet; Excel: Variant;
  Linha: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ROB_CADROB', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('ROB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('ROB_CODIGO').AsString := Excel.Cells[Linha, 1].Text;
  qryDestino.FieldByName('ROB_SERIE_').AsString := Excel.Cells[Linha, 2].Text;
  qryDestino.FieldByName('ROB_MARCA_').AsString := Excel.Cells[Linha, 3].Text;
  qryDestino.FieldByName('ROB_NOMCOR').AsString := Excel.Cells[Linha, 4].Text;
  qryDestino.FieldByName('ROB_CODCOR').AsString := Excel.Cells[Linha, 5].Text;
  qryDestino.FieldByName('ROB_VARIAN').AsString := Excel.Cells[Linha, 6].Text;
  qryDestino.FieldByName('ROB_MODELO').AsString := Excel.Cells[Linha, 7].Text;
  qryDestino.FieldByName('ROB_GRUCOR').AsString := Excel.Cells[Linha, 8].Text;
  qryDestino.FieldByName('ROB_ANOINI').AsString := Excel.Cells[Linha, 10].Text;
  qryDestino.FieldByName('ROB_ANOFIN').AsString := Excel.Cells[Linha, 11].Text;
  qryDestino.FieldByName('ROB_CAMADA').AsString := Excel.Cells[Linha, 12].Text;
  qryDestino.FieldByName('ROB_CATALO').AsString := Excel.Cells[Linha, 13].Text;
  qryDestino.FieldByName('ROB_REGIAO').AsString := Excel.Cells[Linha, 16].Text;
  qryDestino.FieldByName('ROB_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('ROB_CODIGO').AsString +
                                                          qryDestino.FieldByName('ROB_SERIE_').AsString +
                                                          qryDestino.FieldByName('ROB_MARCA_').AsString +
                                                          qryDestino.FieldByName('ROB_CODCOR').AsString +
                                                          qryDestino.FieldByName('ROB_NOMCOR').AsString +
                                                          qryDestino.FieldByName('ROB_VARIAN').AsString +
                                                          qryDestino.FieldByName('ROB_GRUCOR').AsString +
                                                          qryDestino.FieldByName('ROB_CATALO').AsString +
                                                          qryDestino.FieldByName('ROB_REGIAO').AsString +
                                                          qryDestino.FieldByName('ROB_MODELO').AsString +
                                                          qryDestino.FieldByName('ROB_ANOINI').AsString +
                                                          qryDestino.FieldByName('ROB_ANOFIN').AsString);
  qryDestino.FieldByName('ROB_ATIVO_').AsString := 'S';
  qryDestino.Post;
end;

function TGravandoExecucaoRoberloCores.IsRegistroExistente(qryDestino: IDataSet; Excel: Variant;
  Linha: Integer): Boolean;
begin
  Result := False;
end;

end.
