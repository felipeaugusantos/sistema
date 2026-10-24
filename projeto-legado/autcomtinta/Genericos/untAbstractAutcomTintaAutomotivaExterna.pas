unit untAbstractAutcomTintaAutomotivaExterna;

interface

uses
  untAbstractAutcomTintaAutomotiva, Uni, Classes, untFuncoesSimples,
  SysUtils,
  Controls, untIReformuladorAutomotiva, Data.DB;

type
  TAbstractAutcomTintaAutomotivaExterna = class abstract (TAbstractAutcomTintaAutomotiva)
  protected
    function GetReformulador(): IReformuladorAutomotiva; virtual; abstract;
    function GetChaveReformulacao(const qryTinta: TUniQuery): string; virtual; abstract;
    function fDigDadosTintometricos(qryTinta: TUniQuery; stlDesEmb, stlProEmbLt, stlProEmbGl,
      stlProEmbLa: TStringList; strProEmbCo, strProEmbSp, strProEmbBa, strProEmbTb: String; var strIteEmb, strTipEmb, strTipPre: String;
      var intQtdEmb: Integer; var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; var strCatali: String;
      dicRetorno: TDicionario): Boolean; override;
  public
    function fGTinForGeral(strIteTin, strTipPre, strLinTin, strCatalize: String; intLazQua: Integer; fltQtdEmb, fltQtdIte: Double;
      strDescri: String; qryArqFor: TUniQuery; fltVolPro: Double; var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
      var stlItensTraMl: TStringList; strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double; strTipCor,
      strTextBase: String; intAcao: Integer; strIteCob: String; strCodEmpPrd: string): Boolean; override;
  public
    function IsFormulaEspecifica(const qryTinta: TUniQuery): Boolean;
  end;

implementation
uses untICalculadorFatVendas,untFuncEspecificas, untDigTintaAutomotiva;
{ TAbstractAutcomTintaAutomotivaExterna }

function TAbstractAutcomTintaAutomotivaExterna.fDigDadosTintometricos(qryTinta: TUniQuery; stlDesEmb, stlProEmbLt, stlProEmbGl,
  stlProEmbLa: TStringList; strProEmbCo, strProEmbSp, strProEmbBa, strProEmbTb: String; var strIteEmb, strTipEmb, strTipPre: String;
  var intQtdEmb: Integer; var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; var strCatali: String;
  dicRetorno: TDicionario): Boolean;
var
  objBase : TBaseAutomotiva;
  objFormula: TFormulaAutomotiva;
  intCont: Integer;
  frmDigTinta: TfrmDigTintaAutomotiva;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  Result := False;
  objFormula := nil;
  frmDigTinta := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := GetFormulaAutomotiva(strTabPre, GetIFormulaAutomotiva, GetIdePro());
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := GetDescri(qryTinta);
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltVolumeOri := GetIFormulaAutomotiva.GetVolumeOri;

      if IsFormulaEspecifica(qryTinta) then
      begin
        for intCont := 1 to 20 do
        begin
          if not Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacao() + fStrZero(intCont, 2))) then
            Break;

          If fEmptyStr(qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString) Then
            Break;

          objBase := TBaseAutomotiva(objFormula.Add);
          objBase.strCodBas := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString;

          if Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacaoQuantidade('C') + fStrZero(intCont, 2))) then
            objBase.fltQtdCon := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade('C') + fStrZero(intCont, 2)).AsFloat;

          if Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacaoQuantidade('D') + fStrZero(intCont, 2))) then
            objBase.fltQtdDil := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade('D') + fStrZero(intCont, 2)).AsFloat;

          if Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacaoQuantidade('D2') + fStrZero(intCont, 2))) then
            objBase.fltQtdDi2 := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade('D2') + fStrZero(intCont, 2)).AsFloat;

          objBase.strTipBas := GetTipBas(objBase.strCodBas);
        end;
      end  
      else
        GetReformulador.Reformular(objFormula, GetChaveReformulacao(qryTinta));
        
      objFormula.pCarregaPrecosBases;

      frmDigTinta := GetfrmDigTinta;
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTinta.objFormula := objFormula;
      frmDigTinta.stlDesEmb := stlDesEmb;
      frmDigTinta.stlProEmbLt := stlProEmbLt;
      frmDigTinta.stlProEmbGl := stlProEmbGl;
      frmDigTinta.stlProEmbLa := stlProEmbLa;
      frmDigTinta.strProEmbCo := strProEmbCo;
      frmDigTinta.strProEmbSp := strProEmbSp;
      frmDigTinta.strProEmbTb := strProEmbTb;
      frmDigTinta.strProEmbBa := strProEmbBa;
      frmDigTinta.strIdePro := GetIdePro;
      frmDigTinta.chkComCat.Visible := GetBlnCatalizador;


      if stlProEmbLa.Count > 0 then
        frmDigTinta.strProEmbLa := stlProEmbLa[0];      

      Result := frmDigTinta.ShowModal = mrOk;

      if Result then
      begin
        strIteEmb := frmDigTinta.objFormula.strCodEmb;
        strTipEmb := GetTipEmb(frmDigTinta.objFormula.tpeTipEmb);
        strTipPre := IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTinta.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTinta.objFormula.fltPrecoEmbalagem;
        fltEmbala := GetQtdEmb(frmDigTinta.objFormula.tpeTipEmb);
        fltVolPro := frmDigTinta.objFormula.fltVolumePro;

        If frmDigTinta.rdgModoVenda.ItemIndex = 0 Then
        Begin
          fltPreCus := frmDigTinta.objFormula.fltPrecoCusCon + frmDigTinta.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTinta.objFormula.fltPrecoCu2Con + frmDigTinta.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTinta.objFormula.fltPrecoVenCon + frmDigTinta.objFormula.fltPrecoEmbalagem;
          dicRetorno['premed'] := frmDigTinta.objFormula.fltPreMedCon + frmDigTinta.objFormula.fltPrecoMedioEmbalagem;
        End
        Else
        Begin
          fltPreCus := frmDigTinta.objFormula.fltPrecoCusDil + frmDigTinta.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTinta.objFormula.fltPrecoCu2Dil + frmDigTinta.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTinta.objFormula.fltPrecoVenDil + frmDigTinta.objFormula.fltPrecoEmbalagem;
          dicRetorno['premed'] := frmDigTinta.objFormula.fltPreMedDil + frmDigTinta.objFormula.fltPrecoMedioEmbalagem;
        End;
        dicRetorno['promoc'] := objFormula.StrPromoc;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['precus'] := fltPreCus;
        dicRetorno.AdicionarObjeto('formul', frmDigTinta.matrizSaldosColorantes);
        objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTinta) then FreeAndNil(frmDigTinta);
  End;
end;

function TAbstractAutcomTintaAutomotivaExterna.fGTinForGeral(strIteTin, strTipPre, strLinTin, strCatalize: String; intLazQua: Integer;
  fltQtdEmb, fltQtdIte: Double; strDescri: String; qryArqFor: TUniQuery; fltVolPro: Double; var arrFormul: TForMulTinDetArray;
  var arrBaixaPigmentos: TBaixaPigmentosArray; var stlItensTraMl: TStringList; strCodDil: string; fltPorDil: Double; strDilCon: String;
  fltPorCat: Double; strTipCor, strTextBase: String; intAcao: Integer; strIteCob, strCodEmpPrd: string): Boolean;
var
  qryTinta: TUniQuery;
  dicComponentes: TDicionario;
  intCont: Integer;
  stlComponentes: TStringList;
  intContForm: Integer;
  strFiltro: string;
  objFormula: TFormulaAutomotiva;
begin
  Result := False;
  qryTinta := nil;
  dicComponentes := nil;
  stlComponentes := nil;
  Try
    Try
      qryTinta := fCriaQuery();
      qryTinta.SQL.Text := fGetSqlGTinFor;
      qryTinta.ParamByName('ITETIN').AsString := strIteTin;
      qryTinta.Open;

      if qryTinta.IsEmpty then
        Exit;

      dicComponentes := TDicionario.Create;
      stlComponentes := TStringList.Create;
      stlComponentes.Sorted := True;
      stlComponentes.Duplicates := dupIgnore;

      intContForm := 1;

      if IsFormulaEspecifica(qryTinta) then
      begin
        for intCont := 1 to 20 do
        begin
          if not Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2))) then
            Break;

          if fEmptyStr(qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString) then
            Break;

          if fStrToFloat(qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre) + fStrZero(intCont, 2)).AsString) <= 0 then
            Continue;

          arrFormul[intContForm].strFormul := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString;
          arrFormul[intContForm].fltQtdbas := fGetQtdBaixa(qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre) + fStrZero(intCont, 2)).AsFloat,
            fltVolPro);

          dicComponentes[arrFormul[intContForm].strFormul] := arrFormul[intContForm].fltQtdbas;
          stlComponentes.Add(QuotedStr(arrFormul[intContForm].strFormul));
          Inc(intContForm);
        end;
      end
      else
      begin
        objFormula := GetFormulaAutomotiva('1', GetIFormulaAutomotiva, GetIdePro());
        objFormula.strDescri := GetDescri(qryTinta);
        objFormula.fltVolumePro := fltVolPro;
        objFormula.fltVolumeOri := GetIFormulaAutomotiva.GetVolumeOri;
        GetReformulador.Reformular(objFormula, GetChaveReformulacao(qryTinta));

        for intCont := 0 to objFormula.Count - 1 do
        begin
          arrFormul[intContForm].strFormul := TBaseAutomotiva(objFormula.Items[intCont]).strCodBas;
          if strTipPre = 'C' then
            arrFormul[intContForm].fltQtdbas := fGetQtdBaixa(TBaseAutomotiva(objFormula.Items[intCont]).fltQtdCon, fltVolPro)
          else if strTipPre = 'D' then
            arrFormul[intContForm].fltQtdbas := fGetQtdBaixa(TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil, fltVolPro)
          else if strTipPre = 'D2' then
            arrFormul[intContForm].fltQtdbas := fGetQtdBaixa(TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDi2, fltVolPro);

          dicComponentes[arrFormul[intContForm].strFormul] := arrFormul[intContForm].fltQtdbas;
          stlComponentes.Add(QuotedStr(arrFormul[intContForm].strFormul));
          Inc(intContForm);
        end;
      end;

      strFiltro := fGetFiltroGTinFor(qryTinta);
      qryTinta.Close;
      qryTinta.SQL.Text := fGetSqlComponentesGTinFor(StringReplace(stlComponentes.CommaText, '"', '', [rfReplaceAll]));
      qryTinta.Filtered := False;
      qryTinta.Open;

      if not fEmptyStr(strFiltro) then
      begin
        qryTinta.Filter := strFiltro;
        qryTinta.Filtered := not fEmptyStr(qryTinta.Filter);
      end;

      SetLength(arrBaixaPigmentos, qryTinta.RecordCount);

      while not qryTinta.Eof do
      begin
        stlItensTraMl.Add(qryTinta.FieldByName('CODITE').AsString);
        arrBaixaPigmentos[qryTinta.RecNo - 1].strCodIte := qryTinta.FieldByName('CODITE').AsString;
        arrBaixaPigmentos[qryTinta.RecNo - 1].fltQtdBaixa := dicComponentes[qryTinta.FieldByName('CODCOMP').AsString];
        qryTinta.Next;
      end;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryTinta) then FreeAndNil(qryTinta);
    if Assigned(dicComponentes) then FreeAndNil(dicComponentes);
    if Assigned(stlComponentes) then FreeAndNil(stlComponentes);
  End;
end;

function TAbstractAutcomTintaAutomotivaExterna.IsFormulaEspecifica(const qryTinta: TUniQuery): Boolean;
var
  qryGen: TUniQuery;
begin
  Result := False;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                               ' +
        '   COUNT(0) AS QTD                    ' +
        ' FROM                                 ' +
        '   PPG_CADPPG P                       ' +
        '   INNER JOIN PPG_CADNFM N            ' +
        '     ON P.PPG_CODCOR = N.NFM_CODNFM   ' +
        ' WHERE P.AUTOINCREM = :AUTOINCREM     ';
      qryGen.ParamByName('AUTOINCREM').AsString := qryTinta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;
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

end.
