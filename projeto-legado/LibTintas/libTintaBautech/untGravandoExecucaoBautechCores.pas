{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Bautech *}
{**********************************************************************PH*}
unit untGravandoExecucaoBautechCores;

interface

uses
  untAbstractGravandoExecucaoBautech, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj;

type
  TGravandoExecucaoBautechCores = class(TAbstractGravandoExecucaoBautech)
  public
    procedure GerarMd5CadBAU(const gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoBautechCores }


procedure TGravandoExecucaoBautechCores.GerarMd5CadBAU(const gravando: IGravando);
var
  qrySelect: IDataSet;
  strMd5: String;
  intContador: Integer;
begin

  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := 'SELECT * FROM BAU_CADBAU';
  qrySelect.Open;

  qrySelect.First;
  While Not qrySelect.Eof Do
  Begin

    strMd5 := '';

    strMd5 := strMd5 + qrySelect.FieldByName('BAU_CODBAS').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('BAU_PRODUT').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('BAU_DESCRI').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('BAU_UNIDAD').AsString;

    for intContador := 1 to 20 do
    begin
      strMd5 := strMd5 + qrySelect.FieldByName('BAU_FORM' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySelect.FieldByName('BAU_QTDB' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    qrySelect.Edit;
    qrySelect.FieldByName('BAU_MD5KEY').AsString := strMd5;
    qrySelect.Post;

    gravando.RegistrarProgresso(0, qrySelect.RecNo, qrySelect.RecordCount);

    qrySelect.Next;
  End;
end;


procedure TGravandoExecucaoBautechCores.Executar(const gravando: IGravando);
Const
  arrCodUni: Array [0..2] Of String = ('LT','GL','LA');
Var
  strNameSheet: String;
  qryDestino  : IDataSet;
  qryBase     : IDataSet;
  Planilha    : OleVariant;
  Sheet       : OleVariant;
  intUltLinha : Integer;
  intLinha    : Integer;
  intCont     : Integer;
begin
  Try
    Try
      for intCont := 0 To 2 Do
      begin
        Try
          Try
            gravando.Texto := 'Validando Path de Arquivos ...';

            If (Not fValidaPath) Then
            Begin
              gravando.Texto := 'Path para o geração do arquivo de cores não é válido...';
              gravando.Cancelar;
              Exit;
            End;

            gravando.Texto := 'Path validado com sucesso ...';

            gravando.Texto := 'Carregando dados...';

            Planilha := CreateOleObject('Excel.Application');
            Planilha.WorkBooks.open(GetPath);

            gravando.Texto := 'Dados carregados com sucesso!';

            gravando.Texto := 'Verificando PROCOD...';
            TAutcomTintaFactory.Get.fInsereProCod('BAU_CADBAU');
            gravando.Texto := 'PROCOD verificado com sucesso!';

            Case intCont of
              0 :  strNameSheet := 'Quarto';
              1 :  strNameSheet := 'Galão';
              2 :  strNameSheet := 'Lata';
            end;

            Sheet:= Planilha.Workbooks[1].WorkSheets[strNameSheet];

            intUltLinha := Sheet.Cells.SpecialCells(11).Row;

            intLinha := 1;

            gravando.RegistrarProgresso(0, intLinha, intUltLinha);


            While (intLinha <= intUltLinha) Do
            begin
              Try
                Try
                  if gravando.Status <> sgGravando then
                    Exit;

                  qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

                  qryDestino.SQL := 'SELECT * '+
                                    '  FROM BAU_CADBAU '+
                                    ' WHERE BAU_CODBAS = :CODBAS '+
                                    '   AND BAU_CODUNI = :CODUNI '+
                                    '   AND BAU_DESCRI = :DESCRI ';
                  qryDestino.ParamByName('DESCRI').AsString := Sheet.cells[intLinha, 1].Text;
                  qryDestino.ParamByName('CODBAS').AsString := Sheet.cells[intLinha, 2].Text;
                  qryDestino.ParamByName('CODUNI').AsString := arrCodUni[intCont];
                  qryDestino.Open;

                  If (qryDestino.IsEmpty) Then
                  Begin
                    qryBase := TAutcomTintaFactory.Get.fGetDataSet;
                    qryBase.SQL := 'SELECT BAS_DESCRI   '+
                                   '     , BAS_CODUNI   '+
                                   '  FROM BAU_CADBAS   '+
                                   ' WHERE BAS_CODBAS = :CODBAS'+
                                   '  AND BAS_CODUNI  = :CODUNI';
                    qryBase.ParamByName('CODBAS').AsString := Sheet.cells[intLinha, 2].Text;
                    qryBase.ParamByName('CODUNI').AsString := arrCodUni[intCont];
                    qryBase.Open;

                    qryBase.First;

                    While not (qryBase.Eof) do
                    Begin
                      qryDestino.Insert;
                      qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BAU_CADBAU', TAutcomTintaFactory.Get.GetCodEmp);
                      qryDestino.FieldByName('BAU_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                      qryDestino.FieldByName('BAU_DESCRI').AsString := Sheet.cells[intLinha, 1].Text;
                      qryDestino.FieldByName('BAU_NOMCOR').AsString := Sheet.cells[intLinha, 1].Text;
                      qryDestino.FieldByName('BAU_CODBAS').AsString := Sheet.cells[intLinha, 2].Text;
                      qryDestino.FieldByName('BAU_CODUNI').AsString := qryBase.FieldByName('BAS_CODUNI').AsString;
                      qryDestino.FieldByName('BAU_UNIDAD').AsString := qryBase.FieldByName('BAS_CODUNI').AsString;

                      qryDestino.FieldByName('BAU_FORM01').AsString := Sheet.cells[intLinha, 4].Text;
                      qryDestino.FieldByName('BAU_QTDB01').AsString := Sheet.cells[intLinha, 5].Text;

                      qryDestino.FieldByName('BAU_FORM02').AsString := Sheet.cells[intLinha, 6].Text;
                      qryDestino.FieldByName('BAU_QTDB02').AsString := Sheet.cells[intLinha, 7].Text;

                      qryDestino.FieldByName('BAU_FORM03').AsString := Sheet.cells[intLinha, 8].Text;
                      qryDestino.FieldByName('BAU_QTDB03').AsString := Sheet.cells[intLinha, 9].Text;

                      qryDestino.FieldByName('BAU_FORM04').AsString := Sheet.cells[intLinha, 10].Text;
                      qryDestino.FieldByName('BAU_QTDB04').AsString := Sheet.cells[intLinha, 11].Text;

                      qryDestino.FieldByName('BAU_FORM05').AsString := Sheet.cells[intLinha, 12].Text;
                      qryDestino.FieldByName('BAU_QTDB05').AsString := Sheet.cells[intLinha, 13].Text;

                      qryDestino.FieldByName('BAU_PRODUT').AsString := qryBase.FieldByName('BAS_DESCRI').AsString;
                      qryDestino.Post;

                      qryBase.Next;
                    end;
                  end;
                  Inc(intLinha);
                Except
                  on E: Exception do
                  begin
                    gravando.Cancelar;
                    gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
                  end;
                End;
              Finally
                if (intLinha <= intUltLinha) Then
                  gravando.RegistrarProgresso(0, intLinha, intUltLinha);
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

      gravando.Texto := 'Calculando BAU_MD5KEY...';
      GerarMd5CadBAU(gravando);
      gravando.Texto := 'BAU_MD5KEY Calculado com sucesso!';
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoBautechCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


end.
