{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta BellaCor *}
{*******************************************************************************PH*}
unit untGravandoExecucaoBellaCorNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoBellaCorNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
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

{ TGravandoExecucaoBellaCorNovasFormulas }

constructor TGravandoExecucaoBellaCorNovasFormulas.Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();

  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoBellaCorNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm : IDataSet;
  qryCadBEL : IDataSet;
  qryBases  : IDataSet;
  intCont   : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM BEL_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadBEL := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BEL_CADBEL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      While (not qryCadNfm.Eof)
        and (gravando.Status = sgGravando) do
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '   FROM BEL_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT LIKE :PRODUT ' +
                        '    AND BAS_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := '%' + qryCadNfm.FieldByName('NFM_PRODUT').AsString + '%';
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
              qryCadBEL.SQL := TAutcomTintaFactory.Get.GetInsert('BEL_CADBEL');

              qryCadBEL.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('BEL_CADBEL',TAutcomTintaFactory.Get.GetCodEmp);
              qryCadBEL.ParamByName('BEL_CODITE').AsString   := '';
              qryCadBEL.ParamByName('BEL_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadBEL.ParamByName('BEL_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadBEL.ParamByName('BEL_PRODUT').AsString   := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
              qryCadBEL.ParamByName('BEL_CODUNI').AsString   := qryBases.FieldByName('BAS_CODUNI').AsString;
              qryCadBEL.ParamByName('BEL_CODBAS').AsString   := qryCadNfm.FieldByName('NFM_BASE__').AsString;
              qryCadBEL.ParamByName('BEL_NOMCOR').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
              qryCadBEL.ParamByName('BEL_COLECA').AsString   := qryCadNfm.FieldByName('NFM_COLECA').AsString;
              qryCadBEL.ParamByName('BEL_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
              qryCadBEL.ParamByName('BEL_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadBEL.ParamByName('BEL_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              for intCont := 1 to 20 do
              begin
                if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                  Break;

                if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                  Break;

                qryCadBEL.ParamByName('BEL_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadBEL.ParamByName('BEL_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
                    fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString, qryBases.RecordCount, qryCadNfm.FieldByName('NFM_CODUNI').AsString);
              end;

              qryCadBEL.ParamByName('BEL_MD5KEY').AsString := GetMD5(qryCadBEL.ParamByName('BEL_COLECA').AsString +
                                                                     qryCadBEL.ParamByName('BEL_PRODUT').AsString +
                                                                     qryCadBEL.ParamByName('BEL_DESCRI').AsString +
                                                                     qryCadBEL.ParamByName('BEL_NOMCOR').AsString +
                                                                     qryCadBEL.ParamByName('BEL_CODUNI').AsString +
                                                                     qryCadBEL.ParamByName('BEL_CODBAS').AsString +
                                                                     qryCadBEL.ParamByName('BEL_CODEMP').AsString);

              qryCadBEL.ExecSQL;

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

function TGravandoExecucaoBellaCorNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoBellaCorNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;


function TGravandoExecucaoBellaCorNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoBellaCorNovasFormulas.fRetPesoUnidade(
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

procedure TGravandoExecucaoBellaCorNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE BEL_CADBEL             ' +
          ' FROM                          ' +
          '   BEL_CADBEL                  ' +
          ' INNER JOIN BEL_CADNFM ON BEL_CADNFM.NFM_CODNFM = BEL_CADBEL.BEL_NOMCOR ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE BEL_CADBEL                      ' +
          ' FROM                                   ' +
          '   BEL_CADBEL JOIN BEL_CADNFM ON BEL_CADNFM.NFM_CODNFM = BEL_CADBEL.BEL_NOMCOR   ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
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
