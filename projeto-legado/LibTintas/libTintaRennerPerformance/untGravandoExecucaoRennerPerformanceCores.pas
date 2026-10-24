unit untGravandoExecucaoRennerPerformanceCores;

interface

uses
  untAbstractGravandoExecucaoRennerPerformance, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, Classes, Math, Variants, System.Win.ComObj;

type
  TGravandoExecucaoRennerPerformanceCores = class(TAbstractGravandoExecucaoRennerPerformance)
  private
    intCodigo: Integer;
    procedure pDeletaRegistro();
    function fRetCodigoBase(intBases: Integer): String;
    function fRetPesoEspecifico(strPreFix, strBasCol: String): Double;
  Protected
    function IsRegistroExistente(qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer): Boolean; Override;
    Procedure GravarRegistro(qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer); Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;


implementation

uses
  untCriadorTabelas, untFuncoesGenerica;
{ TGravandoExecucaoRennerPerformanceBases }

procedure TGravandoExecucaoRennerPerformanceCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  OleExcel, OleSheet: OleVariant;
  intContador, intTamExcel: Integer;
  strNomeArquivo: String;
begin
  Try
    Try
      intCodigo := 1;

      Gravando.Texto := 'Verificando Path...';

      If Not fValidarDiretorio(fGetPath) Then
      Begin
        Gravando.Texto := Format('o arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      strNomeArquivo := fGetPath + '\Formulas.xlsx';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REP_CADREP');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Deletando registros REP_CADREP...';
      pDeletaRegistro();
      Gravando.Texto := 'Registros deletado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      OleExcel := CreateOleObject('Excel.Application');
      OleExcel.Visible := False;
      OleExcel.WorkBooks.Open(strNomeArquivo);
      OleSheet := OleExcel.WorkBooks[1].WorkSheets['Worksheet'];
      intTamExcel := OleSheet.Cells.SpecialCells(11).Row;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := ' SELECT * FROM REP_CADREP  ';
      qryDestino.Open;


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando Dados...';
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        Try
          For intContador := 2 To intTamExcel Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            If Not IsRegistroExistente(qryDestino, OleSheet, intContador) Then
              GravarRegistro(qryDestino, OleSheet, intContador);

            Gravando.RegistrarProgresso(0, intContador, intTamExcel);
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
end;

function TGravandoExecucaoRennerPerformanceCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoRennerPerformanceCores.fRetCodigoBase(
  intBases: Integer): String;
begin
  Result := 'RHB300';

  If intBases = 2 Then
    Exit('RHB347');
end;

function TGravandoExecucaoRennerPerformanceCores.fRetPesoEspecifico(strPreFix, strBasCol: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := ' SELECT ' + strPreFix + '_PESESP  ' +
                ' FROM REP_CAD' + strPreFix + ' ' +
                ' WHERE '  + strPreFix + '_COD' + strPreFix + ' = :CODIGO ';
  qryGen.ParamByName('CODIGO').AsString := strBasCol;
  qryGen.Open;

  Result := qryGen.FieldByName(strPreFix + '_PESESP').AsFloat;
end;

procedure TGravandoExecucaoRennerPerformanceCores.GravarRegistro(
  qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer);
Var
  intBases: Integer;
  intColorante: Integer;
  intContador: Integer;
begin

  For intBases := 1 To 2 Do
  Begin
    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REP_CADREP', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('REP_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('REP_CODIGO').AsString := TStrUtils.fStrZero(intCodigo, 6);
    qryDestino.FieldByName('REP_NOMCOR').AsString := Excel.Cells[intLinha, 1].Text;
    qryDestino.FieldByName('REP_PADRAO').AsString := Excel.Cells[intLinha, 2].Text;
    qryDestino.FieldByName('REP_CODBAS').AsString := fRetCodigoBase(intBases);
    qryDestino.FieldByName('REP_QTDBAS').AsFloat  := (StrToFloat(Excel.Cells[intLinha, 3].Text * fRetPesoEspecifico('BAS', fRetCodigoBase(intBases)) * 900)) / 100;
    qryDestino.FieldByName('REP_ATIVAD').AsString := 'S';

    intContador := 1;

    For intColorante := 4 To 14 Do
    Begin
      If TStrUtils.fEmptyStr(Excel.Cells[intLinha, intColorante].Text) Then
        Continue;

      qryDestino.FieldByName('REP_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := Excel.Cells[1, intColorante].Text;
      qryDestino.FieldByName('REP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := (StrToFloat(Excel.Cells[intLinha, intColorante].Text * fRetPesoEspecifico('COL', Excel.Cells[1, intColorante].Text)) * 900) / 100;

      Inc(intContador);
    End;

    qryDestino.FieldByName('REP_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('REP_CODIGO').AsString +
                                                            qryDestino.FieldByName('REP_NOMCOR').AsString +
                                                            qryDestino.FieldByName('REP_PADRAO').AsString +
                                                            qryDestino.FieldByName('REP_CODBAS').AsString);

    qryDestino.Post;

    Inc(intCodigo);
  End;
end;

function TGravandoExecucaoRennerPerformanceCores.IsRegistroExistente(
  qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoRennerPerformanceCores.pDeletaRegistro;
begin
  TAutcomTintaFactory.Get.TruncateTable('REP_CADREP');
end;

end.
