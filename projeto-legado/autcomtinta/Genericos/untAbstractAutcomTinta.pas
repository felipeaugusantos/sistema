unit untAbstractAutcomTinta;

interface

uses
{$IFDEF LINUX}
 {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untGTinForTipos,
{$ELSE}
  untFuncoesSimples, UniClientDataSet, Forms,
  untPnlBotoesAcoesNovaConsulta,
{$ENDIF}
  untIAutcomTinta, untConstantes, Uni,
  Classes, SysUtils, untTintadeMaquina,
  untIConsultaTinta, untIConfTinta,
  untTipoTinta, untTypesSistema;

type
  TAbstractAutcomTinta = class abstract (TInterfacedObject, IAutcomTinta)
  protected
    tinta : IConsultaTinta;
    conf: IConfTinta;
  protected
    function GetIdePro(): string; virtual; abstract;
    function GetTintadeMaquinaClasse: TTintadeMaquinaClasse; virtual; abstract;
    function GetTintadeMaquinaConsultaClasse: TTintadeMaquinaClasse; virtual;
    {$IFNDEF LINUX}
    function GetfrmConsultaCompTintaNovaClass: TfrmPnlBotoesAcoesNovaConsultaClass; virtual;
    function fConsultaInterna(Sender: TForm; qryGen: TUniQuery; strTabPre: String; tipoConsulta: TTipoConsultaTinta;
      blnFaturamento, blnPermiteTab: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
    {$ENDIF}
    function GetIteTin(qryTinta: TUniQuery): string; virtual; abstract;
    function fGetPrefixoNomeCampoFormulacao(): string; virtual; abstract;
    function fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string; virtual; abstract;
    function fGetSqlGTinFor: string; virtual; abstract;
    function fGetQtdBaixa(fltValor: Double; fltVolumePro: Double): Double; virtual;
    function fGetSqlComponentesGTinFor(const strComponente: string): string; virtual; abstract;
    function fGetFiltroGTinFor(const qryTinta: TUniQuery): string; virtual;
    procedure pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario); virtual; abstract;
    function GetNomeClasseNovasFormulas: string; virtual;
    function fGetNomeCampoAcrescimoMaoObra: String; virtual; abstract;
  public
    constructor Create(); virtual;
    destructor Destroy; override;
  public
    function fTipoTinta(): TTipoTinta; virtual; stdcall; abstract;
    function fTintaBaixaEmbalagem(strTipEmb: String; Var strCodIte: String): Boolean; virtual; stdcall; abstract;
    function fTravaQuantidadeTinta(strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; virtual; stdcall; abstract;
    function fTintaGeraFormulacao(): Boolean; virtual; stdcall;
    function fRetornaTabelaColoranteTinta(): String; virtual; stdcall; abstract;
    procedure pRetItemColorante(strColTinDet: String; Var strCodIte, strCodBas: String; const strCodEmp: string); virtual; stdcall; abstract;
    procedure pRetItemEDescricaoColorante(strColTinDet: String; var strCodIte, strCodBas, strDesBas: String;
      const strCodEmp: string); virtual; abstract;
    function fFormulacaoAcumulada(): Boolean; virtual; stdcall;
    procedure pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double); virtual; stdcall; abstract;
    Function fGetFatorML(): Double; virtual; stdcall;
    {$IFNDEF LINUX}
    function fConsultaTintaGeral(Sender: TForm; strCodEmp: String): String; virtual; stdcall;
    function fConsultaTintaVenda(Sender: TForm; strCodEmp: String; qryTinta: TUniQuery;
      blnFaturamento, blnPermiteTab: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; virtual; stdcall;
    {$ENDIF}
    function fRetornaPreco(Sender: TForm; qryTinta: TUniQuery;  Var dicRetorno: TDicionario;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil; strMD5Key: String = ''; blnSemTela: Boolean = False): Boolean; virtual; stdcall; abstract;
    function fRetornaUniTraProTinta(qryTinta: TUniQuery; fltEmbala, fltQuanti: Double; strTipPre, strIteTin, strCodBas, strTabPre,
      strCatalize: String; fltPrcTin, fltPrvTin: Double): Double; virtual;
    function fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double; virtual; stdcall; abstract;
    function fGTinForGeral(strIteTin, strTipPre, strLinTin, strCatalize: String; intLazQua: Integer; fltQtdEmb, fltQtdIte: Double;
      strDescri: String; qryArqFor: TUniQuery; fltVolPro: Double; var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
      var stlItensTraMl: TStringList; strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double; strTipCor,
      strTextBase: String; intAcao: Integer; strIteCob: String; strCodEmpPrd: string): Boolean; virtual;
    procedure pRetornaDadosTinta(strIteTin: String; dicRetorno: TDicionario); virtual; stdcall;
    function fRetornaDescricaoTinta(strDesCri: String; qryTinta: TUniQuery; strTipPre: String): String; stdcall;
    function fRetornaReferenciaTinta(qryTinta: TUniClientDataSet): String; virtual; stdcall; 
    function fRetornaNomeTinta(): String; virtual; stdcall;
    function fRetornaCampoDescricaoColorante(): String; virtual;
   {$IFNDEF LINUX}
    procedure pTarefaFormulacao(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta); virtual; abstract;
    procedure pTarefaPrecos(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta); virtual;
    procedure pTarefaVenda(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta); virtual;
   {$ENDIF}
  end;

  TAbstractAutcomTintaClass = class of TAbstractAutcomTinta;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompGenerico,
{$ENDIF}
  untTintaMaquina, Data.DB;

{ TAbstractAutcomTinta }

constructor TAbstractAutcomTinta.Create;
begin
  inherited;
  tinta := GetTintadeMaquinaClasse.Create;
  conf := fGetConfTinta(GetIdePro);
end;

destructor TAbstractAutcomTinta.Destroy;
begin
  inherited;
end;

{$IFNDEF LINUX}
function TAbstractAutcomTinta.fConsultaInterna(Sender: TForm; qryGen: TUniQuery; strTabPre: String; tipoConsulta: TTipoConsultaTinta;
  blnFaturamento, blnPermiteTab: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := (GetTintadeMaquinaConsultaClasse.Create).fExecutarConsulta(Sender,
    qryGen, tipoConsulta, strTabPre, GetfrmConsultaCompTintaNovaClass,
    '', blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAbstractAutcomTinta.fConsultaTintaGeral(Sender: TForm; strCodEmp: String): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, False, Nil, Nil);
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
{$ENDIF}

{$IFNDEF LINUX}
function TAbstractAutcomTinta.fConsultaTintaVenda(Sender: TForm; strCodEmp: String; qryTinta: TUniQuery;
  blnFaturamento, blnPermiteTab: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcVenda, blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
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
{$ENDIF}

function TAbstractAutcomTinta.fFormulacaoAcumulada: Boolean;
begin
  Result := fGetConfTinta(GetIdePro).fGet('ACUBAS') = 'S';
end;


function TAbstractAutcomTinta.fGetFatorML: Double;
begin
  Result := 1;
end;


function TAbstractAutcomTinta.fGetFiltroGTinFor(const qryTinta: TUniQuery): string;
begin
  Result := '';
end;

function TAbstractAutcomTinta.fGetQtdBaixa(fltValor, fltVolumePro: Double): Double;
begin
  Result := fltValor;
end;

function TAbstractAutcomTinta.fGTinForGeral(strIteTin, strTipPre, strLinTin, strCatalize: String; intLazQua: Integer; fltQtdEmb,
  fltQtdIte: Double; strDescri: String; qryArqFor: TUniQuery; fltVolPro: Double; var arrFormul: TForMulTinDetArray;
  var arrBaixaPigmentos: TBaixaPigmentosArray; var stlItensTraMl: TStringList; strCodDil: string; fltPorDil: Double; strDilCon: String;
  fltPorCat: Double; strTipCor, strTextBase: String; intAcao: Integer; strIteCob: String; strCodEmpPrd: string): Boolean;
var
  qryTinta: TUniQuery;
  dicComponentes: TDicionario;
  intCont: Integer;
  stlComponentes: TStringList;
  intContForm: Integer;
  strFiltro: string;
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
      for intCont := 1 to 20 do
      begin
        if not Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2))) then
          Break;

        if fEmptyStr(qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString) then
          Break;

        if fStrToFloat(qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre) + fStrZero(intCont, 2)).AsString) <= 0 then
          Continue;

        arrFormul[intContForm].strFormul := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString;
        arrFormul[intContForm].fltQtdbas := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre) + fStrZero(intCont, 2)).AsFloat;
        arrFormul[intContForm].fltQtdbas := fGetQtdBaixa(arrFormul[intContForm].fltQtdbas, fltVolPro);

        dicComponentes[arrFormul[intContForm].strFormul] := arrFormul[intContForm].fltQtdbas;
        stlComponentes.Add(QuotedStr(arrFormul[intContForm].strFormul));
        Inc(intContForm);
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

function TAbstractAutcomTinta.fRetornaCampoDescricaoColorante(): String;
begin
  Result := '';
end;

function TAbstractAutcomTinta.fRetornaDescricaoTinta(strDesCri: String; qryTinta: TUniQuery; strTipPre: String): String;
begin
  Result := strDesCri;
end;

function TAbstractAutcomTinta.fRetornaNomeTinta: String;
begin
  Result := tinta.fGetNomeTinta;
end;

function TAbstractAutcomTinta.fRetornaReferenciaTinta(qryTinta: TUniClientDataSet): String;
begin
  Result := '';
end;

function TAbstractAutcomTinta.fRetornaUniTraProTinta(qryTinta: TUniQuery; fltEmbala, fltQuanti: Double; strTipPre, strIteTin, strCodBas,
  strTabPre, strCatalize: String; fltPrcTin, fltPrvTin: Double): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta(GetIdePro);

  strSiglaTrava := conf.fGet('TRASUV');
  fltFatTrava   := conf.fGetDouble('FATSUV');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function TAbstractAutcomTinta.fTintaGeraFormulacao: Boolean;
begin
  Result := fGetConfTinta(GetIdePro).fGet('USAFOR') = 'S';
end;


{$IFNDEF LINUX}
function TAbstractAutcomTinta.GetfrmConsultaCompTintaNovaClass: TfrmPnlBotoesAcoesNovaConsultaClass;
begin
  Result := TfrmConsultaCompGenerico;
end;
{$ENDIF}

function TAbstractAutcomTinta.GetNomeClasseNovasFormulas: string;
begin
  Result := '';
end;

function TAbstractAutcomTinta.GetTintadeMaquinaConsultaClasse: TTintadeMaquinaClasse;
begin
  Result := GetTintadeMaquinaClasse;
end;

procedure TAbstractAutcomTinta.pRetornaDadosTinta(strIteTin: String; dicRetorno: TDicionario);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := fGetSqlGTinFor;
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;
      pPreencheDicionarioDadosTinta(qryGen, dicRetorno);
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

{$IFNDEF LINUX}
procedure TAbstractAutcomTinta.pTarefaPrecos(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta);
begin
  pTarefaFormulacao(Sender, frmConsulta);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TAbstractAutcomTinta.pTarefaVenda(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta);
var
  strNomeClasse: string;
begin
  strNomeClasse := GetNomeClasseNovasFormulas;
  if not fEmptyStr(strNomeClasse) then
    fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' ' + strNomeClasse, False);
end;
{$ENDIF}

end.
