{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta General *}
{***********************************************************************AC*}
unit untGravandoExecucaoGeneralBases;

interface

uses
  untAbstractGravandoExecucaoGeneral, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

type
  TGravandoExecucaoGeneralBases = class(TAbstractGravandoExecucaoGeneral)
  Private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  Private
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoGeneralBases }

procedure TGravandoExecucaoGeneralBases.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;
  Planilha    : OleVariant;
  Sheet       : OleVariant;

  PlanilhaEmb : OleVariant;
  SheetEmb    : OleVariant;

  intUltLinha : Integer;
  intLinha    : Integer;
  intLinhaProg: Integer;
  strCodBas   : String;
  strEmabala  : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not FileExists(GetPath +'/Bases.xls')) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando o arquivo de bases...';

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(GetPath+'/Bases.xls');

      gravando.Texto := 'Carregando o arquivo de embalagens...';

      PlanilhaEmb := CreateOleObject('Excel.Application');
      PlanilhaEmb.WorkBooks.open(GetPath+'/Embalagens.xls');

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('GEN_CADBAS');
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

            strCodBas := Sheet.cells[intLinha, 1].Text;

            qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

            qryDestino.SQL := 'SELECT * '+
                              '  FROM GEN_CADBAS '+
                              ' WHERE BAS_CODBAS = :CODBAS';
            qryDestino.ParamByName('CODBAS').AsString := strCodBas;
            qryDestino.Open;

            If (qryDestino.IsEmpty) Then
            Begin
              qryDestino.Insert;
              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GEN_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('BAS_CODBAS').AsString := Sheet.cells[intLinha, 1].Text;
              qryDestino.FieldByName('BAS_DESCRI').AsString := Sheet.cells[intLinha, 2].Text;
              qryDestino.FieldByName('BAS_PESESP').AsString := Sheet.cells[intLinha, 3].Text;
//              qryDestino.FieldByName('BAS_ORDEM_').AsString := Sheet.cells[intLinha, 5].Text;
              qryDestino.FieldByName('BAS_OBSERV').AsString := Sheet.cells[intLinha, 6].Text;
              qryDestino.FieldByName('BAS_PRECUS').AsFloat  := 0;
              qryDestino.FieldByName('BAS_MARGEM').AsFloat  := 0;
              qryDestino.FieldByName('BAS_PREVEN').AsFloat  := 0;
//              qryDestino.FieldByName('BAS_CODITE').IsNull;
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

      SheetEmb := PlanilhaEmb.Workbooks[1].WorkSheets['Plan1'];

      intUltLinha := SheetEmb.Cells.SpecialCells(11).Row;

      intLinha     := 2;
      intLinhaProg := 1;

      gravando.Texto := 'Validando as embalagens...';

      gravando.RegistrarProgresso(0, intLinhaProg , intUltLinha);

      While (intLinha <= intUltLinha) Do
      begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            strCodBas :=  StringReplace(SheetEmb.cells[intLinha, 1].Text,'.','',[rfReplaceAll]);

            qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

            qryDestino.SQL := 'SELECT * '+
                              '  FROM GEN_CADBAS '+
                              ' WHERE BAS_CODBAS = :CODBAS';
            qryDestino.ParamByName('CODBAS').AsString := strCodBas;
            qryDestino.Open;

            If Not (qryDestino.IsEmpty) Then
            Begin
              strEmabala := StringReplace(SheetEmb.cells[intLinha, 3].Text,'*','',[rfReplaceAll]);

              qryDestino.Edit;
              qryDestino.FieldByName('BAS_EMBALA').AsFloat := TAutcomTintaFactory.Get.IIF(strToFloat(strEmabala) = 0 , 0.9,strToFloat(strEmabala));
              qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat * 1000, ffNumber, 12, 0)), '.', '');
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

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

      qryDestino.SQL := 'UPDATE GEN_CADBAS '+
                        '   SET BAS_EMBALA = 0.9,' +
                        '       BAS_QTDEMB = "900 ML"   ' +
                        ' WHERE BAS_EMBALA IS NULL ';
      qryDestino.ExecSQL;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    Planilha.WorkBooks.Close;
    PlanilhaEmb.WorkBooks.Close;
  End;
end;

function TGravandoExecucaoGeneralBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoGeneralBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
