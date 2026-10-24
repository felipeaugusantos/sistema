unit untStandoxDinamica;

interface

uses SysUtils, Uni, Forms, Classes,  StrUtils, Controls,
  untFuncEspecificas, untFuncoesSimples, Variants,
  untPnlBotoesAcoesNovaConsulta,
  Math,
  DBClient,
  UniClientDataSet;

{***************************************************}
{* CRIA A CLASSE QUE REPRESENTA UMA FORMULA DA     *}
{* Standox                                          *}
{** 04/06/2008 - 17:09 **************************MV*}
Type

  TFormulaStandox = class(TFormulaAutomotiva)
  private
    fltPerAcr: Double;
    fltAcrMob: Double;
  public
    strCatali: String;
    procedure pCarregarColorantes; override;
    procedure pCalcularPrecos; override;
    procedure pCarregaPrecosBases; override;
    constructor Create(strTabPrePar: String); override;
    procedure pReformulaNovo(strCodDil: String; intIdxPercentual : Integer = 0);
    procedure pReformula(strDiluente: String);
  End;

Type
  TfrmConsultaCompTintaStandox = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;


  function fConsultaStandoxInterna(Sender: TForm; Var qryCadDox: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  function fConsultaStandoxDinamica(Sender: TForm): String; stdcall;
  function fConsultaStandoxGeralDinamica(Sender: TForm): String; stdcall;
  function fConsultaStandoxVendaDinamica(Sender: TForm; Var qryCadDox: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fRetornaDescricaoStandoxDinamica(qryTinta: TUniQuery; strDesCor: String): String;
  function fRetornaUniTraProStandoxDinamica(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaUniTraEmbStandoxDinamica(strTipEmb: String): Double;

  function fRetornaPrecoStandoxDinamica(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fGetProdutoVenda: string;

  function fDigDadosTintometricos(qryCadDox: TUniClientDataSet; stlDesEmb, stlProEmbLt,
    stlProEmbGl: TStringList;
    Var strIteEmb, strTipEmb, strTipPre: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro: Double; strTabPre: String; Var strCatali: String; dicRetorno: TDicionario;
    Var strCodDil: String): Boolean;

  function fGTinForStandoxDinamica(strIteTin: String; fltQtdIte, fltVolPro: Double;
    strTipPre, strCatali: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodEmpPrd: string; strCodDil: String;const strTipCor: string): Boolean; stdcall;

  procedure pRetornaDadosStandoxDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoStandoxDinamica(dicRetorno: TDicionario; fltFatorAcerto: Double);

  function fGetDiluentes: TStringList;
  function fRetQtdDiluente(strCodDil: String; intIdxPercentual : Integer = 0 ): Double;

  function fRetPesoEspecificoBase(strCodBas: String): Double;

implementation

uses
  DB,
  untTintaMaquina,
  untGenericTintaDeMaquinaComponente,
  untTintaDeMaquinaComponenteTipo,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva,
  untClientDataSetFactory, untMultiSelectLocalizadorFactory,
  untFuncoes,
  untIConfTinta,
  untICalculadorFatVendas,
  untITintaDeMaquinaComponente,
  untIConsultaTinta,
  unTStandoxConsulta,
  untDigTintaAutomotivaStandox;

function fConsultaStandoxDinamica(Sender: TForm): String;
var
  qryCadDox: TUniQuery;
begin
  qryCadDox := nil;
  Try
    Try
      qryCadDox := fCriaQuery(Sender);
      Result := fConsultaStandoxInterna(Sender, qryCadDox, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadDox) then FreeAndNil(qryCadDox);
  End;
end;

function fConsultaStandoxGeralDinamica(Sender: TForm): String;
Var
  qryCadDox: TUniQuery;
begin
  qryCadDox := nil;
  Try
    Try
      qryCadDox := fCriaQuery(Sender);
      Result := fConsultaStandoxInterna(Sender, qryCadDox, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadDox) then FreeAndNil(qryCadDox);
  End;
end;

function fConsultaStandoxVendaDinamica(Sender: TForm;
  Var qryCadDox: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := fConsultaStandoxInterna(Sender, qryCadDox, tpcVenda, strTabPre, blnFaturamento, dicRetorno, sltItems);
end;

function fRetornaDescricaoStandoxDinamica(qryTinta: TUniQuery; strDesCor: String): String;
begin
  Result := strDesCor;
end;

function fRetornaUniTraProStandoxDinamica(fltPrcTin, fltPrvTin: Double): Double;
var
  strTraStandox: String;
  fltTraStandox: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('DOX');
  strTraStandox := conf.fGet('TRADOX');
  fltTraStandox := conf.fGetDouble('FATDOX');

  If (strTraStandox = 'VEN') Then
    Result := fltPrvTin
  Else
    Result := fltPrcTin;

  Result := fFormataFloat(Result * fltTraStandox, 2);
end;

function fRetornaUniTraEmbStandoxDinamica(strTipEmb: String): Double;
var
  fltPreEmb: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('DOX');
  
  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('DOXPLT')
  Else
    fltPreEmb := conf.fGetDouble('DOXPGL');

  Result := fltPreEmb * conf.fGetDouble('FATDOX')
end;

function fRetornaPrecoStandoxDinamica(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
  strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
  strCodEmp: String;
  strOpcDoc: String;
  strTipPre: String;
  strTipEmb: String;
  intQtdEmb: Integer;

  strIteTin: String;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  //fltPrcTin: Double;
  fltPrvTin: Double;

  strIteEmb: String;

  fltVolPro: Double;

  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;

  strChaFor: String;
  strTabPre: String;
  strCatali: String;
  strCodDil: String;

  strAuto: String;
  tinta : IConsultaTinta;
  strDesCor: String;
  conf: IConfTinta;
  cdsTinta: TUniClientDataSet;
  blnUsaPreCus: Boolean;

  function fConfOuDefault(strConf, strDefault: String): String;
  begin
    Result := conf.fGet(strConf);
    If fEmptyStr(Result) Then
      Result := conf.fGet(strDefault);
  end;
begin

  Result := False;

  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbLa := nil;
  Try
    Try
      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;

      strTipEmb := '';
      intQtdEmb := 0;
      fltPreEmb := 0.0;
      fltEmbala := 0.0;

      strCodEmp    := dicRetorno['codemp'];
      strOpcDoc    := dicRetorno['opcdoc'];
      strTipEmb    := dicRetorno['tipemb'];
      intQtdEmb    := dicRetorno['qtdemb'];
      strTabPre    := dicRetorno['tabpre'];
      blnUsaPreCus := dicRetorno['usaprecus'];

      If strTab = 'N' Then
      Begin
        strAuto := fConsultaStandoxVendaDinamica(Sender, qryTinta, strTabPre, blnFaturamento, dicRetorno, sltItems);
        If (strAuto = '-1') Then
        Begin
          Exit;
        End;
      End
      Else
        strAuto := strAutoTab;

      tinta := TStandoxConsulta.Create;
      conf := fGetConfTinta('DOX');

      qryTinta.Close;
      qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
      cdsTinta := TClientDataSetFactory.GetClientDataSet(qryTinta);

      stlDesEmb.Add('NORMAL');
      stlProEmbLt.Add(conf.fGet('DOXPLT'));
      stlProEmbGl.Add(conf.fGet('DOXPGL'));

      strChaFor := cdsTinta.FieldByName('DOX_DESCRI').AsString + ' ' +
                   cdsTinta.FieldByName('DOX_MONTAD').AsString + ' ' +
                   cdsTinta.FieldByName('DOX_QUALID').AsString + ' ' +
                   cdsTinta.FieldByName('DOX_CODDOX').AsString + ' ' +
                   cdsTinta.FieldByName('DOX_PAINEL').AsString + ' ' +
                   cdsTinta.FieldByName('DOX_CATEGO').AsString;

      dicRetorno['montad'] := cdsTinta.FieldByName('DOX_MONTAD').AsString;

      strIteTin := cdsTinta.FieldByName('DOX_MD5KEY').AsString;

      fltPreCus := 0.0;
      fltUnitar := 0.0;

      If (Not fDigDadosTintometricos(cdsTinta, stlDesEmb, stlProEmbLt,
            stlProEmbGl, strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb,
            fltEmbala, fltPreCus, fltUnitar, fltVolPro, strTabPre, strCatali, dicRetorno,
            strCodDil)) Then
      Begin
        Exit;
      End;

      strDesCor := Trim(tinta.fGetDescricao(cdsTinta.FieldbyName('AUTOINCREM').AsString));

      dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

      //fltPrcTin := fltPreCus;

      If (blnUsaPreCus) Then
        fltUnitar := fltPreCus
      Else
        fltUnitar := fltUnitar;
      
      fltPrvTin := fltUnitar;

      fltPreCus := fFormataFloat(fltPreCus, 2);
      // := fFormataFloat(fltPrcTin, 2);
      fltUnitar := fFormataFloat(fltUnitar, 2);
      fltPrvTin := fFormataFloat(fltPrvTin, 2);

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['unitar'] := fltUnitar;
      //dicRetorno['prctin'] := fltPrcTin;
      dicRetorno['prvtin'] := fltPrvTin;
      dicRetorno['codite'] := fGetProdutoVenda;
      dicRetorno['itetin'] := strIteTin;

      dicRetorno['iteemb'] := strIteEmb;
      dicRetorno['tipemb'] := strTipEmb;
      dicRetorno['qtdemb'] := intQtdEmb;
      dicRetorno['preemb'] := fltPreEmb;
      dicRetorno['tippre'] := strTipPre;
      dicRetorno['embala'] := fltEmbala;
      dicRetorno['descor'] := strDesCor;
      dicRetorno['volpro'] := fltVolPro;
      dicRetorno['chafor'] := strChaFor + strTipEmb;
      dicRetorno['catali'] := strCatali;
      dicRetorno['coddil'] := strCodDil;
      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

function fGetProdutoVenda: string;
begin
  Result := fGetConfTinta('DOX').fGet('PRODOX');
end;

function fGTinForStandoxDinamica(strIteTin: String; fltQtdIte, fltVolPro: Double;
  strTipPre, strCatali: String; Var arrFormul: TForMulTinDetArray; 
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
  strCodEmpPrd: string; strCodDil: String;const strTipCor: string): Boolean;
Var
  strSQL: String;
  strCamFor: String;
  strCamBas: String;
  intContador: Integer;

  strBases: String;
  dicBases: TDicionario;
  qryConsulta: TUniQuery;

  cdsConsulta: TUniClientDataSet;
  objBase: TBaseAutomotiva;
  objFormula: TFormulaStandox;
  fltQuantidade: Double;
begin
  dicBases := nil;
  qryConsulta := nil;
  Result := False;
  Try
    Try
      qryConsulta := fCriaQuery(Nil);
      dicBases := TDicionario.Create;
      strBases := '';

      Result := TMultiSelectLocalizadorFactory.GetLocalizador('DOX').Localizar(cdsConsulta, ['ITETIN'], [strIteTin]);
      if not Result then
        Exit;

      objFormula := TFormulaStandox.Create('1');
      objFormula.fltVolumePro := fltVolPro;

      For intContador := 1 To 20 Do
      Begin
        strCamFor := 'DOX_BASE' + fStrZero(IntToStr(intContador), 2);
        strCamBas := 'DOX_QTDC' + fStrZero(IntToStr(intContador), 2);

        If fEmptyStr(cdsConsulta.FieldByName(strCamFor).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := cdsConsulta.FieldByName(strCamFor).AsString;
        objBase.fltQtdCon := cdsConsulta.FieldByName(strCamBas).AsFloat;
        objBase.fltPesEsp := fRetPesoEspecificoBase(objBase.strCodBas);
        objBase.strTipBas := 'B';
      End;

      objFormula.pReformulaNovo(strCodDil, strToInt(strTipCor));

      For intContador := 0 To objFormula.Count - 1 Do
      Begin
        If strTipPre = 'C' Then
          fltQuantidade := TBaseAutomotiva(objFormula.Items[intContador]).fltQtdCon * fltVolPro
        Else
          fltQuantidade := TBaseAutomotiva(objFormula.Items[intContador]).fltQtdDil * fltVolPro;

        if fltQuantidade <= 0 then
          Continue;

        arrFormul[intContador + 1].strFormul := TBaseAutomotiva(objFormula.Items[intContador]).strCodBas;

        If((arrFormul[intContador + 1].strFormul = 'STBLCOATA')
         Or(arrFormul[intContador + 1].strFormul = 'STBLADJSL')) Then
         Begin
           arrFormul[intContador + 1].fltQtdbas := IIF(strToInt(strTipCor) = 0, 92.7, 170.0) * fltVolPro;
         End
         Else
           arrFormul[intContador + 1].fltQtdbas := fltQuantidade;

        dicBases[arrFormul[intContador + 1].strFormul] := arrFormul[intContador + 1].fltQtdbas;
        strBases := strBases + QuotedStr(arrFormul[intContador + 1].strFormul) + ', ';
      End;

      strBases := Trim(strBases);
      If (RightStr(strBases, 1) = ',') Then
        strBases := Copy(strBases, 1, Length(strBases)-1);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_CODBAS, ';
      strSQL := strSQL + '  BAS_CODITE  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  DOX_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + GetInToOr('BAS_CODBAS', strBases);
//      strSQL := strSQL + '  AND BAS_CODEMP = :CODEMP ';

      qryConsulta.SQL.Text := strSQL;

//      qryConsulta.ParamByName('CODEMP').AsString := strCodEmpPrd;

      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);
      SetLength(arrBaixaPigmentos, cdsConsulta.RecordCount);

      While (Not cdsConsulta.Eof) Do
      Begin
        stlItensTraMl.Add(cdsConsulta.FieldByName('BAS_CODITE').AsString);
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strCodIte   := cdsConsulta.FieldByName('BAS_CODITE').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strFormul   := cdsConsulta.FieldByName('BAS_CODBAS').AsString;

        If((cdsConsulta.FieldByName('BAS_CODBAS').AsString = 'STBLCOATA')
         Or(cdsConsulta.FieldByName('BAS_CODBAS').AsString = 'STBLADJSL')) Then
        Begin
          arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltQtdBaixa := IIF(strToInt(strTipCor) = 0, 92.7, 170.0) * fltVolPro;
        End
        Else
          arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltQtdBaixa := dicBases[cdsConsulta.FieldByName('BAS_CODBAS').AsString];

        cdsConsulta.Next;
      End;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    FreeAndNil(dicBases);
    FreeAndNil(qryConsulta);
  End;
end;

{ TFormulaStandox }

procedure TFormulaStandox.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;
  cdsCadBas: TUniClientDataSet;
  fltPreCusPro,
  fltPreVenPro: Double;

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
    FComLiqCon := 0;
    FPreUltCon := 0;
    FImpUltCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;
    FComLiqDil := 0;
    FPreUltDil := 0;
    FImpUltDil := 0;        
  End;
begin
  inherited;

  pZerarPrecos;
  strCatali := '';

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  tintaDeMaquina[mvConcentrado].Limpar;
  tintaDeMaquina[mvDiluido].Limpar;

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (objBase.strTipBas = 'C') Then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
      if Assigned(componente[mvConcentrado]) then
      begin
        tintaDeMaquina[mvConcentrado].Remover(componente[mvConcentrado]);
      end;

      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
      if Assigned(componente[mvDiluido]) then
      begin
        tintaDeMaquina[mvDiluido].Remover(componente[mvDiluido]);
      end;

      Continue;
    end;

    If (Self.FModoVenda = mvConcentrado) And (objBase.strTipBas = 'D') Then
    Begin
      Continue;
    End;

    if (not cdsCadBas.Locate('BAS_CODBAS', varArrayOf([objBase.strCodBas]) , [])) then
    Begin
      pZerarPrecos;
      raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(cdsCadBas.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (cdsCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    If (cdsCadBas.FieldByName('ITE_PREVEN').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o preço de venda ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    if not IsItemAtivo(cdsCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsCadBas.FieldByName('BAS_CODITE').AsString]);
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

    componente[mvConcentrado].Quantidade := objBase.fltQtdCon * FVolumePro / FVolumeOri;
    componente[mvDiluido].Quantidade := objBase.fltQtdDil * FVolumePro / FVolumeOri;

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreCusBas := fltPreCusPro;
      fltPreVenBas := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusBas = 0 Then
        fltPreCusBas := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusBas := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenBas := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    If cdsCadBas.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Begin
      fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenBas,
                                          fltPreCusBas,
                                          objBase.fltOutVal,
                                          objBase.fltIcmSai,
                                          objBase.fltImpFed,
                                          objBase.fltDesOpe);

      fltPreCusBas := fltPreCusBas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

      fltPreVenBas := fltPreVenBas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

      fltPreCu2Bas := fltPreCu2Bas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

      componente[mvConcentrado].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltOutVal / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltOutVal / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreMed / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreMed / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltImpUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltImpUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltComLiq / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltComLiq / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

    End
    Else
    Begin
      fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenBas,
                                          fltPreCusBas,
                                          objBase.fltOutVal,
                                          objBase.fltIcmSai,
                                          objBase.fltImpFed,
                                          objBase.fltDesOpe);

      fltPreCusBas := fltPreCusBas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat) /
                      cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      fltPreVenBas := fltPreVenBas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat) /
                      cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      fltPreCu2Bas := fltPreCu2Bas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat) /
                      cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltOutVal /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltOutVal /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreMed /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreMed /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltImpUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltImpUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltComLiq /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltComLiq /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;                
    End;

    componente[mvConcentrado].PrecoCusto := (objBase.fltQtdCon * fltPreCusBas) * (FVolumePro / FVolumeOri);
    componente[mvDiluido].PrecoCusto := (objBase.fltQtdDil * fltPreCusBas) * (FVolumePro / FVolumeOri);

    componente[mvConcentrado].PrecoCustoReal := (objBase.fltQtdCon * fltPreCu2Bas) * (FVolumePro / FVolumeOri);
    componente[mvDiluido].PrecoCustoReal := (objBase.fltQtdDil * fltPreCu2Bas) * (FVolumePro / FVolumeOri);

    componente[mvConcentrado].PrecoVenda := (objBase.fltQtdCon * fltPreVenBas) * (FVolumePro / FVolumeOri);
    componente[mvDiluido].PrecoVenda := (objBase.fltQtdDil * fltPreVenBas) * (FVolumePro / FVolumeOri);

    componente[mvConcentrado].IcmsSaida := (componente[mvConcentrado].PrecoVenda * objBase.fltIcmSai / 100);
    componente[mvDiluido].IcmsSaida := (componente[mvDiluido].PrecoVenda * objBase.fltIcmSai / 100);

    componente[mvConcentrado].DespesasOperacionais := (componente[mvConcentrado].PrecoVenda * objBase.fltDesOpe / 100);
    componente[mvDiluido].DespesasOperacionais := (componente[mvDiluido].PrecoVenda * objBase.fltDesOpe / 100);

    componente[mvConcentrado].ImpostosFederais := (componente[mvConcentrado].PrecoVenda * objBase.fltImpFed / 100);
    componente[mvDiluido].ImpostosFederais := (componente[mvDiluido].PrecoVenda * objBase.fltImpFed / 100);
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
  FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;

  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
  FPrecoVenDil := FPrecoVenDil + (fltPerAcr * FPrecoVenDil);

  FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;
  FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;

  FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMob;

  If FPrecoVenDil > 0 Then
    FPrecoVenDil := FPrecoVenDil + fltAcrMob;
end;

procedure TFormulaStandox.pCarregarColorantes;
begin
  inherited;
  strCatali := '';

  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , BAS_PESGRA                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');
  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');
  qryCadBas.SQL.Add('   , ITE_PREMED                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');  

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
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

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
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
  qryCadBas.SQL.Add('   DOX_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  TClientDataSetFactory.GetClientDataSet(qryCadBas);
end;

function fDigDadosTintometricos(qryCadDox: TUniClientDataSet; stlDesEmb, stlProEmbLt,
  stlProEmbGl: TStringList; Var strIteEmb, strTipEmb, strTipPre: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro: Double; strTabPre: String; Var strCatali: String; dicRetorno: TDicionario;
    Var strCodDil: String): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TFormulaStandox;
  intContador: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := False;
  objFormula := nil;
  frmDigTintaAutomotivaStandox := nil;
  conf := fGetConfTinta('DOX');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaStandox.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.fltAcrMob := qryCadDox.FieldByName('DOX_ACRMOB').AsFloat;

      objFormula.fltVolumeOri := 1;
      objFormula.strDescri    := qryCadDox.FieldByName('DOX_DESCRI').AsString + ' - ' +
                                 qryCadDox.FieldByName('DOX_CODDOX').AsString;


      objFormula.FDadosAdicionais  := True;
      objFormula.FCaptionAdicional := 'Diluentes';
      objFormula.FListaAdicional   := fGetDiluentes;
      objFormula.FAdicionalConcentrado := True;
      objFormula.FIndiceAdicional  := 0;

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(qryCadDox.FieldByName('DOX_BASE' + fStrZero(intContador, 2)).AsString)) Then
          Continue;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadDox.FieldByName('DOX_BASE' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := qryCadDox.FieldByName('DOX_QTDC' + fStrZero(intContador, 2)).AsFloat;
        objBase.strTipBas := 'B'
      End;

      objFormula.pCarregaPrecosBases;

      If objFormula.FListaAdicional.Count > 0 Then
        objFormula.pReformulaNovo(objFormula.FListaAdicional[0])
      Else
      Begin
        fMensagem('ATENÇÃO', 'Cadastro de diluentes vazio. É necessário gerar o cadastro de bases para importar os diluentes.', ['OK']);
      End;

      objFormula.pCarregaPrecosBases;

      pCriarFormularios(TfrmDigTintaAutomotivaStandox, frmDigTintaAutomotivaStandox);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotivaStandox.objFormula  := objFormula;
      frmDigTintaAutomotivaStandox.stlDesEmb   := stlDesEmb;
      frmDigTintaAutomotivaStandox.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaStandox.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaStandox.Caption     := frmDigTintaAutomotivaStandox.Caption + 'Standox';


      frmDigTintaAutomotivaStandox.strIdePro   := 'DOX';
      frmDigTintaAutomotivaStandox.chkComCat.Visible := False;

      Result := (frmDigTintaAutomotivaStandox.ShowModal = mrOk);

      If (Result) Then
      Begin
        strIteEmb := frmDigTintaAutomotivaStandox.objFormula.strCodEmb;
        strTipEmb := IIF(frmDigTintaAutomotivaStandox.objFormula.tpeTipEmb = teLitro, 'LT', 'GL');
        strTipPre := IIF(frmDigTintaAutomotivaStandox.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaStandox.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaStandox.objFormula.fltPrecoEmbalagem;
        fltEmbala := IIF(frmDigTintaAutomotivaStandox.objFormula.tpeTipEmb = teLitro, 0.900, 3.600);

        If (frmDigTintaAutomotivaStandox.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotivaStandox.objFormula.fltPrecoCusCon;
          fltPreCu2 := frmDigTintaAutomotivaStandox.objFormula.fltPrecoCu2Con;
          fltPreVen := frmDigTintaAutomotivaStandox.objFormula.fltPrecoVenCon;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotivaStandox.objFormula.fltPrecoCusDil;
          fltPreCu2 := frmDigTintaAutomotivaStandox.objFormula.fltPrecoCu2Dil;
          fltPreVen := frmDigTintaAutomotivaStandox.objFormula.fltPrecoVenDil;
        End;

        dicRetorno['tipcor'] := objFormula.intIdxPorDil;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaStandox.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaStandox.objFormula.fltPreMedCon,
          frmDigTintaAutomotivaStandox.objFormula.fltPreMedDil) +
          frmDigTintaAutomotivaStandox.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaStandox.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaStandox.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaStandox.objFormula.fltImpUltDil) +
          frmDigTintaAutomotivaStandox.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaStandox.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaStandox.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaStandox.objFormula.fltPreUltDil) +
          frmDigTintaAutomotivaStandox.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotivaStandox.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaStandox.objFormula.fltComLiqCon,
          frmDigTintaAutomotivaStandox.objFormula.fltComLiqDil) +
          frmDigTintaAutomotivaStandox.objFormula.fltPrecoCompraLiquidoEmbalagem;

        fltPreCus := fltPreCus + frmDigTintaAutomotivaStandox.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := fltPreCu2 + frmDigTintaAutomotivaStandox.objFormula.fltPrecoCusto2Embalagem;
        fltPreVen := fltPreVen + fltPreEmb;
        fltVolPro := frmDigTintaAutomotivaStandox.objFormula.fltVolumePro;
        strCatali := IfThen(frmDigTintaAutomotivaStandox.chkComCat.Checked, 'S', 'N');
        strCodDil := frmDigTintaAutomotivaStandox.cmbListaAdicional.Text;

        If strTipPre = 'C' Then
          strCodDil := '';

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        objFormula.pCalculaImpostosSaida(dicRetorno);


        dicRetorno['obscolorista']   := frmDigTintaAutomotivaStandox.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotivaStandox.rdgTipoFormula.ItemIndex;


        dicRetorno['saldocols'] := frmDigTintaAutomotivaStandox.blnSaldoSuficiente;
        dicRetorno['promoc']    :=  objFormula.StrPromoc;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaStandox.matrizSaldosColorantes);
      End;

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
    if Assigned(frmDigTintaAutomotivaStandox) then FreeAndNil(frmDigTintaAutomotivaStandox);
  End;
End;

procedure TFormulaStandox.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  cdsCadBas: TUniClientDataSet;
  fltPreCusPro, fltPreVenPro : Double;

  conf: IConfTinta;
  fltDesOpeTinta: Double;
begin
  conf := fGetConfTinta('DOX');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);
  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    cdsCadBas.Locate('BAS_CODBAS', varArrayOf([objBase.strCodBas]) , []);

    objBase.fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESESP').AsFloat;
    objBase.strImpDir := cdsCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;


    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      objBase.fltPreVen := fltPreVenPro;
      FPromoc := 'S';
    End
    Else
    Begin
      objBase.fltPreVen := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.fltOutVal := cdsCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := cdsCadBas.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := cdsCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := cdsCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := cdsCadBas.FieldByName('ITE_PREMED').AsFloat;
    objBase.fltImpUlt := cdsCadBas.FieldByName('ITE_IMPULT').AsFloat;
    objBase.fltPreUlt := cdsCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.strPesGra := cdsCadBas.FieldByName('BAS_PESGRA').AsString;
    objBase.fltComLiq := fCalculaPrecoCompraLiq(cdsCadBas.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF02').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF04').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF06').AsFloat);    
  End;

  FCalculo.Clear;
  FCalculo.Add('VolumeFormula = ' + FloatToStrF(FVolumeOri, ffFixed, 12, 4));
  FCalculo.Add('Valor da Base "Gramas" = (Preço / Embalagem)');
  FCalculo.Add('Valor da Base "MLs" = (Preço / Embalagem / Peso Específico)');
  FCalculo.Add('Preço da Tinta = Soma do Valor da Base de todas as bases.');
end;

procedure pRetornaDadosStandoxDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  cdsCadDox: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('DOX').Localizar(cdsCadDox, ['ITETIN'], [strIteTin]) then
  begin
    dicRetorno['codtin'] := cdsCadDox.FieldByName('DOX_CODDOX').AsString;
    dicRetorno['montad'] := cdsCadDox.FieldByName('DOX_MONTAD').AsString;
//    dicRetorno['martin'] := cdsCadDox.FieldByName('DOX_LINHA_').AsString;
//    dicRetorno['a_n_o_'] := cdsCadDox.FieldByName('DOX_ANOCOR').AsString;
  end;
end;

procedure pRetornaTabelaPrecoStandoxDinamica(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strIteTin: String;
  strTabelas: String;
  objFormula: TFormulaStandox;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  strTabelaUnica: string;
  conf: IConfTinta;
  cdsConsulta: TUniClientDataSet;
begin
  conf := fGetConfTinta('DOX');
  objFormula := nil;
  Try
    Try
      strIteTin := dicRetorno['itetin'];

      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaStandox.Create('1');
      objFormula.calculadorFatVendas := calculadorFatVendas;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      strIteTin := dicRetorno['itetin'];

      If TMultiSelectLocalizadorFactory.GetLocalizador('DOX').Localizar(cdsConsulta, ['ITETIN'], [strIteTin]) Then
        objFormula.fltAcrMob := cdsConsulta.FieldByName('DOX_ACRMOB').AsFloat;

      objFormula.fltVolumeOri := 1;

      objFormula.fltVolumePro := dicRetorno['volpro'];

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
          Continue;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro;
        objBase.strTipBas := 'B';
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');
      if not fEmptyStr(strTabelaUnica) then
      begin
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
      end
      else
      begin
        strTabelas := fCfgSis('TABPRC');
        If Length(strTabelas) < 6 Then
          strTabelas := strTabelas + StringOfChar('N',6-Length(strTabelas));

        For intContador := 1 To Length(strTabelas) Do
        Begin

          objFormula.strTabPre := IntToStr(intContador);
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
            dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
          End
          Else
          Begin
            dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
            dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
          End;

          if intContador = IfNull(dicRetorno['tabpre'], 0) then
          begin
            objFormula.pCalculaImpostosSaida(dicRetorno);
            dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
            dicRetorno['promoc'] := objFormula.StrPromoc;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End
            Else
            Begin
              dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End;
          end;
        End;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(cdsConsulta) then FreeAndNil(cdsConsulta);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;

end;

function fGetDiluentes: TStringList;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT                                    ' +
        '   *                                                ' +
        ' FROM                                               ' +
        '   DOX_CADBAS B                                     ' +
        '   INNER JOIN DOX_CADDIL D                          ' +
        '     ON D.DIL_CODDIL = B.BAS_CODBAS                 ';

      qryGen.Open;

      Result := TStringList.Create;

      while not qryGen.Eof do
      begin
        Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
        qryGen.Next;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TFormulaStandox.pReformula(strDiluente: String);
  Var
    intCont: Integer;
    objBase: TBaseAutomotiva;
//    fltVolume: Double;
begin
  //RESTAURA A FORMULACAO COM SOMENTE O CONCENTRADO
  For intCont := Self.Count - 1 DownTo 0 do
  Begin
    If TBaseAutomotiva(Self.Items[intCont]).strTipBas <> 'B' Then
    Begin
      Self.Delete(intCont);
    End
    Else
    Begin
      TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := 0;
    End;
  End;

  If strDiluente = 'MSB 10-20' Then
  Begin
    objBase := TBaseAutomotiva(Self.Add);
    objBase.strCodBas := strDiluente;
    objBase.fltQtdDil := 291.7;
    objBase.strTipBas := 'D';
  End
  Else If strDiluente = 'MSB 15-25' Then
  Begin
    objBase := TBaseAutomotiva(Self.Add);
    objBase.strCodBas := strDiluente;
    objBase.fltQtdDil := 283.3;
    objBase.strTipBas := 'D';
  End
  Else If strDiluente = 'MSB 25-35' Then
  Begin
    objBase := TBaseAutomotiva(Self.Add);
    objBase.strCodBas := strDiluente;
    objBase.fltQtdDil := 289.7;
    objBase.strTipBas := 'D';
  End

  {  - SE O USUÁRIO OPTAR POR 10% DE DILUIÇÃO A QUANTIDADE DO DILUENTE PARA 1 LITRO É: 92,7.
     - SE 20% DE DILUIÇÃO A QUANTIDADE DO DILUENTE PARA 1 LITRO É: 170,0
  }
  Else If strDiluente = 'STBLCOATA' Then
  Begin
    objBase := TBaseAutomotiva(Self.Add);
    objBase.strCodBas := strDiluente;
    objBase.fltQtdDil := 92.7;
    objBase.strTipBas := 'D';
  End
  Else If strDiluente = 'STBLADJSL' Then
  Begin
    objBase := TBaseAutomotiva(Self.Add);
    objBase.strCodBas := strDiluente;
    objBase.fltQtdDil := 92.7;
    objBase.strTipBas := 'D';
  End;

  //MONTA A FORMULACAO DE ACORDO COM AS BASES
  For intCont := 0 To Self.Count - 1 Do
  Begin
    If TBaseAutomotiva(Self.Items[intCont]).strTipBas = 'B' Then
    Begin
      TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := (TBaseAutomotiva(Self.Items[intCont]).fltQtdCon -
                                                       ((TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 33.3) / 100));
    End;
  End;

  Try
    pCarregaPrecosBases;
    pCalcularPrecos;
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO', e.Message, ['OK']);
    End;
  End;
end;

procedure TFormulaStandox.pReformulaNovo(strCodDil: String; intIdxPercentual : Integer = 0);
var
  intCont: Integer;
  diluente: TBaseAutomotiva;
  qryGen: TUniQuery;
  base: TBaseAutomotiva;
  fltTotalVolumeAtual: Double;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT                                      '+
        '   *                                                  '+
        ' FROM                                                 '+
        '   DOX_CADBAS B                                       '+
        '   INNER JOIN DOX_CADDIL D                            '+
        '     ON D.DIL_CODDIL = B.BAS_CODBAS                   '+
        '   INNER JOIN ITEGER I ON I.ITE_CODITE = B.BAS_CODITE '+
        '                      AND I.ITE_CODEMP = B.BAS_CODEMP '+
        ' WHERE BAS_CODBAS = :CODBAS                           ';

      qryGen.ParamByName('CODBAS').AsString := strCodDil;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      fltTotalVolumeAtual := 0;

      for intCont := Self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);
        if base.strTipBas <> 'B' then
          Self.Delete(intCont)
        else
          fltTotalVolumeAtual := fltTotalVolumeAtual + (base.fltQtdCon / base.fltPesEsp);
      end;

      diluente := (Self.Add as TBaseAutomotiva);
      diluente.strCodBas := strCodDil;
      diluente.strTipBas := 'D';
      diluente.fltPesEsp := qryGen.FieldByName('BAS_PESESP').AsFloat;
      diluente.fltQtdDil := fRetQtdDiluente(strCodDil, intIdxPercentual);
      diluente.fltPreVen := qryGen.FieldByName('ITE_PREVE' + strTabPre).AsFloat;
      diluente.fltEmbala := qryGen.FieldByName('BAS_EMBALA').AsFloat;

      for intCont := Self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);

        if base.strTipBas <> 'D' then
        begin
          base.fltQtdDil := (base.fltQtdCon / base.fltPesEsp);
          base.fltQtdDil := ((base.fltQtdDil * 1000) / fltTotalVolumeAtual);

          If ((strCodDil =  'STBLCOATA') Or (strCodDil =  'STBLADJSL')) Then
          Begin
            base.fltQtdDil := ((base.fltQtdDil * 1000) / IIF(intIdxPercentual = 0,1100,1200));
          End
          Else
            base.fltQtdDil := ((base.fltQtdDil * 1000) / 1500);

          base.fltQtdDil := fFormataFloat((base.fltQtdDil * base.fltPesEsp),1);
        end;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function fRetQtdDiluente(strCodDil: String; intIdxPercentual : Integer = 0 ): Double;
begin
  Result := 0;

  If strCodDil = 'MSB 10-20' Then
  Begin
    Result := 291.7;
  End
  Else If strCodDil = 'MSB 15-25' Then
  Begin
    Result := 283.3;
  End
  Else If strCodDil = 'MSB 25-35' Then
  Begin
    Result := 289.7;
  End
  Else If strCodDil = 'STBLCOATA' Then
  Begin
    Result := IIF(intIdxPercentual = 0, 92.7, 170.0);
  End
  Else If strCodDil = 'STBLADJSL' Then
  Begin
    Result := IIF(intIdxPercentual = 0, 92.7, 170.0);
  End;

end;

function fRetPesoEspecificoBase(strCodBas: String): Double;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT BAS_PESESP ');
      SQL.Add('   FROM DOX_CADBAS ');
      SQL.Add('  WHERE BAS_CODBAS = :CODBAS ');
      ParamByName('CODBAS').AsString := strCodBas;
      Open;

      Result := FieldByName('BAS_PESESP').AsFloat;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

{ TfrmConsultaCompTintaVenda }

function fConsultaStandoxInterna(Sender: TForm; Var qryCadDox: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TStandoxConsulta.Create).fExecutarConsulta(Sender,
    qryCadDox, tipoConsulta, strTabPre, TfrmConsultaCompTintaStandox,
    '', blnFaturamento, dicRetorno, sltItems);
End;

procedure TfrmConsultaCompTintaStandox.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  strIteEmb: String;
  strTipEmb: String;
  strTipPre: String;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  fltVolPro: Double;
  strCatali: String;
  strCodDil: String;

  conf: IConfTinta;

  dicParams: TDicionario;
  cdsGen: TUniClientDataSet;
  function fConfOuDefault(strConf, strDefault: String): String;
  begin
    Result := conf.fGet(strConf);
    If fEmptyStr(Result) Then
      Result := conf.fGet(strDefault);
  end;
begin
  dicParams := nil;
  qryGen := nil;
  stlDesEmb   := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;

  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('DOX');

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM DOX_CADDOX WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;

      stlDesEmb.Add('NORMAL');
      stlProEmbLt.Add(conf.fGet('DOXPLT'));
      stlProEmbGl.Add(conf.fGet('DOXPGL'));

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'DOX';

      fDigDadosTintometricos(cdsGen, stlDesEmb, stlProEmbLt,
        stlProEmbGl, strIteEmb, strTipEmb, strTipPre,
        intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar,
        fltVolPro, strTabPre, strCatali, dicParams, strCodDil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicParams) then FreeAndNil(dicParams);
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  End;
end;

procedure TfrmConsultaCompTintaStandox.pTarefaPrecos(Sender: TObject);
begin
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompTintaStandox.pTarefaVenda(Sender: TObject);
begin
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadStandoxNovasFormulas', False);
end;

constructor TFormulaStandox.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited Create(strTabPrePar, TBaseAutomotiva);
  conf := fGetConfTinta('DOX');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
  fltAcrMob := 0;
end;

end.

