{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Jotun *}
{***************************************************************************PH*}
unit untGravandoExecucaoJotunColorantes;

interface

uses
  untAbstractGravandoExecucaoJotun, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs, Classes;
type
  TGravandoExecucaoJotunColorantes = class(TAbstractGravandoExecucaoJotun)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoJotunCores }

procedure TGravandoExecucaoJotunColorantes.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;
  Planilha    : OleVariant;
  Sheet       : OleVariant;
  intUltLinha : Integer;
  intLinha    : Integer;
  intLinhaProg: Integer;
  strCodCol   : String;
  strDescri   : String;
  strPath     : String;
  intArquivo: Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      intArquivo := fRetIntArquivo('Corantes');

      strPath := GetPath + '\' + slArquivos[intArquivo];

      If (Not FileExists(strPath)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de Colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(strPath);

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('JOT_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Sheet:= Planilha.Workbooks[1].WorkSheets[1];

      intUltLinha := Sheet.Cells.SpecialCells(11).Row;

      intLinha     := 3;
      intLinhaProg := 2;

      gravando.RegistrarProgresso(0, intLinhaProg , intUltLinha);

      While (intLinha <= intUltLinha) Do
      begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            strCodCol := copy(Sheet.cells[intLinha, 2].Text,21,2);
            strDescri := copy(Sheet.cells[intLinha, 2].Text,1,22);

            qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

            qryDestino.SQL := 'SELECT * '+
                              '  FROM JOT_CADCOL '+
                              ' WHERE COL_CODCOL = :CODCOL';
            qryDestino.ParamByName('CODCOL').AsString := strCodCol;
            qryDestino.Open;

            If (qryDestino.IsEmpty) and (strCodCol <> '')Then
            Begin
              qryDestino.Insert;

              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('JOT_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('COL_CODCOL').AsString := strCodCol;
              qryDestino.FieldByName('COL_DESCRI').AsString := strDescri;
              qryDestino.FieldByName('COL_EMBALA').AsFloat  := 3000;
              qryDestino.Post;


            end;
            Inc(intLinha);
            inc(intLinhaProg);

            gravando.RegistrarProgresso(0, intLinhaProg, intUltLinha);
          Except
            on E: Exception do
            begin
              gravando.Cancelar;
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          gravando.RegistrarProgresso(0, intLinhaProg, intUltLinha);
        End;
      end;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    Planilha.WorkBooks.Close;
  End;
end;

function TGravandoExecucaoJotunColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;


end.

