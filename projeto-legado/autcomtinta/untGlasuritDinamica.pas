unit untGlasuritDinamica;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untGTinForTipos,
{$ELSE}
  Forms, Controls, ADODB, UniClientDataSet,
  untGlasuritSQLServer,
  untPnlBotoesAcoesNovaConsulta,
  untInicializarDllAutTin,
  untFuncoesSimples, Windows,
{$ENDIF}
  SysUtils, Uni, Classes,  StrUtils,
  untFuncEspecificas,
  Variants, Math,
  untTypesSistema;

Type
{$IFNDEF LINUX}
  TConsultaGlasurit = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;
{$ENDIF}

  TFormulaGlasurit = class(TFormulaAutomotiva)
    private
     {$IFNDEF LINUX}
      glasuritSQLServer: TGlasuritSQLServer;
     {$ENDIF}
      FantesCalcularFormula: TNotifyEvent;
      FdepoisCalcularFormula: TNotifyEvent;
      fltPerAcr: Double;
      fltAcrMob: Double;
      procedure pCarregarBasesSQLServerCasoNecessario;
     {$IFNDEF LINUX}
      procedure pCarregarBasesSQLServer;
     {$ENDIF}
    protected
      function fCalculaQuantidadeParaBaixaEstoque(objBase: TBaseAutomotiva): Double; Override;
    public
      blnRecarregarBases: Boolean;
      blnResina325: Boolean;
      procedure pCarregarColorantes; override;
      procedure pCalcularPrecos; override;
      procedure pCarregaPrecosBases; override;
     {$IFNDEF LINUX}
      procedure pConectarSQLServer(strIdCor: String; strLinha: String);
     {$ENDIF}
      Constructor Create(strTabPre: String); override;

      property antesCalcularFormula: TNotifyEvent Read FantesCalcularFormula Write FantesCalcularFormula;
      property depoisCalcularFormula: TNotifyEvent Read FdepoisCalcularFormula Write FdepoisCalcularFormula;
  End;

  {$IFNDEF LINUX}
  function fConsultaGlasuritDinamica(Sender: TForm): String; stdcall;
  function fConsultaGlasuritGeralDinamica(Sender: TForm): String; stdcall;
  function fConsultaGlasuritVendaDinamica(Sender: TForm; Var qryCadGla: TUniQuery; strTabPre: String;
    blnFaturamento, blnPermiteTab: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
  {$ENDIF}

  {$IFNDEF LINUX}
  function fConsultaGlasuritInterna(Sender: TForm; qryCadGla: TUniQuery;
    tipoConsulta: TTipoConsultaTinta; strTabPre: String; blnFaturamento, blnPermiteTab: Boolean;
    dicRetorno: TDicionario; sltItems: TStringList): String;
  {$ENDIF}

  function fRetornaDescricaoGlasuritDinamica(qryTinta: TUniQuery; strDesCor: String): String;

  {$IFNDEF LINUX}
  function fRetornaPrecoGlasuritDinamica(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  {$ENDIF}

  function fRetornaUniTraProGlasuritDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fGTinForGlasuritDinamica(strIteTin: String; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodDil: String; strTipPre: String): Boolean; stdcall;

  {$IFNDEF LINUX}
  function fDigDadosTintometricos(qryCadGla: TUniQuery; stlDesEmb, stlProEmbLt,
    stlProEmbGl: TStringList; strProEmbCo, strProEmbSp, strProEmbBa: String; Var strTipPre, strIteEmb,
    strTipEmb: String; Var intQtdEmb: Integer; Var fltPreEmb,
    fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String;
    dicRetorno: TDicionario; strDesCor: String): Boolean;
  {$ENDIF}

  function fModoFormulacaoIndireto: Boolean;

  procedure pRetornaDadosGlasuritDinamica(strIteTin: String; dicRetorno: TDicionario);

  procedure pRetornaTabelaPrecoGlasurit(dicRetorno: TDicionario; fltFatorAcerto: Double);

  function fRetornaAcrescimoMaoObra(strIteTin: String): Double;

implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica,
{$ELSE}
  untGravando,
  untDigTintaAutomotiva,
  untDigTintaAutomotivaSalcomix,
{$ENDIF}
  Data.DB,
  untIConfTinta ,untTintaMaquina,
  untConstantes, untGlasuritConsulta,untIConsultaTinta,
  untClientDataSetFactory,untICalculadorFatVendas,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteComparerBaseAutomotiva;

{$IFNDEF LINUX}
function fConsultaGlasuritDinamica(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaGlasuritInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, False, Nil, Nil);
  FreeAndNil(qryGen);
end;
{$ENDIF}

{$IFNDEF LINUX}
function fConsultaGlasuritGeralDinamica(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaGlasuritInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, False, Nil, Nil);
  FreeAndNil(qryGen);
end;
{$ENDIF}

{$IFNDEF LINUX}
function fConsultaGlasuritVendaDinamica(Sender: TForm; Var qryCadGla: TUniQuery; strTabPre: String;
  blnFaturamento, blnPermiteTab: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := fConsultaGlasuritInterna(Sender, qryCadGla, tpcVenda, strTabPre, blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
end;
{$ENDIF}

function fGTinForGlasuritDinamica(strIteTin: String; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
  strCodDil: String; strTipPre: String): Boolean; stdcall;
var
  strSQL: String;
  strCamFor: String;
  strCamBas: String;
  intPos: Integer;
  intContador: Integer;

  strBases: String;
  dicBases: TDicionario;
  qryGen: TUniQuery;

  strLinha: String;

  {$IFNDEF LINUX}
  glasuritSQLServer: TGlasuritSQLServer;
  tpsTipo: TTipoPreparoGlasurit;
  formula: TFormulaGlasuritSQLServer;
  {$ENDIF}

  cdsGen: TUniClientDataSet;
begin
  Result := False;
  Try
    Try
      qryGen := fCriaQuery(Nil);
      dicBases := TDicionario.Create;
      strBases := '';
      strLinha := '';

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  GLA_CADGLA ';
      strSQL := strSQL + 'WHERE ';

      If (fModoFormulacaoIndireto)     And
         (Pos('ESP ', strIteTin) <= 0) Then
      Begin
        strSQL := strSQL + ' 	GLA_CODSEQ = :ITETIN ';
      End
      Else
      Begin
        strSQL := strSQL + ' 	CONCAT(IFNULL(GLA_LINHA_, ''''), IFNULL(GLA_MONTAD, ''''), IFNULL(GLA_DESCRI, ''''), ';
        strSQL := strSQL + ' 			IFNULL(GLA_CODPRO, ''''), IFNULL(GLA_ANOCOR, ''''), IFNULL(GLA_VARIAC, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_FORM01, ''''), IFNULL(GLA_QTDB01, ''0.0''), IFNULL(GLA_FORM02, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_QTDB02, ''0.0''), IFNULL(GLA_FORM03, ''''), IFNULL(GLA_QTDB03, ''0.0''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_FORM04, ''''), IFNULL(GLA_QTDB04, ''0.0''), IFNULL(GLA_FORM05, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_QTDB05, ''0.0''), IFNULL(GLA_FORM06, ''''), IFNULL(GLA_QTDB06, ''0.0''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_FORM07, ''''), IFNULL(GLA_QTDB07, ''0.0''), IFNULL(GLA_FORM08, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_QTDB08, ''0.0''), IFNULL(GLA_FORM09, ''''), IFNULL(GLA_QTDB09, ''0.0''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_FORM10, ''''), IFNULL(GLA_QTDB10, ''0.0''), IFNULL(GLA_FORM11, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_QTDB11, ''0.0''), IFNULL(GLA_FORM12, ''''), IFNULL(GLA_QTDB12, ''0.0''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_FORM13, ''''), IFNULL(GLA_QTDB13, ''0.0''), IFNULL(GLA_FORM14, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_QTDB14, ''0.0''), IFNULL(GLA_FORM15, ''''), IFNULL(GLA_QTDB15, ''0.0''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_FORM16, ''''), IFNULL(GLA_QTDB16, ''0.0''), IFNULL(GLA_FORM17, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_QTDB17, ''0.0''), IFNULL(GLA_FORM18, ''''), IFNULL(GLA_QTDB18, ''0.0''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_FORM19, ''''), IFNULL(GLA_QTDB19, ''0.0''), IFNULL(GLA_FORM20, ''''),  ';
        strSQL := strSQL + ' 			IFNULL(GLA_QTDB20, ''0.0'')) = :ITETIN ';
      End;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('ITETIN').AsString := strIteTin;
        cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

        If (cdsGen.IsEmpty) Then
        Begin
          Close;
          Result := False;
          Exit;
        End;

        strLinha :=  cdsGen.FieldByName('GLA_LINHA_').AsString;

        If (fModoFormulacaoIndireto) And (Pos('ESP', cdsGen.FieldByName('GLA_CODPRO').AsString) <= 0) Then
        Begin
        {$IFDEF LINUX}
          Raise Exception.Create('fGTinForGlasuritDinamica.fModoFormulacaoIndireto nao implementado na compilacao linux');
        {$ELSE}
          If (strCodDil = 'D') Then
            tpsTipo := tpsDiluido
          Else
            tpsTipo := tpsConcentrado;

          glasuritSQLServer := TGlasuritSQLServer.Create(strIteTin, cdsGen.FieldByName('GLA_LINHA_').AsString);
          formula := glasuritSQLServer.fCalculaFormulacao(fltVolPro, tpsTipo);

          If (Not Assigned(formula)) Then
          Begin
            Result := False;
            Exit;
          End;

          For intContador := 0 To formula.Count -1 Do
          Begin
            arrFormul[intContador+1].strFormul := formula.Base[intContador].strCodBas;

            If formula.Base[intContador].fltQtdCon > 0 Then
              arrFormul[intContador+1].fltQtdBas := formula.Base[intContador].fltQtdCon
            Else
              arrFormul[intContador+1].fltQtdBas := formula.Base[intContador].fltQtdDil;

            dicBases[arrFormul[intContador+1].strFormul] := arrFormul[intContador+1].fltQtdBas;

            {*******************************************}
            {* GUARDA BASES PARA POSTERIOR BUSCA       *}
            {* DOS ITENS                               *}
            {****************************************MV*}
            strBases := strBases + QuotedStr(arrFormul[intContador+1].strFormul);
            If (Not fEmptyStr(arrFormul[intContador+1].strFormul)) Then
              strBases := strBases + ', ';
          End;
        {$ENDIF}
        End
        Else
        Begin
          For intContador := 1 To 18 Do
          Begin

            strCamFor := 'GLA_FORM' + fStrZero(IntToStr(intContador), 2);

            if Pos('ESP', cdsGen.FieldByName('GLA_CODPRO').AsString) > 0 then
            begin
              if strTipPre = 'C' then
                strCamBas := 'GLA_QTDB' + fStrZero(IntToStr(intContador), 2)
              else
                strCamBas := 'GLA_QTDD' + fStrZero(IntToStr(intContador), 2);
            end
            else
              strCamBas := 'GLA_QTDB' + fStrZero(IntToStr(intContador), 2);

            arrFormul[intContador].strFormul := cdsGen.FieldByName(strCamFor).AsString;
            arrFormul[intContador].fltQtdBas := (cdsGen.FieldByName(strCamBas).AsFloat * fltVolPro);

            dicBases[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

            {*******************************************}
            {* GUARDA BASES PARA POSTERIOR BUSCA       *}
            {* DOS ITENS                               *}
            {****************************************MV*}
            strBases := strBases + QuotedStr(arrFormul[intContador].strFormul);
            If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
              strBases := strBases + ', ';

          End;
        End;

        strBases := Trim(strBases);
        If (RightStr(strBases, 1) = ',') Then
          strBases := Copy(strBases, 1, Length(strBases)-1);

      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_CODBAS, ';
      strSQL := strSQL + '  BAS_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  GLA_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + GetInToOr('BAS_CODBAS', strBases);
      strSQL := strSQL + ' AND BAS_LINHA_ = :LINHA_ ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('LINHA_').AsString := strLinha;
        cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

        intPos := 0;
        SetLength(arrBaixaPigmentos, cdsGen.RecordCount);

        While (Not cdsGen.Eof) Do
        Begin

          {*******************************************}
          {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
          {* DE SALDO EM ML                          *}
          {****************************************MV*}
          stlItensTraMl.Add(cdsGen.FieldByName('BAS_CODITE').AsString);

          arrBaixaPigmentos[intPos].strCodIte   := cdsGen.FieldByName('BAS_CODITE').AsString;
          arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[cdsGen.FieldByName('BAS_CODBAS').AsString];
          Inc(intPos);
          cdsGen.Next;
        End;
      End;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen)   then FreeAndNil(qryGen);
    if Assigned(dicBases) then FreeAndNil(dicBases);
    {$IFNDEF LINUX}
    if Assigned(formula)  then FreeAndNil(formula);
    {$ENDIF}
  End;
end;

procedure pRetornaDadosGlasuritDinamica(strIteTin: String; dicRetorno: TDicionario);
Var
  qryCadGla: TUniQuery;
  cdsGen: TUniClientDataSet;
begin
  qryCadGla := nil;
  Try
    Try
      qryCadGla := fCriaQuery(Nil);

      With qryCadGla Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM GLA_CADGLA WHERE ');
        SQL.Add('	CONCAT(IFNULL(GLA_LINHA_, ''''), IFNULL(GLA_MONTAD, ''''), IFNULL(GLA_DESCRI, ''''),');
        SQL.Add('			IFNULL(GLA_CODPRO, ''''), IFNULL(GLA_ANOCOR, ''''), IFNULL(GLA_VARIAC, ''''), ');
        SQL.Add('			IFNULL(GLA_FORM01, ''''), IFNULL(GLA_QTDB01, ''0.0''), IFNULL(GLA_FORM02, ''''), ');
        SQL.Add('			IFNULL(GLA_QTDB02, ''0.0''), IFNULL(GLA_FORM03, ''''), IFNULL(GLA_QTDB03, ''0.0''), ');
        SQL.Add('			IFNULL(GLA_FORM04, ''''), IFNULL(GLA_QTDB04, ''0.0''), IFNULL(GLA_FORM05, ''''), ');
        SQL.Add('			IFNULL(GLA_QTDB05, ''0.0''), IFNULL(GLA_FORM06, ''''), IFNULL(GLA_QTDB06, ''0.0''), ');
        SQL.Add('			IFNULL(GLA_FORM07, ''''), IFNULL(GLA_QTDB07, ''0.0''), IFNULL(GLA_FORM08, ''''), ');
        SQL.Add('			IFNULL(GLA_QTDB08, ''0.0''), IFNULL(GLA_FORM09, ''''), IFNULL(GLA_QTDB09, ''0.0''), ');
        SQL.Add('			IFNULL(GLA_FORM10, ''''), IFNULL(GLA_QTDB10, ''0.0''), IFNULL(GLA_FORM11, ''''), ');
        SQL.Add('			IFNULL(GLA_QTDB11, ''0.0''), IFNULL(GLA_FORM12, ''''), IFNULL(GLA_QTDB12, ''0.0''), ');
        SQL.Add('			IFNULL(GLA_FORM13, ''''), IFNULL(GLA_QTDB13, ''0.0''), IFNULL(GLA_FORM14, ''''), ');
        SQL.Add('			IFNULL(GLA_QTDB14, ''0.0''), IFNULL(GLA_FORM15, ''''), IFNULL(GLA_QTDB15, ''0.0''), ');
        SQL.Add('			IFNULL(GLA_FORM16, ''''), IFNULL(GLA_QTDB16, ''0.0''), IFNULL(GLA_FORM17, ''''), ');
        SQL.Add('			IFNULL(GLA_QTDB17, ''0.0''), IFNULL(GLA_FORM18, ''''), IFNULL(GLA_QTDB18, ''0.0''), ');
        SQL.Add('			IFNULL(GLA_FORM19, ''''), IFNULL(GLA_QTDB19, ''0.0''), IFNULL(GLA_FORM20, ''''), ');
        SQL.Add('			IFNULL(GLA_QTDB20, ''0.0'')) = :ITETIN');

        ParamByName('ITETIN').AsString := strIteTin;
        cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadGla);
        dicRetorno['codtin'] := cdsGen.FieldByName('GLA_CODPRO').AsString;
        dicRetorno['montad'] := cdsGen.FieldByName('GLA_MONTAD').AsString;
        dicRetorno['martin'] := cdsGen.FieldByName('GLA_LINHA_').AsString;
        dicRetorno['variac'] := cdsGen.FieldByName('GLA_VARIAC').AsString;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadGla) then FreeAndNil(qryCadGla);
  End;

end;

function fRetornaUniTraProGlasuritDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strTraGlasurit: String;
    fltTraGlasurit: Double;
    conf: IConfTinta;
begin
  conf           := fGetConfTinta('GLA');
  strTraGlasurit := conf.fGet('TRAGLA');
  fltTraGlasurit := conf.fGetDouble('FATGLA');

  If (strTraGlasurit = 'VEN') Then
    Result := fltPrvTin
  Else
    Result := fltPrcTin;

  Result := fFormataFloat(Result * fltTraGlasurit, 2);
end;

function fRetornaDescricaoGlasuritDinamica(qryTinta: TUniQuery; strDesCor: String): String;
begin
  Result := strDesCor;
end;

{$IFNDEF LINUX}
function fRetornaPrecoGlasuritDinamica(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario; blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N';
  strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  Var
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    blnUsaPreCus: Boolean;
    strTipEmb: String;
    intQtdEmb: Integer;

    strIteTin: String;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
//    fltPrcTin: Double;
    fltPrvTin: Double;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;
    strChaFor: String;

    fltVolPro: Double;

    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    strProEmbCo: String;
    strProEmbSp: String;
    strProEmbBa: String;

    strTabPre: String;
    strTipPre: String;

    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor : String;
    conf: IConfTinta;
    strDesAdc: String;
begin

  Result := False;

  conf   := fGetConfTinta('GLA');

  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;
  strDesAdc := '';

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTipEmb    := dicRetorno['tipemb'];
  intQtdEmb    := dicRetorno['qtdemb'];
  strTabPre    := dicRetorno['tabpre'];
{
  If (fConsultaGlasuritVendaDinamica(Sender, qryTinta, strTabPre) = '-1') Then
  Begin
    Exit;
  End;
}
  If strTab = 'N' Then
  Begin
    strAuto := fConsultaGlasuritVendaDinamica(Sender, qryTinta, strTabPre, blnFaturamento, blnPermiteTab, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TGlasuritConsulta.Create;

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;

  stlDesEmb.Add('NORMAL');
  stlProEmbLt.Add(conf.fGet('GLAIEM'));
  stlProEmbGl.Add(conf.fGet('GLAIGL'));

  strProEmbCo := conf.fGet('GLAICO');
  strProEmbSp := conf.fGet('GLAISP');
  strProEmbBa := conf.fGet('GLABAL');

  If (fModoFormulacaoIndireto)                                      And
     (Pos('ESP', qryTinta.FieldByName('GLA_CODPRO').AsString) <= 0) Then
  Begin
    strIteTin := qryTinta.FieldByName('GLA_CODSEQ').AsString;
  End
  Else
  Begin
    strIteTin := qryTinta.FieldByName('GLA_LINHA_').AsString +
      qryTinta.FieldByName('GLA_MONTAD').AsString + qryTinta.FieldByName('GLA_DESCRI').AsString +
      qryTinta.FieldByName('GLA_CODPRO').AsString + qryTinta.FieldByName('GLA_ANOCOR').AsString +
      qryTinta.FieldByName('GLA_VARIAC').AsString + qryTinta.FieldByName('GLA_FORM01').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB01').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM02').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB02').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM03').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB03').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM04').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB04').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM05').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB05').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM06').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB06').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM07').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB07').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM08').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB08').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM09').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB09').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM10').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB10').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM11').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB11').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM12').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB12').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM13').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB13').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM14').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB14').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM15').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB15').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM16').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB16').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM17').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB17').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM18').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB18').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM19').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB19').AsFloat), ',', '.') + qryTinta.FieldByName('GLA_FORM20').AsString +
      AnsiReplaceStr(FormatFloat('0.0', qryTinta.FieldByName('GLA_QTDB20').AsFloat), ',', '.');
  End;

  strMontad := qryTinta.FieldByName('GLA_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('GLA_ANOCOR').AsString;

  strChaFor := qryTinta.FieldByName('GLA_LINHA_').AsString + ' ' +
               qryTinta.FieldByName('GLA_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('GLA_MONTAD').AsString + ' ' +
               qryTinta.FieldByName('GLA_CODPRO').AsString;

  fltPreCus := 0.0;
  fltUnitar := 0.0;

  If (Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt,
        stlProEmbGl, strProEmbCo, strProEmbSp, strProEmbBa,
        strTipPre, strIteEmb, strTipEmb, intQtdEmb, fltPreEmb, fltEmbala,
        fltPreCus, fltUnitar, fltVolPro, strTabPre, dicRetorno, strDesAdc)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(IfNull(dicRetorno['Desadc'], '') + ' ' + Tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  If blnUsaPreCus Then
    fltUnitar := fltPreCus;

//  fltPrcTin := fltPreCus;
  fltPrvTin := fltUnitar;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
//  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROGLA');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['tippre'] := strTipPre;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['volpro'] := fltVolPro;
  dicRetorno['chafor'] := strChaFor + strTipEmb;
  dicRetorno['descor'] := strDesCor;

  dicRetorno['linha_'] := qryTinta.FieldByName('GLA_LINHA_').AsString;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));

  Result := True;

end;
{$ENDIF}

{$IFNDEF LINUX}
function fDigDadosTintometricos(qryCadGla: TUniQuery; stlDesEmb, stlProEmbLt,
  stlProEmbGl: TStringList; strProEmbCo, strProEmbSp, strProEmbBa: String;
  Var strTipPre, strIteEmb, strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
  fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario;  strDesCor: String): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TFormulaGlasurit;
  intContador: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;

  procedure pInicializaFormDig(frmDig: TfrmDigTintaAutomotiva);
  begin
    frmDig.objFormula  := objFormula;
    frmDig.stlDesEmb   := stlDesEmb;
    frmDig.stlProEmbLt := stlProEmbLt;
    frmDig.stlProEmbGl := stlProEmbGl;
    frmDig.strProEmbCo := strProEmbCo;
    frmDig.strProEmbSp := strProEmbSp;
    frmDig.strProEmbBa := strProEmbBa;
    frmDig.Caption     := 'Glasurit';
    frmDig.chkComCat.Visible := False;
    frmDig.strIdePro   := 'GLA';
  end;

  procedure pPegaRetornosFormDig(frmDig: TfrmDigTintaAutomotiva);
  begin
    If (Result) Then
    Begin
      strIteEmb := frmDig.objFormula.strCodEmb;
      strTipPre := IIF(frmDig.rdgModoVenda.ItemIndex = 0, 'C', 'D');
      strDesCor := frmDig.edtDesAdc.Text;
      dicRetorno['Desadc'] := strDesCor;

      Case frmDig.objFormula.tpeTipEmb of
        teLitro  : begin
                     strTipEmb := 'LT';
                     fltEmbala := 0.900;
                   end;
        teCopo   : begin
                     strTipEmb := 'CP';
                     fltEmbala := 0.500;
                   end;
        teGalao  : begin
                     strTipEmb := 'GL';
                     fltEmbala := 3.600;
                   end;
        teSpray  : begin
                     strTipEmb := 'SP';
                     fltEmbala := 0.400;
                   end;
        teBalde  : begin
                     strTipEmb := 'BD';
                     fltEmbala := 18.000;
                   end;
      end;

      intQtdEmb := StrToIntDef(frmDig.edtQtdEmb.Text, 0);
      fltPreEmb := frmDig.objFormula.fltPrecoEmbalagem;

      If (frmDig.rdgModoVenda.ItemIndex = 0) Then
      Begin
        fltPreCus := frmDig.objFormula.fltPrecoCusCon;
        fltPreCu2 := frmDig.objFormula.fltPrecoCu2Con;
        fltPreVen := frmDig.objFormula.fltPrecoVenCon;
      End
      Else
      Begin
        fltPreCus := frmDig.objFormula.fltPrecoCusDil;
        fltPreCu2 := frmDig.objFormula.fltPrecoCu2Dil;
        fltPreVen := frmDig.objFormula.fltPrecoVenDil;
      End;

      fltPreCus := fltPreCus + frmDig.objFormula.fltPrecoCustoEmbalagem;
      fltPreCu2 := fltPreCu2 + frmDig.objFormula.fltPrecoCusto2Embalagem;
      fltPreVen := fltPreVen + fltPreEmb;

      dicRetorno['premed'] := IfThen(frmDig.rdgModoVenda.ItemIndex = 0,
        frmDig.objFormula.fltPreMedCon,
        frmDig.objFormula.fltPreMedDil) +
        frmDig.objFormula.fltPrecoMedioEmbalagem;

      dicRetorno['impult'] := IfThen(frmDig.rdgModoVenda.ItemIndex = 0,
        frmDig.objFormula.fltImpUltCon,
        frmDig.objFormula.fltImpUltDil) + frmDig.objFormula.fltUltimoImpostoEmbalagem;

      dicRetorno['preult'] := IfThen(frmDig.rdgModoVenda.ItemIndex = 0,
        frmDig.objFormula.fltPreUltCon,
        frmDig.objFormula.fltPreUltDil) + frmDig.objFormula.fltPreUltEmbalagem;

      dicRetorno['prctin'] := IfThen(frmDig.rdgModoVenda.ItemIndex = 0,
          frmDig.objFormula.fltComLiqCon,
          frmDig.objFormula.fltComLiqDil) + frmDig.objFormula.fltPrecoCompraLiquidoEmbalagem;

      dicRetorno['obscolorista']   := frmDig.edtDescricaoColorista.Text;
      dicRetorno['tipoformulacao'] := frmDig.rdgTipoFormula.ItemIndex;


      fltVolPro := frmDig.objFormula.fltVolumePro;

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['precu2'] := fltPreCu2;
      dicRetorno['tippre'] := strTipPre;
      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
      objFormula.pCalculaImpostosSaida(dicRetorno);

      dicRetorno['saldocols'] := frmDig.blnSaldoSuficiente;
      dicRetorno.AdicionarObjeto('formul', frmDig.matrizSaldosColorantes);

      If fModoFormulacaoIndireto Then
      Begin
        If (frmDigTintaAutomotivaSalcomix.chkResina325.Checked) Then
          dicRetorno['coddil'] := 'R'
        Else If frmDigTintaAutomotivaSalcomix.objFormula.mveModoVenda = mvDiluido Then
          dicRetorno['coddil'] := 'D'
        Else
          dicRetorno['coddil'] := 'C';
      End;
    End;
  end;
Begin
  Result := False;
  objFormula := nil;
  frmDigTintaAutomotivaSalcomix := nil;
  frmDigTintaAutomotiva := nil;
  conf := fGetConfTinta('GLA');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaGlasurit.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 1000;
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.EmpPrd       := IfNull(dicRetorno['empprd'], '');
      objFormula.OprFlj       := IfNull(dicRetorno['oprflj'], '');
      objFormula.EmpFat       := IfNull(dicRetorno['empfat'], '');
      objFormula.EmpCd_       := IfNull(dicRetorno['emp_cd'], '');
      objFormula.FatS_N       := IfNull(dicRetorno['FatS_N'], '');
      objFormula.CD_S_N       := IfNull(dicRetorno['CD_S_N'], '');
      objFormula.strDescri    := qryCadGla.FieldByName('GLA_DESCRI').AsString + ' - ' +
                                   qryCadGla.FieldByName('GLA_CODPRO').AsString;

      objFormula.fltAcrMob := qryCadGla.FieldByName('GLA_ACRMOB').AsFloat;

      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      If (fModoFormulacaoIndireto)                                       And
         (Pos('ESP', qryCadGla.FieldByName('GLA_CODPRO').AsString) <= 0) Then
      Begin
        objFormula.pConectarSQLServer(qryCadGla.FieldByName('GLA_CODSEQ').AsString, qryCadGla.FieldByName('GLA_LINHA_').AsString);
      End;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      For intContador := 1 To 18 Do
      Begin

        If (fEmptyStr(qryCadGla.FieldByName('GLA_FORM' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadGla.FieldByName('GLA_FORM' + fStrZero(intContador, 2)).AsString;
        objBase.strLinBas := qryCadGla.FieldByName('GLA_LINHA_').AsString;

        if Pos('ESP', qryCadGla.FieldByName('GLA_CODPRO').AsString) > 0 then //somente novas formulas contem diluido e concentrado
        begin
          objBase.fltQtdDil := qryCadGla.FieldByName('GLA_QTDD' + fStrZero(intContador, 2)).AsFloat;
          objBase.fltQtdCon := qryCadGla.FieldByName('GLA_QTDB' + fStrZero(intContador, 2)).AsFloat;
        end
        else
        begin
           If RightStr(qryCadGla.FieldByName('GLA_LINHA_').AsString, 1) = 'D' Then
             objBase.fltQtdDil := qryCadGla.FieldByName('GLA_QTDB' + fStrZero(intContador, 2)).AsFloat
           Else
             objBase.fltQtdCon := qryCadGla.FieldByName('GLA_QTDB' + fStrZero(intContador, 2)).AsFloat;
        end;

        objBase.strTipBas := 'B';

      End;

      objFormula.pCarregarColorantes;
      objFormula.pCarregaPrecosBases;

      If fModoFormulacaoIndireto Then
      Begin
        pCriarFormularios(TfrmDigTintaAutomotivaSalcomix, frmDigTintaAutomotivaSalcomix);
        pInicializaFormDig(frmDigTintaAutomotivaSalcomix);
        frmDigTintaAutomotivaSalcomix.chkResina325.Visible := False;
        frmDigTintaAutomotivaSalcomix.chkResina325.Checked := False;
        frmDigTintaAutomotivaSalcomix.strLinha := qryCadGla.FieldByName('GLA_LINHA_').AsString;
        frmDigTintaAutomotivaSalcomix.strLinhasDiluido := '55_90_35_30_';

        frmDigTintaAutomotivaSalcomix.strIdePro   := 'GLA';

        If (Pos('ESP', qryCadGla.FieldByName('GLA_CODPRO').AsString) > 0) Then
        Begin
          frmDigTintaAutomotivaSalcomix.chkResina325.Visible := False;
        End;
      End
      Else
      Begin
        pCriarFormularios(TfrmDigTintaAutomotiva, frmDigTintaAutomotiva);
        pInicializaFormDig(frmDigTintaAutomotiva);
      End;

      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);

      If fModoFormulacaoIndireto Then
      Begin
        Result := (frmDigTintaAutomotivaSalcomix.ShowModal = mrOk);
      End
      Else
      Begin
        Result := (frmDigTintaAutomotiva.ShowModal = mrOk);
      End;

      If fModoFormulacaoIndireto Then
      Begin
        pPegaRetornosFormDig(frmDigTintaAutomotivaSalcomix);
      End
      Else
      Begin
        pPegaRetornosFormDig(frmDigTintaAutomotiva);
      End;

      dicRetorno['promoc'] := objFormula.StrPromoc;

      If (Result) And (Assigned(dicRetorno)) Then
      Begin
        objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTintaAutomotivaSalcomix) then FreeAndNil(frmDigTintaAutomotivaSalcomix);
    if Assigned(frmDigTintaAutomotiva) then FreeAndNil(frmDigTintaAutomotiva);
  End;

end;
{$ENDIF}

function fModoFormulacaoIndireto: Boolean;
Var
  conf: IConfTinta;
begin
  conf   := fGetConfTinta('GLA');
  Result := conf.fGet('CALFOR') = '1';
end;

{ TFormulaGlasurit }

constructor TFormulaGlasurit.Create(strTabPre: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('GLA');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  fltAcrMob := 0 ;
end;

function TFormulaGlasurit.fCalculaQuantidadeParaBaixaEstoque(
  objBase: TBaseAutomotiva): Double;
begin
  If (fModoFormulacaoIndireto) And
     (Pos('ESP ', strDescri) <= 0) Then
  Begin
    Result := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) * (Self.fltVolumePro  / Self.fltVolumeOri);
  End
  Else
  Begin
    Result := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) * ((Self.fltVolumePro * 1000) / Self.fltVolumeOri);
  End;
end;

procedure TFormulaGlasurit.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCu2: Double;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltPreCusDil: Double;
  fltPreCu2Dil: Double;
  fltPreVenDil: Double;
  fltPreCusPro,
  fltPreVenPro: Double;
  cdsGen: TUniClientDataSet;
  strCodEmpresa: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    FPrecoCusCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoVenDil := 0.0;

    FOutValCon := 0;
    FIcmsaiCon := 0;
    FImpFedCon := 0;
    FDesOpeCon := 0;
    FPreMedCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;

    FPreUltCon := 0;
    FPreUltDil := 0;
    FImpUltCon := 0;
    FImpUltDil := 0;

    FComLiqCon := 0;
    FComLiqDil := 0;
  End;
begin
  inherited;
  pCarregarBasesSQLServerCasoNecessario;
  pZerarPrecos;
  cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  strCodEmpresa := fVerificaEmpresaSetada();

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Not cdsGen.Locate('BAS_CODBAS;BAS_LINHA_', varArrayOf([objBase.strCodBas,objBase.strLinBas]), [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Base/Linha ' + objBase.strCodBas +'/'+ objBase.strLinBas + ' não cadastrada. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(cdsGen.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base/linha ' + objBase.strCodBas +'/'+ objBase.strLinBas +  ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (cdsGen.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + cdsGen.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
    End;

    If objBase.fltPesEsp <= 0 Then
    Begin
      pZerarPrecos;
      Raise Exception.Create(Format('A base %s não está com o peso específico preenchido corretamente. Favor verificar', [objBase.strCodBas]));
    End;

    if not IsItemAtivo(cdsGen.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsGen.FieldByName('BAS_CODITE').AsString]);
    end;

    componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvConcentrado]) then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvDiluido]) then
    begin
      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    If fCarregaPromocao(cdsGen.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
    Begin
      objBase.fltPreCus := fltPreCusPro;
      objBase.fltPreVen := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusPro = 0 Then
        objBase.fltPreCus := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objBase.fltPreCus := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
      objBase.fltPreVen := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltPreCu2 := fCalculaPrecoCusto2(objBase.fltPreVen,
                                     objBase.fltPreCus,
                                     objBase.fltOutVal,
                                     objBase.fltIcmSai,
                                     objBase.fltImpFed,
                                     objBase.fltDesOpe);

    fltPreCusBas := objBase.fltPreCus/
                    (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) *
                    objBase.fltQtdCon;

    fltPreCu2Bas := fltPreCu2 /
                    (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) *
                    objBase.fltQtdCon;

    fltPreVenBas := objBase.fltPreVen/
                    (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) *
                    objBase.fltQtdCon;

    fltPreCusDil := objBase.fltPreCus/
                    (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) *
                    objBase.fltQtdDil;

    fltPreCu2Dil := fltPreCu2 /
                  (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil;

    fltPreVenDil := objBase.fltPreVen/
                    (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) *
                    objBase.fltQtdDil;

    componente[mvConcentrado].Quantidade                := objBase.fltQtdCon;
    componente[mvDiluido].Quantidade                    := objBase.fltQtdDil;

    fltPreVenBas := fltPreVenBas * (1 + fltPerAcr);
    fltPreVenDil := fltPreVenDil * (1 + fltPerAcr);

    If AcertoValor Then
    Begin
      componente[mvConcentrado].OutrosValores             := (objBase.fltOutVal / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon);
      componente[mvConcentrado].PrecoMedio                := (objBase.fltPreMed / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon);
      componente[mvConcentrado].UltimoPrecoCompra         := (objBase.fltPreUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon);
      componente[mvConcentrado].UltimoPrecoCompraImpostos := (objBase.fltImpUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon);
      componente[mvConcentrado].PrecoCompraLiquido        := (objBase.fltComLiq / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon);
      componente[mvConcentrado].IcmsSaida                 := (fltPreVenBas * objBase.fltIcmSai / 100);
      componente[mvConcentrado].ImpostosFederais          := (fltPreVenBas * objBase.fltImpFed / 100);
      componente[mvConcentrado].DespesasOperacionais      := (fltPreVenBas * objBase.fltDesOpe / 100);
      componente[mvConcentrado].PrecoCusto                := fltPreCusBas;
      componente[mvConcentrado].PrecoCustoReal            := fltPreCu2Bas;
      componente[mvConcentrado].PrecoVenda                := fltPreVenBas;

      componente[mvDiluido].OutrosValores                 := (objBase.fltOutVal / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil);
      componente[mvDiluido].PrecoMedio                    := (objBase.fltPreMed / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil);
      componente[mvDiluido].UltimoPrecoCompra             := (objBase.fltPreUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil);
      componente[mvDiluido].UltimoPrecoCompraImpostos     := (objBase.fltImpUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil);
      componente[mvDiluido].PrecoCompraLiquido            := (objBase.fltComLiq / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil);
      componente[mvDiluido].IcmsSaida                     := (fltPreVenDil * objBase.fltIcmSai / 100);
      componente[mvDiluido].ImpostosFederais              := (fltPreVenDil * objBase.fltImpFed / 100);
      componente[mvDiluido].DespesasOperacionais          := (fltPreVenDil * objBase.fltDesOpe / 100);
      componente[mvDiluido].PrecoCusto                    := fltPreCusDil;
      componente[mvDiluido].PrecoCustoReal                := fltPreCu2Dil;
      componente[mvDiluido].PrecoVenda                    := fltPreVenDil;
    End
    Else
    Begin
      componente[mvConcentrado].OutrosValores             := (objBase.fltOutVal / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon) * FFatorAcerto;
      componente[mvConcentrado].PrecoMedio                := (objBase.fltPreMed / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon) * FFatorAcerto;
      componente[mvConcentrado].UltimoPrecoCompra         := (objBase.fltPreUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon) * FFatorAcerto;
      componente[mvConcentrado].UltimoPrecoCompraImpostos := (objBase.fltImpUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon) * FFatorAcerto;
      componente[mvConcentrado].PrecoCompraLiquido        := (objBase.fltComLiq / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdCon) * FFatorAcerto;
      componente[mvConcentrado].IcmsSaida                 := (fltPreVenBas * objBase.fltIcmSai / 100) * FFatorAcerto;
      componente[mvConcentrado].ImpostosFederais          := (fltPreVenBas * objBase.fltImpFed / 100) * FFatorAcerto;
      componente[mvConcentrado].DespesasOperacionais      := (fltPreVenBas * objBase.fltDesOpe / 100) * FFatorAcerto;
      componente[mvConcentrado].PrecoCusto                := fltPreCusBas * FFatorAcerto;
      componente[mvConcentrado].PrecoCustoReal            := fltPreCu2Bas * FFatorAcerto;
      componente[mvConcentrado].PrecoVenda                := fltPreVenBas * FFatorAcerto;

      componente[mvDiluido].OutrosValores                 := (objBase.fltOutVal / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil) * FFatorAcerto;
      componente[mvDiluido].PrecoMedio                    := (objBase.fltPreMed / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil) * FFatorAcerto;
      componente[mvDiluido].UltimoPrecoCompra             := (objBase.fltPreUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil) * FFatorAcerto;
      componente[mvDiluido].UltimoPrecoCompraImpostos     := (objBase.fltImpUlt / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil) * FFatorAcerto;
      componente[mvDiluido].PrecoCompraLiquido            := (objBase.fltComLiq / (cdsGen.FieldByName('BAS_EMBALA').AsFloat * cdsGen.FieldByName('BAS_PESBAS').AsFloat) * objBase.fltQtdDil) * FFatorAcerto;
      componente[mvDiluido].IcmsSaida                     := (fltPreVenDil * objBase.fltIcmSai / 100) * FFatorAcerto;
      componente[mvDiluido].ImpostosFederais              := (fltPreVenDil * objBase.fltImpFed / 100) * FFatorAcerto;
      componente[mvDiluido].DespesasOperacionais          := (fltPreVenDil * objBase.fltDesOpe / 100) * FFatorAcerto;
      componente[mvDiluido].PrecoCusto                    := fltPreCusDil * FFatorAcerto;
      componente[mvDiluido].PrecoCustoReal                := fltPreCu2Dil * FFatorAcerto;
      componente[mvDiluido].PrecoVenda                    := fltPreVenDil * FFatorAcerto;
    End;

  End;

  If AcertoValor Then
  Begin
    FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes + FFatorAcerto;
    FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes + FFatorAcerto;

    FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes + FFatorAcerto;
    FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes + FFatorAcerto;

    FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes + FFatorAcerto;
    FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes + FFatorAcerto;

    FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes + FFatorAcerto;
    FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes + FFatorAcerto;

    FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes + FFatorAcerto;
    FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes + FFatorAcerto;

    FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes + FFatorAcerto;
    FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes + FFatorAcerto;

    FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes + FFatorAcerto;
    FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes + FFatorAcerto;

    FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes + FFatorAcerto;
    FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes + FFatorAcerto;

    FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes + FFatorAcerto;
    FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes + FFatorAcerto;

    FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes + FFatorAcerto;
    FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes + FFatorAcerto;

    FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes + FFatorAcerto;
    FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes + FFatorAcerto;
  End
  Else
  Begin
    FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
    FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

    FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
    FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

    FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
    FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;

    FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
    FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;

    FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
    FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;

    FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
    FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

    FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
    FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

    FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
    FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

    FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
    FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

    FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
    FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

    FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
    FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;
  End;

  If (fModoFormulacaoIndireto) And
     (Pos('ESP ', strDescri) <= 0) Then
  Begin
    FPrecoCusCon := fFormataFloat(FPrecoCusCon, 2);
    FPrecoCu2Con := fFormataFloat(FPrecoCu2Con, 2);
    FPrecoCusDil := fFormataFloat(FPrecoCusDil, 2);
    FPrecoCu2Dil := fFormataFloat(FPrecoCu2Dil, 2);
  End
  Else
  Begin
    FPrecoCusCon := fFormataFloat(FPrecoCusCon * FVolumePro * 1000 / FVolumeOri, 2);
    FPrecoCu2Con := fFormataFloat(FPrecoCu2Con * FVolumePro * 1000 / FVolumeOri, 2);
    FPrecoVenCon := fFormataFloat(FPrecoVenCon * FVolumePro * 1000 / FVolumeOri, 2);
    FPrecoCusDil := fFormataFloat(FPrecoCusDil * FVolumePro * 1000 / FVolumeOri, 2);
    FPrecoCu2Dil := fFormataFloat(FPrecoCu2Dil * FVolumePro * 1000 / FVolumeOri, 2);
    FPrecoVenDil := fFormataFloat(FPrecoVenDil * FVolumePro * 1000 / FVolumeOri, 2);

    FIcmsaiCon := fFormataFloat(FIcmsaiCon * FVolumePro * 1000 / FVolumeOri, 2);
    FIcmsaiDil := fFormataFloat(FIcmsaiDil * FVolumePro * 1000 / FVolumeOri, 2);

    FImpFedCon := fFormataFloat(FImpFedCon * FVolumePro * 1000 / FVolumeOri, 2);
    FImpFedDil := fFormataFloat(FImpFedDil * FVolumePro * 1000 / FVolumeOri, 2);

    FDesOpeCon := fFormataFloat(FDesOpeCon * FVolumePro * 1000 / FVolumeOri, 2);
    FDesOpeDil := fFormataFloat(FDesOpeDil * FVolumePro * 1000 / FVolumeOri, 2);
  End;

  FPrecoVenCon := fFormataFloat(FPrecoVenCon, 2);
  FPrecoVenDil := fFormataFloat(FPrecoVenDil, 2);

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMob;

  If FPrecoVenDil > 0 Then
    FPrecoVenDil := FPrecoVenDil + fltAcrMob;
end;

procedure TFormulaGlasurit.pCarregarBasesSQLServerCasoNecessario;
begin
  If (blnRecarregarBases) Then
  Begin
  {$IFDEF LINUX}
    raise Exception.Create('pCarregarBasesSQLServer nao implementado no linux');
  {$ELSE}
    pCarregarBasesSQLServer;
  {$ENDIF}
    blnRecarregarBases := False;
  End;
end;

{$IFNDEF LINUX}
procedure TFormulaGlasurit.pCarregarBasesSQLServer;
var
  tpsPreparo: TTipoPreparoGlasurit;
  formula: TFormulaGlasuritSQLServer;
  formulaPadrao: TFormulaGlasuritSQLServer;
  intContador: Integer;
  base: TBaseAutomotiva;
  cdsGen: TUniClientDataSet;
  fltPreCusPro,
  fltPreVenPro: Double;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  strCodEmpresa: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  If Assigned(glasuritSQLServer) THen
  Begin
    conf := fGetConfTinta('GLA');
    fltDesOpeTinta := conf.fGetDouble('DESOPE');

//    fltVolumeOri := 1;
    FVolumeOri := 1;

    If (mveModoVenda = mvDiluido) Then
      tpsPreparo := tpsDiluido
    Else
      tpsPreparo := tpsConcentrado;

    if not (FErroIntegracao) then
      formula := glasuritSQLServer.fCalculaFormulacao(IfThen(FVolumePro = 0, 0.9, FVolumePro), tpsPreparo);

    if Not Assigned(formula) then
    begin
      FErroIntegracao := true;
      Exit;
    end;

    formulaPadrao := glasuritSQLServer.fCalculaFormulacao(FVolumeOri, tpsPreparo);

    cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadBas);

    strCodEmpresa := fVerificaEmpresaSetada();

    Clear;
    For intContador := 0 To formula.Count -1 Do
    Begin
      If (Not cdsGen.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([formula.Base[intContador].strCodBas, formula.Base[intContador].strLinBas]), [])) Then
      Begin
        Raise ExceptionAutCom.Create('Base/Linha ' + formula.Base[intContador].strCodBas +'/' + formula.Base[intContador].strLinBas + ' não cadastrada!');
      End;

      base := TBaseAutomotiva(Self.Add);
      base.strCodBas := formula.Base[intContador].strCodBas;
      base.strLinBas := formula.Base[intContador].strLinBas;
      base.fltQtdDil := formula.Base[intContador].fltQtdDil;
      base.fltQtdCon := formula.Base[intContador].fltQtdCon;

      //Formulacao padrao
      base.fltQtdPCo := formulaPadrao.Base[intContador].fltQtdCon;
      base.fltQtdPDi := formulaPadrao.Base[intContador].fltQtdDil;

      base.fltEmbala := cdsGen.FieldByName('BAS_EMBALA').AsFloat;
      base.fltPesEsp := cdsGen.FieldByName('BAS_PESBAS').AsFloat;

      If fCarregaPromocao(cdsGen.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
        fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
      Begin
        base.fltPreVen := fltPreVenPro;
        FPromoc := 'S';
      End
      Else
      Begin
        base.fltPreVen := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
      End;

      base.fltPreMed := cdsGen.FieldByName('ITE_PREMED').AsFloat;
      base.strImpDir := cdsGen.FieldByName('ITE_IMPDIR').AsString;
      base.strCodIte := cdsGen.FieldByName('BAS_CODITE').AsString;
      base.strTipBas := 'B';

      base.fltOutVal := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;

      if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        base.fltIcmSai := calculadorFatVendas.fCalculaAliquota(base.strCodIte, base.strImpDir)
      else
        base.fltIcmSai := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;

      base.fltImpFed := cdsGen.FieldByName('ITE_IMPFED').AsFloat;
      base.fltDesOpe := cdsGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
      base.fltPreUlt := cdsGen.FieldByName('ITE_PREULT').AsFloat;
      base.fltImpUlt := cdsGen.FieldByName('ITE_IMPULT').AsFloat;

      base.fltComLiq := fCalculaPrecoCompraLiquido(cdsGen.Fieldbyname('ITE_PRECOM').AsFloat, cdsGen.Fieldbyname('ITE_DESF01').AsFloat,
                                                   cdsGen.Fieldbyname('ITE_DESF02').AsFloat, cdsGen.Fieldbyname('ITE_DESF03').AsFloat,
                                                   cdsGen.Fieldbyname('ITE_DESF04').AsFloat, cdsGen.Fieldbyname('ITE_DESF05').AsFloat,
                                                   cdsGen.Fieldbyname('ITE_DESF06').AsFloat);
    End;

    FreeAndNil(formula);
    FreeAndNil(formulaPadrao);
  End;
end;
{$ENDIF}

procedure TFormulaGlasurit.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  cdsGen: TUniClientDataSet;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodEmpresa: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  conf := fGetConfTinta('GLA');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  strCodEmpresa := fVerificaEmpresaSetada();

  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    cdsGen.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([objBase.strCodBas,objBase.strLinBas]), []);

    objBase.fltEmbala := cdsGen.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsGen.FieldByName('BAS_PESBAS').AsFloat;


    If fCarregaPromocao(cdsGen.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
    Begin
      objBase.fltPreVen := fltPreVenPro;
      FPromoc := 'S';
    End
    Else
    Begin
      objBase.fltPreVen := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.strImpDir := cdsGen.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsGen.FieldByName('BAS_CODITE').AsString;

    objBase.fltOutVal := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;

    objBase.fltImpFed := cdsGen.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := cdsGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := cdsGen.FieldByName('ITE_PREMED').AsFloat;
    objBase.fltPreUlt := cdsGen.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltImpUlt := cdsGen.FieldByName('ITE_IMPULT').AsFloat;

    objBase.fltComLiq := fCalculaPrecoCompraLiquido(cdsGen.Fieldbyname('ITE_PRECOM').AsFloat, cdsGen.Fieldbyname('ITE_DESF01').AsFloat,
                                                    cdsGen.Fieldbyname('ITE_DESF02').AsFloat, cdsGen.Fieldbyname('ITE_DESF03').AsFloat,
                                                    cdsGen.Fieldbyname('ITE_DESF04').AsFloat, cdsGen.Fieldbyname('ITE_DESF05').AsFloat,
                                                    cdsGen.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Add('VolumeFormula = ' + FloatToStrF(FVolumeOri, ffFixed, 12, 4));
  FCalculo.Add('Valor da Base = Preço / (Embalagem * Peso Específico) * Qtde. Concentrado');
  FCalculo.Add('Preço da Tinta = Soma(Valores de Base) * Volume Produzido * 1000 / VolumeFormula');

  blnRecarregarBases := True;

end;

procedure TFormulaGlasurit.pCarregarColorantes;
var
  strFveGla: String;
  conf: IConfTinta;
begin
  inherited;
  conf      := fGetConfTinta('GLA');
  strFveGla := AnsiReplaceStr(conf.fGet('FVEGLA'), ',', '.');

  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_LINHA_                       ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_PESBAS                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');
  qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');

  If (fCfgSis('PREGER') <> '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
  end;

  If (fCfgSis('PREGER') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_VALBAS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_VALBAS * ' + strFveGla + ' AS ITE_PREVEN         ');
  end
  else if (fCfgSis('PREGER') = '1') and FBlnCalculaUnitario then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fCfgSis('TABPRE') + ' AS ITE_PREVEN       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                 ');
  qryCadBas.SQL.Add('   GLA_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');


  If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    qryCadBas.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    qryCadBas.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    qryCadBas.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;

  TClientDataSetFactory.GetClientDataSet(qryCadBas);
end;

{$IFNDEF LINUX}
procedure TFormulaGlasurit.pConectarSQLServer(strIdCor: String; strLinha: String);
begin
  glasuritSQLServer := TGlasuritSQLServer.Create(strIdCor, strLinha);
end;
{$ENDIF}

procedure pRetornaTabelaPrecoGlasurit(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TFormulaGlasurit;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
  strTabelaUnica: String;

  function GetDescri(const strDescri: string): string;
  begin
    Result := strDescri;
    if Length(strDescri) > 20 then
      Result := LeftStr(strDescri, 20) + '...';
  end;
begin
  conf := fGetConfTinta('GLA');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaGlasurit.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 1000;
      objFormula.fltVolumePro := 1; // dicRetorno['volpro'];
      objFormula.strDescri := dicRetorno['itetin'];
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.EmpPrd := IfNull(dicRetorno['empprd'], '');
      objFormula.OprFlj := IfNull(dicRetorno['oprflj'], '');
      objFormula.EmpFat := IfNull(dicRetorno['empfat'], '');
      objFormula.EmpCd_ := IfNull(dicRetorno['emp_cd'], '');
      objFormula.FatS_N := IfNull(dicRetorno['FatS_N'], '');
      objFormula.CD_S_N := IfNull(dicRetorno['CD_S_N'], '');

      objFormula.fltAcrMob := fRetornaAcrescimoMaoObra(dicRetorno['itetin']);

      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;
      objFormula.strCodEmb := dicRetorno['iteemb'];
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        objBase.strLinBas := dicRetorno['linha_'];
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * (objFormula.fltVolumeOri / 1000) / objFormula.fltVolumePro
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * (objFormula.fltVolumeOri / 1000) / objFormula.fltVolumePro;
        objBase.strTipBas := 'B';
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');

      If Not fEmptyStr(strTabelaUnica) Then
      Begin
        objFormula.strTabPre := strTabelaUnica;
        objFormula.pCarregarColorantes;
        objFormula.pCarregaPrecosBases;
        objFormula.pCalcularPrecos;

        If IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
          Else
            dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
        End;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
        End;

        objFormula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
        dicRetorno['promoc'] := objFormula.StrPromoc;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End
        Else
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End;
      End
      Else
      Begin
        strTabelas := fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N', 7 - Length(strTabelas));

        For intContador := 1 To Length(strTabelas) Do
        Begin
          if strTabelas[intContador] = 'S' then
          begin
            objFormula.strTabPre := IntToStr(intContador);

            fExecutarModal(objFormula.pCarregarColorantes, Format('Carregando Bases... [%s] - Tabela %d',
              [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCarregarColorantes');

            fExecutarModal(objFormula.pCarregaPrecosBases, Format('Carregando Preços... [%s] - Tabela %d',
              [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCarregaPrecosBases');

            fExecutarModal(objFormula.pCalcularPrecos, Format('Calculando Preços... [%s] - Tabela %d',
                [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCalcularPrecos');

            If IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If dicRetorno['tippre'] = 'C' Then
                dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
              Else
                dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
            End
            Else
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
            End;

            if intContador = IfNull(dicRetorno['tabpre'], 0) then
            Begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
              dicRetorno['promoc'] := objFormula.StrPromoc;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End
            Else
            Begin
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End;
          end;
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
end;

function fRetornaAcrescimoMaoObra(strIteTin: String): Double;
var
  strSQL: String;
  qryGen: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GLA_CADGLA ';
  strSQL := strSQL + 'WHERE ';

  If (fModoFormulacaoIndireto)     And
     (Pos('ESP ', strIteTin) <= 0) Then
  Begin
    strSQL := strSQL + ' 	GLA_CODSEQ = :ITETIN ';
  End
  Else
  Begin
    strSQL := strSQL + ' 	CONCAT(IFNULL(GLA_LINHA_, ''''), IFNULL(GLA_MONTAD, ''''), IFNULL(GLA_DESCRI, ''''), ';
    strSQL := strSQL + ' 			IFNULL(GLA_CODPRO, ''''), IFNULL(GLA_ANOCOR, ''''), IFNULL(GLA_VARIAC, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_FORM01, ''''), IFNULL(GLA_QTDB01, ''0.0''), IFNULL(GLA_FORM02, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_QTDB02, ''0.0''), IFNULL(GLA_FORM03, ''''), IFNULL(GLA_QTDB03, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_FORM04, ''''), IFNULL(GLA_QTDB04, ''0.0''), IFNULL(GLA_FORM05, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_QTDB05, ''0.0''), IFNULL(GLA_FORM06, ''''), IFNULL(GLA_QTDB06, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_FORM07, ''''), IFNULL(GLA_QTDB07, ''0.0''), IFNULL(GLA_FORM08, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_QTDB08, ''0.0''), IFNULL(GLA_FORM09, ''''), IFNULL(GLA_QTDB09, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_FORM10, ''''), IFNULL(GLA_QTDB10, ''0.0''), IFNULL(GLA_FORM11, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_QTDB11, ''0.0''), IFNULL(GLA_FORM12, ''''), IFNULL(GLA_QTDB12, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_FORM13, ''''), IFNULL(GLA_QTDB13, ''0.0''), IFNULL(GLA_FORM14, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_QTDB14, ''0.0''), IFNULL(GLA_FORM15, ''''), IFNULL(GLA_QTDB15, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_FORM16, ''''), IFNULL(GLA_QTDB16, ''0.0''), IFNULL(GLA_FORM17, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_QTDB17, ''0.0''), IFNULL(GLA_FORM18, ''''), IFNULL(GLA_QTDB18, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_FORM19, ''''), IFNULL(GLA_QTDB19, ''0.0''), IFNULL(GLA_FORM20, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(GLA_QTDB20, ''0.0'')) = :ITETIN ';
  End;

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    Result := FieldByName('GLA_ACRMOB').AsFloat;
  End;
end;

{ TConsultaGlasurit }

{$IFNDEF LINUX}
procedure TConsultaGlasurit.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;

  strTipEmb: String;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  strIteEmb: String;
  strMontad: String;
  strA_n_o_: String;
  strChaFor: String;
  fltVolPro: Double;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;

  strProEmbCo: String;
  strProEmbSp: String;
  strProEmbBa: String;

  strTipPre: String;
  conf: IConfTinta;
  dicParams: TDicionario;
  strDesCor: String;
begin
  qryGen := nil;
  dicParams := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf      := fGetConfTinta('GLA');
      strTipEmb := '';
      intQtdEmb := 0;
      fltPreEmb := 0.0;
      fltEmbala := 0.0;
      strDesCor := '';

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM GLA_CADGLA WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;

      stlDesEmb.Add('NORMAL');
      stlProEmbLt.Add(conf.fGet('GLAIEM'));
      stlProEmbGl.Add(conf.fGet('GLAIGL'));

      strProEmbCo := conf.fGet('GLAICO');
      strProEmbSp := conf.fGet('GLAISP');
      strProEmbBa := conf.fGet('GLABAL');

      strMontad := qryGen.FieldByName('GLA_MONTAD').AsString;
      strA_n_o_ := qryGen.FieldByName('GLA_ANOCOR').AsString;

      strChaFor := qryGen.FieldByName('GLA_LINHA_').AsString + ' ' +
                   qryGen.FieldByName('GLA_DESCRI').AsString + ' ' +
                   qryGen.FieldByName('GLA_MONTAD').AsString + ' ' +
                   qryGen.FieldByName('GLA_CODPRO').AsString;

      fltPreCus := 0.0;
      fltUnitar := 0.0;

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'GLA';

      fDigDadosTintometricos(qryGen, stlDesEmb, stlProEmbLt,
            stlProEmbGl, strProEmbCo, strProEmbSp, strProEmbBa,
            strTipPre, strIteEmb, strTipEmb, intQtdEmb, fltPreEmb, fltEmbala,
            fltPreCus, fltUnitar, fltVolPro, strTabPre, dicParams, strDesCor);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(dicParams) then FreeAndNil(dicParams);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TConsultaGlasurit.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TConsultaGlasurit.pTarefaVenda(Sender: TObject);
begin
  inherited;
  Try
    pCarregaFuncoesDllAuttin;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioNovasFormulasGlasurit;
  Finally
    If HandleDllAuttin <> 0 Then
    Begin
      FreeLibrary(HandleDllAuttin);
      HandleDllAuttin := 0;
    End;
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function fConsultaGlasuritInterna(Sender: TForm; qryCadGla: TUniQuery;
    tipoConsulta: TTipoConsultaTinta; strTabPre: String; blnFaturamento, blnPermiteTab: Boolean;
    dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := (TGlasuritConsulta.Create).fExecutarConsulta(Sender,
    qryCadGla, tipoConsulta, strTabPre, TConsultaGlasurit, '', blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
end;
{$ENDIF}

end.



