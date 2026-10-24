{******************************************-*************************************}
{* Classe contendo as informações especificas da tinta Salcomix *}
{*******************************************-************************************}
unit untLibTintaSalcomix;

interface

uses
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,StrUtils,
  Controls, untAbstractTintaSQLServer, untSalcomixFormulacaoSQLServer;

type
  TLibTintaSalcomix = class(TAbstractLibTintaAutomotiva)
  protected
    strLinha: String;
    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; override;
    function GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string; override;
    procedure GetSQLBasesGTinForParametros(qryBases: IDataSet); override;

    function GetVolumeOriginal(const dicRetorno: IDicionario): Double; override;
    function GetVolumeConcentrado: Double; override;
    function GetVolumeDiluido: Double; override;
    function GetVolumePro(const dicRetorno: IDicionario): Double; override;
    function GetCodFormul(const dicRetorno: IDicionario): string; override;

    procedure pProcessaFormulacaoTabelaPreco(Formula: TAbstractFormulaAutomotiva;
                                  const dicRetorno: IDicionario; const qryConsulta: IDataSet); override;
    procedure pProcessaFormulacaoGTinFor(Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet;
                                  dicBases: IDicionario; Const Formula: TAbstractFormulaAutomotiva;
                                  Const dicDados: IDicionario; Var strBases: String); override;

    function GetPrefixoTabela: String; override;

  public
    function GetNomeTinta: String; override;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper; override;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String; override;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double; override;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario); override;
    function GetMenu: IAuttinMenuItem; override;
    function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double): String ; override;
    function GetNomeTabelaFormulacao: String; override;
    function GetCampoComponenteDesComp(): String; override;

    function fTruncaValor(fltValor: Double; intCasas: Integer): Double;
    function SALredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fRetornaFatorDensidade(strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fCasasDecimaisQtd(strTipPrg: String): Integer;


  end;

implementation

uses
  untFormulaAutomotivaSalcomix, untTintadeMaquinaWrapperSalcomix, untAutcomTintaFactory, untVariantUtils, untAuttinMenuItemSalcomix;

{ TSalcomixTintadeMaquina }



function TLibTintaSalcomix.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaSalcomix.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaSalcomix.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaSalcomix.Create(strTabPre);
end;

function TLibTintaSalcomix.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperSalcomix.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaSalcomix.GetMenu: IAuttinMenuItem;
begin
  Result := TAuttinMenuItemSalcomix.Create();
end;

function TLibTintaSalcomix.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORSAL';
end;

function TLibTintaSalcomix.GetNomeTinta: String;
begin
  Result := 'Salcomix';
end;

function TLibTintaSalcomix.GetPrefixoTabela: String;
begin
  Result := 'SAL';
end;

function TLibTintaSalcomix.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double): String;
begin
  Result := '';
end;

function TLibTintaSalcomix.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                 ' +
    '     BAS_CODBAS                         ' +
    '   , BAS_CODITE                         ' +
    ' FROM                                   ' +
    '   SAL_CADBAS                           ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ' +
    ' AND BAS_LINHA_ = :LINHA                ' ;
end;

procedure TLibTintaSalcomix.GetSQLBasesGTinForParametros(qryBases: IDataSet);
begin
  qryBases.ParamByName('LINHA').AsString := strLinha;

end;

function TLibTintaSalcomix.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaSalcomix.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaSalcomix.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1000;
end;

function TLibTintaSalcomix.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

procedure TLibTintaSalcomix.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  SalcomixSQLServer: TAbstractTintaSQLServer;
  tpsTipo: TTipoPreparoTinta;
  objFormulaSQS: TFormulaTintasSQLServer;
  intContador: Integer;
  strCamFor,
  strCamQtd:String;
begin
  Try
    Try
      strLinha := LeftStr(qryConsulta.FieldByName('SAL_LINHA_').AsString, 8);

      If (formula.fModoIntegracaoSistema) And
        (Pos('ESP', qryConsulta.FieldByName('SAL_CODPRO').AsString) <= 0) Then
      Begin
        If dicDados['coddil'] = 'R' Then
          tpsTipo := tpsResina325
        Else If dicDados['coddil'] = 'D' Then
          tpsTipo := tpsDiluido
        Else
          tpsTipo := tpsConcentrado;

        SalcomixSQLServer := formula.GetTintaSQLServer(qryConsulta.FieldByName('SAL_CODSEQ').AsString, strLinha);
        objFormulaSQS := SalcomixSQLServer.fCalculaFormulacao(dicDados['volpro'], tpsTipo);

        If Not Assigned(objFormulaSQS) Then
        Begin
          Formula.blnErroIntegracao := True;
          Exit;
        End;

        For intContador := 0 To objFormulaSQS.Count - 1 Do
        Begin
          arrFormul[intContador+1].strFormul := objFormulaSQS.Base[intContador].CodigoBase;

          If objFormulaSQS.Base[intContador].QuantidadeConcentrado > 0 Then
            arrFormul[intContador+1].fltQtdbas := objFormulaSQS.Base[intContador].QuantidadeConcentrado
          Else
            arrFormul[intContador+1].fltQtdbas := objFormulaSQS.Base[intCOntador].QuantidadeDiluido;

          dicBases[arrFormul[intContador+1].strFormul] := arrFormul[intContador+1].fltQtdbas;

          strBases := strBases + QuotedStr(arrFormul[intContador+1].strFormul);
          If (Not TStrUtils.fEmptyStr(arrFormul[intContador+1].strFormul)) Then
            strBases := strBases + ', ';
        End;
      End
      Else
      Begin
        For intContador := 1 To 20 Do
        Begin
          strCamFor := 'SAL_FORM' + TStrUtils.fStrZero(intContador, 2);

          If (Pos('ESP', qryConsulta.FieldByName('SAL_CODPRO').AsString) > 0) Then
          Begin
            If dicDados['tippre'] = 'C' Then
              strCamQtd := 'SAL_QTDB' + TStrUtils.fStrZero(IntToStr(intContador), 2)
            Else
              strCamQtd := 'SAL_QTDD' + TStrUtils.fStrZero(IntToStr(intContador), 2);
          End
          Else
            strCamQtd := 'SAL_QTDB' + TStrUtils.fStrZero(IntToStr(intContador), 2);

          arrFormul[intContador].strFormul := qryConsulta.FieldByName(strCamFor).AsString;
          arrFormul[intContador].fltQtdbas := (qryConsulta.FieldByName(strCamQtd).AsFloat * dicDados['volpro']);

          dicBases[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdbas;

          strBases := strBases + QuotedStr(arrFormul[intContador].strFormul);
          If (Not TStrUtils.fEmptyStr(arrFormul[intContador].strFormul)) Then
            strBases := strBases + ', ';

        End;
      End;

    Except
      On E: Exception Do
        Raise;
    End;
  Finally

  End;

end;

procedure TLibTintaSalcomix.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To 15 Do
  Begin

    If TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)], '')) Then
      Break;

    Base := TBaseAutomotiva(formula.Add);
    Base.CodigoBase := dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)];
    Base.LinhaBase  := qryConsulta.FieldByName('SAL_LINHA_').AsString;
    If dicRetorno['tippre'] = 'C' Then
      Base.QuantidadeConcentrado := TAutcomTintaFactory.Get.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) *
        (Formula.VolumeOri / 1000) / Formula.VolumePro
    Else
      Base.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) *
        (Formula.VolumeOri / 1000) / Formula.VolumePro;
    Base.TipoBase := 'B';
  End;

end;

procedure TLibTintaSalcomix.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=  'SELECT ' +
                     '  *  ' +
                     'FROM ' +
                     '  SAL_CADSAL ' +
                     'WHERE ' +
                     ' 	UPPER(CAST(MD5(CONCAT(IFNULL(SAL_LINHA_, ''''), IFNULL(SAL_MONTAD, ''''), IFNULL(SAL_DESCRI, ''''), ' +
                     ' 			IFNULL(SAL_CODPRO, ''''), IFNULL(SAL_ANOCOR, ''''), IFNULL(SAL_VARIAC, ''''),  ' +
                     ' 			IFNULL(SAL_FORM01, ''''), IFNULL(SAL_QTDB01, ''0.0''), IFNULL(SAL_FORM02, ''''),  ' +
                     ' 			IFNULL(SAL_QTDB02, ''0.0''), IFNULL(SAL_FORM03, ''''), IFNULL(SAL_QTDB03, ''0.0''),  ' +
                     ' 			IFNULL(SAL_FORM04, ''''), IFNULL(SAL_QTDB04, ''0.0''), IFNULL(SAL_FORM05, ''''),  ' +
                     ' 			IFNULL(SAL_QTDB05, ''0.0''), IFNULL(SAL_FORM06, ''''), IFNULL(SAL_QTDB06, ''0.0''),  ' +
                     ' 			IFNULL(SAL_FORM07, ''''), IFNULL(SAL_QTDB07, ''0.0''), IFNULL(SAL_FORM08, ''''),  ' +
                     ' 			IFNULL(SAL_QTDB08, ''0.0''), IFNULL(SAL_FORM09, ''''), IFNULL(SAL_QTDB09, ''0.0''),  ' +
                     ' 			IFNULL(SAL_FORM10, ''''), IFNULL(SAL_QTDB10, ''0.0''), IFNULL(SAL_FORM11, ''''),  ' +
                     ' 			IFNULL(SAL_QTDB11, ''0.0''), IFNULL(SAL_FORM12, ''''), IFNULL(SAL_QTDB12, ''0.0''),  ' +
                     ' 			IFNULL(SAL_FORM13, ''''), IFNULL(SAL_QTDB13, ''0.0''), IFNULL(SAL_FORM14, ''''),  ' +
                     ' 			IFNULL(SAL_QTDB14, ''0.0''), IFNULL(SAL_FORM15, ''''), IFNULL(SAL_QTDB15, ''0.0''),  ' +
                     ' 			IFNULL(SAL_FORM16, ''''), IFNULL(SAL_QTDB16, ''0.0''), IFNULL(SAL_FORM17, ''''),  ' +
                     ' 			IFNULL(SAL_QTDB17, ''0.0''), IFNULL(SAL_FORM18, ''''), IFNULL(SAL_QTDB18, ''0.0''),  ' +
                     ' 			IFNULL(SAL_FORM19, ''''), IFNULL(SAL_QTDB19, ''0.0''), IFNULL(SAL_FORM20, ''''),  ' +
                     ' 			IFNULL(SAL_QTDB20, ''0.0''))) AS CHAR)) = :ITETIN ';

      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Close;
        qryGen.SQL.Empty;
        qryGen.SQL := '   SELECT * FROM SAL_CADSAL  WHERE SAL_CODSEQ = :ITETIN    ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      End;

      dicRetorno['codtin'] := qryGen.FieldByName('SAL_CODPRO').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('SAL_MONTAD').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('SAL_LINHA_').AsString;
      dicRetorno['variac'] := qryGen.FieldByName('SAL_VARIAC').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaSalcomix.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaSalcomix.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
Var
  conf: IConfTinta;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('SAL');

  If conf.fGet('SALPRE') = 'VEN' Then
    Result :=  TVariantUtils.IfNull(dicDados['unitar'],0) * conf.fGetDouble('SALFAT')
  Else
    Result :=  TVariantUtils.IfNull(dicDados['precus' ],0) * conf.fGetDouble('SALFAT');

  Result := TFloatUtils.fFormataFloat(Result, 2);
end;

function TLibTintaSalcomix.SALredondaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.' + TStrUtils.fStrZero(0, intCasas), fltValor));
end;

function TLibTintaSalcomix.fCasasDecimaisQtd(
  strTipPrg: String): Integer;
begin
  Result := 4;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := 5;
end;

function TLibTintaSalcomix.fRetornaFatorDensidade(strTipPrg: String;
  fltQtdCon, fltPesEsp: Double): Double;
begin
  Result := fltQtdCon / fltPesEsp;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltQtdCon / fltPesEsp, 2);
end;

function TLibTintaSalcomix.fRetornaTotalDensidade(strTipPrg: String;
  fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltPorcen / fltDensid, 2);

end;

function TLibTintaSalcomix.fTruncaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat((FloatToStr(Int(fltValor)) ) + Copy(FloatToStr(Frac(fltValor)), 2, (intCasas + 1) ) );
end;

end.
