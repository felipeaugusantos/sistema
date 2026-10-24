{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta AnjoImobiliaria *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAnjoImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoAnjoImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;

    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fRetProxCodSeq: Integer;

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

{ TGravandoExecucaoAnjoImobiliariaNovasFormulas }

constructor TGravandoExecucaoAnjoImobiliariaNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoAnjoImobiliariaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadANJ: IDataSet;
  qryBases : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM ANJ_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadANJ := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ANJ_CADANJ');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;

        qryBases.SQL := 'SELECT * '+
                      '  FROM ANJ_CADBAS    '+
                      ' INNER JOIN CADITE I ON    ' +
                      '   ANJ_CADBAS.BAS_CODITE = I.ITE_CODITE    ' +
                      ' WHERE BAS_BASE__ = "'+ qryCadNfm.FieldByName('NFM_BASE__').AsString+'"'+
                      '   AND BAS_PROKEY = "'+ qryCadNfm.FieldByName('NFM_PROKEY').AsString+'"'+
                      '   AND BAS_SUBKEY = "'+ qryCadNfm.FieldByName('NFM_SUBKEY').AsString+'"';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

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

              qryCadANJ.SQL := TAutcomTintaFactory.Get.GetInsert('ANJ_CADANJ');

              qryCadANJ.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ANJ_CADANJ', qryCadNfm.FieldByName('NFM_CODEMP').AsString);
              qryCadANJ.ParamByName('ANJ_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadANJ.ParamByName('ANJ_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
              qryCadANJ.ParamByName('ANJ_CODIG2').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
              qryCadANJ.ParamByName('ANJ_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadANJ.ParamByName('ANJ_UNIDAD').AsString  := qryBases.FieldByName('BAS_UNIDAD').AsString;
              qryCadANJ.ParamByName('ANJ_CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;
              qryCadANJ.ParamByName('ANJ_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadANJ.ParamByName('ANJ_CODSEQ').AsString := TStrUtils.fStrZero(fRetProxCodSeq, 6);
              qryCadANJ.ParamByName('ANJ_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
              qryCadANJ.ParamByName('ANJ_PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
              qryCadANJ.ParamByName('ANJ_SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;
              qryCadANJ.ParamByName('ANJ_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;


              for intCont := 1 to 20 do
              begin
                if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                  Break;

                qryCadANJ.ParamByName('ANJ_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadANJ.ParamByName('ANJ_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                  qryCadNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
                    fRetPesoUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString, qryBases.RecordCount, qryCadNfm.FieldByName('NFM_UNIDAD').AsString); //arrPesos[intUnidade];//arrPesos[intUnidades];
              end;

              qryCadANJ.ParamByName('ANJ_MD5KEY').AsString := GetMD5(qryCadANJ.ParamByName('ANJ_DESCRI').AsString +
                                                                     qryCadANJ.ParamByName('ANJ_CODIGO').AsString +
                                                                     qryCadANJ.ParamByName('ANJ_CODIG2').AsString +
                                                                     qryCadANJ.ParamByName('ANJ_UNIDAD').AsString +
                                                                     qryCadANJ.ParamByName('ANJ_PROKEY').AsString +
                                                                     qryCadANJ.ParamByName('ANJ_SUBKEY').AsString +
                                                                     qryCadANJ.ParamByName('ANJ_BASE__').AsString);

              qryCadANJ.ExecSQL;

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

function TGravandoExecucaoAnjoImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoAnjoImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoAnjoImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAnjoImobiliariaNovasFormulas.fRetPesoUnidade(
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

function TGravandoExecucaoAnjoImobiliariaNovasFormulas.fRetProxCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT ANJ_CODSEQ '+
                '  FROM ANJ_CADANJ '+
                ' ORDER BY ANJ_CODSEQ DESC LIMIT 1;';
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('ANJ_CODSEQ').AsInteger + 1;
end;

procedure TGravandoExecucaoAnjoImobiliariaNovasFormulas.RemoverNovasFormulas;
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
          '   ANJ_CADANJ                  ' +
          ' WHERE ANJ_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODPRO                ' +
          '   FROM                        ' +
          '     ANJ_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   ANJ_CADANJ                           ' +
          ' WHERE ANJ_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODPRO                         ' +
          '   FROM                                 ' +
          '     ANJ_CADNFM                         ' +
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
