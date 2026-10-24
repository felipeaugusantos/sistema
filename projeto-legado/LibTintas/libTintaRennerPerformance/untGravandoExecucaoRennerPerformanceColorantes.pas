unit untGravandoExecucaoRennerPerformanceColorantes;

interface

uses
  untAbstractGravandoExecucaoRennerPerformance, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untStrUtils, System.Win.ComObj;

type
  TGravandoExecucaoRennerPerformanceColorantes = class(TAbstractGravandoExecucaoRennerPerformance)
  Private
    procedure pDeletaRegistro();
  protected
    function IsRegistroExistente(qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer): Boolean; Override;
    Procedure GravarRegistro(qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer); Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoRennerPerformanceColorantes }

procedure TGravandoExecucaoRennerPerformanceColorantes.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  OleExcel, OleSheet: OleVariant;
  intContador, intTamExcel: Integer;
  strNomeArquivo: String;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path...';

      If Not fValidarDiretorio(fGetPath) Then
      Begin
        Gravando.Texto := Format('o arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      strNomeArquivo := fGetPath + '\PesosEspecificos.xlsx';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REP_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Deletando registros REP_CADCOL...';
      pDeletaRegistro();
      Gravando.Texto := 'Registros deletado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      OleExcel := CreateOleObject('Excel.Application');
      OleExcel.Visible := False;
      OleExcel.WorkBooks.Open(strNomeArquivo);
      OleSheet := OleExcel.WorkBooks[1].WorkSheets['Planilha1'];
      intTamExcel := OleSheet.Cells.SpecialCells(11).Row;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := ' SELECT * FROM REP_CADCOL  ';
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

function TGravandoExecucaoRennerPerformanceColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

procedure TGravandoExecucaoRennerPerformanceColorantes.GravarRegistro(
  qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REP_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := TrimLeft(Excel.Cells[intLinha, 2].Text);
  qryDestino.FieldByName('COL_DESCRI').AsString := TrimLeft(Excel.Cells[intLinha, 4].Text);
  qryDestino.FieldByName('COL_PESESP').AsFloat  := StrToFloat(Excel.Cells[intLinha, 3].Text);
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 900;
  qryDestino.Post;
end;

function TGravandoExecucaoRennerPerformanceColorantes.IsRegistroExistente(
  qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer): Boolean;
begin
  Result := False;

  If Excel.Cells[intLinha, 1].Text = 'Base' Then
    Exit(True);

  If Pos(Excel.Cells[intLinha, 2].Text, 'RHB300_RHB347_') > 0 Then
    Exit(True);
end;

procedure TGravandoExecucaoRennerPerformanceColorantes.pDeletaRegistro;
begin
  TAutcomTintaFactory.Get.TruncateTable('REP_CADCOL');
end;

end.
