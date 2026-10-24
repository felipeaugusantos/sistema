{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta General *}
{***********************************************************************AC*}
unit untGravandoExecucaoGeneralCores;

interface

uses
  untAbstractGravandoExecucaoGeneral, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

type
  TGravandoExecucaoGeneralCores = class(TAbstractGravandoExecucaoGeneral)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;


  Private
    procedure GerarMd5CadGEN(const gravando: IGravando);
    function fDiluente(strBase : String) : Boolean;
    Var
      qryBase: IDataSet;
  end;

implementation

uses
  untIConfTinta, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoGeneralCores }

procedure TGravandoExecucaoGeneralCores.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;

  Planilha    : OleVariant;
  Sheet       : OleVariant;
  strPath     : String;

  PlanilhaComp : OleVariant;
  SheetComp    : OleVariant;
  strPathComp  : String;

  intFormula  : Integer;

  intUltLinha : Integer;
  intLinha    : Integer;
  intLinhaProg: Integer;
begin
  Try
    Try
      intFormula := 0;
      gravando.Texto := 'Validando Path de Arquivos ...';

      strPath := GetPath +'/Formulas.xls';

      If (Not FileExists(strPath)) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de fórmulas não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      strPathComp := GetPath+'/FormulasComp.xls';

      If (Not FileExists(strPathComp)) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de complementos das fórmulas não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(strPath);

      // Planilha de Complemento
      PlanilhaComp := CreateOleObject('Excel.Application');
      PlanilhaComp.WorkBooks.open(strPathComp);


      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('GEN_CADGEN', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Sheet     := Planilha.Workbooks[1].WorkSheets['Plan1'];

      SheetComp := PlanilhaComp.Workbooks[1].WorkSheets['Plan1'];

      intUltLinha := Sheet.Cells.SpecialCells(11).Row;

      intLinha     := 2;
      intLinhaProg := 1;


      gravando.Texto := 'Excluindo os registros da tabela de formulação...';
      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'DELETE FROM GEN_CADGEN';
      qryDestino.ExecSQL;

      gravando.RegistrarProgresso(0, intLinhaProg , intUltLinha);

      gravando.Texto := 'Iniciando a geração dos registros de formulação...';

      qryBase := TAutcomTintaFactory.Get.fGetDataSet;

      While (intLinha <= intUltLinha) Do
      begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            qryDestino.SQL := '';
            qryDestino.SQL := 'SELECT *                    '+
                              '  FROM GEN_CADGEN           '+
                              ' WHERE GEN_CODIGO = :CODIGO '+
                              '   AND GEN_VARIAC = :VARICA;';


            qryDestino.ParamByName('CODIGO').AsString := Sheet.cells[intLinha, 1].Text;
            qryDestino.ParamByName('VARICA').AsString := Sheet.cells[intLinha, 2].Text;
            qryDestino.Open;


            If (qryDestino.IsEmpty) Then
            Begin
              intFormula := 1;
              qryDestino.Insert;
              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GEN_CADGEN', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('GEN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('GEN_CODIGO').AsString := Sheet.cells[intLinha, 1].Text;
              qryDestino.FieldByName('GEN_VARIAC').AsString := Sheet.cells[intLinha, 2].Text;

              if fDiluente(Sheet.cells[intLinha, 3].Text)Then
                qryDestino.FieldByName('GEN_DILUID').AsString := 'S';

              If TStrUtils.fEmptyStr(Sheet.cells[intLinha, 3].Text) Then
                Break;

              qryDestino.FieldByName('GEN_FORM01').AsString := Sheet.cells[intLinha, 3].Text;
              qryDestino.FieldByName('GEN_QTDC01').AsString := Sheet.cells[intLinha, 4].Text;
              qryDestino.Post;
            End
            Else
            Begin
              Inc(intFormula);

              qryDestino.Edit;

              if fDiluente(Sheet.cells[intLinha, 3].Text)Then
                qryDestino.FieldByName('GEN_DILUID').AsString := 'S';

              qryDestino.FieldByName('GEN_FORM' + TStrUtils.fStrZero(intFormula, 2)).AsString := Sheet.cells[intLinha, 3].Text;
              qryDestino.FieldByName('GEN_QTDC' + TStrUtils.fStrZero(intFormula, 2)).AsFloat  := Sheet.cells[intLinha, 4].Text;
              qryDestino.Post;
            End;

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

      intLinha     := 2;
      intLinhaProg := 1;
      intUltLinha := SheetComp.Cells.SpecialCells(11).Row;

      gravando.Texto := 'Iniciando a geração informações complementares...';

      While (intLinha <= intUltLinha) Do
      begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            qryDestino.SQL := '';
            qryDestino.SQL := 'SELECT *                    '+
                              '  FROM GEN_CADGEN           '+
                              ' WHERE GEN_CODIGO = :CODIGO '+
                              '   AND GEN_VARIAC = :VARICA;';

            qryDestino.ParamByName('CODIGO').AsString := SheetComp.cells[intLinha, 1].Text;
            qryDestino.ParamByName('VARICA').AsString := SheetComp.cells[intLinha, 2].Text;
            qryDestino.Open;


            If Not(qryDestino.IsEmpty) Then
            Begin
              qryDestino.Edit;
              qryDestino.FieldByName('GEN_DESCRI').AsString := SheetComp.cells[intLinha, 3].Text;
              qryDestino.FieldByName('GEN_CODMON').AsFloat  := SheetComp.cells[intLinha, 4].Text;
              qryDestino.FieldByName('GEN_ANOINI').AsString := SheetComp.cells[intLinha, 5].Text;
              qryDestino.FieldByName('GEN_ANOFIM').AsString := SheetComp.cells[intLinha, 6].Text;
              qryDestino.Post;
            End;

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
      GerarMd5CadGEN(gravando);
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    gravando.Texto := 'Cadastro concluido com sucesso!';
    Planilha.WorkBooks.Close;
    PlanilhaComp.WorkBooks.Close;
  End;
end;

function TGravandoExecucaoGeneralCores.fDiluente(strBase: String): Boolean;
begin
  qryBase.SQL := 'SELECT BAS_DESCRI '+
                 '  FROM GEN_CADBAS '+
                 ' WHERE BAS_CODBAS = '+ strBase;
  qryBase.Open;

  Result := Pos(' PU', UpperCase(qryBase.FieldByName('BAS_DESCRI').AsString)) > 0;
end;

function TGravandoExecucaoGeneralCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

procedure TGravandoExecucaoGeneralCores.GerarMd5CadGEN(
  const gravando: IGravando);
var
  qrySelect: IDataSet;
  strMd5: String;
  intContador: Integer;
begin

  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := 'SELECT * FROM GEN_CADGEN';
  qrySelect.Open;

  qrySelect.First;

  While Not qrySelect.Eof Do
  Begin
    strMd5 := '';

    strMd5 := strMd5 + qrySelect.FieldByName('AUTOINCREM').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_CODIGO').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_VARIAC').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_DESCRI').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_CODMON').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_ANOINI').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_ANOFIM').AsString;

    for intContador := 1 to 20 do
    begin
      strMd5 := strMd5 + qrySelect.FieldByName('GEN_FORM' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySelect.FieldByName('GEN_QTDC' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    qrySelect.Edit;
    qrySelect.FieldByName('GEN_MD5KEY').AsString := strMd5;
    qrySelect.Post;

    gravando.RegistrarProgresso(0, qrySelect.RecNo, qrySelect.RecordCount);

    qrySelect.Next;
  End;
end;


end.
