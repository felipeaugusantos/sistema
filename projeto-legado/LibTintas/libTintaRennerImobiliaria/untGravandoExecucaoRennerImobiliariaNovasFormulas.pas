{********************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta RennerImobiliaria *}
{*****************************************************************************************AC*}
unit untGravandoExecucaoRennerImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants;

type
  TGravandoExecucaoRennerImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fRetProximoCodSeq: Integer;

    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoRennerImobiliariaNovasFormulas }

constructor TGravandoExecucaoRennerImobiliariaNovasFormulas.Create(const strCodNfm: string = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoRennerImobiliariaNovasFormulas.Executar(const gravando: IGravando);
//const
//  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
//  arrPesos: array[0..2] of Double = (1, 4, 20);
var
  qryCadNfm          : IDataSet;
  qryCadREI          : IDataSet;
  intCont            : Integer;
//  intUnidade         : Integer;
  qryBases           : IDataSet;
  intCodSeq          : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := ' SELECT * FROM REI_CADNFM ';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadREI := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REI_CADREI', False);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      intCodSeq := fRetProximoCodSeq;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_UNIDAD,             ' +
                        '        BAS_DESCRI              ' +
                        '   FROM REI_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin

              qryCadREI.SQL := TAutcomTintaFactory.Get.GetInsert('REI_CADREI');

              qryCadREI.ParamByName('REI_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
              qryCadREI.ParamByName('REI_DESCRI').AsString := qryBases.FieldByName('BAS_DESCRI').AsString;
              qryCadREI.ParamByName('REI_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
              qryCadREI.ParamByName('REI_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
              qryCadREI.ParamByName('REI_DESCOR').AsString := qryCadNfm.FieldByName('NFM_DESCOR').AsString;
              qryCadREI.ParamByName('REI_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
              qryCadREI.ParamByName('REI_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
              qryCadREI.ParamByName('REI_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              qryCadREI.ParamByName('REI_CODITE').Value    := Null;

              qryCadREI.ParamByName('REI_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

              for intCont := 1 to 20 do
              begin
                If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
                  Break;

                qryCadREI.ParamByName('REI_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadREI.ParamByName('REI_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
                  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString, qryBases.RecordCount, qryCadNfm.FieldByName('NFM_UNIDAD').AsString); //arrPesos[intUnidade];
              end;

              qryCadREI.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REI_CADREI', TAutcomTintaFactory.Get.GetCodEmp);

              qryCadREI.ParamByName('REI_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadREI.ParamByName('REI_DTACAD').AsDateTime := TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_DTACAD').AsString),
                                                                                            fNow(),
                                                                                            qryCadNfm.FieldByName('NFM_DTACAD').AsDate);
              qryCadREI.ParamByName('REI_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;

              qryCadREI.ParamByName('REI_MD5KEY').AsString := GetMD5(qryCadREI.ParamByName('REI_DESCRI').AsString +
                                                                     qryCadREI.ParamByName('REI_REFERE').AsString +
                                                                     qryCadREI.ParamByName('REI_UNIDAD').AsString +
                                                                     qryCadREI.ParamByName('REI_DESCOR').AsString +
                                                                     qryCadREI.ParamByName('REI_CODPRO').AsString +
                                                                     qryCadREI.ParamByName('REI_CODBAS').AsString +
                                                                     FormatDateTime('YYYY-MM-DD', qryCadREI.ParamByName('REI_DTACAD').AsDateTime));

              qryCadREI.ExecSQL;

              if not (blnGerarUnidades) then
                Break;

              Inc(intCodSeq);

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

function TGravandoExecucaoRennerImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoRennerImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoRennerImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoRennerImobiliariaNovasFormulas.fRetPesoUnidade(
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
    Else If (strCodUni = 'LA') And (Pos(strUniOri,'LT_QT_') > 0) Then
      Result := 20
    Else If strCodUni = 'LA' Then
      Result := 5;
  End;
end;

function TGravandoExecucaoRennerImobiliariaNovasFormulas.fRetProximoCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT IFNULL(MAX(REI_CODSEQ), 0) + 1 AS MAXIMO FROM REI_CADREI;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoRennerImobiliariaNovasFormulas.RemoverNovasFormulas;
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
          '   REI_CADREI                  ' +
          ' WHERE REI_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODPRO                ' +
          '   FROM                        ' +
          '     REI_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   REI_CADREI                           ' +
          ' WHERE REI_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODPRO                         ' +
          '   FROM                                 ' +
          '     REI_CADNFM                         ' +
          '   WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm) + ') ';
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
