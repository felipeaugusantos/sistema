{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Bautech *}
{***************************************************************************PH*}
unit untGravandoExecucaoBautechColorantes;

interface

uses
  untAbstractGravandoExecucaoBautech, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs;
type
  TGravandoExecucaoBautechColorantes = class(TAbstractGravandoExecucaoBautech)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoBautechCores }

procedure TGravandoExecucaoBautechColorantes.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;
  Planilha    : OleVariant;
  Sheet       : OleVariant;
  intUltLinha : Integer;
  intLinha    : Integer;
  intLinhaProg: Integer;
  strCodCol   : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de Colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(GetPath);

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BAU_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Sheet:= Planilha.Workbooks[1].WorkSheets['Colorantes'];

      intUltLinha := Sheet.Cells.SpecialCells(11).Row;

      intLinha     := 2;
      intLinhaProg := 1;

      gravando.RegistrarProgresso(0, intLinhaProg , intUltLinha);

      While (intLinha <= intUltLinha) Do
      begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            strCodCol := Sheet.cells[intLinha, 1].Text;

            qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

            qryDestino.SQL := 'SELECT * '+
                              '  FROM BAU_CADCOL '+
                              ' WHERE COL_CODCOL = :CODCOL';
            qryDestino.ParamByName('CODCOL').AsString := strCodCol;
            qryDestino.Open;

            If (qryDestino.IsEmpty) Then
            Begin
              qryDestino.Insert;

              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BAU_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('COL_CODCOL').AsString := Sheet.cells[intLinha, 1].Text;
              qryDestino.FieldByName('COL_DESCRI').AsString := Sheet.cells[intLinha, 2].Text;
              qryDestino.FieldByName('COL_EMBALA').AsString := Sheet.cells[intLinha, 3].Text;
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

function TGravandoExecucaoBautechColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;


end.

