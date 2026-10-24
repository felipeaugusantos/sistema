{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Jotun *}
{**********************************************************************PH*}
unit untGravandoExecucaoJotunBases;

interface

uses
  untAbstractGravandoExecucaoJotun, untIGravando, SysUtils, untIDataSet, strUtils,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando,ComObj, Dialogs, Classes, untStrUtils;

type
  TGravandoExecucaoJotunBases = class(TAbstractGravandoExecucaoJotun)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoJotunBases }


procedure TGravandoExecucaoJotunBases.Executar(const gravando: IGravando);
Var
  qryDestino  : IDataSet;
  Planilha    : OleVariant;
  Sheet       : OleVariant;
  intUltLinha : Integer;
  intLinha    : Integer;
  strPath     : String;
  strBase     : String;
  strUnidade  : String;
  intPosicao  : Integer;
  intPosFim   : Integer;
  intArquivo: Integer;
  strTipo     : String;
  strDescri   : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      intArquivo := fRetIntArquivo('Bases');

      strPath := GetPath + '\' + slArquivos[intArquivo];

      If (Not FileExists(strPath)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('JOT_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Try
        Try
          Planilha := CreateOleObject('Excel.Application');
          Planilha.WorkBooks.open(strPath);
          Sheet:= Planilha.Workbooks[1].WorkSheets[1];

          gravando.Texto := 'Iniciando a importação do arquivo...';


          intUltLinha := Sheet.Cells.SpecialCells(11).Row;

          intLinha := 2;

          gravando.RegistrarProgresso(0, intLinha, intUltLinha);

          While (intLinha <= intUltLinha) Do
          begin
            Try
              Try
                if gravando.Status <> sgGravando then
                  Exit;

                qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

                qryDestino.SQL := 'SELECT * '+
                                  '  FROM JOT_CADBAS '+
                                  ' WHERE BAS_DESCRI = :DESCRI ';
                qryDestino.ParamByName('DESCRI').AsString := Sheet.cells[intLinha, 2].Text;
                qryDestino.Open;

                If (qryDestino.IsEmpty) and (Sheet.cells[intLinha, 2].Text <> '') Then
                Begin
                  intPosicao  := Length(Sheet.Cells[intLinha, 2].Text) - 5;

                  strDescri := Sheet.Cells[intLinha, 2].Text;

                  If Pos('13.76L', strDescri) > 0 Then
                    strUnidade := Trim(Copy(Sheet.Cells[intLinha, 2].Text, intPosicao, intPosicao + 4))
                  Else
                    strUnidade   := Trim(Copy(Sheet.cells[intLinha, 2].Text, intPosicao + 1,  intPosicao  + 4));

                  strUnidade   := AnsiReplaceStr(Copy(strUnidade, 1, pos('L',strUnidade)-1),'.',',');
                  strUnidade   := AnsiReplaceStr(strUnidade, 'A','');
                  strUnidade   := AnsiReplaceStr(strUnidade, 'W','');

                  strTipo := Copy(Sheet.cells[intLinha, 2].Text,1, pos('BASE',Sheet.cells[intLinha, 2].Text)-1);

                  intPosicao := pos('BASE',Sheet.cells[intLinha, 2].Text);

                  intPosFim  := 6;

                  strBase := Copy(Sheet.cells[intLinha, 2].Text,intPosicao, intPosFim);
                  strBase := AnsiReplaceStr(strBase, 'O','');
                  strBase := AnsiReplaceStr(strBase, 'Y','');

                  If StrToFloat(strUnidade) = 200 Then
                  Begin
                    Inc(intLinha);
                    Continue;
                  End;

                  qryDestino.Insert;
                  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('JOT_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
                  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                  qryDestino.FieldByName('BAS_CODBAS').AsString := UpperCase(strBase);

                  qryDestino.FieldByName('BAS_EMBALA').AsFloat := StrToFloat(strUnidade);

                  If Trunc(strToFloat(trim(strUnidade))) < 13 Then
                    qryDestino.FieldByName('BAS_CODUNI').AsString := 'GL'
                  Else
                    qryDestino.FieldByName('BAS_CODUNI').AsString := 'LA';

                  qryDestino.FieldByName('BAS_DESCRI').AsString := Sheet.cells[intLinha, 2].Text;
                  qryDestino.FieldByName('BAS_TIPO__').AsString := UpperCase(strTipo);
                  qryDestino.Post;
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
        Planilha.Quit;
        Planilha := Unassigned;
        Sheet := Unassigned;
      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;


function TGravandoExecucaoJotunBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

end.
