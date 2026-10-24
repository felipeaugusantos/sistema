{****************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Starmix *}
{*************************************************************************AC*}
unit untGravandoExecucaoStarmixCores;

interface

uses
  untAbstractGravandoExecucaoStarmix, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, untTipoCadastro, untFloatUtils, Classes;

Type
  TStaForMul = Record
    strCodBas: String;
    fltQtdBas: Double;
End;


type
  TGravandoExecucaoStarmixCores = class(TAbstractGravandoExecucaoStarmix)
  private

  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

    function fFormataMySqlFloat(fltValor: Double; intCasas: Integer): String;

    function fGravaCadStaDinamica(strCodSeq,
                                  strNomCor, strAnoCor, strCodLin, strCodMon, strUniVer, strUniDad: String;
                                  fltPesFor, fltPesCor: Double;
                                  strCodB01: String; fltQtdB01: Double;
                                  strCodB02: String; fltQtdB02: Double; strCodB03: String; fltQtdB03: Double;
                                  strCodB04: String; fltQtdB04: Double; strCodB05: String; fltQtdB05: Double;
                                  strCodB06: String; fltQtdB06: Double; strCodB07: String; fltQtdB07: Double;
                                  strCodB08: String; fltQtdB08: Double; strCodB09: String; fltQtdB09: Double;
                                  strCodB10: String; fltQtdB10: Double; strCodB11: String; fltQtdB11: Double;
                                  strCodB12: String; fltQtdB12: Double; strCodB13: String; fltQtdB13: Double;
                                  strCodB14: String; fltQtdB14: Double; strCodB15: String; fltQtdB15: Double): Boolean;

  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoStarmixCores }



procedure TGravandoExecucaoStarmixCores.Executar(const gravando: IGravando);
var
  intContador: Integer;

  intContador2: Integer;

  strLinha    : String;
  strTipReg   : String;

  stlArquivos : TStringList;
  stlArqTxt   : TStringList;

  strLinBas   : String;
  intContBas  : Integer;

  intPosFormul: Integer;
  intCodSeq   : Integer;

  strCodBas   : String;
  fltQtdBas   : Double;

  strNomCor    : String;
  strAnoCor    : String;
  fltPesCor    : Double;
  fltPesFor    : Double;
  strCodLin    : String;
  strCodMon    : String;
  strUniVer    : String;

  arrBases     : Array[1..15] Of TStaForMul;
  stlMontadoras: TStringList;
  qryTMP_CADBAS: IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto  := 'Path para a geração do arquivo não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      if gravando.Status <> sgGravando then
        Exit;

      stlArquivos := TStringList.Create;
      stlArqTxt   := TStringList.Create;

      intCodSeq := 0;

      stlArquivos.Add(GetPath);


      If (stlArquivos.Count <= 0) Then
      Begin
        gravando.Texto := 'Não encontrei nenhum arquivo para a geração!';
        Exit;
      End;


      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('STA_CADSTA', False);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Limpando tabela de formulação';
      TAutcomTintaFactory.Get.TruncateTable('STA_CADSTA');
      gravando.Texto := 'Tabela de formulação limpa com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      stlMontadoras := TStringList.Create;

      qryTMP_CADBAS     := TAutcomTintaFactory.Get.fGetDataSet;
      qryTMP_CADBAS.SQL := 'SELECT * FROM STA_CADBAS';
      qryTMP_CADBAS.Open;


      For intContador := 0 To stlArquivos.Count -1 Do
      Begin

        stlArqTxt.LoadFromFile(stlArquivos[intContador]);

        For intContador2 := 0 To stlArqTxt.Count -1 Do
        Begin
          strLinha := stlArqTxt[intContador2];

          strTipReg := Copy(strLinha, 299, 02);

          If (strTipReg = '10') Then
          Begin
            stlMontadoras.Values[Trim(Copy(strLinha, 01, 03))] := Trim(Copy(strLinha, 04, 45));
          End

          Else If (strTipReg = '60') Then
          Begin

            strNomCor := Trim(AnsiUpperCase(Copy(strLinha, 09, 45)));
            strAnoCor := Trim(AnsiUpperCase(Copy(strLinha, 88, 04)));
            fltPesCor := TAutcomTintaFactory.Get.fStrToFloat(Copy(strLinha,  92, 08 )) / 10000.00;
            fltPesFor := TAutcomTintaFactory.Get.fStrToFloat(Copy(strLinha, 100, 08 )) / 10000.00;
            strCodLin := Trim(AnsiUpperCase(Copy(strLinha, 116, 03)));
            strCodMon := Trim(AnsiUpperCase(Copy(strLinha, 119, 03)));
            strUniVer := Trim(AnsiUpperCase(Copy(strLinha, 122, 12)));

            strLinBas := TStrUtils.fPadr( Copy(strLinha, 134, Length(strLinha)), 165);

            If (fltPesFor = 0.0) Then
            Begin
              gravando.Texto := 'A cor ' + strNomCor + ' está com o peso da fórmula Zerado. Essa Cor não será gerada!';
              Continue;
            End;

            For intContBas := Low(arrBases) To High(arrBases) Do
            Begin
              arrBases[intContBas].strCodBas := '';
              arrBases[intContBas].fltQtdBas := 0.0;
            End;

            intContBas   := 1;
            intPosFormul := Low(arrBases);

            While (intContBas < Length(strLinBas)) Do
            Begin

              strCodBas := Copy(strLinBas, intContBas, 3);
              fltQtdBas := TAutcomTintaFactory.Get.fStrToFloat(Copy(strLinBas, intContBas + 3, 8)) / 10000;

              If Not TStrUtils.fEmptyStr(strCodBas) Then
              Begin
                qryTMP_CADBAS.Locate('BAS_CODSEQ', strCodBas, []);

                arrBases[intPosFormul].strCodBas := TrimRight(qryTMP_CADBAS.FieldByName('BAS_CODBAS').AsString);
                arrBases[intPosFormul].fltQtdBas := fltQtdBas;
                Inc(intPosFormul);
              End;

              Inc(intContBas, 11);
            End;

            Inc(intCodSeq);

            fGravaCadStaDinamica(TStrUtils.fStrZero(intCodSeq, 6),
                                 strNomCor,
                                 strAnoCor,
                                 strCodLin,
                                 stlMontadoras.Values[strCodMon],
                                 strUniVer,
                                 'LT',
                                 fltPesFor,
                                 fltPesCor,
                                 arrBases[01].strCodBas,
                                 arrBases[01].fltQtdBas,
                                 arrBases[02].strCodBas,
                                 arrBases[02].fltQtdBas,
                                 arrBases[03].strCodBas,
                                 arrBases[03].fltQtdBas,
                                 arrBases[04].strCodBas,
                                 arrBases[04].fltQtdBas,
                                 arrBases[05].strCodBas,
                                 arrBases[05].fltQtdBas,
                                 arrBases[06].strCodBas,
                                 arrBases[06].fltQtdBas,
                                 arrBases[07].strCodBas,
                                 arrBases[07].fltQtdBas,
                                 arrBases[08].strCodBas,
                                 arrBases[08].fltQtdBas,
                                 arrBases[09].strCodBas,
                                 arrBases[09].fltQtdBas,
                                 arrBases[10].strCodBas,
                                 arrBases[10].fltQtdBas,
                                 arrBases[11].strCodBas,
                                 arrBases[11].fltQtdBas,
                                 arrBases[12].strCodBas,
                                 arrBases[12].fltQtdBas,
                                 arrBases[13].strCodBas,
                                 arrBases[13].fltQtdBas,
                                 arrBases[14].strCodBas,
                                 arrBases[14].fltQtdBas,
                                 arrBases[15].strCodBas,
                                 arrBases[15].fltQtdBas);


          End;

          Gravando.RegistrarProgresso(0, intContador2, stlArqTxt.Count);

        End;

      End;

    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;


function TGravandoExecucaoStarmixCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoStarmixCores.fFormataMySqlFloat(fltValor: Double; intCasas: Integer): String;
begin
  Result := AnsiReplaceStr(FormatFloat('0.' + DupeString('0', intCasas), fltValor), ',', '.');
end;


function TGravandoExecucaoStarmixCores.fGravaCadStaDinamica(strCodSeq,
  strNomCor, strAnoCor, strCodLin, strCodMon, strUniVer, strUniDad: String;
  fltPesFor, fltPesCor: Double;
  strCodB01: String; fltQtdB01: Double;
  strCodB02: String; fltQtdB02: Double; strCodB03: String; fltQtdB03: Double;
  strCodB04: String; fltQtdB04: Double; strCodB05: String; fltQtdB05: Double;
  strCodB06: String; fltQtdB06: Double; strCodB07: String; fltQtdB07: Double;
  strCodB08: String; fltQtdB08: Double; strCodB09: String; fltQtdB09: Double;
  strCodB10: String; fltQtdB10: Double; strCodB11: String; fltQtdB11: Double;
  strCodB12: String; fltQtdB12: Double; strCodB13: String; fltQtdB13: Double;
  strCodB14: String; fltQtdB14: Double; strCodB15: String; fltQtdB15: Double): Boolean;
  Var
    qryInsert   : IDataSet;
//    intContador : Integer;
begin

  Try
    qryInsert := TAutcomTintaFactory.Get.fGetDataSet;
    qryInsert.SQL := TAutcomTintaFactory.Get.GetInsert('STA_CADSTA');


    qryInsert.ParamByName('STA_CODSEQ').AsString   := strCodSeq;
    qryInsert.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('STA_CADSTA', TAutcomTintaFactory.Get.GetCodEmp);
    qryInsert.ParamByName('STA_DTACAD').AsDateTime := Date;
    qryInsert.ParamByName('STA_NOMCOR').AsString   := strNomCor;
    qryInsert.ParamByName('STA_ANOCOR').AsString   := strAnoCor;
    qryInsert.ParamByName('STA_CODLIN').AsString   := strCodLin;
    qryInsert.ParamByName('STA_MONTAD').AsString   := strCodMon;
    qryInsert.ParamByName('STA_UNIVER').AsString   := strUniVer;
    qryInsert.ParamByName('STA_UNIDAD').AsString   := strUniDad;
    qryInsert.ParamByName('STA_PESFOR').AsFloat    := fltPesFor;
    qryInsert.ParamByName('STA_PESCOR').AsFloat    := fltPesCor;
    qryInsert.ParamByName('STA_CODB01').AsString   := strCodB01;
    qryInsert.ParamByName('STA_QTDB01').AsFloat    := fltQtdB01;
    qryInsert.ParamByName('STA_CODB02').AsString   := strCodB02;
    qryInsert.ParamByName('STA_QTDB02').AsFloat    := fltQtdB02;
    qryInsert.ParamByName('STA_CODB03').AsString   := strCodB03;
    qryInsert.ParamByName('STA_QTDB03').AsFloat    := fltQtdB03;
    qryInsert.ParamByName('STA_CODB04').AsString   := strCodB04;
    qryInsert.ParamByName('STA_QTDB04').AsFloat    := fltQtdB04;
    qryInsert.ParamByName('STA_CODB05').AsString   := strCodB05;
    qryInsert.ParamByName('STA_QTDB05').AsFloat    := fltQtdB05;
    qryInsert.ParamByName('STA_CODB06').AsString   := strCodB06;
    qryInsert.ParamByName('STA_QTDB06').AsFloat    := fltQtdB06;
    qryInsert.ParamByName('STA_CODB07').AsString   := strCodB07;
    qryInsert.ParamByName('STA_QTDB07').AsFloat    := fltQtdB07;
    qryInsert.ParamByName('STA_CODB08').AsString   := strCodB08;
    qryInsert.ParamByName('STA_QTDB08').AsFloat    := fltQtdB08;
    qryInsert.ParamByName('STA_CODB09').AsString   := strCodB09;
    qryInsert.ParamByName('STA_QTDB09').AsFloat    := fltQtdB09;
    qryInsert.ParamByName('STA_CODB10').AsString   := strCodB10;
    qryInsert.ParamByName('STA_QTDB10').AsFloat    := fltQtdB10;
    qryInsert.ParamByName('STA_CODB11').AsString   := strCodB11;
    qryInsert.ParamByName('STA_QTDB11').AsFloat    := fltQtdB11;
    qryInsert.ParamByName('STA_CODB12').AsString   := strCodB12;
    qryInsert.ParamByName('STA_QTDB12').AsFloat    := fltQtdB12;
    qryInsert.ParamByName('STA_CODB13').AsString   := strCodB13;
    qryInsert.ParamByName('STA_QTDB13').AsFloat    := fltQtdB13;
    qryInsert.ParamByName('STA_CODB14').AsString   := strCodB14;
    qryInsert.ParamByName('STA_QTDB14').AsFloat    := fltQtdB14;
    qryInsert.ParamByName('STA_CODB15').AsString   := strCodB15;
    qryInsert.ParamByName('STA_QTDB15').AsFloat    := fltQtdB15;

    qryInsert.ParamByName('STA_MD5KEY').AsString := GetMD5(qryInsert.ParamByName('STA_NOMCOR').AsString +
                                                           qryInsert.ParamByName('STA_ANOCOR').AsString +
                                                           qryInsert.ParamByName('STA_CODLIN').AsString +
                                                           qryInsert.ParamByName('STA_CODMON').AsString +
                                                           qryInsert.ParamByName('STA_UNIVER').AsString +
                                                           qryInsert.ParamByName('STA_UNIDAD').AsString +
                                                           qryInsert.ParamByName('STA_MONTAD').AsString +
                                                           fFormataMySqlFloat(qryInsert.ParamByName('STA_PESCOR').AsFloat, 4) +
                                                           fFormataMySqlFloat(qryInsert.ParamByName('STA_PESFOR').AsFloat, 4) +
                                                           qryInsert.ParamByName('STA_DESLIN').AsString);

    qryInsert.ExecSQL;

    Result := True;

  Except
    Result := False;
  End;

end;

end.

