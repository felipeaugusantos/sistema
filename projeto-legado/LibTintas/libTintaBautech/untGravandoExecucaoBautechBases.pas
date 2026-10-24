{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Bautech *}
{**********************************************************************PH*}
unit untGravandoExecucaoBautechBases;

interface

uses
  untAbstractGravandoExecucaoBautech, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando,ComObj, Dialogs;

type
  TGravandoExecucaoBautechBases = class(TAbstractGravandoExecucaoBautech)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoBautechBases }

procedure TGravandoExecucaoBautechBases.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;
  Planilha    : OleVariant;
  Sheet       : OleVariant;
  intUltLinha : Integer;
  intLinha    : Integer;
  intLinhaProg: Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(GetPath);

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BAU_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Sheet:= Planilha.Workbooks[1].WorkSheets['Bases'];

      intUltLinha := Sheet.Cells.SpecialCells(11).Row;

      intLinha     := 2;
      intLinhaProg := 1;

      gravando.RegistrarProgresso(0, intLinhaProg, intUltLinha);

      While (intLinha <= intUltLinha) Do
      begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

            qryDestino.SQL := 'SELECT * '+
                              '  FROM BAU_CADBAS '+
                              ' WHERE BAS_CODBAS  = :CODBAS '+
                              '   AND BAS_DESCRI  = :DESCRI '+
                              '   AND BAS_CODUNI  = :CODUNI ';

            qryDestino.ParamByName('CODBAS').AsString := Sheet.cells[intLinha, 1].Text;
            qryDestino.ParamByName('DESCRI').AsString := Sheet.cells[intLinha, 2].Text;
            qryDestino.ParamByName('CODUNI').AsString := Sheet.cells[intLinha, 3].Text;
            qryDestino.Open;

            If (qryDestino.IsEmpty)and (qryDestino.ParamByName('CODBAS').AsString <> '' )Then
            Begin
              qryDestino.Insert;

              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BAU_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('BAS_CODBAS').AsString := Sheet.cells[intLinha, 1].Text;
              qryDestino.FieldByName('BAS_DESCRI').AsString := Sheet.cells[intLinha, 2].Text;
              qryDestino.FieldByName('BAS_CODUNI').AsString := Sheet.cells[intLinha, 3].Text;
              qryDestino.Post;

            end;

            Inc(intLinha);
            Inc(intLinhaProg);
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

function TGravandoExecucaoBautechBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

end.
