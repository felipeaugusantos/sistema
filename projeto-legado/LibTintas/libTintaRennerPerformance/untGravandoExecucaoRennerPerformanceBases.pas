unit untGravandoExecucaoRennerPerformanceBases;

interface

uses
  untAbstractGravandoExecucaoRennerPerformance, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untStrUtils, System.Win.ComObj;

type
  TGravandoExecucaoRennerPerformanceBases = class(TAbstractGravandoExecucaoRennerPerformance)
  private
    procedure pDeletaRegistro();
    function fQtdEmbalagemMl(strEmbalagem: String): String;
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

{ TGravandoExecucaoRennerPerformanceBases }

procedure TGravandoExecucaoRennerPerformanceBases.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('REP_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Deletando registros REP_CADBAS...';
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
      qryDestino.SQL := ' SELECT * FROM REP_CADBAS  ';
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

function TGravandoExecucaoRennerPerformanceBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoRennerPerformanceBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

procedure TGravandoExecucaoRennerPerformanceBases.GravarRegistro(
  qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REP_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := Excel.Cells[intLinha, 2].Text;
  qryDestino.FieldByName('BAS_DESCRI').AsString := Excel.Cells[intLinha, 4].Text;
  qryDestino.FieldByName('BAS_PESESP').AsFloat  := StrToFloat(Excel.Cells[intLinha, 3].Text);
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := 900;
  qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
  qryDestino.Post;
end;

function TGravandoExecucaoRennerPerformanceBases.IsRegistroExistente(
  qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer): Boolean;
begin
  Result := False;

  If Excel.Cells[intLinha, 1].Text = 'Conc.' Then
    Exit(True);

  If Pos(Excel.Cells[intLinha, 2].Text, 'RHB300_RHB347_') <= 0 Then
    Exit(True);
end;

procedure TGravandoExecucaoRennerPerformanceBases.pDeletaRegistro;
begin
  TAutcomTintaFactory.Get.TruncateTable('REP_CADBAS');
end;

end.
