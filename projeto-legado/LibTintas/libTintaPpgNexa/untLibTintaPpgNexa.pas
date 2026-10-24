{**************************************************************************}
{* Classe contendo as informações especificas da tinta PPX *}
{***********************************************************************MH*}
unit untLibTintaPpgNexa;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes;



type
  TLibTintaPpgNexa = class(TAbstractLibTintaAutomotiva)
  private
    fltPorDil: Double;
    strCodDil: String;
    function fSelectBasesEmpresa(strCodEmp: String): String;
  protected
    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; override;
    function GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string; override;
    function GetSQLBasesEmpGTinFor(const strBases: String; Const dicDados: IDicionario): String; override;

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
    procedure pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet; intPos: Integer; Var List: TStringList;
      arrBaixaPigmentos: TBaixaPigmentosArray; dicBases: IDicionario; Const dicDados: IDicionario; strBases: String); Override;



    function GetPrefixoTabela: String; override;
  public
    function GetNomeTinta: String; override;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper; override;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String; override;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double; override;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario); override;
    function GetMenu: IAuttinMenuItem; override;
    function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String ; override;
    function GetNomeTabelaFormulacao: String; override;
    function GetCampoComponenteDesComp(): String; override;
    function fArredondaPPX(fltValor: Double): Double;
    procedure pRetItemColorante(const strColTinDet: String; Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String); Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemPpgNexa,
{$ENDIF}
  untFormulaAutomotivaPpgNexa, untTintadeMaquinaWrapperPpgNexa, untAutcomTintaFactory, untVariantUtils;

{ TPPXTintadeMaquina }

{function TLibTintaPpgNexa.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaPpgNexa.fArredondaPPX(fltValor: Double): Double;
Var
  strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);

  If (TAutcomTintaFactory.Get.fStrToFloat(strAux) = 0) Then
    strAux := Format('%.2f', [fltValor]);

  Result := TAutcomTintaFactory.Get.fStrToFloat(strAux);
end;


function TLibTintaPpgNexa.fSelectBasesEmpresa(strCodEmp: String): String;
begin
  Result := ' SELECT              ';
  Result := Result + '    BAS_CODITE,     ';
  Result := Result + '    BAS_CODBAS      ';
  Result := Result + ' FROM       ';
  Result := Result + '    PPX_BASEMP      ';
  Result := Result + ' WHERE BAS_CODBAS = :BAS_CODBAS   ';
  Result := Result + '  AND BAS_CODEMP = "' + strCodEmp + '"  ';
end;

function TLibTintaPpgNexa.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaPpgNexa.GetCodFormul(const dicRetorno: IDicionario): string;
begin
   Result := dicRetorno['sistem'];
end;

function TLibTintaPpgNexa.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaPpgNexa.Create(strTabPre);
end;

function TLibTintaPpgNexa.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperPpgNexa.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaPpgNexa.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemPpgNexa.Create();
{$ENDIF}
end;

function TLibTintaPpgNexa.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORPPX';
end;

function TLibTintaPpgNexa.GetNomeTinta: String;
begin
  Result := 'PPG/NEXA';
end;

function TLibTintaPpgNexa.GetPrefixoTabela: String;
begin
  Result := 'PPX';
end;

function TLibTintaPpgNexa.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaPpgNexa.GetSQLBasesEmpGTinFor(const strBases: String;
  const dicDados: IDicionario): String;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    BAS_CODBAS,           ';
  Result := Result + '    BAS_CODITE            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    PPX_BASEMP            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    BAS_CODBAS IN (' + strBases + ')  AND       ';
  Result := Result + '    BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  AND     ';
  Result := Result + '    BAS_CODITE IS NOT NULL                      ';
end;

function TLibTintaPpgNexa.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result := ' SELECT                                  ' +
            '    BAS_CODBAS                           ' +
            '  , BAS_CODITE                           ' +
            ' FROM                                    ' +
            '   PPX_CADBAS                            ' +
            ' WHERE BAS_CODBAS IN (' + strBases + ')  ';
end;

function TLibTintaPpgNexa.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaPpgNexa.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaPpgNexa.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

function TLibTintaPpgNexa.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaPpgNexa.pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet;
  intPos: Integer; Var List: TStringList; arrBaixaPigmentos: TBaixaPigmentosArray;
  dicBases: IDicionario; Const dicDados: IDicionario; strBases: String);
Var
  qryBasEmp: IDataSet;
  strBasEmp: String;
Begin
  qryBasEmp := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasEmp.Close;
  qryBasEmp.SQL := GetSQLBasesEmpGTinFor(strBases, dicDados);
  qryBasEmp.Open;

  While (Not qryBasEmp.Eof) Do
  Begin

    If dicBases[qryBasEmp.FieldByName('BAS_CODBAS').AsString] <= 0 Then
    Begin
      qryBasEmp.Next;
      Continue;
    End;

    List.Add(qryBasEmp.FieldByName(GetNomeCampoBaseCodIte).AsString);
    arrBaixaPigmentos[intPos].strCodIte   := qryBasEmp.FieldByName(GetNomeCampoBaseCodIte).AsString;
    arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[qryBasEmp.FieldByName('BAS_CODBAS').AsString];
    arrBaixaPigmentos[intPos].strFormul   := GetFormulArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].strPesGra   := GetPesGraArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].fltEmbBas   := GetEmbalaArrBaixaPigmentos(qryBases);

    strBasEmp := strBasEmp + '"' + qryBasEmp.FieldByName('BAS_CODBAS').AsString + '", ';

    Inc(intPos);
    qryBasEmp.Next;
  End;

  While Not qryBases.Eof Do
  Begin

    If Pos(qryBases.FieldByName('BAS_CODBAS').AsString, strBasEmp) > 0 Then
    Begin
      qryBases.Next;
      Continue;
    End;

    If fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases) <= 0 Then
    Begin
      qryBases.Next;
      Continue;
    End;

    List.Add(qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString);
    arrBaixaPigmentos[intPos].strCodIte   := qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString;
    arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases);
    arrBaixaPigmentos[intPos].strFormul   := GetFormulArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].strPesGra   := GetPesGraArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].fltEmbBas   := GetEmbalaArrBaixaPigmentos(qryBases);

    Inc(intPos);
    qryBases.Next;
  End;
End;

procedure TLibTintaPpgNexa.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont              : Integer;
  Base                 : TBaseAutomotiva;
  qryBases             : IDataSet;
  fltQuantidade        : Double;
begin
  qryBases     := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := 'SELECT * '+
                  '  FROM PPX_CADBAS';
  qryBases.Open;


  strCodDil := dicDados['coddil'];
  fltPorDil := dicDados['pordil'];

  For intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase            := qryConsulta.FieldByName('PPX_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString;
    Base.QuantidadeConcentrado := qryConsulta.FieldByName('PPX_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    Base.TipoBase              := 'B';

    if qryBases.Locate('BAS_CODBAS', Base.CodigoBase, []) then
    begin
      Base.PesoEspecifico := qryBases.FieldByName('BAS_PESESP').AsFloat;
      Base.Embalagem      := qryBases.FieldByName('BAS_EMBALA').AsFloat;
    end;
  end;

  Formula.pCalcularDiluente(dicDados['coddil'], dicDados['pordil'], qryConsulta);

  For intCont := 0 To Formula.Count - 1 Do
  Begin
    If Pos('PERSONALIZ', qryConsulta.FieldByName('PPX_SISTEM').AsString) <= 0 Then
    Begin
      If dicDados['tippre']  = 'C' Then
        fltQuantidade := fArredondaPPX(TFloatUtils.fFormataFloat(TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado, 1) * dicDados['volpro'])
      Else
        fltQuantidade := fArredondaPPX(TFloatUtils.fFormataFloat(TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido, 1) * dicDados['volpro']);
    End
    Else
    Begin
      If dicDados['tippre']  = 'C' Then
        fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * dicDados['volpro']
      Else
        fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * dicDados['volpro'];
    End;

    if fltQuantidade <= 0 then
      Continue;

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
    strBases := strBases + '"' +arrFormul[intCont + 1].strFormul + '", ';
  End;


end;

procedure TLibTintaPpgNexa.pProcessaFormulacaoTabelaPreco( Formula: TAbstractFormulaAutomotiva;
  const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intCont              : Integer;
  Base                 : TBaseAutomotiva;
  qryBases             : IDataSet;
begin
  qryBases     := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := 'SELECT * '+
                  '  FROM PPX_CADBAS';
  qryBases.Open;

  dicRetorno['sistem'] := qryConsulta.FieldByName('PPX_SISTEM').AsString;

  For intCont := 1 To 20 Do
  Begin

    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString, ''))) Then
      Continue;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase := Trim(qryConsulta.FieldByName('PPX_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
    Base.QuantidadeConcentrado := qryConsulta.FieldByName('PPX_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    Base.TipoBase := 'B';
    Base.System := qryConsulta.FieldByName('PPX_SISTEM').AsString;

    If qryBases.Locate('BAS_CODBAS', Base.CodigoBase, []) Then
    Begin
      Base.PesoEspecifico := qryBases.FieldByName('BAS_PESESP').AsFloat;
      Base.Embalagem      := qryBases.FieldByName('BAS_EMBALA').AsFloat;
    End;
  End;

  Formula.pCalcularDiluente(TVariantUtils.IfNull(dicRetorno['coddil'], strCodDil), TVariantUtils.IfNull(dicRetorno['pordil'], fltPorDil), qryConsulta);
end;


procedure TLibTintaPpgNexa.pRetItemColorante(const strColTinDet: String;
  var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String);
var
  dataSet: IDataSet;
begin
  dataSet := nil;
  strCodIte := '';
  strCodBas := '';
  Try
    Try
      dataSet := TAutcomTintaFactory.Get().fGetDataSet;
      dataSet.SQL:= fSelectBasesEmpresa(strCodEmp);
      SetaParametrosRetComponentes(dataSet, strColTinDet);
      dataSet.Open;

      If Not DataSet.IsEmpty Then
      Begin
        strCodIte := dataSet.FieldByName(GetCampoComponenteCodIte).AsString;
        strCodBas := dataSet.FieldByName(GetCampoComponenteCodComp).AsString;
      End;

      dataSet.Close;
      DataSet.SQL := GetInstrucaoRetComponentes(strCodEmp);
      SetaParametrosRetComponentes(dataSet, strColTinDet);
      dataSet.Open;

      If TStrUtils.fEmptyStr(strCodIte) Then
        strCodIte := dataSet.FieldByName(GetCampoComponenteCodIte).AsString;

      If TStrUtils.fEmptyStr(strCodBas) Then
        strCodBas := dataSet.FieldByName(GetCampoComponenteCodComp).AsString;

      strDesBas := dataSet.FieldByName('DESBAS').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    dataSet := nil;
  End;
end;

procedure TLibTintaPpgNexa.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
Var
  qryCadGen: IDataSet;
  strSQL   : String;
begin
  Try
    Try
      qryCadGen := TAutcomTintaFactory.Get.fGetDataSet;

      strSQL := '';
      strSQL := strSQL + ' SELECT *  ';
      strSQL := strSQL + ' FROM PPX_CADPPX  ';
      strSQL := strSQL + ' WHERE CONCAT( ';
      strSQL := strSQL + '    IFNULL(PPX_DESCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_VEICUL, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_MONTAD, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_TIPO__, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_A_N_O_, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODATC, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB10, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB10, "")) = :ITETIN;  ';

      qryCadGen.Close;
      qryCadGen.SQL := strSQL;
      qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
      qryCadGen.Open;

      if qryCadGen.IsEmpty then
      begin
        strSQL := '';
        strSQL := strSQL + ' SELECT *  ';
        strSQL := strSQL + ' FROM PPX_CADPPX  ';
        strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
        strSQL := strSQL + '    IFNULL(PPX_DESCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_VEICUL, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_MONTAD, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_TIPO__, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_A_N_O_, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODATC, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB10, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

        qryCadGen.Close;
        qryCadGen.SQL := strSQL;
        qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
        qryCadGen.Open;

        if (qryCadGen.IsEmpty) then
        begin
          strSQL := '';
          strSQL := strSQL + ' SELECT *  ';
          strSQL := strSQL + ' FROM PPX_CADPPX  ';
          strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
          strSQL := strSQL + '    IFNULL(PPX_DESCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_VEICUL, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_MONTAD, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_TIPO__, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_A_N_O_, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODATC, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB01, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB01, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB02, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB02, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB03, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB03, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB04, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB04, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB05, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB05, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB06, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB06, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB07, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB07, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB08, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB08, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB09, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB09, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB10, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB10, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB11, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB11, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB12, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB12, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB13, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB13, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB14, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB14, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB15, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB15, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB16, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB16, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB17, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB17, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB18, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB18, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB19, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB19, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_CODB20, ""),   ';
          strSQL := strSQL + '    IFNULL(PPX_QTDB20, ""))) AS CHAR) = :ITETIN;  ';

          qryCadGen.Close;
          qryCadGen.SQL := strSQL;
          qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
          qryCadGen.Open;

        end;
      end;

      if qryCadGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryCadGen.FieldByName('PPX_CODCOR').AsString;
      dicRetorno['montad'] := qryCadGen.FieldByName('PPX_MONTAD').AsString;
      dicRetorno['martin'] := qryCadGen.FieldByName('PPX_TIPO__').AsString;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;

  Finally

  End;
end;

function TLibTintaPpgNexa.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaPpgNexa.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraPPX: String;
    fltTraPPX: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('PPX');

  strTraPPX := conf.fGet('TRAPPX');
  fltTraPPX := conf.fGetDouble('FATPPX');

  If (strTraPPX = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraPPX, 2);
end;

end.
