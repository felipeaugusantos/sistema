{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta BrasimixAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoBrasimixAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoBrasimixAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

  type
    TGravandoExecucaoBrasimixAutomotivaCores = class(TAbstractGravandoExecucaoBrasimixAutomotiva)
    public
      function fGetNomeGravacao: string; override;
      procedure Executar(const gravando: IGravando); override;
      procedure pExcluindoMDDuplicados(const gravando: IGravando);

    Private

    End;

    TFormBases = Record
      strCodBas : String;
      fltQtdBas : Double;
    end;



implementation

uses
  untIConfTinta, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoBrasimixAutomotivaCores }

procedure TGravandoExecucaoBrasimixAutomotivaCores.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;
  qryDelete   : IDataSet;
  arqBzaTxt   : TextFile;
  strLinha    : String;
  strArquivo  : String;
  intTotLinhas: Integer;
  intCont     : Integer;
  intProgresso: Integer;
  strMd5      : String;

  arrBases    : array of TFormBases;

  strCodigo   : String;
  strTipo     : String;
  strMontad   : String;
  strAno      : String;
  strDescri   : String;
  strCodUni   : String;
  strBases    : String;
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
      TAutcomTintaFactory.Get.fInsereProCod('BZA_CADBZA', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';


      gravando.Texto := 'Limpando os registros da tabela de cores...';
      qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelete.SQL := 'TRUNCATE BZA_CADBZA';
      qryDelete.ExecSQL;

      gravando.Texto := 'Carregando os registros para geração... ';
      AssignFile(arqBzaTxt, strArquivo);
      Reset(arqBzaTxt);


      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'SELECT * FROM BZA_CADBZA';
      qryDestino.Open;

      gravando.Texto := 'Iniciando a geração do arquivo de cores... ';

      intProgresso := 0;
      intTotLinhas := fRetTotLinhas(strArquivo);

      SetLength(arrBases, 0);

      gravando.RegistrarProgresso(0, 0 , intTotLinhas);

      While (Not Eof(arqBzaTxt)) Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        Readln(arqBzaTxt, strLinha);

        strCodigo :=  Copy(strLinha, 001, 006);
        strTipo   :=  fProcessaTipo(Copy(strLinha, 007, 002));
        strMontad :=  Trim(Copy(strLinha, 009, 050));
        strAno    :=  Copy(strLinha, 059, 004);
        strDescri :=  Trim(Copy(strLinha, 063, 050));
        strCodUni :=  Trim(copy(strLinha, 113, 050));

        Inc(intProgresso);

        If Not qryDestino.Locate('BZA_DESCRI;BZA_CODSEQ',VarArrayOf([strDescri, strCodigo]), []) Then
        Begin
          qryDestino.Insert;
          qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZA_CADBZA', TAutcomTintaFactory.Get.GetCodEmp);
          qryDestino.FieldByName('BZA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryDestino.FieldByName('BZA_CODSEQ').AsString := strCodigo;
          qryDestino.FieldByName('BZA_DTACAD').AsDate   := Date;
          qryDestino.FieldByName('BZA_MONTAD').AsString := strMontad;
          qryDestino.FieldByName('BZA_A_N_O_').AsString := strAno;
          qryDestino.FieldByName('BZA_DESCRI').AsString := strDescri;
          qryDestino.FieldByName('BZA_CODUNI').AsString := strCodUni;
          qryDestino.FieldByName('BZA_ARQTXT').AsString := strTipo;

          SetLength(arrBases, 0);

          strBases  :=  Copy(strLinha, 172, Length(strLinha));

          While (Not TStrUtils.fEmptyStr(strBases)) Do
          Begin
            SetLength(arrBases, Length(arrBases) + 1);
            arrBases[Length(arrBases) - 1].strCodBas := Trim(Copy(strBases, 1, 7));

            strBases := Copy(strBases, 8, Length(strBases));
            arrBases[Length(arrBases) - 1].fltQtdBas := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strBases, 1, 9), '-', '')) / 100;
            strBases := Copy(strBases, 10, Length(strBases));
          End;


          For intCont := Low(arrBases) To High(arrBases) Do
          Begin
            qryDestino.FieldByName('BZA_CODB' + TStrUtils.fStrZero(intCont + 1, 2)).AsString := arrBases[intCont].strCodBas;
            qryDestino.FieldByName('BZA_QTDB' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloat  := arrBases[intCont].fltQtdBas;
          End;

          strMd5 := '';
          strMd5 := (qryDestino.FieldByName('BZA_MONTAD').AsString +
                     qryDestino.FieldByName('BZA_A_N_O_').AsString +
                     qryDestino.FieldByName('BZA_DESCRI').AsString +
                     qryDestino.FieldByName('BZA_CODUNI').AsString +
                     qryDestino.FieldByName('BZA_ARQTXT').AsString);


          for intCont := 1 to 20 do
          begin
            If TStrUtils.fEmptyStr(qryDestino.FieldByName('BZA_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
              Break;

            strMd5 := strMd5 + qryDestino.FieldByName('BZA_CODB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
            strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryDestino.FieldByName('BZA_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
              ',', '.', [rfReplaceAll]);
          end;

          strMd5 := GetMD5(strMd5);

          qryDestino.FieldByName('BZA_MD5KEY').AsString := strMd5;

          qryDestino.Post;
        End;

        gravando.RegistrarProgresso(0, intProgresso, intTotLinhas);
      End;

      gravando.Texto := 'Excluindo as fórmulas duplicadas...';
      pExcluindoMDDuplicados(gravando);

    Except
      On e : Exception do
        gravando.Texto := 'Erro ao gerar o arquivo de cores.' + #13 + e.message;
    End;

  Finally
    CloseFile(arqBzaTxt);
    gravando.Texto := 'Geração conluída com sucesso!';
  End;

end;

function TGravandoExecucaoBrasimixAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

procedure TGravandoExecucaoBrasimixAutomotivaCores.pExcluindoMDDuplicados(const gravando: IGravando);
var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        BZA_MD5KEY       ' +
                '   FROM BZA_CADBZA       ' +
                '  GROUP BY BZA_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';
  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    gravando.Texto := 'Excluindo arquivos duplicados BZA_CADBZA...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM BZA_CADBZA ' +
                    '  WHERE BZA_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('BZA_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;

  End;

end;

end.
