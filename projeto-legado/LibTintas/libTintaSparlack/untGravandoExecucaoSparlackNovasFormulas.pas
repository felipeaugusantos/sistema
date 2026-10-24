{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Sparlack *}
{*******************************************************************************PH*}
unit untGravandoExecucaoSparlackNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoSparlackNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;

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

{ TGravandoExecucaoSparlackNovasFormulas }

constructor TGravandoExecucaoSparlackNovasFormulas.Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;


function TGravandoExecucaoSparlackNovasFormulas.fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","BL") '
  Else If strUnidade = 'BL' Then
    Result := ' AND BAS_CODUNI = "BL" ';
end;

function TGravandoExecucaoSparlackNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSparlackNovasFormulas.fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
begin
  Result := 1;

  If intRegistros = 3 Then
  Begin
    If Pos(strCodUni, 'QT_') > 0 Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If strCodUni = 'BL' Then
      Result := 20;
  End
  Else If intRegistros = 2 Then
  Begin
    If strCodUni = 'QT' Then
      Result := 1
    Else If (strCodUni = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If (strCodUni = 'BL') And (strUniOri = 'QT') Then
      Result := 20
    Else If strCodUni = 'BL' Then
      Result := 5;
  End;

end;

procedure TGravandoExecucaoSparlackNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm     : IDataSet;
  qryCadSPA     : IDataSet;
  qryEmb        : IDataSet;
  intCont       : Integer;
  strMd5        : String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM SPA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadSPA := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SPA_CADSPA');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      While (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        qryEmb := TAutcomTintaFactory.Get.fGetDataSet;
        qryEmb.SQL := ' SELECT BAS_CODUNI '+
                      '   FROM SPA_CADBAS '+
                      '  INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE '+
                      '  WHERE BAS_CODBAS  = :CODBAS '+
                      '    AND BAS_PRODUT  = :PRODUT ';


        If Not blnGerarUnidades Then
          qryEmb.SQL := qryEmb.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryEmb.SQL := qryEmb.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryEmb.SQL := qryEmb.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryEmb.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryEmb.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryEmb.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryEmb.Open;

        Try
          Try
            begin
              qryEmb.First;

              While Not qryEmb.Eof Do
              Begin
                qryCadSPA.SQL := TAutcomTintaFactory.Get.GetInsert('SPA_CADSPA');

                qryCadSPA.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('SPA_CADSPA', TAutcomTintaFactory.Get.GetCodEmp);
                qryCadSPA.ParamByName('SPA_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadSPA.ParamByName('SPA_CODSPA').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                qryCadSPA.ParamByName('SPA_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
                qryCadSPA.ParamByName('SPA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
                qryCadSPA.ParamByName('SPA_CODUNI').AsString   := qryEmb.FieldByName('BAS_CODUNI').AsString;
                qryCadSPA.ParamByName('SPA_CODBAS').AsString   := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
                qryCadSPA.ParamByName('SPA_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                qryCadSPA.ParamByName('SPA_REFERE').AsString   := qryCadNfm.FieldByName('NFM_REFERE').AsString;
                qryCadSPA.ParamByName('SPA_PRODUT').AsString   := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
                qryCadSPA.ParamByName('SPA_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                for intCont := 1 to 20 do
                begin
                  if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                    Break;

                  if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                    Break;

                  qryCadSPA.ParamByName('SPA_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString);

                  qryCadSPA.ParamByName('SPA_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
                    (qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
                    fRetPesoUnidade(qryEmb.FieldByName('BAS_CODUNI').AsString, qryEmb.RecordCount, qryCadNfm.FieldByName('NFM_CODUNI').AsString));

                end;

                strMd5 := '';

                strMd5 := qryCadSPA.ParamByName('SPA_CODSPA').AsString +
                          qryCadSPA.ParamByName('SPA_CODEMP').AsString +
                          qryCadSPA.ParamByName('SPA_CODBAS').AsString +
                          qryCadSPA.ParamByName('SPA_CODUNI').AsString +
                          qryCadSPA.ParamByName('SPA_DESCRI').AsString +
                          qryCadSPA.ParamByName('SPA_PRODUT').AsString +
                          qryCadSPA.ParamByName('SPA_REFERE').AsString ;

                qryCadSPA.ParamByName('SPA_MD5KEY').AsString := GetMD5(strMd5);

                qryCadSPA.ExecSQL;

                if not (blnGerarUnidades) then
                  Break;

                qryEmb.Next;
              End;
            end;
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

function TGravandoExecucaoSparlackNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TGravandoExecucaoSparlackNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL := 'DELETE '+
                      '  FROM SPA_CADSPA '+
                      ' WHERE SPA_CODSPA IN (SELECT NFM_CODNFM  '+
                      '                        FROM SPA_CADNFM)';
      end
      else
      begin
        qryGen.SQL := ' DELETE              ' +
                      '   FROM SPA_CADSPA   ' +
                      '  WHERE SPA_CODSPA = :CODSPA';
        qryGen.ParamByName('CODSPA').AsString := strCodNfm;
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
