unit untStarmixDinamica;

interface

uses SysUtils, Uni, Forms, Classes, StrUtils,
  untFuncEspecificas, Controls, Dialogs, untFuncoesSimples, untPnlBotoesAcoesNovaConsulta,
  Math;


{***************************************************}
{* CRIA A CLASSE QUE REPRESENTA UMA FORMULA DA     *}
{* STARMIX                                         *}
{** 13/08/2008 - 10:18 **************************MV*}
Type

  TfrmConsultaCompStarmix = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaStarmix = class(TFormulaAutomotiva)
    private
      fltPerAcr: Double;
      fltAcrMob: Double;
    protected
      FPesCor: Double;
      FPesFor: Double;
      function fCalculaQuantidadeParaBaixaEstoque(objBase: TBaseAutomotiva): Double; override;
    public

      property fltPesCor: Double Read FPesCor Write FPesCor; // Peso Específico da Fórmula
      property fltPesFor: Double Read FPesFor Write FPEsFor; // Peso Total da Fórmula (g)

      procedure pCarregarColorantes; override;
      procedure pCalcularPrecos; override;
      procedure pCarregaPrecosBases; override;
      Constructor Create(strTabPre: String); override;

End;

  function fConsultaStarmixDinamica(Sender: TForm): String; stdcall;
  function fConsultaStarmixDinamicaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaStarmixDinamicaVenda(Sender: TForm; strCodEmp: String;
    Var qryCadSta: TUniQuery; blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fRetornaUniTraProStarmixDinamica(qryTinta: TUniQuery; strIteTin: String;
    fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaPrecoStarmixDinamica(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fRetornaDescricaoStarmixDinamica(qryCadSta: TUniQuery; strDesCor: string): String;

  function fRetornaUniTraEmbStarmixDinamica(strTipEmb: String): Double;

  function fDigDadosTintometricos(qryCadSta: TUniQuery; stlDesEmb, stlProEmbLt,
    stlProEmbGl, stlProEmbLa: TStringList; strProEmbCo, strProEmbSp: String; Var strIteEmb,
    strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb,
    fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fGTinForStarmixDinamica(strIteTin: String; fltQtdIte, fltVolPro: Double;
    Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
    Var stlItensTraMl: TStringList): Boolean;

  procedure pRetornaDadosStarmixDinamica(strIteTin: String; dicRetorno: TDicionario);

  procedure pRetornaTabelaPrecoStarmix(dicRetorno: TDicionario; fltFatorAcerto: Double);

  function fGetMd5MySql(strTexto: String): String;

  function fFormataMySqlFloat(fltValor: Double; intCasas: Integer): String;

  function fConsultaStarmixDinamicaInterna(Sender: TForm;  qryCadSta: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  function fRetornaAcrescimoMaoObra(strIteTin: String): Double;

implementation

uses
  DB, untDigTintaAutomotiva, untICalculadorFatVendas,untFuncoes,
untIConfTinta,
untIConsultaTinta,
untTintaMaquina,
untStarmixConsulta,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteComparerBaseAutomotiva, untTypesSistema, untConsultas;

function fRetornaDescricaoStarmixDinamica(qryCadSta: TUniQuery; strDesCor:string): String;
begin
  Result := strDesCor;            
End;

function fConsultaStarmixDinamica(Sender: TForm): String;
var
  qrySta: TUniQuery;
begin
  try
    qrySta := fCriaQuery(Sender);
    Result := fConsultaStarmixDinamicaInterna(Sender, qrySta, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
  finally
    FreeAndNil(qrySta);
  end;
end;

function fConsultaStarmixDinamicaGeral(Sender: TForm; strCodEmp: String): String;
Var
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery(Sender);
    Result := fConsultaStarmixDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fConsultaStarmixDinamicaVenda(Sender: TForm; strCodEmp: String;
  Var qryCadSta: TUniQuery; blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := fConsultaStarmixDinamicaInterna(Sender, qryCadSta, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcVenda, blnFaturamento, dicRetorno, sltItems);
end;

function fRetornaPrecoStarmixDinamica(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
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

    strIteEmb: String;

    strMontad: String;
    strA_n_o_,
    strLinha : String;

    strIteSta: String;
    strIteTin: String;

    strTipPre: String;
    
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
//    fltPrcTin: Double;
    fltPrvTin: Double;

    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbLa: TStringList;
    strProEmbCo: String;
    strProEmbSp: String;

    fltVolPro: Double;
    strTabPre: String;

    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor: String;
    conf: IConfTinta;
begin

  Result := False;

  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTipEmb    := dicRetorno['tipemb'];
  intQtdEmb    := dicRetorno['qtdemb'];
  strTabPre    := dicRetorno['tabpre'];

{  If (fConsultaStarmixDinamicaVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End; }

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaStarmixDinamicaVenda(Sender, strCodEmp, qryTinta, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TStarmixConsulta.Create;
  conf  := fGetConfTinta('STA');

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  strIteTin := fGetMd5MySql(qryTinta.FieldByName('STA_NOMCOR').AsString +
                qryTinta.FieldByName('STA_ANOCOR').AsString +
                qryTinta.FieldByName('STA_CODLIN').AsString +
                qryTinta.FieldByName('STA_CODMON').AsString +
                qryTinta.FieldByName('STA_UNIVER').AsString +
                qryTinta.FieldByName('STA_UNIDAD').AsString +
                qryTinta.FieldByName('STA_MONTAD').AsString +
                fFormataMySqlFloat(qryTinta.FieldByName('STA_PESCOR').AsFloat, 4) +
                fFormataMySqlFloat(qryTinta.FieldByName('STA_PESFOR').AsFloat, 4) +
                qryTinta.FieldByName('STA_DESLIN').AsString);
                
  strMontad := qryTinta.FieldByName('STA_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('STA_ANOCOR').AsString;
  strLinha  := qryTinta.FieldByName('STA_CODLIN').AsString;
  strIteSta := conf.fGet('PROSTA');

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;
  stlProEmbLa := TStringList.Create;

  stlDesEmb.Add('NORMAL');
{
  stlProEmbLt.Add(fArqIniTinta(0, 'STARMIX', 'STAIEM', ''));
  stlProEmbGl.Add(fArqIniTinta(0, 'STARMIX', 'STAIGL', ''));
}
  stlProEmbLt.Add(conf.fGet('STAIEM'));
  stlProEmbGl.Add(conf.fGet('STAIGL'));
  stlProEmbLa.Add(conf.fGet('STAILA'));

  {
  strProEmbCo := fArqIniTinta(0, 'STARMIX', 'STAICO', '');
  strProEmbSp := fArqIniTinta(0, 'STARMIX', 'STAISP', '');
  }
  strProEmbCo := conf.fGet('STAICO');
  strProEmbSp := conf.fGet('STAISP');

  If (Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt,
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
        strIteEmb, strTipEmb, strTipPre,
        intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, strTabPre,
        dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));
  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

//  fltPrcTin := fltPreCus;
  fltPrvTin := fltUnitar;

  fltPreCus := fltPreCus;
//  fltPrcTin := fltPrcTin;

  If Not blnUsaPreCus Then
  Begin
    fltUnitar := fltUnitar;
    fltPrvTin := fltPrvTin;
  End
  Else
  Begin
    fltUnitar := fltPreCus;
    fltPrvTin := fltPreCus;//fltPrcTin;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
//  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := strIteSta;
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['iteemb'] := strIteEmb;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['linha_'] := strLinha;
  dicRetorno['volpro'] := fltVolPro;
  dicRetorno['chafor'] := fRetornaDescricaoStarmixDinamica(qryTinta, strDesCor) + strTipEmb;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  Result := True;

End;

function fRetornaUniTraProStarmixDinamica(qryTinta: TUniQuery; strIteTin: String;
  fltPrcTin, fltPrvTin: Double): Double;
  Var
    strTraStarmix: String;
    fltFatStarmix: Double;
begin
{
  qryTinta.SQL.Clear;
  qryTinta.SQL.Add(' SELECT * ');
  qryTinta.SQL.Add(' FROM STA_CADSTA ');
  qryTinta.SQL.Add(' WHERE UPPER(CAST(MD5(CONCAT( ');
  qryTinta.SQL.Add(' 	IFNULL(STA_NOMCOR, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_ANOCOR, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_CODLIN, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_CODMON, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_UNIVER, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_UNIDAD, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_MONTAD, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_PESCOR, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_PESFOR, ""),  ');
  qryTinta.SQL.Add(' 	IFNULL(STA_DESLIN, ""))) AS CHAR)) = :ITETIN; ');
  qryTinta.ParamByName('ITETIN').AsString := strIteTin;
  qryTinta.Open;

  If qryTinta.IsEmpty Then
  Begin
    qryTinta.Close;
    qryTinta.SQL.Clear;
    qryTinta.SQL.Add('SELECT * FROM STA_CADSTA WHERE STA_CODSEQ = :ITETIN');
    qryTinta.ParamByName('ITETIN').AsString := strIteTin;
    qryTinta.Open;
  End;
}
  strTraStarmix := fArqIniTinta(0, 'STARMIX', 'TRASTA', '');
  fltFatStarmix := fStrToFloat(fArqIniTinta(0, 'STARMIX', 'FATSTA', '0'));

  If strTraStarmix = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatStarmix;

  Result := fFormataFloat(Result, 2);
end;

function fRetornaUniTraEmbStarmixDinamica(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
begin
  If (strTipEmb = 'LT') Then
    fltPreEmb := fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPLT', ''))
  Else
    fltPreEmb := fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPGL', ''));

  Result := fltPreEmb * fStrToFloat(fArqIniTinta(0, 'STARMIX', 'FATSTA', ''))
end;

{ TFormulaStarmix }

constructor TFormulaStarmix.Create(strTabPre: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('STA');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  fltAcrMob := 0;
end;

function TFormulaStarmix.fCalculaQuantidadeParaBaixaEstoque(
  objBase: TBaseAutomotiva): Double;
begin
  Result := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) *
            (fltPesCor / fltPesFor) *
            Self.fltVolumePro;
end;

procedure TFormulaStarmix.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltQtdAux   : Double;

  fltTraImp: Double;
  fltStaPer: Double;
  fltPreCusPro,
  fltPreVenPro: Double;

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

    FComLiqCon := 0;
    FPreUltCon := 0;
    FImpUltCon := 0;

    FComLiqDil := 0;
    FPreUltDil := 0;
    FImpUltDil := 0;
  End;
begin
  inherited;

  pZerarPrecos;
  fltTraImp := fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAIMP', '0'));
  fltStaPer := fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPER', '0'));

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Not qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (qryCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + qryCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;
    
    if not IsItemAtivo(qryCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
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

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreCusBas := fltPreCusPro;
      fltPreVenBas := fltPreVenPro;

      FPromoc := 'S';

      If fltPreCusBas = 0 Then
        fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenBas := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenBas,
                                        fltPreCusBas,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltQtdAux    := FVolumePro * (fltPesCor / fltPesFor) * objBase.fltQtdCon;
    fltPreCusBas := (fltPreCusBas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreCu2Bas := (fltPreCu2Bas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreVenBas := (fltPreVenBas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    componente[mvConcentrado].Quantidade                := fltQtdAux;
    componente[mvDiluido].Quantidade                    := 0.0;

    componente[mvConcentrado].OutrosValores             := (objBase.fltOutVal / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].PrecoMedio                := (objBase.fltPreMed / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].UltimoPrecoCompra         := (objBase.fltPreUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].UltimoPrecoCompraImpostos := (objBase.fltImpUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].PrecoCompraLiquido        := (objBase.fltComLiq / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].IcmsSaida                 := fltPreVenBas * objBase.fltIcmSai /100;
    componente[mvConcentrado].ImpostosFederais          := fltPreVenBas * objBase.fltImpFed /100;
    componente[mvConcentrado].DespesasOperacionais      := fltPreVenBas * objBase.fltDesOpe /100;
    componente[mvConcentrado].PrecoCusto                := fltPreCusBas;
    componente[mvConcentrado].PrecoCustoReal            := fltPreCu2Bas;
    componente[mvConcentrado].PrecoVenda                := fltPreVenBas;

{
    fltQtdAux    := FVolumePro * (fltPesCor / fltPesFor) * objBase.fltQtdCon;
    fltPreCusBas := (fltPreCusBas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreCu2Bas := (fltPreCu2Bas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreVenBas := (fltPreVenBas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    FOutValCon := FOutValCon + (objBase.fltOutVal / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    FIcmsaiCon := FIcmsaiCon + fltPreVenBas * objBase.fltIcmSai /100;
    FImpFedCon := FImpFedCon + fltPreVenBas * objBase.fltImpFed /100;
    FDesOpeCon := FDesOpeCon + fltPreVenBas * objBase.fltDesOpe /100;
    FPreMedCon := FPreMedCon + (objBase.fltPreMed / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    FComLiqCon := FComLiqCon + (objBase.fltComLiq / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    FPreUltCon := FPreUltCon + (objBase.fltPreUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    FImpUltCon := FImpUltCon + (objBase.fltImpUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    FPrecoCusCon := FPrecoCusCon + fltPreCusBas;
    FPrecoCu2Con := FPrecoCu2Con + fltPreCu2Bas;
    FPrecoVenCon := FPrecoVenCon + fltPreVenBas;
}
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;

  FPrecoVenCon := FPrecoVenCon + (FPrecoVenCon / 100) * fltTraImp;
  FPrecoVenCon := FPrecoVenCon + (FPrecoVenCon / 100) * fltStaPer;
  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMob;

{
  FPrecoVenCon := FPrecoVenCon + (FPrecoVenCon / 100) * fltTraImp;
  FPrecoVenCon := FPrecoVenCon + (FPrecoVenCon / 100) * fltStaPer;
  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
}

end;

procedure TFormulaStarmix.pCarregaPrecosBases;
  Var
    intContador: Integer;
    objBase: TBaseAutomotiva;

    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro: Double;
begin
  conf := fGetConfTinta('STA');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := qryCadBas.FieldByName('BAS_VOLUME').AsFloat;
    objBase.fltPesEsp := qryCadBas.FieldByName('BAS_PESESP').AsFloat;

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      objBase.fltPreVen  := fltPreVenPro;
    End
    else
    begin
      objBase.fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    end;

    objBase.strImpDir := qryCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := qryCadBas.FieldByName('BAS_CODITE').AsString;                

    objBase.fltOutVal := qryCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := qryCadBas.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := qryCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := qryCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := qryCadBas.FieldByName('ITE_PREMED').AsFloat;
    objBase.fltImpUlt := qryCadBas.FieldByName('ITE_IMPULT').AsFloat;
    objBase.fltPreUlt := qryCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltComLiq := fCalculaPrecoCompraLiq(qryCadBas.Fieldbyname('ITE_PRECOM').AsFloat, qryCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF02').AsFloat, qryCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF04').AsFloat, qryCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Add('PesoEspecíficoFormula = ' + FloatToStrF(fltPesCor, ffFixed, 12, 3));
  FCalculo.Add('PesoTotalFormula(g) = ' + FloatToStrF(fltPesFor, ffFixed, 12, 3));
  FCalculo.Add('QtdAux = VolumeDigitado * ((PesoEspecíficoFormula / PesoTotalFórmula) * Quantidade)');
  FCalculo.Add('Valor da Base = (Preço / Embalagem) * (QtdAux / Peso Específico)');
  FCalculo.Add('');
  FCalculo.Add('Preço da Tinta = soma do Valor da Base de todas as bases');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + Impostos');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + %Perda');
end;

procedure TFormulaStarmix.pCarregarColorantes;
begin
  inherited;

  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_VOLUME                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');

  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');

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
    qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_PREMED                  ');
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
  qryCadBas.SQL.Add('   STA_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;

end;

function fDigDadosTintometricos(qryCadSta: TUniQuery; stlDesEmb, stlProEmbLt,
  stlProEmbGl, stlProEmbLa: TStringList; strProEmbCo, strProEmbSp: String; Var strIteEmb,
  strTipEmb, strTipPre: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
  fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TFormulaStarmix;
  objFormulaEsp: TFormulaStarmix;
  intContador: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := false;
  conf := fGetConfTinta('STA');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TFormulaStarmix.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 0.900;
      objFormula.strDescri    := qryCadSta.FieldByName('STA_NOMCOR').AsString + ' - ' +
                                 qryCadSta.FieldByName('STA_MONTAD').AsString + ' - ' +
                                 qryCadSta.FieldByName('STA_UNIVER').AsString;

      objFormula.fltPesCor    := qryCadSta.FieldByName('STA_PESCOR').AsFloat * 1000;
      objFormula.fltPesFor    := qryCadSta.FieldByName('STA_PESFOR').AsFloat;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltAcrMob := qryCadSta.FieldByName('STA_ACRMOB').AsFloat;

      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(qryCadSta.FieldByName('STA_CODB' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadSta.FieldByName('STA_CODB' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := qryCadSta.FieldByName('STA_QTDB' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltQtdDil := 0.0;
        objBase.strTipBas := 'B'

      End;

      {*****************************************}
      {* ESTA VARIÁVEL SERÁ UTILIZADA PARA MOS-*}
      {* TRAR A QUANTIDADE QUE SERÁ EFETIVA-   *}
      {* MENTE BAIXADA NO ESTOQUE.             *}
      {**************************************MV*}
      objFormulaEsp := TFormulaStarmix.Create(strTabPre);
      objFormulaEsp.fltVolumeOri := 0.900;
      objFormulaEsp.strDescri    := qryCadSta.FieldByName('STA_NOMCOR').AsString + ' - ' +
                                    qryCadSta.FieldByName('STA_MONTAD').AsString + ' - ' +
                                    qryCadSta.FieldByName('STA_UNIVER').AsString;

      objFormulaEsp.fltPesCor    := qryCadSta.FieldByName('STA_PESCOR').AsFloat * 1000;
      objFormulaEsp.fltPesFor    := qryCadSta.FieldByName('STA_PESFOR').AsFloat;
      objFormulaEsp.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(qryCadSta.FieldByName('STA_CODB' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objBase := TBaseAutomotiva(objFormulaEsp.Add);
        objBase.strCodBas := qryCadSta.FieldByName('STA_CODB' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := qryCadSta.FieldByName('STA_QTDB' + fStrZero(intContador, 2)).AsFloat *
                             (objFormulaEsp.fltPesCor / objFormulaEsp.fltPesFor) * 0.9;

        objBase.fltQtdCon := fFormataFloat(objBase.fltQtdCon, 1);

        objBase.fltQtdDil := 0.0;
        objBase.strTipBas := 'B'

      End;

      objFormula.pCarregaPrecosBases;
      objFormulaEsp.pCarregaPrecosBases;

      frmDigTintaAutomotiva := TfrmDigTintaAutomotiva.Create(Nil);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotiva.objFormula  := objFormula;
      frmDigTintaAutomotiva.objFormulaQtdEsp := objFormulaEsp;
      frmDigTintaAutomotiva.stlDesEmb   := stlDesEmb;
      frmDigTintaAutomotiva.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotiva.stlProEmbLa := stlProEmbLa;
      frmDigTintaAutomotiva.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotiva.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotiva.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotiva.chkComCat.Visible := FAlse;
      frmDigTintaAutomotiva.strIdePro   := dicRetorno['idepro'];
      frmDigTintaAutomotiva.Caption     := frmDigTintaAutomotiva.Caption + 'Starmix';
      Result := (frmDigTintaAutomotiva.ShowModal = mrOk);

      If (Result) Then
      Begin

        Case frmDigTintaAutomotiva.objFormula.tpeTipEmb of
          teLitro  : begin
                       strTipEmb := 'LT';
                       fltEmbala := 0.900;
                     end;
          teCopo   : begin
                       strTipEmb := 'CP';
                       fltEmbala := 0.500;
                     end;
          teSpray  : begin
                       strTipEmb := 'SP';
                       fltEmbala := 0.400;
                     end;
          teGalao  : begin
                       strTipEmb := 'GL';
                       fltEmbala := 3.600;
                     end;
        end;

        strIteEmb := frmDigTintaAutomotiva.objFormula.strCodEmb;
        strTipPre := IIF(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotiva.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;

        If (frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusCon;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Con;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenCon;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusDil;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Dil;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenDil;
        End;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltPreMedCon,
          frmDigTintaAutomotiva.objFormula.fltPreMedDil) +
          frmDigTintaAutomotiva.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltImpUltCon,
          frmDigTintaAutomotiva.objFormula.fltImpUltDil) +
          frmDigTintaAutomotiva.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltPreUltCon,
          frmDigTintaAutomotiva.objFormula.fltPreUltDil) +
          frmDigTintaAutomotiva.objFormula.fltPreUltEmbalagem;

        dicRetorno['obscolorista']   := frmDigTintaAutomotiva.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotiva.rdgTipoFormula.ItemIndex;


        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltComLiqCon,
          frmDigTintaAutomotiva.objFormula.fltComLiqDil) +
          frmDigTintaAutomotiva.objFormula.fltPrecoCompraLiquidoEmbalagem;

        fltPreCus := fltPreCus + frmDigTintaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := fltPreCu2 + frmDigTintaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
        fltPreVen := fltPreVen + fltPreEmb;

        fltVolPro := frmDigTintaAutomotiva.objFormula.fltVolumePro;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        dicRetorno['promoc'] := frmDigTintaAutomotiva.objFormula.StrPromoc;

        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['saldocols'] := frmDigTintaAutomotiva.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotiva.matrizSaldosColorantes);
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
    if Assigned(frmDigTintaAutomotiva) then FreeAndNil(frmDigTintaAutomotiva);
  End;
End;

function fGTinForStarmixDinamica(strIteTin: String; fltQtdIte, fltVolPro: Double;
  Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
  Var stlItensTraMl: TStringList): Boolean;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strBases: String;
    dicBases: TDicionario;
    qryConsulta01: TUniQuery;

    fltPesFor: Double;
    fltPesCor: Double;
begin
  qryConsulta01 := fCriaQuery(Nil);

  dicBases := TDicionario.Create;
  strBases := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM STA_CADSTA ';
  strSQL := strSQL + ' WHERE UPPER(CAST(MD5(CONCAT( ';
  strSQL := strSQL + ' 	IFNULL(STA_NOMCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_ANOCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_CODLIN, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_CODMON, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_UNIVER, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_UNIDAD, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_MONTAD, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_PESCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_PESFOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_DESLIN, ""))) AS CHAR)) = :ITETIN; ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

     If (IsEmpty) Then
     Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  STA_CADSTA ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  STA_CODSEQ = :ITETIN ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      Open;
    End;

    If (IsEmpty) Then
    Begin
      Close;
      Result := False;
      Exit;
    End;

    fltPesCor := FieldByName('STA_PESCOR').AsFloat * 1000;
    fltPesFor := FieldByName('STA_PESFOR').AsFloat;

    For intContador := 1 To 15 Do
    Begin

      strCamFor := 'STA_CODB' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'STA_QTDB' + fStrZero(IntToStr(intContador), 2);

      If (FieldByName(strCamBas).AsFloat <= 0) Then
        Break;

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := fltVolPro * ((fltPesCor / fltPesFor) * FieldByName(strCamBas).AsFloat);

      dicBases[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

      {*******************************************}
      {* GUARDA BASES PARA POSTERIOR BUSCA       *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strBases := strBases + QuotedStr(arrFormul[intContador].strFormul);
      If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
        strBases := strBases + ', ';

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
  strSQL := strSQL + '  STA_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS IN (' + strBases + ') ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    intPos := 0;
    SetLength(arrBaixaPigmentos, RecordCount);

    While (Not Eof) Do
    Begin

      {*******************************************}
      {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
      {* DE SALDO EM ML                          *}
      {****************************************MV*}
      stlItensTraMl.Add(FieldByName('BAS_CODITE').AsString);

      arrBaixaPigmentos[intPos].strCodIte   := FieldByName('BAS_CODITE').AsString;
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[FieldByName('BAS_CODBAS').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicBases);
  FreeAndNil(qryConsulta01);
end;

procedure pRetornaDadosStarmixDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadSta: TUniQuery;
    strSQL: String;
begin
  qryCadSta := fCriaQuery(Nil);

  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM STA_CADSTA ';
  strSQL := strSQL + ' WHERE UPPER(CAST(MD5(CONCAT( ';
  strSQL := strSQL + ' 	IFNULL(STA_NOMCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_ANOCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_CODLIN, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_CODMON, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_UNIVER, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_UNIDAD, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_MONTAD, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_PESCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_PESFOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_DESLIN, ""))) AS CHAR)) = :ITETIN; ';

  With qryCadSta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If IsEmpty Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  STA_CADSTA ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  STA_CODSEQ = :ITETIN ';
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      Open;
    End;

    dicRetorno['codtin'] := FieldByName('STA_UNIVER').AsString;
    dicRetorno['montad'] := FieldByName('STA_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('STA_CODLIN').AsString;
    Close;
  End;

  FreeAndNil(qryCadSta);
end;

procedure pRetornaTabelaPrecoStarmix(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TFormulaStarmix;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  strCodBas: String;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
  strTabelaUnica: String;
begin
  conf := fGetConfTinta('STA');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
      objFormula := TFormulaStarmix.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 1;
      objFormula.fltVolumePro := 1;//dicRetorno['volpro'];
      objFormula.fltPesCor    := 1;
      objFormula.fltPesFor    := 1;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltAcrMob := fRetornaAcrescimoMaoObra(dicRetorno['itetin']);

      objFormula.mveModoVenda := mvConcentrado;
      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strCodEmb := dicRetorno['iteemb'];
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      For intContador := 1 To 15 Do
      Begin

        strCodBas := IfNull(dicRetorno['base' + fStrZero(intContador, 2)], '');

        If (fEmptyStr(strCodBas)) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := strCodBas;
        objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3);
        objBase.fltQtdDil := 0.0;
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
      End
      Else
      Begin
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
              dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem;

            dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
            dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;

            If intContador = IfNull(dicRetorno['tabpre'], 0) Then
            Begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
              dicRetorno['promoc'] := objFormula.StrPromoc;
            End;

            dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
            dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
            dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
            dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
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

function fGetMd5MySql(strTexto: String): String;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT UPPER(CAST(MD5("' + strTexto + '") AS CHAR))    ITETIN';
  qryGen.Open;
  Result := qryGen.FieldByName('ITETIN').AsString;
  FreeAndNil(qryGen);
end;

function fFormataMySqlFloat(fltValor: Double; intCasas: Integer): String;
begin
  Result := AnsiReplaceStr(FormatFloat('0.' + DupeString('0', intCasas), fltValor), ',', '.');
end;

function fConsultaStarmixDinamicaInterna(Sender: TForm;  qryCadSta: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TStarmixConsulta.Create).fExecutarConsulta(Sender,
    qryCadSta, tipoConsulta, strTabPre, TfrmConsultaCompStarmix, '', blnFaturamento, dicRetorno, sltItems);
end;

function fRetornaAcrescimoMaoObra(strIteTin: String): Double;
var
  qryGen: TUniQuery;
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT STA_ACRMOB ';
  strSQL := strSQL + '   FROM STA_CADSTA ';
  strSQL := strSQL + '  WHERE UPPER(CAST(MD5(CONCAT( ';
  strSQL := strSQL + ' 	IFNULL(STA_NOMCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_ANOCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_CODLIN, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_CODMON, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_UNIVER, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_UNIDAD, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_MONTAD, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_PESCOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_PESFOR, ""),  ';
  strSQL := strSQL + ' 	IFNULL(STA_DESLIN, ""))) AS CHAR)) = :ITETIN; ';

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      Open;

       If (IsEmpty) Then
       Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  STA_ACRMOB ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  STA_CADSTA ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  STA_CODSEQ = :ITETIN ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('ITETIN').AsString := strIteTin;
        Open;
      End;

      Result := FieldByName('STA_ACRMOB').AsFloat;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

{ TfrmConsultaCompStarmix }

procedure TfrmConsultaCompStarmix.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  {*******************************************}
  {* PARAMETROS                              *}
  {****************************************MV*}
  strTipPre: String;
  strTipEmb: String;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  strIteEmb: String;
  stlDesEmb  : TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;

  strProEmbCo: String;
  strProEmbSp: String;
  fltVolPro  : Double;
  conf       : IConfTinta;
  dicParams  : TDicionario;
begin
  dicParams := nil;
  qryGen := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbLa := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('STA');

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;

      //strIteTin := '';
      fltPreCus := 0.0;
      fltUnitar := 0.0;

      strTipPre := '';
      strTipEmb := '';
      intQtdEmb := 0;
      fltPreEmb := 0.0;
      fltEmbala := 0.0;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM STA_CADSTA WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      stlDesEmb.Add('NORMAL');
      stlProEmbLt.Add(conf.fGet('STAIEM'));
      stlProEmbGl.Add(conf.fGet('STAIGL'));
      stlProEmbLa.Add(conf.fGet('STAILA'));

      strProEmbCo := conf.fGet('STAICO');
      strProEmbSp := conf.fGet('STAISP');

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'STA';

      If (Not fDigDadosTintometricos(qryGen, stlDesEmb, stlProEmbLt,
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
        strIteEmb, strTipEmb, strTipPre, intQtdEmb,
        fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, strTabPre, dicParams)) Then
      Begin
        Exit;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicParams)   then FreeAndNil(dicParams);
    if Assigned(qryGen)      then FreeAndNil(qryGen);
    if Assigned(stlDesEmb)   then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

procedure TfrmConsultaCompStarmix.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompStarmix.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadStaNovasFormulas', False);
end;

end.
