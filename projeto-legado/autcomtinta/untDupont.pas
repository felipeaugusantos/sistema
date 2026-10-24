unit untDupont;

interface

uses SysUtils, Uni, Forms, Classes,  StrUtils, Controls,
  untFuncEspecificas, untFuncoesSimples, untConsultaCompTinta, Variants,
  untConsultaCompTintaNova, untPnlBotoesAcoesNovaConsulta,
  Math,
  UniClientDataSet;

{***************************************************}
{* CRIA A CLASSE QUE REPRESENTA UMA FORMULA DA     *}
{* DUPONT                                          *}
{** 04/06/2008 - 17:09 **************************MV*}
Type

  TBaseAutomotivaDupont = class(TBaseAutomotiva)
  private
    FstrQualid: String;
    procedure SetstrQualid(const Value: String);
  public
    property strQualid: String read FstrQualid write SetstrQualid;
  End;

  TFormulaDupont = class(TFormulaAutomotiva)
  private
    fltPerAcr: Double;
    fltAcrMob: Double;
  public
    strCatali: String;
    procedure pCarregarColorantes; override;
    procedure pCalcularPrecos; override;
    procedure pCarregaPrecosBases; override;
    constructor Create(strTabPrePar: String); override;
  End;

Type
  TfrmConsultaCompTintaDupont = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  function fConsultaDupontInterna(Sender: TForm; Var qryCadDup: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String): String; stdcall;

  function fConsultaDupont(Sender: TForm): String; stdcall;
  function fConsultaDupontGeral(Sender: TForm): String; stdcall;
  function fConsultaDupontVenda(Sender: TForm; Var qryCadDup: TUniQuery; strTabPre: String): String; stdcall;

  function fRetornaDescricaoDupont(qryTinta: TUniQuery; strDesCor: String): String;
  function fRetornaUniTraProDupont(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaUniTraEmbDupont(strTipEmb: String): Double;

  function fRetornaPrecoDupont(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGetProdutoVenda(const strLinha: string): string;

  function fDigDadosTintometricos(qryCadDup: TUniClientDataSet; stlDesEmb, stlProEmbLt,
    stlProEmbGl, stlProEmbLa: TStringList; strProEmbCo, strProEmbSp, strProEmbSs,
    strProEmbPo, strProEmbDu, strProEmbBa, strProEmbTb: String;
    Var strIteEmb, strTipEmb, strTipPre: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro: Double; strTabPre: String; Var strCatali: String; dicRetorno: TDicionario): Boolean;

  function fGTinForDupont(strIteTin: String; fltQtdIte, fltVolPro: Double;
    strTipPre, strCatali: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodEmpPrd: string): Boolean; stdcall;

  procedure pRetornaDadosDupont(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoDupont(dicRetorno: TDicionario; fltFatorAcerto: Double);
  function fGetQualidade(strIteTin: String): String;

implementation

uses
  DB,untFuncoes,untIConfTinta,untIConsultaTinta,
  untDigTintaAutomotivaColorPro, untTintaMaquina,untITintaDeMaquinaComponente,
  untDigTintaAutomotivaDupont,untICalculadorFatVendas,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo, unTDupontConsulta,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva, untClientDataSetFactory, untMultiSelectLocalizadorFactory;

function fConsultaDupont(Sender: TForm): String;
var
  qryCadDup: TUniQuery;
begin
  qryCadDup := nil;
  Try
    Try
      qryCadDup := fCriaQuery(Sender);
      Result := fConsultaDupontInterna(Sender, qryCadDup, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadDup) then FreeAndNil(qryCadDup);
  End;
end;

function fConsultaDupontGeral(Sender: TForm): String;
Var
  qryCadDup: TUniQuery;
begin
  qryCadDup := nil;
  Try
    Try
      qryCadDup := fCriaQuery(Sender);
      Result := fConsultaDupontInterna(Sender, qryCadDup, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadDup) then FreeAndNil(qryCadDup);
  End;
end;

function fConsultaDupontVenda(Sender: TForm;
  Var qryCadDup: TUniQuery; strTabPre: String): String;
begin
  Result := fConsultaDupontInterna(Sender, qryCadDup, tpcVenda, strTabPre);
end;

function fRetornaDescricaoDupont(qryTinta: TUniQuery; strDesCor: String): String;
begin
  Result := strDesCor;
end;

function fRetornaUniTraProDupont(fltPrcTin, fltPrvTin: Double): Double;
var
  strTraDupont: String;
  fltTraDupont: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('DUP');
  strTraDupont := conf.fGet('TRADUP');
  fltTraDupont := conf.fGetDouble('FATDUP');

  If (strTraDupont = 'VEN') Then
    Result := fltPrvTin
  Else
    Result := fltPrcTin;

  Result := fFormataFloat(Result * fltTraDupont, 2);
end;

function fRetornaUniTraEmbDupont(strTipEmb: String): Double;
var
  fltPreEmb: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('DUP');
  fltPreEmb := 0.0;
  If (strTipEmb = '1/8') Then
    fltPreEmb := conf.fGetDouble('EMB1_8')
  Else If (strTipEmb = '1/4') Then
    fltPreEmb := conf.fGetDouble('EMB1_4')
  Else If (strTipEmb = '1/2') Then
    fltPreEmb := conf.fGetDouble('EMB1_2')
  Else If (strTipEmb = 'GL') Then
    fltPreEmb := conf.fGetDouble('EMBGAL');

  Result := fltPreEmb * conf.fGetDouble('FATDUP')

end;

function fRetornaPrecoDupont(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
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
//  fltPrcTin: Double;
  fltPrvTin: Double;

  strIteEmb: String;

  fltVolPro: Double;

  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;
  strProEmbCo: String;
  strProEmbSp: String;
  strProEmbSs: String;
  strProEmbPo: String;
  strProEmbDu: String;
  strProEmbBa: String;
  strProEmbTb: String;

  strChaFor: String;
  strTabPre: String;
  strCatali: String;

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

      strAuto := fConsultaDupontVenda(Sender, qryTinta, strTabPre);
      If (strAuto = '-1') Then
      Begin
        Exit;
      End;

      tinta := TDupontConsulta.Create;
      conf := fGetConfTinta('DUP');

      qryTinta.Close;
      qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
      cdsTinta := TClientDataSetFactory.GetClientDataSet(qryTinta);

      stlDesEmb.Add('DUXONE');
      stlProEmbLt.Add(conf.fGet('ITE1_4'));
      stlProEmbGl.Add(conf.fGet('ITEGAL'));
      stlProEmbLa.Add(conf.fGet('ITELAT'));

      stlDesEmb.Add('NASON');
      stlProEmbLt.Add(conf.fGet('NASOLT'));
      stlProEmbGl.Add(conf.fGet('NASOGL'));
      stlProEmbLa.Add(conf.fGet('NASOLA'));

      stlDesEmb.Add('CHROMA');
      stlProEmbLt.Add(conf.fGet('CHROLT'));
      stlProEmbGl.Add(conf.fGet('CHROGL'));
      stlProEmbLa.Add(conf.fGet('CHROLA'));

      stlDesEmb.Add('IMRON');
      stlProEmbLt.Add(conf.fGet('IMROLT'));
      stlProEmbGl.Add(conf.fGet('IMROGL'));
      stlProEmbLa.Add(conf.fGet('IMROLA'));

      stlDesEmb.Add('CORMAX');
      stlProEmbLt.Add(conf.fGet('CORMLT'));
      stlProEmbGl.Add(conf.fGet('CORMGL'));
      stlProEmbLa.Add(conf.fGet('CORMLA'));

      strProEmbCo := conf.fGet('ITECOP');
      strProEmbSs := conf.fGet('ITESPS');
      strProEmbPo := conf.fGet('ITESPO');
      strProEmbDu := conf.fGet('ITESDU');
      strProEmbBa := conf.fGet('ITEBAL');
      strProEmbTb := conf.fGet('ITETAM');

      strChaFor := cdsTinta.FieldByName('DUP_DESCRI').AsString + ' ' +
                   cdsTinta.FieldByName('DUP_MONTAD').AsString + ' ' +
                   cdsTinta.FieldByName('DUP_QUALID').AsString + ' ' +
                   cdsTinta.FieldByName('DUP_CODDUP').AsString + ' ' +
                   cdsTinta.FieldByName('DUP_ALTERN').AsString + ' ' +
                   cdsTinta.FieldByName('DUP_REGIAO').AsString;

      dicRetorno['montad'] := cdsTinta.FieldByName('DUP_MONTAD').AsString;
      dicRetorno['a_n_o_'] := cdsTinta.FieldByName('DUP_ANOCOR').AsString;
      dicRetorno['linha_'] := cdsTinta.FieldByName('DUP_LINHA_').AsString;

      strIteTin := cdsTinta.FieldByName('DUP_MD5KEY').AsString;

      fltPreCus := 0.0;
      fltUnitar := 0.0;

      If fEmptyStr(fGetProdutoVenda(cdsTinta.FieldByName('DUP_LINHA_').AsString)) Then
      Begin
        fMensagem('ATENÇÃO', 'O produto para venda (' + cdsTinta.FieldByName('DUP_LINHA_').AsString + ') não está com o produto associado ' + #13#10 +
                             'nas configurações do AUTTIN. Favor verificar!',['&Ok']);
//        Raise Exception.Create('O produto para venda (' + cdsTinta.FieldByName('DUP_LINHA_').AsString + ') não está com o produto associado ' + #13#10 +
//                               'nas configurações do AUTTIN. Favor verificar!');
        Exit;
      End;

      If (Not fDigDadosTintometricos(cdsTinta, stlDesEmb, stlProEmbLt,
            stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp, strProEmbSs,
            strProEmbPo, strProEmbDu, strProEmbBa, strProEmbTb,
            strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb,
            fltEmbala, fltPreCus, fltUnitar, fltVolPro, strTabPre, strCatali, dicRetorno)) Then
      Begin
        Exit;
      End;

      strDesCor := Trim(tinta.fGetDescricao(cdsTinta.FieldbyName('AUTOINCREM').AsString));

      dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

//      fltPrcTin := fltPreCus;

      If (blnUsaPreCus) Then
        fltUnitar := fltPreCus
      Else
        fltUnitar := fltUnitar;

      fltPrvTin := fltUnitar;

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['unitar'] := fltUnitar;
//      dicRetorno['prctin'] := fltPrcTin;
      dicRetorno['prvtin'] := fltPrvTin;
      dicRetorno['codite'] := fGetProdutoVenda(cdsTinta.FieldByName('DUP_LINHA_').AsString);
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
      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));      

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

function fGetProdutoVenda(const strLinha: string): string;
begin
  Result := '';

  if Pos('CHROMA', strLinha) > 0 then
    Result := fGetConfTinta('DUP').fGet('PROCHR')
  else if Pos('DUXONE', strLinha) > 0 then
    Result := fGetConfTinta('DUP').fGet('PRODUX')
  else if Pos('IMRON', strLinha) > 0 then
    Result := fGetConfTinta('DUP').fGet('PROIRO')
  else if Pos('CORMAX', strLinha) > 0 then
    Result := fGetConfTinta('DUP').fGet('PROCOR')
  else if Pos('NASON', strLinha) > 0 then
    Result := fGetConfTinta('DUP').fGet('PRONAS');

//  if fEmptyStr(Result) then
//    Result := fGetConfTinta('DUP').fGet('PRODUP');
end;

function fGTinForDupont(strIteTin: String; fltQtdIte, fltVolPro: Double;
  strTipPre, strCatali: String; Var arrFormul: TForMulTinDetArray; 
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
  strCodEmpPrd: string): Boolean;
Var
  strSQL: String;
  strCamFor: String;
  strCamBas: String;
  intContador: Integer;

  strBases: String;
  dicBases: TDicionario;
  qryConsulta: TUniQuery;

  intIndice: Integer;
  strQualid: String;
  cdsConsulta: TUniClientDataSet;
begin
  dicBases := nil;
  qryConsulta := nil;
  Result := False;
  Try
    Try
      qryConsulta := fCriaQuery(Nil);
      dicBases := TDicionario.Create;
      strBases := '';

      Result := TMultiSelectLocalizadorFactory.GetLocalizador('DUP').Localizar(cdsConsulta, ['ITETIN'], [strIteTin]);
      if not Result then
        Exit;

      intIndice := 1;
      For intContador := 1 To 20 Do
      Begin

        strCamFor := 'DUP_BASE' + fStrZero(IntToStr(intContador), 2);

        If strTipPre = 'C' Then
          strCamBas := 'DUP_QTDC' + fStrZero(IntToStr(intContador), 2)
        Else
          strCamBas := 'DUP_QTDD' + fStrZero(IntToStr(intContador), 2);

        If (cdsConsulta.FieldByName(strCamBas).AsFloat <= 0) Then
          Continue;

        If (cdsConsulta.FieldByName('DUP_TIPB' + fStrZero(IntToStr(intContador), 2)).AsString = 'C')
          And (strCatali <> 'S') Then
          Continue;

        If cdsConsulta.FieldByName(strCamFor).AsString <> strCatali Then
        Begin

          arrFormul[intIndice].strFormul := cdsConsulta.FieldByName(strCamFor).AsString;
          arrFormul[intIndice].fltQtdBas := RoundTo(RoundTo(cdsConsulta.FieldByName(strCamBas).AsFloat, -1) * (fltVolPro * 1000) /
                                                        cdsConsulta.FieldByName('DUP_LITRAG').AsFloat, -1);

          dicBases[arrFormul[intIndice].strFormul] := arrFormul[intIndice].fltQtdBas;

          strBases := strBases + QuotedStr(arrFormul[intIndice].strFormul);
          If (Not fEmptyStr(arrFormul[intIndice].strFormul)) Then
            strBases := strBases + ', ';

          Inc(intIndice, 1);
        End;

      End;

      strBases := Trim(strBases);
      If (RightStr(strBases, 1) = ',') Then
        strBases := Copy(strBases, 1, Length(strBases)-1);

      strQualid := cdsConsulta.FieldByName('DUP_QUALID').AsString;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_CODBAS, ';
      strSQL := strSQL + '  BAS_CODITE, ';
      strSQL := strSQL + '  BAS_PESGRA, ';
      strSQL := strSQL + '  BAS_EMBALA  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  DUP_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + GetInToOr('BAS_CODBAS', strBases);
      If VS_blnCodEmpBasDup Then
        strSQL := strSQL + '  AND BAS_CODEMP = :CODEMP ';

      qryConsulta.SQL.Text := strSQL;
      If VS_blnCodEmpBasDup Then
        qryConsulta.ParamByName('CODEMP').AsString := strCodEmpPrd;

      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);
      SetLength(arrBaixaPigmentos, cdsConsulta.RecordCount);

      While (Not cdsConsulta.Eof) Do
      Begin
        stlItensTraMl.Add(cdsConsulta.FieldByName('BAS_CODITE').AsString);
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strCodIte   := cdsConsulta.FieldByName('BAS_CODITE').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltQtdBaixa := dicBases[cdsConsulta.FieldByName('BAS_CODBAS').AsString];
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strFormul := cdsConsulta.FieldByName('BAS_CODBAS').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strPesGra := cdsConsulta.FieldByName('BAS_PESGRA').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltEmbBas := cdsConsulta.FieldByName('BAS_EMBALA').AsFloat;
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

{ TFormulaDupont }

procedure TFormulaDupont.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotivaDupont;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;
  cdsCadBas: TUniClientDataSet;

  fltPreCusItem: Double;
  fltPreVenItem: Double;
  fltPreCusPro: Double;
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

    FPromoc := 'N';
  End;
begin
  inherited;

  pZerarPrecos;
  strCatali := '';

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotivaDupont(Items[intIndex]);

    If (blnComCatalisador) And (objBase.strTipBas = 'C') Then
    Begin
      strCatali := objBase.strCodBas;
    End;

    If (not blnComCatalisador) And (objBase.strTipBas = 'C') Then
    begin
      strCatali := '';

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
//      raise Exception.Create('Base ' + objBase.strCodBas + '/' + objBase.strQualid + ' não cadastrada. Favor verificar.');
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
      Raise Exception.Create('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o preço de venda ' + strTabPre + #13#10 +
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

//    componente[mvConcentrado].Quantidade := objBase.fltQtdCon * FVolumePro / FVolumeOri;
//    componente[mvDiluido].Quantidade := objBase.fltQtdDil * FVolumePro / FVolumeOri;

    componente[mvConcentrado].Quantidade := RoundTo(objBase.fltQtdCon * FVolumePro / FVolumeOri, -1);
    componente[mvDiluido].Quantidade := RoundTo(objBase.fltQtdDil * FVolumePro / FVolumeOri, -1);

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreCusItem := fltPreCusPro;
      fltPreVenItem := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusItem = 0 Then
        fltPreCusItem := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusItem := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenItem := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    If cdsCadBas.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Begin
      fltPreCusBas := fltPreCusItem /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

      fltPreVenBas := fltPreVenItem /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

      fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenItem,
                                          fltPreCusItem,
                                          objBase.fltOutVal,
                                          objBase.fltIcmSai,
                                          objBase.fltImpFed,
                                          objBase.fltDesOpe);

      fltPreCu2Bas := fltPreCu2Bas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

//      componente[mvConcentrado].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltOutVal / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
//      componente[mvDiluido].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltOutVal / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].OutrosValores := componente[mvConcentrado].Quantidade * objBase.fltOutVal / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].OutrosValores := componente[mvDiluido].Quantidade * objBase.fltOutVal / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

//      componente[mvConcentrado].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreMed / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
//      componente[mvDiluido].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreMed / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].PrecoMedio := componente[mvConcentrado].Quantidade * objBase.fltPreMed / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].PrecoMedio := componente[mvDiluido].Quantidade * objBase.fltPreMed / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

//      componente[mvConcentrado].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
//      componente[mvDiluido].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompra := componente[mvConcentrado].Quantidade * objBase.fltPreUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].UltimoPrecoCompra := componente[mvDiluido].Quantidade * objBase.fltPreUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

//      componente[mvConcentrado].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltImpUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
//      componente[mvDiluido].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltImpUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompraImpostos := componente[mvConcentrado].Quantidade * objBase.fltImpUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].UltimoPrecoCompraImpostos := componente[mvDiluido].Quantidade * objBase.fltImpUlt / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

//      componente[mvConcentrado].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltComLiq / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
//      componente[mvDiluido].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltComLiq / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

      componente[mvConcentrado].PrecoCompraLiquido := componente[mvConcentrado].Quantidade * objBase.fltComLiq / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
      componente[mvDiluido].PrecoCompraLiquido := componente[mvDiluido].Quantidade * objBase.fltComLiq / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
    End
    Else
    Begin
      fltPreCusBas := fltPreCusItem /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat) /
                      cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      fltPreVenBas := fltPreVenItem /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat) /
                      cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenItem,
                                          fltPreCusItem,
                                          objBase.fltOutVal,
                                          objBase.fltIcmSai,
                                          objBase.fltImpFed,
                                          objBase.fltDesOpe);

      fltPreCu2Bas := fltPreCu2Bas /
                      (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat) /
                      cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvConcentrado].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltOutVal /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvDiluido].OutrosValores := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltOutVal /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].OutrosValores := componente[mvConcentrado].Quantidade * objBase.fltOutVal /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].OutrosValores := componente[mvDiluido].Quantidade * objBase.fltOutVal /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvConcentrado].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreMed /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvDiluido].PrecoMedio := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreMed /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].PrecoMedio := componente[mvConcentrado].Quantidade * objBase.fltPreMed /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].PrecoMedio := componente[mvDiluido].Quantidade * objBase.fltPreMed /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvConcentrado].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltPreUlt /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvDiluido].UltimoPrecoCompra := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltPreUlt /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompra := componente[mvConcentrado].Quantidade * objBase.fltPreUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].UltimoPrecoCompra := componente[mvDiluido].Quantidade * objBase.fltPreUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvConcentrado].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltImpUlt /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvDiluido].UltimoPrecoCompraImpostos := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltImpUlt /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].UltimoPrecoCompraImpostos := componente[mvConcentrado].Quantidade * objBase.fltImpUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].UltimoPrecoCompraImpostos := componente[mvDiluido].Quantidade * objBase.fltImpUlt /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvConcentrado].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdCon * objBase.fltComLiq /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

//      componente[mvDiluido].PrecoCompraLiquido := (FVolumePro / FVolumeOri) * objBase.fltQtdDil * objBase.fltComLiq /
//        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvConcentrado].PrecoCompraLiquido := componente[mvConcentrado].Quantidade * objBase.fltComLiq /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

      componente[mvDiluido].PrecoCompraLiquido := componente[mvDiluido].Quantidade * objBase.fltComLiq /
        cdsCadBas.FieldByName('BAS_EMBALA').AsFloat / cdsCadBas.FieldByName('BAS_PESESP').AsFloat;
    End;

//    componente[mvConcentrado].PrecoCusto := (objBase.fltQtdCon * fltPreCusBas) * (FVolumePro / FVolumeOri);
//    componente[mvDiluido].PrecoCusto := (objBase.fltQtdDil * fltPreCusBas) * (FVolumePro / FVolumeOri);

    componente[mvConcentrado].PrecoCusto := (componente[mvConcentrado].Quantidade * fltPreCusBas);
    componente[mvDiluido].PrecoCusto := (componente[mvDiluido].Quantidade * fltPreCusBas);

//    componente[mvConcentrado].PrecoCustoReal := (objBase.fltQtdCon * fltPreCu2Bas) * (FVolumePro / FVolumeOri);
//    componente[mvDiluido].PrecoCustoReal := (objBase.fltQtdDil * fltPreCu2Bas) * (FVolumePro / FVolumeOri);

    componente[mvConcentrado].PrecoCustoReal := (componente[mvConcentrado].Quantidade * fltPreCu2Bas);
    componente[mvDiluido].PrecoCustoReal := (componente[mvDiluido].Quantidade * fltPreCu2Bas);

//    componente[mvConcentrado].PrecoVenda := (objBase.fltQtdCon * fltPreVenBas) * (FVolumePro / FVolumeOri);
//    componente[mvDiluido].PrecoVenda := (objBase.fltQtdDil * fltPreVenBas) * (FVolumePro / FVolumeOri);

    componente[mvConcentrado].PrecoVenda := (componente[mvConcentrado].Quantidade * fltPreVenBas);
    componente[mvDiluido].PrecoVenda := (componente[mvDiluido].Quantidade * fltPreVenBas);

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

procedure TFormulaDupont.pCarregarColorantes;
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
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario then
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
  qryCadBas.SQL.Add('   DUP_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  If VS_blnCodEmpBasDup Then
  Begin
    qryCadBas.SQL.Add('   AND BAS_CODEMP = :EMPBAS           ');
    qryCadBas.ParamByName('EMPBAS').AsString := VS_strCodEmp;
  End;

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  TClientDataSetFactory.GetClientDataSet(qryCadBas);
end;

function fDigDadosTintometricos(qryCadDup: TUniClientDataSet; stlDesEmb, stlProEmbLt,
  stlProEmbGl, stlProEmbLa: TStringList; strProEmbCo, strProEmbSp, strProEmbSs,
  strProEmbPo, strProEmbDu, strProEmbBa, strProEmbTb: String;
    Var strIteEmb, strTipEmb, strTipPre: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro: Double; strTabPre: String; Var strCatali: String; dicRetorno: TDicionario): Boolean;
var
  objBase: TBaseAutomotivaDupont;
  objFormula: TFormulaDupont;
  intContador: Integer;
  fltPreCu2: Double;
  intIndEmb: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := False;
  objFormula := nil;
  frmDigTintaAutomotivaDupont := nil;
  conf := fGetConfTinta('DUP');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaDupont.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := qryCadDup.FieldByName('DUP_LITRAG').AsFloat / 1000;
      objFormula.strDescri    := qryCadDup.FieldByName('DUP_DESCRI').AsString + ' - ' +
                                 qryCadDup.FieldByName('DUP_CODDUP').AsString;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.fltAcrMob := qryCadDup.FieldByName('DUP_ACRMOB').AsFloat;

      intIndEmb := -1;
      if qryCadDup.FieldByName('DUP_LINHA_').AsString = 'DUXONE' then
        intIndEmb := 0
      else if qryCadDup.FieldByName('DUP_LINHA_').AsString = 'NASON' then
        intIndEmb := 1
      else if qryCadDup.FieldByName('DUP_LINHA_').AsString = 'CHROMA' then
        intIndEmb := 2
      else if qryCadDup.FieldByName('DUP_LINHA_').AsString = 'IMRON' then
        intIndEmb := 3
      else if qryCadDup.FieldByName('DUP_LINHA_').AsString = 'CORMAX' then
        intIndEmb := 4;

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(qryCadDup.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString)) Then
          Continue;

        objBase := TBaseAutomotivaDupont(objFormula.Add);
        objBase.strIdePro := 'DUP';
        objBase.strCodBas := qryCadDup.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := RoundTo(qryCadDup.FieldByName('DUP_QTDC' + fStrZero(intContador, 2)).AsFloat, -1);
        objBase.fltQtdDil := RoundTo(qryCadDup.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat, -1);
        objBase.strTipBas := qryCadDup.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString;
        objBase.strQualid := qryCadDup.FieldByName('DUP_QUALID').AsString;
      End;

      objFormula.pCarregaPrecosBases;

      Application.CreateForm(TfrmDigTintaAutomotivaDupont, frmDigTintaAutomotivaDupont);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotivaDupont.objFormula  := objFormula;
      frmDigTintaAutomotivaDupont.stlDesEmb   := stlDesEmb;
      frmDigTintaAutomotivaDupont.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaDupont.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaDupont.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotivaDupont.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotivaDupont.strProEmbSs := strProEmbSs;
      frmDigTintaAutomotivaDupont.strProEmbPo := strProEmbPo;
      frmDigTintaAutomotivaDupont.strProEmbDu := strProEmbDu;
      frmDigTintaAutomotivaDupont.stlProEmbLa := stlProEmbLa;
      frmDigTintaAutomotivaDupont.strProEmbBa := strProEmbBa;
      frmDigTintaAutomotivaDupont.strProEmbTb := strProEmbTb;
      frmDigTintaAutomotivaDupont.Caption     := frmDigTintaAutomotivaDupont.Caption + 'Dupont';

      frmDigTintaAutomotivaDupont.strIdePro   := 'DUP';
      frmDigTintaAutomotivaDupont.intIndEmb   := intIndEmb;
      frmDigTintaAutomotivaDupont.strQualid   := qryCadDup.FieldByName('DUP_QUALID').AsString;

      Result := (frmDigTintaAutomotivaDupont.ShowModal = mrOk);

      If (Result) Then
      Begin
        strIteEmb := frmDigTintaAutomotivaDupont.objFormula.strCodEmb;
        strTipEmb := IIF(frmDigTintaAutomotivaDupont.objFormula.tpeTipEmb = teLitro, 'LT', 'GL');
        strTipPre := IIF(frmDigTintaAutomotivaDupont.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaDupont.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaDupont.objFormula.fltPrecoEmbalagem;
        fltEmbala := IIF(frmDigTintaAutomotivaDupont.objFormula.tpeTipEmb = teLitro, 0.900, 3.600);

        If (frmDigTintaAutomotivaDupont.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotivaDupont.objFormula.fltPrecoCusCon;
          fltPreCu2 := frmDigTintaAutomotivaDupont.objFormula.fltPrecoCu2Con;
          fltPreVen := frmDigTintaAutomotivaDupont.objFormula.fltPrecoVenCon;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotivaDupont.objFormula.fltPrecoCusDil;
          fltPreCu2 := frmDigTintaAutomotivaDupont.objFormula.fltPrecoCu2Dil;
          fltPreVen := frmDigTintaAutomotivaDupont.objFormula.fltPrecoVenDil;
        End;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaDupont.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaDupont.objFormula.fltPreMedCon,
          frmDigTintaAutomotivaDupont.objFormula.fltPreMedDil) +
          frmDigTintaAutomotivaDupont.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaDupont.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaDupont.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaDupont.objFormula.fltImpUltDil) +
          frmDigTintaAutomotivaDupont.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaDupont.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaDupont.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaDupont.objFormula.fltPreUltDil) +
          frmDigTintaAutomotivaDupont.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotivaDupont.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaDupont.objFormula.fltComLiqCon,
          frmDigTintaAutomotivaDupont.objFormula.fltComLiqDil) +
          frmDigTintaAutomotivaDupont.objFormula.fltPrecoCompraLiquidoEmbalagem;

        dicRetorno['promoc'] := frmDigTintaAutomotivaDupont.objFormula.StrPromoc;

        fltPreCus := fltPreCus + frmDigTintaAutomotivaDupont.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := fltPreCu2 + frmDigTintaAutomotivaDupont.objFormula.fltPrecoCusto2Embalagem;
        fltPreVen := fltPreVen + fltPreEmb;
        fltVolPro := frmDigTintaAutomotivaDupont.objFormula.fltVolumePro;
        strCatali :=  IfThen(frmDigTintaAutomotivaDupont.chkComCat.Checked, 'S', 'N');

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['saldocols'] := frmDigTintaAutomotivaDupont.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaDupont.matrizSaldosColorantes);
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
    if Assigned(frmDigTintaAutomotivaDupont) then FreeAndNil(frmDigTintaAutomotivaDupont);
  End;
End;

procedure TFormulaDupont.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotivaDupont;
  cdsCadBas: TUniClientDataSet;
  fltPreCusPro: Double;
  fltPreVenPro: Double;
  fltPreVenItem: Double;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
begin
  conf := fGetConfTinta('DUP');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);
  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotivaDupont(Self.Items[intContador]);
    cdsCadBas.Locate('BAS_CODBAS', varArrayOf([objBase.strCodBas]), []);

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreVenItem := fltPreVenPro;
    End
    Else
    Begin
      fltPreVenItem := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESESP').AsFloat;
    objBase.strImpDir := cdsCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;

    If cdsCadBas.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Begin
      If (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat > 0) Then
        objBase.fltPreVen := fltPreVenItem /
                            (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    End
    Else
    Begin
      If (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat > 0) And
         (cdsCadBas.FieldByName('BAS_PESESP').AsFloat > 0) then
        objBase.fltPreVen := fltPreVenItem /
                            (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat) /
                             cdsCadBas.FieldByName('BAS_PESESP').AsFloat;
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
    objBase.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(cdsCadBas.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                              cdsCadBas.Fieldbyname('ITE_DESF02').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                              cdsCadBas.Fieldbyname('ITE_DESF04').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                              cdsCadBas.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
  End;

  FCalculo.Add('VolumeFormula = ' + FloatToStrF(FVolumeOri, ffFixed, 12, 4));

  FCalculo.Add('Preço Base "Gramas" = (Preço / Embalagem) * Quantidade');
  FCalculo.Add('Preço Base  "MLs" = (Preço / Embalagem / Peso Específico) * Quantidade');
  FCalculo.Add('Preço da Tinta = soma do Valor da Base de todas as bases.');
end;

procedure pRetornaDadosDupont(strIteTin: String; dicRetorno: TDicionario);
var
  cdsCadDup: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('DUP').Localizar(cdsCadDup, ['ITETIN'], [strIteTin]) then
  begin
    dicRetorno['codtin'] := cdsCadDup.FieldByName('DUP_CODDUP').AsString;
    dicRetorno['montad'] := cdsCadDup.FieldByName('DUP_MONTAD').AsString;
    dicRetorno['martin'] := cdsCadDup.FieldByName('DUP_LINHA_').AsString;
    dicRetorno['a_n_o_'] := cdsCadDup.FieldByName('DUP_ANOCOR').AsString;
    dicRetorno['catal_'] := cdsCadDup.FieldByName('DUP_CATALI').AsString;
  end;
end;

procedure pRetornaTabelaPrecoDupont(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strIteTin: String;
  strTabelas: String;
  objFormula: TFormulaDupont;
  objBase: TBaseAutomotivaDupont;
  intContador: Integer;
  strQualid: String;
  calculadorFatVendas: ICalculadorFatVendas;
  strTabelaUnica: string;
  cdsCadDup: TUniClientDataSet;
  conf: IConfTinta;
  blnFormul: Boolean;
begin
  conf := fGetConfTinta('DUP');
  objFormula := nil;
  Try
    Try
      strIteTin := dicRetorno['itetin'];
      strQualid := fGetQualidade(strIteTin);
      blnFormul := False;

      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaDupont.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 0.9;

      if TMultiSelectLocalizadorFactory.GetLocalizador('DUP').Localizar(cdsCadDup, ['ITETIN'], [strIteTin]) then
      Begin
        objFormula.fltVolumeOri := cdsCadDup.FieldByName('DUP_LITRAG').AsFloat / 1000;
        blnFormul := True;

        objFormula.fltAcrMob := cdsCadDup.FieldByName('DUP_ACRMOB').AsFloat;
      End;

      objFormula.fltVolumePro := dicRetorno['volpro'];

      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strCodEmb := dicRetorno['iteemb'];

      For intContador := 1 To 15 Do
      Begin
        If blnFormul Then
        Begin
          If ((IfNull(dicRetorno['tippre'], 'C') = 'C') And (cdsCadDup.FieldByName('DUP_QTDC' + fStrZero(IntToStr(intContador), 2)).AsFloat <= 0)) Or
             ((IfNull(dicRetorno['tippre'], 'D') = 'D') And (cdsCadDup.FieldByName('DUP_QTDD' + fStrZero(IntToStr(intContador), 2)).AsFloat <= 0)) Then
            Continue;

          objBase := TBaseAutomotivaDupont(objFormula.Add);
          objBase.strCodBas := cdsCadDup.FieldByName('DUP_BASE' + fStrZero(IntToStr(intContador), 2)).AsString;
          If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
            objBase.fltQtdCon := RoundTo(cdsCadDup.FieldByName('DUP_QTDC' + fStrZero(IntToStr(intContador), 2)).AsFloat, -1)
          Else
            objBase.fltQtdDil := RoundTo(cdsCadDup.FieldByName('DUP_QTDD' + fStrZero(IntToStr(intContador), 2)).AsFloat, -1);
          objBase.strTipBas := cdsCadDup.FieldByName('DUP_TIPB' + fStrZero(IntToStr(intContador), 2)).AsString;
          objBase.strQualid := strQualid;
        End
        Else
        Begin
          If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
            Continue;

          objBase := TBaseAutomotivaDupont(objFormula.Add);
          objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
          If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
            objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro
          Else
            objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro;
          objBase.strTipBas := 'B';
          objBase.strQualid := strQualid;
        End;
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
          If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
          Else
            dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
        End;

        If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
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

        If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
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
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

        For intContador := 1 To Length(strTabelas) Do
        Begin
          if strTabelas[intContador] = 'S' then
          begin
            objFormula.strTabPre := IntToStr(intContador);
            objFormula.pCarregarColorantes;
            objFormula.pCarregaPrecosBases;
            objFormula.pCalcularPrecos;

            If IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
                dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
              Else
                dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
            End;

            If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
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

              If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
              Begin
                dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
                dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
                dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
              End
              Else
              Begin
                dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
                dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
                dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
              End;
            end;

            If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem
            Else
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
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
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;

end;

{ TfrmConsultaCompTintaVenda }

function fConsultaDupontInterna(Sender: TForm; Var qryCadDup: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String): String; stdcall;
begin
  Result := (TDupontConsulta.Create).fExecutarConsulta(Sender,
    qryCadDup, tipoConsulta, strTabPre, TfrmConsultaCompTintaDupont);
End;

procedure TfrmConsultaCompTintaDupont.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;
  strProEmbCo: String;
  strProEmbSp: String;
  strProEmbSs: String;
  strProEmbPo: String;
  strProEmbDu: String;
  strProEmbBa: String;
  strProEmbTb: String;    
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
  stlProEmbLa := nil;

  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('DUP');

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM DUP_CADDUP WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;

      stlDesEmb.Add('DUXONE');
      stlProEmbLt.Add(conf.fGet('ITE1_4'));
      stlProEmbGl.Add(conf.fGet('ITEGAL'));
      stlProEmbLa.Add(conf.fGet('ITELAT'));

      stlDesEmb.Add('NASON');
      stlProEmbLt.Add(fConfOuDefault('NASOLT', 'ITE1_4'));
      stlProEmbGl.Add(fConfOuDefault('NASOGL', 'ITEGAL'));
      stlProEmbLa.Add(fConfOuDefault('NASOLA', 'ITELAT'));

      stlDesEmb.Add('CHROMA');
      stlProEmbLt.Add(fConfOuDefault('CHROLT', 'ITE1_4'));
      stlProEmbGl.Add(fConfOuDefault('CHROGL', 'ITEGAL'));
      stlProEmbLa.Add(fConfOuDefault('CHROLA', 'ITELAT'));

      stlDesEmb.Add('IMRON');
      stlProEmbLt.Add(fConfOuDefault('IMROLT', 'ITE1_4'));
      stlProEmbGl.Add(fConfOuDefault('IMROGL', 'ITEGAL'));
      stlProEmbLa.Add(fConfOuDefault('IMROLA', 'ITELAT'));

      stlDesEmb.Add('CORMAX');
      stlProEmbLt.Add(conf.fGet('CORMLT'));
      stlProEmbGl.Add(conf.fGet('CORMGL'));
      stlProEmbLa.Add(conf.fGet('CORMLA'));

      strProEmbCo := conf.fGet('ITECOP');
      strProEmbSs := conf.fGet('ITESPS');
      strProEmbPo := conf.fGet('ITESPO');
      strProEmbDu := conf.fGet('ITESDU');
      strProEmbBa := conf.fGet('ITEBAL');
      strProEmbTb := conf.fGet('ITETAM');

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'DUP';

      fDigDadosTintometricos(cdsGen, stlDesEmb, stlProEmbLt,
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp, strProEmbSs,
        strProEmbPo, strProEmbDu, strProEmbBa, strProEmbTb,
        strIteEmb, strTipEmb, strTipPre,
        intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, strTabPre, strCatali, dicParams);
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
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

procedure TfrmConsultaCompTintaDupont.pTarefaPrecos(Sender: TObject);
begin
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompTintaDupont.pTarefaVenda(Sender: TObject);
begin
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadDupNovasFormulas', False);
end;

constructor TFormulaDupont.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited Create(strTabPrePar, TBaseAutomotivaDupont);
  conf      := fGetConfTinta('DUP');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
  fltAcrMob := 0;
end;

{ TBaseAutomotivaDupont }

procedure TBaseAutomotivaDupont.SetstrQualid(const Value: String);
begin
  FstrQualid := Value;
end;

function fGetQualidade(strIteTin: String): String;
var
  cdsGen: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('DUP').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
    Result := cdsGen.FieldByName('DUP_QUALID').AsString;
end;

end.

