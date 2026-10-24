unit untAbstractAutcomTintaImobiliaria;

interface

uses
  untAbstractAutcomTinta, untFuncoesSimples, Uni, SysUtils, Classes,
  untConstantes, Forms, untFuncEspecificas,
  untDigTintaImobiliaria, Controls, untIFormulaImobiliaria,
  untTipoTinta, untPnlBotoesAcoesNovaConsulta;

type
  TFormulaImobiliariaClass = class of TFormulaImobiliaria;

  TAbstractAutcomTintaImobiliaria = class abstract(TAbstractAutcomTinta)
  protected
    function GetNomeCampoColCodCol(): string; virtual;
    function GetNomeCampoColCodIte(): string; virtual;
    function GetNomeCampoColDesCol(): string; virtual;
    function GetNomeTabelaColorantes(): string; virtual; 
    function fDigDadosTintometricos(qryCadTinta: TUniQuery; strTabPre: String;
      Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
      Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean; virtual;
    function GetFatorEstoque(): Double; virtual;
    function fRetornaProdutoBase(qryCadTinta: TUniQuery): string; virtual; abstract;
    function fGetUnidade(qryCadTinta: TUniQuery): string; virtual; abstract;
    function fGetDescri(qryCadTinta: TUniQuery): string; virtual; abstract;
    function GetfrmDigTintaImobiliaria: TfrmDigTintaImobiliaria; virtual;
    function GetIFormulaImobiliaria(): IFormulaImobiliaria; virtual; abstract;
    function GetItemBaseOri(const strIteTin: String): string; virtual; abstract;
    function fGetSqlComponentesGTinFor(const strComponente: string): string; override;
    function fGetQtdBaixa(fltValor: Double; fltVolumePro: Double): Double; override;    
  public
    function fTipoTinta(): TTipoTinta; override; stdcall;
    procedure pRetItemEDescricaoColorante(strColTinDet: String; var strCodIte, strCodBas, strDesBas: String;
      const strCodEmp: string); override;
    procedure pRetItemColorante(strColTinDet: String; Var strCodIte, strCodBas: String; const strCodEmp: string); override; stdcall;
    function fTravaQuantidadeTinta(strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; override; stdcall;
    function fTintaBaixaEmbalagem(strTipEmb: String; Var strCodIte: String): Boolean; override; stdcall;
    function fRetornaTabelaColoranteTinta(): String; override; stdcall;
    procedure pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double); override; stdcall;
    function fRetornaPreco(Sender: TForm; qryTinta: TUniQuery;  Var dicRetorno: TDicionario;
      blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean; override; stdcall;
    function fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double; override;
    function fRetornaCampoDescricaoColorante(): String; override;
    procedure pTarefaFormulacao(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta); override;
  end;

implementation

uses
  untGenericFormulaImobiliaria, Data.DB,untICalculadorFatVendas,untTintaMaquina;

{ TAbstractAutcomTintaImobiliaria }

function TAbstractAutcomTintaImobiliaria.fDigDadosTintometricos(qryCadTinta: TUniQuery; strTabPre: String; var strNovBas, strDesBas,
  strRefere, strUniBas, strDesCor: String; var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaImobiliaria;
  intContador: Integer;
  frmDigTinta: TfrmDigTintaImobiliaria;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Result := False;
  Try
    Try
      conf := fGetConfTinta(GetIdePro());

      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TGenericFormulaImobiliaria.Create(strTabPre, GetIFormulaImobiliaria, GetIdePro());
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := GetFatorEstoque;

      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadTinta);
      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := fGetUnidade(qryCadTinta);
      objFormula.strDescri    := fGetDescri(qryCadTinta);

      For intContador := 1 To 20 Do
      Begin
        if not Assigned(qryCadTinta.FindField(fGetPrefixoNomeCampoFormulacao() + fStrZero(intContador, 2))) then
          Break;

        If fEmptyStr(qryCadTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intContador, 2)).AsString) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade('C') + fStrZero(intContador, 2)).AsFloat;
      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);

      frmDigTinta := GetfrmDigTintaImobiliaria;
      frmDigTinta.Caption := 'Tinta de Máquina - ' + tinta.fGetNomeTinta;
      frmDigTinta.objFormula := objFormula;
      frmDigTinta.strIdePro  := IfNull(dicRetorno['idepro'], IfNull(GetIdePro(), ''));
      Result := (frmDigTinta.ShowModal = mrOk);

      If (Result) Then
      Begin
        strNovBas := frmDigTinta.strNovBas;
        strDesBas := frmDigTinta.strDesBas;
        strRefere := frmDigTinta.strRefere;
        strUniBas := frmDigTinta.strUniBas;
        strDesCor := frmDigTinta.strDesCor;
        fltPreCus := frmDigTinta.fltPreCus;
        fltPreVen := frmDigTinta.fltPreVen;

        dicRetorno['precu2'] := objFormula.fltPreCu2;
        dicRetorno['premed'] := objFormula.fltPreMed + objFormula.fltPreMedBas;

        dicRetorno['preult'] := objFormula.fltPreUlt + objFormula.fltPreUltBas;
        dicRetorno['impult'] := objFormula.fltImpUlt + objFormula.fltImpUltBas;
        dicRetorno['prctin'] := objFormula.fltComLiq + objFormula.fltComLiqBas;
        dicRetorno['promoc'] := objFormula.StrPromoc;

        AcertaImpostos(fltPreCus, objFormula.fltPreCu2,
          objFormula.fltOutVal + objFormula.fltOutValBas,
          objFormula.fltIcmsai + objFormula.fltIcmsaiBas,
          objFormula.fltImpFed + objFormula.fltImpFedBas,
          objFormula.fltDesOpe + objFormula.fltDesOpeBas,
          dicRetorno);

        dicRetorno['maximoqtdbase'] := frmDigTinta.fltQtdMaximo;
        dicRetorno.AdicionarObjeto('formul', frmDigTinta.matrizSaldosColorantes);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina);        
        objFormula.pRecalculaTabelas(dicRetorno);
      End;
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

function TAbstractAutcomTintaImobiliaria.fGetQtdBaixa(fltValor, fltVolumePro: Double): Double;
begin
  Result := fltValor * GetFatorEstoque;
end;

function TAbstractAutcomTintaImobiliaria.fGetSqlComponentesGTinFor(const strComponente: string): string;
begin
    Result :=
    ' SELECT                        ' +
    '   COL_CODCOL AS CODCOMP       ' +
    '   , COL_CODITE AS CODITE      ' +
    ' FROM                          ' +
    '   ' + GetIFormulaImobiliaria.GetNomeTabelaColorante + '                  ' +
    ' WHERE COL_CODCOL IN (' + strComponente + ')';
end;


function TAbstractAutcomTintaImobiliaria.fRetornaCampoDescricaoColorante(): String;
begin
  Result := GetNomeCampoColDesCol();
end;

function TAbstractAutcomTintaImobiliaria.fRetornaPreco(Sender: TForm; qryTinta: TUniQuery; var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
  strOpcDoc: string;
  blnUsaPreCus: Boolean;
  strTabPre: string;
  strAuto: string;
  strCodEmp: string;
  strCodIte: string;
  strIteTin: string;
  fltPreCus: Double;
  fltUnitar: Double;
  strDesCor: string;
  strDesBas: string;
  strRefBas: string;
  strUniBas: string;
begin
  conf := fGetConfTinta(GetIdePro());

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaTintaVenda(Sender, strCodEmp, qryTinta, blnFaturamento, dicRetorno, sltItems);
    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  If (Not fDigDadosTintometricos(qryTinta, strTabPre, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryTinta.FieldByName('AUTOINCREM').AsString, strCodIte));
  strIteTin := GetIteTin(qryTinta);
  fltPreCus := fltPreCus;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar;

  dicRetorno['unidad'] := strUniBas;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltUnitar;
//  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  Result := True;
end;

function TAbstractAutcomTintaImobiliaria.fRetornaTabelaColoranteTinta: String;
begin
  Result := GetNomeTabelaColorantes;
end;

function TAbstractAutcomTintaImobiliaria.fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double;
begin
  Result := 0;
end;

function TAbstractAutcomTintaImobiliaria.fTintaBaixaEmbalagem(strTipEmb: String; Var strCodIte: String): Boolean;
begin
  Result := False;
end;

function TAbstractAutcomTintaImobiliaria.fTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TAbstractAutcomTintaImobiliaria.fTravaQuantidadeTinta(strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean;
begin
  Result := True;
end;

function TAbstractAutcomTintaImobiliaria.GetFatorEstoque: Double;
begin
  Result := fGetFatorML;
end;

function TAbstractAutcomTintaImobiliaria.GetfrmDigTintaImobiliaria: TfrmDigTintaImobiliaria;
begin
  Result := TfrmDigTintaImobiliaria.Create(nil);
end;

function TAbstractAutcomTintaImobiliaria.GetNomeCampoColCodCol: string;
begin
  Result := 'COL_CODCOL';
end;

function TAbstractAutcomTintaImobiliaria.GetNomeCampoColCodIte: string;
begin
  Result := 'COL_CODITE';
end;

function TAbstractAutcomTintaImobiliaria.GetNomeCampoColDesCol: string;
begin
  Result := GetIFormulaImobiliaria.GetNomeCampoColDesCol; // '';
end;

function TAbstractAutcomTintaImobiliaria.GetNomeTabelaColorantes: string;
begin
  Result := GetIFormulaImobiliaria.GetNomeTabelaColorante;
end;

procedure TAbstractAutcomTintaImobiliaria.pRetItemColorante(strColTinDet: String; var strCodIte, strCodBas: String;
  const strCodEmp: string);
var
  strDesBas: String;
begin
  pRetItemEDescricaoColorante(strColTinDet, strCodIte, strCodBas, strDesBas, strCodEmp);
end;

procedure TAbstractAutcomTintaImobiliaria.pRetItemEDescricaoColorante(strColTinDet: String; var strCodIte, strCodBas, strDesBas: String;
  const strCodEmp: string);
var
  qryGen: TUniQuery;
  stlCampos: TStringList;
begin
  qryGen := nil;
  stlCampos := nil;
  strCodIte := '';
  strCodBas := '';
  strDesBas := '';
  Try
    Try
      stlCampos := TStringList.Create;
      stlCampos.Duplicates := dupIgnore;
      stlCampos.Sorted := True;

      if not fEmptyStr(GetNomeCampoColCodCol) then
        stlCampos.Add(GetNomeCampoColCodCol);
        
      if not fEmptyStr(GetNomeCampoColCodIte) then
        stlCampos.Add(GetNomeCampoColCodIte);
        
      if not fEmptyStr(GetNomeCampoColDesCol) then
        stlCampos.Add(GetNomeCampoColDesCol);

      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                       ' +
        stlCampos.CommaText +
        ' FROM                         ' +
        GetNomeTabelaColorantes +
        ' WHERE ' + GetNomeCampoColCodCol + ' = :CODCOL   ';
      qryGen.ParamByName('CODCOL').AsString := strColTinDet;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      if not fEmptyStr(GetNomeCampoColCodCol) then
        strCodBas := qryGen.FieldByName(GetNomeCampoColCodCol).AsString;

      if not fEmptyStr(GetNomeCampoColCodIte) then
        strCodIte := qryGen.FieldByName(GetNomeCampoColCodIte).AsString;

      if not fEmptyStr(GetNomeCampoColDesCol) then
        strDesBas := qryGen.FieldByName(GetNomeCampoColDesCol).AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(stlCampos) then FreeAndNil(stlCampos);
  End;
end;

procedure TAbstractAutcomTintaImobiliaria.pTarefaFormulacao(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta);
var
  qryGen: TUniQuery;
  strDesBas: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  strNovBas: String;
  strRefere: String;
  fltPreVen: Double;
begin
  qryGen := nil;
  Try
    Try
      If (Not frmConsulta.qryConsulta.Active) Or (frmConsulta.qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery();
      qryGen.SQL.Add('SELECT * FROM ' + tinta.fGetNomeTabela + ' WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := frmConsulta.qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      fDigDadosTintometricos(qryGen, frmConsulta.strTabPre,
                             strNovBas, strDesBas, strRefere, strUniBas, strDesCor,
                             fltPreCus, fltPreVen, TDicionario.Create);
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

procedure TAbstractAutcomTintaImobiliaria.pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  objFormula: TFormulaImobiliaria;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TGenericFormulaImobiliaria.Create('1', GetIFormulaImobiliaria, GetIdePro());
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := GetFatorEstoque;

      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := GetItemBaseOri(dicRetorno['itetin']);
      objFormula.strIteBas    := dicRetorno['itebas'];
      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, fGetFatorML);
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

end.
