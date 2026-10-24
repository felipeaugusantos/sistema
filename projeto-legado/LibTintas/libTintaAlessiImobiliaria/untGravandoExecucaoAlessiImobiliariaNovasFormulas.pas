{*********************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Alessi Imobiliaria *}
{******************************************************************************************AC*}
unit untGravandoExecucaoAlessiImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoAlessiImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;

    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fGetFatorInteiroOnca(intParteInteira: Integer; fltParteFracao: Double; fltFator: Double): Integer;
    function fGetFatorFracaoOnca(intParteInteira: Integer; fltParteFracao: Double; fltFator: Double): Double;
    function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double;
    procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoAlessiImobiliariaNovasFormulas }

constructor TGravandoExecucaoAlessiImobiliariaNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoAlessiImobiliariaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadAle: IDataSet;
  qryBases : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM ALE_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadAle := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALE_CADALE', False);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI,                ' +
                        '        EMB_NOME__,                ' +
                        '        EMB_QTDEMB                 ' +
                        '   FROM ALE_CADBAS                 ' +
                        '  INNER JOIN CADITE                ' +
                        '     ON ITE_CODITE = BAS_CODITE    ' +
                        '  INNER JOIN ALE_CADEMB            ' +
                        '     ON BAS_CODUNI = EMB_CODUNI    ' +
                        '       AND BAS_EMBALA = EMB_NOME__ ' +
                        '  WHERE BAS_PRODUT = :PRODUT       ' +
                        '    AND BAS_BASE__ = :CODBAS       ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin

              qryCadAle.SQL := TAutcomTintaFactory.Get.GetInsert('ALE_CADALE');

              qryCadAle.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALE_CADALE', qryCadNfm.FieldByName('NFM_CODEMP').AsString);
              qryCadAle.ParamByName('ALE_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
              qryCadAle.ParamByName('ALE_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
              qryCadAle.ParamByName('ALE_EMBALA').AsString := qryBases.FieldByName('EMB_NOME__').AsString;
              qryCadAle.ParamByName('ALE_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
              qryCadAle.ParamByName('ALE_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadAle.ParamByName('ALE_NOMLON').AsString := qryCadNfm.FieldByName('NFM_NOMLON').AsString;
              qryCadAle.ParamByName('ALE_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString; //arrUnidades[intUnidades];
              qryCadAle.ParamByName('ALE_CODEMP').AsString := qryCadNfm.FieldByName('NFM_CODEMP').AsString;
              qryCadAle.ParamByName('ALE_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              for intCont := 1 to 20 do
              begin
                if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                  Break;

                qryCadAle.ParamByName('ALE_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadAle.ParamByName('ALE_QTOZ' + TStrUtils.fStrZero(intCont, 2)).AsInteger :=
                  fGetFatorInteiroOnca(qryCadNfm.FieldByName('NFM_QTOZ' + TStrUtils.fStrZero(intCont, 2)).AsInteger,
                                       qryCadNfm.FieldByName('NFM_QSHO' + TStrUtils.fStrZero(intCont, 2)).AsFloat,
                                       fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString,
                                         qryBases.RecordCount, qryCadNfm.FieldByName('NFM_CODUNI').AsString));

                qryCadAle.ParamByName('ALE_QSHO' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                  fGetFatorFracaoOnca(qryCadNfm.FieldByName('NFM_QTOZ' + TStrUtils.fStrZero(intCont, 2)).AsInteger,
                                      qryCadNfm.FieldByName('NFM_QSHO' + TStrUtils.fStrZero(intCont, 2)).AsFloat,
                                      fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString,
                                        qryBases.RecordCount, qryCadNfm.FieldByName('NFM_CODUNI').AsString));
              end;

              qryCadAle.ParamByName('ALE_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;

              qryCadAle.ParamByName('ALE_MD5KEY').AsString := GetMD5(qryCadAle.ParamByName('ALE_PRODUT').AsString +
                                                                     qryCadAle.ParamByName('ALE_BASE__').AsString +
                                                                     qryCadAle.ParamByName('ALE_EMBALA').AsString +
                                                                     qryCadAle.ParamByName('ALE_NOMCOR').AsString +
                                                                     qryCadAle.ParamByName('ALE_NOMLON').AsString +
                                                                     qryCadAle.ParamByName('ALE_CODNFM').AsString );

              qryCadAle.ParamByName('ALE_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

              qryCadAle.ExecSQL;

              if not (blnGerarUnidades) then
                Break;

              qryBases.Next;
            End;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryCadNfm.Next;
          gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoAlessiImobiliariaNovasFormulas.fGetFatorInteiroOnca(
  intParteInteira: Integer; fltParteFracao, fltFator: Double): Integer;
var
  fltCalculo: Double;
begin
  fltCalculo := OncaParaMl(intParteInteira, fltParteFracao) * fltFator;
  MlParaOnca(fltCalculo, intParteInteira, fltParteFracao);
  Result := intParteInteira;
end;

function TGravandoExecucaoAlessiImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoAlessiImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoAlessiImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAlessiImobiliariaNovasFormulas.fRetPesoUnidade(
  strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
begin
  Result := 1;
  If intRegistros = 3 Then
  Begin
    If Pos(strCodUni, 'LT_QT_') > 0 Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If strCodUni = 'LA' Then
      Result := 20;
  End
  Else If intRegistros = 2 Then
  Begin
    If strCodUni = 'LT' Then
      Result := 1
    Else If (strCodUni = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If (strCodUni = 'LA') And (strUniOri = 'LT') Then
      Result := 20
    Else If strCodUni = 'LA' Then
      Result := 5;
  End;
end;

procedure TGravandoExecucaoAlessiImobiliariaNovasFormulas.MlParaOnca(
  fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.616125);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));
end;

function TGravandoExecucaoAlessiImobiliariaNovasFormulas.OncaParaMl(
  intParteInteira: Integer; fltParteFracao: Double): Double;
begin
  Result := (intParteInteira * 29.574) + (fltParteFracao * 0.616125);
end;

function TGravandoExecucaoAlessiImobiliariaNovasFormulas.fGetFatorFracaoOnca(
  intParteInteira: Integer; fltParteFracao, fltFator: Double): Double;
var
  fltCalculo: Double;
begin
  fltCalculo := OncaParaMl(intParteInteira, fltParteFracao) * fltFator;
  MlParaOnca(fltCalculo, intParteInteira, fltParteFracao);
  Result := fltParteFracao;
end;

procedure TGravandoExecucaoAlessiImobiliariaNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   ALE_CADALE                  ' +
          ' WHERE ALE_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     ALE_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   ALE_CADALE                           ' +
          ' WHERE ALE_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     ALE_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
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
