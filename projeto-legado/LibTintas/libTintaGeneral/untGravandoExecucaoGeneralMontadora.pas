{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta General *}
{***********************************************************************AC*}
unit untGravandoExecucaoGeneralMontadora;

interface

uses
  untAbstractGravandoExecucaoGeneral, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

type
  TGravandoExecucaoGeneralMontadora = class(TAbstractGravandoExecucaoGeneral)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  Private
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoGeneralMontadora }

procedure TGravandoExecucaoGeneralMontadora.Executar(const gravando: IGravando);
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

      If (Not FileExists(GetPath +'/Montadoras.xls')) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de montadora não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(GetPath+'/Montadoras.xls');

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('GEN_CADMON');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Sheet:= Planilha.Workbooks[1].WorkSheets['Plan1'];

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
                              '  FROM GEN_CADMON '+
                              ' WHERE MON_CODMON = :CODMON';
            qryDestino.ParamByName('CODMON').AsString := strCodCol;
            qryDestino.Open;

            If (qryDestino.IsEmpty) Then
            Begin
              qryDestino.Insert;

              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GEN_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('MON_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('MON_CODMON').AsString := Sheet.cells[intLinha, 1].Text;
              qryDestino.FieldByName('MON_DESCRI').AsString := Sheet.cells[intLinha, 2].Text;
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

function TGravandoExecucaoGeneralMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;



end.
