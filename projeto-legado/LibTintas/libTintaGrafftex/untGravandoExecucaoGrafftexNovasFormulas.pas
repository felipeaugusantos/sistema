{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Grafftex *}
{*******************************************************************************PH*}
unit untGravandoExecucaoGrafftexNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoGrafftexNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
//    function fBaseProduto(strCodBas, strCodUni: String): String;
    function fRetFatorUnidade(fltVolOri, fltVolPro: Double): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
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

{ TGravandoExecucaoGrafftexNovasFormulas }

constructor TGravandoExecucaoGrafftexNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoGrafftexNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm          : IDataSet;
  qryCadGRA          : IDataSet;
  qryBases           : IDataSet;
  intCont            : Integer;
  strMd5             : String;
  fltFator           : Double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM GRA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadGRA := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('GRA_CADGRA');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI,             ' +
                        '        BAS_EMBALA              ' +
                        '   FROM GRA_CADBAS              ' +
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
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;
        While Not qryBases.Eof Do
        Begin
          Try
            qryCadGRA.SQL := 'SELECT * FROM GRA_CADGRA WHERE FALSE';
            qryCadGRA.Open;

            qryCadGRA.Insert;
            qryCadGRA.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GRA_CADGRA',TAutcomTintaFactory.Get.GetCodEmp);
            qryCadGRA.FieldByName('GRA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadGRA.FieldByName('GRA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
            qryCadGRA.FieldByName('GRA_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadGRA.FieldByName('GRA_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
            qryCadGRA.FieldByName('GRA_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
            qryCadGRA.FieldByName('GRA_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString;
            qryCadGRA.FieldByName('GRA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadGRA.FieldByName('GRA_NOME__').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadGRA.FieldByName('GRA_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
            qryCadGRA.FieldByName('GRA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
            qryCadGRA.FieldByName('GRA_COLECA').AsString := qryCadNfm.FieldByName('NFM_COLECA').AsString;
            qryCadGRA.FieldByName('GRA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            fltFator := fRetFatorUnidade(qryCadNfm.FieldByName('NFM_VOLUME').AsFloat, qryBases.FieldByName('BAS_EMBALA').AsFloat);

            for intCont := 1 to 20 do
            begin
              if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                Break;

              if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                Break;

              qryCadGRA.FieldByName('GRA_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

              qryCadGRA.FieldByName('GRA_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
            end;

            strMd5 := '';
            strMd5 := (qryCadGRA.FieldByName('GRA_CODIGO').AsString +
                       qryCadGRA.FieldByName('GRA_DESCRI').AsString +
                       qryCadGRA.FieldByName('GRA_BASE__').AsString +
                       qryCadGRA.FieldByName('GRA_PRODUT').AsString +
                       qryCadGRA.FieldByName('GRA_CODUNI').AsString +
                       qryCadGRA.FieldByName('GRA_COLECA').AsString);

            qryCadGRA.FieldByName('GRA_MD5KEY').AsString := GetMD5(strMd5);

            qryCadGRA.Post;
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

function TGravandoExecucaoGrafftexNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoGrafftexNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;


function TGravandoExecucaoGrafftexNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoGrafftexNovasFormulas.fRetFatorUnidade(fltVolOri,
  fltVolPro: Double): Double;
begin
  Result := fltVolPro / fltVolOri;
end;

procedure TGravandoExecucaoGrafftexNovasFormulas.RemoverNovasFormulas;
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
          '   GRA_CADGRA        ' +
          ' WHERE GRA_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     GRA_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   GRA_CADGRA        ' +
          ' WHERE GRA_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     GRA_CADNFM      ' +
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
