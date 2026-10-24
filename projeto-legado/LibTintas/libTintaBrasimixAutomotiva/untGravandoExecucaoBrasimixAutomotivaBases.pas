{************************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta BrasimixAutomotiva *}
{*********************************************************************************AC*}
unit untGravandoExecucaoBrasimixAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoBrasimixAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

type
  TGravandoExecucaoBrasimixAutomotivaBases = class(TAbstractGravandoExecucaoBrasimixAutomotiva)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  Private


  end;

    TFormBases = Record
      strCodBas : String;
    end;


implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoBrasimixAutomotivaBases }

procedure TGravandoExecucaoBrasimixAutomotivaBases.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;
  qryDelete   : IDataSet;
  arqBzaTxt   : TextFile;

  strLinha    : String;
  strArquivo  : String;
//  strCodBases : String;

  intTotLinhas: Integer;
  intProgresso: Integer;

  intCont     : Integer;
  strBases    : String;
  arrBases    : array of TFormBases;
begin

  Try
    Try
      strArquivo := conf.fGet('BZAPAT');


      If Not FileExists(strArquivo) Then
      begin
        gravando.Texto := 'Não foi encontrado o arquivo para geração.' + #13#10 +'Caminho: ' + strArquivo;
        Exit;
      end;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BZA_CADBAS', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';


      gravando.Texto := 'Limpando os registros da tabela de bases...';
      qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelete.SQL := 'TRUNCATE BZA_CADBAS ';
      qryDelete.ExecSQL;

      gravando.Texto := 'Carregando os registros para geração... ';
      AssignFile(arqBzaTxt, strArquivo);
      Reset(arqBzaTxt);


      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'SELECT * FROM BZA_CADBAS';
      qryDestino.Open;

      gravando.Texto := 'Iniciando a geração do arquivo de bases... ';

      intProgresso := 0;
      intTotLinhas := fRetTotLinhas(strArquivo);

      SetLength(arrBases, 0);

      While (Not Eof(arqBzaTxt)) Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        Readln(arqBzaTxt, strLinha);

        strBases  :=  Copy(strLinha, 172, Length(strLinha));

        SetLength(arrBases, 0);

        While (Not TStrUtils.fEmptyStr(strBases)) Do
        Begin
          SetLength(arrBases, Length(arrBases) + 1);
          arrBases[Length(arrBases) - 1].strCodBas := Trim(Copy(strBases, 1, 7));

          strBases := Copy(strBases, 8, Length(strBases));
          strBases := Copy(strBases, 10, Length(strBases));
        End;

        Inc(intProgresso);

        For intCont := Low(arrBases) To High(arrBases) Do
        Begin
          If Not qryDestino.Locate('BAS_CODBAS', arrBases[intCont].strCodBas, []) Then
          Begin
            qryDestino.Insert;
            qryDestino.FieldByName('BAS_CODBAS').AsString := arrBases[intCont].strCodBas;
//            qryDestino.FieldByName('BAS_DESBAS').AsString := arrBases[intCont].strCodBas;
            qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryDestino.FieldByName('BAS_PESPEC').AsFloat  := 0;
            qryDestino.FieldByName('BAS_EMBALA').AsFloat  := 0;
            qryDestino.Post;
          End;
        End;


        gravando.RegistrarProgresso(0, intProgresso, intTotLinhas);
      End;

    Except
      On e : Exception do
        gravando.Texto := 'Erro ao gerar o arquivo de bases.' + #13 + e.message;
    End;

  Finally
    CloseFile(arqBzaTxt);
  End;

end;

function TGravandoExecucaoBrasimixAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


end.
