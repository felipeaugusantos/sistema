{*******************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Montana *}
{****************************************************************************************AC*}
unit untGravandoExecucaoMontanaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants;

type
  TGravandoExecucaoMontanaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm          : string;
    blnGerarUnidades   : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor    : String;

    procedure RemoverNovasFormulas();
    function fRetProximoCodSeq: Integer;

    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
  public
    constructor Create(const strCodNfm          : string = '';
                       blnGerarUnidades         : Boolean = true;
                       const blnAtualizarUnidade: Boolean = False;
                       const strUnidadeMenor    : String = '');

    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoMontanaNovasFormulas }

constructor TGravandoExecucaoMontanaNovasFormulas.Create(const strCodNfm           : string = '';
                                                         blnGerarUnidades          : Boolean = true;
                                                         const blnAtualizarUnidade : Boolean = False;
                                                         const strUnidadeMenor     : String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;


procedure TGravandoExecucaoMontanaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm          : IDataSet;
  qryCadMON          : IDataSet;
  qryBases           : IDataSet;
  intCont            : Integer;
  intCodSeq          : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := ' SELECT * FROM MON_CADNFM ';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadMON := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MON_CADMON');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      While (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT * ' +
                        '   FROM MON_CADBAS ' +
                        '  WHERE BAS_CODBAS = :CODBAS ' +
                        '    AND BAS_PRODUT = :PRODUT ' +
                        '    AND BAS_ACABAM = :DESCRI ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_ACABAM').AsString;

        qryBases.Open;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin
              intCodSeq := fRetProximoCodSeq;

              qryCadMON.SQL := TAutcomTintaFactory.Get.GetInsert('MON_CADMON');

              qryCadMON.ParamByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('MON_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadMON.ParamByName('MON_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadMON.ParamByName('MON_DTACAD').Value     := qryCadNfm.FieldByName('NFM_DTACAD').Value;
              qryCadMON.ParamByName('MON_CODBAS').AsString  := qryBases.FieldByName('BAS_CODBAS').AsString;
              qryCadMON.ParamByName('MON_CODSEQ').AsInteger := intCodSeq;
              qryCadMON.ParamByName('MON_CODNFM').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
              qryCadMON.ParamByName('MON_ATIVAD').AsString  := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
              qryCadMON.ParamByName('MON_CODITE').AsString  := qryCadNfm.FieldByName('NFM_CODITE').AsString;
              qryCadMON.ParamByName('MON_DESCRI').AsString  := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadMON.ParamByName('MON_DESCOR').AsString  := qryCadNfm.FieldByName('NFM_DESCOR').AsString;
              qryCadMON.ParamByName('MON_PRODUT').AsString  := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
              qryCadMON.ParamByName('MON_UNIDAD').AsString  := qryBases.FieldByName('BAS_UNIDAD').AsString;
              qryCadMON.ParamByName('MON_ACABAM').AsString  := qryBases.FieldByName('BAS_ACABAM').AsString;
              qryCadMON.ParamByName('MON_ACRMOB').AsFloat   := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;


              for intCont := 1 to 20 do
              begin
                If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
                  Break;

                qryCadMON.ParamByName('MON_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadMON.ParamByName('MON_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
                  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString
                                                                                                             , qryBases.RecordCount
                                                                                                             , qryCadNfm.FieldByName('NFM_UNIDAD').AsString);
              end;

              qryCadMON.ParamByName('MON_MD5KEY').AsString := GetMD5(qryCadMON.ParamByName('MON_CODSEQ').AsString +
                                                                     qryCadMON.ParamByName('MON_CODBAS').AsString +
                                                                     qryCadMON.ParamByName('MON_ACABAM').AsString +
                                                                     qryCadMON.ParamByName('MON_DESCRI').AsString +
                                                                     qryCadMON.ParamByName('MON_DESCOR').AsString +
                                                                     qryCadMON.ParamByName('MON_PRODUT').AsString +
                                                                     qryCadMON.ParamByName('MON_UNIDAD').AsString );




              qryCadMON.ExecSQL;

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

function TGravandoExecucaoMontanaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoMontanaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","BL") '
  Else If strUnidade = 'BL' Then
    Result := ' AND BAS_UNIDAD = "BL" ';
end;


function TGravandoExecucaoMontanaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoMontanaNovasFormulas.fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
begin

  Result := 1;
  If intRegistros = 3 Then
  Begin
    If Pos(strCodUni, 'LT_QT_') > 0 Then
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

function TGravandoExecucaoMontanaNovasFormulas.fRetProximoCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT IFNULL(MAX(MON_CODSEQ), 0) + 1 AS MAXIMO FROM MON_CADMON;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoMontanaNovasFormulas.RemoverNovasFormulas;
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
          '   MON_CADMON                  ' +
          ' WHERE MON_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     MON_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   MON_CADMON                           ' +
          ' WHERE MON_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     MON_CADNFM                         ' +
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
