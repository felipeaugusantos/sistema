unit untExportaTintometricosTerceirosColorPro;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, Math, strUtils,
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosAutomotiva,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;


Type
  TCompColorPro = Record
    Componente: String;
    Quantidade: Double;
    QuantidadeDiluida: Double;
    QuantidadeDiluida2: Double;
  End;

Type
  TPrecoPorEmbColorPro = record
    strSigEmb: String;
    fltValCon: Double;
    fltValDil: Double;
    fltValDil2: Double;
    fltPrecoVenda: Double;
    strIteEmb: String;
    fltPreEmb: Double;
    strCodDil: String;
    fltPorDil: Double;
End;

TArrPrecoPorEmbColorPro = Array of TPrecoPorEmbColorPro;

Type
  TExportaTintometricosTerceirosColorPro = Class(TExportaTintometricosTerceirosAutomotiva)
   Private
    strLinha: String;
    strCodAkz: String;
    strProWan: String;
    qryCfgLin: TUniQuery;
    qryCfgBas: TUniQuery;
    strAcrMob: String;
    strLinhaDil: String;
    strDiluente: String;
    fltPorceDil: Double;
    ArrEmbColorPro: TArrPrecoPorEmbColorPro;
    sCatalise: TStringList;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fRetVolumeOriginal(strLinha: String): Double;
    function fRetQuantidadeDiluida(qryTinta: TUniQuery; intContador: Integer; intRecNo: Integer): Double;
    function fRetQuantidadeDiluida2(qryTinta: TUniQuery; intContador: Integer; intRecNo: Integer): Double;
    function fRetQtdRegistros(qryGen: TUniQuery): Integer;
   Protected
     procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
      strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
     procedure pCriaTabelaExportacao; Override;

   {$IFDEF LINUX}
     procedure pValidarPrecoExportacaoColorPro(AMd5Key, AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double; dicPrecos: TDicionario; APrefix: String; strCatalise: String);
   {$ENDIF}
   Public
     function fNomeTabela(): String; Override;
     function fQuantidadeFormulacao(): Integer; Override;
     function fCamposTabela(): String; Override;
     function fCamposSelect(): String; Override;
     function fFatorTinta(): Double; Override;
     function fRetDescricao(): String; Override;
     function fRetItemBase(): String; Override;
     function fRetMD5KEY(): String; Override;
     function fRetFormula(intCont: Integer): String; Override;
     function fRetQuantidade(intCont: Integer): String; Override;
     function fSQLInsert(): String; Override;
     function fRetornaColorantes(): String; Override;
     function fRetornaBases(): String; Override;
     function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
     function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
     function fRetTipoCor(): String; Override;
     function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; Override;
     function fGetPorLinha(): Integer; Override;
     function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; Override;
     function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; Override;

     procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
       fltPreVen: Double; intParam: Integer = 0); Override;
     procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
     procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
     procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
     procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer); Reintroduce;
     procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; arrComponentes: Array Of TCompColorPro; intEmbalagem: Integer); Reintroduce;
     procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
     function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

     Procedure pCalculaPrecoConcentrado(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer);
     Procedure pCalculaPrecoConcentradoTabClientes(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intEmbalagem: Integer; intRecNo: Integer);
     Procedure pCalculaPrecoDiluido(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer);
     Procedure pCalculaPrecoDiluidoTabClientes(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intEmbalagem: Integer; intRecNo: Integer);
     Procedure pCalculaPrecoDiluido2(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer);
     Procedure pCalculaPrecoDiluido2TabClientes(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intEmbalagem: Integer; intRecNo: Integer);



     function fRetEmbalagemLT(strTipCor: String): String; //Embalagem Litro
     function fRetEmbalagemGL(strTipCor: String): String; //Embalagem Galão
     function fRetEmbalagemLA(strTipCor: String): String; //Embalagem Lata
     function fRetEmbalagemCP(): String; // Embalagem Copo
     function fRetEmbalagemSP(): String; // Spray
     function fRetEmbalagemSS(): String; // Spray SIntetico
    // function fGetLinhaWandaPro(): String; // Where Select por linha

     procedure pCriaClientEmbalagem(Conexao: TUniConnection);
     procedure pRetTabelasVenda(Conexao: TUniConnection);
     procedure pPreencheEmbalagens;
     procedure pPreencheArrayEmbalagem;

    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
       blnAuto: Boolean = False); Override;

    function fRetItemVenda(Conexao: TUniConnection): String;

    destructor Destroy; Override;

    //Calculos

    procedure pRetornaCodPorDiluente(strLinha: String);
    //procedure pRetornaInfoLinha(strLinha: String; Var strLinDil, strBasDil: String;
    //  Var fltFatBas, fltPerDil: Double; strConDil: String);

    //function fCalculoA(dicRetorno: TDicionario; strConDil:String; intIndex: Integer; qryBases: TUniQuery; fltVolumePro: Double; strLinha: String): Double;
    //function fCalculoB(dicRetorno: TDicionario; strConDil:String; intIndex: Integer; qryBases: TUniQuery; fltVolumePro: Double; strLinha: String): Double;
    //function fCalculoBLinha8(dicRetorno: TDicionario; strConDil: String; intIndex: Integer; qryBases: TUniQuery; fltVolumePro: Double; strLinha: String): Double;
    //function fCalculoC(dicRetorno: TDicionario; intIndex: Integer; qryBases: TUniQuery; fltVolumePro: Double): Double;


  End;

implementation

{ TExportaTintometricosTerceirosColorPro }

constructor TExportaTintometricosTerceirosColorPro.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProWan := '';
  strLinha  := '';
  strCodAkz := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  sCatalise := TStringList.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();

  qryCfgLin := fCriaQuery();
  qryCfgBas := fCriaQuery();

  qryCfgLin.Close;
  qryCfgLin.SQL.Clear;
  qryCfgLin.SQL.Add('SELECT * FROM CFGTIN WHERE CFG_IDEPRO = "WCP" AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryCfgLin.Open;

  qryCfgBas.Close;
  qryCfgBas.SQL.Clear;
  qryCfgBas.SQL.Add('SELECT * FROM CFGTIN WHERE CFG_IDEPRO = "WCP" AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryCfgBas.Open;
end;

destructor TExportaTintometricosTerceirosColorPro.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);

  If Assigned(qryCfgLin) Then
    FreeAndNil(qryCfgLin);

  If Assigned(qryCfgBas) Then
    FreeAndNil(qryCfgBas);

  If Assigned(sCatalise) Then
    FreeAndNil(sCatalise);
end;

procedure TExportaTintometricosTerceirosColorPro.Execute;
begin
  inherited;

end;

{function TExportaTintometricosTerceirosColorPro.fCalculoA(
  dicRetorno: TDicionario; strConDil: String; intIndex: Integer;
  qryBases:TUniQuery; fltVolumePro: Double; strLinha: String): Double;
Var
  intCont: Integer;

  arrX: Array[1..20] Of Double;
  arrW: Array[1..20] Of Double;
  arrY: Array[1..20] Of Double;
  arrT: Array[1..20] Of Double;

  fltSomaW: Double;
  fltDilui: Double;
  strLinDil: String;
  strCodDil: String;
  fltFatBas: Double;
begin
  pRetornaInfoLinha(strLinha, strLinDil,  strCodDil, fltFatBas, fltDilui, strConDil);
  dicRetorno['coddil'] := strCodDil;
  dicRetorno['pordil'] := fltDilui;

  fltSomaW := 0.0;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin

    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
        Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;

    If strConDil = 'DIL' Then
    Begin
      If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
        arrX[intCont] := fltDilui
      Else
        arrX[intCont] := dicRetorno['porc' + fStrZero(intCont, 2)] * (100 - fltDilui) / 100;
    End
    Else If strConDil = 'CON' Then
    Begin
      If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
        arrX[intCont] := 0
      Else
        arrX[intCont] := dicRetorno['porc' + fStrZero(intCont, 2)];
    End;

    arrW[intCont] := arrX[intCont] / qryBases.FieldByName('BAS_PESESP').AsFloat;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;

    arrY[intCont] := (fltVolumePro * 1000 * arrW[intCont]) / fltSomaW;
    arrT[intCont] := RoundTo(arrY[intCont] * qryBases.FieldByName('BAS_PESESP').AsFloat, -1);
  End;

  Result := arrT[intIndex];

end;   }

{function TExportaTintometricosTerceirosColorPro.fCalculoB(
  dicRetorno: TDicionario; strConDil: String; intIndex: Integer;
  qryBases:TUniQuery; fltVolumePro: Double; strLinha: String): Double;
Var
  intCont: Integer;

  arrX: Array[1..20] Of Double;
  arrW: Array[1..20] Of Double;
  arrY: Array[1..20] Of Double;
  arrT: Array[1..20] Of Double;

  fltSomaW: Double;
  fltDilui: Double;

  strLinDil: String;
  strCodDil: String;

  fltFatBas: Double;
  fltThinner: Double;
  fltTinta: Double;

Begin
  For intCont := 1 To 20 Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  fltSomaW := 0.0;
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;


    {*******************************************}
    {* CATÁLISE 2:1                            *}
    {****************************************RG*}
    {If strConDil = 'DIL' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);
      dicRetorno['coddil'] := strCodDil;
      dicRetorno['pordil'] := fltDilui;

      If Pos(fStrZero(strLinha, 2), '13_') > 0 Then
      Begin
        fltTinta   := (fltVolumePro * 1000) / 1.10;
        fltThinner := (fltDilui * fltTinta) / 100;

        If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := fltTinta;
      End
      Else If Pos(fStrZero(strLinha, 2), '58_') > 0 Then
      Begin
        arrX[intCont] := 0;
      End;
    End
    {*******************************************}
    {* CATÁLISE 4:1                            *}
    {****************************************RG*}
    {Else If strConDil = 'DI2' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);
      dicRetorno['coddil'] := strCodDil;
      dicRetorno['pordil'] := fltDilui;

      If Pos(fStrZero(strLinha, 2), '58_') > 0 Then
      Begin
        fltThinner := (fltDilui * (fltVolumePro * 1000)) / 100;
        If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := (fltVolumePro * 1000) - fltThinner;
      End
      Else If Pos(fStrZero(strLinha, 2), '13_') > 0 Then
      Begin
        fltTinta   := (fltVolumePro * 1000) / 1.25;
        fltThinner := (fltDilui * fltTinta) / 100;
        If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := fltTinta;
      End
    End
    {*******************************************}
    {* CATÁLISE 9:2                            *}
    {****************************************RG*}
    {Else If strConDil = 'DI9_2' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);
      dicRetorno['coddil'] := strCodDil;
      dicRetorno['pordil'] := fltDilui;

      fltTinta := (fltVolumePro * 1000) / 1.11;
      fltThinner := (fltDilui * fltTinta) / 100;

      If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
        arrX[intCont] := fltThinner
      Else
        arrX[intCont] := fltTinta;
    End
    {*******************************************}
    {* CONCENTRADO                             *}
    {****************************************RG*}
    {Else If strConDil = 'CON' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
        arrX[intCont] := 0
      Else
        arrX[intCont] := fltVolumePro * 1000;
    End;

    arrW[intCont] := dicRetorno['porc' + fStrZero(intCont, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;

    If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
      arrY[intCont] := arrX[intCont]
    Else
      arrY[intCont] := arrX[intCont] * arrW[intCont] / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * qryBases.FieldByName('BAS_PESESP').AsFloat, -1);
  End;

  Result := arrT[intIndex];
End; }

{function TExportaTintometricosTerceirosColorPro.fCalculoBLinha8(
  dicRetorno: TDicionario; strConDil: String; intIndex: Integer;
  qryBases: TUniQuery; fltVolumePro: Double; strLinha: String): Double;
Var
  intCont: Integer;

  arrX: Array[1..20] Of Double;
  arrW: Array[1..20] Of Double;
  arrY: Array[1..20] Of Double;
  arrT: Array[1..20] Of Double;

  fltSomaW: Double;
  fltDilui: Double;
  fltFatBas: Double;
  fltThinner: Double;
  fltTinta: Double;

  strLinDil: String;
  strCodDil: String;
begin
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  fltSomaW := 0.0;
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;


    {*******************************************}
    {* CATÁLISE 2:1                            *}
    {****************************************RG*}
    {If strConDil = 'DIL' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);
      dicRetorno['coddil'] := strCodDil;
      dicRetorno['pordil'] := fltDilui;

      fltTinta   := (fltVolumePro * 1000) / 0.8205666;
      fltThinner := (fltDilui * fltTinta) / 100;
      fltTinta   := (fltVolumePro * 1000) - fltThinner;

      If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
        arrX[intCont] := fltThinner
      Else
        arrX[intCont] := fltTinta;
    End
    {*******************************************}
    {* CATÁLISE 4:1                            *}
    {****************************************RG*}
    {Else If strConDil = 'DI2' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);
      dicRetorno['coddil'] := strCodDil;
      dicRetorno['pordil'] := fltDilui;

      fltThinner := (fltDilui * (fltVolumePro * 1000)) / 100;
      fltTinta   := (fltVolumePro * 1000) - fltThinner;

      If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
        arrX[intCont] := fltThinner
      Else
        arrX[intCont] := fltTinta;
    End
    {*******************************************}
    {* CONCENTRADO                             *}
    {****************************************RG*}
    {Else If strConDil = 'CON' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
        arrX[intCont] := 0.0
      Else
        arrX[intCont] := fltVolumePro * 1000;
    End;

    arrW[intCont] := dicRetorno['porc' + fStrZero(intCont, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;

    If (strLinha = strLinDil) And (dicRetorno['base' + fStrZero(intCont, 2)] = strCodDil) Then
      arrY[intCont] := arrX[intCont]
    Else
      arrY[intCont] := arrX[intCont] * arrW[intCont] / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * qryBases.FieldByName('BAS_PESESP').AsFloat, -1);
  End;

  Result := arrT[intIndex];
end;    }

{function TExportaTintometricosTerceirosColorPro.fCalculoC(
  dicRetorno: TDicionario; intIndex: Integer; qryBases: TUniQuery;
  fltVolumePro: Double): Double;
Var
  intCont: Integer;
  arrR: Array[1..20] Of Double;
  arrW: Array[1..20] Of Double;
  arrY: Array[1..20] Of Double;
  arrT: Array[1..20] Of Double;
  fltSomaW: Double;
begin
  fltSomaW := 0.0;
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    arrR[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;


  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;

    If dicRetorno['base' + fStrZero(intCont, 2)] = 'QR080' Then
      arrR[intCont] := 0
    Else
      arrR[intCont] := (dicRetorno['porc' + fStrZero(intCont, 2)] * 100) / (100 - 23);


    arrW[intCont] := arrR[intCont] / qryBases.FieldByName('BAS_PESESP').AsFloat;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], strLinha]), []) Then
      Break;


    If dicRetorno['base' + fStrZero(intCont, 2)] = 'Q080' Then
      arrY[intCont] := fltVolumePro * 1000 / 2
    Else
      arrY[intCont] := ((fltVolumePro * 1000 / 2) * arrW[intCont]) / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * qryBases.FieldByName('BAS_PESESP').AsFloat, -1);
  End;

  Result := arrT[intIndex];
end;}

function TExportaTintometricosTerceirosColorPro.fCamposSelect: String;
Var
  intContador : Integer;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    WAN_LINHA_,                       ';
  Result := Result + '    WAN_NOMLIN,                       ';
  Result := Result + '    WAN_DESCRI,                       ';
  Result := Result + '    WAN_CODAKZ,                       ';
  Result := Result + '    WAN_ALTERN,                       ';
  Result := Result + '    WAN_MONTAD,                       ';
  Result := Result + '    WAN_ANOINI,                       ';
  Result := Result + '    WAN_ANOFIN,                       ';
  Result := Result + '    WAN_CATALI,                       ';
  Result := Result + '    WAN_CAMADA,                       ';
  Result := Result + '    WAN_CONCUS,                       ';
  Result := Result + '    WAN_CONVEN,                       ';
  Result := Result + '    WAN_DILCUS,                       ';
  Result := Result + '    WAN_DILVEN,                       ';
  Result := Result + '    WAN_4P1CUS,                       ';
  Result := Result + '    WAN_4P1VEN,                       ';
  Result := Result + '    WAN_VERCOR,                       ';
  Result := Result + '    WAN_ACRMOB,                       ';

  For intContador := 1 To fQuantidadeFormulacao Do
  Begin
    Result := Result + '    WAN_LINC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_CODC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_QCON' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_QD21' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_QD41' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_QD92' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_PORC' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    WAN_MD5KEY                        ';

  Result := Result + '  FROM                                ';

  Result := Result + '    WANPRO_CADWAN                     ';
  Result := Result + '    LEFT JOIN WANPRO_CODUNI ON        ';
  Result := Result + '      WANPRO_CODAKZ = WAN_CODAKZ AND  ';
  Result := Result + '      WANPRO_ALTERN = WAN_ALTERN AND  ';
  Result := Result + '      WANPRO_VERCOR = WAN_VERCOR      ';

  Result := Result + '  WHERE                               ';
  Result := Result + '    WAN_NOMLIN = "' + arrLinha[intLinha].strNome  + '"   AND          ';
  Result := Result + '    WAN_LINHA_ = "' + arrLinha[intLinha].strLinha + '"                ';
  Result := Result + '  GROUP BY                            ';
  Result := Result + '    WAN_CODAKZ, WAN_ALTERN, WAN_CAMADA, WAN_VERCOR, WAN_DESCRI ';
end;

function TExportaTintometricosTerceirosColorPro.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + ' (           ';
  Result := Result + '    WAN_LINHA_ CHAR(3) DEFAULT NULL,              ';
  Result := Result + '    WAN_NOMLIN VARCHAR(50) DEFAULT NULL,          ';
  Result := Result + '    WAN_DESCRI VARCHAR(50) DEFAULT NULL,          ';
  Result := Result + '    WAN_CODAKZ VARCHAR(15) DEFAULT NULL,          ';
  Result := Result + '    WAN_ALTERN CHAR(3) DEFAULT NULL,              ';
  Result := Result + '    WAN_MONTAD VARCHAR(30) DEFAULT NULL,          ';
  Result := Result + '    WAN_ANOINI VARCHAR(10) DEFAULT NULL,          ';
  Result := Result + '    WAN_ANOFIN VARCHAR(10) DEFAULT NULL,          ';
  Result := Result + '    WAN_CATALI TEXT DEFAULT NULL,                 ';
  Result := Result + '    WAN_CAMADA INT(1) DEFAULT NULL,               ';
  Result := Result + '    WAN_CONCUS DECIMAL(12, 2) DEFAULT 0.00,       ';
  Result := Result + '    WAN_CONVEN DECIMAL(12, 2) DEFAULT 0.00,       ';
  Result := Result + '    WAN_DILCUS DECIMAL(12, 2) DEFAULT 0.00,       ';
  Result := Result + '    WAN_DILVEN DECIMAL(12, 2) DEFAULT 0.00,       ';
  Result := Result + '    WAN_4P1CUS DECIMAL(12, 2) DEFAULT 0.00,       ';
  Result := Result + '    WAN_4P1VEN DECIMAL(12, 2) DEFAULT 0.00,       ';
  Result := Result + '    WAN_VERCOR CHAR(3) DEFAULT NULL,              ';
  Result := Result + '    WAN_MD5KEY VARCHAR(32) DEFAULT NULL,          ';

  Result := Result + '    WAN_CODITE VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    WAN_CODDIL VARCHAR(20) DEFAULT NULL,          ';
  Result := Result + '    WAN_PORDIL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_TIPPRE CHAR(1) DEFAULT NULL,              ';
  Result := Result + '    WAN_CATDIL VARCHAR(5) DEFAULT NULL,           ';

  Result := Result + '    WAN_PREVLT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREVGL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREVLA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREVCP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREVSP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREVSS DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PRECLT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRECGL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRECLA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRECCP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRECSP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRECSS DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PRE1LT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE2LT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE3LT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE4LT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE5LT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE6LT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE7LT DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PRE1GL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE2GL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE3GL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE4GL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE5GL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE6GL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE7GL DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PRE1LA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE2LA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE3LA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE4LA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE5LA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE6LA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE7LA DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PRE1CP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE2CP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE3CP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE4CP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE5CP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE6CP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE7CP DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PRE1SP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE2SP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE3SP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE4SP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE5SP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE6SP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE7SP DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PRE1SS DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE2SS DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE3SS DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE4SS DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE5SS DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE6SS DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PRE7SS DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_EMBALT VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    WAN_EMBAGL VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    WAN_EMBALA VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    WAN_EMBACP VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    WAN_EMBASP VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    WAN_EMBASS VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';

  Result := Result + '    WAN_VOLULT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_VOLUGL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_VOLULA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_VOLUCP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_VOLUSP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_VOLUSS DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_PREELT DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREEGL DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREELA DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREECP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREESP DECIMAL(12, 4) DEFAULT 0.0000,     ';
  Result := Result + '    WAN_PREESS DECIMAL(12, 4) DEFAULT 0.0000,     ';

  Result := Result + '    WAN_TIPOLT CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    WAN_TIPOGL CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    WAN_TIPOLA CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    WAN_TIPOCP CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    WAN_TIPOSP CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    WAN_TIPOSS CHAR(2) DEFAULT NULL               ';
  Result := Result + '                        );                        ';
end;

function TExportaTintometricosTerceirosColorPro.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosColorPro.fGetPorLinha: Integer;
Var
  qryGen: TUniQuery;
  strSQL: String;
  strLinha: String;
begin
  qryGen := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                    ';
    strSQL := strSQL + '    CFG_VALCFG AS LINHA     ';
    strSQL := strSQL + '  FROM                      ';
    strSQL := strSQL + '    CFGTIN                  ';
    strSQL := strSQL + '  WHERE                     ';
    strSQL := strSQL + '    CFG_IDEPRO = "WCP" AND              ';
    strSQL := strSQL + '    CFG_CODCFG = "LINWAN" AND           ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '" ';


    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    strLinha := qryGen.FieldByName('LINHA').AsString;
  Finally
    FreeAndNil(qryGen);
  End;

  SetLength(arrLinha, 0);

  If Pos('001', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOBASE PLUS 100:50';
    arrLinha[Length(arrLinha) - 1].strLinha := '1';
  End;

  If Pos('004', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'WANDABASE HS';
    arrLinha[Length(arrLinha) - 1].strLinha := '4';
  End;

  If Pos('006', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'WANDALAC';
    arrLinha[Length(arrLinha) - 1].strLinha := '6';
  End;


  If Pos('008', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'WANDA PU HS';
    arrLinha[Length(arrLinha) - 1].strLinha := '8';
  End;

  If Pos('009', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'WANDACAR';
    arrLinha[Length(arrLinha) - 1].strLinha := '9';
  End;

  If Pos('011', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'SINGLE STAGE CONVERTER';
    arrLinha[Length(arrLinha) - 1].strLinha := '11';
  End;

  If Pos('012', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOBASE PLUS BASELINE 100:80';
    arrLinha[Length(arrLinha) - 1].strLinha := '12';
  End;

  If Pos('014', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOBASE PLUS 100:80';
    arrLinha[Length(arrLinha) - 1].strLinha := '14';
  End;

  If Pos('016', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOCOAT BT120';
    arrLinha[Length(arrLinha) - 1].strLinha := '16';
  End;

  If Pos('019', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOBASE PLUS BASELINE 100:50';
    arrLinha[Length(arrLinha) - 1].strLinha := '19';
  End;

  If Pos('058', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'WANDA PU MS';
    arrLinha[Length(arrLinha) - 1].strLinha := '58';
  End;

  If Pos('059', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOCOAT BT90';
    arrLinha[Length(arrLinha) - 1].strLinha := '59';
  End;

  If Pos('013', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOCOAT BT100';
    arrLinha[Length(arrLinha) - 1].strLinha := '13';
  End;

  If Pos('015', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOCOAT BT110';
    arrLinha[Length(arrLinha) - 1].strLinha := '15';
  End;

  If Pos('017', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOCOAT BT130';
    arrLinha[Length(arrLinha) - 1].strLinha := '17';
  End;

  If Pos('027', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'AUTOWAVE MM';
    arrLinha[Length(arrLinha) - 1].strLinha := '27';
  End;

  If Pos('072', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'TECH FLEET PU';
    arrLinha[Length(arrLinha) - 1].strLinha := '72';
  End;

  If Pos('074', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'TECH FLEET EPOXY';
    arrLinha[Length(arrLinha) - 1].strLinha := '74';
  End;

  If Pos('075', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'TECH FLEET SINTETICO';
    arrLinha[Length(arrLinha) - 1].strLinha := '75';
  End;

  If Pos('076', strLinha) > 0 Then
  Begin
    SetLength(arrLinha, Length(arrLinha) + 1);
    arrLinha[Length(arrLinha) - 1].strNome  := 'TECH FLEET LACA';
    arrLinha[Length(arrLinha) - 1].strLinha := '76';
  End;

  Result := Length(arrLinha);
end;

function TExportaTintometricosTerceirosColorPro.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

{function TExportaTintometricosTerceirosColorPro.fGetLinhaWandaPro: String;
Var
  qryGen : TUniQuery;
  strLin : String;
  intOpc : Integer;
  arrOpc : Array Of String;
begin
  Result := '';

  qryGen := fCriaQuery();
  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add('    SELECT CFG_VALCFG AS VALOR        ');
  qryGen.SQL.Add('      FROM CFGTIN                     ');
  qryGen.SQL.Add('    WHERE CFG_IDEPRO = "WCP"  AND     ');
  qryGen.SQL.Add('          CFG_CODCFG = "LINWAN" AND   ');
  qryGen.SQL.Add('          CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryGen.Open;

  strLin := qryGen.FieldByName('VALOR').AsString; //LINHAS DISPONIVEIS PARA O SELECT

  FreeAndNil(qryGen);

  If Pos('001', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := ' 1 Autobase Plus 100:50';
  End;

  If Pos('004', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := ' 4 Wandabase HS';
  End;

  If Pos('006', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := ' 6 Wandalac';
  End;

  If Pos('008', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := ' 8 Wanda PU HS';
  End;

  If Pos('009', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := ' 9 Wandacar';
  End;

  If Pos('011', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '11 Single Stage Converter';
  End;

  If Pos('012', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '12 Autobase Plus Baseline 100:80';
  End;

  If Pos('014', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '14 Autobase Plus 100:80';
  End;

  If Pos('016', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '16 Autocoat BT120';
  End;

  If Pos('019', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '19 Autobase Plus Baseline 100:50';
  End;

  If Pos('058', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '58 Wanda PU MS';
  End;

  If Pos('059', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '59 Autocoat BT90';
  End;

  If Pos('013', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '13 Autocoat BT100';
  End;

  If Pos('15', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '15 Autocoat BT110';
  End;

  If Pos('17', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '17 Autocoat BT130';
  End;

  If Pos('27', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '27 Autowave MM';
  End;

  If Pos('67', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '67 Autowave MM 2.0';
  End;

  If Pos('72', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '72 Tech Fleet PU';
  End;

  If Pos('74', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '74 Tech Fleet Epoxy';
  End;

  If Pos('75', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '75 Tech Fleet Sintetico';
  End;

  If Pos('76', strLin) > 0 Then
  Begin
    SetLength(arrOpc, Length(arrOpc) + 1);
    arrOpc[Length(arrOpc) - 1] := '76 Tech Fleet Laca';
  End;

  If Length(arrOpc) >= 2 Then
  Begin
    intOpc := fGetMenu('Linha', arrOpc, 1);
    Result := Trim(LeftStr(arrOpc[intOpc - 1], 2));
  End
  Else If Length(arrOpc) = 1 Then
  Begin
    intOpc := 1;
    Result := Trim(LeftStr(arrOpc[intOpc - 1], 2));
  End;



end; }

function TExportaTintometricosTerceirosColorPro.fNomeTabela: String;
begin
  Result := 'WANPRO_CADWAN_SIT';
end;

function TExportaTintometricosTerceirosColorPro.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosColorPro.fRetDescricao: String;
begin
  Result := 'WAN_DESCRI';
end;

function TExportaTintometricosTerceirosColorPro.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
end;

function TExportaTintometricosTerceirosColorPro.fRetEmbalagemCP: String;
begin
  Result := 'WANICO';
end;

function TExportaTintometricosTerceirosColorPro.fRetEmbalagemGL(
  strTipCor: String): String;
begin
  Result := '';

  Case AnsiIndexStr(strTipCor,
    ['1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
     '27', '58', '59', '72', '74', '75', '76']) Of
    0  :  Begin //1
            Result := 'PLSIGL';
          End;
    1  :  Begin //4
            Result := 'WAHSGL';
          End;
    2  :  Begin //6
            Result := 'WALAGL';
          End;
    3  :  Begin //8
            Result := 'PUHSGL';
          End;
    4  :  Begin //9
            Result := 'WCARGL';
          End;
    5  :  Begin //11
            Result := 'SISTGL';
          End;
    6  :  Begin //12
            Result := 'PLBAGL';
          End;
    7  :  Begin //13
            Result := 'BTSIGL';
          End;
    8  :  Begin //14
            Result := 'PLAUGL';
          End;
    9  :  Begin //15
            Result := 'BT11GL';
          End;
    10 :  Begin //16
            Result := 'BT12GL';
          End;
    11 :  Begin //17
            Result := 'BT13GL';
          End;
    12 :  Begin //19
            Result := 'PLBLGL';
          End;
    13 :  Begin //27
            Result := 'MMSIGL';
          End;
    14 :  Begin //58
            Result := 'PUMSGL';
          End;
    15 :  Begin //59
            Result := 'BT90GL';
          End;
    16 :  Begin //72
            Result := 'TFPUGL';
          End;
    17 :  Begin //74
            Result := 'TFEPGL';
          End;
    18 :  Begin //75
            Result := 'TFSIGL';
          End;
    19 :  Begin //76
            Result := 'TFLAGL';
          End;
  End;
end;

function TExportaTintometricosTerceirosColorPro.fRetEmbalagemLA(
  strTipCor: String): String;
begin
  Result := '';

  Case AnsiIndexStr(strTipCor,
    ['1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
     '27', '58', '59', '72', '74', '75', '76']) Of
    0 :  Begin //1
           Result := 'PLSILA';
         End;
    1 :  Begin //4
           Result := 'WAHSLA';
         End;
    2 :  Begin //6
           Result := 'WALALA';
         End;
    3 :  Begin //8
           Result := 'PUHSLA';
         End;
    4 :  Begin //9
           Result := 'WCARLA'
         End;
    5 :  Begin //11
           Result := 'SISTLA';
         End;
    6 :  Begin //12
           Result := 'PLBALA';
         End;
    7 :  Begin //13
           Result := 'BTSILA';
         End;
    8 :  Begin //14
           Result := 'PLAULA';
         End;
    9 :  Begin //15
           Result := 'BT11LA';
         End;
    10 : Begin //16
           Result := 'BT12LA';
         End;
    11 : Begin //17
           Result := 'BT13LA';
         End;
    12 : Begin //19
           Result := 'PLBLLA';
         End;
    13 : Begin //27
           Result := 'MMSILA';
         End;
    14 : Begin //58
           Result := 'PUMSLA';
         End;
    15 : Begin //59
           Result := 'BT90LA';
         End;
    16 : Begin //72
           Result := 'TFPULA';
         End;
    17 : Begin //74
           Result := 'TFEPLA';
         End;
    18 : Begin //75
           Result := 'TFSILA';
         End;
    19 : Begin //76
           Result := 'TFLALA';
         End;
  End;
end;

function TExportaTintometricosTerceirosColorPro.fRetEmbalagemLT(
  strTipCor: String): String;
begin
  Result := '';

  Case AnsiIndexStr(strTipCor,
    ['1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
     '27', '58', '59', '72', '74', '75', '76']) Of
    0  : Begin //1
           Result := 'PLSILT';
         End;
    1  : Begin //4
           Result := 'WAHSLT';
         End;
    2  : Begin //6
           Result := 'WALALT';
         End;
    3  : Begin //8
           Result := 'PUHSLT';
         End;
    4  : Begin //9
           Result := 'WCARLT';
         End;
    5  : Begin //11
           Result := 'SISTLT';
         End;
    6  : Begin //12
           Result := 'PLBALT';
         End;
    7  : Begin //13
           Result := 'BTSILT';
         End;
    8  : Begin //14
           Result := 'PLAULT';
         End;
    9  : Begin //15
           Result := 'BT11LT';
         End;
    10 : Begin //16
           Result := 'BT12LT';
         End;
    11 : Begin //17
           Result := 'BT13LT';
         End;
    12 : Begin //19
           Result := 'PLBLLT';
         End;
    13 : Begin //27
           Result := 'MMSILT';
         End;
    14 : Begin //58
           Result := 'PUMSLT';
         End;
    15 : Begin //59
           Result := 'BT90LT';
         End;
    16 : Begin //72
           Result := 'TFPULT';
         End;
    17 : Begin //74
           Result := 'TFEPLT';
         End;
    18 : Begin //75
           Result := 'TFSILT';
         End;
    19 : Begin //76
           Result := 'TFLALT';
         End;
  End;
end;

function TExportaTintometricosTerceirosColorPro.fRetEmbalagemSP: String;
begin
  Result := 'WANISP';
end;

function TExportaTintometricosTerceirosColorPro.fRetEmbalagemSS: String;
begin
  Result := 'WANISS';
end;

function TExportaTintometricosTerceirosColorPro.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'WAN_CODC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosColorPro.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosColorPro.fRetItemVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    *                 ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_IDEPRO = "WCP" AND        ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '" AND   ';
    strSQL := strSQL + '    CFG_CODCFG = "PROWAN"         ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosColorPro.fRetMD5KEY: String;
begin
  Result := 'WAN_MD5KEY';
end;

function TExportaTintometricosTerceirosColorPro.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    BAS_CODITE,                   ';
  Result := Result + '    BAS_CODBAS,                   ';
  Result := Result + '    BAS_LINHA_,                   ';
  Result := Result + '    BAS_EMBALA,                   ';
  Result := Result + '    BAS_PESESP,                   ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,  ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';

  Result := Result + '  FROM                            ';
  Result := Result + '    WANPRO_CADBAS B               ';
  Result := Result + '    INNER JOIN CADITE I ON        ';
  Result := Result + '      B.BAS_CODITE = I.ITE_CODITE ';
  Result := Result + '    INNER JOIN ITEGER G ON        ';
  Result := Result + '      I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ';';
end;

function TExportaTintometricosTerceirosColorPro.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor'])
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA(dicRetorno['tipcor'])
  ELse If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP
  Else If strSigEmb = 'SS' Then
    Result := fRetEmbalagemSS;
end;

function TExportaTintometricosTerceirosColorPro.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosColorPro.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosColorPro.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT                            ');
    qryGen.SQL.Add('    CFG_VALCFG  AS VALCFG           ');
    qryGen.SQL.Add('  FROM                              ');
    qryGen.SQL.Add('    CFGTIN                          ');
    qryGen.SQL.Add('  WHERE                             ');
    qryGen.SQL.Add('    CFG_IDEPRO = "WCP"  AND         ');
    qryGen.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp) +  ' AND  ');
    qryGen.SQL.Add('    CFG_CODCFG = "APREVE"           ');
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('VALCFG').AsString) Then
      Result := 0
    Else
      Result := fStrToFloat(qryGen.FieldByName('VALCFG').AsString) / 100.0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosColorPro.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosColorPro.fRetQtdRegistros(
  qryGen: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  sCatalise.Clear;

  intContador := 0;
  sCatalise.Add('CON');
  
  If qryGen.FieldByName('WAN_QD2101').AsFloat > 0 Then
  Begin
    Inc(intContador);
    sCatalise.Add('2:1');
  End;

  If qryGen.FieldByName('WAN_QD4101').AsFloat > 0 Then
  Begin
    Inc(intContador);
    sCatalise.Add('4:1');
  End;

  If qryGen.FieldByName('WAN_QD9201').AsFloat > 0 Then
  Begin
    Inc(intContador);  
    sCatalise.Add('9:2');
  End;

  Result := intContador;
end;

function TExportaTintometricosTerceirosColorPro.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'WAN_QCON' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosColorPro.fRetQuantidadeDiluida(qryTinta: TUniQuery; intContador: Integer; intRecNo: Integer): Double;
begin
  Result := qryTinta.FieldByName('WAN_QD21' + fStrZero(intContador, 2)).AsFloat;

  If sCatalise[intRecNo] = '4:1' Then
    Result := qryTinta.FieldByName('WAN_QD41' + fStrZero(intContador, 2)).AsFloat
  Else If sCatalise[intRecNo] = '9:2' Then
    Result := qryTinta.FieldByName('WAN_QD92' + fStrZero(intContador, 2)).AsFloat;
end;

function TExportaTintometricosTerceirosColorPro.fRetQuantidadeDiluida2(qryTinta: TUniQuery; intContador: Integer; intRecNo: Integer): Double;
begin
  Result := 0;

  If sCatalise[intRecNo] = '4:1' Then
    Result := qryTinta.FieldByName('WAN_QD41' + fStrZero(intContador, 2)).AsFloat
  Else If sCatalise[intRecNo] = '2:1' Then
    Result := qryTinta.FieldByName('WAN_QD21' + fStrZero(intContador, 2)).AsFloat
  Else If sCatalise[intRecNo] = '9:2' Then
    Result := qryTinta.FieldByName('WAN_QD92' + fStrZero(intContador, 2)).AsFloat;
end;

function TExportaTintometricosTerceirosColorPro.fRetTipoCor: String;
begin
  Result := 'WAN_LINHA_';
end;

function TExportaTintometricosTerceirosColorPro.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "WCP" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosColorPro.fRetVolumeOriginal(
  strLinha: String): Double;
begin
  Result := 0.900;

  If Pos(fStrZero(strLinha, 3), '008_058_059_013_072_') > 0 Then
  Begin
    If strLinha = '8' Then
      Result := 0.640
    Else If strLinha = '13' Then
      Result := 0.618
    Else
      Result := 0.750;
  End;
end;

function TExportaTintometricosTerceirosColorPro.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + ' (   ';

  Result := Result + '    WAN_LINHA_,                         ';
  Result := Result + '    WAN_NOMLIN,                         ';
  Result := Result + '    WAN_DESCRI,                         ';
  Result := Result + '    WAN_CODAKZ,                         ';
  Result := Result + '    WAN_ALTERN,                         ';
  Result := Result + '    WAN_MONTAD,                         ';
  Result := Result + '    WAN_ANOINI,                         ';
  Result := Result + '    WAN_ANOFIN,                         ';
  Result := Result + '    WAN_CATALI,                         ';
  Result := Result + '    WAN_CAMADA,                         ';
  Result := Result + '    WAN_CONCUS,                         ';
  Result := Result + '    WAN_CONVEN,                         ';
  Result := Result + '    WAN_DILCUS,                         ';
  Result := Result + '    WAN_DILVEN,                         ';
  Result := Result + '    WAN_4P1CUS,                         ';
  Result := Result + '    WAN_4P1VEN,                         ';
  Result := Result + '    WAN_VERCOR,                         ';
  Result := Result + '    WAN_MD5KEY,                         ';

  Result := Result + '    WAN_CODITE,                         ';
  Result := Result + '    WAN_CODDIL,                         ';
  Result := Result + '    WAN_PORDIL,                         ';
  Result := Result + '    WAN_TIPPRE,                         ';
  Result := Result + '    WAN_CATDIL,                         ';

  Result := Result + '    WAN_PREVLT,                         ';
  Result := Result + '    WAN_PREVGL,                         ';
  Result := Result + '    WAN_PREVLA,                         ';
  Result := Result + '    WAN_PREVCP,                         ';
  Result := Result + '    WAN_PREVSP,                         ';
  Result := Result + '    WAN_PREVSS,                         ';

  Result := Result + '    WAN_PRECLT,                         ';
  Result := Result + '    WAN_PRECGL,                         ';
  Result := Result + '    WAN_PRECLA,                         ';
  Result := Result + '    WAN_PRECCP,                         ';
  Result := Result + '    WAN_PRECSP,                         ';
  Result := Result + '    WAN_PRECSS,                         ';

  Result := Result + '    WAN_PRE1LT,                         ';
  Result := Result + '    WAN_PRE2LT,                         ';
  Result := Result + '    WAN_PRE3LT,                         ';
  Result := Result + '    WAN_PRE4LT,                         ';
  Result := Result + '    WAN_PRE5LT,                         ';
  Result := Result + '    WAN_PRE6LT,                         ';
  Result := Result + '    WAN_PRE7LT,                         ';

  Result := Result + '    WAN_PRE1GL,                         ';
  Result := Result + '    WAN_PRE2GL,                         ';
  Result := Result + '    WAN_PRE3GL,                         ';
  Result := Result + '    WAN_PRE4GL,                         ';
  Result := Result + '    WAN_PRE5GL,                         ';
  Result := Result + '    WAN_PRE6GL,                         ';
  Result := Result + '    WAN_PRE7GL,                         ';

  Result := Result + '    WAN_PRE1LA,                         ';
  Result := Result + '    WAN_PRE2LA,                         ';
  Result := Result + '    WAN_PRE3LA,                         ';
  Result := Result + '    WAN_PRE4LA,                         ';
  Result := Result + '    WAN_PRE5LA,                         ';
  Result := Result + '    WAN_PRE6LA,                         ';
  Result := Result + '    WAN_PRE7LA,                         ';

  Result := Result + '    WAN_PRE1CP,                         ';
  Result := Result + '    WAN_PRE2CP,                         ';
  Result := Result + '    WAN_PRE3CP,                         ';
  Result := Result + '    WAN_PRE4CP,                         ';
  Result := Result + '    WAN_PRE5CP,                         ';
  Result := Result + '    WAN_PRE6CP,                         ';
  Result := Result + '    WAN_PRE7CP,                         ';

  Result := Result + '    WAN_PRE1SP,                         ';
  Result := Result + '    WAN_PRE2SP,                         ';
  Result := Result + '    WAN_PRE3SP,                         ';
  Result := Result + '    WAN_PRE4SP,                         ';
  Result := Result + '    WAN_PRE5SP,                         ';
  Result := Result + '    WAN_PRE6SP,                         ';
  Result := Result + '    WAN_PRE7SP,                         ';

  Result := Result + '    WAN_PRE1SS,                         ';
  Result := Result + '    WAN_PRE2SS,                         ';
  Result := Result + '    WAN_PRE3SS,                         ';
  Result := Result + '    WAN_PRE4SS,                         ';
  Result := Result + '    WAN_PRE5SS,                         ';
  Result := Result + '    WAN_PRE6SS,                         ';
  Result := Result + '    WAN_PRE7SS,                         ';

  Result := Result + '    WAN_EMBALT,                         ';
  Result := Result + '    WAN_EMBAGL,                         ';
  Result := Result + '    WAN_EMBALA,                         ';
  Result := Result + '    WAN_EMBACP,                         ';
  Result := Result + '    WAN_EMBASP,                         ';
  Result := Result + '    WAN_EMBASS,                         ';

  Result := Result + '    WAN_VOLULT,                         ';
  Result := Result + '    WAN_VOLUGL,                         ';
  Result := Result + '    WAN_VOLULA,                         ';
  Result := Result + '    WAN_VOLUCP,                         ';
  Result := Result + '    WAN_VOLUSP,                         ';
  Result := Result + '    WAN_VOLUSS,                         ';

  Result := Result + '    WAN_PREELT,                         ';
  Result := Result + '    WAN_PREEGL,                         ';
  Result := Result + '    WAN_PREELA,                         ';
  Result := Result + '    WAN_PREECP,                         ';
  Result := Result + '    WAN_PREESP,                         ';
  Result := Result + '    WAN_PREESS,                         ';

  Result := Result + '    WAN_TIPOLT,                         ';
  Result := Result + '    WAN_TIPOGL,                         ';
  Result := Result + '    WAN_TIPOLA,                         ';
  Result := Result + '    WAN_TIPOCP,                         ';
  Result := Result + '    WAN_TIPOSP,                         ';
  Result := Result + '    WAN_TIPOSS                          ';
  Result := Result + '                )                       ';

  Result := Result + '  VALUES        (                       ';

  Result := Result + '    :LINHA_,                            ';
  Result := Result + '    :NOMLIN,                            ';
  Result := Result + '    :DESCRI,                            ';
  Result := Result + '    :CODAKZ,                            ';
  Result := Result + '    :ALTERN,                            ';
  Result := Result + '    :MONTAD,                            ';
  Result := Result + '    :ANOINI,                            ';
  Result := Result + '    :ANOFIN,                            ';
  Result := Result + '    :CATALI,                            ';
  Result := Result + '    :CAMADA,                            ';
  Result := Result + '    :CONCUS,                            ';
  Result := Result + '    :CONVEN,                            ';
  Result := Result + '    :DILCUS,                            ';
  Result := Result + '    :DILVEN,                            ';
  Result := Result + '    :4P1CUS,                            ';
  Result := Result + '    :4P1VEN,                            ';
  Result := Result + '    :VERCOR,                            ';
  Result := Result + '    :MD5KEY,                            ';

  Result := Result + '    :CODITE,                            ';
  Result := Result + '    :CODDIL,                            ';
  Result := Result + '    :PORDIL,                            ';
  Result := Result + '    :TIPPRE,                            ';
  Result := Result + '    :CATDIL,                            ';

  Result := Result + '    :PREVLT,                            ';
  Result := Result + '    :PREVGL,                            ';
  Result := Result + '    :PREVLA,                            ';
  Result := Result + '    :PREVCP,                            ';
  Result := Result + '    :PREVSP,                            ';
  Result := Result + '    :PREVSS,                            ';

  Result := Result + '    :PRECLT,                            ';
  Result := Result + '    :PRECGL,                            ';
  Result := Result + '    :PRECLA,                            ';
  Result := Result + '    :PRECCP,                            ';
  Result := Result + '    :PRECSP,                            ';
  Result := Result + '    :PRECSS,                            ';

  Result := Result + '    :PRE1LT,                            ';
  Result := Result + '    :PRE2LT,                            ';
  Result := Result + '    :PRE3LT,                            ';
  Result := Result + '    :PRE4LT,                            ';
  Result := Result + '    :PRE5LT,                            ';
  Result := Result + '    :PRE6LT,                            ';
  Result := Result + '    :PRE7LT,                            ';

  Result := Result + '    :PRE1GL,                            ';
  Result := Result + '    :PRE2GL,                            ';
  Result := Result + '    :PRE3GL,                            ';
  Result := Result + '    :PRE4GL,                            ';
  Result := Result + '    :PRE5GL,                            ';
  Result := Result + '    :PRE6GL,                            ';
  Result := Result + '    :PRE7GL,                            ';

  Result := Result + '    :PRE1LA,                            ';
  Result := Result + '    :PRE2LA,                            ';
  Result := Result + '    :PRE3LA,                            ';
  Result := Result + '    :PRE4LA,                            ';
  Result := Result + '    :PRE5LA,                            ';
  Result := Result + '    :PRE6LA,                            ';
  Result := Result + '    :PRE7LA,                            ';

  Result := Result + '    :PRE1CP,                            ';
  Result := Result + '    :PRE2CP,                            ';
  Result := Result + '    :PRE3CP,                            ';
  Result := Result + '    :PRE4CP,                            ';
  Result := Result + '    :PRE5CP,                            ';
  Result := Result + '    :PRE6CP,                            ';
  Result := Result + '    :PRE7CP,                            ';

  Result := Result + '    :PRE1SP,                            ';
  Result := Result + '    :PRE2SP,                            ';
  Result := Result + '    :PRE3SP,                            ';
  Result := Result + '    :PRE4SP,                            ';
  Result := Result + '    :PRE5SP,                            ';
  Result := Result + '    :PRE6SP,                            ';
  Result := Result + '    :PRE7SP,                            ';

  Result := Result + '    :PRE1SS,                            ';
  Result := Result + '    :PRE2SS,                            ';
  Result := Result + '    :PRE3SS,                            ';
  Result := Result + '    :PRE4SS,                            ';
  Result := Result + '    :PRE5SS,                            ';
  Result := Result + '    :PRE6SS,                            ';
  Result := Result + '    :PRE7SS,                            ';

  Result := Result + '    :EMBALT,                            ';
  Result := Result + '    :EMBAGL,                            ';
  Result := Result + '    :EMBALA,                            ';
  Result := Result + '    :EMBACP,                            ';
  Result := Result + '    :EMBASP,                            ';
  Result := Result + '    :EMBASS,                            ';

  Result := Result + '    :VOLULT,                            ';
  Result := Result + '    :VOLUGL,                            ';
  Result := Result + '    :VOLULA,                            ';
  Result := Result + '    :VOLUCP,                            ';
  Result := Result + '    :VOLUSP,                            ';
  Result := Result + '    :VOLUSS,                            ';

  Result := Result + '    :PREELT,                            ';
  Result := Result + '    :PREEGL,                            ';
  Result := Result + '    :PREELA,                            ';
  Result := Result + '    :PREECP,                            ';
  Result := Result + '    :PREESP,                            ';
  Result := Result + '    :PREESS,                            ';

  Result := Result + '    :TIPOLT,                            ';
  Result := Result + '    :TIPOGL,                            ';
  Result := Result + '    :TIPOLA,                            ';
  Result := Result + '    :TIPOCP,                            ';
  Result := Result + '    :TIPOSP,                            ';
  Result := Result + '    :TIPOSS                             ';
  Result := Result + '              );                        ';
end;

function TExportaTintometricosTerceirosColorPro.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosColorPro.pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
  fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
  strSigEmb: String;
begin
  DataSet.ParamByName('LINHA_').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_LINHA_').AsString);
  DataSet.ParamByName('NOMLIN').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_NOMLIN').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_DESCRI').AsString);
  DataSet.ParamByName('CODAKZ').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_CODAKZ').AsString);
  DataSet.ParamByName('ALTERN').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_ALTERN').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_MONTAD').AsString);
  DataSet.ParamByName('ANOINI').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_ANOINI').AsString);
  DataSet.ParamByName('ANOFIN').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_ANOFIN').AsString);
  DataSet.ParamByName('CATALI').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_CATALI').AsString);
  DataSet.ParamByName('CAMADA').AsIntegers[intParam] := qryTinta.FieldByName('WAN_CAMADA').AsInteger;
  DataSet.ParamByName('CONCUS').AsFloats[intParam]   := qryTinta.FieldByName('WAN_CONCUS').AsFloat;
  DataSet.ParamByName('CONVEN').AsFloats[intParam]   := qryTinta.FieldByName('WAN_CONVEN').AsFloat;
  DataSet.ParamByName('DILCUS').AsFloats[intParam]   := qryTinta.FieldByName('WAN_DILCUS').AsFloat;
  DataSet.ParamByName('DILVEN').AsFloats[intParam]   := qryTinta.FieldByName('WAN_DILVEN').AsFloat;
  DataSet.ParamByName('4P1CUS').AsFloats[intParam]   := qryTinta.FieldByName('WAN_4P1CUS').AsFloat;
  DataSet.ParamByName('4P1VEN').AsFloats[intParam]   := qryTinta.FieldByName('WAN_4P1VEN').AsFloat;
  DataSet.ParamByName('VERCOR').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('WAN_VERCOR').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam]  := qryTinta.FieldByName('WAN_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam]  := strProWan;
  DataSet.ParamByName('TIPPRE').AsStrings[intParam]  := IIF(intParam = 0, 'C', 'D');
  DataSet.ParamByName('CATDIL').AsStrings[intParam]  := sCatalise[intParam];
  

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    strSigEmb := arrEmbalagens[intEmb].strSigEmb;

    DataSet.ParamByName('EMBA' + strSigEmb).AsStrings[intParam] := ArrEmbColorPro[intEmb].strIteEmb;
    DataSet.ParamByName('VOLU' + strSigEmb).AsFloats[intParam]  := arrEmbalagens[intEmb].fltVolume;
    DataSet.ParamByName('PREE' + strSigEmb).AsFloats[intParam]  := ArrEmbColorPro[intEmb].fltPreEmb;
    DataSet.ParamByName('TIPO' + strSigEmb).AsStrings[intParam] := strSigEmb;
    DataSet.ParamByName('CODDIL').AsStrings[intParam] := ArrEmbColorPro[intEmb].strCodDil;
    DataSet.ParamByName('PORDIL').AsFloats[intParam]  := ArrEmbColorPro[intEmb].fltPorDil;
    DataSet.ParamByName('PREC' + strSigEmb).AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS' + strSigEmb], 0.0);

    If strAcrMob = '1' Then
      DataSet.ParamByName('PREV' + strSigEmb).AsFloats[intParam] := ArrEmbColorPro[intEmb].fltPrecoVenda * (1 + qryTinta.FieldByName('WAN_ACRMOB').AsFloat / 100)
    Else
      DataSet.ParamByName('PREV' + strSigEmb).AsFloats[intParam] := fValorQuantidade(ArrEmbColorPro[intEmb].fltPrecoVenda, qryTinta.FieldByName('WAN_ACRMOB').AsFloat);

    For intContador := 1 To 7 Do
    Begin
      If stlTabPre[intContador] <> 'S' Then
        DataSet.ParamByName('PRE' + IntToStr(intContador) + strSigEmb).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + strSigEmb + IntToStr(intContador)], 0.0)
      Else
      Begin
        If strAcrMob = '1' Then
          DataSet.ParamByName('PRE' + IntToStr(intContador) + strSigEmb).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + strSigEmb + IntToStr(intContador)], 0.0) * (1 + qryTinta.FieldByName('WAN_ACRMOB').AsFloat / 100)
        Else
          DataSet.ParamByName('PRE' + IntToStr(intContador) + strSigEmb).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + strSigEmb + IntToStr(intContador)], 0.0), qryTinta.FieldByName('WAN_ACRMOB').AsFloat);  
      End;
    End;
  End;
end;

Procedure TExportaTintometricosTerceirosColorPro.pCalculaPrecoConcentrado(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer);
var
  intContador: Integer;
  strTabelaUnica: String;
  fltPrecoBase,
  fltPrecoEmbalagem,
  fltCustoBase,
  fltCustoEmbalagem,
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  VS_Embalagem: Double;
  intEmb: Integer;
  strCamEmb: String;
  fltVolOriCon,
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltPrecoCustoCon,
  fltPrecoCustoTotalCon: Double;
begin
  If intRecNo <> 0 Then
    Exit;
  
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltCustoBase       := 0;
  fltCustoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  strLinha  := qryGen.FieldByName('WAN_LINHA_').AsString;
  strCodAkz := qryGen.FieldByName('WAN_CODAKZ').AsString;

  fltVolOriCon  := 0.9;
  dicRetorno['coddil'] := '';
  dicRetorno['pordil'] := 0;

  SetLength(ArrEmbColorPro, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];
  dicPrecoAdicional.Limpar;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalCon := 0;
    fltPrecoCustoTotalCon := 0;

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If fEmptyStr(qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString) Then
          Break;

        If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString, strLinha]),[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          Begin
            fltPrecoBase := fltPreVenPro;
            fltCustoBase := fltPreCusPro;
          End
          Else
          Begin
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
            fltCustoBase := qryBases.FieldByName('PRECUS').AsFloat;
          End;
        End;

        VS_Embalagem := fRetEmbalagem(qryBases);

        //Preco de venda concentrado
        fltQuantCon := RoundTo(qryGen.FieldByName('WAN_QCON' + fStrZero(intContador, 2)).AsFloat / fltVolOriCon * arrEmbalagens[intEmb].fltVolume, -1);
        fltPrecoVendaCon := (fltQuantCon * fltPrecoBase) / VS_Embalagem;
        fltPrecoCustoCon := (fltQuantCon * fltCustoBase) / VS_Embalagem;
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;
      End;

      If IsNan(fltPrecoVendaTotalCon) Or IsInfinite(fltPrecoVendaTotalCon) Then
        fltPrecoVendaTotalCon := 0;

      If IsNan(fltPrecoCustoTotalCon) Or IsInfinite(fltPrecoCustoTotalCon) Then
        fltPrecoCustoTotalCon := 0;

      //Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro);
          fltCustoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro);
        End
        Else
        Begin
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
          fltCustoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
        End;
      End;

      If fltPrecoVendaTotalCon > 0 Then
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

      If fltPrecoCustoTotalCon > 0 Then
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + (fltPerAcr * fltPrecoCustoTotalCon) + fltCustoEmbalagem;

      arrEmbColorPro[intEmb].strSigEmb  := arrEmbalagens[intEmb].strSigEmb;
      arrEmbColorPro[intEmb].fltPrecoVenda := fltPrecoVendaTotalCon;
      arrEmbColorPro[intEmb].strIteEmb  := cdsEmbalagens.FieldByName('CFG_VALCFG').AsString;
      arrEmbColorPro[intEmb].fltPreEmb  := fltPrecoEmbalagem;
      arrEmbColorPro[intEmb].strCodDil  := fRetornaCodigoDiluente(dicRetorno);
      arrEmbColorPro[intEmb].fltPorDil  := fRetornaPorcentagemDiluente(dicRetorno);
      dicPrecoAdicional['PRECUS' + arrEmbalagens[intEmb].strSigEmb] := fltPrecoCustoTotalCon;

      pCalculaPrecoConcentradoTabClientes(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen, intEmb, intRecNo);
    Finally
      //
    End;
  End;
end;

Procedure TExportaTintometricosTerceirosColorPro.pCalculaPrecoConcentradoTabClientes(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intEmbalagem: Integer; intRecNo: Integer);
var
  intContador: Integer;
  intPreVen: Integer;
  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  VS_Embalagem: Double;
  strCamEmb: String;
  strEmb: String;
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltVolOriCon: Double;
begin
  If intRecNo <> 0 Then
    Exit;
  
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltVolOriCon       := 0.9;

  SetLength(ArrEmbColorPro, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];

  strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmbalagem].strSigEmb, dicRetorno);
  strEmb := arrEmbalagens[intEmbalagem].strSigEmb;

  If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
    Exit;

  If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
    Exit;

  For intPreVen := 1 To 7 Do
  Begin
    fltPrecoVendaTotalCon  := 0;

    If stlTabPre[intPreVen] <> 'S' Then
      Continue;

    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If fEmptyStr(qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString) Then
          Break;

      If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString, strLinha]), []) Then
      Begin
        If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
          IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoBase := fltPreVenPro
        Else
          fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
      End;

      VS_Embalagem := fRetEmbalagem(qryBases);

      fltQuantCon := RoundTo(qryGen.FieldByName('WAN_QCON' + fStrZero(intContador, 2)).AsFloat / fltVolOriCon * arrEmbalagens[intEmbalagem].fltVolume, -1);
      fltPrecoVendaCon := (fltQuantCon * fltPrecoBase) / VS_Embalagem;
      fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;
    End;

    If IsNan(fltPrecoVendaTotalCon) Or IsInfinite(fltPrecoVendaTotalCon) Then
      fltPrecoVendaTotalCon := 0;

    If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
    Begin
      If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
        IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
      Else
        fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
    End;

    If fltPrecoVendaTotalCon > 0 Then
      fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +  (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

    dicPrecoAdicional['PREVE' + strEmb + IntToStr(intPreVen)] := fltPrecoVendaTotalCon;
  End;
end;

Procedure TExportaTintometricosTerceirosColorPro.pCalculaPrecoDiluido(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer);
var
  intContador: Integer;
  strTabelaUnica: String;
  fltPrecoBase,
  fltCustoBase,
  fltPrecoEmbalagem,
  fltCustoEmbalagem: Double;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  VS_Embalagem: Double;
  intEmb: Integer;
  strCamEmb: String;
  fltVolOriDil,
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoCustoDil,
  fltPrecoVendaTotalDil,
  fltPrecoCustoTotalDil: Double;
begin
  If intRecNo <> 1 Then
    Exit;
  
  fltPrecoBase       := 0;
  fltCustoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltCustoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  strLinha  := qryGen.FieldByName('WAN_LINHA_').AsString;
  strCodAkz := qryGen.FieldByName('WAN_CODAKZ').AsString;
  fltVolOriDil  := fRetVolumeOriginal(strLinha);

  If (strLinha <> strLinhaDil) Then
    pRetornaCodPorDiluente(strLinha);

  dicRetorno['coddil'] := strDiluente;
  dicRetorno['pordil'] := fltPorceDil;

  SetLength(ArrEmbColorPro, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];
  dicPrecoAdicional.Limpar;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalDil  := 0;
    fltPrecoCustoTotalDil  := 0;

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If fEmptyStr(qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString) Then
          Break;

        If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString, strLinha]),[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          Begin
            fltPrecoBase := fltPreVenPro;
            fltCustoBase := fltPreCusPro;
          End
          Else
          Begin
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
            fltCustoBase := qryBases.FieldByName('PRECUS').AsFloat;
          End;
        End;

        VS_Embalagem := fRetEmbalagem(qryBases);

        If intEmb = 0 Then
          fltQuantDil := RoundTo((IfNull(fRetQuantidadeDiluida(qryGen, intContador, intRecNo), 0) / fltVolOriDil) * fltVolOriDil, -1)
        Else
          fltQuantDil := RoundTo((IfNull(fRetQuantidadeDiluida(qryGen, intContador, intRecNo), 0) / fltVolOriDil) * arrEmbalagens[intEmb].fltVolume, -1);

        fltPrecoVendaDil := (fltQuantDil * fltPrecoBase) / VS_Embalagem;
        fltPrecoCustoDil := (fltQuantDil * fltCustoBase) / VS_Embalagem;
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
      End;

      If IsNan(fltPrecoVendaTotalDil) Or IsInfinite(fltPrecoVendaTotalDil) Then
        fltPrecoVendaTotalDil := 0;

      If IsNan(fltPrecoCustoTotalDil) Or IsInfinite(fltPrecoCustoTotalDil) Then
        fltPrecoCustoTotalDil := 0;

      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro);
          fltCustoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro);
        End
        Else
        Begin
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
          fltCustoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
        End;
      End;

      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

      If fltPrecoCustoTotalDil > 0 Then
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + (fltPerAcr * fltPrecoCustoTotalDil) + fltCustoEmbalagem;

      arrEmbColorPro[intEmb].strSigEmb  := arrEmbalagens[intEmb].strSigEmb;
      arrEmbColorPro[intEmb].fltPrecoVenda := fltPrecoVendaTotalDil;
      arrEmbColorPro[intEmb].strIteEmb  := cdsEmbalagens.FieldByName('CFG_VALCFG').AsString;
      arrEmbColorPro[intEmb].fltPreEmb  := fltPrecoEmbalagem;
      arrEmbColorPro[intEmb].strCodDil  := fRetornaCodigoDiluente(dicRetorno);
      arrEmbColorPro[intEmb].fltPorDil  := fRetornaPorcentagemDiluente(dicRetorno);
      dicPrecoAdicional['PRECUS' + arrEmbalagens[intEmb].strSigEmb] := fltPrecoCustoTotalDil;

      pCalculaPrecoDiluidoTabClientes(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen, intEmb, intRecNo);
    Finally
      //
    End;
  End;
end;

Procedure TExportaTintometricosTerceirosColorPro.pCalculaPrecoDiluido2(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer);
var
  intContador: Integer;
  strTabelaUnica: String;
  fltPrecoBase,
  fltPrecoEmbalagem,
  fltCustoBase,
  fltCustoEmbalagem,
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  VS_Embalagem: Double;
  intEmb: Integer;
  strCamEmb: String;
  fltVolOriDil2,
  fltQuantDil2,
  fltPrecoVendaDil2,
  fltPrecoVendaTotalDil2,
  fltPrecoCustoDil2,
  fltPrecoCustoTotalDil2: Double;
begin
  If intRecNo <> 2 Then
    Exit;
  
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltCustoBase       := 0;
  fltCustoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  strLinha  := qryGen.FieldByName('WAN_LINHA_').AsString;
  strCodAkz := qryGen.FieldByName('WAN_CODAKZ').AsString;
  fltVolOriDil2 := 0.750;

  If (strLinha <> strLinhaDil) Then
    pRetornaCodPorDiluente(strLinha);

  dicRetorno['coddil'] := strDiluente;
  dicRetorno['pordil'] := fltPorceDil;

  SetLength(ArrEmbColorPro, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];
  dicPrecoAdicional.Limpar;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalDil2 := 0;
    fltPrecoCustoTotalDil2 := 0;

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If fEmptyStr(qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString) Then
          Break;

        If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString, strLinha]),[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          Begin
            fltPrecoBase := fltPreVenPro;
            fltCustoBase := fltPreCusPro;
          End
          Else
          Begin
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
            fltCustoBase := qryBases.FieldByName('PRECUS').AsFloat;
          End;
        End;

        VS_Embalagem := fRetEmbalagem(qryBases);

        If intEmb = 0 Then
          fltQuantDil2 := RoundTo((IfNull(fRetQuantidadeDiluida2(qryGen, intContador, intRecNo), 0) / fltVolOriDil2) * fltVolOriDil2, -1)
        Else
          fltQuantDil2 := RoundTo((IfNull(fRetQuantidadeDiluida2(qryGen, intContador, intRecNo), 0) / fltVolOriDil2) * arrEmbalagens[intEmb].fltVolume, -1);

        fltPrecoVendaDil2 := (fltQuantDil2 * fltPrecoBase) / VS_Embalagem;
        fltPrecoCustoDil2 := (fltQuantDil2 * fltCustoBase) / VS_Embalagem;
        fltPrecoVendaTotalDil2 := fltPrecoVendaTotalDil2 + fltPrecoVendaDil2;
        fltPrecoCustoTotalDil2 := fltPrecoCustoTotalDil2 + fltPrecoCustoDil2;
      End;

      If IsNan(fltPrecoVendaTotalDil2) Or IsInfinite(fltPrecoVendaTotalDil2) Then
        fltPrecoVendaTotalDil2 := 0;

      If IsNan(fltPrecoCustoTotalDil2) Or IsInfinite(fltPrecoCustoTotalDil2) Then
        fltPrecoCustoTotalDil2 := 0;

      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro);
          fltCustoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro);
        End
        Else
        Begin
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
          fltCustoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
        End;
      End;

      If fltPrecoVendaTotalDil2 > 0 Then
        fltPrecoVendaTotalDil2 := fltPrecoVendaTotalDil2 + (fltPerAcr * fltPrecoVendaTotalDil2) + fltPrecoEmbalagem;

      If fltPrecoCustoTotalDil2 > 0 Then
        fltPrecoCustoTotalDil2 := fltPrecoCustoTotalDil2 + (fltPerAcr * fltPrecoCustoTotalDil2) + fltCustoEmbalagem;

      arrEmbColorPro[intEmb].strSigEmb  := arrEmbalagens[intEmb].strSigEmb;
      arrEmbColorPro[intEmb].fltPrecoVenda := fltPrecoVendaTotalDil2;
      arrEmbColorPro[intEmb].strIteEmb  := cdsEmbalagens.FieldByName('CFG_VALCFG').AsString;
      arrEmbColorPro[intEmb].fltPreEmb  := fltPrecoEmbalagem;
      arrEmbColorPro[intEmb].strCodDil  := fRetornaCodigoDiluente(dicRetorno);
      arrEmbColorPro[intEmb].fltPorDil  := fRetornaPorcentagemDiluente(dicRetorno);
      dicPrecoAdicional['PRECUS' + arrEmbalagens[intEmb].strSigEmb] := fltPrecoCustoTotalDil2;

      pCalculaPrecoDiluido2TabClientes(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen, intEmb, intRecNo);
    Finally
      //
    End;
  End;
end;

Procedure TExportaTintometricosTerceirosColorPro.pCalculaPrecoDiluido2TabClientes(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intEmbalagem: Integer; intRecNo: Integer);
var
  intContador: Integer;
  intPreVen: Integer;
  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  VS_Embalagem: Double;
  strCamEmb: String;
  strEmb: String;
  fltQuantDil2,
  fltPrecoVendaDil2,
  fltPrecoVendaTotalDil2,
  fltVolOriDil2: Double;
begin
  If intRecNo <> 2 Then
    Exit;
  
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltVolOriDil2      := 0.750;

  SetLength(ArrEmbColorPro, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];

  strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmbalagem].strSigEmb, dicRetorno);
  strEmb := arrEmbalagens[intEmbalagem].strSigEmb;

  If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
    Exit;

  If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
    Exit;

  For intPreVen := 1 To 7 Do
  Begin
    fltPrecoVendaTotalDil2 := 0;

    If stlTabPre[intPreVen] <> 'S' Then
      Continue;

    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If fEmptyStr(qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString) Then
            Break;

      If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString, strLinha]), []) Then
      Begin
        If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
          IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoBase := fltPreVenPro
        Else
          fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
      End;

      VS_Embalagem := fRetEmbalagem(qryBases);


      If intEmbalagem = 0 Then
        fltQuantDil2 := RoundTo((IfNull(fRetQuantidadeDiluida2(qryGen, intContador, intRecNo), 0) / fltVolOriDil2) * fltVolOriDil2, -1)
      Else
        fltQuantDil2 := RoundTo((IfNull(fRetQuantidadeDiluida2(qryGen, intContador, intRecNo), 0) / fltVolOriDil2) * arrEmbalagens[intEmbalagem].fltVolume, -1);

      fltPrecoVendaDil2 := (fltQuantDil2 * fltPrecoBase) / VS_Embalagem;
      fltPrecoVendaTotalDil2 := fltPrecoVendaTotalDil2 + fltPrecoVendaDil2;
    End;

    If IsNan(fltPrecoVendaTotalDil2) Or IsInfinite(fltPrecoVendaTotalDil2) Then
      fltPrecoVendaTotalDil2 := 0;

    If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
    Begin
      If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
        IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
      Else
        fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
    End;

    If fltPrecoVendaTotalDil2 > 0 Then
        fltPrecoVendaTotalDil2 := fltPrecoVendaTotalDil2 + (fltPerAcr * fltPrecoVendaTotalDil2) + fltPrecoEmbalagem;

    dicPrecoAdicional['PREVE' + strEmb + IntToStr(intPreVen)] := fltPrecoVendaTotalDil2;
  End;
end;

Procedure TExportaTintometricosTerceirosColorPro.pCalculaPrecoDiluidoTabClientes(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intEmbalagem: Integer; intRecNo: Integer);
var
  intContador: Integer;
  intPreVen: Integer;
  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  VS_Embalagem: Double;
  strCamEmb: String;
  strEmb: String;
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltVolOriDil: Double;
begin
  If intRecNo <> 1 Then
    Exit;
  
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltVolOriDil  := fRetVolumeOriginal(strLinha);

  SetLength(ArrEmbColorPro, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];

  strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmbalagem].strSigEmb, dicRetorno);
  strEmb := arrEmbalagens[intEmbalagem].strSigEmb;

  If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
    Exit;

  If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
    Exit;

  For intPreVen := 1 To 7 Do
  Begin
    fltPrecoVendaTotalDil  := 0;

    If stlTabPre[intPreVen] <> 'S' Then
      Continue;

    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If fEmptyStr(qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString) Then
        Break;

      If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([qryGen.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString, strLinha]), []) Then
      Begin
        If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
          IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoBase := fltPreVenPro
        Else
          fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
      End;

      VS_Embalagem := fRetEmbalagem(qryBases);

      //Preco de venda diluido

      If intEmbalagem = 0 Then
        fltQuantDil := RoundTo((IfNull(fRetQuantidadeDiluida(qryGen, intContador, intRecNo), 0) / fltVolOriDil) * fltVolOriDil, -1)
      Else
        fltQuantDil := RoundTo((IfNull(fRetQuantidadeDiluida(qryGen, intContador, intRecNo), 0) / fltVolOriDil) * arrEmbalagens[intEmbalagem].fltVolume, -1);

      fltPrecoVendaDil := (fltQuantDil * fltPrecoBase) / VS_Embalagem;
      fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
    End;

    If IsNan(fltPrecoVendaTotalDil) Or IsInfinite(fltPrecoVendaTotalDil) Then
      fltPrecoVendaTotalDil := 0;

    //Retorna preco da embalagem
    If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
    Begin
      If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
        IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
      Else
        fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
    End;

    If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

    dicPrecoAdicional['PREVE' + strEmb + IntToStr(intPreVen)] := fltPrecoVendaTotalDil;
  End;
end;

procedure TExportaTintometricosTerceirosColorPro.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT                ');
    qryGen.SQL.Add('    *                   ');
    qryGen.SQL.Add('  FROM                  ');
    qryGen.SQL.Add('    CFGTIN              ');
    qryGen.SQL.Add('  WHERE                 ');
    qryGen.SQL.Add('    CFG_IDEPRO = "WCP" AND              ');
    qryGen.SQL.Add('    CFG_GRUCFG = "CONFIGURACOES" AND    ');
    qryGen.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosColorPro.pCriaTabelaExportacao;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(fCamposTabela);
    qryGen.ExecSQL;
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('ALTER TABLE ' + fNomeTabela + ' ADD UNIQUE KEY (WAN_MD5KEY, WAN_TIPPRE, WAN_CATDIL)');
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosColorPro.pGravaTintometricoPorTintaTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0);
begin
  Try
    pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
  Finally
    SetLength(ArrEmbColorPro, 0);
  End;
end;

procedure TExportaTintometricosTerceirosColorPro.pIncluirLogTinSite(Conexao: TUniConnection;
  strStatus: string);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "WCP"  ');
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('  INSERT INTO LOGTIN_SIT  (             ');
    qryGen.SQL.Add('    LOG_IDEPRO,                         ');
    qryGen.SQL.Add('    LOG_DTAEXE,                         ');
    qryGen.SQL.Add('    LOG_HOREXE,                         ');
    qryGen.SQL.Add('    LOG_EXECUT                          ');
    qryGen.SQL.Add('                )                       ');
    qryGen.SQL.Add('  VALUES      (                         ');
    qryGen.SQL.Add('    "WCP",                              ');
    qryGen.SQL.Add('    :DTAEXE,                            ');
    qryGen.SQL.Add('    :HOREXE,                            ');
    qryGen.SQL.Add('    :EXECUT                             ');
    qryGen.SQL.Add('                    );                  ');

    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosColorPro.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  //Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (900 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (3600 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Lata
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Lata';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LA';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (18000 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (500 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (400 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray Sintetico
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Sintetico';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SS';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (100 / 1000);

end;

procedure TExportaTintometricosTerceirosColorPro.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosColorPro.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
  intRecord: Integer;
  intEmb: Integer;
begin
  qryGen.First;

  If Not FAutoma Then
    FProgresso.Position := 0;

{$IFDEF LINUX}
  FInicioExportacao := Now;
{$ENDIF}

{$IFDEF LINUX}
  pGerarArrayValidacao(qryGen.RecordCount);
{$ENDIF}

  While Not qryGen.Eof Do
  Begin
  {$IFDEF LINUX}
    If VS_ExitProcessSignal Then
      Break;
  {$ENDIF}

    intRecord := fRetQtdRegistros(qryGen);

    qryInsert.Params.ClearValues();
    qryInsert.Params.ArraySize := intRecord + 3;
    intContador := 0;

    dicRetorno.Limpar;
    pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);

    For intRegistros := 0 To intRecord Do
    Begin
    {$IFDEF LINUX}
      If VS_ExitProcessSignal Then
        Break;
    {$ENDIF}

      {************************************************************}
      {** VALIDAÇÃO FEITA PARA VERIFICAR SE EXISTE BASE AMARRADA **}
      {**         SE FOR 3 EXISTE BASE NÃO AMARRADA              **}
      {********************************************************RG**}
      If fGetTipoFormula(qryGen, qryBases) = 3 Then
      Begin
        If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

        qryGen.Next;
        Continue;
      End;

      pRetPrecoTintas(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen, intRegistros);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        For intEmb := 0 To Length(arrEmbalagens) - 1 Do
        Begin
          pValidarPrecoExportacaoColorPro(qryGen.FieldByName(fRetMD5KEY).AsString,
            arrEmbalagens[intEmb].strNomEmb, IIF(intRegistros <> 0, 'D', 'C'), arrEmbalagens[intEmb].strSigEmb,
            ArrEmbColorPro[intEmb].fltPrecoVenda, dicPrecoAdicional, IIF(intRegistros <> 0, '_CON', '_DIL'), sCatalise[intRegistros]);
        End;
      End;
    {$ENDIF}

      fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0);
      pGravaTintometricoTabelasTerceiros(qryInsert, fltPreven, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
        Synchronize(pStep);

      Inc(intContador, 1);
    End;

    If Not qryGen.Eof Then
      qryGen.Next
    Else
      Break;

  {$IFDEF LINUX}
    pEscreverAguardeInserindo;
  {$ENDIF}

    If intContador > 0 Then
      qryInsert.Execute(intContador, 0);

  {$IFDEF LINUX}
    pEscreverLogProgresso(qryGen);
  {$ENDIF}
  End;
end;

procedure TExportaTintometricosTerceirosColorPro.pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery;
  qryBases: TUniQuery);
//Var
//  intContador: Integer;
begin
  {For intContador := 1 To fQuantidadeFormulacao Do
  Begin

    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

    dicRetorno['porc' + fStrZero(intContador, 2)] := qryGen.FieldByName('WAN_PORC' + fStrZero(intContador, 2)).AsFloat;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat;
    dicRetorno['qt21' + fStrZero(intContador, 2)] := qryGen.FieldByName('WAN_QD21' + fStrZero(intContador, 2)).AsFloat;
    dicRetorno['qt41' + fStrZero(intContador, 2)] := qryGen.FieldByName('WAN_QD41' + fStrZero(intContador, 2)).AsFloat;
    dicRetorno['qt92' + fStrZero(intContador, 2)] := fFormataFloat(qryGen.FieldByName('WAN_QD92' + fStrZero(intContador, 2)).AsFloat, 3);
  End;}
end;

procedure TExportaTintometricosTerceirosColorPro.pRetornaCodPorDiluente(
  strLinha: String);
begin
  strLinhaDil := strLinha;

  If (strLinha = '4') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1WAN', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1WAN', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  33.33;
  End
  Else If (strLinha = '1') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1ABS_100_50', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1ABS_100_50', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  33.33;
  End
  Else If (strLinha = '14') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1ABS_100_80', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1ABS_100_80', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  44.4;
  End
  Else If (strLinha = '8') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1PU_HS', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1PU_HS', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  15.39;
  End
  Else If (strLinha = '58') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1PU_MS', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1PU_MS', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  20;
  End
  Else If (strLinha = '16') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1BT120', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1BT120', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  30;
  End
  Else If (strLinha = '59') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1BT90', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1BT90', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil := 0;
  End
  Else If (strLinha = '37') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1BT80', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1BT80', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  15;
  End
  Else If (strLinha = '13') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1BT100', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1BT100', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  10;
  End
  Else If (strLinha = '12') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LPAPB_10080', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BPAPB_10080', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  44.4;
  End
  Else If (strLinha = '19') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1ABS_BASELINE', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1ABS_BASELINE', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  33.33;
  End
  Else If (strLinha = '72') Then
  Begin
    qryCfgLin.Locate('CFG_CODCFG', 'LD1BT362', []);
    qryCfgBas.Locate('CFG_CODCFG', 'BD1BT362', []);

    strDiluente := qryCfgBas.FieldByName('CFG_VALCFG').AsString;
    fltPorceDil :=  11.111;
  End;
end;



procedure TExportaTintometricosTerceirosColorPro.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double; arrComponentes: Array Of TCompColorPro; intEmbalagem: Integer);
var
  intContador: Integer;
  intPreVen: Integer;

  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  VS_Embalagem: Double;
  strCamEmb: String;
  strEmb: String;

  //Otimização
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltQuantDil2,
  fltPrecoVendaDil2,
  fltPrecoVendaTotalDil2,
  fltPrecoCustoCon,
  fltPrecoCustoDil,
  fltPrecoCustoDil2,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
  fltPrecoCustoTotalDil2: Double;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;

  SetLength(ArrEmbColorPro, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];

  Begin
    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmbalagem].strSigEmb, dicRetorno);
    strEmb := arrEmbalagens[intEmbalagem].strSigEmb;

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Exit;

    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Exit;

    //Calcula o preço de venda - Tabela de clientes (Preve1 - Preve7)
    For intPreVen := 1 To 7 Do
    Begin
      fltPrecoVendaTotalCon  := 0;
      fltPrecoVendaTotalDil  := 0;
      fltPrecoVendaTotalDil2 := 0;

      If stlTabPre[intPreVen] <> 'S' Then
        Continue;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([ArrComponentes[intContador].Componente, strLinha]), []) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
        End;

        VS_Embalagem := fRetEmbalagem(qryBases);

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := (fltQuantCon * fltPrecoBase) / VS_Embalagem;
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].QuantidadeDiluida;
        fltPrecoVendaDil := (fltQuantDil * fltPrecoBase) / VS_Embalagem;
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;

        //Preco de venda diluido 2
        fltQuantDil2 := ArrComponentes[intContador].QuantidadeDiluida2;
        fltPrecoVendaDil2 := (fltQuantDil2 * fltPrecoBase) / VS_Embalagem;
        fltPrecoVendaTotalDil2 := fltPrecoVendaTotalDil2 + fltPrecoVendaDil2;
      End;

      If IsNan(fltPrecoVendaTotalCon) Or IsInfinite(fltPrecoVendaTotalCon) Then
        fltPrecoVendaTotalCon := 0;

      If IsNan(fltPrecoVendaTotalDil) Or IsInfinite(fltPrecoVendaTotalDil) Then
        fltPrecoVendaTotalDil := 0;

      If IsNan(fltPrecoVendaTotalDil2) Or IsInfinite(fltPrecoVendaTotalDil2) Then
        fltPrecoVendaTotalDil2 := 0;

      //Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
      End;

      //Preco de venda concentrado
      If fltPrecoVendaTotalCon > 0 Then
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
          (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

      //Preco de venda diluido
      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
          (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

      //Preco de venda diluido 2
      If fltPrecoVendaTotalDil2 > 0 Then
        fltPrecoVendaTotalDil2 := fltPrecoVendaTotalDil2 +
          (fltPerAcr * fltPrecoVendaTotalDil2) + fltPrecoEmbalagem;


      dicPrecoAdicional['PREVEN_CON' + strEmb + '_' + IntToStr(intPreVen)] := fltPrecoVendaTotalCon;
      dicPrecoAdicional['PREVEN_DIL' + strEmb + '_' + IntToStr(intPreVen)] := fltPrecoVendaTotalDil;
      dicPrecoAdicional['PREVEN_DI2' + strEmb + '_' + IntToStr(intPreVen)] := fltPrecoVendaTotalDil2;
    End;

    //Calcula o preço de custo concentrados e diluidos
    fltPrecoCustoTotalCon := 0;
    fltPrecoCustoTotalDil := 0;
    fltPrecoCustoTotalDil2 := 0;

    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

      If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([ArrComponentes[intContador].Componente, strLinha]),[]) Then
      Begin
        If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoBase := fltPreCusPro
        Else
          fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
      End;

      VS_Embalagem := fRetEmbalagem(qryBases);

      //Preco de custo concentrado
      fltQuantCon := ArrComponentes[intContador].Quantidade;
      fltPrecoCustoCon := (fltQuantCon * fltPrecoBase) / VS_Embalagem;
      fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

      //Preco de custo diluido
      fltQuantDil := ArrComponentes[intContador].QuantidadeDiluida;
      fltPrecoCustoDil := (fltQuantDil * fltPrecoBase) / VS_Embalagem;
      fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;

      //Preco de custo diluido 2
      fltQuantDil2 := ArrComponentes[intContador].QuantidadeDiluida2;
      fltPrecoCustoDil2 := (fltQuantDil2 * fltPrecoBase) / VS_Embalagem;
      fltPrecoCustoTotalDil2 := fltPrecoCustoTotalDil2 + fltPrecoCustoDil2;
    End;

    If IsNan(fltPrecoCustoTotalCon) Or IsInfinite(fltPrecoCustoTotalCon) Then
      fltPrecoCustoTotalCon := 0;

    If IsNan(fltPrecoCustoTotalDil) Or IsInfinite(fltPrecoCustoTotalDil) Then
      fltPrecoCustoTotalDil := 0;

    If IsNan(fltPrecoCustoTotalDil2) Or IsInfinite(fltPrecoCustoTotalDil2) Then
      fltPrecoCustoTotalDil2 := 0;

    //Retorna preço de custo da embalagem
    If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
    Begin
      If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro)
      Else
        fltPrecoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
    End;

    //Preco de custo concentrado
    If fltPrecoCustoTotalCon > 0 Then
      fltPrecoCustoTotalCon := fltPrecoCustoTotalCon +
        (fltPerAcr * fltPrecoCustoTotalCon) + fltPrecoEmbalagem;

    //Preco de custo diluido
    If fltPrecoCustoTotalDil > 0 Then
      fltPrecoCustoTotalDil := fltPrecoCustoTotalDil +
        (fltPerAcr * fltPrecoCustoTotalDil) + fltPrecoEmbalagem;

    //Preco de custo diluido 2
    If fltPrecoCustoTotalDil2 > 0 Then
      fltPrecoCustoTotalDil2 := fltPrecoCustoTotalDil2 +
        (fltPerAcr * fltPrecoCustoTotalDil2) + fltPrecoEmbalagem;

    dicPrecoAdicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
    dicPrecoAdicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
    dicPrecoAdicional['PRECUS_DI2' + strEmb] := fltPrecoCustoTotalDil2;
  End;
end;


procedure TExportaTintometricosTerceirosColorPro.pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery; intRecNo: Integer);
begin
  pCalculaPrecoConcentrado(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen, intRecNo);
  pCalculaPrecoDiluido(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen, intRecNo);
  pCalculaPrecoDiluido2(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen, intRecNo);  
end;

procedure TExportaTintometricosTerceirosColorPro.pRetTabelasVenda(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
  intContador: Integer;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    SIS_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGSIS              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    SIS_CODEMP = "' + VS_strCodEmp + '" AND       ';
    strSQL := strSQL + '    SIS_CODCFG = "CFG_TABPRC"   AND               ';
    strSQL := strSQL + '    SIS_GRUCFG = "PRODUTOS"                       ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    strCfgPre := qryGen.FieldByName('SIS_VALCFG').AsString;
    stlTabPre.Clear;
    stlTabPre.Add(strCfgPre);

    For intContador := 1 To 7 Do
      stlTabPre.Add(Copy(strCfgPre, intContador, 1));
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosColorPro.pSetaParametrosEspecificos(Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  pRetTabelasVenda(Conexao);
  strProWan := fRetItemVenda(Conexao);
end;

{$IFDEF LINUX}
procedure TExportaTintometricosTerceirosColorPro.pValidarPrecoExportacaoColorPro(
  AMd5Key, AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double;
  dicPrecos: TDicionario; APrefix, strCatalise: String);
var
  LValInfo: TValidateInf;
begin
  LValInfo.strIdePro := FIdePro;
  LValInfo.strMD5Key := AMd5Key;
  LValInfo.strEmbPro := AEmbPro;
  LValInfo.strTabPre := fRetornaTabelaPreco;
  LValInfo.strModVen := AModVen;
  LValInfo.fltPreVen := fltPreVen;
  LValInfo.strCodDil := '';
  LValInfo.fltPreCus := IfNull(dicPrecos['PRECUS' + ASigEmb], 0.0);
  LValInfo.fltPreVe1 := IfNull(dicPrecos['PREVE' + ASigEmb + '1'], 0.0);
  LValInfo.fltPreVe2 := IfNull(dicPrecos['PREVE' + ASigEmb + '2'], 0.0);
  LValInfo.fltPreVe3 := IfNull(dicPrecos['PREVE' + ASigEmb + '3'], 0.0);
  LValInfo.fltPreVe4 := IfNull(dicPrecos['PREVE' + ASigEmb + '4'], 0.0);
  LValInfo.fltPreVe5 := IfNull(dicPrecos['PREVE' + ASigEmb + '5'], 0.0);
  LValInfo.fltPreVe6 := IfNull(dicPrecos['PREVE' + ASigEmb + '6'], 0.0);
  LValInfo.fltPreVe7 := IfNull(dicPrecos['PREVE' + ASigEmb + '7'], 0.0);
  LValInfo.strCodDil := strCatalise;
  pValidacaoFormula(LValInfo, VS_strCodEmp);
end;
{$ENDIF}

end.



