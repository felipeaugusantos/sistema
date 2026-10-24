{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta PPX *}
{********************************************************************************AC*}
unit untGravandoExecucaoPpgNexaImportaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Classes, StrUtils, System.Win.ComObj, Variants;

type
  TGravandoExecucaoPpgNexaImportaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    intPrxNfm: Integer;
    function fVerificaNovFormulas(strCodNfm: String): Boolean;
    function fVerificaNfmCadastrada(strDtaCad: String;
                                    strDesCor: String;
                                    strVarian: String;
                                    strVeicul: String;
                                    strMontad: String;
                                    strTipSis: String;
                                    strAtiCad: String = 'S';
                                    strBase01: String = '';
                                    strQtde01: String = '';
                                    strBase02: String = '';
                                    strQtde02: String = '';
                                    strBase03: String = '';
                                    strQtde03: String = '';
                                    strBase04: String = '';
                                    strQtde04: String = '';
                                    strBase05: String = '';
                                    strQtde05: String = '';
                                    strBase06: String = '';
                                    strQtde06: String = '';
                                    strBase07: String = '';
                                    strQtde07: String = '';
                                    strBase08: String = '';
                                    strQtde08: String = '';
                                    strBase09: String = '';
                                    strQtde09: String = '';
                                    strBase10: String = '';
                                    strQtde10: String = '';
                                    strBase11: String = '';
                                    strQtde11: String = '';
                                    strBase12: String = '';
                                    strQtde12: String = '';
                                    strBase13: String = '';
                                    strQtde13: String = '';
                                    strBase14: String = '';
                                    strQtde14: String = '';
                                    strBase15: String = '';
                                    strQtde15: String = '';
                                    strBase16: String = '';
                                    strQtde16: String = '';
                                    strBase17: String = '';
                                    strQtde17: String = '';
                                    strBase18: String = '';
                                    strQtde18: String = '';
                                    strBase19: String = '';
                                    strQtde19: String = '';
                                    strBase20: String = '';
                                    strQtde20: String = ''): Boolean;
    function fRetornaBaseContador2a11(intContador: Integer;
                                      strBase02: String = '';
                                      strBase03: String = '';
                                      strBase04: String = '';
                                      strBase05: String = '';
                                      strBase06: String = '';
                                      strBase07: String = '';
                                      strBase08: String = '';
                                      strBase09: String = '';
                                      strBase10: String = '';
                                      strBase11: String = ''): String;
    function fRetornaBaseContador12a20(intContador: Integer;
                                      strBase12: String = '';
                                      strBase13: String = '';
                                      strBase14: String = '';
                                      strBase15: String = '';
                                      strBase16: String = '';
                                      strBase17: String = '';
                                      strBase18: String = '';
                                      strBase19: String = '';
                                      strBase20: String = ''): String;
    function fRetornaQtdeContador2a11(intContador: Integer;
                                      strQtde02: String = '';
                                      strQtde03: String = '';
                                      strQtde04: String = '';
                                      strQtde05: String = '';
                                      strQtde06: String = '';
                                      strQtde07: String = '';
                                      strQtde08: String = '';
                                      strQtde09: String = '';
                                      strQtde10: String = '';
                                      strQtde11: String = ''): String;
    function fRetornaQtdeContador12a20(intContador: Integer;
                                      strQtde12: String = '';
                                      strQtde13: String = '';
                                      strQtde14: String = '';
                                      strQtde15: String = '';
                                      strQtde16: String = '';
                                      strQtde17: String = '';
                                      strQtde18: String = '';
                                      strQtde19: String = '';
                                      strQtde20: String = ''): String;
    function fSqlSelectIntContador2a11(strBase02: String = '';
                                      strBase03: String = '';
                                      strBase04: String = '';
                                      strBase05: String = '';
                                      strBase06: String = '';
                                      strBase07: String = '';
                                      strBase08: String = '';
                                      strBase09: String = '';
                                      strBase10: String = '';
                                      strBase11: String = '';
                                      strQtde02: String = '';
                                      strQtde03: String = '';
                                      strQtde04: String = '';
                                      strQtde05: String = '';
                                      strQtde06: String = '';
                                      strQtde07: String = '';
                                      strQtde08: String = '';
                                      strQtde09: String = '';
                                      strQtde10: String = '';
                                      strQtde11: String = ''): String;
    function fSqlSelectIntContador12a20(strBase12: String = '';
                                        strBase13: String = '';
                                        strBase14: String = '';
                                        strBase15: String = '';
                                        strBase16: String = '';
                                        strBase17: String = '';
                                        strBase18: String = '';
                                        strBase19: String = '';
                                        strBase20: String = '';
                                        strQtde12: String = '';
                                        strQtde13: String = '';
                                        strQtde14: String = '';
                                        strQtde15: String = '';
                                        strQtde16: String = '';
                                        strQtde17: String = '';
                                        strQtde18: String = '';
                                        strQtde19: String = '';
                                        strQtde20: String = ''): String;
    procedure GravarNovaFormula(qryDestino: IDataSet; Excel: Variant; RecNo: Integer);
    function fGetPath: String;
    function TemAtributo(Attr, Val: Integer): Boolean;
    function FQtdArqsExcel(strDiretorio: String; stlNome: TStringList): Integer;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
    function fRetProxCodSeq : Integer;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoPpgNexaImportaNovasFormulas }

constructor TGravandoExecucaoPpgNexaImportaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoPpgNexaImportaNovasFormulas.Executar(const gravando: IGravando);
Var
  qryNovasFormulas   : IDataSet;
  intQtdArqsExcel    : Integer;
  stlNomeArqsExcel   : TStringList;
  intContador        : Integer;
  strPathArquivo     : String;
  Excel: Variant;
  ExcelNfm: Variant;
  RecordCount,
  RecNo: Integer;
  blnExisteNovaFormula: Boolean;
begin
  Try
    Try
      If Not DirectoryExists(fGetPath) Then
      Begin
        Gravando.Texto := Format('O diretorio [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      qryNovasFormulas := TAutcomTintaFactory.Get.fGetDataSet;
      qryNovasFormulas.SQL := ' SELECT * FROM PPX_CADNFM WHERE FALSE    ';
      qryNovasFormulas.Open;

      stlNomeArqsExcel := TStringList.Create();

      intQtdArqsExcel := FQtdArqsExcel(fGetPath, stlNomeArqsExcel);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      For intContador := 0 To intQtdArqsExcel - 1 Do
      Begin
        Try
          strPathArquivo := fGetPath + '\' + stlNomeArqsExcel[intContador];

          If Not FileExists(strPathArquivo) Then
          Begin
            Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(strPathArquivo, '"', '')]);
            Exit;
          End;

          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('PPX_CADNFM');
          Gravando.Texto := 'PROCOD verificado com sucesso...';

          Gravando.Texto := 'Abrindo Importação de Novas Fórmulas: [ ' + strPathArquivo + ' ]';

          ExcelNfm := CreateOleObject('Excel.Application');
          ExcelNfm.Visible := False;
          ExcelNfm.WorkBooks.Open(strPathArquivo);
          Excel := ExcelNfm.WorkBooks[1].WorkSheets[1];
          RecordCount := Excel.Cells.SpecialCells(11).Row;

          Gravando.Texto := 'Processando Importação: [ ' + strPathArquivo + ' ]';

          For RecNo := 2 To RecordCount Do
          Begin
            If (Gravando.Status <> sgGravando) Then
              Break;

            intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('PPX').fGetInteger('PROCOD');


            Repeat
              strCodNfm := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp + TStrUtils.fStrZero(intPrxNfm, 5);

              Inc(intPrxNfm);
            Until (fVerificaNovFormulas(strCodNfm));



            blnExisteNovaFormula := fVerificaNfmCadastrada(Excel.Cells[RecNo, 1].Text,
                                                           Excel.Cells[RecNo, 3].Text,
                                                           Excel.Cells[RecNo, 6].Text,
                                                           Excel.Cells[RecNo, 2].Text,
                                                           Excel.Cells[RecNo, 4].Text,
                                                           Excel.Cells[RecNo, 5].Text,
                                                           'S',
                                                           Excel.Cells[RecNo, 7].Text,
                                                           Excel.Cells[RecNo, 8].Text,
                                                           Excel.Cells[RecNo, 9].Text,
                                                           Excel.Cells[RecNo, 10].Text,
                                                           Excel.Cells[RecNo, 11].Text,
                                                           Excel.Cells[RecNo, 12].Text,
                                                           Excel.Cells[RecNo, 13].Text,
                                                           Excel.Cells[RecNo, 14].Text,
                                                           Excel.Cells[RecNo, 15].Text,
                                                           Excel.Cells[RecNo, 16].Text,
                                                           Excel.Cells[RecNo, 17].Text,
                                                           Excel.Cells[RecNo, 18].Text,
                                                           Excel.Cells[RecNo, 19].Text,
                                                           Excel.Cells[RecNo, 20].Text,
                                                           Excel.Cells[RecNo, 21].Text,
                                                           Excel.Cells[RecNo, 22].Text,
                                                           Excel.Cells[RecNo, 23].Text,
                                                           Excel.Cells[RecNo, 24].Text,
                                                           Excel.Cells[RecNo, 25].Text,
                                                           Excel.Cells[RecNo, 26].Text,
                                                           Excel.Cells[RecNo, 27].Text,
                                                           Excel.Cells[RecNo, 28].Text,
                                                           Excel.Cells[RecNo, 29].Text,
                                                           Excel.Cells[RecNo, 30].Text,
                                                           Excel.Cells[RecNo, 31].Text,
                                                           Excel.Cells[RecNo, 32].Text,
                                                           Excel.Cells[RecNo, 33].Text,
                                                           Excel.Cells[RecNo, 34].Text,
                                                           Excel.Cells[RecNo, 35].Text,
                                                           Excel.Cells[RecNo, 36].Text,
                                                           Excel.Cells[RecNo, 37].Text,
                                                           Excel.Cells[RecNo, 38].Text,
                                                           Excel.Cells[RecNo, 39].Text,
                                                           Excel.Cells[RecNo, 40].Text,
                                                           Excel.Cells[RecNo, 41].Text,
                                                           Excel.Cells[RecNo, 42].Text,
                                                           Excel.Cells[RecNo, 43].Text,
                                                           Excel.Cells[RecNo, 44].Text,
                                                           Excel.Cells[RecNo, 45].Text,
                                                           Excel.Cells[RecNo, 46].Text);


            If Not blnExisteNovaFormula Then
            Begin
              GravarNovaFormula(qryNovasFormulas, Excel, RecNo);
              TAutcomTintaFactory.Get.fGetConfTinta('PPX').pSet('PROCOD', TStrUtils.fStrZero(intPrxNfm, 5));
            End;

            Gravando.RegistrarProgresso(0, RecNo, RecordCount);
          End;
        Finally
          ExcelNfm.Quit;
          ExcelNfm := Unassigned;
          Excel     := Unassigned;
        End;
      End;
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Importação de Novas Fórmulas';
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fGetPath: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('PPX').fGet('PATINV');
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('PPX').fGet('USAINV') <> 'N';
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fRetornaBaseContador12a20(intContador: Integer;
                                                                               strBase12: String = '';
                                                                               strBase13: String = '';
                                                                               strBase14: String = '';
                                                                               strBase15: String = '';
                                                                               strBase16: String = '';
                                                                               strBase17: String = '';
                                                                               strBase18: String = '';
                                                                               strBase19: String = '';
                                                                               strBase20: String = ''): String;
begin
  If intContador = 12 Then
    Result := strBase12
  Else If intContador = 13 Then
    Result := strBase13
  Else If intContador = 14 Then
    Result := strBase14
  Else If intContador = 15 Then
    Result := strBase15
  Else If intContador = 16 Then
    Result := strBase16
  Else If intContador = 17 Then
    Result := strBase17
  Else If intContador = 18 Then
    Result := strBase18
  Else If intContador = 19 Then
    Result := strBase19
  Else If intContador = 20 Then
    Result := strBase20;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fRetornaBaseContador2a11(intContador: Integer;
                                                                               strBase02: String = '';
                                                                               strBase03: String = '';
                                                                               strBase04: String = '';
                                                                               strBase05: String = '';
                                                                               strBase06: String = '';
                                                                               strBase07: String = '';
                                                                               strBase08: String = '';
                                                                               strBase09: String = '';
                                                                               strBase10: String = '';
                                                                               strBase11: String = ''): String;
begin
  If intContador = 2 Then
    Result := strBase02
  Else If intContador = 3 Then
    Result := strBase03
  Else If intContador = 4 Then
    Result := strBase04
  Else If intContador = 5 Then
    Result := strBase05
  Else If intContador = 6 Then
    Result := strBase06
  Else If intContador = 7 Then
    Result := strBase07
  Else If intContador = 8 Then
    Result := strBase08
  Else If intContador = 9 Then
    Result := strBase09
  Else If intContador = 10 Then
    Result := strBase10
  Else If intContador = 11 Then
    Result := strBase11;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fRetornaQtdeContador12a20(
  intContador: Integer; strQtde12, strQtde13, strQtde14, strQtde15, strQtde16,
  strQtde17, strQtde18, strQtde19, strQtde20: String): String;
begin
  If intContador = 12 Then
    Result := strQtde12
  Else If intContador = 13 Then
    Result := strQtde13
  Else If intContador = 14 Then
    Result := strQtde14
  Else If intContador = 15 Then
    Result := strQtde15
  Else If intContador = 16 Then
    Result := strQtde16
  Else If intContador = 17 Then
    Result := strQtde17
  Else If intContador = 18 Then
    Result := strQtde18
  Else If intContador = 19 Then
    Result := strQtde19
  Else If intContador = 20 Then
    Result := strQtde20;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fRetornaQtdeContador2a11(
  intContador: Integer; strQtde02, strQtde03, strQtde04, strQtde05, strQtde06,
  strQtde07, strQtde08, strQtde09, strQtde10, strQtde11: String): String;
begin
  If intContador = 2 Then
    Result := strQtde02
  Else If intContador = 3 Then
    Result := strQtde03
  Else If intContador = 4 Then
    Result := strQtde04
  Else If intContador = 5 Then
    Result := strQtde05
  Else If intContador = 6 Then
    Result := strQtde06
  Else If intContador = 7 Then
    Result := strQtde07
  Else If intContador = 8 Then
    Result := strQtde08
  Else If intContador = 9 Then
    Result := strQtde09
  Else If intContador = 10 Then
    Result := strQtde10
  Else If intContador = 11 Then
    Result := strQtde11;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fRetProxCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT (IFNULL(MAX(PPX_CODSEQ), 0) + 1) PROX '+
                '  FROM PPX_CADPPX;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;

end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fSqlSelectIntContador12a20(
  strBase12, strBase13, strBase14, strBase15, strBase16, strBase17, strBase18,
  strBase19, strBase20, strQtde12, strQtde13, strQtde14, strQtde15, strQtde16,
  strQtde17, strQtde18, strQtde19, strQtde20: String): String;
Var
  intContador: Integer;
begin
  Result := '';

  For intContador := 12 To 20 Do
  Begin
    If (Not TStrUtils.fEmptyStr(fRetornaBaseContador12a20(intContador, strBase12, strBase13, strBase14, strBase15, strBase16, strBase17, strBase18, strBase19, strBase20)))
      And (fRetornaBaseContador12a20(intContador, strBase12, strBase13, strBase14, strBase15, strBase16, strBase17, strBase18, strBase19, strBase20) <> '0') Then
      Result := Result + '  AND NFM_CODB' + TStrUtils.fStrZero(intContador, 2) + ' = :CODB' + TStrUtils.fStrZero(intContador, 2)  + '     ';

    If (Not TStrUtils.fEmptyStr(fRetornaQtdeContador12a20(intContador, strQtde12, strQtde13, strQtde14, strQtde15, strQtde16, strQtde17, strQtde18, strQtde19, strQtde20)))
      And (fRetornaQtdeContador12a20(intContador, strQtde12, strQtde13, strQtde14, strQtde15, strQtde16, strQtde17, strQtde18, strQtde19, strQtde20) <> '0') Then
      Result := Result + '  AND NFM_QTDB' + TStrUtils.fStrZero(intContador, 2) + ' = :QTDB' + TStrUtils.fStrZero(intContador, 2)  + '     ';
  End;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fSqlSelectIntContador2a11(strBase02: String = '';
                                                                                strBase03: String = '';
                                                                                strBase04: String = '';
                                                                                strBase05: String = '';
                                                                                strBase06: String = '';
                                                                                strBase07: String = '';
                                                                                strBase08: String = '';
                                                                                strBase09: String = '';
                                                                                strBase10: String = '';
                                                                                strBase11: String = '';
                                                                                strQtde02: String = '';
                                                                                strQtde03: String = '';
                                                                                strQtde04: String = '';
                                                                                strQtde05: String = '';
                                                                                strQtde06: String = '';
                                                                                strQtde07: String = '';
                                                                                strQtde08: String = '';
                                                                                strQtde09: String = '';
                                                                                strQtde10: String = '';
                                                                                strQtde11: String = ''): String;
Var
  intContador: Integer;
begin
  Result := '';

  For intContador := 2 To 11 Do
  Begin
    If (Not TStrUtils.fEmptyStr(fRetornaBaseContador2a11(intContador, strBase02, strBase03, strBase04, strBase05, strBase06, strBase07, strBase08, strBase09, strBase10, strBase11)))
      And (fRetornaBaseContador2a11(intContador, strBase02, strBase03, strBase04, strBase05, strBase06, strBase07, strBase08, strBase09, strBase10, strBase11) <> '0') Then
      Result := Result + '  AND NFM_CODB' + TStrUtils.fStrZero(intContador, 2) + ' = :CODB' + TStrUtils.fStrZero(intContador, 2)  + '     ';

    If (Not TStrUtils.fEmptyStr(fRetornaQtdeContador2a11(intContador, strQtde02, strQtde03, strQtde04, strQtde05, strQtde06, strQtde07, strQtde08, strQtde09, strQtde10, strQtde11)))
      And (fRetornaQtdeContador2a11(intContador, strQtde02, strQtde03, strQtde04, strQtde05, strQtde06, strQtde07, strQtde08, strQtde09, strQtde10, strQtde11) <> '0') Then
      Result := Result + '  AND NFM_QTDB' + TStrUtils.fStrZero(intContador, 2) + ' = :QTDB' + TStrUtils.fStrZero(intContador, 2)  + '     ';
  End;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fVerificaNfmCadastrada(
  strDtaCad, strDesCor, strVarian, strVeicul, strMontad, strTipSis, strAtiCad,
  strBase01: String; strQtde01: String; strBase02: String; strQtde02: String;
  strBase03: String; strQtde03: String; strBase04: String; strQtde04: String;
  strBase05: String; strQtde05: String; strBase06: String; strQtde06: String;
  strBase07: String; strQtde07: String; strBase08: String; strQtde08: String;
  strBase09: String; strQtde09: String; strBase10: String; strQtde10: String;
  strBase11: String; strQtde11: String; strBase12: String; strQtde12: String;
  strBase13: String; strQtde13: String; strBase14: String; strQtde14: String;
  strBase15: String; strQtde15: String; strBase16: String; strQtde16: String;
  strBase17: String; strQtde17: String; strBase18: String; strQtde18: String;
  strBase19: String; strQtde19: String; strBase20: String;
  strQtde20: String): Boolean;
Var
  qryNfm: IDataSet;
  intContador: Integer;
begin
  Try
    qryNfm := TAutcomTintaFactory.Get.fGetDataSet;
    qryNfm.Close;
    qryNfm.SQL := ' SELECT                    ';
    qryNfm.SQL := qryNfm.SQL + '    *         ';
    qryNfm.SQL := qryNfm.SQL + '  FROM        ';
    qryNfm.SQL := qryNfm.SQL + '    PPX_CADNFM      ';
    qryNfm.SQL := qryNfm.SQL + '  WHERE       ';
    qryNfm.SQL := qryNfm.SQL + '    TRUE AND        ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_DESCOR = :DESCOR AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_VARIAN = :VARIAN AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_VEICUL = :VEICUL AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_MONTAD = :MONTAD AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_TIPO__ = :TIPO__ AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_ATIVO_ = :ATIVO_ AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_DTACAD = :DTACAD AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_CODB01 = :CODB01 AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_QTDB01 = :QTDB01          ';

    qryNfm.SQL := qryNfm.SQL + fSqlSelectIntContador2a11(strBase02, strBase03, strBase04, strBase05, strBase06, strBase07, strBase08, strBase09, strBase10, strBase11,
                                                         strQtde02, strQtde03, strQtde04, strQtde05, strQtde06, strQtde07, strQtde08, strQtde09, strQtde10, strQtde11);
    qryNfm.SQL := qryNfm.SQL + fSqlSelectIntContador12a20(strBase12, strBase13, strBase14, strBase15, strBase16, strBase17, strBase18, strBase19, strBase20,
                                                         strQtde12, strQtde13, strQtde14, strQtde15, strQtde16, strQtde17, strQtde18, strQtde19, strQtde20);

    qryNfm.ParamByName('DTACAD').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(strDtaCad));
    qryNfm.ParamByName('DESCOR').AsString := strDesCor;
    qryNfm.ParamByName('VARIAN').AsString := strVarian;
    qryNfm.ParamByName('VEICUL').AsString := strVeicul;
    qryNfm.ParamByName('MONTAD').AsString := strMontad;
    qryNfm.ParamByName('TIPO__').AsString := strTipSis;
    qryNfm.ParamByName('ATIVO_').AsString := strAtiCad;
    qryNfm.ParamByName('CODB01').AsString := strBase01;
    qryNfm.ParamByName('QTDB01').AsFloat  := StrToFloat(strQtde01);


    For intContador := 2 To 11 Do
    Begin
      If (Not TStrUtils.fEmptyStr(fRetornaBaseContador2a11(intContador, strBase02, strBase03, strBase04, strBase05, strBase06, strBase07, strBase08, strBase09, strBase10, strBase11)))
        And (fRetornaBaseContador2a11(intContador, strBase02, strBase03, strBase04, strBase05, strBase06, strBase07, strBase08, strBase09, strBase10, strBase11) <> '0') Then
        qryNfm.ParamByName('CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := fRetornaBaseContador2a11(intContador, strBase02, strBase03, strBase04, strBase05,
                                                                                                             strBase06, strBase07, strBase08, strBase09, strBase10, strBase11);

      If (Not TStrUtils.fEmptyStr(fRetornaQtdeContador2a11(intContador, strQtde02, strQtde03, strQtde04, strQtde05, strQtde06, strQtde07, strQtde08, strQtde09, strQtde10, strQtde11)))
        And (fRetornaQtdeContador2a11(intContador, strQtde02, strQtde03, strQtde04, strQtde05, strQtde06, strQtde07, strQtde08, strQtde09, strQtde10, strQtde11) <> '0') Then
        qryNfm.ParamByName('QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(fRetornaQtdeContador2a11(intContador, strQtde02, strQtde03, strQtde04, strQtde05,
                                                                                                                        strQtde06, strQtde07, strQtde08, strQtde09, strQtde10, strQtde11));
    End;

    For intContador := 12 To 20 Do
    Begin
      If (Not TStrUtils.fEmptyStr(fRetornaBaseContador12a20(intContador, strBase12, strBase13, strBase14, strBase15, strBase16, strBase17, strBase18, strBase19, strBase20)))
        And (fRetornaBaseContador12a20(intContador, strBase12, strBase13, strBase14, strBase15, strBase16, strBase17, strBase18, strBase19, strBase20) <> '0') Then
        qryNfm.ParamByName('CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := fRetornaBaseContador12a20(intContador, strBase12, strBase13, strBase14, strBase15,
                                                                                                              strBase16, strBase17, strBase18, strBase19, strBase20);

      If (Not TStrUtils.fEmptyStr(fRetornaQtdeContador12a20(intContador, strQtde12, strQtde13, strQtde14, strQtde15, strQtde16, strQtde17, strQtde18, strQtde19, strQtde20)))
        And (fRetornaQtdeContador12a20(intContador, strQtde12, strQtde13, strQtde14, strQtde15, strQtde16, strQtde17, strQtde18, strQtde19, strQtde20) <> '0') Then
        qryNfm.ParamByName('QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(fRetornaQtdeContador12a20(intContador, strQtde12, strQtde13, strQtde14, strQtde15,
                                                                                                                         strQtde16, strQtde17, strQtde18, strQtde19, strQtde20));
    End;

    qryNfm.Open;

    Result := (Not qryNfm.IsEmpty);
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                              ';
  qryGen.SQL := qryGen.SQL + '    * FROM PPX_CADNFM     ';
  qryGen.SQL := qryGen.SQL + '  WHERE NFM_CODNFM = :NFM ';
  qryGen.ParamByName('NFM').AsString  :=  strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TGravandoExecucaoPpgNexaImportaNovasFormulas.GravarNovaFormula(
  qryDestino: IDataSet; Excel: Variant; RecNo: Integer);
Var
  intContador: Integer;
  intQuantidade: Integer;
  intColorante: Integer;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPX_CADNFM', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('NFM_CODNFM').AsString := strCodNfm;
  qryDestino.FieldByName('NFM_DESCOR').AsString := Excel.Cells[RecNo, 3].Text;
  qryDestino.FieldByName('NFM_VARIAN').AsString := Excel.Cells[RecNo, 6].Text;
  qryDestino.FieldByName('NFM_VEICUL').AsString := Excel.Cells[RecNo, 2].Text;
  qryDestino.FieldByName('NFM_MONTAD').AsString := Excel.Cells[RecNo, 4].Text;
  qryDestino.FieldByName('NFM_TIPO__').AsString := Excel.Cells[RecNo, 5].Text;
  qryDestino.FieldByName('NFM_ATIVO_').AsString := 'S';
  qryDestino.FieldByName('NFM_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('NFM_CODB01').AsString := Excel.Cells[RecNo, 7].Text;
  qryDestino.FieldByName('NFM_QTDB01').AsFloat  := StrToFloat(Excel.Cells[RecNo, 8].Text);
  qryDestino.FieldByName('NFM_DTACAD').AsString := FormatDateTime('dd/mm/yy',  StrToDate(Excel.Cells[RecNo, 1].Text));

  intColorante := 9;
  intQuantidade := 10;


  For intContador := 2 To 20 Do
  Begin
    If (Not TStrUtils.fEmptyStr(Excel.Cells[RecNo, intColorante].Text)) And (Excel.Cells[RecNo, intColorante].Text <> '0') Then
      qryDestino.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString  := Excel.Cells[RecNo, intColorante].Text;

    If (Not TStrUtils.fEmptyStr(Excel.Cells[RecNo, intQuantidade].Text)) And (Excel.Cells[RecNo, intQuantidade].Text <> '0') Then
      qryDestino.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := StrToFloat(Excel.Cells[RecNo, intQuantidade].Text);

    Inc(intColorante, 2);
    Inc(intQuantidade, 2);
  End;

  qryDestino.Post;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.FQtdArqsExcel(
  strDiretorio: String; stlNome: TStringList): Integer;
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  Result := 0;

  intContador := FindFirst(strDiretorio + '\*.xlsx', faAnyFile, Pesquisa);

  Try
    While intContador = 0 Do
    Begin
      If TemAtributo(Pesquisa.Attr, faDirectory) Then
      Begin
        If (Pesquisa.Name <> '.') Then
        Begin
          If (Pesquisa.Name <> '..') Then
          Begin
            TempNome := strDiretorio + '\' + Pesquisa.Name;
            FQtdArqsExcel(TempNome, stlNome);
          End;
        End;
      End
      Else
      Begin
        Result := Result + 1;
        stlNome.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally
    SysUtils.FindClose(Pesquisa);
  End;
end;

function TGravandoExecucaoPpgNexaImportaNovasFormulas.TemAtributo(Attr,
  Val: Integer): Boolean;
begin
  Result := False;

  If Attr = Val Then
  Begin
    If Val = Val Then
      Result := True;
  End;
end;

end.
