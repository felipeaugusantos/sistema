{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Ciacollor *}
{*******************************************************************************PH*}
unit untGravandoExecucaoCiacollorNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoCiacollorNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
//    function fBaseProduto(strCodBas, strCodUni: String): String;
    function fRetPesoUnidade(fltVolOri: Double; fltVolumeUni: Double): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
     const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    function fHabilitaOpcao(): Boolean;
    procedure Executar(const gravando: IGravando);
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoCiacollorNovasFormulas }

constructor TGravandoExecucaoCiacollorNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoCiacollorNovasFormulas.Executar(const gravando: IGravando);
//const
//  arrUnidades : array[0..2] of string = ('LT', 'GL', 'LA');
//  arrPesos    : array[0..2] of Double = (1, 4, 20);
var
  qryCadNfm          : IDataSet;
  qryCadCIA          : IDataSet;
  qryBases           : IDataSet;
  intCont            : Integer;
//  intUnidade         : Integer;
  strMd5             : String;
//  intGerarUnidades   : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM CIA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadCIA := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CIA_CADCIA');
      gravando.Texto := 'PROCOD verificado com sucesso!';

//      if (blnGerarUnidades) then
//        intGerarUnidades := 2
//      else
//        intGerarUnidades := 0;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '      , BAS_VOLUME              ' +
                        '   FROM CIA_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT = :PRODUT    ' +
                        '    AND BAS_CODBAS = :CODBAS    ' ;

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;
        While Not qryBases.Eof Do
        Begin
//        for intUnidade := 0 To intGerarUnidades Do
//        begin
          Try
            qryCadCIA.SQL := 'SELECT * FROM CIA_CADCIA WHERE FALSE';
            qryCadCIA.Open;

            qryCadCIA.Insert;
            qryCadCIA.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CIA_CADCIA',TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCIA.FieldByName('CIA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCIA.FieldByName('CIA_UNIDAD').AsString := qryBases.FieldByName('BAS_CODUNI').AsString; //arrUnidades[intUnidade];
            qryCadCIA.FieldByName('CIA_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString; //arrUnidades[intUnidade];
            qryCadCIA.FieldByName('CIA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadCIA.FieldByName('CIA_VOLUME').AsString := qryBases.FieldByName('BAS_VOLUME').AsString;
            qryCadCIA.FieldByName('CIA_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadCIA.FieldByName('CIA_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
            qryCadCIA.FieldByName('CIA_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString; //fBaseProduto(qryCadNfm.FieldByName('NFM_BASE__').AsString, arrUnidades[intUnidade]);
            qryCadCIA.FieldByName('CIA_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
            qryCadCIA.FieldByName('CIA_COLECA').AsString := 'ESPECIAL';
            qryCadCIA.FieldByName('CIA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
            qryCadCIA.FieldByName('CIA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            for intCont := 1 to 20 do
            begin
              if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                Break;

              if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                Break;

              qryCadCIA.FieldByName('CIA_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString :=
                qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString;

              qryCadCIA.FieldByName('CIA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryCadNfm.FieldByName('NFM_VOLUME').AsFloat, qryBases.FieldByName('BAS_VOLUME').AsFloat);
            end;

            strMd5 := '';

            strMd5 := strMd5 +
                     qryCadCIA.FieldByName('CIA_CODEMP').AsString + qryCadCIA.FieldByName('CIA_UNIDAD').AsString +
                     qryCadCIA.FieldByName('CIA_CODUNI').AsString + qryCadCIA.FieldByName('CIA_DESCRI').AsString +
                     qryCadCIA.FieldByName('CIA_VOLUME').AsString + qryCadCIA.FieldByName('CIA_NOMCOR').AsString +
                     qryCadCIA.FieldByName('CIA_PRODUT').AsString + qryCadCIA.FieldByName('CIA_CODBAS').AsString +
                     qryCadCIA.FieldByName('CIA_COLECA').AsString;

            for intCont := 1 to 20 do
            begin
              if TStrUtils.fEmptyStr(qryCadCIA.FieldByName('CIA_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                Break;

              strMd5 := strMd5 + qryCadCIA.FieldByName('CIA_FORM' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
              strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryCadCIA.FieldByName('CIA_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
                ',', '.', [rfReplaceAll]);
            end;

            qryCadCIA.FieldByName('CIA_MD5KEY').AsString := GetMD5(strMd5);

            qryCadCIA.Post;
          Except
            On E : Exception do
              gravando.Texto := 'Erro ao gerar o cadastro de Novas Fórmulas! ' + e.Message;
          end;
        //end;
          qryBases.Next;
        End;
        qryCadNfm.Next;
        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      end;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
  End;
end;

{function TGravandoExecucaoCiacollorNovasFormulas.fBaseProduto(strCodBas,
  strCodUni: String): String;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT BAS_DESCRI ' +
                  '   FROM CIA_CADBAS ' +
                  '  WHERE BAS_CODBAS = :CODBAS ' +
                  '    AND BAS_CODUNI = :CODUNI ';

    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.ParamByName('CODUNI').AsString := strCodUni;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_DESCRI').AsString;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;}

function TGravandoExecucaoCiacollorNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoCiacollorNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoCiacollorNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoCiacollorNovasFormulas.fRetPesoUnidade(fltVolOri: Double; fltVolumeUni: Double): Double;
begin
  Result := fltVolumeUni / fltVolOri;
end;

procedure TGravandoExecucaoCiacollorNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   CIA_CADCIA        ' +
          ' WHERE CIA_NOMCOR IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     CIA_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE             ' +
          ' FROM               ' +
          '   CIA_CADCIA       ' +
          ' WHERE CIA_NOMCOR = ' + QuotedStr(strCodNfm);
      end;

      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

end.
